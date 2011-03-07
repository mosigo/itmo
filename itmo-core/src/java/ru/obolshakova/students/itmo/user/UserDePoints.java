package ru.obolshakova.students.itmo.user;

import java.util.ArrayList;
import java.util.List;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 06.03.11 16:45
 */
public class UserDePoints {

    private final long userId;
    private final List<DePoint> items = new ArrayList<DePoint>(10);

    public UserDePoints(final long userId) {
        this.userId = userId;
    }

    public UserDePoints(final long userId, final List<DePoint> items) {
        this.userId = userId;
        this.items.addAll(items);
    }

    public void addItem(final DePoint item) {
        this.items.add(item);
    }

    public long getUserId() {
        return userId;
    }

    public List<DePoint> getItems() {
        return items;
    }
}
