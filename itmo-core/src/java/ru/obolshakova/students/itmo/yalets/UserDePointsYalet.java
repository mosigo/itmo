package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import net.sf.xfresh.core.xml.Tagable;
import ru.obolshakova.students.itmo.user.DePoint;
import ru.obolshakova.students.itmo.user.UserDePoints;

import java.util.ArrayList;
import java.util.List;

import static net.sf.xfresh.core.xml.Xmler.attribute;
import static net.sf.xfresh.core.xml.Xmler.tag;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 06.03.11 17:54
 */
public class UserDePointsYalet extends AbstractPointsYalet {

    @Override
    public void process(final InternalRequest req, final InternalResponse res) {
        final long termId = Long.parseLong(req.getParameter("term"));

        final List<UserDePoints> studentsDePoints = pointsService.getStudentsDePoints(termId);

        final List<Tagable> tags = new ArrayList<Tagable>(studentsDePoints.size());
        for (final UserDePoints point : studentsDePoints) {
            final List<DePoint> items = point.getItems();
            final List<Tagable> deItems = new ArrayList<Tagable>(items.size());
            for (final DePoint item : items) {
                deItems.add(
                        tag("item",
                                attribute("id", item.getDeItemId()),
                                tag("points", Integer.toString(item.getPointCnt()))
                        )
                );
            }
            tags.add(
                    tag("point",
                            tag("user-id", Long.toString(point.getUserId())),
                            tag("de-items", deItems)
                    )
            );
        }

        res.add(tag("user-de-points", tags));
    }
}
