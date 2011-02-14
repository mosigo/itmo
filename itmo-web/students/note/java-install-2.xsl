<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="../common.xsl"/>

    <xsl:template match="page" mode="content">
        <h2>Как установить и настроить Intellij Idea</h2>

        <h3>Шаг 0. Установка IDEA</h3>
        <ol>
            <li>
                Идём на сайт jetbrains.com и находим
                <a href="http://www.jetbrains.com/idea/download/">страницу загрузки</a> IDEA.
            </li>
            <li>
                Там предлагается два варианта: либо полная платная версия (Ultimate Edition),
                либо неполная бесплатная (Community Edition). Бесплатной на данном этапе точно
                достаточно.
            </li>
            <li>
                После загрузки файла следующий шаг зависит от ОС.
            </li>
            <ul>
                <li>Если у Вас windows, просто запустите .exe файл из загруженного архива.</li>
                <li>
                    Если у Вас linux, то необходимо распаковать загруженный архив.
                    В распакованной папке будет файл bin/idea.sh. Запускать
                    нужно именно его:
                    <pre>obolshakova 09/19 00:22:53 ~/programs/idea-IC-95.429/bin$ ./idea.sh</pre>
                    Возможно, будут проблемы с тем, что скрипт не будет знать пути до java.
                    Одно из возможных решений - прописать этот пусть прямо внутри скрипта, например,
                    добавив строчку прямо в idea.sh (в самое начало после строчки "#!/bin/sh"):
                    <pre>export JDK_HOME='/usr/lib/jvm/java-6-sun'</pre>
                </li>
            </ul>
        </ol>

        <h3>Шаг 1. Создание проекта</h3>
        <ol>
            <li>Открываем Intellij Idea.</li>
            <li>Выбираем File -> New Project.</li>
            <li>Далее предлагается выбор из трёх вариантов. Нам могут понадобиться первые два:</li>
                <ul>
                    <li>Create project from scratch - создать проект с нуля, выбрав, где он будет находиться в файловой системе</li>
                    <li>Create java project from existing sources - создать проект из существующих исходников</li>
                </ul>
            <li>Выбираем первый пункт.</li>
            <li>
                Далее предлагается настроить проект.
                Первый пункт - название. Вместо "untitled" вводим название проекта. Например, "myproject".
            </li>
            <li>
                Чуть ниже выбираем каталог в файловой системе, где будет сохранён проект.
            </li>
            <li>
                Далее расположена галка "create module". Если проект создаётся с нуля, то удобно её установить
                и сразу задать имя модуля (т.к. каждый проект должен содержать хотя бы один модуль и его всё
                равно придётся создать).
            </li>
            <li>
                Во втором блоке Module Settings - настройки модуля: имя и расположение в файловой системе.
                Тип - Java Module, остальное пока не пригодится.
            </li>
            <li>
                В следующем окне предлагается либо создать директорию, где будут храниться исходные коды, либо не создавать.
                Если Вам не очень понятно, что это значит, то лучше согласиться на предложение о "src".
            </li>
            <li>На последнем шаге диалога лучше ничего не отмечать, а просто нажать Finish.</li>
        </ol>
        <h3>Шаг 2. Подключение java</h3>
        <ol>
            <li>
                Первым делом необходимо указать путь до java. File -> Project Structure -> Project Settings -> Project.
                Далее справа в разделе Project SDK нужно нажать кнопку New и указать путь до Java.
                Если у Вас windows, то это что-то вроде C:\Program Files\Java\jdk_6_21\bin.
                Если у Вас линукс, то около /usr/lib/jvm/java-6-sun.
            </li>
            <li>
                Далее необходимо подключить исходные коды стандартной библиотеки, чтобы javadoc
                на всё был, и можно было при необходимости заглянуть в код. File ->
                Project Structure -> Platform Settings -> SDKs. Справа нужно выбрать добавленный jdk,
                затем вкладку Sourcepath и нажать кнопку Add. Далее необходимо указать путь к файлу src.zip,
                который должен быть внутри папки с jdk.
            </li>

        </ol>
        <h4>NB:</h4>
        <ul>
            <li>
                Если у Вас линукс, то скорее всего исходные коды нужно поставить дополнительно.
                Например, установив соответствующий пакет.
                <pre>sudo apt-get install sun-java6-source</pre>
            </li>
        </ul>
        <h3>Шаг 3. Шапка и другие настройки кодогенерации</h3>
        <ol>
            <li>
                Первым делом стоит настроить текст, который будет приписываться
                к каждому классу. По умолчанию это:
            </li>
<pre>
/*
 * Created by IntelliJ IDEA.
 * User: user
 * Date: 19.09.2010
 * Time: 00:04:19
 * To change this template use File | Settings | File Templates.
 */
</pre>
                Собственно, как изменить эту надпись, там указано: File -> Settings -> File Templates.
                Будет здорово, если в шапке будут указаны Ваши полное имя, фамилия и e-mail.
                Например, так:
<pre>
/**
 * Author: Olga Bolshakova (o.bolshakova@yandex.ru)
 * Date: 08.09.2010 2:26:01
 *
 */
</pre>
                Мой шаблон при этом такой:
<pre>
/**
 * Author: Olga Bolshakova (o.bolshakova@yandex.ru)
 * Date: ${DATE} ${TIME}
 *
 */
</pre>
            <li>
                 Также стоит настроить, что именно будет использоваться в качестве
                 отступов (табуляции) в коде. File -> Settings -> Project Settings ->
                 Code Style. Далее на вкладке Java можно указать Tab Size. У меня он
                 равен 4.
            </li>
            <li>
                Можно включить нумерацию строк: File -> Settings -> IDE Settings ->
                Editor -> Appearance. Установить галку Show line numbers.
            </li>
            <li>
                Включение отображения пробелов: File -> Settings -> IDE Settings ->
                Editor -> Appearance. Установить галку Show whitespaces.
            </li>
            <li>
                Настройка кодировки файлов: File -> Settings -> Project Settings >
                File Encodings. Справа есть комбобокс с выбором кодировки
                IDE Endoding. У меня стоит UTF-8.
            </li>
        </ol>
        <div class="empty">&#160;</div>
    </xsl:template>

    <xsl:template name="additional-header">
        <link type="text/css" rel="stylesheet" href="../notes.css"/>
        <link type="text/css" rel="stylesheet" href="../list.css"/>
    </xsl:template>

</xsl:stylesheet>