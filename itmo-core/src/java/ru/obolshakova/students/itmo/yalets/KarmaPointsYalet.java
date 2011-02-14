package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import net.sf.xfresh.core.Yalet;
import net.sf.xfresh.core.xml.Xmler;
import static net.sf.xfresh.core.xml.Xmler.tag;
import org.springframework.beans.factory.annotation.Required;
import ru.obolshakova.students.itmo.karma.KarmaItem;
import ru.obolshakova.students.itmo.karma.KarmaService;

import java.util.ArrayList;
import java.util.List;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 07.01.11 22:51
 */
public class KarmaPointsYalet implements Yalet {

    private KarmaService karmaService;

    @Required
    public void setKarmaService(final KarmaService karmaService) {
        this.karmaService = karmaService;
    }

    public void process(final InternalRequest req, final InternalResponse res) {
        res.add(Xmler.tag("karma-items", buildTags(karmaService.loadItems())));
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
