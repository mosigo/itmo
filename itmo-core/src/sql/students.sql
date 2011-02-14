CREATE DATABASE itmo CHARACTER SET utf8;

USE itmo;

set character set utf8;

CREATE TABLE user_role (
    id                    INTEGER           PRIMARY KEY
  , descr                 VARCHAR(256)
) ENGINE = INNODB character set utf8;

INSERT INTO user_role (id, descr) VALUES (1, 'студент');
INSERT INTO user_role (id, descr) VALUES (2, 'лектор');
INSERT INTO user_role (id, descr) VALUES (3, 'админ');

CREATE TABLE user_info (
    user_id               INTEGER           PRIMARY KEY
  , name                  VARCHAR(256)
  , role_id               INTEGER
  , FOREIGN KEY (role_id) REFERENCES user_role(id)
) ENGINE = INNODB character set utf8;

insert into user_info (user_id, name, role_id) values (1, 'Ольга Большакова', 3);
insert into user_info (user_id, name, role_id) values (2, 'Александр Кубенский', 2);
insert into user_info (user_id, name, role_id) values (3, 'Павел Кузнецов', 1);
insert into user_info (user_id, name, role_id) values (4, 'Василий Андрианов', 1);
insert into user_info (user_id, name, role_id) values (5, 'Кирилл Богданов', 1);
insert into user_info (user_id, name, role_id) values (6, 'Ярослав Давыдчик', 1);
insert into user_info (user_id, name, role_id) values (7, 'Александр Донской', 1);
insert into user_info (user_id, name, role_id) values (8, 'Алексей Дудко', 1);
insert into user_info (user_id, name, role_id) values (9, 'Анна Евстафьева', 1);
insert into user_info (user_id, name, role_id) values (10, 'Алексей Гусаров', 1);
insert into user_info (user_id, name, role_id) values (11, 'Виктория Киреева', 1);
insert into user_info (user_id, name, role_id) values (12, 'Максим Лосевской', 1);
insert into user_info (user_id, name, role_id) values (13, 'Михаил Мельник', 1);
insert into user_info (user_id, name, role_id) values (14, 'Ксения Мухина', 1);
insert into user_info (user_id, name, role_id) values (15, 'Татьяна Румянцева', 1);
insert into user_info (user_id, name, role_id) values (16, 'Никита Рыбкин', 1);
insert into user_info (user_id, name, role_id) values (17, 'Алексей Владиев', 1);
insert into user_info (user_id, name, role_id) values (18, 'Максим Зайцев', 1);
insert into user_info (user_id, name, role_id) values (19, 'Сергей Фёдоров', 1);

--семестр
CREATE TABLE term (
    id                    INTEGER           PRIMARY KEY
  , descr                 VARCHAR(256)
  , active                INTEGER           DEFAULT 0
) ENGINE = INNODB character set utf8;

INSERT INTO term (id, descr) VALUES (1, 'Осень 2010');
INSERT INTO term (id, descr, active) VALUES (2, 'Зима 2011', 1);

CREATE TABLE user_term (
    user_id               INTEGER           PRIMARY KEY
  , term_id               INTEGER
  , FOREIGN KEY (user_id) REFERENCES user_info(user_id)
  , FOREIGN KEY (term_id) REFERENCES term(id)
) ENGINE = INNODB character set utf8;

insert into user_term (user_id, term_id) values (3, 2);
insert into user_term (user_id, term_id) values (4, 2);
insert into user_term (user_id, term_id) values (5, 2);
insert into user_term (user_id, term_id) values (6, 2);
insert into user_term (user_id, term_id) values (7, 2);
insert into user_term (user_id, term_id) values (8, 2);
insert into user_term (user_id, term_id) values (9, 2);
insert into user_term (user_id, term_id) values (10, 2);
insert into user_term (user_id, term_id) values (11, 2);
insert into user_term (user_id, term_id) values (12, 2);
insert into user_term (user_id, term_id) values (13, 2);
insert into user_term (user_id, term_id) values (14, 2);
insert into user_term (user_id, term_id) values (15, 2);
insert into user_term (user_id, term_id) values (16, 2);
insert into user_term (user_id, term_id) values (17, 2);
insert into user_term (user_id, term_id) values (18, 2);
insert into user_term (user_id, term_id) values (19, 2);

CREATE TABLE term_module (
    id                    INTEGER           PRIMARY KEY
  , term_id               INTEGER
  , descr                 VARCHAR(256)
  , FOREIGN KEY (term_id) REFERENCES term(id)
) ENGINE = INNODB character set utf8;

