package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import org.apache.log4j.Logger;
import ru.obolshakova.students.itmo.task.Task;
import ru.obolshakova.students.itmo.task.TaskType;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 06.03.11 22:25
 */
public class SaveTaskYalet extends AbstractTaskYalet {
    private static final Logger log = Logger.getLogger(SaveTaskYalet.class);

    @Override
    public void process(final InternalRequest req, final InternalResponse res) {
        if (req.getUserId() == null || req.getUserId() != 1L) {
            log.info("user is not admin");
            return;
        }

        log.info("all params => " + req.getAllParameters());

        final String taskIdAsStr = req.getParameter("task");
        final long taskId = taskIdAsStr == null ? -1L : Long.parseLong(taskIdAsStr);

        final int moduleId = Integer.parseInt(req.getParameter("module-id"));
        final int moduleNpp = Integer.parseInt(req.getParameter("module-npp"));
        final String name = req.getParameter("name");
        final String body = req.getParameter("body");

        final String homeworkAsStr = req.getParameter("homework");
        final boolean homework = homeworkAsStr != null && Integer.parseInt(homeworkAsStr) == 1;

        final String hiddenAsStr = req.getParameter("hidden");
        final boolean hidden = hiddenAsStr != null && Integer.parseInt(hiddenAsStr) == 1;

        final Task task = new Task(
                taskId, TaskType.SIMPLE, moduleId, moduleNpp,
                name, body, homework, hidden
        );

        taskService.saveTask(task);
    }
}
