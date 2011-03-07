package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import org.apache.log4j.Logger;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 07.03.11 15:06
 */
public class WeeklyKarmaYalet extends AbstractPointsYalet {
    private static final Logger log = Logger.getLogger(WeeklyKarmaYalet.class);

    @Override
    public void process(final InternalRequest req, final InternalResponse res) {
        if (req.getUserId() == null || req.getUserId() != 1L) {
            log.info("user is not admin");
            return;
        }
        log.info("all params => {" + req.getAllParameters() + "}");

        final long taskId = Long.parseLong(req.getParameter("task-id"));
        pointsService.weeklyKarma(taskId);
    }
}
