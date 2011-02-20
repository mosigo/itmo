package ru.obolshakova.students.itmo.user;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 18.02.11 2:15
 */
public enum AttendanceType {
    ABSENTEE(0),
    LATECOMER(1),
    PRESENT(2)
    ;

    private final int code;

    AttendanceType(final int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }

    public static AttendanceType byCode(final int code) {
        for (final AttendanceType type : values()) {
            if (code == type.code) {
                return type;
            }
        }
        throw new IllegalArgumentException("No attendance type with code " + code);
    }
}
