package ru.obolshakova.students.itmo.karma;

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
 * Date: 07.01.11 22:40
 */
public class KarmaService {

    private SimpleJdbcTemplate jdbcTemplate;

    @Required
    public void setJdbcTemplate(final SimpleJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<KarmaItem> loadItems() {
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
}
