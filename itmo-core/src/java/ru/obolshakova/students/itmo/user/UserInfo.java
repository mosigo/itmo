package ru.obolshakova.students.itmo.user;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 14.02.11 0:17
 */
public class UserInfo {

    private final long userId;
    private final String name;

    public UserInfo(final long userId, final String name) {
        this.userId = userId;
        this.name = name;
    }

    public long getUserId() {
        return userId;
    }

    public String getName() {
        return name;
    }
}
