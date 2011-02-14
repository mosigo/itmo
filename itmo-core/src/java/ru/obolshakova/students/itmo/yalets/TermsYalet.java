package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import net.sf.xfresh.core.Yalet;
import net.sf.xfresh.core.xml.Xmler;
import org.springframework.beans.factory.annotation.Required;
import ru.obolshakova.students.itmo.term.Term;
import ru.obolshakova.students.itmo.term.TermService;

import java.util.ArrayList;
import java.util.List;

import static net.sf.xfresh.core.xml.Xmler.attribute;
import static net.sf.xfresh.core.xml.Xmler.tag;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 30.01.11 21:03
 */
public class TermsYalet implements Yalet {

    private TermService termService;

    @Required
    public void setTermService(final TermService termService) {
        this.termService = termService;
    }

    public void process(final InternalRequest req, final InternalResponse res) {
        final List<Term> terms = termService.loadTerms();

        res.add(convertToTag(terms));
    }

    private Xmler.Tag convertToTag(final List<Term> terms) {
        final List<Xmler.Tag> termTags = new ArrayList<Xmler.Tag>(terms.size());
        for (final Term term : terms) {
            termTags.add(tag("term", attribute("id", term.getId()).and("active", term.isActive() ? "1" : "0"), tag("description", term.getName())));
        }
        return tag("terms", termTags);
    }
}
