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
            <xsl:when test="menu/data/no-auth or menu/data/user-info/@id != 1">
                <div class="error">Ой. А у Вас нету прав.</div>
            </xsl:when>
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
                <xsl:apply-templates select="data/task/points" mode="table"/>

            </xsl:when>
            <xsl:otherwise>
                <div class="error">Ой. Нет такого задания. Возможно, введено что-то не то.</div>
            </xsl:otherwise>
        </xsl:choose>


        <div class="empty">&#160;</div>
    </xsl:template>

    <xsl:template match="points" mode="table">
        <form action="save-points.xml" method="get">
            <input type="hidden" name="task-id" value="{/page/data/task/@id}"/>
            <input type="hidden" name="student-id" value="{/page/data/user-info/@id}"/>
            <h3><xsl:value-of select="/page/data/user-info"/></h3>
            <div>
                <xsl:text>Текущая оценка: </xsl:text>
                <xsl:value-of select="/page/data/student-task-point/point-cnt"/>
                <xsl:text> (баллы), </xsl:text>
                <xsl:value-of select="/page/data/student-task-point/karma-cnt"/>
                <xsl:text> (карма)</xsl:text>
            </div>
            <xsl:if test="point">
                <table class="points">
                    <tr>
                        <th/>
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
                        <th/>
                        <th>карма</th>
                        <th>за что</th>
                    </tr>
                    <xsl:apply-templates select="karma" mode="tr"/>
                </table>
            </xsl:if>
            <div>
                <xsl:for-each select="/page/data/task-statuses/status">
                    <input type="radio" name="task-status" value="{@code}">
                        <xsl:if test="@code = /page/data/student-task-point/status">
                            <xsl:attribute name="checked">checked</xsl:attribute>
                        </xsl:if>
                    </input>
                    <xsl:value-of select="."/><br/>
                </xsl:for-each>
            </div>
            <div>
                <input type="submit" value="Сохранить"/>
            </div>
        </form>

    </xsl:template>

    <xsl:template match="point" mode="tr">
        <tr>
            <xsl:variable name="de-item-id" select="de-item-id"/>
            <td>
                <input type="checkbox" name="de-item-id" value="{de-item-id}">
                    <xsl:if test="/page/data/detailed-student-task-points/point[de-item-id = $de-item-id]">
                        <xsl:attribute name="checked">checked</xsl:attribute>
                    </xsl:if>
                </input>
                <input type="hidden" name="task-point-{de-item-id}" value="{point-cnt}"/>
            </td>
            <td><xsl:value-of select="point-cnt"/></td>
            <td><xsl:value-of select="description"/></td>
            <td><xsl:value-of select="/page/data/de-items/de-item[@id = $de-item-id]/description"/></td>
        </tr>
    </xsl:template>

    <xsl:template match="karma" mode="tr">
        <tr>
            <td>
                <input type="checkbox" name="karma-id" value="{karma-id}">
                    <xsl:variable name="karma-id" select="karma-id"/>
                    <xsl:if test="/page/data/detailed-student-task-points/karma[karma-id = $karma-id]">
                        <xsl:attribute name="checked">checked</xsl:attribute>
                    </xsl:if>
                </input>
            </td>
            <td>+<xsl:value-of select="point-cnt"/></td>
            <td><xsl:value-of select="description"/></td>
        </tr>
    </xsl:template>

</xsl:stylesheet>