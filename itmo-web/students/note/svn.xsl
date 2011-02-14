<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="../common.xsl"/>

    <xsl:template match="page" mode="content">
        <h2>Как работать с subversion (консоль)</h2>
        <div>
            Данное описание только для тех, кто пользуется ОС linux
            (на примере ubuntu, хотя должно работать в любой debian-подобной системе).
        </div>
        <div>
            Возможно, в первое время стоит работать с svn из IntellijIdea,
            это может показаться чуть-чуть проще. Описанный здесь способ является
            незавимым от IntellijIdea.
        </div>
        <div>
            Если у Вас windows, то как установить subversion предлагается выяснить самостоятельно.
            Можно пойти более <a href="svn2.xml">простым путём</a> и делать всё из IntellijIdea, в этом
            случае не потребуется устанавливать subversion дополнительно.
        </div>
        <h3>Шаг 1. Установка</h3>
        <ol>
            <li>Выполняем набор команд:</li>
<pre>
    sudo apt-get update
    sudo apt-get install subversion
</pre>
        </ol>
        <h3>Шаг 2. Загрузка проекта</h3>
        <ol>
            <li>Идём в каталог, где хотим держать исходные коды:</li>
<pre>
    cd /home/obolshakova
    mkdir svn
    cd svn
</pre>
            <li>Выгружаем проект из svn (здесь username и password должны быть Ваши):</li>
<pre>
    svn co --username obolshakova --password test svn://obolshakova.ru/test
</pre>
            <li>В текущей директории появился каталог test:</li>
<pre>
    ls
    > test
    cd test
</pre>
            <li>В этом каталоге нужно создать проект IntellijIdea с заданной структурой пакетов.</li>
        </ol>
        <h3>Шаг 3. Коммит исходного кода</h3>
        <ol>
            <li>Создаём структуру каталогов:</li>
<pre>
    mkdir -p src/ru/enf/ifmo/obolshakova/t02
</pre>
            <li>Создаём в каталоге src/ru/enf/ifmo/obolshakova/t00 файл HelloWorld.java</li>
<pre>
    package ru.enf.ifmo.obolshakova.t02;

    public class HelloWorld {
        public static void main(String[] args) {
            System.out.println("Hello, world!");
        }
    }
</pre>
            <li>Складываем его в svn:</li>
<pre>
    svn add src
    > A         src
    > A         src/ru
    > A         src/ru/enf
    > A         src/ru/enf/ifmo
    > A         src/ru/enf/ifmo/obolshakova
    > A         src/ru/enf/ifmo/obolshakova/t02
    > A         src/ru/enf/ifmo/obolshakova/t02/HelloWorld.java
    svn ci -m "Task 02"
</pre>
            <li>Первый коммит состоялся!</li>
        </ol>

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