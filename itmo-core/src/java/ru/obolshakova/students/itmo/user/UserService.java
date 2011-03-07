package ru.obolshakova.students.itmo.user;

import ru.obolshakova.students.itmo.task.TaskKarma;
import ru.obolshakova.students.itmo.task.TaskPoint;
import ru.obolshakova.students.itmo.task.TaskStatus;

import java.util.List;
import java.util.Map;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 14.02.11 0:17
 */
public interface UserService {

    List<UserInfo> getAllStudents(long termId);

    UserInfo getUserInfo(long userId);

    List<UserRole> getUserRoles(long termId, long userId);

    List<UserPoints> getStudentsPoints(long termId);

    List<UserTaskPoints> getStudentsTaskPoints(long termId);

    UserTaskPoints getStudentTaskPoints(long userId, long taskId);

    UserDetailedTaskPoints getDetailedStudentTaskPoints(long userId, long taskId);

    List<UserAttendance> getStudentsAttendance(long termId);

    void saveUserTaskPoints(long userId, long taskId, List<TaskPoint> points, List<TaskKarma> karma, TaskStatus status);

    void saveStudentsAttendance(List<UserAttendance> userAttendances);

}
