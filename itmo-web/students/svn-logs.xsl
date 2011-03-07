<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="common.xsl"/>

    <xsl:template match="page" mode="content">
        <xsl:choose>
            <xsl:when test="menu/data/no-auth or (menu/data/user-info/uid != 1 and menu/data/user-info/uid != 2)">
                <div class="error">Ой. А у Вас нету прав.</div>
            </xsl:when>
            <xsl:otherwise>
                <h2>Коммиты студентов</h2>
                <xsl:apply-templates select="data/history/commit" mode="div"/>
            </xsl:otherwise>
        </xsl:choose>

        <div class="empty">&#160;</div>
    </xsl:template>

    <xsl:template match="commit" mode="div">
        <div class="commit">
            <div class="head">
                <div class="date">
                    <xsl:value-of select="@when"/>
                </div>
                <div class="author">
                    <xsl:value-of select="@who"/>
                    <xsl:text> (</xsl:text>
                    <xsl:value-of select="@rev"/>
                    <xsl:text>)</xsl:text>
                </div>
            </div>
            <div class="comment">
                <pre><xsl:value-of select="comment"/></pre>
            </div>
            <div class="changes">
                <xsl:apply-templates select="changes/change" mode="div"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="change" mode="div">
        <div class="change">
            <xsl:value-of select="@type"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="@path"/>
        </div>
    </xsl:template>

    <xsl:template name="additional-header">
        <link type="text/css" rel="stylesheet" href="svn-logs.css"/>

    </xsl:template>

</xsl:stylesheet>
