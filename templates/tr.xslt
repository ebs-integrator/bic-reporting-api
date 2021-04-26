<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:import href="./credit_report_ro.xsl"/>

    <xsl:output method="html" media-type="text/html" version="4.0" encoding="utf-8"/>

    <xsl:template match="/">
        <xsl:if test="string(/root/language)='ro'">
            <xsl:call-template name="raportCredit">
                <xsl:with-param name="situatiaInscrierii">false</xsl:with-param>
                <xsl:with-param name="forEmail">false</xsl:with-param>
            </xsl:call-template>
        </xsl:if>

    </xsl:template>

</xsl:stylesheet>
