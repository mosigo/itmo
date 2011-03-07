package ru.obolshakova.students.itmo.point;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 07.03.11 2:28
 */
public class KarmaPoint {

    private final long userId;
    private final int karmaId;
    private final Long taskId;
    private final Long lessonId;
    private final String time;

    public KarmaPoint(final long userId, final int karmaId, final Long taskId, final Long lessonId, final String time) {
        this.userId = userId;
        this.karmaId = karmaId;
        this.taskId = taskId;
        this.lessonId = lessonId;
        this.time = time;
    }

    public long getUserId() {
        return userId;
    }

    public int getKarmaId() {
        return karmaId;
    }

    public Long getTaskId() {
        return taskId;
    }

    public Long getLessonId() {
        return lessonId;
    }

    public String getTime() {
        return time;
    }
}
