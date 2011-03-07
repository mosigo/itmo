package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import org.apache.log4j.Logger;
import ru.obolshakova.students.itmo.point.KarmaItem;
import ru.obolshakova.students.itmo.task.TaskKarma;
import ru.obolshakova.students.itmo.task.TaskPoint;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 07.03.11 0:24
 */
public class SaveTaskPointsYalet extends AbstractTaskYalet {
    private static final Logger log = Logger.getLogger(SaveTaskPointsYalet.class);

    @Override
    public void process(final InternalRequest req, final InternalResponse res) {
        if (req.getUserId() == null || req.getUserId() != 1L) {
            log.info("user is not admin");
            return;
        }

        log.info("all params => " + req.getAllParameters());

        final long taskId = Long.parseLong(req.getParameter("task"));

        final List<TaskKarma> karma = new ArrayList<TaskKarma>();
        final String[] karmaValues = req.getParameters("karma-id");

        if (karmaValues != null) {
            for (final String karmaIdAsStr : karmaValues) {
                karma.add(new TaskKarma(Integer.parseInt(karmaIdAsStr)));
            }
        }

        final List<TaskPoint> points = new ArrayList<TaskPoint>();
        for (final Map.Entry<String, List<String>> entry : req.getAllParameters().entrySet()){
            final String paramName = entry.getKey();
            if (paramName.startsWith("deitem-")) {
                final String deItemIdAsStr = paramName.split("-")[1];
                final int deItem = Integer.parseInt(deItemIdAsStr);
                final String pointsAsStr = entry.getValue().get(0);
                try {
                    final int point = Integer.parseInt(pointsAsStr);
                    if (point > 0) {
                        final String descr = req.getParameter("deitemdescr-" + deItem);
                        points.add(new TaskPoint(descr, point, deItem));
                    }
                } catch (NumberFormatException e) {
                    //ignore
                }
            }
        }

        final String lessonIdAsStr = req.getParameter("lesson-id");
        final int lessonId = lessonIdAsStr == null ? -1 : Integer.parseInt(lessonIdAsStr);

        taskService.saveTaskPoints(taskId, points, karma, lessonId);
    }

}
