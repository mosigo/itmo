package ru.obolshakova.students.itmo.point;

import ru.obolshakova.students.itmo.user.UserDePoints;

import java.util.List;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 06.03.11 17:18
 */
public interface PointsService {

    List<DeItem> getDeItems(long termId);

    List<KarmaItem> loadKarmaItems();

    List<UserDePoints> getStudentsDePoints(long termId);

    List<KarmaPoint> getStudentsKarmaPoints(long termId);

    void addStudentKarmaPoint(KarmaPoint point);

    void weeklyKarma(long taskId);
}
