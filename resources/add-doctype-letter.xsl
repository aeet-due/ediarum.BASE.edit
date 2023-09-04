<xsl:stylesheet version="3.0"
                xmlns="http://www.tei-c.org/ns/1.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:korpora="http://www.korpora.org/aeet"
                xmlns:aeet="http://www.korpora.org/aeet"
                xmlns:telota="http://www.telota.de"
>

    <xsl:variable name="opener">
        <opener>
            <?oxy_comment_start author="Bernhard Fisseni" comment="Sie dürfen die Elemente auch veschieben bzw. löschen und über ediarum → Brieftext wieder einfügen."?>
            <dateline/><?oxy_comment_end?>
            <salute/>
        </opener>
    </xsl:variable>
    <xsl:variable name="closer">
        <closer>
            <salute/>
            <?oxy_comment_start author="Bernhard Fisseni" comment="Mit ediarum → Brieftext → können Sie ein Postscriptum hinzufügen."?>
            <signed/><?oxy_comment_end?>
        </closer>
    </xsl:variable>

    <!-- default template -->
    <xsl:template mode="#all"
                  match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>


    <xsl:template match="tei:TEI[@telota:doctype = 'letter']"><xsl:message select="error((), 'Dokument ist schon ein Brief!')"/>'Dokument ist schon ein Brief!'</xsl:template>

    <xsl:template match="tei:TEI[@telota:doctype != 'letter']">
        <xsl:copy>
            <xsl:attribute name="telota:doctype">letter</xsl:attribute>
            <xsl:apply-templates select="@* except @telota:doctype|node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="tei:body">
        <xsl:copy>
            <div type="writingSession">
                <xsl:apply-templates select="@*" mode="#current"/>
                <xsl:copy-of select="$opener"/>
                <xsl:apply-templates select="node()" mode="#current"/>
                <xsl:copy-of select="$closer"/>
            </div>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>