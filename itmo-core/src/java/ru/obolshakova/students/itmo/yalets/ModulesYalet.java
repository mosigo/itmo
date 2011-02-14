package ru.obolshakova.students.itmo.yalets;

import net.sf.xfresh.core.InternalRequest;
import net.sf.xfresh.core.InternalResponse;
import net.sf.xfresh.core.Yalet;
import net.sf.xfresh.core.xml.Tagable;
import org.springframework.beans.factory.annotation.Required;
import ru.obolshakova.students.itmo.module.Module;
import ru.obolshakova.students.itmo.module.ModuleService;

import java.util.ArrayList;
import java.util.List;

import static net.sf.xfresh.core.xml.Xmler.attribute;
import static net.sf.xfresh.core.xml.Xmler.tag;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 12.02.11 2:21
 */
public class ModulesYalet implements Yalet {

    private ModuleService moduleService;

    @Required
    public void setModuleService(final ModuleService moduleService) {
        this.moduleService = moduleService;
    }

    public void process(final InternalRequest req, final InternalResponse res) {
        final long termId;
        try {
            termId = Long.parseLong(req.getParameter("term"));
        } catch (NumberFormatException e) {
            res.add(tag("modules"));
            return;
        }
        final List<Module> modules = moduleService.getModules(termId);
        final List<Tagable> tags = new ArrayList<Tagable>(modules.size());
        for (final Module module : modules) {
            tags.add(
                    tag("module",
                            attribute("id", module.getId()),
                            tag("name", module.getName())
                    )
            );
        }
        res.add(tag("modules", tags));
    }
}
