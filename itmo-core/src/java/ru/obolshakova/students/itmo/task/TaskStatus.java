package ru.obolshakova.students.itmo.task;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 18.02.11 1:06
 */
public enum TaskStatus {
    NOT_RECEIVED(-1),
    RECEIVED(0),
    AWAITING(1),
    ACCEPTED(2),
    PARTIALLY_ACCEPTED(3),
    DECLINED(4),
    EXPIRED(5)
    ;

    private final int code;

    TaskStatus(final int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }

    public static TaskStatus byCode(final int code) {
        for (final TaskStatus status : values()) {
            if (code == status.code) {
                return status;
            }
        }
        throw new IllegalArgumentException("No task status with code " + code);
    }
}
