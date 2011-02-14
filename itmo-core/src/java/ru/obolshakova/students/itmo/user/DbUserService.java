package ru.obolshakova.students.itmo.user;

import org.springframework.beans.factory.annotation.Required;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 14.02.11 0:16
 */
public class DbUserService implements UserService {

    private SimpleJdbcTemplate jdbcTemplate;

    @Required
    public void setJdbcTemplate(final SimpleJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
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
}
