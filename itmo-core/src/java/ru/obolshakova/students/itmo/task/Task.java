package ru.obolshakova.students.itmo.task;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 11.02.11 0:06
 */
public class Task {

    private long id = -1L;

    private final TaskType type;

    private final int moduleId;
    private final int moduleNpp;

    private final String name;
    private final String bodyHtml;

    private final boolean isHomework;
    private final boolean isHidden;

    public Task(final long id, final TaskType type, final int moduleId, final int moduleNpp, final String name, final String bodyHtml, final boolean isHomework, final boolean hidden) {
        this(type, moduleId, moduleNpp, name, bodyHtml, isHomework, hidden);
        this.id = id;
    }

    public Task(final TaskType type, final int moduleId, final int moduleNpp, final String name, final String bodyHtml, final boolean homework, final boolean hidden) {
        this.type = type;
        this.moduleId = moduleId;
        this.moduleNpp = moduleNpp;
        this.name = name;
        this.bodyHtml = bodyHtml;
        isHidden = hidden;
        isHomework = homework;
    }

    public long getId() {
        return id;
    }

    public TaskType getType() {
        return type;
    }

    public int getModuleId() {
        return moduleId;
    }

    public int getModuleNpp() {
        return moduleNpp;
    }

    public String getName() {
        return name;
    }

    public String getBodyHtml() {
        return bodyHtml;
    }

    public boolean isHomework() {
        return isHomework;
    }

    public boolean isHidden() {
        return isHidden;
    }
}
