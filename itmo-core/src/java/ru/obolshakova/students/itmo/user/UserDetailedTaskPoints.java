package ru.obolshakova.students.itmo.user;

import ru.obolshakova.students.itmo.task.TaskKarma;
import ru.obolshakova.students.itmo.task.TaskPoint;

import java.util.List;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 20.02.11 20:53
 */
public class UserDetailedTaskPoints {

    private final long taskId;
    private final List<TaskPoint> taskPoints;
    private final List<TaskKarma> taskKarma;

    public UserDetailedTaskPoints(final long taskId, final List<TaskPoint> taskPoints, final List<TaskKarma> taskKarma) {
        this.taskId = taskId;
        this.taskPoints = taskPoints;
        this.taskKarma = taskKarma;
    }

    public long getTaskId() {
        return taskId;
    }

    public List<TaskPoint> getTaskPoints() {
        return taskPoints;
    }

    public List<TaskKarma> getTaskKarma() {
        return taskKarma;
    }
}
