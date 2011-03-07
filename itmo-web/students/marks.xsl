<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="common.xsl"/>

    <xsl:template match="page" mode="content">
        <h2>Набранные баллы</h2>

        <xsl:if test="menu/data/user-info/uid = 1 or menu/data/user-info/uid = 2">
            <div>
                <a href="points/points.xml">Баллы для ЦДО</a>
                <xsl:text> | </xsl:text>
                <a href="points/attendance.xml">Отметить посещаемость</a>
                <xsl:text> | </xsl:text>
                <a href="points/karma.xml">Карма</a>
            </div>
        </xsl:if>

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
                <th>
                    <xsl:text>Баллы (</xsl:text>
                    <xsl:value-of select="sum(/page/data/tasks/task/point-cnt)"/>
                    <xsl:text>)</xsl:text>
                </th>
                <th>Карма</th>
                <xsl:apply-templates select="/page/data/tasks/task" mode="th"/>
            </tr>
            <xsl:apply-templates select="student" mode="tr">
                <xsl:sort select="/page/data/students-points/student[@id=current()/@id]/points" order="descending" data-type="number"/>
                <xsl:sort select="/page/data/students-points/student[@id=current()/@id]/karma" order="descending" data-type="number"/>
            </xsl:apply-templates>
        </table>
    </xsl:template>

    <xsl:template match="task" mode="th">
        <th title="{name}">
            <xsl:if test="homework = 0">
                <xsl:attribute name="colspan">2</xsl:attribute>
                <xsl:text>&#8226;&#160;</xsl:text>
            </xsl:if>
            <a href="task/task.xml?task={@id}" class="non-visible-link">
                <xsl:value-of select="module-npp"/>
            </a>
            <xsl:if test="homework = 0">
                <xsl:text>&#160;&#8226;</xsl:text>
            </xsl:if>
        </th>
    </xsl:template>

    <xsl:template match="task" mode="td">
        <xsl:param name="student-id"/>
        <xsl:variable name="task-id" select="@id"/>
        <xsl:variable name="lesson-id" select="lesson-id"/>
        <xsl:variable name="max-points" select="point-cnt"/>
        <xsl:variable name="points"
                      select="/page/data/student-task-points/student-task-point[student-id = $student-id and task-id = $task-id]"/>
        <xsl:if test="homework = 0">
            <td title="{name}">
                <xsl:variable name="attendance" select="/page/data/students-attendance/student-attendance[student-id = $student-id and lesson-id = $lesson-id]/status"/>
                <xsl:choose>
                    <xsl:when test="$attendance = 0">
                        <xsl:attribute name="class">red</xsl:attribute>
                        <xsl:text>-</xsl:text>
                    </xsl:when>
                    <xsl:when test="$attendance = 1">
                        <xsl:attribute name="class">yellow</xsl:attribute>
                        <xsl:text>+</xsl:text>
                    </xsl:when>
                    <xsl:when test="$attendance = 2">
                        <xsl:attribute name="class">green</xsl:attribute>
                        <xsl:text>+</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </td>
        </xsl:if>
        <td title="{name}">
            <xsl:choose>
                <xsl:when test="$points/point-cnt = $max-points">
                    <xsl:attribute name="class">green</xsl:attribute>
                </xsl:when>
                <xsl:when test="$points/status = 5">
                    <xsl:attribute name="class">red</xsl:attribute>
                </xsl:when>
                <xsl:when test="$points/point-cnt &gt; 0 or $points/status &gt; 1">
                    <xsl:attribute name="class">yellow</xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="/page/menu/data/user-info/uid = 1">
                    <a class="non-visible-link" href="task/user-points.xml?user-id={$student-id}&#38;task={$task-id}">
                        <xsl:value-of select="$points/point-cnt"/>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$points/point-cnt"/>
                </xsl:otherwise>
            </xsl:choose>

        </td>
    </xsl:template>

    <xsl:template match="student" mode="tr">
        <tr>
            <xsl:variable name="student-id" select="@id"/>
            <td class="left"><xsl:value-of select="position()"/></td>
            <td class="left"><xsl:value-of select="."/></td>
            <td class="blue"><xsl:value-of select="/page/data/students-points/student[@id=$student-id]/points"/></td>
            <td>
                <xsl:variable name="karma" select="/page/data/students-points/student[@id=$student-id]/karma"/>
                <xsl:choose>
                    <xsl:when test="$karma &gt; 0">
                        <xsl:attribute name="class">blue plus</xsl:attribute>
                        <xsl:text>+</xsl:text>
                    </xsl:when>
                    <xsl:when test="$karma &lt; 0">
                        <xsl:attribute name="class">blue minus</xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="class">blue zero</xsl:attribute>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="/page/menu/data/user-info and /page/menu/data/user-info/uid = 1">
                        <a class="non-visible-link" href="points/karma.xml?student={@id}">
                            <xsl:value-of select="$karma"/>
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$karma"/>
                    </xsl:otherwise>
                </xsl:choose>

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
            div#content a.non-visible-link {color:inherit; text-decoration:none;}
        </style>
    </xsl:template>

</xsl:stylesheet>
