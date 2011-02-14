package ru.obolshakova.students.itmo.task;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 11.02.11 0:20
 */
public class TaskPoint {

    private final String description;

    private final Integer pointCnt;
    private final Integer deItemId;

    public TaskPoint(final String description, final Integer pointCnt, final Integer deItemId) {
        this.description = description;
        this.pointCnt = pointCnt;
        this.deItemId = deItemId;
    }

    public String getDescription() {
        return description;
    }

    public Integer getPointCnt() {
        return pointCnt;
    }

    public Integer getDeItemId() {
        return deItemId;
    }
}
