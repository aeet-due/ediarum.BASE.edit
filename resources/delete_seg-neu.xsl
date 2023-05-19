<?xml version="1.0" encoding="UTF-8"?>
<!-- 
Copyright 2013 Berlin-Brandenburg Academy of Sciences and Humanities

This file is part of ediarum.FS.

ediarum.FS is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published 
by the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

ediarum.FS is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with ediarum.FS. If not, see <http://www.gnu.org/licenses/>.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="3.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:oxy="http://www.oxygenxml.com/ns/author/xpath-extension-functions" 
    exclude-result-prefixes="oxy">
    
    <xsl:param name="currentElementLocation"/>
    

    <xsl:variable name="note_id" select="oxy:current-element()/ancestor-or-self::seg/note/@xml:id" />
   
    <!--xsl:variable name="note_id"><xsl:value-of select="saxon:eval(saxon:expression($currentElementLocation))/ancestor-or-self::seg/note/@xml:id"/></xsl:variable-->

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Index löschen, wenn xml:id übereinstimmt, ansonsten auch kopieren -->
    <xsl:template match="seg[/note/@xml:id = $note_id]">
                <xsl:apply-templates select="node()" mode="currentseg" />
    </xsl:template>
    
    <xsl:template match="orig" mode="currentseg">
        <xsl:apply-templates select="node()" />
    </xsl:template>
    
    <xsl:template match="note" mode="currentseg" />
    
        
</xsl:stylesheet>