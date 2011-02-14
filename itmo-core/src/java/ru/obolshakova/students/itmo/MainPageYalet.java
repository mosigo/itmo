package ru.obolshakova.students.itmo;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import net.sf.xfresh.core.SelfWriter;
import net.sf.xfresh.core.Yalet;
import net.sf.xfresh.core.xml.Xmler;
import org.xml.sax.ContentHandler;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

/**
 * Author: Olga Bolshakova (o.bolshakova@yandex.ru)
 * Date: 01.01.2011 19:19:48
 */
public class MainPageYalet implements Yalet {

    public void process(final InternalRequest req, final InternalResponse res) {
        System.out.println(req.getAllParameters());
        res.add(Xmler.tag("blabla", "здесь скоро будет сайт с нормальным xml-ем"));
        res.add(Xmler.tag("string", "здесь скоро будет сайт с нормальным xml-ем"));
    }
}
