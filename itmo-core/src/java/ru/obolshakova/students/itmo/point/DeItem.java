package ru.obolshakova.students.itmo.point;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 06.03.11 16:56
 */
public class DeItem {

    private final long id;
    private final int moduleId;
    private final String name;
    private final int pointCnt;
    private final int usedPointCnt;

    public DeItem(final long id, final int moduleId, final String name, final int pointCnt, final int usedPointCnt) {
        this.id = id;
        this.name = name;
        this.pointCnt = pointCnt;
        this.moduleId = moduleId;
        this.usedPointCnt = usedPointCnt;
    }

    public long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getPointCnt() {
        return pointCnt;
    }

    public int getModuleId() {
        return moduleId;
    }

    public int getUsedPointCnt() {
        return usedPointCnt;
    }
}
