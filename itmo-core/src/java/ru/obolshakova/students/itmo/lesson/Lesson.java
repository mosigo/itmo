package ru.obolshakova.students.itmo.lesson;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 06.03.11 18:59
 */
public class Lesson {

    private final int id;
    private final LessonType type;
    private final String name;
    private final int moduleId;
    private final boolean isGiven;

    public Lesson(final int id, final LessonType type, final String name, final int moduleId, final boolean given) {
        this.id = id;
        this.type = type;
        this.name = name;
        this.moduleId = moduleId;
        isGiven = given;
    }

    public int getId() {
        return id;
    }

    public LessonType getType() {
        return type;
    }

    public String getName() {
        return name;
    }

    public int getModuleId() {
        return moduleId;
    }

    public boolean isGiven() {
        return isGiven;
    }
}
