package ru.obolshakova.students.itmo.user;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 06.03.11 16:43
 */
public class DePoint {

    private final int deItemId;
    private final int pointCnt;

    public DePoint(final int deItemId, final int pointCnt) {
        this.deItemId = deItemId;
        this.pointCnt = pointCnt;
    }

    public int getDeItemId() {
        return deItemId;
    }

    public int getPointCnt() {
        return pointCnt;
    }
}
