package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import net.sf.xfresh.core.xml.Tagable;
import ru.obolshakova.students.itmo.task.TaskKarma;
import ru.obolshakova.students.itmo.task.TaskKarmaInfo;
import ru.obolshakova.students.itmo.task.TaskPoint;
import ru.obolshakova.students.itmo.task.TaskPointInfo;
import ru.obolshakova.students.itmo.user.UserDetailedTaskPoints;

import java.util.ArrayList;
import java.util.List;

import static net.sf.xfresh.core.xml.Xmler.tag;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 20.02.11 21:11
 */
public class DetailedStudentTaskPointsYalet extends AbstractUserYalet {

    public void process(final InternalRequest req, final InternalResponse res) {
        try {
            final long userId = Long.parseLong(req.getParameter("user-id"));
            final long taskId = Long.parseLong(req.getParameter("task"));

            final UserDetailedTaskPoints taskPoints = userService.getDetailedStudentTaskPoints(userId, taskId);
            final List<Tagable> tags = getTaskPoints(taskPoints);

            res.add(tag("detailed-student-task-points", tags));
        } catch (NumberFormatException e) {
            res.add(tag("detailed-student-task-points"));
        }
    }

    private List<Tagable> getTaskPoints(final UserDetailedTaskPoints taskPoints) {
        final List<Tagable> tags = new ArrayList<Tagable>(10);
        for (final TaskPoint taskPoint : taskPoints.getTaskPoints()) {
            tags.add(
                    tag("point",
                            tag("description", taskPoint.getDescription()),
                            tag("point-cnt", Integer.toString(taskPoint.getPointCnt())),
                            tag("de-item-id", Integer.toString(taskPoint.getDeItemId()))
                    )
            );
        }
        for (final TaskKarma info : taskPoints.getTaskKarma()) {
            tags.add(
                    tag("karma",
                            tag("karma-id", Integer.toString(info.getKarmaId()))
                    )
            );

        }
        return tags;
    }
}
