<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://purl.org/rss/2.0/">

<xsl:output method="text" encoding="UTF-8"
            omit-xml-declaration="yes"
            indent="no"/>




<xsl:template match="/rss/channel/item">
  <xsl:text>title:</xsl:text>
  <xsl:value-of select="normalize-space(translate(title, '&#x0A;', ' '))"/>
  <xsl:text>&#x09;</xsl:text>
  <xsl:text>link:</xsl:text>
  <xsl:value-of select="normalize-space(translate(link, '&#x0A;', ' '))"/>
  <xsl:text>&#x09;</xsl:text>
  <xsl:text>category:</xsl:text>
  <xsl:value-of select="normalize-space(translate(category, '&#x0A;', ' '))"/>
  <xsl:text>&#x09;</xsl:text>
  <xsl:text>date:</xsl:text>
  <xsl:value-of select="normalize-space(translate(pubDate, '&#x0A;', ' '))"/>
  <xsl:text>&#x09;</xsl:text>
  <xsl:text>description:</xsl:text>
  <xsl:value-of select="normalize-space(translate(description, '&#x0A;', ' '))"/>
  <xsl:text>&#x0A;</xsl:text>
</xsl:template>

<xsl:template match="@*|text()">
  <!-- 余計なテキストは出さない -->
</xsl:template>




</xsl:stylesheet>
