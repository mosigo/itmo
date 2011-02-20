package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import net.sf.xfresh.core.xml.Tagable;
import ru.obolshakova.students.itmo.user.UserTaskPoints;

import java.util.ArrayList;
import java.util.List;

import static net.sf.xfresh.core.xml.Xmler.tag;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 18.02.11 0:15
 */
public class StudentsTaskPointsYalet extends AbstractUserYalet {

    public void process(final InternalRequest req, final InternalResponse res) {
        final long termId;
        try {
            termId = Long.parseLong(req.getParameter("term"));
        } catch (NumberFormatException e) {
            res.add(tag("students"));
            return;
        }
        final List<UserTaskPoints> points = userService.getStudentsTaskPoints(termId);
        final List<Tagable> tags = new ArrayList<Tagable>(points.size());
        for (final UserTaskPoints point : points) {
            tags.add(YaletXmlUtils.studentTaskPoints(point));
        }
        res.add(tag("student-task-points", tags));
    }
}
