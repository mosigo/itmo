package ru.obolshakova.students.itmo.point;

import org.springframework.beans.factory.annotation.Required;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;
import ru.obolshakova.students.itmo.task.TaskStatus;
import ru.obolshakova.students.itmo.user.DePoint;
import ru.obolshakova.students.itmo.user.UserDePoints;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 07.01.11 22:40
 */
public class DbPointsService implements PointsService {

    private SimpleJdbcTemplate jdbcTemplate;

    @Required
    public void setJdbcTemplate(final SimpleJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<KarmaItem> loadKarmaItems() {
        final List<KarmaItem> result = new ArrayList<KarmaItem>(50);
        jdbcTemplate.getJdbcOperations().query(
                "SELECT id, point_cnt, descr FROM karma ORDER BY npp",
                new PreparedStatementSetter() {
                    public void setValues(final PreparedStatement ps) throws SQLException {
                        ps.setFetchSize(100);
                    }
                },
                new RowCallbackHandler() {
                    public void processRow(final ResultSet rs) throws SQLException {
                        final int id = rs.getInt("id");
                        final int pointCnt = rs.getInt("point_cnt");
                        final String description = rs.getString("descr");
                        result.add(new KarmaItem(id, pointCnt, description));
                    }
                }
        );
        return result;
    }

    @Override
    public List<DeItem> getDeItems(final long termId) {
        final List<DeItem> result = new ArrayList<DeItem>(10);
        jdbcTemplate.getJdbcOperations().query(
                "select i.id, i.module_id, i.descr, i.point_cnt, ifnull(t.point_cnt, 0) as used_point_cnt\n" +
                "from de_item i\n" +
                "    join term_module m on i.module_id = m.id and m.term_id = ?\n" +
                "    left join (\n" +
                "        select de_item_id, sum(point_cnt) as point_cnt from task_point group by de_item_id\n" +
                "    ) t on i.id = t.de_item_id\n" +
                "order by i.id",
                new PreparedStatementSetter() {
                    @Override
                    public void setValues(final PreparedStatement ps) throws SQLException {
                        ps.setLong(1, termId);
                    }
                },
                new RowCallbackHandler() {
                    @Override
                    public void processRow(final ResultSet rs) throws SQLException {
                        final int id = rs.getInt("id");
                        final int moduleId = rs.getInt("module_id");
                        final String descr = rs.getString("descr");
                        final int pointCnt = rs.getInt("point_cnt");
                        final int usedPointCnt = rs.getInt("used_point_cnt");
                        result.add(new DeItem(id, moduleId, descr, pointCnt, usedPointCnt));
                    }
                }
        );
        return result;
    }

    @Override
    public List<UserDePoints> getStudentsDePoints(final long termId) {
        final Map<Long, UserDePoints> userIdToPoints = new HashMap<Long, UserDePoints>();
        jdbcTemplate.getJdbcOperations().query(
                "select up.user_id, up.de_item_id, sum(up.point_cnt) as point_cnt " +
                "from user_point up " +
                        "join de_item i on up.de_item_id = i.id " +
                        "join term_module tm on i.module_id = tm.id and tm.term_id = ? " +
                "group by up.user_id, up.de_item_id " +
                "order by 1, 2, 3",
                new PreparedStatementSetter() {
                    @Override
                    public void setValues(final PreparedStatement ps) throws SQLException {
                        ps.setLong(1, termId);
                    }
                },
                new RowCallbackHandler() {
                    @Override
                    public void processRow(final ResultSet rs) throws SQLException {
                        final long userId = rs.getLong("user_id");
                        final int deItemId = rs.getInt("de_item_id");
                        final int pointCnt = rs.getInt("point_cnt");

                        UserDePoints items = userIdToPoints.get(userId);
                        if (items == null) {
                            items = new UserDePoints(userId);
                            userIdToPoints.put(userId, items);
                        }
                        items.addItem(new DePoint(deItemId, pointCnt));
                    }
                }
        );
        return new ArrayList<UserDePoints>(userIdToPoints.values());
    }

    @Override
    public List<KarmaPoint> getStudentsKarmaPoints(final long termId) {
        final List<KarmaPoint> result = new ArrayList<KarmaPoint>();
        jdbcTemplate.getJdbcOperations().query(
                "select user_id, karma_id, task_id, lesson_id, creation_time from user_karma order by creation_time desc",
                new RowCallbackHandler() {
                    @Override
                    public void processRow(final ResultSet rs) throws SQLException {
                        result.add(new KarmaPoint(
                                rs.getLong("user_id"),
                                rs.getInt("karma_id"),
                                rs.getLong("task_id"),
                                rs.getLong("lesson_id"),
                                rs.getString("creation_time")
                        ));
                    }
                }
        );
        return result;
    }

    @Override
    public void addStudentKarmaPoint(final KarmaPoint point) {
        jdbcTemplate.update(
                "insert into user_karma (user_id, karma_id, task_id, lesson_id) values (?,?,?,?)",
                point.getUserId(),
                point.getKarmaId(),
                point.getTaskId() > 0 ? point.getTaskId() : null,
                point.getLessonId() > 0 ? point.getLessonId() : null
        );
    }

    @Override
    public void weeklyKarma(final long taskId) {
        jdbcTemplate.update(
            "insert into user_karma (user_id, karma_id, task_id) " +
            "select user_id, 12 as karma_id, task_id " +
                    "from user_task_status " +
                    "where task_id = ? and status = " + TaskStatus.EXPIRED.getCode(),
            taskId
        );
    }
}
