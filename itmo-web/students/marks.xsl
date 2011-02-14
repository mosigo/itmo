<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="common.xsl"/>

    <xsl:template match="page" mode="content">
        <h2>Набранные баллы</h2>

        <xsl:for-each select="data/modules/module">
            <xsl:variable name="module-id" select="@id"/>
            <xsl:if test="/page/data/tasks/task[module-id/text() = $module-id]">
                <xsl:apply-templates select="/page/data/students" mode="table">
                    <xsl:with-param name="module" select="$module-id"/>
                </xsl:apply-templates>
            </xsl:if>
        </xsl:for-each>

        <div class="empty">&#160;</div>
    </xsl:template>

    <xsl:template match="students" mode="table">
        <xsl:param name="module"/>
        <h3><xsl:value-of select="/page/data/modules/module[@id = $module]/name"/></h3>
        <table>
            <tr>
                <th>№</th>
                <th>Студент</th>
                <th>Баллы</th>
                <th>Карма</th>
                <xsl:apply-templates select="/page/data/tasks/task" mode="th"/>
            </tr>
            <xsl:apply-templates select="student" mode="tr"/>
        </table>
    </xsl:template>

    <xsl:template match="task" mode="th">
        <th><xsl:value-of select="@id"/></th>
    </xsl:template>

    <xsl:template match="task" mode="td">
        <xsl:param name="student-id"/>
        <td></td>
    </xsl:template>

    <xsl:template match="student" mode="tr">
        <tr>
            <xsl:variable name="student-id" select="@id"/>
            <td class="left"><xsl:value-of select="position()"/></td>
            <td class="left"><xsl:value-of select="."/></td>
            <td><xsl:value-of select="/page/data/students-points/student[@id=$student-id]/points"/></td>
            <td>
                <xsl:variable name="karma" select="/page/data/students-points/student[@id=$student-id]/karma"/>
                <xsl:choose>
                    <xsl:when test="$karma &gt; 0">
                        <xsl:attribute name="class">plus</xsl:attribute>
                        <xsl:text>+</xsl:text>
                    </xsl:when>
                    <xsl:when test="$karma &lt; 0">
                        <xsl:attribute name="class">minus</xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="class">zero</xsl:attribute>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:value-of select="$karma"/>
            </td>
            <xsl:apply-templates select="/page/data/tasks/task" mode="td">
                <xsl:with-param name="student-id" select="$student-id"/>
            </xsl:apply-templates>
        </tr>
    </xsl:template>

    <xsl:template name="additional-header">
        <link type="text/css" rel="stylesheet" href="list.css"/>
        <style type="text/css">
            div#content div {padding-bottom:12px;}
            table {margin-bottom:12px;}
            table td, table th {text-align: center;}
            table td.left {text-align:left;}
            table td.plus {color:green;}
            table td.minus {color:red;}
            table td.zero {color:yellow;}
        </style>
    </xsl:template>

</xsl:stylesheet>
