package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import net.sf.xfresh.core.xml.Tagable;
import ru.obolshakova.students.itmo.task.Task;
import ru.obolshakova.students.itmo.task.TaskKarmaInfo;
import ru.obolshakova.students.itmo.task.TaskPoint;
import ru.obolshakova.students.itmo.task.TaskPointInfo;

import java.util.ArrayList;
import java.util.List;

import static net.sf.xfresh.core.xml.Xmler.attribute;
import static net.sf.xfresh.core.xml.Xmler.tag;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 11.02.11 0:45
 */
public class TaskYalet extends AbstractTaskYalet {

    public void process(final InternalRequest req, final InternalResponse res) {
        final long taskId;
        try {
            taskId = Long.parseLong(req.getParameter("task"));
        } catch (NumberFormatException e) {
            res.add(tag("task"));
            return;
        }
        final Task task = taskService.getTask(taskId);

        if (task == null || (req.getUserId() == null || req.getUserId() != 1L) && task.isHidden()) {
            res.add(tag("task"));
            return;
        }

        res.add(
                tag("task",
                        attribute("id", task.getId())
                                .and("hidden", task.isHidden() ? "1" : "0")
                                .and("homework", task.isHomework() ? "1" : "0"),
                        tag("module-id", Integer.toString(task.getModuleId())),
                        tag("module-npp", Integer.toString(task.getModuleNpp())),
                        tag("name", task.getName()),
                        tag("body", task.getBodyHtml()),
                        tag("points", getTaskPoints(taskId))
                )
        );
    }

    private List<Tagable> getTaskPoints(final long taskId) {
        final List<TaskPoint> taskPoints = taskService.getTaskPoints(taskId);
        final List<Tagable> tags = new ArrayList<Tagable>(taskPoints.size());
        for (final TaskPoint taskPoint : taskPoints) {
            tags.add(
                    tag("point",
                            tag("description", taskPoint.getDescription()),
                            tag("point-cnt", Integer.toString(taskPoint.getPointCnt())),
                            tag("de-item-id", Integer.toString(taskPoint.getDeItemId()))
                    )
            );
        }
        for (final TaskKarmaInfo info : taskService.getTaskKarma(taskId)) {
            tags.add(
                    tag("karma",
                            tag("description", info.getDescription()),
                            tag("point-cnt", Integer.toString(info.getPointCnt())),
                            tag("karma-id", Integer.toString(info.getKarmaId()))
                    )
            );

        }
        return tags;
    }
}
