package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import ru.obolshakova.students.itmo.user.UserTaskPoints;

import static net.sf.xfresh.core.xml.Xmler.tag;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 20.02.11 20:29
 */
public class StudentTaskPointYalet extends AbstractUserYalet {

    public void process(final InternalRequest req, final InternalResponse res) {
        try {
            final long userId = Long.parseLong(req.getParameter("user-id"));
            final long taskId = Long.parseLong(req.getParameter("task"));

            final UserTaskPoints studentTaskPoint = userService.getStudentTaskPoints(userId, taskId);
            res.add(YaletXmlUtils.studentTaskPoints(studentTaskPoint));
        } catch (NumberFormatException e) {
            res.add(tag("student-task-point"));
        }
    }
}
