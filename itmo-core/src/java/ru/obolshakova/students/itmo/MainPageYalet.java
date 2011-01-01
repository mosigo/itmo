package ru.obolshakova.students.itmo;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import net.sf.xfresh.core.Yalet;

/**
 * Author: Olga Bolshakova (o.bolshakova@yandex.ru)
 * Date: 01.01.2011 19:19:48
 */
public class MainPageYalet implements Yalet {

    public void process(final InternalRequest req, final InternalResponse res) {
        res.add("Здесь скоро будет сайт :)");
    }
}
