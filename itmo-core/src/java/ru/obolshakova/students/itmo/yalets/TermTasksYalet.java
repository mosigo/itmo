package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import net.sf.xfresh.core.Yalet;
import net.sf.xfresh.core.xml.Tagable;
import ru.obolshakova.students.itmo.task.TaskInfo;

import java.util.ArrayList;
import java.util.List;

import static net.sf.xfresh.core.xml.Xmler.attribute;
import static net.sf.xfresh.core.xml.Xmler.tag;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 12.02.11 1:13
 */
public class TermTasksYalet extends AbstractTaskYalet {

    public void process(final InternalRequest req, final InternalResponse res) {
        final int termId;
        try {
            termId = Integer.parseInt(req.getParameter("term"));
        } catch (NumberFormatException e) {
            res.add(tag("tasks"));
            return;
        }
        final List<TaskInfo> tasks = taskService.getAllTasks(termId);
        final List<Tagable> tags = new ArrayList<Tagable>(tasks.size());
        for (final TaskInfo task : tasks) {
            tags.add(
                    YaletXmlUtils.taskInfo(task)
            );
        }
        res.add(tag("tasks", tags));
    }


}
