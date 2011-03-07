<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="common.xsl"/>

    <xsl:template match="page" mode="content">
        <h2>Задачи, которые необходимо сдать за семестр</h2>

        <xsl:if test="not(menu/data/no-auth) and (menu/data/user-info/uid = 1)">
            <div>
                <a href="task/task-edit.xml">Добавить задачу</a>
            </div>
        </xsl:if>

        <div>
            Результат любого задания - это некоторый набор файлов,
            который должен быть закоммичен в svn. Как настроить svn,
            написано <a href="/students/note/svn2.xml">тут</a>.
        </div>
        <div>
            Структура пакетов должна быть следующая: ru.ifmo.enf.[Ваша_фамилия].t[номер_задания].
        </div>
        <div>
            <em>Пример:</em><br/> если Вас зовут <strong>Василий Пупкин</strong>
            и Вы намерены сдать <strong>седьмую задачу</strong>, результатом которой
            должен быть файл HelloWorld.java, то файл в свне нужно положить по следующему
            пути:<br/>
            <pre>ru/ifmo/enf/pupkin/t07/HelloWorld.java</pre>
            полное название класса при этом будет<br/>
            <pre>ru.ifmo.enf.pupkin.t07.HelloWorld</pre>
        </div>
        <div>
            Перед тем, как закоммитить код, убедитесь,
            что он соответствует <a href="/students/note/requirements.xml">требованиям</a>.
            Если присланное не соответствует требованиям - минус балл.
            Если прислан не компилирующийся код, задание не рассматривается совсем.
        </div>
        <div>
            Если задание присылается после указанного срока (см. на странице задания)
            - минус балл, а то и больше.
        </div>
        <div>Результат проверки задания высылается каждому студенту на почту.</div>

        <xsl:for-each select="data/modules/module">
            <xsl:variable name="module-id" select="@id"/>
            <xsl:if test="/page/data/tasks/task[module-id/text() = $module-id]">
                <h3><xsl:value-of select="name"/></h3>
                <div>
                    <xsl:apply-templates select="/page/data/tasks/task[module-id/text() = $module-id]" mode="div"/>
                </div>
            </xsl:if>
        </xsl:for-each>

        <div class="empty">&#160;</div>
    </xsl:template>

    <xsl:template match="task" mode="div">
        <div>
            <xsl:value-of select="module-npp"/>
            <xsl:text>. </xsl:text>
            <a href="task/task.xml?task={@id}">
                <xsl:value-of select="name"/>
            </a>
            <xsl:text> (</xsl:text>
                    <xsl:if test="point-cnt &gt; 0">
                        <xsl:value-of select="point-cnt"/>
                        <xsl:text>б</xsl:text>

                        <xsl:if test="karma-cnt &gt; 0">, </xsl:if>
                    </xsl:if>
                    <xsl:if test="karma-cnt &gt; 0">
                        <xsl:text>+</xsl:text>
                        <xsl:value-of select="karma-cnt"/>
                        <xsl:text>к</xsl:text>
                    </xsl:if>
                    <xsl:text>)</xsl:text>
        </div>
    </xsl:template>

    <xsl:template name="additional-header">
        <link type="text/css" rel="stylesheet" href="list.css"/>
        <link type="text/css" rel="stylesheet" href="task/task.css"/>
    </xsl:template>

</xsl:stylesheet>
