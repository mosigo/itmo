package ru.obolshakova.students.itmo.user;

import ru.obolshakova.students.itmo.task.TaskStatus;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 17.02.11 23:49
 */
public class UserTaskPoints {

    private final long userId;
    private final int taskId;
    private final int pointCnt;
    private final int karmaCnt;
    private final TaskStatus status;

    public UserTaskPoints(final long userId, final int taskId, final int pointCnt, final int karmaCnt, final TaskStatus status) {
        this.userId = userId;
        this.taskId = taskId;
        this.pointCnt = pointCnt;
        this.karmaCnt = karmaCnt;
        this.status = status;
    }

    public long getUserId() {
        return userId;
    }

    public int getTaskId() {
        return taskId;
    }

    public int getPointCnt() {
        return pointCnt;
    }

    public int getKarmaCnt() {
        return karmaCnt;
    }

    public TaskStatus getStatus() {
        return status;
    }
}
