package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import net.sf.xfresh.core.xml.Tagable;
import ru.obolshakova.students.itmo.lesson.Lesson;

import java.util.ArrayList;
import java.util.List;

import static net.sf.xfresh.core.xml.Xmler.attribute;
import static net.sf.xfresh.core.xml.Xmler.tag;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 06.03.11 19:26
 */
public class LessonsYalet extends AbstractLessonYalet {

    @Override
    public void process(final InternalRequest req, final InternalResponse res) {
        final long termId = Long.parseLong(req.getParameter("term"));
        final List<Lesson> lessons = lessonService.getLessons(termId);
        final List<Tagable> tags = new ArrayList<Tagable>(lessons.size());

        for (final Lesson lesson : lessons) {
            tags.add(
                    tag("lesson",
                            attribute("id", lesson.getId()),
                            tag("name", lesson.getName()),
                            tag("module-id", Integer.toString(lesson.getModuleId())),
                            tag("type", Integer.toString(lesson.getType().getCode())),
                            tag("given", lesson.isGiven() ? "1" : "0")
                    )
            );
        }

        res.add(tag("lessons", tags));
    }
}