INSERT INTO term_module (id, term_id, descr) VALUES (1, 1, 'Модуль 1');
INSERT INTO term_module (id, term_id, descr) VALUES (2, 1, 'Модуль 2');
INSERT INTO term_module (id, term_id, descr) VALUES (3, 1, 'Экзамен');

INSERT INTO term_module (id, term_id, descr) VALUES (4, 2, 'Модуль 3');
INSERT INTO term_module (id, term_id, descr) VALUES (5, 2, 'Модуль 4');
INSERT INTO term_module (id, term_id, descr) VALUES (6, 2, 'Экзамен');

CREATE TABLE de_item (
    id                    INTEGER           PRIMARY KEY
  , module_id             INTEGER
  , descr                 VARCHAR(256)
  , point_cnt             INTEGER
  , FOREIGN KEY (module_id) REFERENCES term_module(id)
) ENGINE = INNODB character set utf8;

INSERT INTO de_item (id, module_id, descr, point_cnt) VALUES (1, 1, 'Посещение лекций', 9);
INSERT INTO de_item (id, module_id, descr, point_cnt) VALUES (2, 1, 'Выполнение л.р.', 6);
INSERT INTO de_item (id, module_id, descr, point_cnt) VALUES (3, 1, 'Защита л.р.', 16);
INSERT INTO de_item (id, module_id, descr, point_cnt) VALUES (4, 1, 'Тестирование', 11);

INSERT INTO de_item (id, module_id, descr, point_cnt) VALUES (5, 2, 'Посещение лекций', 8);
INSERT INTO de_item (id, module_id, descr, point_cnt) VALUES (6, 2, 'Выполнение л.р.', 6);
INSERT INTO de_item (id, module_id, descr, point_cnt) VALUES (7, 2, 'Защита л.р.', 18);
INSERT INTO de_item (id, module_id, descr, point_cnt) VALUES (8, 2, 'Тестирование', 6);

INSERT INTO de_item (id, module_id, descr, point_cnt) VALUES (9, 3, 'Экзамен', 20);

INSERT INTO de_item (id, module_id, descr, point_cnt) VALUES (10, 4, '[ЯП] Тестирование', 10);
INSERT INTO de_item (id, module_id, descr, point_cnt) VALUES (11, 4, '[ЯП] Лабораторные работы', 20);
INSERT INTO de_item (id, module_id, descr, point_cnt) VALUES (12, 4, '[ЯП] Личностные качества', 12);
INSERT INTO de_item (id, module_id, descr, point_cnt) VALUES (14, 4, '[ЭВМ] Тестирование', 10);
INSERT INTO de_item (id, module_id, descr, point_cnt) VALUES (15, 4, '[ЭВМ] Выполнение и защита лабораторных работ', 20);
INSERT INTO de_item (id, module_id, descr, point_cnt) VALUES (16, 4, '[ЭВМ] Работа на лабораторных занятиях', 12);
INSERT INTO de_item (id, module_id, descr, point_cnt) VALUES (17, 4, '[ЭВМ] Контрольная работа', 11);

INSERT INTO de_item (id, module_id, descr, point_cnt) VALUES (18, 5, '[ЯП] Тестирование', 10);
INSERT INTO de_item (id, module_id, descr, point_cnt) VALUES (19, 5, '[ЯП] Лабораторные работы', 20);
INSERT INTO de_item (id, module_id, descr, point_cnt) VALUES (20, 5, '[ЯП] Личностные качества', 8);
INSERT INTO de_item (id, module_id, descr, point_cnt) VALUES (22, 5, '[ЭВМ] Тестирование', 10);
INSERT INTO de_item (id, module_id, descr, point_cnt) VALUES (23, 5, '[ЭВМ] Выполнение и защита лабораторных работ', 20);
INSERT INTO de_item (id, module_id, descr, point_cnt) VALUES (24, 5, '[ЭВМ] Работа на лабораторных занятиях', 8);
INSERT INTO de_item (id, module_id, descr, point_cnt) VALUES (25, 5, '[ЭВМ] Контрольная работа', 9);

INSERT INTO de_item (id, module_id, descr, point_cnt) VALUES (26, 6, 'Экзамен', 20);

CREATE TABLE task (
    id                    INTEGER           AUTO_INCREMENT          PRIMARY KEY
  , module_id             INTEGER
  , module_npp            INTEGER
  , name                  VARCHAR(256)
  , type                  INTEGER
  , body_html             VARCHAR(4000)
  , homework              INTEGER
  , hidden                INTEGER           DEFAULT 0
  , FOREIGN KEY (module_id) REFERENCES term_module(id)
) ENGINE = INNODB character set utf8;

