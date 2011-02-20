package ru.obolshakova.students.itmo.task;

import net.sf.xfresh.db.util.DbUtil;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallback;
import org.springframework.transaction.support.TransactionTemplate;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 11.02.11 0:11
 */
public class DbTaskService implements TaskService {

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

    public long addTask(final Task task, final List<TaskPoint> points, final List<TaskKarma> karma) {
        return (Long) transactionTemplate.execute(new TransactionCallback() {
            public Object doInTransaction(final TransactionStatus transactionStatus) {
                jdbcTemplate.update(
                        "insert task (module_id, module_npp, name, type, body_html, homework, hidden) values (?,?,?,?,?,?,?)",
                        task.getModuleId(), task.getModuleNpp(), task.getName(), 1 /*TODO*/, task.getBodyHtml(), task.isHomework() ? 1 : 0, task.isHidden() ? 1 : 0
                );
                final Long taskId = DbUtil.getLastInsertId(jdbcTemplate);
                jdbcTemplate.getJdbcOperations().batchUpdate(
                        "insert into task_point (task_id, point_cnt, de_item_id, descr) values (?,?,?,?)",
                        new BatchPreparedStatementSetter() {
                            public void setValues(final PreparedStatement ps, final int i) throws SQLException {
                                final TaskPoint point = points.get(i);
                                ps.setLong(1, taskId);
                                ps.setObject(2, point.getPointCnt());
                                ps.setObject(3, point.getDeItemId());
                                ps.setString(4, point.getDescription());
                            }

                            public int getBatchSize() {
                                return points.size();
                            }
                        }
                );
                jdbcTemplate.getJdbcOperations().batchUpdate(
                        "insert into task_karma (task_id, karma_id) values (?,?)",
                        new BatchPreparedStatementSetter() {
                            public void setValues(final PreparedStatement ps, final int i) throws SQLException {
                                final TaskKarma k = karma.get(i);
                                ps.setLong(1, taskId);
                                ps.setObject(2, k.getKarmaId());
                            }

                            public int getBatchSize() {
                                return karma.size();
                            }
                        }
                );
                return taskId;
            }
        });
    }

    public Task getTask(final long id) {
        final List<Task> result = new ArrayList<Task>(1);
        jdbcTemplate.getJdbcOperations().query(
                "select module_id, module_npp, name, type, body_html, homework, hidden from task where id = ?",
                new PreparedStatementSetter() {
                    public void setValues(final PreparedStatement ps) throws SQLException {
                        ps.setLong(1, id);
                    }
                },
                new RowCallbackHandler() {
                    public void processRow(final ResultSet rs) throws SQLException {
                        result.add(new Task(id, TaskType.SIMPLE, rs.getInt("module_id"), rs.getInt("module_npp"), rs.getString("name"), rs.getString("body_html"), rs.getBoolean("homework"), rs.getBoolean("hidden")));
                    }
                }
        );
        if (result.isEmpty()) {
            return null;
        }
        if (result.size() > 1) {
            throw new IllegalStateException("More than 1 task with id " + id);
        }
        return result.get(0);
    }

    public List<TaskPointInfo> getTaskPoints(final long taskId) {
        final List<TaskPointInfo> result = new ArrayList<TaskPointInfo>(5);
        jdbcTemplate.getJdbcOperations().query(
                "select p.point_cnt, p.de_item_id, p.descr, i.descr as item_descr from task_point p join de_item i on p.de_item_id = i.id  where task_id = ?",
                new PreparedStatementSetter() {
                    public void setValues(final PreparedStatement ps) throws SQLException {
                        ps.setLong(1, taskId);
                    }
                },
                new RowCallbackHandler() {
                    public void processRow(final ResultSet rs) throws SQLException {
                        final TaskPointInfo point = new TaskPointInfo(rs.getString("descr"), rs.getInt("point_cnt"), rs.getInt("de_item_id"), rs.getString("item_descr"));
                        result.add(point);
                    }
                }
        );
        return result;
    }

    public List<TaskKarmaInfo> getTaskKarma(final long taskId) {
        final List<TaskKarmaInfo> result = new ArrayList<TaskKarmaInfo>(5);
        jdbcTemplate.getJdbcOperations().query(
                "select karma_id, k.point_cnt, k.descr from task_karma p join karma k on p.karma_id = k.id where task_id = ? order by k.npp",
                new PreparedStatementSetter() {
                    public void setValues(final PreparedStatement ps) throws SQLException {
                        ps.setLong(1, taskId);
                    }
                },
                new RowCallbackHandler() {
                    public void processRow(final ResultSet rs) throws SQLException {
                        final TaskKarmaInfo point = new TaskKarmaInfo(rs.getInt("karma_id"), rs.getInt("point_cnt"), rs.getString("descr"));
                        result.add(point);
                    }
                }
        );
        return result;
    }

    public List<TaskInfo> getAllTasks(final int termId) {
        final List<TaskInfo> result = new ArrayList<TaskInfo>(50);
        jdbcTemplate.getJdbcOperations().query(
                "select t.id, t.module_id, t.module_npp, t.name,\n" +
                "       p.point_cnt as point_cnt, k.point_cnt as karma_cnt,\n" +
                "       t.homework, tl.lesson_id\n" +
                "from task t join term_module m on t.module_id = m.id\n" +
                "     left join (\n" +
                "          select task_id, sum(point_cnt) as point_cnt\n" +
                "          from task_point\n" +
                "          group by task_id\n" +
                "     ) p on t.id = p.task_id\n" +
                "     left join (\n" +
                "          select tk.task_id, sum(kr.point_cnt) as point_cnt\n" +
                "          from task_karma tk join karma kr on tk.karma_id = kr.id\n" +
                "          where kr.id not in (2,3)\n" +
                "          group by tk.task_id\n" +
                "     ) k on t.id = k.task_id\n" +
                "     left join task_lesson tl on t.id = tl.task_id\n" +
                "where m.term_id = ? order by module_npp",
                new PreparedStatementSetter() {
                    public void setValues(final PreparedStatement ps) throws SQLException {
                        ps.setLong(1, termId);
                    }
                },
                new RowCallbackHandler() {
                    public void processRow(final ResultSet rs) throws SQLException {
                        final TaskInfo point = new TaskInfo(
                                rs.getLong("id"), rs.getInt("module_id"), rs.getInt("module_npp"),
                                rs.getString("name"), rs.getInt("point_cnt"), rs.getInt("karma_cnt"),
                                rs.getInt("homework"), rs.getInt("lesson_id")
                        );
                        result.add(point);
                    }
                }
        );
        return result;
    }

    public List<TaskStatusInfo> getAllStatuses() {
        final List<TaskStatusInfo> result = new ArrayList<TaskStatusInfo>(TaskStatus.values().length);
        jdbcTemplate.getJdbcOperations().query(
                "select id, descr from task_status",
                new RowCallbackHandler() {
                    public void processRow(final ResultSet rs) throws SQLException {
                        result.add(new TaskStatusInfo(rs.getInt("id"), rs.getString("descr")));
                    }
                }
        );
        return result;
    }
}
