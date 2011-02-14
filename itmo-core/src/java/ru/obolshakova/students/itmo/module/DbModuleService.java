package ru.obolshakova.students.itmo.module;

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
 * Date: 12.02.11 2:17
 */
public class DbModuleService implements ModuleService {

    private SimpleJdbcTemplate jdbcTemplate;

    @Required
    public void setJdbcTemplate(final SimpleJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Module> getModules(final long termId) {
        final List<Module> result = new ArrayList<Module>(5);
        jdbcTemplate.getJdbcOperations().query(
                "select id, descr from term_module where term_id = ? order by id",
                new PreparedStatementSetter() {
                    public void setValues(final PreparedStatement ps) throws SQLException {
                        ps.setLong(1, termId);
                    }
                },
                new RowCallbackHandler() {
                    public void processRow(final ResultSet rs) throws SQLException {
                        result.add(new Module(rs.getInt("id"), rs.getString("descr")));
                    }
                }
        );
        return result;
    }
}
