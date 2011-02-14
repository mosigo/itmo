package ru.obolshakova.students.itmo.user;

import java.util.List;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 14.02.11 0:17
 */
public interface UserService {

    List<UserInfo> getAllStudents(long termId);

    List<UserRole> getUserRoles(long termId, long userId);

    List<UserPoints> getStudentsPoints(long termId);

}
