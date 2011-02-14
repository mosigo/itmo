package ru.obolshakova.students.itmo.task;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 12.02.11 0:49
 */
public class TaskInfo {

    private final long taskId;
    private final long moduleId;

    private final int moduleNpp;
    private final String name;

    private final int pointCnt;
    private final int karmaCnt;

    public TaskInfo(final long taskId, final long moduleId, final int moduleNpp, final String name, final int pointCnt, final int karmaCnt) {
        this.taskId = taskId;
        this.moduleId = moduleId;
        this.moduleNpp = moduleNpp;
        this.name = name;
        this.pointCnt = pointCnt;
        this.karmaCnt = karmaCnt;
    }

    public long getTaskId() {
        return taskId;
    }

    public long getModuleId() {
        return moduleId;
    }

    public int getModuleNpp() {
        return moduleNpp;
    }

    public String getName() {
        return name;
    }

    public int getPointCnt() {
        return pointCnt;
    }

    public int getKarmaCnt() {
        return karmaCnt;
    }
}
