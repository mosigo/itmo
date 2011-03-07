package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import net.sf.xfresh.core.xml.Xmler;
import ru.obolshakova.students.itmo.point.KarmaItem;

import java.util.ArrayList;
import java.util.List;

import static net.sf.xfresh.core.xml.Xmler.tag;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 07.01.11 22:51
 */
public class KarmaPointsYalet extends AbstractPointsYalet {

    public void process(final InternalRequest req, final InternalResponse res) {
        res.add(Xmler.tag("karma-items", buildTags(pointsService.loadKarmaItems())));
    }

    private List<Xmler.Tag> buildTags(final List<KarmaItem> items) {
        final List<Xmler.Tag> tags = new ArrayList<Xmler.Tag>(items.size());
        for (final KarmaItem item : items) {
            tags.add(
                    tag("item",
                            tag("id", Integer.toString(item.getId())),
                            tag("point-cnt", Integer.toString(item.getPointCnt())),
                            tag("description", item.getDescription())
                    )
            );
        }
        return tags;
    }
}
