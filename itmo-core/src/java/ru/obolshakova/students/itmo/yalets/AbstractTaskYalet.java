package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.Yalet;
import org.springframework.beans.factory.annotation.Required;
import ru.obolshakova.students.itmo.task.TaskService;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 11.02.11 0:44
 */
abstract class AbstractTaskYalet implements Yalet {

    protected TaskService taskService;

    @Required
    public void setTaskService(final TaskService taskService) {
        this.taskService = taskService;
    }
}
