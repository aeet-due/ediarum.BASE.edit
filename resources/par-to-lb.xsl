<xsl:stylesheet version="3.0"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:korpora="http://www.korpora.org/aeet"
                xmlns:aeet="http://www.korpora.org/aeet"
                xmlns:telota="http://www.telota.de"
>


    <!-- default template -->
    <xsl:template mode="#all"
                  match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="tei:p[@cleanup-par = 'true']/tei:p">
        <xsl:apply-templates select="node()" mode="#current"/><lb/>
    </xsl:template>

    <xsl:template match="tei:body/p[@cleanup-par = 'true']">
        <xsl:copy>
                <xsl:apply-templates select="@*[local-name() != 'cleanup-par']" mode="#current"/>
                <xsl:apply-templates select="node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>