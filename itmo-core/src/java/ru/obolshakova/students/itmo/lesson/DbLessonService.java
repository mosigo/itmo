package ru.obolshakova.students.itmo.lesson;

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
 * Date: 06.03.11 19:15
 */
public class DbLessonService implements LessonService {

    private SimpleJdbcTemplate jdbcTemplate;

    @Required
    public void setJdbcTemplate(final SimpleJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Lesson> getLessons(final long termId) {
        final List<Lesson> result = new ArrayList<Lesson>(30);
        jdbcTemplate.getJdbcOperations().query(
                "select l.id, l.type, l.name, l.module_id, l.given " +
                "from lesson l " +
                        "join term_module m on l.module_id = m.id and m.term_id = ? " +
                "order by l.id",
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
                        final LessonType type = LessonType.byCode(rs.getInt("type"));
                        final String name = rs.getString("name");
                        final int moduleId = rs.getInt("module_id");
                        final int isGiven = rs.getInt("given");
                        result.add(new Lesson(id, type, name, moduleId, isGiven == 1));
                    }
                }
        );
        return result;
    }
}
