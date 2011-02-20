<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="../common.xsl"/>

    <xsl:template match="page" mode="content">
        <h2>Как работать с subversion (IntellijIdea)</h2>
        <h3>Шаг 1. Загрузка проекта</h3>
        <ol>
            <li>Открываем IntellijIdea</li>
            <li>Заходим в меню Version Control > Checkout from Version Control > Subversion</li>
            <li>Жмём на плюсик после слова Repositories</li>
            <li>Прописываем урл до репозитория:</li>
<pre>
    svn://obolshakova.ru/test
</pre>
            <li>Жмём ОК</li>
            <li>Выбираем в списке строчку с нашим репозиторием и нажимаем кнопку Checkout</li>
            <li>Дальше будет предложено выбрать каталог, в который будет выгружен проект. Выбираем каталог, жмём ОК.</li>
            <li>Выбираем формат: 1.6</li>
            <li>IntellijIdea предложит открыть проект и создать структуру каталогов (в том числе создаст директорию src,
                которую пометит как "директория с исходными кодами". Со всем соглашаемся.</li>
            <li>После того, как проект откроется, можно создавать пакеты. Жмём правой
                клавишей мыши на каталог src. New > Package</li>
            <li>Вводим названия пакетов:</li>
<pre>
    ru.ifmo.enf.obolshakova.t02
</pre>
            <li>Далее жмём правой клавишей на созданном пакете и выбираем New -> Java Class</li>
            <li>Создаём класс HelloWorld</li>
<pre>
    package ru.enf.ifmo.obolshakova.t02;

    public class HelloWorld {
        public static void main(String[] args) {
            System.out.println("Hello, world!");
        }
    }
</pre>
            <li>Осталось это сложить в svn (закоммитить)</li>
        </ol>
        <h3>Шаг 2. Коммит</h3>
        <ol>
            <li>Жмём правой кнопкой на каталоге src (слева в структуре проекта). Выбираем Subversion > Add. <br/>Если пункта меню Subversion нет, то делаем следующее:</li>
            <ol>
                <li>File > Settings > Version Control</li>
                <li>В строке &lt;Project Root&gt; справа выбираем Subversion</li>
                <li>Жмём ОК. Теперь пункт меню Subversion при нажатии правой клавишей на src должен появиться</li>
            </ol>
            <li>Все файлы стали выделяться зелёным цветом</li>
            <li>Жмём Alt + 9. Внизу разворачивается окошко Changes</li>
            <li>Раскрываем "Default" и видим все файлы и каталоги, которые будут добавлены.
                Здесь зелёным цветом выделяются добавляемые файлы, синим — обновлённые.</li>
            <li>Жмём правой кнопкой мыши на слове Default и выбираем Commit Changes</li>
            <li>Далее будет предложено написать комментарий и нажать кнопку "Commit"</li>
            <li>Коммит состоялся</li>
        </ol>
        <h4>hint:</h4>
        <ul>
            <li>
                Все файлы, которые лежат у Вас локально и не находятся под контролем версий,
                помечены коричневым цветом (в структуре проекта слева).
            </li>
            <li>
                Все файлы, которые при коммите будут добавлены,
                помечены зелёным цветом.
            </li>
            <li>
                Все файлы, которые при коммите будут обновлены,
                помечены синим цветом.
            </li>
            <li>
                Данная раскраска актуальна и для окна "changes", которое доступно по Alt + 9.
            </li>
        </ul>
        <h3>Шаг 3. Если напутали со структурой пакетов</h3>
        <div>
            Если на предыдущем шаге мы что-то напутали со структурой пакетов и
            закоммитили не то, то самый простой способ на данном этапе — это удалить
            неверные пакеты, закоммитить удаление, а потом сделать всё заново.
        </div>
        <div>
            Рассмотрим следующий пример: допустим, выполняя инструкцию по шагам, мы забыли заменить
            в структуре пакетов "obolshakova" на свою фамилию.
        </div>
        <ol>
            <li>
                Жмём правой клавишей на каталоге src > New > Package. Забиваем туда ru.ifmo.enf.pupkin.t02
                (не забываем в этот раз написать свою фамилию!!!).
            </li>
            <li>
                На классе HelloWorld нажимаем правой клавишей > Cut
            </li>
            <li>
                Нажимаем правой клавишей на пакете pupkin.t02 > Paste
            </li>
            <li>
                Кликаем правой клавишей на пакете obolshakova.t02 > Delete
            </li>
            <li>
                На все предложения логировать действия в svn соглашаемся (жмём yes)
            </li>
            <li>
                Жмём Alt + 9. Видим в списке изменений:
            </li>
<pre>
    HelloWorld — синим цветом, moved from ../obolshakova/t02/HelloWorld.java
    obolshakova — серым цветом (каталог)
    pupkin — зелёным цветом (каталог)
    t02 — зелёным цветом (каталог)
    t02 — серым цветом (каталог)
</pre>
            <li>
                Жмём правой кнопкой на Default > Commit Changes... Дальше всё как раньше.
            </li>

        </ol>
        <h4>hint:</h4>
        <ul>
            <li>
                Если Вы напутали с самыми верхними каталогами, то стоит на самом верхнем каталоге
                выполнить удаление, затем произвести коммит, а уже после сделать всё с нуля.
            </li>
        </ul>

        <div class="empty">&#160;</div>
    </xsl:template>

    <xsl:template name="additional-header">
        <link type="text/css" rel="stylesheet" href="../notes.css"/>
        <link type="text/css" rel="stylesheet" href="../list.css"/>
        <style type="text/css">
            div#content div {margin-bottom:12px;}
        </style>
    </xsl:template>

</xsl:stylesheet>