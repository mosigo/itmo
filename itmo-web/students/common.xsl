<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output method="html" indent="yes" encoding="windows-1251"/>

    <xsl:key match="/page/items/item" name="item" use="@uid"/>

    <xsl:template match="/">
        <html>
        <head>
            <title>obolshakova.ru</title>
            <link type="text/css" rel="stylesheet" href="basket.css"/>
        </head>
        <body>
            <xsl:call-template name="main"/>
        </body>
        </html>
    </xsl:template>

</xsl:stylesheet>