package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import net.sf.xfresh.core.xml.Tagable;
import org.apache.log4j.Logger;
import ru.obolshakova.students.itmo.point.KarmaPoint;

import java.util.ArrayList;
import java.util.List;

import static net.sf.xfresh.core.xml.Xmler.attribute;
import static net.sf.xfresh.core.xml.Xmler.tag;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 07.03.11 2:34
 */
public class UserKarmaPointsYalet extends AbstractPointsYalet {
    private static final Logger log = Logger.getLogger(UserKarmaPointsYalet.class);

    @Override
    public void process(final InternalRequest req, final InternalResponse res) {
        try {
            final long termId = Long.parseLong(req.getParameter("term"));
            final String studentIdAsStr = req.getParameter("student");
            final long studentId = studentIdAsStr == null ? 0 : Long.parseLong(studentIdAsStr);
            final List<KarmaPoint> points = pointsService.getStudentsKarmaPoints(termId);

            final List<Tagable> tags = new ArrayList<Tagable>(points.size());
            for (final KarmaPoint point : points) {
                if (studentId > 0) {
                    if (point.getUserId() != studentId) {
                        continue;
                    }
                }
                tags.add(
                        tag("point",
                                attribute("karma-id", point.getKarmaId()),
                                tag("user-id", Long.toString(point.getUserId())),
                                tag("lesson-id", Long.toString(point.getLessonId())),
                                tag("task-id", Long.toString(point.getTaskId())),
                                tag("creation-time", point.getTime())
                        )
                );
            }

            res.add(tag("karma-points", tags));
        } catch (Exception e) {
            log.error("", e);
            res.add(tag("karma-points"));
        }
    }
}
