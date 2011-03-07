<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

    <xsl:output method="html" indent="yes" encoding="utf-8"
            doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
            doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

    <xsl:template match="page">
        <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
            <title>
                <xsl:text>Практика по информатике для группы 1742 ИТМО</xsl:text>
                <xsl:if test="@title">
                    <xsl:text>: </xsl:text>
                    <xsl:value-of select="@title"/>
                </xsl:if>
            </title>

            <link rel="icon" href="/students/favicon.ico" type="image/x-icon"/>
            <link rel="shortcut icon" href="/students/favicon.ico" type="image/x-icon"/>

            <link type="text/css" rel="stylesheet" href="/students/main.css"/>
            <xsl:call-template name="additional-header"/>
        </head>


        <body>
            <xsl:apply-templates select="." mode="header"/>
            <div id="content">
                <xsl:choose>
                    <xsl:when test="http-error[@status='500']">
                        <div class="error">Упс. Системная ошибка. Будем править.</div>
                    </xsl:when>
                    <xsl:when test="http-error[@status='403']">
                        <div class="error">Кажется, у Вас не достаточно прав.</div>
                    </xsl:when>
                    <xsl:when test="http-error">
                        <div class="error">Что-то совсем странное. Будем исправлять.</div>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="." mode="content"/>
                    </xsl:otherwise>
                </xsl:choose>
            </div>
            <xsl:call-template name="footer"/>
        </body>
        </html>
    </xsl:template>

    <xsl:template name="additional-header">

    </xsl:template>

    <xsl:template match="page" mode="header">
        <!--<div id="header">&#160;</div>-->
        <div id="header">
            <div class="login">
                <xsl:choose>
                    <xsl:when test="menu/data/user-info/uid">
                        <xsl:value-of select="menu/data/user-info/fio"/>
                        <xsl:text> (</xsl:text>
                        <xsl:value-of select="menu/data/user-info/login"/>
                        <xsl:text>)</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <span style="color:white">*</span>
                        <!--<form action="do-auth.xml">-->
                            <!--<xsl:text>login: </xsl:text>-->
                            <!--<input type="text" name="user-login" class="text"/>-->
                            <!--<xsl:text>pass: </xsl:text>-->
                            <!--<input type="password" name="user-passwd" class="text"/>-->
                            <!--<input type="submit" value=">>"/>-->
                        <!--</form>-->
                    </xsl:otherwise>
                </xsl:choose>

            </div>
        </div>
        <div id="menu">
            <div class="links">
                <a href="/students/index.xml">Главная</a>
                <xsl:text>&#160;&#8226;&#160;</xsl:text>
                <a href="/students/lessons.xml">Занятия</a>
                <xsl:text>&#160;&#8226;&#160;</xsl:text>
                <a href="/students/notes.xml">Читать</a>
                <xsl:text>&#160;&#8226;&#160;</xsl:text>
                <a href="/students/tasks.xml">Задачи</a>
                <xsl:text>&#160;&#8226;&#160;</xsl:text>
                <a href="/students/marks.xml">Баллы</a>
                <xsl:if test="/page/menu/data/user-info and (/page/menu/data/user-info/uid = 1 or /page/menu/data/user-info/uid = 2)">
                    <xsl:text>&#160;&#8226;&#160;</xsl:text>
                    <a href="/students/svn-logs.xml">Коммиты</a>
                </xsl:if>
            </div>
            <div class="terms">
                <xsl:for-each select="/page/menu/data/terms/term">
                    <xsl:if test="@active = 1">
                        <span><xsl:value-of select="description"/></span>
                    </xsl:if>
                </xsl:for-each>
            </div>
        </div>
    </xsl:template>

    <xsl:template name="footer">
        <div id="footer">Copyright &#169; 2010 Ольга Большакова</div>
    </xsl:template>

</xsl:stylesheet>