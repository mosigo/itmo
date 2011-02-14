package ru.obolshakova.students.itmo.karma;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 07.01.11 22:39
 */
public class KarmaItem {

    private int id = -1;

    private final int pointCnt;
    private final String description;

    public KarmaItem(final int id, final int pointCnt, final String description) {
        this.id = id;
        this.pointCnt = pointCnt;
        this.description = description;
    }

    public KarmaItem(final int pointCnt, final String description) {
        this(-1, pointCnt, description);
    }

    public int getId() {
        return id;
    }

    public int getPointCnt() {
        return pointCnt;
    }

    public String getDescription() {
        return description;
    }
}
