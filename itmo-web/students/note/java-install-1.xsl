<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="../common.xsl"/>

    <xsl:template match="page" mode="content">
        <h2>Как установить Java на Ваш компьютер</h2>

        <h3>Если у вас linux (на примере ubuntu, хотя должно работать в любой debian-подобной системе)</h3>
        <ol>
            <li>Если у Вас unubtu версии 10.04, то необходимо добавить репозиторий
                (до версии 10.04 этот шаг не нужен):</li>
            <pre>sudo add-apt-repository "deb http://archive.canonical.com/ lucid partner"</pre>
            <li>Выполняем набор команд:</li>
<pre>
    sudo apt-get update
    sudo apt-get install sun-java6-jdk
    sudo apt-get install sun-java6-source
</pre>
        </ol>
        <h3>Если у Вас windows</h3>
        <ol>
            <li>
                Загружаем с сайта java.sun.com .exe-файл установки:
                http://www.oracle.com/technetwork/java/javase/downloads/jdk6-jsp-136632.html
            </li>
            <li>Запускаем загруженный файл.</li>
            <li>
                Неплохо добавить путь к java в переменные среды:
                Панель управления -> Система -> Дополнительно -> Переменные среды.
                Там нужно найти в списке переменную PATH, нажать "редактировать" и
                через точку с запятой дописать путь к java. По умолчанию это
                C:\Program Files\Java\jdk_6_21\bin.
            </li>
        </ol>

        <div class="empty">&#160;</div>
    </xsl:template>

    <xsl:template name="additional-header">
        <link type="text/css" rel="stylesheet" href="../notes.css"/>
        <link type="text/css" rel="stylesheet" href="../list.css"/>
    </xsl:template>

</xsl:stylesheet>