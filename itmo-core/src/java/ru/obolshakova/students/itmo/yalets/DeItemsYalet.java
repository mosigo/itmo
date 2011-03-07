package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import net.sf.xfresh.core.xml.Tagable;
import org.apache.log4j.Logger;
import ru.obolshakova.students.itmo.point.DeItem;

import java.util.ArrayList;
import java.util.List;

import static net.sf.xfresh.core.xml.Xmler.attribute;
import static net.sf.xfresh.core.xml.Xmler.tag;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 06.03.11 17:21
 */
public class DeItemsYalet extends AbstractPointsYalet {
    private static final Logger log = Logger.getLogger(DeItemsYalet.class);

    @Override
    public void process(final InternalRequest req, final InternalResponse res) {
        try {
            final long termId = Long.parseLong(req.getParameter("term"));
            final List<DeItem> deItems = pointsService.getDeItems(termId);

            final List<Tagable> tags = new ArrayList<Tagable>(deItems.size());
            for (final DeItem deItem : deItems) {
                tags.add(
                        tag("de-item",
                                attribute("id", deItem.getId()),
                                tag("description", deItem.getName()),
                                tag("module-id", Integer.toString(deItem.getModuleId())),
                                tag("point-cnt", Integer.toString(deItem.getPointCnt())),
                                tag("used-point-cnt", Integer.toString(deItem.getUsedPointCnt()))
                        )
                );
            }

            res.add(tag("de-items", tags));
        } catch (Exception e) {
            res.add(tag("de-items"));
            log.error("", e);
        }
    }
}
