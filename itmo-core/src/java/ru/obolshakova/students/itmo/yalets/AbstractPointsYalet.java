package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.Yalet;
import org.springframework.beans.factory.annotation.Required;
import ru.obolshakova.students.itmo.point.DbPointsService;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 06.03.11 17:20
 */
abstract class AbstractPointsYalet implements Yalet {

    protected DbPointsService pointsService;

    @Required
    public void setPointsService(final DbPointsService pointsService) {
        this.pointsService = pointsService;
    }
}
