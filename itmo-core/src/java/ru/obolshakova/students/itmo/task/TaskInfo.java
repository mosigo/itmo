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

    private final int type;
    private final int lessonId;

    public TaskInfo(final long taskId, final long moduleId, final int moduleNpp, final String name, final int pointCnt, final int karmaCnt, final int type, final int lessonId) {
        this.taskId = taskId;
        this.moduleId = moduleId;
        this.moduleNpp = moduleNpp;
        this.name = name;
        this.pointCnt = pointCnt;
        this.karmaCnt = karmaCnt;
        this.type = type;
        this.lessonId = lessonId;
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

    public int getType() {
        return type;
    }

    public int getLessonId() {
        return lessonId;
    }
}
