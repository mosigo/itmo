package ru.obolshakova.students.itmo.user;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 14.02.11 2:34
 */
public class UserPoints {

    private final long userId;
    private final int pointCnt;
    private final int karmaCnt;

    public UserPoints(final long userId, final int pointCnt, final int karmaCnt) {
        this.userId = userId;
        this.pointCnt = pointCnt;
        this.karmaCnt = karmaCnt;
    }

    public long getUserId() {
        return userId;
    }

    public int getPointCnt() {
        return pointCnt;
    }

    public int getKarmaCnt() {
        return karmaCnt;
    }
}
