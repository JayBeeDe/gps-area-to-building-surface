<xsl:stylesheet version = "1.0" 
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
     <xsl:output omit-xml-declaration="yes" indent="yes"/>
     <xsl:strip-space elements="*"/>

     <xsl:output method="xml" indent="yes" omit-xml-declaration="no" />

     <xsl:template match="/">
        <result>
               <xsl:attribute name="minlat">
                    <xsl:value-of select="//bounds/@minlat"/>
               </xsl:attribute>
               <xsl:attribute name="maxlat">
                    <xsl:value-of select="//bounds/@maxlat"/>
               </xsl:attribute>
               <xsl:attribute name="minlon">
                    <xsl:value-of select="//bounds/@minlon"/>
               </xsl:attribute>
               <xsl:attribute name="maxlon">
                    <xsl:value-of select="//bounds/@maxlon"/>
               </xsl:attribute>
               <xsl:apply-templates select="//way[tag/@k='building']" />
        </result>
     </xsl:template>

     <xsl:template match="way">
               <surface>
                    <xsl:attribute name="id">
                         <xsl:value-of select="@id"/>
                    </xsl:attribute>
                    <xsl:variable name="idway">
                         <xsl:value-of select="@id"/>
                    </xsl:variable>
                    <xsl:attribute name="role">
                         <xsl:choose>
                              <xsl:when test="..//member[@ref=$idway and ../tag/@k='building']/@role"> 
                                   <xsl:value-of select="..//member[@ref=$idway and ../tag/@k='building']/@role"/>
                              </xsl:when> 
                              <xsl:otherwise>
                                   <xsl:text>inner</xsl:text>
                              </xsl:otherwise>
                         </xsl:choose>
                    </xsl:attribute>

                    <xsl:for-each select="./nd"> 
                         <xsl:variable name="refnode">
                              <xsl:value-of select="./@ref"/>
                         </xsl:variable>
                         <xsl:call-template name="node">
                              <xsl:with-param name="idnode" select="$refnode" />
                         </xsl:call-template>
                    </xsl:for-each>
               </surface>
     </xsl:template>


     <xsl:template name="node">
          <xsl:param name="idnode" select="/" />
               <point>
                    <xsl:attribute name="id">
                         <xsl:value-of select="$idnode"/>
                    </xsl:attribute>
                    <xsl:attribute name="lat">
                         <xsl:value-of select="//node[@id=$idnode]/@lat"/>
                    </xsl:attribute>
                    <xsl:attribute name="lon">
                         <xsl:value-of select="//node[@id=$idnode]/@lon"/>
                    </xsl:attribute>
               </point>
     </xsl:template>








     <xsl:template name="relation">
          <xsl:param name="memberref" select="/" />
               <xsl:attribute name="role">
                    <xsl:value-of select="//relation/member[@ref=$memberref]/role"/>
               </xsl:attribute>
     </xsl:template>
</xsl:stylesheet>