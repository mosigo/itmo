package ru.obolshakova.students.itmo.module;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 12.02.11 2:16
 */
public class Module {

    private final int id;
    private final String name;

    public Module(final int id, final String name) {
        this.id = id;
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }
}
