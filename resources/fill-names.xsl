<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs math xd"
    version="3.0">
    <!-- java -jar $HOME/lib/saxon/saxon-he-12.2.jar -xsl:fill-names.xsl -s:$HOME/lib/oxygen-frameworks/aeetiarum/daten/1918-09-01\ Bromberg\ kor.xml  index=$PWD/AEET-Personen.xml -->
    <xsl:param name="index"/>
    <xsl:variable name="index-doc" select="document($index)"/>

    <xsl:template match="@*|node()">
        <xsl:copy><xsl:apply-templates select="@*|node()" /></xsl:copy>
    </xsl:template>
    
    <xsl:variable name="root" select="/"/>
    <xsl:template match="/">
        <xsl:apply-templates select="@*|node()"/>
    </xsl:template>
    
    
    <xsl:template match="tei:list[@xml:id = 'namen'] | tei:list[parent::tei:cell/preceding-sibling::tei:cell[. = 'Namen']]">
        <xsl:variable name="keys"
            select="distinct-values($root/tei:TEI//tei:body//tei:persName/@key)"/>
        <xsl:variable name="names">
            <xsl:for-each select="$keys">
                <xsl:variable name="key" select="."/>
                <xsl:variable name="entry" select="$index-doc//li[@xml:id=$key]"/>
                <xsl:element name="item">
                    <xsl:choose>
                        <xsl:when test="starts-with($entry/span, '!Unbekannt!')">
                            <xsl:for-each select="string-join(distinct-values(normalize-space($root//tei:persName[@key = $key])), ', ')">
                                <xsl:element name="tei:persName">
                                    <xsl:attribute name="key" select="$key"/>
                                    <xsl:copy-of select="."/> [<xsl:copy-of select="$entry/normalized/node()"/>]</xsl:element>
                             </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:element name="tei:persName">
                                <xsl:attribute name="key" select="$key"/>
                                <xsl:copy-of select="$entry/normalized/node()"/>
                            </xsl:element>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:element>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy>
            <xsl:for-each select="sort($names/*,
                'http://www.w3.org/2013/collation/UCA?lang=de;strength=primary')">
                <xsl:copy-of select="."></xsl:copy-of><xsl:text>
                </xsl:text>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>