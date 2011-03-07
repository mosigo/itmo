<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="../common.xsl"/>

    <xsl:template name="additional-header">
        <link type="text/css" rel="stylesheet" href="karma.css"/>
    </xsl:template>

    <xsl:template match="page" mode="content">
        <xsl:choose>
            <xsl:when test="menu/data/no-auth or (menu/data/user-info/uid != 1 and menu/data/user-info/uid != 2)">
                <div class="error">Ой. А у Вас нету прав.</div>
            </xsl:when>
            <xsl:otherwise>
                <h2>Карма студентов</h2>
                <xsl:apply-templates select="data/karma-points" mode="table"/>
            </xsl:otherwise>
        </xsl:choose>


        <div class="empty">&#160;</div>
    </xsl:template>

    <xsl:template match="karma-points" mode="table">
        <table>
            <tr>
                <th>id</th>
                <th>Кто</th>
                <th>Сколько</th>
                <th>Что</th>
                <th>Где</th>
                <th>Когда</th>
            </tr>
            <xsl:apply-templates select="point" mode="tr"/>
        </table>
    </xsl:template>

    <xsl:template match="point" mode="tr">
        <tr>
            <xsl:variable name="user-id" select="user-id"/>
            <xsl:variable name="karma-id" select="@karma-id"/>
            <td>
                <xsl:value-of select="$user-id"/>
            </td>
            <td>
                <xsl:value-of select="/page/data/students/student[@id=$user-id]"/>
            </td>
            <xsl:variable name="karma-item" select="/page/data/karma-items/item[id=$karma-id]"/>
            <td>
                <xsl:if test="$karma-item/point-cnt &gt; 0">
                    <xsl:attribute name="class">green</xsl:attribute>
                    <xsl:text>+</xsl:text>
                </xsl:if>
                <xsl:value-of select="$karma-item/point-cnt"/>
            </td>
            <td>
                <xsl:value-of select="$karma-item/description"/>
            </td>
            <td>
                <xsl:variable name="lesson-id" select="lesson-id"/>
                <xsl:variable name="task-id" select="task-id"/>

                <xsl:variable name="task" select="/page/data/tasks/task[@id=$task-id]"/>
                <xsl:choose>
                    <xsl:when test="$lesson-id &gt; 0">
                        <xsl:text>Занятие </xsl:text>
                        <xsl:value-of select="/page/data/lessons/lesson[@id=$lesson-id]/name"/>
                    </xsl:when>
                    <xsl:when test="$task-id &gt; 0">
                        <xsl:text>Задача №</xsl:text>
                        <xsl:value-of select="$task/module-npp"/>
                        <xsl:text> «</xsl:text>
                        <xsl:value-of select="$task/name"/>
                        <xsl:text>»</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </td>
            <td><xsl:value-of select="creation-time"/></td>
        </tr>
    </xsl:template>


</xsl:stylesheet>