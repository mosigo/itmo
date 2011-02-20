package ru.obolshakova.students.itmo.user;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 18.02.11 2:09
 */
public class UserAttendance {

    private final long userId;
    private final int lessonId;
    private final AttendanceType attendanceType;

    public UserAttendance(final long userId, final int lessonId, final AttendanceType attendanceType) {
        this.userId = userId;
        this.lessonId = lessonId;
        this.attendanceType = attendanceType;
    }

    public long getUserId() {
        return userId;
    }

    public int getLessonId() {
        return lessonId;
    }

    public AttendanceType getAttendanceType() {
        return attendanceType;
    }
}
