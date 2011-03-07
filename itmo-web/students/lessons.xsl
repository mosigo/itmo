<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="common.xsl"/>

    <xsl:template match="page" mode="content">
        <h2>Состоявшиеся занятия</h2>

        <xsl:apply-templates select="data/lessons/lesson[type=2][given=1]" mode="descr">
            <xsl:sort select="@id" order="descending" data-type="number"/>
        </xsl:apply-templates>

        <!--<h3>12 февраля, суббота [2 пары]</h3>-->

        <!--<div>-->
            <!--<a href="note/svn2.xml">Subversion. Базовые знания.</a><br/>-->
            <!--Списки. ArrayList. LinkedList.-->
        <!--</div>-->
        <!--<div class="intro">-->
            <!--<strong>Выполняли на занятии:</strong>-->
            <!--<ul>-->
                <!--<li><a href="task/task.xml?task=1">Своя реализация связного списка</a></li>-->
            <!--</ul>-->
            <!--<strong>Домашнее задание:</strong>-->
            <!--<ul>-->
                <!--<li><a href="task/task.xml?task=2">Subversion. HelloWorld.</a></li>-->
                <!--<li><a href="task/task.xml?task=3">Реализация списка с "закладками"</a></li>-->
            <!--</ul>-->
        <!--</div>-->


        <div class="empty">&#160;</div>
    </xsl:template>
    
    <xsl:template match="lesson" mode="descr">
        <xsl:variable name="lesson-id" select="@id"/>
        <h3><xsl:value-of select="name"/></h3>
        <xsl:variable name="task" select="/page/data/tasks/task[lesson-id=$lesson-id]"/>
        <xsl:if test="$task">
            <div class="intro">
                <strong>Выполняли на занятии:</strong>

                <ul>
                    <li><a href="task/task.xml?task={$task/@id}"><xsl:value-of select="$task/name"/></a></li>
                </ul>
                <!--<strong>Домашнее задание:</strong>-->
                <!--<ul>-->
                    <!--<li><a href="task/task.xml?task=2">Subversion. HelloWorld.</a></li>-->
                    <!--<li><a href="task/task.xml?task=3">Реализация списка с "закладками"</a></li>-->
                <!--</ul>-->
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template name="additional-header">
        <!--<link type="text/css" rel="stylesheet" href="list.css"/>-->
        <style type="text/css">
            div#content div {padding-left: 12px; padding-bottom: 12px;}
            div.intro {paffing-left: 18px; font-size:0.9em;}
            hr {width:80%;}
        </style>
    </xsl:template>

</xsl:stylesheet>
