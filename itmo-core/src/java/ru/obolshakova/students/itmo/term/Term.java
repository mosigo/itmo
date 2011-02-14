package ru.obolshakova.students.itmo.term;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 30.01.11 21:04
 */
public class Term {

    private long id;
    private final String name;
    private boolean active;

    public Term(final long id, final String name, final boolean active) {
        this.id = id;
        this.name = name;
        this.active = active;
    }

    public Term(final String name) {
        this.name = name;
    }

    public void setId(final long id) {
        this.id = id;
    }

    public long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public boolean isActive() {
        return active;
    }
}
