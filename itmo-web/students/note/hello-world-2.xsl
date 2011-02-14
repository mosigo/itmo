<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="../common.xsl"/>

    <xsl:template match="page" mode="content">
        <h2>Как скомпилировать и запустить Java-программу из Intellij Idea</h2>

        <h3>Шаг 1. Создаём проект</h3>
        <ol>
            <li>Открываем Intellij Idea.</li>
            <li>Выбираем File -> New Project.</li>
            <li>Вместо "undefined" вводим название проекта. Например, helloworld.</li>
            <li>На все остальные вопросы отвечаем "yes".</li>
        </ol>
        <h3>Шаг 2. Создаём класс</h3>
        <ol>
            <li>
                Слева в окне "Project" отображается структура файлов.
                Жмём правой клавишей на папке src (она должна быть
                подсвечена синим цветом), выбираем New -> Java Class.
            </li>
            <li>Вводим название класса: HelloWorld</li>
            <li>Добавляем к созданному классу метод main:</li>
<pre class="code">
    public static void main (String[] args) {
        System.out.println("Hello World!");
    }
</pre>
            <li>
                Правой клавишей мыши нажимаем в любом месте метода main.
                Из контекстного меню выбираем "Run HelloWorld.main()".
            </li>
            <li>Внизу в консоли видим результат.</li>
        </ol>
        <h4>hint:</h4>
        <ul>
            <li>Чтобы объявить метод main внутри класса, достаточно набрать:
            <pre>psvm</pre>
            и нажать клавишу tab. Метод будет сгенерирован автоматически.
            </li>
            <li>Чтобы сгенерить строчку кода System.out.println() достаточно набрать:
            <pre>sout</pre>
            и нажать клавишу tab. Строка будет сгенерирована автоматически.
            </li>
            <li>Полный список подобных сокращений доступен в File -> Settings -> IDE Settings -> Live Templates.</li>
        </ul>
        <h3>Шаг 3. Как передать параметры</h3>
        <ol>
            <li>В меню Intellij Idea выбираем Run -> Edit Configurations.</li>
            <li>В поле ввода Program Parameters можно ввести аргументы.</li>
            <li>Нажимаем кнопку ОК. Затем Run -> Run. Программа запустилась
                с нужными параметрами.</li>
        </ol>

        <div class="empty">&#160;</div>
    </xsl:template>

    <xsl:template name="additional-header">
        <link type="text/css" rel="stylesheet" href="../notes.css"/>
        <link type="text/css" rel="stylesheet" href="../list.css"/>
    </xsl:template>

</xsl:stylesheet>