package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import org.apache.log4j.Logger;
import ru.obolshakova.students.itmo.task.TaskInfo;

import static net.sf.xfresh.core.xml.Xmler.tag;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 06.03.11 22:55
 */
public class TaskInfoYalet extends AbstractTaskYalet {
    private static final Logger log = Logger.getLogger(TaskInfoYalet.class);

    @Override
    public void process(final InternalRequest req, final InternalResponse res) {
        try {
            final long taskId = Long.parseLong(req.getParameter("task"));
            final long termId = Long.parseLong(req.getParameter("term"));
            for (final TaskInfo task : taskService.getAllTasks(termId)){
                if (task.getTaskId() == taskId) {
                    res.add(YaletXmlUtils.taskInfo(task));
                    return;
                }
            }
            res.add(tag("task"));
        } catch (Exception e) {
            log.error("", e);
            res.add(tag("task"));
        }
    }
}
