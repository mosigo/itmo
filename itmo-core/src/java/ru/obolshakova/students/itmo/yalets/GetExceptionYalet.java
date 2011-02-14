package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import net.sf.xfresh.core.Yalet;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 13.02.11 20:08
 */
public class GetExceptionYalet implements Yalet {

    public void process(final InternalRequest req, final InternalResponse res) {
        throw new RuntimeException("Failed");
    }
}
