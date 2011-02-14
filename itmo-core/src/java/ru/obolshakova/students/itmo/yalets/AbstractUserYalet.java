package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.Yalet;
import org.springframework.beans.factory.annotation.Required;
import ru.obolshakova.students.itmo.user.UserService;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 14.02.11 2:36
 */
abstract class AbstractUserYalet implements Yalet {

    protected UserService userService;

    @Required
    public void setUserService(final UserService userService) {
        this.userService = userService;
    }

}
