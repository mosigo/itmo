package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import org.apache.log4j.Logger;
import ru.obolshakova.students.itmo.point.KarmaPoint;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 07.03.11 14:45
 */
public class AddStudentKarmaPointYalet extends AbstractPointsYalet {
    private static final Logger log = Logger.getLogger(AddStudentKarmaPointYalet.class);

    @Override
    public void process(final InternalRequest req, final InternalResponse res) {
        if (req.getUserId() == null || req.getUserId() != 1L) {
            log.info("user is not admin");
            return;
        }
        log.info("all params => {" + req.getAllParameters() + "}");

        final long userId = Long.parseLong(req.getParameter("user-id"));
        final int karmaId = Integer.parseInt(req.getParameter("karma-id"));
        final long lessonId = Long.parseLong(req.getParameter("lesson-id"));
        final long taskId = Long.parseLong(req.getParameter("task-id"));

        pointsService.addStudentKarmaPoint(new KarmaPoint(userId, karmaId, taskId, lessonId, ""));
    }
}
