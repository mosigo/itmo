<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="../common.xsl"/>

    <xsl:template name="additional-header">
        <style type="text/css">
            table {margin-top:12px; margin-bottom:12px;}
            option.gray {color:lightgray;}
        </style>
    </xsl:template>

    <xsl:template match="page" mode="content">
        <xsl:choose>
            <xsl:when test="menu/data/no-auth or (menu/data/user-info/uid != 1 and menu/data/user-info/uid != 2)">
                <div class="error">Ой. А у Вас нету прав.</div>
            </xsl:when>
            <xsl:otherwise>
                <h2>Отметить посещаемость</h2>
                <form action="save-attendance.xml" method="post">
                    <div>
                        <xsl:apply-templates select="data/lessons" mode="combo"/>
                    </div>
                    <xsl:apply-templates select="data/students" mode="table"/>
                    <div>
                        <input type="submit" value="Сохранить"/>
                    </div>
                </form>
            </xsl:otherwise>
        </xsl:choose>

        <div class="empty">&#160;</div>
    </xsl:template>

    <xsl:template match="students" mode="table">
        <table>
            <tr>
                <th>id</th>
                <th>Студент</th>
                <th>Присутствие</th>
            </tr>
            <xsl:apply-templates select="student" mode="tr">
                <xsl:sort select="@id" data-type="number"/>
            </xsl:apply-templates>
        </table>
    </xsl:template>

    <xsl:template match="student" mode="tr">
        <tr>
            <td><xsl:value-of select="@id"/></td>
            <td><xsl:value-of select="."/></td>
            <td>
                <input type="radio" name="user-{@id}" value="0" checked="1"/>нет
                <input type="radio" name="user-{@id}" value="1"/>опоздал
                <input type="radio" name="user-{@id}" value="2"/>был
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="lessons" mode="combo">
        <select name="lesson-id">
            <option value="-1">-выберите занятие-</option>
            <xsl:apply-templates select="lesson" mode="option"/>
        </select>
    </xsl:template>

    <xsl:template match="lesson" mode="option">
        <xsl:variable name="lesson-id" select="@id"/>
        <option value="{@id}">
            <xsl:if test="count(/page/data/students-attendance/student-attendance[lesson-id=$lesson-id]) &gt; 5">
                <xsl:attribute name="class">gray</xsl:attribute>
            </xsl:if>
            <xsl:value-of select="name"/>
            <xsl:choose>
                <xsl:when test="type=1">
                    <xsl:text> [лекция]</xsl:text>
                </xsl:when>
                <xsl:when test="type=2">
                    <xsl:text> [практика]</xsl:text>
                </xsl:when>
            </xsl:choose>
        </option>
    </xsl:template>

</xsl:stylesheet>