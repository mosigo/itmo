package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import ru.obolshakova.students.itmo.user.UserInfo;

import static net.sf.xfresh.core.xml.Xmler.attribute;
import static net.sf.xfresh.core.xml.Xmler.tag;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 19.02.11 3:05
 */
public class UserInfoYalet extends AbstractUserYalet {

    public void process(final InternalRequest req, final InternalResponse res) {
        final long userId = Long.parseLong(req.getParameter("user-id"));
        final UserInfo userInfo = userService.getUserInfo(userId);
        if (userInfo == null) {
            res.add(tag("user-info"));
            return;
        }
        res.add(tag("user-info", attribute("id", userInfo.getUserId()), userInfo.getName()));
    }
}
