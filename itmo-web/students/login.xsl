<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

    <xsl:import href="common.xsl"/>

    <xsl:template match="page" mode="content">
        <xsl:choose>
            <xsl:when test="data/user-info/uid">
                <div>
                    <xsl:text>Вы есть </xsl:text>
                    <xsl:value-of select="data/user-info/fio"/>
                    <xsl:text> (</xsl:text>
                    <xsl:value-of select="data/user-info/login"/>
                    <xsl:text>)</xsl:text>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div>Вы не залогинены</div>
            </xsl:otherwise>
        </xsl:choose>
        <form action="do-auth.xml">
            <input type="text" name="user-login"/><br/>
            <input type="password" name="user-passwd"/><br/>
            <input type="hidden" name="redir" value="login.xml"/><br/>
            <input type="submit" value="войти"/>
        </form>
    </xsl:template>

    <!--<xsl:template match="/">-->
        <!--<html>-->
        <!--<head>-->
            <!--<title>obolshakova.ru</title>-->
            <!--&lt;!&ndash;<link type="text/css" rel="stylesheet" href="basket.css"/>&ndash;&gt;-->
        <!--</head>-->
        <!--<body>-->
            <!--<xsl:choose>-->
                <!--<xsl:when test="page/data/user-info/uid">-->
                    <!--<div>-->
                        <!--<xsl:text>Вы есть </xsl:text>-->
                        <!--<xsl:value-of select="page/data/user-info/fio"/>-->
                        <!--<xsl:text> (</xsl:text>-->
                        <!--<xsl:value-of select="page/data/user-info/login"/>-->
                        <!--<xsl:text>)</xsl:text>-->
                    <!--</div>-->
                <!--</xsl:when>-->
                <!--<xsl:otherwise>-->
                    <!--<div>Вы не залогинены</div>-->
                <!--</xsl:otherwise>-->
            <!--</xsl:choose>-->
            <!--<form action="do-auth.xml">-->
                <!--<input type="text" name="user-login"/><br/>-->
                <!--<input type="password" name="user-passwd"/><br/>-->
                <!--<input type="hidden" name="redir" value="login.xml"/><br/>-->
                <!--<input type="submit" value="войти"/>-->
            <!--</form>-->
        <!--</body>-->
        <!--</html>-->
    <!--</xsl:template>-->

</xsl:stylesheet>