package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import net.sf.xfresh.core.xml.Tagable;
import ru.obolshakova.students.itmo.task.TaskStatusInfo;

import java.util.ArrayList;
import java.util.List;

import static net.sf.xfresh.core.xml.Xmler.attribute;
import static net.sf.xfresh.core.xml.Xmler.tag;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 18.02.11 1:40
 */
public class TaskStatusesYalet extends AbstractTaskYalet {

    public void process(final InternalRequest req, final InternalResponse res) {
        final List<TaskStatusInfo> statuses = taskService.getAllStatuses();
        final List<Tagable> tags = new ArrayList<Tagable>(statuses.size());
        for (final TaskStatusInfo status : statuses) {
            tags.add(tag("status", attribute("code", status.getCode()), status.getDescription()));
        }
        res.add(tag("task-statuses", tags));
    }
}
