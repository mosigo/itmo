package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import net.sf.xfresh.core.xml.Tagable;
import ru.obolshakova.students.itmo.user.UserAttendance;
import ru.obolshakova.students.itmo.user.UserTaskPoints;

import java.util.ArrayList;
import java.util.List;

import static net.sf.xfresh.core.xml.Xmler.tag;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 18.02.11 2:30
 */
public class StudentsAttendanceYalet extends AbstractUserYalet {

    public void process(final InternalRequest req, final InternalResponse res) {
        final long termId;
        try {
            termId = Long.parseLong(req.getParameter("term"));
        } catch (NumberFormatException e) {
            res.add(tag("students-attendance"));
            return;
        }
        final List<UserAttendance> points = userService.getStudentsAttendance(termId);
        final List<Tagable> tags = new ArrayList<Tagable>(points.size());
        for (final UserAttendance attendance : points) {
            tags.add(tag(
                    "student-attendance",
                    tag("student-id", Long.toString(attendance.getUserId())),
                    tag("lesson-id", Integer.toString(attendance.getLessonId())),
                    tag("status", Integer.toString(attendance.getAttendanceType().getCode()))
            ));
        }
        res.add(tag("students-attendance", tags));
    }
}
