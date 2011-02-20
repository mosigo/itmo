package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.xml.Tagable;
import ru.obolshakova.students.itmo.user.UserTaskPoints;

import static net.sf.xfresh.core.xml.Xmler.tag;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 20.02.11 20:30
 */
public class YaletXmlUtils {

    public static Tagable studentTaskPoints(final UserTaskPoints point) {
        return tag(
                "student-task-point",
                tag("student-id", Long.toString(point.getUserId())),
                tag("task-id", Integer.toString(point.getTaskId())),
                tag("point-cnt", Integer.toString(point.getPointCnt())),
                tag("karma-cnt", Integer.toString(point.getKarmaCnt())),
                tag("status", Integer.toString(point.getStatus().getCode()))
        );
    }
}
