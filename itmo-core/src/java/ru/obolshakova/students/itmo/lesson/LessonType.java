package ru.obolshakova.students.itmo.lesson;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 06.03.11 19:11
 */
public enum LessonType {
    LECTURE(1),
    LABS(2)
    ;


    private final int code;

    LessonType(final int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }

    public static LessonType byCode(final int code) {
        for (final LessonType type : values()) {
            if (code == type.getCode()) {
                return type;
            }
        }
        throw new IllegalArgumentException("No lesson type with code " + code);
    }
}
