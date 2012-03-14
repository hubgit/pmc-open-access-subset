<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0" 
    xmlns:xlink="http://www.w3.org/1999/xlink" 
    exclude-result-prefixes="xlink">
    
  <xsl:output nethod="xml" encoding="utf-8" omit-xml-declaration="yes" standalone="yes" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <meta charset="utf-8"/>
        <title><xsl:value-of select="article/front/article-meta/title-group/article-title[1]"/></title>
        <link rel="stylesheet" href="../style.css"/>
      </head>
      <body>
        <xsl:apply-templates select="article/body"/>
        <script src="../script.js"></script>
      </body>
    </html>
  </xsl:template>

  <!-- inline elements -->
  <xsl:template match="italic | bold | sc | strike | sub | sup | underline | abbrev | surname | given-names | email | label | year | month | day | xref">
    <span class="{local-name()}">
      <xsl:apply-templates select="node()|@*"/>
    </span>
  </xsl:template>

  <!-- links -->
  <xsl:template match="ext-link">
    <a class="{local-name()}" href="{@xlink:href}">
      <xsl:apply-templates select="node()|@*"/>
    </a>
  </xsl:template>

  <!-- remove references -->
  <!--<xsl:template match="xref"></xsl:template>-->

  <!-- block elements -->
  <xsl:template match="*">
    <div class="{local-name()}">
      <xsl:apply-templates select="node()|@*"/>
    </div>
  </xsl:template>

  <!-- attributes -->
  <xsl:template match="@*">
    <xsl:if test="name() != 'class'">
      <xsl:copy-of select="."/>            
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
