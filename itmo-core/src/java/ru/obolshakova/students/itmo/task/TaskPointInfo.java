package ru.obolshakova.students.itmo.task;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 12.02.11 0:31
 */
public class TaskPointInfo extends TaskPoint {

    private final String deItemName;

    public TaskPointInfo(final String description, final Integer pointCnt, final Integer deItemId, final String deItemName) {
        super(description, pointCnt, deItemId);
        this.deItemName = deItemName;
    }

    public String getDeItemName() {
        return deItemName;
    }
}
