<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="../common.xsl"/>

    <xsl:template name="additional-header">
        <style type="text/css">
            option.green {color:green;}
            option.red {color:red;}
            div.label {float:left; width:150px; margin-top:0}
            input.submit {font-size:1.2em;margin-bottom:12px;}
            form div {margin-top:6px;}
        </style>
    </xsl:template>

    <xsl:template match="page" mode="content">
        <xsl:choose>
            <xsl:when test="menu/data/no-auth or (menu/data/user-info/uid != 1 and menu/data/user-info/uid != 2)">
                <div class="error">Ой. А у Вас нету прав.</div>
            </xsl:when>
            <xsl:otherwise>
                <h2>Операции с кармой</h2>
                <h3>Начислить студенту</h3>
                <form action="save-karma.xml" method="post">
                    <div>
                        <div class="label">Студент</div>
                        <xsl:apply-templates select="data/students" mode="select"/>
                    </div>

                    <div>
                        <div class="label">Карма</div>
                        <xsl:apply-templates select="data/karma-items" mode="select"/>
                    </div>

                    <div>
                        <div class="label">Занятие</div>
                        <xsl:apply-templates select="data/lessons" mode="select"/>
                    </div>

                    <div>
                        <div class="label">Задача</div>
                        <xsl:apply-templates select="data/tasks" mode="select"/>
                    </div>


                    <div>
                        <input type="submit" class="submit" value="Сохранить"/>
                    </div>
                </form>

                <h3>Еженедельное списывание</h3>
                <form action="weekly-karma.xml" method="post">

                    <div>
                        <div class="label">Задача</div>
                        <xsl:apply-templates select="data/tasks" mode="select"/>
                    </div>

                    <div>
                        <input type="submit" class="submit" value="Списать"/>
                    </div>
                </form>
            </xsl:otherwise>
        </xsl:choose>

        <div class="empty">&#160;</div>
    </xsl:template>

    <xsl:template match="students" mode="select">
        <select name="user-id">
            <xsl:apply-templates select="student" mode="option"/>
        </select>
    </xsl:template>

    <xsl:template match="student" mode="option">
        <option value="{@id}"><xsl:value-of select="."/></option>
    </xsl:template>

    <xsl:template match="lessons" mode="select">
        <select name="lesson-id">
            <option value="-1">-выберите занятие-</option>
            <xsl:apply-templates select="lesson" mode="option"/>
        </select>
    </xsl:template>

    <xsl:template match="lesson" mode="option">
        <option value="{@id}">
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

    <xsl:template match="tasks" mode="select">
        <select name="task-id">
            <option value="-1">-выберите задачу-</option>
            <xsl:apply-templates select="task" mode="option"/>
        </select>
    </xsl:template>

    <xsl:template match="task" mode="option">
        <option value="{@id}">
            <xsl:value-of select="module-npp"/>
            <xsl:text>. </xsl:text>
            <xsl:value-of select="name"/>
        </option>
    </xsl:template>

    <xsl:template match="karma-items" mode="select">
        <select name="karma-id">
            <xsl:apply-templates select="item" mode="option"/>
        </select>
    </xsl:template>

    <xsl:template match="item" mode="option">
        <option value="{id}">
            <xsl:choose>
                <xsl:when test="point-cnt &gt; 0">
                    <xsl:attribute name="class">green</xsl:attribute>
                    <xsl:text>(+</xsl:text>
                    <xsl:value-of select="point-cnt"/>
                    <xsl:text>) </xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="class">red</xsl:attribute>
                    <xsl:text>(</xsl:text>
                    <xsl:value-of select="point-cnt"/>
                    <xsl:text>) </xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:value-of select="description"/>
        </option>
    </xsl:template>

</xsl:stylesheet>