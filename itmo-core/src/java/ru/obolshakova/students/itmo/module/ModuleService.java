package ru.obolshakova.students.itmo.module;

import java.util.List;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 12.02.11 2:16
 */
public interface ModuleService {

    List<Module> getModules(long termId);

}
