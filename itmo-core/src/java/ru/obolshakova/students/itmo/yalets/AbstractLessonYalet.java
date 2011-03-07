package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.Yalet;
import org.springframework.beans.factory.annotation.Required;
import ru.obolshakova.students.itmo.lesson.LessonService;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 06.03.11 19:24
 */
abstract class AbstractLessonYalet implements Yalet {

    protected LessonService lessonService;

    @Required
    public void setLessonService(final LessonService lessonService) {
        this.lessonService = lessonService;
    }
}
