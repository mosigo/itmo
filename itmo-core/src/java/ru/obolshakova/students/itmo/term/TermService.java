package ru.obolshakova.students.itmo.term;

import org.springframework.beans.factory.annotation.Required;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 30.01.11 21:04
 */
public class TermService {

    private SimpleJdbcTemplate jdbcTemplate;

    @Required
    public void setJdbcTemplate(final SimpleJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Term> loadTerms() {
        final List<Term> result = new ArrayList<Term>(5);
        jdbcTemplate.getJdbcOperations().query(
                "select id, descr, active from term order by id",
                new RowCallbackHandler() {
                    public void processRow(final ResultSet rs) throws SQLException {
                        final long id = rs.getLong("id");
                        final String descr = rs.getString("descr");
                        final boolean active = rs.getBoolean("active");
                        result.add(new Term(id, descr, active));
                    }
                }
        );
        return result;
    }
}
