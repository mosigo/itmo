package ru.obolshakova.students.itmo.user;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 14.02.11 0:46
 */
public enum UserRole {
    STUDENT(1), LECTURER(2), ADMIN(3);

    private final int code;

    UserRole(final int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }

    public static UserRole byCode(final int code) {
        for (final UserRole role : values()) {
            if (role.code == code) {
                return role;
            }
        }
        throw new IllegalArgumentException("No role with code " + code);
    }
}
