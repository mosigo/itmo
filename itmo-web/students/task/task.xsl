<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="../common.xsl"/>

    <xsl:template name="additional-header">
        <link type="text/css" rel="stylesheet" href="../list.css"/>
        <link type="text/css" rel="stylesheet" href="task.css"/>
    </xsl:template>

    <xsl:template match="page" mode="content">
        <xsl:choose>
            <xsl:when test="data/task/name">
                <h2>
                    <xsl:value-of select="data/task/module-npp"/>
                    <xsl:text>. </xsl:text>
                    <xsl:value-of select="data/task/name"/>
                    <xsl:text> (</xsl:text>
                    <xsl:if test="data/task/points/point">
                        <xsl:value-of select="sum(data/task/points/point/point-cnt)"/>
                        <xsl:text>б</xsl:text>

                        <xsl:if test="data/task/points/karma">, </xsl:if>
                    </xsl:if>
                    <xsl:if test="data/task/points/karma">
                        <xsl:text>+</xsl:text>
                        <xsl:value-of select="sum(data/task/points/karma[karma-id/text() != 2 and karma-id/text() != 3]/point-cnt)"/>
                        <xsl:text>к</xsl:text>
                    </xsl:if>
                    <xsl:text>)</xsl:text>
                </h2>
                <xsl:if test="data/task/@hidden=1">
                    <div style="color:red">!!Задание скрыто!!</div>
                </xsl:if>
                <xsl:if test="not(menu/data/no-auth) and (menu/data/user-info/uid = 1)">
                    <div>
                        <xsl:text>Редактировать </xsl:text>
                        <a href="task-edit.xml?task={data/task/@id}">текст</a>
                        <xsl:text> или </xsl:text>
                        <a href="task-points.xml?task={data/task/@id}">баллы</a>
                    </div>
                </xsl:if>
                <xsl:apply-templates select="data/task/points" mode="table"/>

                <xsl:value-of disable-output-escaping="yes" select="data/task/body" />
            </xsl:when>
            <xsl:otherwise>
                <div class="error">Ой. Нет такого задания. Возможно, введено что-то не то.</div>
            </xsl:otherwise>
        </xsl:choose>


        <div class="empty">&#160;</div>
    </xsl:template>

    <xsl:template match="points" mode="table">
        <xsl:if test="point">
            <table class="points">
                <tr>
                    <th>баллы</th>
                    <th>за что</th>
                    <th>графа</th>
                </tr>
                <xsl:apply-templates select="point" mode="tr"/>
            </table>
        </xsl:if>

        <xsl:if test="karma">
            <table class="points">
                <tr>
                    <th>карма</th>
                    <th>за что</th>
                </tr>
                <xsl:apply-templates select="karma" mode="tr"/>
            </table>
        </xsl:if>

    </xsl:template>

    <xsl:template match="point" mode="tr">
        <tr>
            <xsl:variable name="de-item-id" select="de-item-id"/>
            <td><xsl:value-of select="point-cnt"/></td>
            <td><xsl:value-of select="description"/></td>
            <td><xsl:value-of select="/page/data/de-items/de-item[@id = $de-item-id]/description"/></td>
        </tr>
    </xsl:template>

    <xsl:template match="karma" mode="tr">
        <tr>
            <td>+<xsl:value-of select="point-cnt"/></td>
            <td><xsl:value-of select="description"/></td>
        </tr>
    </xsl:template>

</xsl:stylesheet>