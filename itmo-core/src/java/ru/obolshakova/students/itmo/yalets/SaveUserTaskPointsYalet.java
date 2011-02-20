package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import org.apache.log4j.Logger;
import ru.obolshakova.students.itmo.task.TaskKarma;
import ru.obolshakova.students.itmo.task.TaskPoint;
import ru.obolshakova.students.itmo.task.TaskStatus;

import java.util.ArrayList;
import java.util.List;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 19.02.11 2:43
 */
public class SaveUserTaskPointsYalet extends AbstractUserYalet {
    private static final Logger log = Logger.getLogger(SaveUserTaskPointsYalet.class);

    public void process(final InternalRequest req, final InternalResponse res) {
        if (req.getUserId() == null || req.getUserId() != 1L) {
            log.info("user is not admin");
            return;
        }

        log.info("all params => {" + req.getAllParameters() + "}");
        final long userId = Long.parseLong(req.getParameter("student-id"));
        final long taskId = Long.parseLong(req.getParameter("task-id"));

        final List<TaskPoint> points = new ArrayList<TaskPoint>(5);
        final String[] pointValues = req.getParameters("de-item-id");
        if (pointValues != null) {
            for (final String deItemIdAsStr : pointValues) {
                final int pointCnt = Integer.parseInt(req.getParameter("task-point-" + deItemIdAsStr));
                points.add(new TaskPoint("", pointCnt, Integer.parseInt(deItemIdAsStr)));
            }
        }

        final List<TaskKarma> karma = new ArrayList<TaskKarma>(5);
        final String[] karmaValues = req.getParameters("karma-id");
        if (karmaValues != null) {
            for (final String karmaIdAsStr : karmaValues) {
                karma.add(new TaskKarma(Integer.parseInt(karmaIdAsStr)));
            }
        }

        userService.saveUserTaskPoints(userId, taskId, points, karma, TaskStatus.byCode(Integer.parseInt(req.getParameter("task-status"))));

    }
}
