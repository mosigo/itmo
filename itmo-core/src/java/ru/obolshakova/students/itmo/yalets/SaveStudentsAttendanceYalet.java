package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import org.apache.log4j.Logger;
import ru.obolshakova.students.itmo.user.AttendanceType;
import ru.obolshakova.students.itmo.user.UserAttendance;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 06.03.11 18:52
 */
public class SaveStudentsAttendanceYalet extends AbstractUserYalet {
    private static final Logger log = Logger.getLogger(SaveStudentsAttendanceYalet.class);

    @Override
    public void process(final InternalRequest req, final InternalResponse res) {
        if (req.getUserId() == null || req.getUserId() != 1L && req.getUserId() != 2) {
            log.info("user is not admin");
            return;
        }
        log.info("all params => {" + req.getAllParameters() + "}");
        final int lessonId = Integer.parseInt(req.getParameter("lesson-id"));
        final List<UserAttendance> result = new ArrayList<UserAttendance>();
        for (final Map.Entry<String, List<String>> entry : req.getAllParameters().entrySet()){
            final String paramName = entry.getKey();
            if (paramName.startsWith("user-")) {
                final String[] parts = paramName.split("-");
                final long userId = Long.parseLong(parts[1]);
                final AttendanceType attendanceType = AttendanceType.byCode(Integer.parseInt(entry.getValue().get(0)));
                result.add(new UserAttendance(userId, lessonId, attendanceType));
            }
        }
        userService.saveStudentsAttendance(result);
    }
}
