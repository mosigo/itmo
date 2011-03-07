package ru.obolshakova.students.itmo.lesson;

import java.util.List;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 06.03.11 19:14
 */
public interface LessonService {

    List<Lesson> getLessons(long termId);
}
