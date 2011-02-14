package ru.obolshakova.students.itmo.task;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 11.02.11 23:57
 */
public class TaskKarmaInfo {

    private final int karmaId;
    private final int pointCnt;
    private final String description;

    public TaskKarmaInfo(final int karmaId, final int pointCnt, final String description) {
        this.karmaId = karmaId;
        this.pointCnt = pointCnt;
        this.description = description;
    }

    public int getKarmaId() {
        return karmaId;
    }

    public int getPointCnt() {
        return pointCnt;
    }

    public String getDescription() {
        return description;
    }
}
