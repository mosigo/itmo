package ru.obolshakova.students.itmo.task;

import java.util.List;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 11.02.11 0:11
 */
public interface TaskService {

    long addTask(Task task, List<TaskPoint> points, List<TaskKarma> karma);

    Task getTask(long id);

    List<TaskInfo> getAllTasks(int termId);

    List<TaskPointInfo> getTaskPoints(long taskId);

    List<TaskKarmaInfo> getTaskKarma(long taskId);

    List<TaskStatusInfo> getAllStatuses();

}
