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
            <li>После того, как проект откроется, можно создавить пакеты. Жмём правой
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