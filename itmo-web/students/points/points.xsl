<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="../common.xsl"/>

    <xsl:template name="additional-header">
        <link type="text/css" rel="stylesheet" href="points.css"/>
    </xsl:template>

    <xsl:template match="page" mode="content">
        <xsl:choose>
            <xsl:when test="menu/data/no-auth or (menu/data/user-info/uid != 1 and menu/data/user-info/uid != 2)">
                <div class="error">Ой. А у Вас нету прав.</div>
            </xsl:when>
            <xsl:otherwise>
                <h2>Баллы для ЦДО</h2>
                <xsl:apply-templates select="data/de-items" mode="table"/>
            </xsl:otherwise>
        </xsl:choose>


        <div class="empty">&#160;</div>
    </xsl:template>

    <xsl:template match="de-items" mode="table">
        <xsl:for-each select="/page/data/modules/module">
            <xsl:variable name="module-id" select="@id"/>
            <xsl:if test="/page/data/de-items/de-item[module-id = $module-id]">
                <h3><xsl:value-of select="name"/></h3>
                <xsl:apply-templates select="." mode="table"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="module" mode="table">
        <xsl:variable name="module-id" select="@id"/>
        <table>
            <tr>
                <th rowspan="2">Студент</th>

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
            <xsl:for-each select="/page/data/students/student">
                <tr>
                    <td class="first"><xsl:value-of select="."/></td>
                    <xsl:variable name="student-id" select="@id"/>
                    <xsl:for-each select="/page/data/de-items/de-item[module-id = $module-id]">
                        <xsl:variable name="de-item-id" select="@id"/>
                        <td>
                            <xsl:variable name="item"
                                          select="/page/data/user-de-points/point[user-id = $student-id]/de-items/item[@id = $de-item-id]"/>
                            <xsl:choose>
                                <xsl:when test="$item">
                                    <xsl:attribute name="class">green</xsl:attribute>
                                    <xsl:value-of select="$item/points"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:attribute name="class">gray</xsl:attribute>
                                    <xsl:text>0</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </td>
                    </xsl:for-each>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>

</xsl:stylesheet>