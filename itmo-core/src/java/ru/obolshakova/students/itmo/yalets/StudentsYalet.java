package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import net.sf.xfresh.core.Yalet;
import net.sf.xfresh.core.xml.Tagable;
import ru.obolshakova.students.itmo.user.UserInfo;

import java.util.ArrayList;
import java.util.List;

import static net.sf.xfresh.core.xml.Xmler.attribute;
import static net.sf.xfresh.core.xml.Xmler.tag;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 14.02.11 0:21
 */
public class StudentsYalet extends AbstractUserYalet {

    public void process(final InternalRequest req, final InternalResponse res) {
        final long termId;
        try {
            termId = Long.parseLong(req.getParameter("term"));
        } catch (NumberFormatException e) {
            res.add(tag("students"));
            return;
        }
        final List<UserInfo> students = userService.getAllStudents(termId);
        final List<Tagable> tags = new ArrayList<Tagable>(students.size());
        for (final UserInfo student : students) {
            tags.add(tag("student", attribute("id", student.getUserId()), student.getName()));
        }
        res.add(tag("students", tags));
    }
}
