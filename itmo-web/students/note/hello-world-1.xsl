<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="../common.xsl"/>

    <xsl:template match="page" mode="content">
        <h2>Как скомпилировать и запустить Java-программу из консоли</h2>

        <h3>Шаг 1. Создаём Java-класс</h3>
        <ol>
            <li>Любым текстовым редактором (например, "Блокнот" в windows или "Gedit" в линуксе) создаём файл и называем его HelloWorld.java</li>
            <li>Копируем в файл следующий текст:</li>
<pre class="code">
public class HelloWorld {
    public static void main (String[] args) {
        System.out.println("Hello World!");
    }
}
</pre>
        </ol>
        <h4>NB:</h4>
        <ul>
            <li>Нельзя написать код на языке Java, не написав ни одного класса.</li>
            <li>Имя класса всегда должно совпадать с названием файла (имя класса -- HelloWorld, имя файла -- HellowWorld.java).</li>
            <li>Для того, чтобы запустить класс, в нём обязательно нужно описать метод main:</li>
            <pre>public static void main (String[] args) {...}</pre>
        </ul>
        <h3>Шаг 2. Компилируем созданный класс</h3>
        <ol>
            <li>Выполняем из консоли команду (из той директории, где находится java-класс):</li>
            <pre>javac HelloWorld.java</pre>
            <li>Рядом с файлом HelloWorld.java появится файл HellowWorld.class -- это байт-код, в который был скомпилирован файл HelloWorld.java</li>
        </ol>
        <h3>Шаг 3. Запускаем скомпилированную программу</h3>
        <ol>
            <li>Выполняем из консоли команду:</li>
            <pre>java HelloWorld</pre>
            <li>Видим на экране выведенное приветствие:</li>
            <pre>Hello World!</pre>
        </ol>

        <div class="empty">&#160;</div>
    </xsl:template>

    <xsl:template name="additional-header">
        <link type="text/css" rel="stylesheet" href="../notes.css"/>
        <link type="text/css" rel="stylesheet" href="../list.css"/>
    </xsl:template>

</xsl:stylesheet>