CREATE TABLE task_anketa (
    task_id               INTEGER
  , npp                   INTEGER
  , descr                 VARCHAR(4000)
  , FOREIGN KEY (task_id) REFERENCES task(id)
) ENGINE = INNODB character set utf8;

CREATE TABLE task_individual (
    task_id               INTEGER
  , user_id               INTEGER
  , body_html             VARCHAR(4000)
  , FOREIGN KEY (task_id) REFERENCES task(id)
  , FOREIGN KEY (user_id) REFERENCES user_info(user_id)
) ENGINE = INNODB character set utf8;

CREATE TABLE task_point (
    task_id               INTEGER
  , point_cnt             INTEGER
  , de_item_id            INTEGER
  , descr                 VARCHAR(256)
  , FOREIGN KEY (task_id) REFERENCES task(id)
) ENGINE = INNODB character set utf8;

CREATE TABLE task_karma (
    task_id               INTEGER
  , karma_id              INTEGER
  , FOREIGN KEY (task_id) REFERENCES task(id)
) ENGINE = INNODB character set utf8;

insert into task(id, module_id, module_npp, name, type, body_html, homework, hidden)
values (1, 4, 1, 'Связный список', 1, "<div class=""task"">
    Необходимо реализовать указанный ниже интерфейс List. Реализация
    должна представлять собой однонаправленный список, который
    рассматривался на лекции.
    <pre>
    public interface List&lt;E&gt; {

        void add(E elem);

        E get(int index);

        void set(int index, E elem);

        void remove(int index);

        int size();

    }
    </pre>
</div>
<div class=""task"">Реализацию следует назвать MyLinkedList.</div>", 0, 0);

insert into task_point(task_id, point_cnt, de_item_id, descr) values (1, 1, 11, 'показано на занятии (12.02.2011) или выполнено до 17.02.2011 21:00');
insert into task_point(task_id, point_cnt, de_item_id, descr) values (1, 1, 11, 'задание выполнено');

insert into task(id, module_id, module_npp, name, type, body_html, homework, hidden)
values (2, 4, 2, 'Subversion. Hello World.', 1, "<div class=""task"">Необходимо написать класс HelloWorld, выводящий в консоль запись ""Hello, world!"". </div><div class=""task"">Данное задание проверяет способность студента выполнить его в соответствии с требованиями, т.е. код должен быть сложен в систему контроля версий subversion с правильной структурой пакетов. </div>", 1, 0);

insert into task_point(task_id, point_cnt, de_item_id, descr) values (2, 1, 11, 'сдано вовремя (до 17.02.2011 21:00)');
insert into task_point(task_id, point_cnt, de_item_id, descr) values (2, 1, 11, 'задание выполнено');
insert into task_karma(task_id, karma_id) values (2, 1);
insert into task_karma(task_id, karma_id) values (2, 2);
insert into task_karma(task_id, karma_id) values (2, 3);
insert into task_karma(task_id, karma_id) values (2, 7);

insert into task(id, module_id, module_npp, name, type, body_html, homework, hidden)
values (3, 4, 3, 'Список с закладками', 1, "                <div class=""task"">
                    Необходимо реализовать указанный ниже интерфейс List.
                    Реализация должна представлять собой однонаправленный список,
                    который рассматривался на лекции, с дополнительной оптимизацией:
                    список внутри себя должен хранить ссылки на каждый 10-ый элемент.
                    Дополнительные ссылки должны использоваться для более быстрой
                    реализации методов (поиск по индексу не должен проходиться по
                    всем элементам).
                </div>
<pre>
public interface List&lt;E&gt; {

    void add(E elem);

    E get(int index);

    void set(int index, E elem);

    void remove(int index);

    int size();

}
</pre>

                <div class=""task"">
                    Реализацию следует назвать SkipList.
                </div>", 1, 0);

insert into task_point(task_id, point_cnt, de_item_id, descr) values (3, 1, 15, 'сдано вовремя (до 24.02.2011 21:00)');
insert into task_point(task_id, point_cnt, de_item_id, descr) values (3, 1, 15, 'задание выполнено');
insert into task_karma(task_id, karma_id) values (3, 1);
insert into task_karma(task_id, karma_id) values (3, 2);
insert into task_karma(task_id, karma_id) values (3, 3);
insert into task_karma(task_id, karma_id) values (3, 7);

CREATE TABLE karma (
    id                    INTEGER             PRIMARY KEY
  , npp                   INTEGER
  , point_cnt             INTEGER
  , descr                 VARCHAR(256)
) ENGINE = INNODB character set utf8;

INSERT INTO karma (id, npp, point_cnt, descr) VALUES (1, 1, 3, 'прислал задание первым');
INSERT INTO karma (id, npp, point_cnt, descr) VALUES (2, 2, 2, 'прислал задание вторым');
INSERT INTO karma (id, npp, point_cnt, descr) VALUES (3, 3, 1, 'прислал задание третьим');
INSERT INTO karma (id, npp, point_cnt, descr) VALUES (4, 4, 2, 'работа у доски');
INSERT INTO karma (id, npp, point_cnt, descr) VALUES (5, 5, 2, 'задание прислано до общего обсуждения (для тяжёлых задач)');
INSERT INTO karma (id, npp, point_cnt, descr) VALUES (6, 6, 1, 'контрольная работа с первого раза выполнена на максимум');
INSERT INTO karma (id, npp, point_cnt, descr) VALUES (7, 7, 1, 'домашнее задание прислано вовремя');
INSERT INTO karma (id, npp, point_cnt, descr) VALUES (8, 8, 1, 'присутствие на занятии (без опоздания)');
INSERT INTO karma (id, npp, point_cnt, descr) VALUES (9, 9, 1, 'найдена опечатка / ошибка в задании / слайдах');
INSERT INTO karma (id, npp, point_cnt, descr) VALUES (10, 10, 1, 'другое (на усмотрение преподавателя)');
INSERT INTO karma (id, npp, point_cnt, descr) VALUES (11, 11, -3, 'дал списать товарищу');
INSERT INTO karma (id, npp, point_cnt, descr) VALUES (12, 12, -1, 'за каждую неделю просрочки задания (как домашнего, так и требуемого на занятии)');
INSERT INTO karma (id, npp, point_cnt, descr) VALUES (13, 13, -1, 'за каждую неудачную попытку сдать задание, начиная с четвёртой');
INSERT INTO karma (id, npp, point_cnt, descr) VALUES (14, 14, -1, 'отсутствие на занятии по неизвестной преподавателю причине (т.е. по неуважительной)');
INSERT INTO karma (id, npp, point_cnt, descr) VALUES (15, 15, -1, 'не выполнено задание, которое требовалось выполнить на занятии (только в случае, если студент присутствовал)');
INSERT INTO karma (id, npp, point_cnt, descr) VALUES (16, 16, -1, 'плохое поведение на занятии');
INSERT INTO karma (id, npp, point_cnt, descr) VALUES (17, 17, -1, 'другое (на усмотрение преподавателя)');

CREATE TABLE lesson (
    id                    INTEGER              AUTO_INCREMENT        PRIMARY KEY
  , type                  INTEGER
  , name                  INTEGER
) ENGINE = INNODB character set utf8;

INSERT INTO lesson (id, type, name) VALUES (1, 1, '12 февраля 2011, суббота');
INSERT INTO lesson (id, type, name) VALUES (2, 2, '12 февраля 2011, суббота');
INSERT INTO lesson (id, type, name) VALUES (3, 1, '19 февраля 2011, суббота');
INSERT INTO lesson (id, type, name) VALUES (4, 2, '19 февраля 2011, суббота');
INSERT INTO lesson (id, type, name) VALUES (5, 1, '26 февраля 2011, суббота');
INSERT INTO lesson (id, type, name) VALUES (6, 2, '26 февраля 2011, суббота');


CREATE TABLE user_karma (
    user_id               INTEGER
  , karma_id              INTEGER
  , task_id               INTEGER
  , lesson_id             INTEGER
  , creation_time         TIMESTAMP            DEFAULT CURRENT_TIMESTAMP
  , FOREIGN KEY (task_id) REFERENCES task(id)
  , FOREIGN KEY (karma_id) REFERENCES karma(id)
  , FOREIGN KEY (lesson_id) REFERENCES lesson(id)
) ENGINE = INNODB character set utf8;



CREATE TABLE user_point (
    user_id               INTEGER
  , task_id               INTEGER
  , point_cnt             INTEGER
  , de_item_id            INTEGER
  , creation_time         TIMESTAMP            DEFAULT CURRENT_TIMESTAMP
  , FOREIGN KEY (task_id) REFERENCES task(id)
  , FOREIGN KEY (de_item_id) REFERENCES de_item(id)
) ENGINE = INNODB character set utf8;

GRANT ALL PRIVILEGES ON itmo.* TO itmo@'%' IDENTIFIED BY 'itmo' WITH GRANT OPTION;


