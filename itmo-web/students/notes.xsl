<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="common.xsl"/>

    <xsl:template match="page" mode="content">
        <h2>Теоретический материал</h2>
        <h3>Руководства</h3>
        <ol>
            <li>
                <div><a href="note/java-install-1.xml">Как установить Java на Ваш компьютер</a></div>
                <a href="note/java-install-2.xml">Как установить и настроить Intellij Idea</a>
            </li>
            <li>
                <div><a href="note/hello-world-1.xml">Как скомпилировать и запустить Java-программу из консоли</a></div>
                <a href="note/hello-world-2.xml">Как скомпилировать и запустить Java-программу из Intellij Idea</a>
            </li>
            <li>
                <a href="note/requirements.xml">Требования к присылаемому коду</a>
            </li>
            <li>
                <div><a href="note/svn.xml">Как работать с subversion (консоль)</a></div>
                <a href="note/svn2.xml">Как работать с subversion (IntellijIdea)</a>
            </li>
        </ol>
        <h3>Слайды</h3>
        <ol>
            <li><a href="pdf/01.pdf">Слайды про примитивные типы, инкремент, строки, массивы и циклы</a></li>
            <li><a href="pdf/02.pdf">Cтроки, массивы, циклы. Требования к коду.</a></li>
            <li><a href="pdf/03.pdf">Решето Эратосфена</a></li>
            <li><a href="pdf/04.pdf">Круглые простые числа</a></li>
            <li><a href="pdf/05.pdf">Циклы</a></li>
            <li><a href="pdf/06.pdf">Быстрое возведение в степень</a></li>
            <li><a href="pdf/07.pdf">Сортировка "пузырьком"</a></li>
            <li><a href="pdf/08.pdf">Требования к коду — упрощённые конструкции</a></li>
            <li><a href="pdf/09.pdf">Упаковка бинарного дерева в массив</a></li>
            <li><a href="pdf/10.pdf">Двоичное дерево поиска</a></li>
            <li><a href="pdf/11.pdf">Классы — первые шаги</a></li>
        </ol>

        <h3>Примеры кода</h3>
        <ol>
            <li><a href="code/01_strings_and_arrays.zip">Строки и массивы</a></li>
        </ol>

        <h3>Контрольные работы</h3>
        <ol>
            <li><a href="test/t01.pdf">Контрольная работа №1 (строки и массивы)</a></li>
        </ol>

        <div class="empty">&#160;</div>
    </xsl:template>

    <xsl:template name="additional-header">
        <link type="text/css" rel="stylesheet" href="list.css"/>
        <style type="text/css">
            li div {margin-bottom:6px;}
        </style>
    </xsl:template>

</xsl:stylesheet>
