<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="../common.xsl"/>

    <xsl:template name="additional-header">
        <link type="text/css" rel="stylesheet" href="task-points.css"/>
    </xsl:template>

    <xsl:template match="page" mode="content">
        <xsl:choose>
            <xsl:when test="menu/data/no-auth or menu/data/user-info/uid != 1">
                <div class="error">Ой. А у Вас нету прав.</div>
            </xsl:when>
            <xsl:when test="not(data/task/name)">
                <div class="error">Ой. Нет такой задачи.</div>
            </xsl:when>
            <xsl:otherwise>
                <h2>Баллы к задаче (id=<xsl:value-of select="data/task/@id"/>)</h2>
                <div>
                    <xsl:value-of select="data/task/name"/>
                </div>

                <form action="save-task-points.xml" method="post">
                    <input type="hidden" name="task" value="{/page/data/task/@id}"/>
                    <xsl:variable name="module-id" select="data/task/module-id"/>
                    <xsl:apply-templates select="data/lessons" mode="div"/>
                    <xsl:apply-templates select="data/modules/module[@id=$module-id]" mode="table"/>
                    <xsl:apply-templates select="data/karma-items" mode="div"/>
                    <div>
                        <input type="submit" class="submit" value="Сохранить"/>
                    </div>
                </form>
            </xsl:otherwise>
        </xsl:choose>

        <div class="empty">&#160;</div>
    </xsl:template>

    <xsl:template match="karma-items" mode="div">
        <h3>Карма</h3>
        <xsl:apply-templates select="item[point-cnt &gt; 0]" mode="div"/>
    </xsl:template>

    <xsl:template match="item" mode="div">
        <div>
            <input type="checkbox" name="karma-id" value="{id}">
                <xsl:variable name="karma-id" select="id"/>
                <xsl:if test="/page/data/task/points/karma[karma-id = $karma-id]">
                    <xsl:attribute name="checked">1</xsl:attribute>
                </xsl:if>
                <xsl:value-of select="description"/>
            </input>
        </div>
    </xsl:template>
    
    <xsl:template match="lessons" mode="div">
        <xsl:variable name="lesson-id" select="/page/data/task/lesson-id"/>
        <xsl:if test="/page/data/task/@homework=0">
            <div>
                <select name="lesson-id">
                    <option value="-1" selected="1">не выбрано</option>
                    <xsl:for-each select="lesson[type=2]">
                        <option value="{@id}">
                            <xsl:if test="@id = $lesson-id">
                                <xsl:attribute name="selected">1</xsl:attribute>
                            </xsl:if>
                            <xsl:value-of select="name"/>
                        </option>
                    </xsl:for-each>
                </select>
            </div>
        </xsl:if>

    </xsl:template>

    <xsl:template match="module" mode="table">
        <xsl:variable name="module-id" select="@id"/>
        <table>
            <tr>
                <th rowspan="4" style="vertical-align:middle">
                    <xsl:value-of select="sum(/page/data/de-items/de-item[module-id = $module-id]/used-point-cnt)"/>
                    <xsl:text>&#160;/&#160;</xsl:text>
                    <xsl:value-of select="sum(/page/data/de-items/de-item[module-id = $module-id]/point-cnt)"/>
                </th>
                <xsl:for-each select="/page/data/de-items/de-item[module-id = $module-id]">
                    <th>
                        <xsl:value-of select="description"/>
                    </th>
                </xsl:for-each>
            </tr>
            <tr>

                <xsl:for-each select="/page/data/de-items/de-item[module-id = $module-id]">
                    <th>
                        <xsl:value-of select="used-point-cnt"/>
                        <xsl:text> / </xsl:text>
                        <xsl:value-of select="point-cnt"/>
                    </th>
                </xsl:for-each>
            </tr>
            <tr>
                <xsl:for-each select="/page/data/de-items/de-item[module-id = $module-id]">
                    <xsl:variable name="de-item-id" select="@id"/>
                    <td>
                        <input type="text" class="text" name="deitem-{@id}">
                            <xsl:attribute name="value">
                                <xsl:variable name="points" select="/page/data/task/points/point[de-item-id=$de-item-id]"/>
                                <xsl:choose>
                                    <xsl:when test="$points">
                                        <xsl:value-of select="$points/point-cnt"/>
                                    </xsl:when>
                                    <xsl:otherwise>0</xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>
                        </input>
                    </td>
                </xsl:for-each>
            </tr>
            <tr>
                <xsl:for-each select="/page/data/de-items/de-item[module-id = $module-id]">
                    <xsl:variable name="de-item-id" select="@id"/>
                    <td>
                        <textarea type="text" name="deitemdescr-{@id}">
                            <xsl:value-of select="/page/data/task/points/point[de-item-id=$de-item-id]/description"/>
                        </textarea>
                    </td>
                </xsl:for-each>
            </tr>

        </table>
    </xsl:template>

</xsl:stylesheet>