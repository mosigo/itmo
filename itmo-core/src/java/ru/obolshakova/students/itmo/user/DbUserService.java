package ru.obolshakova.students.itmo.user;

import net.sf.xfresh.db.util.DbUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallbackWithoutResult;
import org.springframework.transaction.support.TransactionTemplate;
import ru.obolshakova.students.itmo.task.*;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 14.02.11 0:16
 */
public class DbUserService implements UserService {
    private static final Logger log = Logger.getLogger(DbUserService.class);

    private SimpleJdbcTemplate jdbcTemplate;

    private TransactionTemplate transactionTemplate;

    @Required
    public void setJdbcTemplate(final SimpleJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Required
    public void setTransactionTemplate(final TransactionTemplate transactionTemplate) {
        this.transactionTemplate = transactionTemplate;
    }

    public List<UserInfo> getAllStudents(final long termId) {
        final List<UserInfo> result = new ArrayList<UserInfo>(20);
        jdbcTemplate.getJdbcOperations().query(
                "select u.user_id, u.name from user_info u join user_term t on u.user_id = t.user_id where t.term_id = ? and u.role_id = 1", //role=1 -- студент
                new PreparedStatementSetter() {
                    public void setValues(final PreparedStatement ps) throws SQLException {
                        ps.setLong(1, termId);
                    }
                },
                new RowCallbackHandler() {
                    public void processRow(final ResultSet rs) throws SQLException {
                        result.add(new UserInfo(rs.getLong("user_id"), rs.getString("name")));
                    }
                }
        );
        return result;
    }

    public UserInfo getUserInfo(final long userId) {
        final List<UserInfo> result = new ArrayList<UserInfo>(20);
        jdbcTemplate.getJdbcOperations().query(
                "select user_id, name from user_info where user_id = ?",
                new PreparedStatementSetter() {
                    public void setValues(final PreparedStatement ps) throws SQLException {
                        ps.setLong(1, userId);
                    }
                },
                new RowCallbackHandler() {
                    public void processRow(final ResultSet rs) throws SQLException {
                        result.add(new UserInfo(rs.getLong("user_id"), rs.getString("name")));
                    }
                }
        );
        if (result.isEmpty()) {
            return null;
        }
        return result.get(0);
    }

    public List<UserRole> getUserRoles(final long termId, final long userId) {
        throw new RuntimeException("not implemented");
    }

    public List<UserPoints> getStudentsPoints(final long termId) {
        final List<UserPoints> result = new ArrayList<UserPoints>(20);
        jdbcTemplate.getJdbcOperations().query(
                "select u.user_id, ifnull(uk.point_cnt,0) as karma, ifnull(up.point_cnt,0) as point\n" +
                        "from user_info u\n" +
                        "     join user_term t on u.user_id = t.user_id\n" +
                        "     left join (\n" +
                        "         select uk.user_id, sum(point_cnt) as point_cnt\n" +
                        "         from user_karma uk\n" +
                        "              join karma k on uk.karma_id = k.id\n" +
                        "         group by user_id\n" +
                        "     ) uk on u.user_id = uk.user_id\n" +
                        "     left join (\n" +
                        "         select user_id, sum(point_cnt) as point_cnt\n" +
                        "         from user_point\n" +
                        "         group by user_id\n" +
                        "     ) up on u.user_id = up.user_id\n" +
                        "where t.term_id = ?",
                new PreparedStatementSetter() {
                    public void setValues(final PreparedStatement ps) throws SQLException {
                        ps.setLong(1, termId);
                    }
                },
                new RowCallbackHandler() {
                    public void processRow(final ResultSet rs) throws SQLException {
                        result.add(new UserPoints(rs.getLong("user_id"), rs.getInt("point"), rs.getInt("karma")));
                    }
                }
        );
        return result;
    }

    public List<UserTaskPoints> getStudentsTaskPoints(final long termId) {
        final List<UserTaskPoints> result = new ArrayList<UserTaskPoints>(200);
        jdbcTemplate.getJdbcOperations().query(
                "select uts.user_id, uts.task_id, ifnull(t1.point_cnt, 0) as point_cnt, ifnull(t1.karma_cnt, 0) as karma_cnt, uts.status as task_status\n" +
                        "from (\n" +
                        "    select user_id, task_id, sum(point_cnt) as point_cnt, sum(karma_cnt) as karma_cnt\n" +
                        "    from (\n" +
                        "        select uk.user_id, uk.task_id, 0 as point_cnt, k.point_cnt as karma_cnt from user_karma uk inner join karma k on uk.karma_id = k.id where uk.task_id is not null\n" +
                        "        union all\n" +
                        "        select up.user_id, up.task_id, point_cnt, 0 as karma_cnt from user_point up\n" +
                        "    ) as t group by user_id, task_id\n" +
                        ") as t1 join task t on t1.task_id = t.id join term_module tm on t.module_id = tm.id and tm.term_id = ?\n" +
                        "right outer join user_task_status uts on t1.task_id = uts.task_id and t1.user_id = uts.user_id",
                new PreparedStatementSetter() {
                    public void setValues(final PreparedStatement ps) throws SQLException {
                        ps.setLong(1, termId);
                    }
                },
                new RowCallbackHandler() {
                    public void processRow(final ResultSet rs) throws SQLException {
                        result.add(
                                new UserTaskPoints(
                                        rs.getLong("user_id"),
                                        rs.getInt("task_id"),
                                        rs.getInt("point_cnt"),
                                        rs.getInt("karma_cnt"),
                                        TaskStatus.byCode(rs.getInt("task_status"))
                                )
                        );
                    }
                }
        );
        return result;
    }

    public UserTaskPoints getStudentTaskPoints(final long userId, final long taskId) {
        final List<UserTaskPoints> result = new ArrayList<UserTaskPoints>(200);
        jdbcTemplate.getJdbcOperations().query(
                "select uts.user_id, uts.task_id, ifnull(t1.point_cnt, 0) as point_cnt, ifnull(t1.karma_cnt, 0) as karma_cnt, uts.status as task_status\n" +
                        "from (\n" +
                        "    select user_id, task_id, sum(point_cnt) as point_cnt, sum(karma_cnt) as karma_cnt\n" +
                        "    from (\n" +
                        "        select uk.user_id, uk.task_id, 0 as point_cnt, k.point_cnt as karma_cnt from user_karma uk inner join karma k on uk.karma_id = k.id where uk.task_id is not null\n" +
                        "        union all\n" +
                        "        select up.user_id, up.task_id, point_cnt, 0 as karma_cnt from user_point up\n" +
                        "    ) as t group by user_id, task_id\n" +
                        ") as t1 join task t on t1.task_id = t.id \n" +
                        "right outer join user_task_status uts on t1.task_id = uts.task_id and t1.user_id = uts.user_id \n" +
                        "where uts.user_id = ? and uts.task_id = ?",
                new PreparedStatementSetter() {
                    public void setValues(final PreparedStatement ps) throws SQLException {
                        ps.setLong(1, userId);
                        ps.setLong(2, taskId);
                    }
                },
                new RowCallbackHandler() {
                    public void processRow(final ResultSet rs) throws SQLException {
                        result.add(
                                new UserTaskPoints(
                                        rs.getLong("user_id"),
                                        rs.getInt("task_id"),
                                        rs.getInt("point_cnt"),
                                        rs.getInt("karma_cnt"),
                                        TaskStatus.byCode(rs.getInt("task_status"))
                                )
                        );
                    }
                }
        );
        if (result.isEmpty()) {
            return null;
        }
        return result.get(0);
    }

    public List<UserAttendance> getStudentsAttendance(final long termId) {
        final List<UserAttendance> result = new ArrayList<UserAttendance>(500);
        jdbcTemplate.getJdbcOperations().query(
                "select a.user_id, a.lesson_id, a.status\n" +
                        "from lesson l join user_attendance a on l.id = a.lesson_id\n" +
                        "     join term_module tm on l.module_id = tm.id and tm.term_id = ?\n" +
                        "where l.type = 2",
                new PreparedStatementSetter() {
                    public void setValues(final PreparedStatement ps) throws SQLException {
                        ps.setLong(1, termId);
                    }
                },
                new RowCallbackHandler() {
                    public void processRow(final ResultSet rs) throws SQLException {
                        result.add(new UserAttendance(rs.getLong("user_id"), rs.getInt("lesson_id"), AttendanceType.byCode(rs.getInt("status"))));

                    }
                }
        );
        return result;
    }

    public UserDetailedTaskPoints getDetailedStudentTaskPoints(final long userId, final long taskId) {
        return new UserDetailedTaskPoints(taskId, getTaskPoints(userId, taskId), getTaskKarma(userId, taskId));
    }

    private List<TaskPoint> getTaskPoints(final long userId, final long taskId) {
        final List<TaskPoint> result = new ArrayList<TaskPoint>(5);
        jdbcTemplate.getJdbcOperations().query(
                "select up.point_cnt, up.de_item_id, i.descr " +
                "from user_point up join de_item i on up.de_item_id = i.id " +
                "where user_id = ? and task_id = ?",
                new PreparedStatementSetter() {
                    public void setValues(final PreparedStatement ps) throws SQLException {
                        ps.setLong(1, userId);
                        ps.setLong(2, taskId);
                    }
                },
                new RowCallbackHandler() {
                    public void processRow(final ResultSet rs) throws SQLException {
                        final TaskPoint point = new TaskPoint(rs.getString("descr"), rs.getInt("point_cnt"), rs.getInt("de_item_id"));
                        result.add(point);
                    }
                }
        );
        return result;
    }

    private List<TaskKarma> getTaskKarma(final long userId, final long taskId) {
        final List<TaskKarma> result = new ArrayList<TaskKarma>(5);
        jdbcTemplate.getJdbcOperations().query(
                "select karma_id from user_karma where user_id = ? and task_id = ?",
                new PreparedStatementSetter() {
                    public void setValues(final PreparedStatement ps) throws SQLException {
                        ps.setLong(1, userId);
                        ps.setLong(2, taskId);
                    }
                },
                new RowCallbackHandler() {
                    public void processRow(final ResultSet rs) throws SQLException {
                        final TaskKarma point = new TaskKarma(rs.getInt("karma_id"));
                        result.add(point);
                    }
                }
        );
        return result;
    }


    public void saveUserTaskPoints(
            final long userId, final long taskId, final List<TaskPoint> points,
            final List<TaskKarma> karma, final TaskStatus status) {

        transactionTemplate.execute(new TransactionCallbackWithoutResult() {
            @Override
            protected void doInTransactionWithoutResult(final TransactionStatus transactionStatus) {
                log.info("Start saving task points for user " + userId + " and task id " + taskId);
                savePoints(userId, taskId, points);
                saveKarma(karma, userId, taskId);
                saveTaskStatus(taskId, userId, status);
                log.info("Task points saved for user " + userId + " and task id " + taskId);
            }
        });
    }

    private void savePoints(final long userId, final long taskId, final List<TaskPoint> points) {
        jdbcTemplate.update("delete from user_point where user_id = ? and task_id = ?", userId, taskId);
        jdbcTemplate.getJdbcOperations().batchUpdate(
                "insert into user_point (user_id, task_id, point_cnt, de_item_id, creation_time) values (?,?,?,?,current_timestamp)",
                new BatchPreparedStatementSetter() {
                    public void setValues(final PreparedStatement ps, final int i) throws SQLException {
                        final TaskPoint taskPoint = points.get(i);
                        ps.setLong(1, userId);
                        ps.setLong(2, taskId);
                        ps.setInt(3, taskPoint.getPointCnt());
                        ps.setInt(4, taskPoint.getDeItemId());

                    }

                    public int getBatchSize() {
                        return points.size();
                    }
                }
        );
    }

    private void saveKarma(final List<TaskKarma> karma, final long userId, final long taskId) {
        final Set<Integer> newKarmaIds = new HashSet<Integer>(karma.size());
        for (final TaskKarma k : karma) {
            newKarmaIds.add(k.getKarmaId());
        }

        final Set<Integer> oldKarmaIds = new HashSet<Integer>(karma.size());
        jdbcTemplate.getJdbcOperations().query(
                "select karma_id from user_karma where user_id = ? and task_id = ?",
                new PreparedStatementSetter() {
                    public void setValues(final PreparedStatement ps) throws SQLException {
                        ps.setLong(1, userId);
                        ps.setLong(2, taskId);
                    }
                },
                new RowCallbackHandler() {
                    public void processRow(final ResultSet rs) throws SQLException {
                        oldKarmaIds.add(rs.getInt(1));
                    }
                }
        );

        final Set<Integer> forDelete = new HashSet<Integer>(oldKarmaIds);
        forDelete.removeAll(newKarmaIds);

        final Set<Integer> forCreate = new HashSet<Integer>(newKarmaIds);
        forCreate.removeAll(oldKarmaIds);

        if (!forDelete.isEmpty()) {
            jdbcTemplate.update("delete from user_karma where user_id = ? and task_id = ? and karma_id not in " + DbUtil.getInSection(forDelete), userId, taskId);
        }
        for (final Integer karmaId : forCreate) {
            jdbcTemplate.update(
                    "insert into user_karma (user_id, karma_id, task_id, creation_time) " +
                            "values (?,?,?,current_timestamp)", userId, karmaId, taskId);
        }
    }

    private void saveTaskStatus(final long taskId, final long userId, final TaskStatus status) {
        final TaskStatus oldStatus =
                TaskStatus.byCode(
                        jdbcTemplate.queryForInt(
                                "select status from user_task_status where user_id = ? and task_id = ?",
                                userId, taskId
                        )
                );

        if (status == oldStatus) {
            log.info("No new status for task " + taskId + " and user id " + userId);
            return;
        }

        jdbcTemplate.update("delete from user_task_status where task_id = ? and user_id = ?", taskId, userId);

        jdbcTemplate.update(
                "insert into user_task_status (user_id, task_id, status, creation_time) values (?,?,?,current_timestamp)",
                userId, taskId, status.getCode()
        );

        jdbcTemplate.update(
                "insert into user_task_status_history (user_id, task_id, status, creation_time) values (?,?,?,current_timestamp)",
                userId, taskId, status.getCode()
        );
    }
}
