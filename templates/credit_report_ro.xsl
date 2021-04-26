<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
   <xsl:import href="Copyright_ro.xsl" />
   <xsl:output method="html" media-type="text/html" version="4.0" encoding="utf-8" />
   <xsl:strip-space elements="root" />
   <xsl:decimal-format name="european" decimal-separator="," grouping-separator="." />
   <xsl:template name="showError">
      <xsl:param name="errorMessage" />
      <xsl:param name="errorDetails" />
      <xsl:param name="loginDetails" />
      <xsl:param name="forEmail" />
      <xsl:if test="string(/root/language)='ro'">
         <xsl:if test="string($loginDetails) = '' and string($errorDetails) = ''">
            <font color="red" size="3">A aparut o eroare in timpul executiei. Solicitarea de raport de credit nu a fost luata in considerare pentru facturare.</font>
            <br />
            <br />
            <br />
         </xsl:if>
         <xsl:if test="string($loginDetails) != ''">
            <link rel="stylesheet" href="media/css/sivabon.css">
               <xsl:attribute name="href">
                  <xsl:if test="$forEmail='true'">cid:sivabon.css</xsl:if>
                  <xsl:if test="$forEmail!='true'">media/css/sivabon.css</xsl:if>
               </xsl:attribute>
            </link>
            <br />
            <br />
            <p align="center" class="Head">
               <xsl:value-of select="$loginDetails" />
            </p>
            <br />
            <br />
            <form target="_top" action="/sivabon_md/">
               <input type="submit" class="Head" value="Login" />
            </form>
         </xsl:if>
         <xsl:if test="string($errorDetails) != ''">
            <link rel="stylesheet" href="media/css/sivabon.css">
               <xsl:attribute name="href">
                  <xsl:if test="$forEmail='true'">cid:sivabon.css</xsl:if>
                  <xsl:if test="$forEmail!='true'">media/css/sivabon.css</xsl:if>
               </xsl:attribute>
            </link>
            <br />
            <br />
            <p align="center" class="Head">
               <xsl:value-of select="$errorDetails" />
            </p>
            <br />
            <br />
            <br />
         </xsl:if>
      </xsl:if>
   </xsl:template>
   <xsl:template name="accounts_summary_table">
      <xsl:param name="ParticipantTypeName" />
      <xsl:param name="ParticipantTypeCode" />
      <xsl:if test="string(/root/language)='ro'">
         <xsl:if test="string(accounts_summary/account[participant/type/@code=$ParticipantTypeCode ] )!=''">
            <tr>
               <td>
                  Tip Sursa de formare:
                  <xsl:value-of select="$ParticipantTypeName" />
               </td>
            </tr>
            <tr>
               <td>
                  <table border="0" width="100%" cellpadding="2" cellspacing="0" style="border: 1px outset #000000">
                     <tr>
                        <td class="creditReportCellHeaderSmall">Sursa de formare</td>
                        <td class="creditReportCellHeaderSmall" width="16">
                           Acord
                           <br />
                           semnat
                        </td>
                        <td class="creditReportCellHeaderSmall" width="95">Tip portofoliu</td>
                        <td class="creditReportCellHeaderSmall">Stare cont</td>
                        <td class="creditReportCellHeaderSmall" width="70">
                           Data ultimei
                           <br />
                           actualizari
                        </td>
                        <td class="creditReportCellHeaderSmall" width="35">Valuta</td>
                        <td class="creditReportCellHeaderSmall" width="75">
                           Limita
                           <br />
                           credit
                        </td>
                        <td class="creditReportCellHeaderSmall" width="75">
                           Valoare
                           <br />
                           imprumut
                        </td>
                        <td class="creditReportCellHeaderSmall" width="75">
                           Sold
                           <br />
                           curent
                        </td>
                        <td class="creditReportCellHeaderSmall" width="75">
                           Suma
                           <br />
                           obligatiilor restante
                        </td>
                        <td class="creditReportCellHeaderSmall" width="75">
                           Frecventa
                           <br />
                           plati
                        </td>
                        <td class="creditReportCellHeaderSmall">Informatii detaliate cont</td>
                     </tr>
                     <xsl:for-each select="accounts_summary/account[ ( participant/type/@code=$ParticipantTypeCode ) ]">
                        <tr>
                           <td class="creditReportCellDataSmall" align="center">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                              <xsl:value-of select="participant/label" />
                           </td>
                           <td class="creditReportCellDataSmall" align="center">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                              <xsl:value-of select="process_indicator" />
                           </td>
                           <td class="creditReportCellDataSmall wrapped" align="center">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                              <xsl:value-of select="document_type" />
                           </td>
                           <td class="creditReportCellDataSmall wrapped" align="left">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                              <xsl:value-of select="account_status" />
                           </td>
                           <td class="creditReportCellDataSmall" align="center">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                              <xsl:value-of select="last_updated_on" />
                           </td>
                           <td class="creditReportCellDataSmall" align="center">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                              <xsl:value-of select="document_currency/@code" />
                           </td>
                           <td class="creditReportCellDataSmall" align="right">
                              <!-- credit_limit -->
                              <xsl:call-template name="currencyFormat">
                                 <xsl:with-param name="value">
                                    <xsl:value-of select="credit_limit" />
                                 </xsl:with-param>
                              </xsl:call-template>
                           </td>
                           <td class="creditReportCellDataSmall" align="right">
                              <!-- initial_value -->
                              <xsl:call-template name="currencyFormat">
                                 <xsl:with-param name="value">
                                    <xsl:value-of select="initial_value" />
                                 </xsl:with-param>
                              </xsl:call-template>
                           </td>
                           <td class="creditReportCellDataSmall" align="right">
                              <!-- current_balance -->
                              <xsl:call-template name="currencyFormat">
                                 <xsl:with-param name="value">
                                    <xsl:value-of select="current_balance" />
                                 </xsl:with-param>
                              </xsl:call-template>
                           </td>
                           <td class="creditReportCellDataSmall" align="right">
                              <!-- amount_past_due -->
                              <xsl:call-template name="currencyFormat">
                                 <xsl:with-param name="value">
                                    <xsl:value-of select="amount_past_due" />
                                 </xsl:with-param>
                              </xsl:call-template>
                           </td>
                           <td class="creditReportCellDataSmall" align="center">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                              <xsl:value-of select="terms_frequency" />
                           </td>
                           <td class="creditReportCellDataSmall" align="center">
                              <xsl:if test="string(document_label) != ''">
                                 <a>
                                    <xsl:attribute name="href">
                                       #Account
                                       <xsl:value-of select="anchor" />
                                    </xsl:attribute>
                                    <font size="-2">
                                       <xsl:value-of select="document_label" />
                                    </font>
                                 </a>
                              </xsl:if>
                              <xsl:if test="string(document_label) = ''">
                                 <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                              </xsl:if>
                           </td>
                        </tr>
                     </xsl:for-each>
                     <xsl:if test="count(accounts_summary/account[participant/type/@code=$ParticipantTypeCode])&lt;3">
                        <tr>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                        </tr>
                     </xsl:if>
                     <xsl:if test="count(accounts_summary/account[participant/type/@code=$ParticipantTypeCode])&lt;2">
                        <tr>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                        </tr>
                     </xsl:if>
                     <xsl:if test="count(accounts_summary/account[participant/type/@code=$ParticipantTypeCode])&lt;1">
                        <tr>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                           <td class="creditReportCellDataSmall">
                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                           </td>
                        </tr>
                     </xsl:if>
                  </table>
               </td>
            </tr>
         </xsl:if>
      </xsl:if>
   </xsl:template>
   <xsl:template name="integerFormat">
      <xsl:param name="value" />
      <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
      <xsl:if test="string(format-number($value, '###.##0', 'european'))!='NaN'">
         <xsl:value-of select="format-number($value, '###.##0', 'european')" />
      </xsl:if>
      <xsl:if test="string(format-number($value, '###.##0', 'european'))='NaN'">
         <font color="red">
            <xsl:value-of select="$value" />
         </font>
      </xsl:if>
   </xsl:template>
   <xsl:template name="currencyFormat">
      <xsl:param name="value" />
      <xsl:if test="string($value)=''">
         <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
      </xsl:if>
      <xsl:if test="string(format-number($value, '###.##0', 'european'))!='NaN'">
         <xsl:value-of select="format-number($value, '###.##0', 'european')" />
      </xsl:if>
      <xsl:if test="string(format-number($value, '###.##0', 'european'))='NaN'">
         <font color="red">
            <xsl:value-of select="$value" />
         </font>
      </xsl:if>
   </xsl:template>
   <xsl:template name="downloadXML">
      <xsl:param name="downloadURL" />
      <xsl:if test="string(/root/language)='ro'">
         <br />
         Numar de inregistrare: ______________________
         <br />
         <br />
         <br />
         Pentru download apasa
         <a>
            <xsl:attribute name="href">
               <xsl:value-of select="$downloadURL" />
            </xsl:attribute>
            aici
         </a>
      </xsl:if>
   </xsl:template>
   <xsl:template name="searchField">
      <xsl:param name="cr_Value" />
      <xsl:param name="personal_data_Value" />
      <xsl:param name="personal_data_idno_idnp" />
      <xsl:if test="string($personal_data_idno_idnp)!=''">
         <xsl:if test="string($personal_data_Value)=string($cr_Value)">
            <td class="creditReportFoundBy" valign="center">
               <xsl:value-of select="$personal_data_Value" />
            </td>
         </xsl:if>
         <xsl:if test="string($personal_data_Value)!=string($cr_Value)">
            <xsl:if test="string($cr_Value)!=''">
               <td class="creditReportNotFoundBy" valign="center">
                  <xsl:value-of select="$personal_data_Value" />
               </td>
            </xsl:if>
            <xsl:if test="string($cr_Value)=''">
               <td class="creditReportContentBlack" valign="center">
                  <xsl:value-of select="$personal_data_Value" />
               </td>
            </xsl:if>
         </xsl:if>
      </xsl:if>
      <xsl:if test="string($personal_data_idno_idnp)=''">
         <td class="creditReportNotFoundBy" valign="center">
            <xsl:value-of select="$cr_Value" />
         </td>
      </xsl:if>
   </xsl:template>
   <xsl:template name="stripPath">
      <xsl:param name="source" />
      <xsl:if test="contains( string($source), '/' )">
         <xsl:call-template name="stripPath">
            <xsl:with-param name="source"><xsl:value-of select="substring-after($source,'/')" /></xsl:with-param>
         </xsl:call-template>
      </xsl:if>
      <xsl:if test="not( contains( string($source), '/' ) )"><xsl:value-of select="$source" /></xsl:if>
   </xsl:template>
   <xsl:template name="resource">
      <xsl:param name="source" />
      <xsl:param name="forEmail" />
      <xsl:if test="$forEmail='true'">cid:<xsl:value-of select="$source" />
      </xsl:if>
      <xsl:if test="$forEmail!='true'"> media/img/<xsl:value-of select="$source" />
      </xsl:if>
   </xsl:template>
   <xsl:template name="raportCredit">
      <xsl:param name="situatiaInscrierii" />
      <xsl:param name="forEmail" />
      <xsl:if test="string(/root/language)='ro'">
         <html>
            <head>
               <title>
                  <xsl:if test="string($situatiaInscrierii)!='true'">
                     <xsl:if test="string(cr_request/extras_type)='AllSection'">Raport de Credit</xsl:if>
                     <xsl:if test="string(cr_request/extras_type)='EX-A'">Extras tip A</xsl:if>
                     <xsl:if test="string(cr_request/extras_type)='EX-B'">Extras tip B</xsl:if>
                     <xsl:if test="string(cr_request/extras_type)='EX-C'">Extras tip C</xsl:if>
                     <xsl:if test="string(cr_request/extras_type)='EX-D'">Extras tip D</xsl:if>
                     <xsl:if test="string(cr_request/extras_type)='EX-E'">Extras tip E</xsl:if>
                     <xsl:value-of select="cr_request/extras_description" />
                     eliberat utilizatorului istoriei de credit
                  </xsl:if>
                  <xsl:if test="string($situatiaInscrierii)='true'">
                     <xsl:if test="string(cr_request/extras_type)='AllSection'">Raport de Credit</xsl:if>
                     <xsl:if test="string(cr_request/extras_type)='EX-A'">Extras tip A</xsl:if>
                     <xsl:if test="string(cr_request/extras_type)='EX-B'">Extras tip B</xsl:if>
                     <xsl:if test="string(cr_request/extras_type)='EX-C'">Extras tip C</xsl:if>
                     <xsl:if test="string(cr_request/extras_type)='EX-D'">Extras tip D</xsl:if>
                     <xsl:if test="string(cr_request/extras_type)='EX-E'">Extras tip E</xsl:if>
                     <xsl:value-of select="cr_request/extras_description" />
                     eliberat subiectului istoriei de credit
                  </xsl:if>
               </title>
               <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
               <link rel="stylesheet" href="media/css/sivabon.css">
                  <xsl:attribute name="href">
                     <xsl:if test="$forEmail='true'">cid:sivabon.css</xsl:if>
                     <xsl:if test="$forEmail!='true'">media/css/sivabon.css</xsl:if>
                  </xsl:attribute>
               </link>
            </head>
            <body style="background-color:white">
               <xsl:if test="string(/root/error)!=''">
                  <table border="0" cellpadding="0" cellspacing="0" align="center" width="100%" height="80%">
                     <tr>
                        <td>
                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                        </td>
                     </tr>
                     <tr>
                        <td valign="middle" align="center">
                           <xsl:call-template name="showError">
                              <xsl:with-param name="errorMessage">
                                 <xsl:value-of select="string(/root/error)" />
                              </xsl:with-param>
                              <xsl:with-param name="errorDetails">
                                 <xsl:value-of select="string(/root/error/errorDetails)" />
                              </xsl:with-param>
                              <xsl:with-param name="loginDetails">
                                 <xsl:value-of select="string(/root/error/loginDetails)" />
                              </xsl:with-param>
                              <xsl:with-param name="forEmail">
                                 <xsl:value-of select="$forEmail" />
                              </xsl:with-param>
                           </xsl:call-template>
                        </td>
                     </tr>
                  </table>
               </xsl:if>
               <xsl:if test="string(/root/error)=''">
                  <!-- error != '' -->
                  <table border="0" cellpadding="0" cellspacing="0" align="center">
                     <tr>
                        <td>
                           <img border="0" width="20" height="1">
                              <xsl:attribute name="src">
                                 <xsl:call-template name="resource">
                                    <xsl:with-param name="source">void.gif</xsl:with-param>
                                    <xsl:with-param name="forEmail">
                                       <xsl:value-of select="$forEmail" />
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:attribute>
                           </img>
                        </td>
                        <td valign="top">
                           <table border="0" width="100%" align="center">
                              <form name="rc" action="#">
                                 <xsl:for-each select="/root/credit_reports/credit_report">
                                    <tr>
                                       <td align="left">
                                          <img style="max-width: 200px;">
                                             <xsl:attribute name="src">
                                                <xsl:call-template name="resource">
                                                   <xsl:with-param name="source">logo.gif</xsl:with-param>
                                                   <xsl:with-param name="forEmail">
                                                      <xsl:value-of select="$forEmail" />
                                                   </xsl:with-param>
                                                </xsl:call-template>
                                             </xsl:attribute>
                                          </img>
                                       </td>
                                    </tr>
                                    <tr>
                                       <td align="left">
                                          <xsl:if test="string(download_url)!=''">
                                             <xsl:call-template name="downloadXML">
                                                <xsl:with-param name="downloadURL">
                                                   <xsl:value-of select="string(download_url)" />
                                                </xsl:with-param>
                                             </xsl:call-template>
                                          </xsl:if>
                                       </td>
                                    </tr>
                                    <xsl:if test="count(cr_signature)&gt;0">
                                       <tr>
                                          <td align="left">
                                             <table border="0" style="border: 0px solid #000000" class="tableType1">
                                                <tr>
                                                   <td>
                                                      <xsl:element name="input">
                                                         <xsl:attribute name="type">hidden</xsl:attribute>
                                                         <xsl:attribute name="id">
                                                            cr_signature
                                                            <xsl:value-of select="position()" />
                                                         </xsl:attribute>
                                                         <xsl:attribute name="value">
                                                            <xsl:value-of select="cr_signature" />
                                                         </xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:element name="input">
                                                         <xsl:attribute name="type">hidden</xsl:attribute>
                                                         <xsl:attribute name="id">
                                                            cr_initialCreditReport
                                                            <xsl:value-of select="position()" />
                                                         </xsl:attribute>
                                                         <xsl:attribute name="value">
                                                            <xsl:value-of select="cr_initialCreditReport" />
                                                         </xsl:attribute>
                                                      </xsl:element>
                                                      <xsl:element name="span">
                                                         <xsl:attribute name="id">
                                                            validationWaitingSpan
                                                            <xsl:value-of select="position()" />
                                                         </xsl:attribute>
                                                         Va rugam sa asteptati pana la incarcarea applet-ului de validare a semnaturii digitale …
                                                      </xsl:element>
                                                      <xsl:element name="span">
                                                         <xsl:attribute name="id">
                                                            validationReadySpan
                                                            <xsl:value-of select="position()" />
                                                         </xsl:attribute>
                                                         <xsl:attribute name="style">display:none;</xsl:attribute>
                                                         Pentru validare semnatura digitala apasa
                                                      </xsl:element>
                                                      <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                      <xsl:element name="a">
                                                         <xsl:attribute name="id">
                                                            validationReadyLink
                                                            <xsl:value-of select="position()" />
                                                         </xsl:attribute>
                                                         <xsl:attribute name="href">#</xsl:attribute>
                                                         <xsl:attribute name="style">display:none</xsl:attribute>
                                                         <xsl:attribute name="onclick">
                                                            javascript:validateDocument(
                                                            <xsl:value-of select="position()" />
                                                            )
                                                         </xsl:attribute>
                                                         aici
                                                      </xsl:element>
                                                   </td>
                                                   <td>
                                                      <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                   </td>
                                                   <td>
                                                      <img height="40" style="display:none">
                                                         <xsl:attribute name="id">
                                                            valid
                                                            <xsl:value-of select="position()" />
                                                         </xsl:attribute>
                                                         <xsl:attribute name="src">
                                                            <xsl:call-template name="resource">
                                                               <xsl:with-param name="source">valid.gif</xsl:with-param>
                                                               <xsl:with-param name="forEmail">
                                                                  <xsl:value-of select="$forEmail" />
                                                               </xsl:with-param>
                                                            </xsl:call-template>
                                                         </xsl:attribute>
                                                      </img>
                                                      <img height="40" style="display:none">
                                                         <xsl:attribute name="id">
                                                            invalid
                                                            <xsl:value-of select="position()" />
                                                         </xsl:attribute>
                                                         <xsl:attribute name="src">
                                                            <xsl:call-template name="resource">
                                                               <xsl:with-param name="source">invalid.gif</xsl:with-param>
                                                               <xsl:with-param name="forEmail">
                                                                  <xsl:value-of select="$forEmail" />
                                                               </xsl:with-param>
                                                            </xsl:call-template>
                                                         </xsl:attribute>
                                                      </img>
                                                   </td>
                                                   <td>
                                                      <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                   </td>
                                                   <td>
                                                      <span style="display:none">
                                                         <xsl:attribute name="id">
                                                            signatureValidationMessage
                                                            <xsl:value-of select="position()" />
                                                         </xsl:attribute>
                                                      </span>
                                                   </td>
                                                </tr>
                                             </table>
                                          </td>
                                       </tr>
                                    </xsl:if>
                                    <!-- count signature -->
                                    <tr>
                                       <td valign="top">
                                          <table border="0">
                                             <tr>
                                                <td>
                                                   <xsl:if test="string(error)!=''">
                                                      <table border="0" cellpadding="0" cellspacing="0" align="center" width="100%" height="80%">
                                                         <tr>
                                                            <td>
                                                               <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                            </td>
                                                         </tr>
                                                         <tr>
                                                            <td valign="middle" align="center">
                                                               <xsl:call-template name="showError">
                                                                  <xsl:with-param name="errorMessage">
                                                                     <xsl:value-of select="string(error)" />
                                                                  </xsl:with-param>
                                                                  <xsl:with-param name="errorDetails">
                                                                     <xsl:value-of select="string(error/errorDetails)" />
                                                                  </xsl:with-param>
                                                                  <xsl:with-param name="loginDetails">
                                                                     <xsl:value-of select="string(error/loginDetails)" />
                                                                  </xsl:with-param>
                                                                  <xsl:with-param name="forEmail">
                                                                     <xsl:value-of select="$forEmail" />
                                                                  </xsl:with-param>
                                                               </xsl:call-template>
                                                            </td>
                                                         </tr>
                                                      </table>
                                                   </xsl:if>
                                                   <xsl:if test="string(error)=''">
                                                      <xsl:variable name="cr_customer_type_desc" select="cr_request/customer_type_desc" />
                                                      <xsl:variable name="cr_idno_idnp" select="cr_request/idno_idnp" />
                                                      <xsl:variable name="cr_inq_purpose" select="cr_request/inquiry_purpose" />
                                                      <xsl:variable name="cr_id" select="cr_request/id" />
                                                      <xsl:variable name="found_result" select="&quot;false&quot;" />
                                                      <xsl:variable name="customer_type_code" select="personal_data/customer_type/@code" />
                                                      <xsl:variable name="cr_extras_selection" select="cr_request/extras_selection" />
                                                      <xsl:variable name="cr_extras_type" select="cr_request/extras_type" />
                                                      <xsl:variable name="cr_extras_desc" select="cr_request/extras_description" />
                                                      <xsl:if test="count(specimen) &gt; 0">
                                                         <tr>
                                                            <td align="center">
                                                               <font color="red" size="6">
                                                                  <xsl:value-of select="specimen" />
                                                               </font>
                                                            </td>
                                                         </tr>
                                                      </xsl:if>
                                                      <tr>
                                                         <td class="creditReportHeadBlack" align="center" />
                                                      </tr>
                                                      <xsl:if test="string($situatiaInscrierii)!='true'">
                                                         <xsl:if test="string(cr_request/extras_type)!=''">
                                                            <td class="creditReportHeadBlack" align="center">
                                                               <xsl:if test="string(cr_request/extras_type)='AllSection'" />
                                                               <xsl:if test="string(cr_request/extras_type)='EX-A'" />
                                                               <xsl:if test="string(cr_request/extras_type)='EX-B'" />
                                                               <xsl:if test="string(cr_request/extras_type)='EX-C'" />
                                                               <xsl:if test="string(cr_request/extras_type)='EX-D'" />
                                                               <xsl:if test="string(cr_request/extras_type)='EX-E'" />
                                                               <h4>
                                                                  <xsl:value-of select="cr_request/extras_description" />
                                                               </h4>
                                                               eliberat utilizatorului istoriei de credit
                                                            </td>
                                                         </xsl:if>
                                                      </xsl:if>
                                                      <xsl:if test="string($situatiaInscrierii)='true'">
                                                         <td class="creditReportHeadBlack" align="center">
                                                            <xsl:if test="string(cr_request/extras_type)='AllSection'">Raport de Credit</xsl:if>
                                                            <xsl:if test="string(cr_request/extras_type)='EX-A'">Extras tip A</xsl:if>
                                                            <xsl:if test="string(cr_request/extras_type)='EX-B'">Extras tip B</xsl:if>
                                                            <xsl:if test="string(cr_request/extras_type)='EX-C'">Extras tip C</xsl:if>
                                                            <xsl:if test="string(cr_request/extras_type)='EX-D'">Extras tip D</xsl:if>
                                                            <xsl:if test="string(cr_request/extras_type)='EX-E'">Extras tip E</xsl:if>
                                                            <xsl:value-of select="cr_request/extras_description" />
                                                            eliberat
                                                            <br />
                                                            subiectului istoriei de credit
                                                         </td>
                                                      </xsl:if>
                                                      <!-- Start Personal Data-->
                                                      <!-- start of GENERAL_DATA section -->
                                                      <xsl:if test="string(cr_request/extras_general_data)='true'">
                                                         <tr>
                                                            <td align="center">
                                                               <table border="0" bgcolor="#FFFFB7" style="border: 1px solid #000000" class="tableType1">
                                                                  <tr>
                                                                     <td align="right" valign="top" class="creditReportHeadBlack">IDNO/IDNP:</td>
                                                                     <!-- idno_idnp section -->
                                                                     <xsl:call-template name="searchField">
                                                                        <xsl:with-param name="personal_data_Value">
                                                                           <xsl:value-of select="personal_data/idno_idnp" />
                                                                        </xsl:with-param>
                                                                        <xsl:with-param name="cr_Value">
                                                                           <xsl:value-of select="$cr_idno_idnp" />
                                                                        </xsl:with-param>
                                                                        <xsl:with-param name="personal_data_idno_idnp">
                                                                           <xsl:value-of select="personal_data/idno_idnp" />
                                                                        </xsl:with-param>
                                                                     </xsl:call-template>
                                                                     <td>
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </td>
                                                                     <td align="right" class="creditReportHeadBlack" valign="top">Tip subiect:</td>
                                                                     <xsl:call-template name="searchField">
                                                                        <!-- customer_type_section -->
                                                                        <xsl:with-param name="personal_data_Value">
                                                                           <xsl:value-of select="personal_data/customer_type" />
                                                                        </xsl:with-param>
                                                                        <xsl:with-param name="cr_Value">
                                                                           <xsl:value-of select="$cr_customer_type_desc" />
                                                                        </xsl:with-param>
                                                                        <xsl:with-param name="personal_data_idno_idnp">
                                                                           <xsl:value-of select="personal_data/idno_idnp" />
                                                                        </xsl:with-param>
                                                                     </xsl:call-template>
                                                                  </tr>
                                                                  <tr>
                                                                     <td align="right" valign="center" class="creditReportHeadBlack">Nume si Prenume:</td>
                                                                     <td valign="center">
                                                                        <table border="0">
                                                                           <tr>
                                                                              <td class="creditReportContentBlack" valign="center">
                                                                                 <xsl:value-of select="personal_data/last_name" />
                                                                              </td>
                                                                              <td class="creditReportHeadBlack">
                                                                                 <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              </td>
                                                                              <td class="creditReportContentBlack" valign="center">
                                                                                 <xsl:value-of select="personal_data/first_name" />
                                                                              </td>
                                                                           </tr>
                                                                        </table>
                                                                     </td>
                                                                     <td>
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </td>
                                                                     <td align="right" class="creditReportHeadBlack" valign="center">Patronimic:</td>
                                                                     <td class="creditReportContentBlack" valign="center">
                                                                        <xsl:value-of select="personal_data/father_name" />
                                                                     </td>
                                                                  </tr>
                                                                  <xsl:if test="count(./personal_data)!=0 and $customer_type_code='C'">
                                                                     <tr>
                                                                        <td align="right" class="creditReportHeadBlack" valign="top">Denumire deplina:</td>
                                                                        <td class="creditReportContentBlack" valign="bottom">
                                                                           <xsl:value-of select="personal_data/company_name" />
                                                                        </td>
                                                                        <td>
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td align="right" class="creditReportHeadBlack" valign="top">
                                                                           Denumire abreviata:
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportContentBlack" valign="bottom">
                                                                           <xsl:value-of select="personal_data/company_short_name" />
                                                                        </td>
                                                                     </tr>
                                                                  </xsl:if>
                                                                  <tr>
                                                                     <td align="right" class="creditReportHeadBlack" valign="top">
                                                                        Data nastere
                                                                        <br />
                                                                        (Data inregistrare):
                                                                     </td>
                                                                     <td class="creditReportContentBlack" valign="bottom">
                                                                        <xsl:value-of select="personal_data/date_of_registration" />
                                                                        <xsl:if test="string(personal_data/deceased_flag)='true'">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <b>- DECEDAT/LICHIDAT SAU DIZOLVAT</b>
                                                                        </xsl:if>
                                                                     </td>
                                                                     <td>
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </td>
                                                                     <td align="right" class="creditReportHeadBlack" valign="top">
                                                                        Serie si nr
                                                                        <br />
                                                                        act de identitate:
                                                                     </td>
                                                                     <td class="creditReportContentBlack" valign="bottom">
                                                                        <xsl:value-of select="personal_data/identity_card" />
                                                                     </td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td align="right" class="creditReportHeadBlack" valign="top">Cod tara:</td>
                                                                     <td class="creditReportContentBlack" valign="center">
                                                                        <xsl:value-of select="personal_data/country_code" />
                                                                     </td>
                                                                     <td colspan="3">
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td align="right" class="creditReportHeadBlack" valign="top" width="36%">Telefon:</td>
                                                                     <td class="creditReportContentBlack" valign="center">
                                                                        <xsl:value-of select="personal_data/telephones/telephone" />
                                                                     </td>
                                                                     <td>
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </td>
                                                                     <td align="right" class="creditReportHeadBlack" valign="top">Fax:</td>
                                                                     <td class="creditReportContentBlack" valign="center">
                                                                        <xsl:value-of select="personal_data/telephones/fax" />
                                                                     </td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td align="right" class="creditReportHeadBlack" valign="top" width="36%">Email:</td>
                                                                     <td class="creditReportContentBlack" valign="center" colspan="4">
                                                                        <xsl:value-of select="personal_data/telephones/email" />
                                                                     </td>
                                                                  </tr>
                                                                  <xsl:if test="count(./personal_data)!=0 and $customer_type_code='C'">
                                                                     <tr>
                                                                        <td colspan="5">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td align="right" class="creditReportHeadBlack" valign="top" width="36%">
                                                                           Persoana juridica
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <br />
                                                                           reorganizata:
                                                                        </td>
                                                                        <td class="creditReportContentBlack" valign="top" colspan="4">
                                                                           <xsl:for-each select="personal_data/old_companies/old_company">
                                                                              <xsl:value-of select="." />
                                                                              /
                                                                              <xsl:value-of select="@idno" />
                                                                              <br />
                                                                           </xsl:for-each>
                                                                        </td>
                                                                     </tr>
                                                                  </xsl:if>
                                                                  <tr>
                                                                     <td colspan="5">
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td align="right" valign="center" class="creditReportHeadBlack">Data emiterii:</td>
                                                                     <td valign="center" class="creditReportContentBlack" width="220">
                                                                        <xsl:value-of select="inquiry_date/time" />
                                                                     </td>
                                                                     <td>
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </td>
                                                                     <td align="right" valign="center" class="creditReportHeadBlack">
                                                                        Scopul emiterii:
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </td>
                                                                     <td valign="center" class="creditReportContentBlack" width="100%">
                                                                        <xsl:value-of select="//cr_request/inquiry_purpose_desc" />
                                                                     </td>
                                                                  </tr>
                                                               </table>
                                                            </td>
                                                         </tr>
                                                         <tr>
                                                            <td>
                                                               <br />
                                                            </td>
                                                         </tr>
                                                         <tr>
                                                            <td align="center" class="creditReportHeadBlack">Adresa de resedinta</td>
                                                         </tr>
                                                         <tr>
                                                            <td align="center">
                                                               <table border="0" bgcolor="#FFFFB7" style="border: 1px outset #000000" class="tableType1">
                                                                  <tr>
                                                                     <td align="right" class="creditReportHeadBlack" valign="center" width="15%">Adresa:</td>
                                                                     <td class="creditReportContentBlack" valign="center" colspan="4">
                                                                        <xsl:value-of select="personal_data/home_address_details/home_address" />
                                                                     </td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td align="right" class="creditReportHeadBlack" valign="center" width="15%">Localitate:</td>
                                                                     <td class="creditReportContentBlack" valign="center" width="20%">
                                                                        <xsl:value-of select="personal_data/home_address_details/home_city" />
                                                                     </td>
                                                                     <td>
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </td>
                                                                     <td align="right" class="creditReportHeadBlack" valign="center" width="15%">Raion/Municipiu:</td>
                                                                     <td class="creditReportContentBlack" valign="center" width="20%">
                                                                        <xsl:value-of select="personal_data/home_address_details/home_state" />
                                                                     </td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td align="right" class="creditReportHeadBlack" valign="center">Cod postal:</td>
                                                                     <td class="creditReportContentBlack" valign="center">
                                                                        <xsl:value-of select="personal_data/home_address_details/home_zip_code" />
                                                                     </td>
                                                                     <td>
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </td>
                                                                     <td align="right" class="creditReportHeadBlack" valign="center">Tip resedinta:</td>
                                                                     <td class="creditReportContentBlack" valign="center">
                                                                        <xsl:value-of select="personal_data/home_address_details/home_residence_type" />
                                                                     </td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td align="right" class="creditReportHeadBlack" valign="center">Tip adresa:</td>
                                                                     <td colspan="4" class="creditReportContentBlack" valign="center">
                                                                        <xsl:value-of select="personal_data/home_address_details/home_address_indicator" />
                                                                     </td>
                                                                  </tr>
                                                               </table>
                                                            </td>
                                                         </tr>
                                                         <tr>
                                                            <td>
                                                               <br />
                                                            </td>
                                                         </tr>
                                                         <tr>
                                                            <td align="center" class="creditReportHeadBlack">Adresa de domiciliu</td>
                                                         </tr>
                                                         <tr>
                                                            <td align="center">
                                                               <table border="0" bgcolor="#FFFFB7" style="border: 1px solid #000000" class="tableType1">
                                                                  <tr>
                                                                     <td align="right" class="creditReportHeadBlack" valign="top" width="15%">Adresa:</td>
                                                                     <td class="creditReportContentBlack" valign="center" colspan="4">
                                                                        <xsl:value-of select="personal_data/residence_address_details/residence_address" />
                                                                     </td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td align="right" class="creditReportHeadBlack" valign="top" width="15%">Localitate:</td>
                                                                     <td class="creditReportContentBlack" valign="center" width="20%">
                                                                        <xsl:value-of select="personal_data/residence_address_details/residence_city" />
                                                                     </td>
                                                                     <td>
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </td>
                                                                     <td align="right" class="creditReportHeadBlack" valign="top" width="15%">Raion/Municipiu:</td>
                                                                     <td class="creditReportContentBlack" valign="center" width="20%">
                                                                        <xsl:value-of select="personal_data/residence_address_details/residence_state" />
                                                                     </td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td align="right" class="creditReportHeadBlack" valign="top">Cod postal:</td>
                                                                     <td class="creditReportContentBlack" valign="center">
                                                                        <xsl:value-of select="personal_data/residence_address_details/residence_zip_code" />
                                                                     </td>
                                                                     <td colspan="3">
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </td>
                                                                  </tr>
                                                               </table>
                                                            </td>
                                                         </tr>
                                                         <!-- End Personal Data-->
                                                         <xsl:if test="string($situatiaInscrierii)!='true'">
                                                            <xsl:for-each select="personal_data/notes">
                                                               <tr>
                                                                  <td align="center">
                                                                     <table border="0" cellpadding="0" cellspacing="0" class="tableType1">
                                                                        <xsl:for-each select="note">
                                                                           <tr>
                                                                              <td>
                                                                                 <xsl:if test="@id=1">Nota:</xsl:if>
                                                                              </td>
                                                                              <td>
                                                                                 <xsl:value-of select="." />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:for-each>
                                                                     </table>
                                                                  </td>
                                                               </tr>
                                                            </xsl:for-each>
                                                            <!-- personal_data/notes -->
                                                         </xsl:if>
                                                         <tr>
                                                            <td align="center" />
                                                         </tr>
                                                         <!-- personal_data/alerts -->
                                                         <xsl:for-each select="personal_data/alerts">
                                                            <tr>
                                                               <td align="center">
                                                                  <table border="0" cellpadding="0" cellspacing="0" class="tableType1">
                                                                     <tr>
                                                                        <td valign="top">
                                                                           Alerte:
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td>
                                                                           <table border="0" cellpadding="0" cellspacing="0">
                                                                              <tr>
                                                                                 <td class="alertFont" colspan="2">
                                                                                    <xsl:value-of select="message" />
                                                                                 </td>
                                                                              </tr>
                                                                              <xsl:for-each select="alert">
                                                                                 <tr>
                                                                                    <td class="alertFont" align="right">
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                       -
                                                                                    </td>
                                                                                    <td class="alertFont">
                                                                                       <xsl:value-of select="field" />
                                                                                       :
                                                                                       <xsl:value-of select="description" />
                                                                                    </td>
                                                                                 </tr>
                                                                              </xsl:for-each>
                                                                           </table>
                                                                        </td>
                                                                     </tr>
                                                                  </table>
                                                               </td>
                                                            </tr>
                                                         </xsl:for-each>
                                                         <!-- personal_data/alerts -->
                                                         <!-- End of personal_data/alerts -->
                                                         <!-- START rs_details-->
                                                      </xsl:if>
                                                      <!-- end of GENERAL_DATA section -->
                                                      <!-- start of DEMOGRAPHIC_DATA section -->
                                                      <xsl:if test="string(cr_request/extras_demographic_data)='true'">
                                                         <xsl:if test="rs_details">
                                                            <tr>
                                                               <td>
                                                                  <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                               <td>
                                                                  <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                               <td align="center">
                                                                  <b>
                                                                     Informatii demografice de la Registrele de Stat pt IDNO/IDNP:
                                                                     <xsl:value-of select="personal_data/idno_idnp" />
                                                                  </b>
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                               <td align="center">
                                                                  <table border="0" bgcolor="#FFFFB7" style="border: 1px outset #000000" class="tableType1">
                                                                     <xsl:if test="$customer_type_code='C'">
                                                                        <tr>
                                                                           <td align="right" valign="top" class="creditReportHeadBlack" width="15%">Denumire deplina:</td>
                                                                           <td class="creditReportContentBlack" valign="center" colspan="2">
                                                                              <xsl:value-of select="rs_details/rs_company_name" />
                                                                           </td>
                                                                           <td colspan="2">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:if>
                                                                     <xsl:if test="$customer_type_code!='C'">
                                                                        <tr>
                                                                           <td align="right" valign="top" class="creditReportHeadBlack" width="15%">Nume:</td>
                                                                           <td class="creditReportContentBlack" valign="center" width="20%">
                                                                              <xsl:value-of select="rs_details/rs_last_name" />
                                                                           </td>
                                                                           <td width="2">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td align="right" valign="top" class="creditReportHeadBlack" width="15%">Prenume:</td>
                                                                           <td class="creditReportContentBlack" valign="center" width="20%">
                                                                              <xsl:value-of select="rs_details/rs_first_name" />
                                                                           </td>
                                                                        </tr>
                                                                        <tr>
                                                                           <td align="right" valign="top" class="creditReportHeadBlack">Patronimic:</td>
                                                                           <td class="creditReportContentBlack" valign="center">
                                                                              <xsl:value-of select="rs_details/rs_father_name" />
                                                                           </td>
                                                                           <td colspan="3">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:if>
                                                                     <tr>
                                                                        <td valign="center" colspan="5">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td align="right" valign="top" class="creditReportHeadBlack">Adresa:</td>
                                                                        <td class="creditReportContentBlack" valign="center" colspan="4">
                                                                           <xsl:value-of select="rs_details/rs_address" />
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td align="right" valign="top" class="creditReportHeadBlack">Localitate:</td>
                                                                        <td class="creditReportContentBlack" valign="center">
                                                                           <xsl:value-of select="rs_details/rs_city" />
                                                                        </td>
                                                                        <td width="2">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td align="right" valign="top" class="creditReportHeadBlack">Raion/Municipiu:</td>
                                                                        <td class="creditReportContentBlack" valign="center" width="25%">
                                                                           <xsl:value-of select="rs_details/rs_state" />
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td align="right" valign="top" class="creditReportHeadBlack">Data actualizare:</td>
                                                                        <td class="creditReportContentBlack" valign="center">
                                                                           <xsl:value-of select="rs_details/rs_last_updated_on" />
                                                                        </td>
                                                                        <td colspan="3">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                     </tr>
                                                                  </table>
                                                               </td>
                                                            </tr>
                                                         </xsl:if>
                                                      </xsl:if>
                                                      <!-- END of DEMOGRAPHIC_DATA section -->
                                                      <!-- END rs_details-->
                                                      <tr>
                                                         <td align="center">
                                                            <b>
                                                               <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                            </b>
                                                         </td>
                                                      </tr>
                                                      <!-- Rezultat Negasit -->
                                                      <xsl:if test="count(./personal_data)=0">
                                                         <xsl:if test="string(cr_request/extras_type)!=''">
                                                            <tr>
                                                               <td align="center" class="creditReportHeadBlack">
                                                                  DESPRE PERSOANA VIZATA
                                                                  <br />
                                                                  NU EXISTA INFORMATIE INSCRISA LA BIROUL DE CREDIT.
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                               <td />
                                                            </tr>
                                                            <tr>
                                                               <td />
                                                            </tr>
                                                         </xsl:if>
                                                      </xsl:if>
                                                      <!-- Rezultat Gasit -->
                                                      <xsl:if test="count(./personal_data)!=0">
                                                         <!-- START of EMPLOYERS section -->
                                                         <xsl:if test="string(cr_request/extras_employers)='true'">
                                                            <!-- Informatii cu privire la angajator -->
                                                            <tr>
                                                               <td align="center">
                                                                  <b>
                                                                     Informatii cu privire la angajatori pentru IDNO/IDNP:
                                                                     <xsl:value-of select="personal_data/idno_idnp" />
                                                                  </b>
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                               <td>
                                                                  <table width="100%" cellpadding="2" cellspacing="0" style="border: 1px outset #000000">
                                                                     <tr>
                                                                        <td width="10%" class="creditReportCellHeaderSmall">Data ultimei actualizari</td>
                                                                        <td width="30%" class="creditReportCellHeaderSmall">Sursa de formare</td>
                                                                        <td width="45%" class="creditReportCellHeaderSmall">Angajator</td>
                                                                        <td width="15%" class="creditReportCellHeaderSmall">Ocupatia</td>
                                                                     </tr>
                                                                     <xsl:for-each select="employment/employer">
                                                                        <tr>
                                                                           <td align="center" class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="last_updated_on" />
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="participant" />
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <b>
                                                                                 <xsl:if test="normalize-space(string(employer_name))!=''">
                                                                                    <xsl:value-of select="employer_name" />
                                                                                    <xsl:if test="normalize-space(string(employer_city))!='' or normalize-space(string(employer_state))!='' or normalize-space(string(employer_zip_code))!=''">
                                                                                       ,
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                    </xsl:if>
                                                                                 </xsl:if>
                                                                              </b>
                                                                              <br />
                                                                              <xsl:if test="normalize-space(string(employer_city))!=''">
                                                                                 <xsl:value-of select="employer_city" />
                                                                                 <xsl:if test="normalize-space(string(employer_state))!='' or normalize-space(string(employer_zip_code))!=''">
                                                                                    ,
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </xsl:if>
                                                                              </xsl:if>
                                                                              <xsl:if test="normalize-space(string(employer_state))!=''">
                                                                                 <xsl:value-of select="employer_state" />
                                                                                 <xsl:if test="normalize-space(string(employer_zip_code))!=''">
                                                                                    ,
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </xsl:if>
                                                                              </xsl:if>
                                                                              <xsl:if test="normalize-space(string(employer_zip_code))!=''">
                                                                                 Cod postal:
                                                                                 <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 <xsl:value-of select="employer_zip_code" />
                                                                              </xsl:if>
                                                                              <br />
                                                                              <xsl:value-of select="employer_address" />
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="employer_occupation" />
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:for-each>
                                                                     <xsl:if test="count(employment/employer)&lt;1">
                                                                        <tr>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:if>
                                                                     <xsl:if test="count(employment/employer)&lt;2">
                                                                        <tr>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:if>
                                                                     <xsl:if test="count(employment/employer)&lt;3">
                                                                        <tr>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:if>
                                                                  </table>
                                                               </td>
                                                            </tr>
                                                            <!-- End of Informatii cu privire la angajator -->
                                                            <tr>
                                                               <td align="center">
                                                                  <b>
                                                                     <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                  </b>
                                                               </td>
                                                            </tr>
                                                         </xsl:if>
                                                         <!-- END of EMPLOYERS section -->
                                                         <!-- START of DISPUTES section -->
                                                         <xsl:if test="string(cr_request/extras_disputes)='true'">
                                                            <!-- Informatii cu privire la litigii -->
                                                            <tr>
                                                               <td align="center">
                                                                  <b>
                                                                     Informatii cu privire la litigiile aferente contractelor de credit pentru IDNO/IDNP:
                                                                     <xsl:value-of select="personal_data/idno_idnp" />
                                                                  </b>
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                               <td>
                                                                  <table width="100%" border="0" cellpadding="2" cellspacing="0" style="border: 1px outset #000000">
                                                                     <tr>
                                                                        <th class="creditReportCellHeaderSmall">
                                                                           Data ultimei
                                                                           <br />
                                                                           actualizari
                                                                        </th>
                                                                        <th class="creditReportCellHeaderSmall">
                                                                           Data emitere
                                                                           <br />
                                                                           sentinta/hotarare
                                                                        </th>
                                                                        <th class="creditReportCellHeaderSmall">Sursa de formare</th>
                                                                        <th class="creditReportCellHeaderSmall">Numar sentinta/hotarare</th>
                                                                        <th class="creditReportCellHeaderSmall">Rezolutie sentinta/hotarare</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">Stare litigiu</th>
                                                                     </tr>
                                                                     <xsl:for-each select="litigations/litigation">
                                                                        <tr>
                                                                           <td class="creditReportCellDataSmall" align="center">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="last_updated_on" />
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="center">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="document_date" />
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="center">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="participant" />
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="center">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="document_number" />
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="center">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="document_resolution" />
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="center">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="document_state" />
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:for-each>
                                                                     <xsl:if test="count(litigations/litigation)&lt;1">
                                                                        <tr>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:if>
                                                                     <xsl:if test="count(litigations/litigation)&lt;2">
                                                                        <tr>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:if>
                                                                     <xsl:if test="count(litigations/litigation)&lt;3">
                                                                        <tr>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:if>
                                                                  </table>
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                               <td align="center">
                                                                  <b>
                                                                     <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                  </b>
                                                               </td>
                                                            </tr>
                                                         </xsl:if>
                                                         <!-- END of DISPUTES section -->
                                                         <!-- START of INSOLVENCY section -->
                                                         <xsl:if test="string(cr_request/extras_insolvency)='true'">
                                                            <!-- Informatii cu privire la insolvabilitati -->
                                                            <tr>
                                                               <td align="center">
                                                                  <b>
                                                                     Informatii cu privire la starile de insolvabilitate pentru IDNO:
                                                                     <xsl:value-of select="personal_data/idno_idnp" />
                                                                  </b>
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                               <td>
                                                                  <table width="100%" border="0" cellpadding="2" cellspacing="0" style="border: 1px outset #000000">
                                                                     <tr>
                                                                        <th class="creditReportCellHeaderSmall">
                                                                           Data ultimei
                                                                           <br />
                                                                           actualizari
                                                                        </th>
                                                                        <th class="creditReportCellHeaderSmall">Data cauza</th>
                                                                        <th class="creditReportCellHeaderSmall">Sursa de formare</th>
                                                                        <th class="creditReportCellHeaderSmall">Numar cauza</th>
                                                                        <th class="creditReportCellHeaderSmall">Denumire instanta</th>
                                                                        <th class="creditReportCellHeaderSmall">Adresa instanta</th>
                                                                        <th class="creditReportCellHeaderSmall">Procedura aplicata</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">Stare cauza</th>
                                                                     </tr>
                                                                     <xsl:for-each select="insolvencies/insolvency">
                                                                        <tr>
                                                                           <td class="creditReportCellDataSmall" align="center">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="last_updated_on" />
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="center">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="document_date" />
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="center">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="participant" />
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="center">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="document_number" />
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="center">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="court_name" />
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="center">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="court_address" />
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="center">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="document_resolution" />
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="center">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="document_state" />
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:for-each>
                                                                     <xsl:if test="count(insolvencies/insolvency)&lt;1">
                                                                        <tr>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:if>
                                                                     <xsl:if test="count(insolvencies/insolvency)&lt;2">
                                                                        <tr>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:if>
                                                                     <xsl:if test="count(insolvencies/insolvency)&lt;3">
                                                                        <tr>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:if>
                                                                  </table>
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                               <td align="center">
                                                                  <b>
                                                                     <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                  </b>
                                                               </td>
                                                            </tr>
                                                         </xsl:if>
                                                         <!-- END of INSOLVENCY section -->
                                                         <!-- START of ACCOUNTS_RELATIONSHIPS section -->
                                                         <xsl:if test="string(cr_request/extras_accounts_relationships)='true'">
                                                            <!-- Informatii cu privire la relatia cu alti clienti -->
                                                            <tr>
                                                               <td align="center">
                                                                  <b>
                                                                     Informatii cu privire la relatia cu alte conturi pentru IDNO/IDNP:
                                                                     <xsl:value-of select="personal_data/idno_idnp" />
                                                                  </b>
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                               <td>
                                                                  <table width="100%" border="0" cellpadding="2" cellspacing="0" style="border: 1px outset #000000">
                                                                     <tr>
                                                                        <th class="creditReportCellHeaderSmall">Tip relatie</th>
                                                                        <th class="creditReportCellHeaderSmall">
                                                                           Acord
                                                                           <br />
                                                                           semnat
                                                                        </th>
                                                                        <th class="creditReportCellHeaderSmall">Tip organizare</th>
                                                                        <th class="creditReportCellHeaderSmall">IDNO/IDNP titular</th>
                                                                        <th class="creditReportCellHeaderSmall" colspan="3">
                                                                           Nume, prenume, patronimic titular
                                                                           <br />
                                                                           /Denumire titular
                                                                        </th>
                                                                        <th class="creditReportCellHeaderSmall">Tip portofoliu</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">Valuta</th>
                                                                        <th class="creditReportCellHeaderSmall" width="65">
                                                                           Limita
                                                                           <br />
                                                                           credit
                                                                        </th>
                                                                        <th class="creditReportCellHeaderSmall" width="65">
                                                                           Valoare
                                                                           <br />
                                                                           imprumut
                                                                        </th>
                                                                        <th class="creditReportCellHeaderSmall" width="65">
                                                                           Sold
                                                                           <br />
                                                                           curent
                                                                        </th>
                                                                        <th class="creditReportCellHeaderSmall" width="65">
                                                                           Suma
                                                                           <br />
                                                                           obligatiilor
                                                                           <br />
                                                                           restante
                                                                        </th>
                                                                        <th class="creditReportCellHeaderSmall" width="65">
                                                                           Frecventa
                                                                           <br />
                                                                           plati
                                                                        </th>
                                                                        <th class="creditReportCellHeaderSmall" width="65">
                                                                           Data
                                                                           <br />
                                                                           procesare
                                                                        </th>
                                                                     </tr>
                                                                     <xsl:for-each select="other_accounts/other_account">
                                                                        <tr>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="ecoa_code" />
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="center">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="process_indicator" />
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="center">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="customer_type" />
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="center">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="idno_idnp" />
                                                                           </td>
                                                                           <xsl:if test="customer_type/@code!='C'">
                                                                              <td class="creditReportCellDataSmall" align="center">
                                                                                 <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 <xsl:value-of select="last_name" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">
                                                                                 <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 <xsl:value-of select="first_name" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">
                                                                                 <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 <xsl:value-of select="father_name" />
                                                                              </td>
                                                                           </xsl:if>
                                                                           <xsl:if test="customer_type/@code='C'">
                                                                              <td class="creditReportCellDataSmall" align="center">
                                                                                 <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 <xsl:value-of select="company_name" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center" colspan="2">
                                                                                 <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 <xsl:value-of select="company_short_name" />
                                                                              </td>
                                                                           </xsl:if>
                                                                           <td class="creditReportCellDataSmall" align="center">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="document_type" />
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="center">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="document_currency/@code" />
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="right">
                                                                              <!-- credit_limit -->
                                                                              <xsl:call-template name="currencyFormat">
                                                                                 <xsl:with-param name="value">
                                                                                    <xsl:value-of select="credit_limit" />
                                                                                 </xsl:with-param>
                                                                              </xsl:call-template>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="right">
                                                                              <!-- initial_value -->
                                                                              <xsl:call-template name="currencyFormat">
                                                                                 <xsl:with-param name="value">
                                                                                    <xsl:value-of select="initial_value" />
                                                                                 </xsl:with-param>
                                                                              </xsl:call-template>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="right">
                                                                              <!-- current_balance -->
                                                                              <xsl:call-template name="currencyFormat">
                                                                                 <xsl:with-param name="value">
                                                                                    <xsl:value-of select="current_balance" />
                                                                                 </xsl:with-param>
                                                                              </xsl:call-template>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="right">
                                                                              <!-- amount_past_due -->
                                                                              <xsl:call-template name="currencyFormat">
                                                                                 <xsl:with-param name="value">
                                                                                    <xsl:value-of select="amount_past_due" />
                                                                                 </xsl:with-param>
                                                                              </xsl:call-template>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="center">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="terms_frequency" />
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="center">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="processed_on" />
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:for-each>
                                                                     <xsl:if test="count(other_accounts/other_account)&lt;1">
                                                                        <tr>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" colspan="3">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:if>
                                                                     <xsl:if test="count(other_accounts/other_account)&lt;2">
                                                                        <tr>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" colspan="3">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:if>
                                                                     <xsl:if test="count(other_accounts/other_account)&lt;3">
                                                                        <tr>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" colspan="3">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:if>
                                                                  </table>
                                                               </td>
                                                            </tr>
                                                            <xsl:if test="string(other_accounts/not_current/@exist) = 'true'">
                                                               <tr>
                                                                  <td>Aceasta persoana a avut in trecut relatii cu alte conturi.</td>
                                                               </tr>
                                                            </xsl:if>
                                                            <!-- End of Informatii cu privire la relatia cu alti clienti -->
                                                         </xsl:if>
                                                         <!-- END of ACCOUNTS_RELATIONSHIPS section -->
                                                         <!-- START of RISK_LEVEL section -->
                                                         <xsl:if test="string(cr_request/extras_risk_level)='true'">
                                                            <!-- START Indicatori de inadvertenta -->
                                                            <xsl:if test="string($situatiaInscrierii)!='true'">
                                                               <tr>
                                                                  <td>
                                                                     <div style="page-break-after:always">
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </div>
                                                                  </td>
                                                               </tr>
                                                               <!-- START Situatia eliberarii de Rapoarte -->
                                                               <xsl:if test="count(indicators/indicator) &gt; 0">
                                                                  <tr>
                                                                     <td>
                                                                        <table style="border: 1px outset #000000" width="100%">
                                                                           <xsl:if test="count(indicators/indicator[@type='inadvertence']) &gt; 0">
                                                                              <tr>
                                                                                 <td class="creditReportHeadBlack" style="padding-left: 4px;" nowrap="true" valign="top">Indicatori de inadvertenta:</td>
                                                                                 <xsl:for-each select="indicators/indicator[@type='inadvertence']">
                                                                                    <td valign="top">
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                       <xsl:value-of select="." />
                                                                                    </td>
                                                                                 </xsl:for-each>
                                                                              </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="count(indicators/indicator[@type='fraud']) &gt; 0">
                                                                              <tr>
                                                                                 <td class="creditReportHeadBlack" style="padding-left: 4px;" nowrap="true" valign="top">Indicatori de frauda:</td>
                                                                                 <xsl:for-each select="indicators/indicator[@type='fraud']">
                                                                                    <td valign="top">
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                       <xsl:value-of select="." />
                                                                                    </td>
                                                                                 </xsl:for-each>
                                                                              </tr>
                                                                           </xsl:if>
                                                                        </table>
                                                                     </td>
                                                                  </tr>
                                                               </xsl:if>
                                                               <!-- START Situatia eliberarii de Rapoarte -->
                                                            </xsl:if>
                                                            <xsl:if test="string($situatiaInscrierii)='true'">
                                                               <!-- START Situatia eliberarii de Rapoarte -->
                                                               <xsl:if test="count( indicators_details/document ) &gt; 0">
                                                                  <tr>
                                                                     <td>
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td colspan="2" width="1%" align="center">
                                                                        <b>
                                                                           Declaratii cu inadvertente si fraude inscrise de sursele de formare
                                                                           <br />
                                                                           pentru IDNO/IDNP:
                                                                           <xsl:value-of select="personal_data/idno_idnp" />
                                                                           la data de:
                                                                           <xsl:value-of select="inquiry_date/date" />
                                                                        </b>
                                                                     </td>
                                                                  </tr>
                                                               </xsl:if>
                                                               <xsl:for-each select="indicators_details/document">
                                                                  <tr>
                                                                     <td colspan="2">
                                                                        <table border="0" width="100%" cellpadding="2" cellspacing="0" style="border: 1px outset #000000">
                                                                           <tr>
                                                                              <td width="80" class="creditReportCellHeaderSmall">Data inscrierii</td>
                                                                              <td width="80" class="creditReportCellHeaderSmall">Data documentului</td>
                                                                              <td width="150" class="creditReportCellHeaderSmall">Tip document</td>
                                                                              <td width="90%" class="creditReportCellHeaderSmall">
                                                                                 Sursa de formare
                                                                                 <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td width="80" rowspan="3" class="creditReportCellDataSmall" align="center">
                                                                                 <xsl:value-of select="./@record_date" />
                                                                              </td>
                                                                              <td width="80" rowspan="3" class="creditReportCellDataSmall" align="center">
                                                                                 <xsl:value-of select="./@date" />
                                                                              </td>
                                                                              <td width="150" class="creditReportCellDataSmall">
                                                                                 <xsl:value-of select="./document_type" />
                                                                              </td>
                                                                              <td width="90%" class="creditReportCellDataSmall">
                                                                                 <xsl:value-of select="./participant_code" />
                                                                                 <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td colspan="2" class="creditReportCellDataSmall" valign="top">
                                                                                 <b>Indicatori:</b>
                                                                                 <xsl:for-each select="./indicators/indicator">
                                                                                    <xsl:value-of select="." />
                                                                                    <xsl:if test="not (position()=last())">,</xsl:if>
                                                                                 </xsl:for-each>
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td colspan="2" class="creditReportCellDataSmall" valign="top">
                                                                                 <b>Comentarii:</b>
                                                                                 <xsl:value-of select="./comments" />
                                                                                 <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              </td>
                                                                           </tr>
                                                                        </table>
                                                                     </td>
                                                                  </tr>
                                                               </xsl:for-each>
                                                               <tr>
                                                                  <td>
                                                                     <div style="page-break-after:always">
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </div>
                                                                  </td>
                                                               </tr>
                                                               <!-- START Situatia eliberarii de Rapoarte -->
                                                            </xsl:if>
                                                            <!-- END Indicatori de inadvertenta -->
                                                            <xsl:if test="string($situatiaInscrierii)!='true'">
                                                               <tr>
                                                                  <td align="center">
                                                                     <table border="0" width="50%">
                                                                        <td class="creditReportHeadBlack" align="center">
                                                                           <table bgcolor="#FFFFB7" style="border: 1px solid #000000; margin-top: 10px;" width="100%" height="100%">
                                                                              <tr>
                                                                                 <xsl:if test="string(risk_scale/risk_label)!='-' and string(risk_scale/risk_label)!=''">
                                                                                    <td align="center" class="creditReportHeadBlack" valign="middle">
                                                                                       <img border="0" width="42">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">
                                                                                                   <xsl:call-template name="stripPath">
                                                                                                      <xsl:with-param name="source">
                                                                                                         <xsl:value-of select="risk_scale/risk_icon" />
                                                                                                      </xsl:with-param>
                                                                                                   </xsl:call-template>
                                                                                                </xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </img>
                                                                                    </td>
                                                                                    <td align="center" class="creditReportHeadBlack" valign="middle">
                                                                                       <img border="0" width="1" height="25">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </img>
                                                                                    </td>
                                                                                    <td align="center" class="creditReportHeadBlack" valign="middle">
                                                                                       GRAD DE RISC CURENT
                                                                                       <br />
                                                                                       <font size="3">
                                                                                          <xsl:value-of select="risk_scale/risk_label" />
                                                                                       </font>
                                                                                    </td>
                                                                                 </xsl:if>
                                                                                 <xsl:if test="string(risk_scale/risk_label)='-' or string(risk_scale/risk_label)=''">
                                                                                    <td align="center" class="creditReportHeadBlack" valign="middle" />
                                                                                    <td align="center" class="creditReportHeadBlack" valign="middle">
                                                                                       <img border="0" width="1" height="25">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </img>
                                                                                    </td>
                                                                                    <td align="center" class="creditReportHeadBlack" valign="middle">
                                                                                       GRAD DE RISC CURENT
                                                                                       <br />
                                                                                       <font size="3">FARA GRAD DE RISC CURENT</font>
                                                                                    </td>
                                                                                 </xsl:if>
                                                                              </tr>
                                                                           </table>
                                                                        </td>
                                                                     </table>
                                                                  </td>
                                                               </tr>
                                                            </xsl:if>
                                                            <tr>
                                                               <td>
                                                                  <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                               </td>
                                                            </tr>
                                                         </xsl:if>
                                                         <!-- END of RISK_LEVEL section -->
                                                         <!-- START of MAIN_INDICATORS section -->
                                                         <xsl:if test="string(cr_request/extras_main_indicators)='true'">
                                                            <!-- Raport de credit pentru C.N.P. -->
                                                            <tr>
                                                               <td align="center">
                                                                  Raportul de credit al subiectului istoriei de credit avand IDNO/IDNP
                                                                  <xsl:value-of select="personal_data/idno_idnp" />
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                               <td align="center">
                                                                  <table border="0" cellspacing="2" style="border: 1px solid #000000; width: 80%">
                                                                     <tr>
                                                                        <td class="creditReportCellHeader" align="center">INDICATORI PRINCIPALI AI DOSARULUI SUBIECTULUI ISTORIEI DE CREDIT</td>
                                                                        <td class="creditReportCellHeader" align="center">Bancari</td>
                                                                        <td class="creditReportCellHeader" colspan="2" align="center">Non-Bancari</td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td class="creditReportBlackNormal">
                                                                           <u>Informatii globale</u>
                                                                        </td>
                                                                        <td align="center" class="creditReportCell" colspan="2">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td align="center" class="creditReportCellData8">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td>
                                                                           <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                              <tr>
                                                                                 <td>
                                                                                    <img border="0" width="20" height="1">
                                                                                       <xsl:attribute name="src">
                                                                                          <xsl:call-template name="resource">
                                                                                             <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                             <xsl:with-param name="forEmail">
                                                                                                <xsl:value-of select="$forEmail" />
                                                                                             </xsl:with-param>
                                                                                          </xsl:call-template>
                                                                                       </xsl:attribute>
                                                                                    </img>
                                                                                 </td>
                                                                                 <td width="100%">Numarul de conturi din dosarul subiectului/Numarul de surse de formare</td>
                                                                              </tr>
                                                                           </table>
                                                                        </td>
                                                                        <td align="center" class="creditReportCell" colspan="2">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <xsl:value-of select="main_indicators/accounts_no[@type='banking']" />
                                                                           /
                                                                           <xsl:value-of select="main_indicators/participants_no[@type='banking']" />
                                                                        </td>
                                                                        <td align="center" class="creditReportCellData8">
                                                                           <xsl:value-of select="main_indicators/accounts_no[@type='non_banking']" />
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           /
                                                                           <xsl:value-of select="main_indicators/participants_no[@type='non_banking']" />
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td>
                                                                           <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                              <tr>
                                                                                 <td>
                                                                                    <img border="0" width="20" height="1">
                                                                                       <xsl:attribute name="src">
                                                                                          <xsl:call-template name="resource">
                                                                                             <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                             <xsl:with-param name="forEmail">
                                                                                                <xsl:value-of select="$forEmail" />
                                                                                             </xsl:with-param>
                                                                                          </xsl:call-template>
                                                                                       </xsl:attribute>
                                                                                    </img>
                                                                                 </td>
                                                                                 <td width="100%">Numarul de conturi cu obligatii restante curente</td>
                                                                              </tr>
                                                                           </table>
                                                                        </td>
                                                                        <td align="center" class="creditReportCell" colspan="2">
                                                                           <!-- due_accounts_no -->
                                                                           <xsl:call-template name="integerFormat">
                                                                              <xsl:with-param name="value">
                                                                                 <xsl:value-of select="main_indicators/due_accounts_no[@type='banking']" />
                                                                              </xsl:with-param>
                                                                           </xsl:call-template>
                                                                        </td>
                                                                        <td align="center" class="creditReportCellData8">
                                                                           <xsl:call-template name="integerFormat">
                                                                              <xsl:with-param name="value">
                                                                                 <xsl:value-of select="main_indicators/due_accounts_no[@type='non_banking']" />
                                                                              </xsl:with-param>
                                                                           </xsl:call-template>
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td>
                                                                           <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                              <tr>
                                                                                 <td>
                                                                                    <img border="0" width="20" height="1">
                                                                                       <xsl:attribute name="src">
                                                                                          <xsl:call-template name="resource">
                                                                                             <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                             <xsl:with-param name="forEmail">
                                                                                                <xsl:value-of select="$forEmail" />
                                                                                             </xsl:with-param>
                                                                                          </xsl:call-template>
                                                                                       </xsl:attribute>
                                                                                    </img>
                                                                                 </td>
                                                                                 <td width="100%">Cele mai vechi informatii</td>
                                                                              </tr>
                                                                           </table>
                                                                        </td>
                                                                        <td align="center" class="creditReportCell" colspan="2">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <xsl:value-of select="main_indicators/oldest_info[@type='banking']" />
                                                                        </td>
                                                                        <td align="center" class="creditReportCellData8">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <xsl:value-of select="main_indicators/oldest_info[@type='non_banking']" />
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td>
                                                                           <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                              <tr>
                                                                                 <td>
                                                                                    <img border="0" width="20" height="1">
                                                                                       <xsl:attribute name="src">
                                                                                          <xsl:call-template name="resource">
                                                                                             <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                             <xsl:with-param name="forEmail">
                                                                                                <xsl:value-of select="$forEmail" />
                                                                                             </xsl:with-param>
                                                                                          </xsl:call-template>
                                                                                       </xsl:attribute>
                                                                                    </img>
                                                                                 </td>
                                                                                 <td width="100%">Numarul de conturi extrabilantiere</td>
                                                                              </tr>
                                                                           </table>
                                                                        </td>
                                                                        <td align="center" class="creditReportCell" colspan="2">
                                                                           <!-- charge_offs_no -->
                                                                           <xsl:call-template name="integerFormat">
                                                                              <xsl:with-param name="value">
                                                                                 <xsl:value-of select="main_indicators/charge_offs_no[@type='banking']" />
                                                                              </xsl:with-param>
                                                                           </xsl:call-template>
                                                                        </td>
                                                                        <td align="center" class="creditReportCellData8">
                                                                           <xsl:call-template name="integerFormat">
                                                                              <xsl:with-param name="value">
                                                                                 <xsl:value-of select="main_indicators/charge_offs_no[@type='non_banking']" />
                                                                              </xsl:with-param>
                                                                           </xsl:call-template>
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td>
                                                                           <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                              <tr>
                                                                                 <td>
                                                                                    <img border="0" width="20" height="1">
                                                                                       <xsl:attribute name="src">
                                                                                          <xsl:call-template name="resource">
                                                                                             <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                             <xsl:with-param name="forEmail">
                                                                                                <xsl:value-of select="$forEmail" />
                                                                                             </xsl:with-param>
                                                                                          </xsl:call-template>
                                                                                       </xsl:attribute>
                                                                                    </img>
                                                                                 </td>
                                                                                 <td width="100%">Numarul de conturi date la colectare</td>
                                                                              </tr>
                                                                           </table>
                                                                        </td>
                                                                        <td align="center" class="creditReportCell" colspan="2">
                                                                           <!-- collections_no -->
                                                                           <xsl:call-template name="integerFormat">
                                                                              <xsl:with-param name="value">
                                                                                 <xsl:value-of select="main_indicators/collections_no[@type='banking']" />
                                                                              </xsl:with-param>
                                                                           </xsl:call-template>
                                                                        </td>
                                                                        <td align="center" class="creditReportCellData8">
                                                                           <xsl:call-template name="integerFormat">
                                                                              <xsl:with-param name="value">
                                                                                 <xsl:value-of select="main_indicators/collections_no[@type='non_banking']" />
                                                                              </xsl:with-param>
                                                                           </xsl:call-template>
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td>
                                                                           <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                              <tr>
                                                                                 <td>
                                                                                    <img border="0" width="20" height="1">
                                                                                       <xsl:attribute name="src">
                                                                                          <xsl:call-template name="resource">
                                                                                             <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                             <xsl:with-param name="forEmail">
                                                                                                <xsl:value-of select="$forEmail" />
                                                                                             </xsl:with-param>
                                                                                          </xsl:call-template>
                                                                                       </xsl:attribute>
                                                                                    </img>
                                                                                 </td>
                                                                                 <td width="100%">
                                                                                    Totalul sumelor de plata pe luna (
                                                                                    <xsl:value-of select="primary_currency" />
                                                                                    )
                                                                                 </td>
                                                                              </tr>
                                                                           </table>
                                                                        </td>
                                                                        <td align="center" class="creditReportCell" colspan="2">
                                                                           <!-- total_payments -->
                                                                           <xsl:call-template name="currencyFormat">
                                                                              <xsl:with-param name="value">
                                                                                 <xsl:value-of select="main_indicators/total_payments[@type='banking']" />
                                                                              </xsl:with-param>
                                                                           </xsl:call-template>
                                                                        </td>
                                                                        <td align="center" class="creditReportCellData8">
                                                                           <xsl:call-template name="currencyFormat">
                                                                              <xsl:with-param name="value">
                                                                                 <xsl:value-of select="main_indicators/total_payments[@type='non_banking']" />
                                                                              </xsl:with-param>
                                                                           </xsl:call-template>
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td>
                                                                           <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                              <tr>
                                                                                 <td>
                                                                                    <img border="0" width="20" height="1">
                                                                                       <xsl:attribute name="src">
                                                                                          <xsl:call-template name="resource">
                                                                                             <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                             <xsl:with-param name="forEmail">
                                                                                                <xsl:value-of select="$forEmail" />
                                                                                             </xsl:with-param>
                                                                                          </xsl:call-template>
                                                                                       </xsl:attribute>
                                                                                    </img>
                                                                                 </td>
                                                                                 <td width="100%">
                                                                                    Totalul sumelor datorate curent (
                                                                                    <xsl:value-of select="primary_currency" />
                                                                                    ):
                                                                                 </td>
                                                                              </tr>
                                                                           </table>
                                                                        </td>
                                                                        <td align="center" class="creditReportCell" colspan="2">
                                                                           <!-- total_owed -->
                                                                           <xsl:call-template name="currencyFormat">
                                                                              <xsl:with-param name="value">
                                                                                 <xsl:value-of select="main_indicators/total_owed[@type='banking']" />
                                                                              </xsl:with-param>
                                                                           </xsl:call-template>
                                                                        </td>
                                                                        <td align="center" class="creditReportCellData8">
                                                                           <xsl:call-template name="currencyFormat">
                                                                              <xsl:with-param name="value">
                                                                                 <xsl:value-of select="main_indicators/total_owed[@type='non_banking']" />
                                                                              </xsl:with-param>
                                                                           </xsl:call-template>
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td>
                                                                           <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                              <tr>
                                                                                 <td>
                                                                                    <img border="0" width="20" height="1">
                                                                                       <xsl:attribute name="src">
                                                                                          <xsl:call-template name="resource">
                                                                                             <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                             <xsl:with-param name="forEmail">
                                                                                                <xsl:value-of select="$forEmail" />
                                                                                             </xsl:with-param>
                                                                                          </xsl:call-template>
                                                                                       </xsl:attribute>
                                                                                    </img>
                                                                                 </td>
                                                                                 <td width="100%">
                                                                                    <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                       <tr>
                                                                                          <td>
                                                                                             <img border="0" width="20" height="1">
                                                                                                <xsl:attribute name="src">
                                                                                                   <xsl:call-template name="resource">
                                                                                                      <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                      <xsl:with-param name="forEmail">
                                                                                                         <xsl:value-of select="$forEmail" />
                                                                                                      </xsl:with-param>
                                                                                                   </xsl:call-template>
                                                                                                </xsl:attribute>
                                                                                             </img>
                                                                                          </td>
                                                                                          <td width="100%">- sub 1 an</td>
                                                                                       </tr>
                                                                                    </table>
                                                                                 </td>
                                                                              </tr>
                                                                           </table>
                                                                        </td>
                                                                        <td align="center" class="creditReportCell" colspan="2">
                                                                           <!-- total_years_1 -->
                                                                           <xsl:call-template name="currencyFormat">
                                                                              <xsl:with-param name="value">
                                                                                 <xsl:value-of select="main_indicators/total_years_1[@type='banking']" />
                                                                              </xsl:with-param>
                                                                           </xsl:call-template>
                                                                        </td>
                                                                        <td align="center" class="creditReportCellData8">
                                                                           <xsl:call-template name="currencyFormat">
                                                                              <xsl:with-param name="value">
                                                                                 <xsl:value-of select="main_indicators/total_years_1[@type='non_banking']" />
                                                                              </xsl:with-param>
                                                                           </xsl:call-template>
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td>
                                                                           <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                              <tr>
                                                                                 <td>
                                                                                    <img border="0" width="20" height="1">
                                                                                       <xsl:attribute name="src">
                                                                                          <xsl:call-template name="resource">
                                                                                             <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                             <xsl:with-param name="forEmail">
                                                                                                <xsl:value-of select="$forEmail" />
                                                                                             </xsl:with-param>
                                                                                          </xsl:call-template>
                                                                                       </xsl:attribute>
                                                                                    </img>
                                                                                 </td>
                                                                                 <td width="100%">
                                                                                    <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                       <tr>
                                                                                          <td>
                                                                                             <img border="0" width="20" height="1">
                                                                                                <xsl:attribute name="src">
                                                                                                   <xsl:call-template name="resource">
                                                                                                      <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                      <xsl:with-param name="forEmail">
                                                                                                         <xsl:value-of select="$forEmail" />
                                                                                                      </xsl:with-param>
                                                                                                   </xsl:call-template>
                                                                                                </xsl:attribute>
                                                                                             </img>
                                                                                          </td>
                                                                                          <td width="100%">- 1 - 5 ani</td>
                                                                                       </tr>
                                                                                    </table>
                                                                                 </td>
                                                                              </tr>
                                                                           </table>
                                                                        </td>
                                                                        <td align="center" class="creditReportCell" colspan="2">
                                                                           <!-- total_years_1 -->
                                                                           <xsl:call-template name="currencyFormat">
                                                                              <xsl:with-param name="value">
                                                                                 <xsl:value-of select="main_indicators/total_years_1_5[@type='banking']" />
                                                                              </xsl:with-param>
                                                                           </xsl:call-template>
                                                                        </td>
                                                                        <td align="center" class="creditReportCellData8">
                                                                           <xsl:call-template name="currencyFormat">
                                                                              <xsl:with-param name="value">
                                                                                 <xsl:value-of select="main_indicators/total_years_1_5[@type='non_banking']" />
                                                                              </xsl:with-param>
                                                                           </xsl:call-template>
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td>
                                                                           <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                              <tr>
                                                                                 <td>
                                                                                    <img border="0" width="20" height="1">
                                                                                       <xsl:attribute name="src">
                                                                                          <xsl:call-template name="resource">
                                                                                             <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                             <xsl:with-param name="forEmail">
                                                                                                <xsl:value-of select="$forEmail" />
                                                                                             </xsl:with-param>
                                                                                          </xsl:call-template>
                                                                                       </xsl:attribute>
                                                                                    </img>
                                                                                 </td>
                                                                                 <td width="100%">
                                                                                    <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                       <tr>
                                                                                          <td>
                                                                                             <img border="0" width="20" height="1">
                                                                                                <xsl:attribute name="src">
                                                                                                   <xsl:call-template name="resource">
                                                                                                      <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                      <xsl:with-param name="forEmail">
                                                                                                         <xsl:value-of select="$forEmail" />
                                                                                                      </xsl:with-param>
                                                                                                   </xsl:call-template>
                                                                                                </xsl:attribute>
                                                                                             </img>
                                                                                          </td>
                                                                                          <td width="100%">- peste 5 ani</td>
                                                                                       </tr>
                                                                                    </table>
                                                                                 </td>
                                                                              </tr>
                                                                           </table>
                                                                        </td>
                                                                        <td align="center" class="creditReportCell" colspan="2">
                                                                           <!-- total_years_5_more -->
                                                                           <xsl:call-template name="currencyFormat">
                                                                              <xsl:with-param name="value">
                                                                                 <xsl:value-of select="main_indicators/total_years_5_more[@type='banking']" />
                                                                              </xsl:with-param>
                                                                           </xsl:call-template>
                                                                        </td>
                                                                        <td align="center" class="creditReportCellData8">
                                                                           <xsl:call-template name="currencyFormat">
                                                                              <xsl:with-param name="value">
                                                                                 <xsl:value-of select="main_indicators/total_years_5_more[@type='non_banking']" />
                                                                              </xsl:with-param>
                                                                           </xsl:call-template>
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td>
                                                                           <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                              <tr>
                                                                                 <td>
                                                                                    <img border="0" width="20" height="1">
                                                                                       <xsl:attribute name="src">
                                                                                          <xsl:call-template name="resource">
                                                                                             <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                             <xsl:with-param name="forEmail">
                                                                                                <xsl:value-of select="$forEmail" />
                                                                                             </xsl:with-param>
                                                                                          </xsl:call-template>
                                                                                       </xsl:attribute>
                                                                                    </img>
                                                                                 </td>
                                                                                 <td width="100%">
                                                                                    Totalul obligatiilor restante curent (
                                                                                    <xsl:value-of select="primary_currency" />
                                                                                    ):
                                                                                 </td>
                                                                              </tr>
                                                                           </table>
                                                                        </td>
                                                                        <td align="center" class="creditReportCell" colspan="2">
                                                                           <!-- total_debt -->
                                                                           <xsl:call-template name="currencyFormat">
                                                                              <xsl:with-param name="value">
                                                                                 <xsl:value-of select="main_indicators/total_debt[@type='banking']" />
                                                                              </xsl:with-param>
                                                                           </xsl:call-template>
                                                                        </td>
                                                                        <td align="center" class="creditReportCellData8">
                                                                           <xsl:call-template name="currencyFormat">
                                                                              <xsl:with-param name="value">
                                                                                 <xsl:value-of select="main_indicators/total_debt[@type='non_banking']" />
                                                                              </xsl:with-param>
                                                                           </xsl:call-template>
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td>
                                                                           <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                              <tr>
                                                                                 <td>
                                                                                    <img border="0" width="20" height="1">
                                                                                       <xsl:attribute name="src">
                                                                                          <xsl:call-template name="resource">
                                                                                             <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                             <xsl:with-param name="forEmail">
                                                                                                <xsl:value-of select="$forEmail" />
                                                                                             </xsl:with-param>
                                                                                          </xsl:call-template>
                                                                                       </xsl:attribute>
                                                                                    </img>
                                                                                 </td>
                                                                                 <td width="100%">
                                                                                    <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                       <tr>
                                                                                          <td width="100%">Categoria de intarziere maxima curenta</td>
                                                                                       </tr>
                                                                                    </table>
                                                                                 </td>
                                                                              </tr>
                                                                           </table>
                                                                        </td>
                                                                        <td align="center" class="creditReportCell" colspan="2">
                                                                           <xsl:if test="string(main_indicators/current_max_categ_of_delay[@type='banking']) = ''">-</xsl:if>
                                                                           <xsl:value-of select="main_indicators/current_max_categ_of_delay[@type='banking']" />
                                                                        </td>
                                                                        <td align="center" class="creditReportCellData8">
                                                                           <xsl:if test="string(main_indicators/current_max_categ_of_delay[@type='non_banking']) = ''">-</xsl:if>
                                                                           <xsl:value-of select="main_indicators/current_max_categ_of_delay[@type='non_banking']" />
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td>
                                                                           <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                              <tr>
                                                                                 <td>
                                                                                    <img border="0" width="20" height="1">
                                                                                       <xsl:attribute name="src">
                                                                                          <xsl:call-template name="resource">
                                                                                             <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                             <xsl:with-param name="forEmail">
                                                                                                <xsl:value-of select="$forEmail" />
                                                                                             </xsl:with-param>
                                                                                          </xsl:call-template>
                                                                                       </xsl:attribute>
                                                                                    </img>
                                                                                 </td>
                                                                                 <td width="100%">
                                                                                    <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                       <tr>
                                                                                          <td width="100%">Intarzierea maxima curenta la data emiterii RC</td>
                                                                                       </tr>
                                                                                    </table>
                                                                                 </td>
                                                                              </tr>
                                                                           </table>
                                                                        </td>
                                                                        <td align="center" class="creditReportCell" colspan="2">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <xsl:value-of select="main_indicators/max_crt_delay_days[@type='banking']" />
                                                                           zile
                                                                        </td>
                                                                        <td align="center" class="creditReportCellData8">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <xsl:value-of select="main_indicators/max_crt_delay_days[@type='non_banking']" />
                                                                           zile
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td>
                                                                           <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                              <tr>
                                                                                 <td>
                                                                                    <img border="0" width="20" height="1">
                                                                                       <xsl:attribute name="src">
                                                                                          <xsl:call-template name="resource">
                                                                                             <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                             <xsl:with-param name="forEmail">
                                                                                                <xsl:value-of select="$forEmail" />
                                                                                             </xsl:with-param>
                                                                                          </xsl:call-template>
                                                                                       </xsl:attribute>
                                                                                    </img>
                                                                                 </td>
                                                                                 <td width="100%">Numarul de conturi contractate in ultimele 24 luni</td>
                                                                              </tr>
                                                                           </table>
                                                                        </td>
                                                                        <td align="center" class="creditReportCell" colspan="2">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <xsl:value-of select="main_indicators/new_accounts[@type='banking']" />
                                                                        </td>
                                                                        <td align="center" class="creditReportCellData8">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <xsl:value-of select="main_indicators/new_accounts[@type='non_banking']" />
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td>
                                                                           <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                              <tr>
                                                                                 <td>
                                                                                    <img border="0" width="20" height="1">
                                                                                       <xsl:attribute name="src">
                                                                                          <xsl:call-template name="resource">
                                                                                             <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                             <xsl:with-param name="forEmail">
                                                                                                <xsl:value-of select="$forEmail" />
                                                                                             </xsl:with-param>
                                                                                          </xsl:call-template>
                                                                                       </xsl:attribute>
                                                                                    </img>
                                                                                 </td>
                                                                                 <td width="100%">Numarul de conturi inchise in ultimele 24 luni</td>
                                                                              </tr>
                                                                           </table>
                                                                        </td>
                                                                        <td align="center" class="creditReportCell" colspan="2">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <xsl:value-of select="main_indicators/closed_accounts[@type='banking']" />
                                                                        </td>
                                                                        <td align="center" class="creditReportCellData8">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <xsl:value-of select="main_indicators/closed_accounts[@type='non_banking']" />
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td>
                                                                           <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                              <tr>
                                                                                 <td>
                                                                                    <img border="0" width="20" height="1">
                                                                                       <xsl:attribute name="src">
                                                                                          <xsl:call-template name="resource">
                                                                                             <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                             <xsl:with-param name="forEmail">
                                                                                                <xsl:value-of select="$forEmail" />
                                                                                             </xsl:with-param>
                                                                                          </xsl:call-template>
                                                                                       </xsl:attribute>
                                                                                    </img>
                                                                                 </td>
                                                                                 <td width="100%">
                                                                                    <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                       <tr>
                                                                                          <td>
                                                                                             <img border="0" width="20" height="1">
                                                                                                <xsl:attribute name="src">
                                                                                                   <xsl:call-template name="resource">
                                                                                                      <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                      <xsl:with-param name="forEmail">
                                                                                                         <xsl:value-of select="$forEmail" />
                                                                                                      </xsl:with-param>
                                                                                                   </xsl:call-template>
                                                                                                </xsl:attribute>
                                                                                             </img>
                                                                                          </td>
                                                                                          <td width="100%">- La  termen</td>
                                                                                       </tr>
                                                                                    </table>
                                                                                 </td>
                                                                              </tr>
                                                                           </table>
                                                                        </td>
                                                                        <td align="center" class="creditReportCell" colspan="2">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <xsl:value-of select="main_indicators/closed_on_term[@type='banking']" />
                                                                        </td>
                                                                        <td align="center" class="creditReportCellData8">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <xsl:value-of select="main_indicators/closed_on_term[@type='non_banking']" />
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td>
                                                                           <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                              <tr>
                                                                                 <td>
                                                                                    <img border="0" width="20" height="1">
                                                                                       <xsl:attribute name="src">
                                                                                          <xsl:call-template name="resource">
                                                                                             <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                             <xsl:with-param name="forEmail">
                                                                                                <xsl:value-of select="$forEmail" />
                                                                                             </xsl:with-param>
                                                                                          </xsl:call-template>
                                                                                       </xsl:attribute>
                                                                                    </img>
                                                                                 </td>
                                                                                 <td width="100%">
                                                                                    <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                       <tr>
                                                                                          <td>
                                                                                             <img border="0" width="20" height="1">
                                                                                                <xsl:attribute name="src">
                                                                                                   <xsl:call-template name="resource">
                                                                                                      <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                      <xsl:with-param name="forEmail">
                                                                                                         <xsl:value-of select="$forEmail" />
                                                                                                      </xsl:with-param>
                                                                                                   </xsl:call-template>
                                                                                                </xsl:attribute>
                                                                                             </img>
                                                                                          </td>
                                                                                          <td width="100%">- Anticipat</td>
                                                                                       </tr>
                                                                                    </table>
                                                                                 </td>
                                                                              </tr>
                                                                           </table>
                                                                        </td>
                                                                        <td align="center" class="creditReportCell" colspan="2">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <xsl:value-of select="main_indicators/closed_before[@type='banking']" />
                                                                        </td>
                                                                        <td align="center" class="creditReportCellData8">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <xsl:value-of select="main_indicators/closed_before[@type='non_banking']" />
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td>
                                                                           <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                              <tr>
                                                                                 <td>
                                                                                    <img border="0" width="20" height="1">
                                                                                       <xsl:attribute name="src">
                                                                                          <xsl:call-template name="resource">
                                                                                             <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                             <xsl:with-param name="forEmail">
                                                                                                <xsl:value-of select="$forEmail" />
                                                                                             </xsl:with-param>
                                                                                          </xsl:call-template>
                                                                                       </xsl:attribute>
                                                                                    </img>
                                                                                 </td>
                                                                                 <td width="100%">
                                                                                    <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                       <tr>
                                                                                          <td>
                                                                                             <img border="0" width="20" height="1">
                                                                                                <xsl:attribute name="src">
                                                                                                   <xsl:call-template name="resource">
                                                                                                      <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                      <xsl:with-param name="forEmail">
                                                                                                         <xsl:value-of select="$forEmail" />
                                                                                                      </xsl:with-param>
                                                                                                   </xsl:call-template>
                                                                                                </xsl:attribute>
                                                                                             </img>
                                                                                          </td>
                                                                                          <td width="100%">- Altele</td>
                                                                                       </tr>
                                                                                    </table>
                                                                                 </td>
                                                                              </tr>
                                                                           </table>
                                                                        </td>
                                                                        <td align="center" class="creditReportCell" colspan="2">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <xsl:value-of select="main_indicators/closed_others[@type='banking']" />
                                                                        </td>
                                                                        <td align="center" class="creditReportCellData8">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <xsl:value-of select="main_indicators/closed_others[@type='non_banking']" />
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td>
                                                                           <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                              <tr>
                                                                                 <td>
                                                                                    <img border="0" width="20" height="1">
                                                                                       <xsl:attribute name="src">
                                                                                          <xsl:call-template name="resource">
                                                                                             <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                             <xsl:with-param name="forEmail">
                                                                                                <xsl:value-of select="$forEmail" />
                                                                                             </xsl:with-param>
                                                                                          </xsl:call-template>
                                                                                       </xsl:attribute>
                                                                                    </img>
                                                                                 </td>
                                                                                 <td width="100%">
                                                                                    Maximul platit intr-o luna in ultimele 24 luni (
                                                                                    <xsl:value-of select="primary_currency" />
                                                                                    )
                                                                                 </td>
                                                                              </tr>
                                                                           </table>
                                                                        </td>
                                                                        <td align="center" class="creditReportCell" colspan="2">
                                                                           <!-- maximum_monthly_payed -->
                                                                           <xsl:call-template name="currencyFormat">
                                                                              <xsl:with-param name="value">
                                                                                 <xsl:value-of select="main_indicators/maximum_monthly_payed[@type='banking']" />
                                                                              </xsl:with-param>
                                                                           </xsl:call-template>
                                                                        </td>
                                                                        <td align="center" class="creditReportCellData8">
                                                                           <xsl:call-template name="currencyFormat">
                                                                              <xsl:with-param name="value">
                                                                                 <xsl:value-of select="main_indicators/maximum_monthly_payed[@type='non_banking']" />
                                                                              </xsl:with-param>
                                                                           </xsl:call-template>
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td class="creditReportBlackNormal">
                                                                           <u>
                                                                              Activitati din ultimele
                                                                              <xsl:value-of select="main_indicators/months_before_date/@no_months" />
                                                                              luni (din
                                                                              <xsl:value-of select="main_indicators/months_before_date" />
                                                                              )
                                                                           </u>
                                                                        </td>
                                                                        <td align="center" class="creditReportCell" colspan="2">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td align="center" class="creditReportCellData8">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td class="creditReportBlackNormal">
                                                                           <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                              <tr>
                                                                                 <td>
                                                                                    <img border="0" width="20" height="1">
                                                                                       <xsl:attribute name="src">
                                                                                          <xsl:call-template name="resource">
                                                                                             <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                             <xsl:with-param name="forEmail">
                                                                                                <xsl:value-of select="$forEmail" />
                                                                                             </xsl:with-param>
                                                                                          </xsl:call-template>
                                                                                       </xsl:attribute>
                                                                                    </img>
                                                                                 </td>
                                                                                 <td width="100%">Numarul de conturi cu obligatii restante</td>
                                                                              </tr>
                                                                           </table>
                                                                        </td>
                                                                        <td align="center" class="creditReportCell" colspan="2">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <xsl:value-of select="main_indicators/past_due_accounts[@type='banking']" />
                                                                        </td>
                                                                        <td align="center" class="creditReportCellData8">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <xsl:value-of select="main_indicators/past_due_accounts[@type='non_banking']" />
                                                                        </td>
                                                                     </tr>
                                                                     <xsl:if test="string($situatiaInscrierii)!='true'">
                                                                        <tr>
                                                                           <td class="creditReportBlackNormal">
                                                                              <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                 <tr>
                                                                                    <td>
                                                                                       <img border="0" width="20" height="1">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </img>
                                                                                    </td>
                                                                                    <td width="100%">Interogari:</td>
                                                                                 </tr>
                                                                              </table>
                                                                           </td>
                                                                           <td align="center" class="creditReportCell" colspan="2">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="main_indicators/queries[@type='banking']" />
                                                                           </td>
                                                                           <td align="center" class="creditReportCellData8">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="main_indicators/queries[@type='non_banking']" />
                                                                           </td>
                                                                        </tr>
                                                                        <tr>
                                                                           <td class="creditReportBlackNormal">
                                                                              <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                 <tr>
                                                                                    <td>
                                                                                       <font color="#FF0000">
                                                                                          <img border="0" width="20" height="1">
                                                                                             <xsl:attribute name="src">
                                                                                                <xsl:call-template name="resource">
                                                                                                   <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                   <xsl:with-param name="forEmail">
                                                                                                      <xsl:value-of select="$forEmail" />
                                                                                                   </xsl:with-param>
                                                                                                </xsl:call-template>
                                                                                             </xsl:attribute>
                                                                                          </img>
                                                                                       </font>
                                                                                    </td>
                                                                                    <td width="100%">
                                                                                       <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                          <tr>
                                                                                             <td>
                                                                                                <font color="#FF0000">
                                                                                                   <img border="0" width="20" height="1">
                                                                                                      <xsl:attribute name="src">
                                                                                                         <xsl:call-template name="resource">
                                                                                                            <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                            <xsl:with-param name="forEmail">
                                                                                                               <xsl:value-of select="$forEmail" />
                                                                                                            </xsl:with-param>
                                                                                                         </xsl:call-template>
                                                                                                      </xsl:attribute>
                                                                                                   </img>
                                                                                                </font>
                                                                                             </td>
                                                                                             <td width="100%">- Banci si institutii financiare nebancare</td>
                                                                                          </tr>
                                                                                       </table>
                                                                                    </td>
                                                                                 </tr>
                                                                              </table>
                                                                           </td>
                                                                           <td align="center" class="creditReportCell" colspan="2">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="main_indicators/qry_no_banking[@type='banking']" />
                                                                           </td>
                                                                           <td align="center" class="creditReportCellData8">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;-</xsl:text>
                                                                           </td>
                                                                        </tr>
                                                                        <ul>
                                                                           <tr>
                                                                              <td class="creditReportBlackNormal">
                                                                                 <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                    <tr>
                                                                                       <td>
                                                                                          <font color="#FF0000">
                                                                                             <img border="0" width="20" height="1">
                                                                                                <xsl:attribute name="src">
                                                                                                   <xsl:call-template name="resource">
                                                                                                      <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                      <xsl:with-param name="forEmail">
                                                                                                         <xsl:value-of select="$forEmail" />
                                                                                                      </xsl:with-param>
                                                                                                   </xsl:call-template>
                                                                                                </xsl:attribute>
                                                                                             </img>
                                                                                          </font>
                                                                                       </td>
                                                                                       <td width="100%">
                                                                                          <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                             <tr>
                                                                                                <td>
                                                                                                   <font color="#FF0000">
                                                                                                      <img border="0" width="47" height="1">
                                                                                                         <xsl:attribute name="src">
                                                                                                            <xsl:call-template name="resource">
                                                                                                               <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                               <xsl:with-param name="forEmail">
                                                                                                                  <xsl:value-of select="$forEmail" />
                                                                                                               </xsl:with-param>
                                                                                                            </xsl:call-template>
                                                                                                         </xsl:attribute>
                                                                                                      </img>
                                                                                                   </font>
                                                                                                </td>
                                                                                                <td width="100%">
                                                                                                   <LI>Credit, acordat persoanei juridice</LI>
                                                                                                </td>
                                                                                             </tr>
                                                                                          </table>
                                                                                       </td>
                                                                                    </tr>
                                                                                 </table>
                                                                              </td>
                                                                              <td align="center" class="creditReportCell" colspan="2">
                                                                                 <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 <xsl:value-of select="main_indicators/qry_no_ccc[@type='banking']" />
                                                                              </td>
                                                                              <td align="center" class="creditReportCellData8">
                                                                                 <xsl:text disable-output-escaping="yes">&amp;nbsp;-</xsl:text>
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td class="creditReportBlackNormal">
                                                                                 <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                    <tr>
                                                                                       <td>
                                                                                          <font color="#FF0000">
                                                                                             <img border="0" width="20" height="1">
                                                                                                <xsl:attribute name="src">
                                                                                                   <xsl:call-template name="resource">
                                                                                                      <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                      <xsl:with-param name="forEmail">
                                                                                                         <xsl:value-of select="$forEmail" />
                                                                                                      </xsl:with-param>
                                                                                                   </xsl:call-template>
                                                                                                </xsl:attribute>
                                                                                             </img>
                                                                                          </font>
                                                                                       </td>
                                                                                       <td width="100%">
                                                                                          <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                             <tr>
                                                                                                <td>
                                                                                                   <font color="#FF0000">
                                                                                                      <img border="0" width="47" height="1">
                                                                                                         <xsl:attribute name="src">
                                                                                                            <xsl:call-template name="resource">
                                                                                                               <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                               <xsl:with-param name="forEmail">
                                                                                                                  <xsl:value-of select="$forEmail" />
                                                                                                               </xsl:with-param>
                                                                                                            </xsl:call-template>
                                                                                                         </xsl:attribute>
                                                                                                      </img>
                                                                                                   </font>
                                                                                                </td>
                                                                                                <td width="100%">
                                                                                                   <LI>Credit, acordat persoanei fizice</LI>
                                                                                                </td>
                                                                                             </tr>
                                                                                          </table>
                                                                                       </td>
                                                                                    </tr>
                                                                                 </table>
                                                                              </td>
                                                                              <td align="center" class="creditReportCell" colspan="2">
                                                                                 <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 <xsl:value-of select="main_indicators/qry_no_cci[@type='banking']" />
                                                                              </td>
                                                                              <td align="center" class="creditReportCellData8">
                                                                                 <xsl:text disable-output-escaping="yes">&amp;nbsp;-</xsl:text>
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td class="creditReportBlackNormal">
                                                                                 <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                    <tr>
                                                                                       <td>
                                                                                          <font color="#FF0000">
                                                                                             <img border="0" width="20" height="1">
                                                                                                <xsl:attribute name="src">
                                                                                                   <xsl:call-template name="resource">
                                                                                                      <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                      <xsl:with-param name="forEmail">
                                                                                                         <xsl:value-of select="$forEmail" />
                                                                                                      </xsl:with-param>
                                                                                                   </xsl:call-template>
                                                                                                </xsl:attribute>
                                                                                             </img>
                                                                                          </font>
                                                                                       </td>
                                                                                       <td width="100%">
                                                                                          <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                             <tr>
                                                                                                <td>
                                                                                                   <font color="#FF0000">
                                                                                                      <img border="0" width="47" height="1">
                                                                                                         <xsl:attribute name="src">
                                                                                                            <xsl:call-template name="resource">
                                                                                                               <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                               <xsl:with-param name="forEmail">
                                                                                                                  <xsl:value-of select="$forEmail" />
                                                                                                               </xsl:with-param>
                                                                                                            </xsl:call-template>
                                                                                                         </xsl:attribute>
                                                                                                      </img>
                                                                                                   </font>
                                                                                                </td>
                                                                                                <td width="100%">
                                                                                                   <LI>Credit, acordat antreprenorului individual</LI>
                                                                                                </td>
                                                                                             </tr>
                                                                                          </table>
                                                                                       </td>
                                                                                    </tr>
                                                                                 </table>
                                                                              </td>
                                                                              <td align="center" class="creditReportCell" colspan="2">
                                                                                 <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 <xsl:value-of select="main_indicators/qry_no_ccm[@type='banking']" />
                                                                              </td>
                                                                              <td align="center" class="creditReportCellData8">
                                                                                 <xsl:text disable-output-escaping="yes">&amp;nbsp;-</xsl:text>
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td class="creditReportBlackNormal">
                                                                                 <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                    <tr>
                                                                                       <td>
                                                                                          <font color="#FF0000">
                                                                                             <img border="0" width="20" height="1">
                                                                                                <xsl:attribute name="src">
                                                                                                   <xsl:call-template name="resource">
                                                                                                      <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                      <xsl:with-param name="forEmail">
                                                                                                         <xsl:value-of select="$forEmail" />
                                                                                                      </xsl:with-param>
                                                                                                   </xsl:call-template>
                                                                                                </xsl:attribute>
                                                                                             </img>
                                                                                          </font>
                                                                                       </td>
                                                                                       <td width="100%">
                                                                                          <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                             <tr>
                                                                                                <td>
                                                                                                   <font color="#FF0000">
                                                                                                      <img border="0" width="47" height="1">
                                                                                                         <xsl:attribute name="src">
                                                                                                            <xsl:call-template name="resource">
                                                                                                               <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                               <xsl:with-param name="forEmail">
                                                                                                                  <xsl:value-of select="$forEmail" />
                                                                                                               </xsl:with-param>
                                                                                                            </xsl:call-template>
                                                                                                         </xsl:attribute>
                                                                                                      </img>
                                                                                                   </font>
                                                                                                </td>
                                                                                                <td width="100%">
                                                                                                   <LI>Leasing</LI>
                                                                                                </td>
                                                                                             </tr>
                                                                                          </table>
                                                                                       </td>
                                                                                    </tr>
                                                                                 </table>
                                                                              </td>
                                                                              <td align="center" class="creditReportCell" colspan="2">
                                                                                 <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 <xsl:value-of select="main_indicators/qry_no_cco[@type='banking']" />
                                                                              </td>
                                                                              <td align="center" class="creditReportCellData8">
                                                                                 <xsl:text disable-output-escaping="yes">&amp;nbsp;-</xsl:text>
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td class="creditReportBlackNormal">
                                                                                 <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                    <tr>
                                                                                       <td>
                                                                                          <font color="#FF0000">
                                                                                             <img border="0" width="20" height="1">
                                                                                                <xsl:attribute name="src">
                                                                                                   <xsl:call-template name="resource">
                                                                                                      <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                      <xsl:with-param name="forEmail">
                                                                                                         <xsl:value-of select="$forEmail" />
                                                                                                      </xsl:with-param>
                                                                                                   </xsl:call-template>
                                                                                                </xsl:attribute>
                                                                                             </img>
                                                                                          </font>
                                                                                       </td>
                                                                                       <td width="100%">
                                                                                          <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                             <tr>
                                                                                                <td>
                                                                                                   <font color="#FF0000">
                                                                                                      <img border="0" width="47" height="1">
                                                                                                         <xsl:attribute name="src">
                                                                                                            <xsl:call-template name="resource">
                                                                                                               <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                               <xsl:with-param name="forEmail">
                                                                                                                  <xsl:value-of select="$forEmail" />
                                                                                                               </xsl:with-param>
                                                                                                            </xsl:call-template>
                                                                                                         </xsl:attribute>
                                                                                                      </img>
                                                                                                   </font>
                                                                                                </td>
                                                                                                <td width="100%">
                                                                                                   <LI>Card de credit</LI>
                                                                                                </td>
                                                                                             </tr>
                                                                                          </table>
                                                                                       </td>
                                                                                    </tr>
                                                                                 </table>
                                                                              </td>
                                                                              <td align="center" class="creditReportCell" colspan="2">
                                                                                 <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 <xsl:value-of select="main_indicators/qry_no_ccr[@type='banking']" />
                                                                              </td>
                                                                              <td align="center" class="creditReportCellData8">
                                                                                 <xsl:text disable-output-escaping="yes">&amp;nbsp;-</xsl:text>
                                                                              </td>
                                                                           </tr>
                                                                        </ul>
                                                                        <tr>
                                                                           <td class="creditReportBlackNormal">
                                                                              <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                 <tr>
                                                                                    <td>
                                                                                       <font color="#FF0000">
                                                                                          <img border="0" width="20" height="1">
                                                                                             <xsl:attribute name="src">
                                                                                                <xsl:call-template name="resource">
                                                                                                   <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                   <xsl:with-param name="forEmail">
                                                                                                      <xsl:value-of select="$forEmail" />
                                                                                                   </xsl:with-param>
                                                                                                </xsl:call-template>
                                                                                             </xsl:attribute>
                                                                                          </img>
                                                                                       </font>
                                                                                    </td>
                                                                                    <td width="100%">
                                                                                       <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                          <tr>
                                                                                             <td>
                                                                                                <font color="#FF0000">
                                                                                                   <img border="0" width="20" height="1">
                                                                                                      <xsl:attribute name="src">
                                                                                                         <xsl:call-template name="resource">
                                                                                                            <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                            <xsl:with-param name="forEmail">
                                                                                                               <xsl:value-of select="$forEmail" />
                                                                                                            </xsl:with-param>
                                                                                                         </xsl:call-template>
                                                                                                      </xsl:attribute>
                                                                                                   </img>
                                                                                                </font>
                                                                                             </td>
                                                                                             <td width="100%">- Asigurari</td>
                                                                                          </tr>
                                                                                       </table>
                                                                                    </td>
                                                                                 </tr>
                                                                              </table>
                                                                           </td>
                                                                           <td align="center" class="creditReportCell" colspan="2">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;-</xsl:text>
                                                                           </td>
                                                                           <td align="center" class="creditReportCellData8">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="main_indicators/qry_no_ensurance[@type='non_banking']" />
                                                                           </td>
                                                                        </tr>
                                                                        <tr>
                                                                           <td class="creditReportBlackNormal">
                                                                              <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                 <tr>
                                                                                    <td>
                                                                                       <font color="#FF0000">
                                                                                          <img border="0" width="20" height="1">
                                                                                             <xsl:attribute name="src">
                                                                                                <xsl:call-template name="resource">
                                                                                                   <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                   <xsl:with-param name="forEmail">
                                                                                                      <xsl:value-of select="$forEmail" />
                                                                                                   </xsl:with-param>
                                                                                                </xsl:call-template>
                                                                                             </xsl:attribute>
                                                                                          </img>
                                                                                       </font>
                                                                                    </td>
                                                                                    <td width="100%">
                                                                                       <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                          <tr>
                                                                                             <td>
                                                                                                <font color="#FF0000">
                                                                                                   <img border="0" width="20" height="1">
                                                                                                      <xsl:attribute name="src">
                                                                                                         <xsl:call-template name="resource">
                                                                                                            <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                            <xsl:with-param name="forEmail">
                                                                                                               <xsl:value-of select="$forEmail" />
                                                                                                            </xsl:with-param>
                                                                                                         </xsl:call-template>
                                                                                                      </xsl:attribute>
                                                                                                   </img>
                                                                                                </font>
                                                                                             </td>
                                                                                             <td width="100%">- Leasing</td>
                                                                                          </tr>
                                                                                       </table>
                                                                                    </td>
                                                                                 </tr>
                                                                              </table>
                                                                           </td>
                                                                           <td align="center" class="creditReportCell" colspan="2">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;-</xsl:text>
                                                                           </td>
                                                                           <td align="center" class="creditReportCellData8">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="main_indicators/qry_no_leasing[@type='non_banking']" />
                                                                           </td>
                                                                        </tr>
                                                                        <tr>
                                                                           <td class="creditReportBlackNormal">
                                                                              <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                 <tr>
                                                                                    <td>
                                                                                       <font color="#FF0000">
                                                                                          <img border="0" width="20" height="1">
                                                                                             <xsl:attribute name="src">
                                                                                                <xsl:call-template name="resource">
                                                                                                   <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                   <xsl:with-param name="forEmail">
                                                                                                      <xsl:value-of select="$forEmail" />
                                                                                                   </xsl:with-param>
                                                                                                </xsl:call-template>
                                                                                             </xsl:attribute>
                                                                                          </img>
                                                                                       </font>
                                                                                    </td>
                                                                                    <td width="100%">
                                                                                       <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                          <tr>
                                                                                             <td>
                                                                                                <font color="#FF0000">
                                                                                                   <img border="0" width="20" height="1">
                                                                                                      <xsl:attribute name="src">
                                                                                                         <xsl:call-template name="resource">
                                                                                                            <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                            <xsl:with-param name="forEmail">
                                                                                                               <xsl:value-of select="$forEmail" />
                                                                                                            </xsl:with-param>
                                                                                                         </xsl:call-template>
                                                                                                      </xsl:attribute>
                                                                                                   </img>
                                                                                                </font>
                                                                                             </td>
                                                                                             <td width="100%">- Utilitati</td>
                                                                                          </tr>
                                                                                       </table>
                                                                                    </td>
                                                                                 </tr>
                                                                              </table>
                                                                           </td>
                                                                           <td align="center" class="creditReportCell" colspan="2">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;-</xsl:text>
                                                                           </td>
                                                                           <td align="center" class="creditReportCellData8">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="main_indicators/qry_no_utilities[@type='non_banking']" />
                                                                           </td>
                                                                        </tr>
                                                                        <tr>
                                                                           <td class="creditReportBlackNormal">
                                                                              <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                 <tr>
                                                                                    <td>
                                                                                       <font color="#FF0000">
                                                                                          <img border="0" width="20" height="1">
                                                                                             <xsl:attribute name="src">
                                                                                                <xsl:call-template name="resource">
                                                                                                   <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                   <xsl:with-param name="forEmail">
                                                                                                      <xsl:value-of select="$forEmail" />
                                                                                                   </xsl:with-param>
                                                                                                </xsl:call-template>
                                                                                             </xsl:attribute>
                                                                                          </img>
                                                                                       </font>
                                                                                    </td>
                                                                                    <td width="100%">
                                                                                       <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                          <tr>
                                                                                             <td>
                                                                                                <font color="#FF0000">
                                                                                                   <img border="0" width="20" height="1">
                                                                                                      <xsl:attribute name="src">
                                                                                                         <xsl:call-template name="resource">
                                                                                                            <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                            <xsl:with-param name="forEmail">
                                                                                                               <xsl:value-of select="$forEmail" />
                                                                                                            </xsl:with-param>
                                                                                                         </xsl:call-template>
                                                                                                      </xsl:attribute>
                                                                                                   </img>
                                                                                                </font>
                                                                                             </td>
                                                                                             <td width="100%">- Altele</td>
                                                                                          </tr>
                                                                                       </table>
                                                                                    </td>
                                                                                 </tr>
                                                                              </table>
                                                                           </td>
                                                                           <td align="center" class="creditReportCell" colspan="2">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;-</xsl:text>
                                                                           </td>
                                                                           <td align="center" class="creditReportCellData8">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="main_indicators/qry_no_other[@type='non_banking']" />
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:if>
                                                                     <!-- string($situatiaInscrierii)!='true' -->
                                                                     <tr>
                                                                        <td class="creditReportBlackNormal">
                                                                           <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                              <tr>
                                                                                 <td>
                                                                                    <img border="0" width="20" height="1">
                                                                                       <xsl:attribute name="src">
                                                                                          <xsl:call-template name="resource">
                                                                                             <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                             <xsl:with-param name="forEmail">
                                                                                                <xsl:value-of select="$forEmail" />
                                                                                             </xsl:with-param>
                                                                                          </xsl:call-template>
                                                                                       </xsl:attribute>
                                                                                    </img>
                                                                                 </td>
                                                                                 <td width="100%">Numarul de conturi actualizate</td>
                                                                              </tr>
                                                                           </table>
                                                                        </td>
                                                                        <td align="center" class="creditReportCell" colspan="2">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <xsl:value-of select="main_indicators/updated_accounts[@type='banking']" />
                                                                        </td>
                                                                        <td align="center" class="creditReportCellData8">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <xsl:value-of select="main_indicators/updated_accounts[@type='non_banking']" />
                                                                        </td>
                                                                     </tr>
                                                                     <xsl:if test="string($situatiaInscrierii)!='true'">
                                                                        <tr>
                                                                           <td class="creditReportBlackNormal">
                                                                              <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                                                                 <tr>
                                                                                    <td>
                                                                                       <img border="0" width="20" height="1">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </img>
                                                                                    </td>
                                                                                    <td width="100%">Cea mai recenta interogare</td>
                                                                                 </tr>
                                                                              </table>
                                                                           </td>
                                                                           <td align="center" class="creditReportCell" colspan="3">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="main_indicators/last_query_date" />
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:if>
                                                                     <!-- string($situatiaInscrierii)!='true' -->
                                                                  </table>
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                               <td align="center">
                                                                  <table border="0" cellspacing="0">
                                                                     <tr>
                                                                        <td>
                                                                           Nota:
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
                                                                           Recalcularea valorii creditelor in valuta straina se efectueaza la cursul valutar al BNM la data eliberarii
                                                                           <br />
                                                                           Raportului de Credit.
                                                                        </td>
                                                                     </tr>
                                                                  </table>
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                               <td align="center">
                                                                  <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                               <td class="creditReportHeadBlack" align="center">
                                                                  <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                               </td>
                                                            </tr>
                                                         </xsl:if>
                                                         <!-- END of MAIN_INDICATORS section -->
                                                         <!-- START of HISTORY_DELAY_CATEGORIES section -->
                                                         <xsl:if test="string(cr_request/extras_history_delay_categories)='true'">
                                                            <!-- End of Raport de credit pentru C.N.P. -->
                                                            <tr>
                                                               <td class="creditReportHeadBlack" align="center">Istoricul incadrarii in categoriile de intarziere</td>
                                                            </tr>
                                                            <tr>
                                                               <td align="center">
                                                                  pentru IDNO/IDNP:
                                                                  <xsl:value-of select="personal_data/idno_idnp" />
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                               <td align="center">
                                                                  <table cellpadding="2" cellspacing="1" class="tableType1" style="border: 1px outset #000000">
                                                                     <tr>
                                                                        <td align="center" width="80" class="calendarCellHeader">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="calendarCellHeader" width="18">Ian</td>
                                                                        <td class="calendarCellHeader" width="18">Feb</td>
                                                                        <td class="calendarCellHeader" width="18">Mar</td>
                                                                        <td class="calendarCellHeader" width="18">Apr</td>
                                                                        <td class="calendarCellHeader" width="18">Mai</td>
                                                                        <td class="calendarCellHeader" width="18">Iun</td>
                                                                        <td class="calendarCellHeader" width="18">Iul</td>
                                                                        <td class="calendarCellHeader" width="18">Aug</td>
                                                                        <td class="calendarCellHeader" width="18">Sep</td>
                                                                        <td class="calendarCellHeader" width="18">Oct</td>
                                                                        <td class="calendarCellHeader" width="18">Nov</td>
                                                                        <td class="calendarCellHeader" width="18">Dec</td>
                                                                     </tr>
                                                                     <xsl:for-each select="delays_history">
                                                                        <xsl:for-each select="yr">
                                                                           <tr>
                                                                              <td class="calendarCellLeft" align="center" width="80">
                                                                                 <xsl:value-of select="@value" />
                                                                              </td>
                                                                              <xsl:for-each select="month">
                                                                                 <td class="calendarCellDarkWave" width="18" height="16">
                                                                                    <img border="0" height="28" width="28">
                                                                                       <xsl:attribute name="src">
                                                                                          <xsl:call-template name="resource">
                                                                                             <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                             <xsl:with-param name="forEmail">
                                                                                                <xsl:value-of select="$forEmail" />
                                                                                             </xsl:with-param>
                                                                                          </xsl:call-template>
                                                                                       </xsl:attribute>
                                                                                       <xsl:if test="@value='0'">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">rating00.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="@value='1'">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">rating01.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="@value='2'">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">rating02.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="@value='3'">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">rating03.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="@value='4'">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">rating04.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="@value='5'">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">rating05.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="@value='6'">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">rating06.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="@value='G'">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">G.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="@value='L'">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">L.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </xsl:if>
                                                                                    </img>
                                                                                 </td>
                                                                              </xsl:for-each>
                                                                           </tr>
                                                                        </xsl:for-each>
                                                                     </xsl:for-each>
                                                                     <xsl:if test="count(delays_history/yr)&lt;1">
                                                                        <tr>
                                                                           <td class="calendarCellLeft" align="center" width="80">2003</td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:if>
                                                                     <xsl:if test="count(delays_history/yr)&lt;2">
                                                                        <tr>
                                                                           <td class="calendarCellLeft" align="center" width="80">2004</td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:if>
                                                                     <xsl:if test="count(delays_history/yr)&lt;3">
                                                                        <tr>
                                                                           <td class="calendarCellLeft" align="center" width="80">2005</td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:if>
                                                                     <xsl:if test="count(delays_history/yr)&lt;4">
                                                                        <tr>
                                                                           <td class="calendarCellLeft" align="center" width="80">2006</td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:if>
                                                                     <xsl:if test="count(delays_history/yr)&lt;5">
                                                                        <tr>
                                                                           <td class="calendarCellLeft" align="center" width="80">2007</td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:if>
                                                                     <xsl:if test="count(delays_history/yr)&lt;5">
                                                                        <tr>
                                                                           <td class="calendarCellLeft" align="center" width="80">2008</td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:if>
                                                                     <xsl:if test="count(delays_history/yr)&lt;5">
                                                                        <tr>
                                                                           <td class="calendarCellLeft" align="center" width="80">2009</td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="calendarCellDarkWave" height="28" width="28">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                        </tr>
                                                                     </xsl:if>
                                                                  </table>
                                                                  <p>
                                                                     <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                  </p>
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                               <td />
                                                            </tr>
                                                            <!-- 	SUMAR CONTURI -->
                                                            <tr>
                                                               <td />
                                                            </tr>
                                                            <tr>
                                                               <td />
                                                            </tr>
                                                         </xsl:if>
                                                         <!-- END of MAIN_INDICATORS section -->
                                                         <!-- START of ACCOUNTS_SUMMARY section -->
                                                         <xsl:if test="string(cr_request/extras_accounts_summary)='true'">
                                                            <!-- START SUMAR CONTURI -->
                                                            <tr>
                                                               <td class="creditReportHeadBlack" align="center">SUMAR CONTURI</td>
                                                            </tr>
                                                            <tr>
                                                               <td align="center">
                                                                  apartinand IDNO/IDNP:
                                                                  <xsl:value-of select="personal_data/idno_idnp" />
                                                                  , la data de:
                                                                  <xsl:value-of select="inquiry_date/date" />
                                                               </td>
                                                            </tr>
                                                            <xsl:call-template name="accounts_summary_table">
                                                               <xsl:with-param name="ParticipantTypeCode">01</xsl:with-param>
                                                               <xsl:with-param name="ParticipantTypeName">Comercial</xsl:with-param>
                                                            </xsl:call-template>
                                                            <tr>
                                                               <td />
                                                            </tr>
                                                            <xsl:call-template name="accounts_summary_table">
                                                               <xsl:with-param name="ParticipantTypeCode">02</xsl:with-param>
                                                               <xsl:with-param name="ParticipantTypeName">Medical</xsl:with-param>
                                                            </xsl:call-template>
                                                            <tr>
                                                               <td />
                                                            </tr>
                                                            <xsl:call-template name="accounts_summary_table">
                                                               <xsl:with-param name="ParticipantTypeCode">03</xsl:with-param>
                                                               <xsl:with-param name="ParticipantTypeName">Companie petroliera</xsl:with-param>
                                                            </xsl:call-template>
                                                            <tr>
                                                               <td />
                                                            </tr>
                                                            <xsl:call-template name="accounts_summary_table">
                                                               <xsl:with-param name="ParticipantTypeCode">04</xsl:with-param>
                                                               <xsl:with-param name="ParticipantTypeName">Guvernamental</xsl:with-param>
                                                            </xsl:call-template>
                                                            <tr>
                                                               <td />
                                                            </tr>
                                                            <xsl:call-template name="accounts_summary_table">
                                                               <xsl:with-param name="ParticipantTypeCode">05</xsl:with-param>
                                                               <xsl:with-param name="ParticipantTypeName">Servicii personale</xsl:with-param>
                                                            </xsl:call-template>
                                                            <tr>
                                                               <td />
                                                            </tr>
                                                            <xsl:call-template name="accounts_summary_table">
                                                               <xsl:with-param name="ParticipantTypeCode">06</xsl:with-param>
                                                               <xsl:with-param name="ParticipantTypeName">Companie de asigurari, reasigurari (alte activitati decat colectarea de creante)</xsl:with-param>
                                                            </xsl:call-template>
                                                            <tr>
                                                               <td />
                                                            </tr>
                                                            <xsl:call-template name="accounts_summary_table">
                                                               <xsl:with-param name="ParticipantTypeCode">07</xsl:with-param>
                                                               <xsl:with-param name="ParticipantTypeName">Educational</xsl:with-param>
                                                            </xsl:call-template>
                                                            <tr>
                                                               <td />
                                                            </tr>
                                                            <xsl:call-template name="accounts_summary_table">
                                                               <xsl:with-param name="ParticipantTypeCode">08</xsl:with-param>
                                                               <xsl:with-param name="ParticipantTypeName">Banca sau Asociatie de Economii si Imprumut</xsl:with-param>
                                                            </xsl:call-template>
                                                            <tr>
                                                               <td />
                                                            </tr>
                                                            <xsl:call-template name="accounts_summary_table">
                                                               <xsl:with-param name="ParticipantTypeCode">09</xsl:with-param>
                                                               <xsl:with-param name="ParticipantTypeName">Societate de leasing</xsl:with-param>
                                                            </xsl:call-template>
                                                            <tr>
                                                               <td />
                                                            </tr>
                                                            <xsl:call-template name="accounts_summary_table">
                                                               <xsl:with-param name="ParticipantTypeCode">10</xsl:with-param>
                                                               <xsl:with-param name="ParticipantTypeName">Utilitati</xsl:with-param>
                                                            </xsl:call-template>
                                                            <tr>
                                                               <td />
                                                            </tr>
                                                            <xsl:call-template name="accounts_summary_table">
                                                               <xsl:with-param name="ParticipantTypeCode">11</xsl:with-param>
                                                               <xsl:with-param name="ParticipantTypeName">Telefonie</xsl:with-param>
                                                            </xsl:call-template>
                                                            <tr>
                                                               <td />
                                                            </tr>
                                                            <xsl:call-template name="accounts_summary_table">
                                                               <xsl:with-param name="ParticipantTypeCode">12</xsl:with-param>
                                                               <xsl:with-param name="ParticipantTypeName">Organizatie de Microfinantare</xsl:with-param>
                                                            </xsl:call-template>
                                                            <tr>
                                                               <td />
                                                            </tr>
                                                            <xsl:call-template name="accounts_summary_table">
                                                               <xsl:with-param name="ParticipantTypeCode">14</xsl:with-param>
                                                               <xsl:with-param name="ParticipantTypeName">Dealeri auto</xsl:with-param>
                                                            </xsl:call-template>
                                                            <tr>
                                                               <td />
                                                            </tr>
                                                            <xsl:if test="count(accounts_summary/account) = 0">
                                                               <tr>
                                                                  <td>
                                                                     <table border="0" width="100%" cellpadding="2" cellspacing="0" style="border: 1px outset #000000">
                                                                        <tr>
                                                                           <td class="creditReportCellHeaderSmall" width="16">Sursa de formare</td>
                                                                           <td class="creditReportCellHeaderSmall" width="16">
                                                                              Acord
                                                                              <br />
                                                                              semnat
                                                                           </td>
                                                                           <td class="creditReportCellHeaderSmall" width="95">Tip portofoliu</td>
                                                                           <td class="creditReportCellHeaderSmall">Stare cont</td>
                                                                           <td class="creditReportCellHeaderSmall" width="70">
                                                                              Data ultimei
                                                                              <br />
                                                                              actualizari
                                                                           </td>
                                                                           <td class="creditReportCellHeaderSmall" width="35">Valuta</td>
                                                                           <td class="creditReportCellHeaderSmall" width="75">
                                                                              Limita
                                                                              <br />
                                                                              credit
                                                                           </td>
                                                                           <td class="creditReportCellHeaderSmall" width="75">
                                                                              Valoare
                                                                              <br />
                                                                              imprumut
                                                                           </td>
                                                                           <td class="creditReportCellHeaderSmall" width="75">
                                                                              Sold
                                                                              <br />
                                                                              curent
                                                                           </td>
                                                                           <td class="creditReportCellHeaderSmall" width="75">
                                                                              Suma
                                                                              <br />
                                                                              obligatiilor restante
                                                                           </td>
                                                                           <td class="creditReportCellHeaderSmall" width="75">
                                                                              Frecventa
                                                                              <br />
                                                                              plati
                                                                           </td>
                                                                           <td class="creditReportCellHeaderSmall" width="90">
                                                                              Infomatii
                                                                              <br />
                                                                              detaliate cont
                                                                           </td>
                                                                        </tr>
                                                                        <tr>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall wrapped">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall wrapped">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                        </tr>
                                                                        <tr>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall wrapped">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall wrapped">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                        </tr>
                                                                        <tr>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall wrapped">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall wrapped">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                        </tr>
                                                                     </table>
                                                                  </td>
                                                               </tr>
                                                            </xsl:if>
                                                            <!--END SUMAR CONTURI -->
                                                            <tr>
                                                               <td>
                                                                  <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                               </td>
                                                            </tr>
                                                         </xsl:if>
                                                         <!-- END of ACCOUNTS_SUMMARY section -->
                                                         <!-- START of ACCOUNTS_DETAILS section -->
                                                         <xsl:if test="string(cr_request/extras_accounts_details)='true'">
                                                            <!-- START DETALII CONTURI -->
                                                            <xsl:if test="count(accounts_details/account_details)&gt;0">
                                                               <tr>
                                                                  <td />
                                                               </tr>
                                                               <tr>
                                                                  <td class="creditReportHeadBlack" align="center">DETALII CONTURI</td>
                                                               </tr>
                                                               <tr>
                                                                  <td align="center">
                                                                     apartinand IDNO/IDNP:
                                                                     <xsl:value-of select="personal_data/idno_idnp" />
                                                                     , la data de:
                                                                     <xsl:value-of select="inquiry_date/date" />
                                                                  </td>
                                                               </tr>
                                                               <tr>
                                                                  <td class="creditReportHeadBlack" />
                                                               </tr>
                                                               <xsl:for-each select="accounts_details/account_details">
                                                                  <tr>
                                                                     <tr>
                                                                        <td>
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                     </tr>
                                                                     <td>
                                                                        <table border="0" cellspacing="1">
                                                                           <tr>
                                                                              <td class="creditReportHeadBlack" colspan="2">
                                                                                 <xsl:value-of select="document_label" />
                                                                                 <a>
                                                                                    <xsl:attribute name="name">
                                                                                       #Account
                                                                                       <xsl:value-of select="anchor" />
                                                                                    </xsl:attribute>
                                                                                 </a>
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td colspan="2">
                                                                                 Apartinand IDNO/IDNP:
                                                                                 <xsl:value-of select="//personal_data/idno_idnp" />
                                                                                 , la data de:
                                                                                 <xsl:value-of select="//inquiry_date/date" />
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td colspan="2">
                                                                                 Sursa de formare:
                                                                                 <xsl:value-of select="participant/label" />
                                                                              </td>
                                                                           </tr>
                                                                           <xsl:if test="string($situatiaInscrierii)='true'">
                                                                              <tr>
                                                                                 <td colspan="2">
                                                                                    Adresa sursei de formare:
                                                                                    <xsl:value-of select="participant_address" />
                                                                                 </td>
                                                                              </tr>
                                                                           </xsl:if>
                                                                           <tr>
                                                                              <td colspan="2">
                                                                                 Tip sursa de formare:
                                                                                 <xsl:value-of select="participant/type" />
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td class="creditReportHeadBlackSmall" align="right">
                                                                                 <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              </td>
                                                                              <td class="creditReportNormalBlackSmall">
                                                                                 <img width="470" height="1">
                                                                                    <xsl:attribute name="src">
                                                                                       <xsl:call-template name="resource">
                                                                                          <xsl:with-param name="source">void.gif</xsl:with-param>
                                                                                          <xsl:with-param name="forEmail">
                                                                                             <xsl:value-of select="$forEmail" />
                                                                                          </xsl:with-param>
                                                                                       </xsl:call-template>
                                                                                    </xsl:attribute>
                                                                                 </img>
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td class="creditReportHeadBlackSmall" align="right">Acord semnat:</td>
                                                                              <td class="creditReportNormalBlackSmall">
                                                                                 <xsl:value-of select="process_indicator" />
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td class="creditReportHeadBlackSmall" align="right">Data ultimei actualizari:</td>
                                                                              <td class="creditReportNormalBlackSmall">
                                                                                 <xsl:value-of select="last_updated_on" />
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td class="creditReportHeadBlackSmall" align="right">Tip cont:</td>
                                                                              <td class="creditReportNormalBlackSmall">
                                                                                 <xsl:value-of select="account_type" />
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td class="creditReportHeadBlackSmall" align="right">Stare cont:</td>
                                                                              <td class="creditReportNormalBlackSmall">
                                                                                 <xsl:value-of select="account_status" />
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td class="creditReportHeadBlackSmall" align="right">Data acordarii:</td>
                                                                              <td class="creditReportNormalBlackSmall">
                                                                                 <xsl:value-of select="document_date" />
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td class="creditReportHeadBlackSmall" align="right">Durata contului:</td>
                                                                              <td class="creditReportNormalBlackSmall">
                                                                                 <xsl:value-of select="terms_duration" />
                                                                                 <xsl:if test="string(terms_duration/@time_unit)!=''">
                                                                                    <xsl:if test="terms_duration/@time_unit='m'">
                                                                                       <xsl:value-of select="' luni'" />
                                                                                    </xsl:if>
                                                                                 </xsl:if>
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td class="creditReportHeadBlackSmall" align="right">Data inchiderii:</td>
                                                                              <td class="creditReportNormalBlackSmall">
                                                                                 <xsl:value-of select="closing_date" />
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td class="creditReportHeadBlackSmall" align="right">Valuta:</td>
                                                                              <td class="creditReportNormalBlackSmall">
                                                                                 <xsl:value-of select="document_currency/@code" />
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td class="creditReportHeadBlackSmall" align="right">Asigurarea rambursarii:</td>
                                                                              <td class="creditReportNormalBlackSmall">
                                                                                 <xsl:value-of select="document_insurance" />
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td class="creditReportHeadBlackSmall" align="right">Limita credit:</td>
                                                                              <td class="creditReportNormalBlackSmall">
                                                                                 <!-- credit_limit -->
                                                                                 <xsl:call-template name="currencyFormat">
                                                                                    <xsl:with-param name="value">
                                                                                       <xsl:value-of select="credit_limit" />
                                                                                    </xsl:with-param>
                                                                                 </xsl:call-template>
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td class="creditReportHeadBlackSmall" align="right">Valoare imprumut:</td>
                                                                              <td class="creditReportNormalBlackSmall">
                                                                                 <!-- initial_value -->
                                                                                 <xsl:call-template name="currencyFormat">
                                                                                    <xsl:with-param name="value">
                                                                                       <xsl:value-of select="initial_value" />
                                                                                    </xsl:with-param>
                                                                                 </xsl:call-template>
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td class="creditReportHeadBlackSmall" align="right">Sold curent:</td>
                                                                              <td class="creditReportNormalBlackSmall">
                                                                                 <!-- current_balance -->
                                                                                 <xsl:call-template name="currencyFormat">
                                                                                    <xsl:with-param name="value">
                                                                                       <xsl:value-of select="current_balance" />
                                                                                    </xsl:with-param>
                                                                                 </xsl:call-template>
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td class="creditReportHeadBlackSmall" align="right">Suma obligatiilor restante:</td>
                                                                              <td class="creditReportNormalBlackSmall">
                                                                                 <!-- amount_past_due -->
                                                                                 <xsl:call-template name="currencyFormat">
                                                                                    <xsl:with-param name="value">
                                                                                       <xsl:value-of select="amount_past_due" />
                                                                                    </xsl:with-param>
                                                                                 </xsl:call-template>
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td class="creditReportHeadBlackSmall" align="right">Clasificare credit:</td>
                                                                              <td class="creditReportNormalBlackSmall">
                                                                                 <xsl:value-of select="document_risk_type" />
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td class="creditReportHeadBlackSmall" align="right">Data ultimei plati:</td>
                                                                              <td class="creditReportNormalBlackSmall">
                                                                                 <xsl:value-of select="date_of_last_payment" />
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td class="creditReportHeadBlackSmall" align="right">Data primei restante:</td>
                                                                              <td class="creditReportNormalBlackSmall">
                                                                                 <xsl:value-of select="first_delinquency_date" />
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td class="creditReportHeadBlackSmall" align="right">Categorie de intarziere curenta:</td>
                                                                              <td class="creditReportNormalBlackSmall">
                                                                                 <xsl:value-of select="payment_rating" />
                                                                              </td>
                                                                           </tr>
                                                                           <tr>
                                                                              <td class="creditReportHeadBlackSmall" align="right">
                                                                                 Stare plati in ultimele
                                                                                 <xsl:value-of select="count(payment_history_profile/payment_history)" />
                                                                                 luni:
                                                                              </td>
                                                                              <td class="creditReportNormalBlackSmall">
                                                                                 <xsl:for-each select="payment_history_profile/payment_history">
                                                                                    <img border="0">
                                                                                       <xsl:if test="@value='0'">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">istbonsmall0.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="@value='1'">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">istbonsmall1.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="@value='2'">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">istbonsmall2.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="@value='3'">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">istbonsmall3.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="@value='4'">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">istbonsmall4.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="@value='5'">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">istbonsmall5.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="@value='6'">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">istbonsmall6.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="@value='G'">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">istbonsmallG.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="@value='L'">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">istbonsmallL.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="@value='D'">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">istbonsmallD.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="@value='B'">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">istbonsmallB.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="@value='E'">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">istbonsmallE.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="@value='H'">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">istbonsmallH.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="@value='J'">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">istbonsmallJ.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="@value='K'">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">istbonsmallK.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </xsl:if>
                                                                                       <xsl:if test="@value='L'">
                                                                                          <xsl:attribute name="src">
                                                                                             <xsl:call-template name="resource">
                                                                                                <xsl:with-param name="source">istbonsmallL.gif</xsl:with-param>
                                                                                                <xsl:with-param name="forEmail">
                                                                                                   <xsl:value-of select="$forEmail" />
                                                                                                </xsl:with-param>
                                                                                             </xsl:call-template>
                                                                                          </xsl:attribute>
                                                                                       </xsl:if>
                                                                                    </img>
                                                                                 </xsl:for-each>
                                                                              </td>
                                                                           </tr>
                                                                        </table>
                                                                     </td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td>
                                                                        <table width="100%" cellpadding="2" cellspacing="0" style="border: 1px outset #000000">
                                                                           <tr>
                                                                              <td class="creditReportCellHeaderSmall">Data procesarii</td>
                                                                              <td class="creditReportCellHeaderSmall">Data actualizarii</td>
                                                                              <td class="creditReportCellHeaderSmall">Valuta</td>
                                                                              <td class="creditReportCellHeaderSmall">Limita credit</td>
                                                                              <td class="creditReportCellHeaderSmall">Valoare imprumut</td>
                                                                              <td class="creditReportCellHeaderSmall">Frecventa plati</td>
                                                                              <td class="creditReportCellHeaderSmall">Categoria de intarziere</td>
                                                                              <td class="creditReportCellHeaderSmall">Suma obligatiilor restante</td>
                                                                              <td class="creditReportCellHeaderSmall">Valoarea achitata</td>
                                                                              <td class="creditReportCellHeaderSmall">Valoarea programata</td>
                                                                              <td class="creditReportCellHeaderSmall">Data scadentei</td>
                                                                              <td class="creditReportCellHeaderSmall">Data primei restante</td>
                                                                              <td class="creditReportCellHeaderSmall" width="90%">Observatii</td>
                                                                           </tr>
                                                                           <xsl:for-each select="account_history/update">
                                                                              <tr>
                                                                                 <td class="creditReportCellDataSmall" align="center">
                                                                                    <xsl:value-of select="processed_on" />
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall" align="center">
                                                                                    <xsl:value-of select="last_updated_on" />
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall" align="center">
                                                                                    <xsl:value-of select="document_currency/@code" />
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall" align="right">
                                                                                    <xsl:call-template name="currencyFormat">
                                                                                       <xsl:with-param name="value">
                                                                                          <xsl:value-of select="credit_limit" />
                                                                                       </xsl:with-param>
                                                                                    </xsl:call-template>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall" align="right">
                                                                                    <xsl:call-template name="currencyFormat">
                                                                                       <xsl:with-param name="value">
                                                                                          <xsl:value-of select="initial_value" />
                                                                                       </xsl:with-param>
                                                                                    </xsl:call-template>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall" align="center">
                                                                                    <xsl:value-of select="terms_frequency" />
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall" align="center">
                                                                                    <xsl:value-of select="payment_rating" />
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall" align="right">
                                                                                    <xsl:call-template name="currencyFormat">
                                                                                       <xsl:with-param name="value">
                                                                                          <xsl:value-of select="amount_past_due" />
                                                                                       </xsl:with-param>
                                                                                    </xsl:call-template>
                                                                                 </td>
                                                                                 <td align="right" class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                    <xsl:call-template name="currencyFormat">
                                                                                       <xsl:with-param name="value">
                                                                                          <xsl:value-of select="actual_payment_amt" />
                                                                                       </xsl:with-param>
                                                                                    </xsl:call-template>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall" align="right">
                                                                                    <xsl:call-template name="currencyFormat">
                                                                                       <xsl:with-param name="value">
                                                                                          <xsl:value-of select="monthly_payment_amt" />
                                                                                       </xsl:with-param>
                                                                                    </xsl:call-template>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall" align="center">
                                                                                    <xsl:value-of select="billing_date" />
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall" align="center">
                                                                                    <xsl:value-of select="first_delinquency_date" />
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:value-of select="comments" />
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                              </tr>
                                                                           </xsl:for-each>
                                                                           <xsl:if test="count(account_history/update)&lt;3">
                                                                              <tr>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                              </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="count(account_history/update)&lt;2">
                                                                              <tr>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                              </tr>
                                                                           </xsl:if>
                                                                           <xsl:if test="count(account_history/update)&lt;1">
                                                                              <tr>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                 </td>
                                                                              </tr>
                                                                           </xsl:if>
                                                                        </table>
                                                                     </td>
                                                                  </tr>
                                                               </xsl:for-each>
                                                               <tr>
                                                                  <td>
                                                                     <div style="page-break-after:always">
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </div>
                                                                  </td>
                                                               </tr>
                                                               <tr>
                                                                  <td align="center" />
                                                               </tr>
                                                               <tr>
                                                                  <td align="center" />
                                                               </tr>
                                                            </xsl:if>
                                                            <tr>
                                                               <td align="center" />
                                                            </tr>
                                                            <!-- End If Rezultat Gasit-->
                                                         </xsl:if>
                                                      </xsl:if>
                                                      <!-- END of ACCOUNTS_DETAILS section -->
                                                      <!-- START of ACTIVE_APPEALS section -->
                                                      <xsl:if test="string(cr_request/extras_active_appeals)='true'">
                                                         <!-- Informatii cu privire la contestatii ale subiectul istoriei de credit -->
                                                         <tr>
                                                            <td align="center">
                                                               <b>
                                                                  Informatii cu privire la contestatiile active ale IDNO/IDNP:
                                                                  <xsl:value-of select="cr_request/idno_idnp" />
                                                               </b>
                                                            </td>
                                                         </tr>
                                                         <tr>
                                                            <td>
                                                               <table width="100%" border="0" cellpadding="2" cellspacing="0" style="border: 1px outset #000000">
                                                                  <tr>
                                                                     <th class="creditReportCellHeaderSmall" align="center">Numar de inregistrare</th>
                                                                     <th class="creditReportCellHeaderSmall" align="center">Data de inregistrare</th>
                                                                     <th class="creditReportCellHeaderSmall" align="center">Sursa de formare</th>
                                                                     <th class="creditReportCellHeaderSmall" align="center">Numar document</th>
                                                                     <th class="creditReportCellHeaderSmall" align="center">Detalii</th>
                                                                     <th class="creditReportCellHeaderSmall" align="center">
                                                                        Data ultimei
                                                                        <br />
                                                                        actualizari
                                                                     </th>
                                                                  </tr>
                                                                  <xsl:for-each select="debates/debate">
                                                                     <tr>
                                                                        <td class="creditReportCellDataSmall" align="center">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <xsl:value-of select="debate_number" />
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall" align="center">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <xsl:value-of select="debate_date" />
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall" align="center">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <xsl:value-of select="participant" />
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall" align="center">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <xsl:value-of select="document_number" />
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall" align="center">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <xsl:value-of select="comments" />
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall" align="center">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           <xsl:value-of select="last_updated_on" />
                                                                        </td>
                                                                     </tr>
                                                                  </xsl:for-each>
                                                                  <xsl:if test="count(debates/debate)&lt;1">
                                                                     <tr>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                     </tr>
                                                                  </xsl:if>
                                                                  <xsl:if test="count(debates/debate)&lt;2">
                                                                     <tr>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                     </tr>
                                                                  </xsl:if>
                                                                  <xsl:if test="count(debates/debate)&lt;3">
                                                                     <tr>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                     </tr>
                                                                  </xsl:if>
                                                               </table>
                                                            </td>
                                                         </tr>
                                                         <tr>
                                                            <td align="center">
                                                               <b>
                                                                  <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                               </b>
                                                            </td>
                                                         </tr>
                                                         <!-- End of Informatii cu privire la contestatii ale subiectul istoriei de credit -->
                                                      </xsl:if>
                                                      <!-- END of ACTIVE_APPEALS section -->
                                                      <!-- START of CREDIT_INQUIRIES section -->
                                                      <xsl:if test="string(cr_request/extras_credit_inquiries)='true'">
                                                         <!-- Informatii cu privire la solicitarile de credit efectuate de subiectul istoriei de credit -->
                                                         <tr>
                                                            <td align="center">
                                                               <b>
                                                                  Informatii cu privire la solicitarile de credit efectuate de IDNO/IDNP:
                                                                  <xsl:value-of select="cr_request/idno_idnp" />
                                                               </b>
                                                            </td>
                                                         </tr>
                                                         <tr>
                                                            <td>
                                                               <table width="100%" border="0" cellpadding="2" cellspacing="0" style="border: 1px outset #000000">
                                                                  <tr>
                                                                     <th class="creditReportCellHeaderSmall" align="center">Data inscrierii</th>
                                                                     <th class="creditReportCellHeaderSmall" align="center">Sursa de formare</th>
                                                                     <th class="creditReportCellHeaderSmall" align="center">
                                                                        Numar
                                                                        <br />
                                                                        document solicitare
                                                                     </th>
                                                                     <th class="creditReportCellHeaderSmall" align="center">Data solicitare</th>
                                                                     <th class="creditReportCellHeaderSmall" align="center">
                                                                        Acord
                                                                        <br />
                                                                        semnat
                                                                     </th>
                                                                     <th class="creditReportCellHeaderSmall" align="center">Tip portofoliu</th>
                                                                     <th class="creditReportCellHeaderSmall" align="center" width="65">Suma solicitata</th>
                                                                     <th class="creditReportCellHeaderSmall" align="center">Valuta</th>
                                                                     <th class="creditReportCellHeaderSmall" align="center">Durata credit</th>
                                                                     <th class="creditReportCellHeaderSmall" align="center">Frecventa plati</th>
                                                                     <th class="creditReportCellHeaderSmall" align="center">Asigurare rambursare</th>
                                                                     <th class="creditReportCellHeaderSmall" align="center">
                                                                        Valoare
                                                                        <br />
                                                                        asigurare rambursare
                                                                     </th>
                                                                  </tr>
                                                                  <xsl:for-each select="credit_applications/credit_application">
                                                                     <tr>
                                                                        <td class="creditReportCellDataSmall" align="center">
                                                                           <xsl:value-of select="processed_on" />
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall wrapped" align="center">
                                                                           <xsl:value-of select="participant" />
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:value-of select="document_number" />
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall" align="center">
                                                                           <xsl:value-of select="document_date" />
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall" align="center">
                                                                           <xsl:value-of select="process_indicator" />
                                                                        </td>
                                                                        <xsl:if test="process_indicator/@code='1'">
                                                                           <td class="creditReportCellDataSmall wrapped" align="center">
                                                                              <xsl:value-of select="document_type" />
                                                                           </td>
                                                                           <!-- initial_value -->
                                                                           <td class="creditReportCellDataSmall" align="right">
                                                                              <xsl:call-template name="currencyFormat">
                                                                                 <xsl:with-param name="value">
                                                                                    <xsl:value-of select="initial_value" />
                                                                                 </xsl:with-param>
                                                                              </xsl:call-template>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="center">
                                                                              <xsl:value-of select="document_currency/@code" />
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="center">
                                                                              <xsl:value-of select="terms_duration" />
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="center">
                                                                              <xsl:value-of select="terms_frequency" />
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="center">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                              <xsl:value-of select="document_insurance" />
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall" align="right">
                                                                              <xsl:call-template name="currencyFormat">
                                                                                 <xsl:with-param name="value">
                                                                                    <xsl:value-of select="document_insurance_value" />
                                                                                 </xsl:with-param>
                                                                              </xsl:call-template>
                                                                           </td>
                                                                        </xsl:if>
                                                                        <xsl:if test="process_indicator/@code='0'">
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                           <td class="creditReportCellDataSmall">
                                                                              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                           </td>
                                                                        </xsl:if>
                                                                     </tr>
                                                                  </xsl:for-each>
                                                                  <xsl:if test="count(credit_applications/credit_application)&lt;1">
                                                                     <tr>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                     </tr>
                                                                  </xsl:if>
                                                                  <xsl:if test="count(credit_applications/credit_application)&lt;2">
                                                                     <tr>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                     </tr>
                                                                  </xsl:if>
                                                                  <xsl:if test="count(credit_applications/credit_application)&lt;3">
                                                                     <tr>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        </td>
                                                                     </tr>
                                                                  </xsl:if>
                                                               </table>
                                                            </td>
                                                         </tr>
                                                         <!-- End of Informatii cu privire la solicitarile de credit efectuate de subiectul istoriei de credit -->
                                                      </xsl:if>
                                                      <!-- END of CREDIT_INQUIRIES section -->
                                                      <!-- START of CREDIT_RAPORT_STATEMENTS section -->
                                                      <xsl:if test="string(cr_request/extras_credit_raport_statements)='true'">
                                                         <xsl:if test="string($situatiaInscrierii)='true'">
                                                            <!-- START Situatia eliberarii de Rapoarte -->
                                                            <tr>
                                                               <td align="center">
                                                                  <table border="0" align="center">
                                                                     <tr>
                                                                        <td class="creditReportHeadBlack">
                                                                           Situatia eliberarii de Rapoarte de Credit vizand IDNO/IDNP:
                                                                           <xsl:value-of select="cr_request/idno_idnp" />
                                                                        </td>
                                                                     </tr>
                                                                     <tr>
                                                                        <td align="center">
                                                                           <table border="0" width="100%" cellpadding="2" cellspacing="0" style="border: 1px outset #000000">
                                                                              <tr>
                                                                                 <td width="100" align="center" valign="center" class="creditReportCellHeaderSmall" rowspan="2">Data si ora</td>
                                                                                 <td width="240" align="center" class="creditReportCellHeaderSmall" colspan="2">Utilizatorul istoriei de credit</td>
                                                                                 <td width="250" align="center" valign="center" class="creditReportCellHeaderSmall" rowspan="2">Scopul declarat de utilizatorul istoriei de credit la cererea R.C.</td>
                                                                              </tr>
                                                                              <tr>
                                                                                 <td width="90" align="center" class="creditReportCellHeaderSmall">Cod utilizator al istoriei de credit</td>
                                                                                 <td width="150" align="center" class="creditReportCellHeaderSmall">Denumire utilizator al istoriei de credit</td>
                                                                              </tr>
                                                                              <xsl:for-each select="credit_report_inquiries/credit_report_inquiry">
                                                                                 <tr>
                                                                                    <td align="center" class="creditReportCellDataSmall">
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                       <xsl:value-of select="date" />
                                                                                    </td>
                                                                                    <td align="center" class="creditReportCellDataSmall">
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                       <xsl:value-of select="participant/@code" />
                                                                                    </td>
                                                                                    <td nowrap="false" width="150" align="center" class="creditReportCellDataSmall">
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                       <xsl:value-of select="participant" />
                                                                                    </td>
                                                                                    <td class="creditReportCellDataSmall">
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                       <xsl:value-of select="inquiry_purpose" />
                                                                                    </td>
                                                                                 </tr>
                                                                              </xsl:for-each>
                                                                              <xsl:if test="count(credit_report_inquiries/credit_report_inquiry)&lt;1">
                                                                                 <tr>
                                                                                    <td class="creditReportCellDataSmall">
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                    </td>
                                                                                    <td class="creditReportCellDataSmall">
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                    </td>
                                                                                    <td class="creditReportCellDataSmall">
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                    </td>
                                                                                    <td class="creditReportCellDataSmall">
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                    </td>
                                                                                 </tr>
                                                                              </xsl:if>
                                                                              <xsl:if test="count(credit_report_inquiries/credit_report_inquiry)&lt;2">
                                                                                 <tr>
                                                                                    <td class="creditReportCellDataSmall">
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                    </td>
                                                                                    <td class="creditReportCellDataSmall">
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                    </td>
                                                                                    <td class="creditReportCellDataSmall">
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                    </td>
                                                                                    <td class="creditReportCellDataSmall">
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                    </td>
                                                                                 </tr>
                                                                              </xsl:if>
                                                                              <xsl:if test="count(credit_report_inquiries/credit_report_inquiry)&lt;3">
                                                                                 <tr>
                                                                                    <td class="creditReportCellDataSmall">
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                    </td>
                                                                                    <td class="creditReportCellDataSmall">
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                    </td>
                                                                                    <td class="creditReportCellDataSmall">
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                    </td>
                                                                                    <td class="creditReportCellDataSmall">
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                    </td>
                                                                                 </tr>
                                                                              </xsl:if>
                                                                           </table>
                                                                        </td>
                                                                     </tr>
                                                                  </table>
                                                               </td>
                                                            </tr>
                                                            <xsl:if test="count(credit_report_inquiries/credit_report_inquiry)&gt;4">
                                                               <tr>
                                                                  <td>
                                                                     <div style="page-break-after:always">
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </div>
                                                                  </td>
                                                               </tr>
                                                            </xsl:if>
                                                         </xsl:if>
                                                         <!-- END Situatia eliberarii de Rapoarte -->
                                                      </xsl:if>
                                                      <!-- END of CREDIT_INQUIRIES section -->
                                                      <xsl:if test="count(accounts_details/account_details)&gt;0">
                                                         <tr>
                                                            <td>
                                                               <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                            </td>
                                                         </tr>
                                                         <tr>
                                                            <td>
                                                               <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                            </td>
                                                         </tr>
                                                         <tr>
                                                            <td align="center">
                                                               <table border="0" class="tableType1">
                                                                  <tr>
                                                                     <td width="28" />
                                                                     <td />
                                                                  </tr>
                                                                  <tr>
                                                                     <td class="creditReportHeadBlack" colspan="2">
                                                                        <font size="2">Legenda:</font>
                                                                     </td>
                                                                     <td />
                                                                  </tr>
                                                                  <tr>
                                                                     <td width="28">
                                                                        <img border="0" width="28" height="28">
                                                                           <xsl:attribute name="src">
                                                                              <xsl:call-template name="resource">
                                                                                 <xsl:with-param name="source">B.gif</xsl:with-param>
                                                                                 <xsl:with-param name="forEmail">
                                                                                    <xsl:value-of select="$forEmail" />
                                                                                 </xsl:with-param>
                                                                              </xsl:call-template>
                                                                           </xsl:attribute>
                                                                        </img>
                                                                     </td>
                                                                     <td>Nu exista informatie</td>
                                                                     <td width="20%">
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </td>
                                                                     <td>
                                                                        <img border="0" width="28" height="28">
                                                                           <xsl:attribute name="src">
                                                                              <xsl:call-template name="resource">
                                                                                 <xsl:with-param name="source">rating01.gif</xsl:with-param>
                                                                                 <xsl:with-param name="forEmail">
                                                                                    <xsl:value-of select="$forEmail" />
                                                                                 </xsl:with-param>
                                                                              </xsl:call-template>
                                                                           </xsl:attribute>
                                                                        </img>
                                                                     </td>
                                                                     <td>Categorie +31 zile</td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td width="28">
                                                                        <img border="0" width="28" height="28">
                                                                           <xsl:attribute name="src">
                                                                              <xsl:call-template name="resource">
                                                                                 <xsl:with-param name="source">D.gif</xsl:with-param>
                                                                                 <xsl:with-param name="forEmail">
                                                                                    <xsl:value-of select="$forEmail" />
                                                                                 </xsl:with-param>
                                                                              </xsl:call-template>
                                                                           </xsl:attribute>
                                                                        </img>
                                                                     </td>
                                                                     <td>Nu exista nici un istoric de plata in aceasta luna.</td>
                                                                     <td width="20%">
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </td>
                                                                     <td>
                                                                        <img border="0" width="28" height="28">
                                                                           <xsl:attribute name="src">
                                                                              <xsl:call-template name="resource">
                                                                                 <xsl:with-param name="source">rating02.gif</xsl:with-param>
                                                                                 <xsl:with-param name="forEmail">
                                                                                    <xsl:value-of select="$forEmail" />
                                                                                 </xsl:with-param>
                                                                              </xsl:call-template>
                                                                           </xsl:attribute>
                                                                        </img>
                                                                     </td>
                                                                     <td>Categorie +61 zile</td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td>
                                                                        <img border="0" width="28" height="28">
                                                                           <xsl:attribute name="src">
                                                                              <xsl:call-template name="resource">
                                                                                 <xsl:with-param name="source">E.gif</xsl:with-param>
                                                                                 <xsl:with-param name="forEmail">
                                                                                    <xsl:value-of select="$forEmail" />
                                                                                 </xsl:with-param>
                                                                              </xsl:call-template>
                                                                           </xsl:attribute>
                                                                        </img>
                                                                     </td>
                                                                     <td>Cont curent si sold zero</td>
                                                                     <td width="20%">
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </td>
                                                                     <td>
                                                                        <img border="0" width="28" height="28">
                                                                           <xsl:attribute name="src">
                                                                              <xsl:call-template name="resource">
                                                                                 <xsl:with-param name="source">rating03.gif</xsl:with-param>
                                                                                 <xsl:with-param name="forEmail">
                                                                                    <xsl:value-of select="$forEmail" />
                                                                                 </xsl:with-param>
                                                                              </xsl:call-template>
                                                                           </xsl:attribute>
                                                                        </img>
                                                                     </td>
                                                                     <td>Categorie +91 zile</td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td>
                                                                        <img border="0" width="28" height="28">
                                                                           <xsl:attribute name="src">
                                                                              <xsl:call-template name="resource">
                                                                                 <xsl:with-param name="source">H.gif</xsl:with-param>
                                                                                 <xsl:with-param name="forEmail">
                                                                                    <xsl:value-of select="$forEmail" />
                                                                                 </xsl:with-param>
                                                                              </xsl:call-template>
                                                                           </xsl:attribute>
                                                                        </img>
                                                                     </td>
                                                                     <td>Plata in avans</td>
                                                                     <td width="20%">
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </td>
                                                                     <td>
                                                                        <img border="0" width="28" height="28">
                                                                           <xsl:attribute name="src">
                                                                              <xsl:call-template name="resource">
                                                                                 <xsl:with-param name="source">rating04.gif</xsl:with-param>
                                                                                 <xsl:with-param name="forEmail">
                                                                                    <xsl:value-of select="$forEmail" />
                                                                                 </xsl:with-param>
                                                                              </xsl:call-template>
                                                                           </xsl:attribute>
                                                                        </img>
                                                                     </td>
                                                                     <td>
                                                                        Categorie +121
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        zile
                                                                     </td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td>
                                                                        <img border="0" width="28" height="28">
                                                                           <xsl:attribute name="src">
                                                                              <xsl:call-template name="resource">
                                                                                 <xsl:with-param name="source">J.gif</xsl:with-param>
                                                                                 <xsl:with-param name="forEmail">
                                                                                    <xsl:value-of select="$forEmail" />
                                                                                 </xsl:with-param>
                                                                              </xsl:call-template>
                                                                           </xsl:attribute>
                                                                        </img>
                                                                     </td>
                                                                     <td>Renuntarea voluntara la asigurare/gaj</td>
                                                                     <td width="20%">
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </td>
                                                                     <td>
                                                                        <img border="0" width="28" height="28">
                                                                           <xsl:attribute name="src">
                                                                              <xsl:call-template name="resource">
                                                                                 <xsl:with-param name="source">rating05.gif</xsl:with-param>
                                                                                 <xsl:with-param name="forEmail">
                                                                                    <xsl:value-of select="$forEmail" />
                                                                                 </xsl:with-param>
                                                                              </xsl:call-template>
                                                                           </xsl:attribute>
                                                                        </img>
                                                                     </td>
                                                                     <td>
                                                                        Categorie +151
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                        zile
                                                                     </td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td>
                                                                        <img border="0" width="28" height="28">
                                                                           <xsl:attribute name="src">
                                                                              <xsl:call-template name="resource">
                                                                                 <xsl:with-param name="source">K.gif</xsl:with-param>
                                                                                 <xsl:with-param name="forEmail">
                                                                                    <xsl:value-of select="$forEmail" />
                                                                                 </xsl:with-param>
                                                                              </xsl:call-template>
                                                                           </xsl:attribute>
                                                                        </img>
                                                                     </td>
                                                                     <td>Reintrare in posesie a bunului</td>
                                                                     <td width="20%">
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </td>
                                                                     <td>
                                                                        <img border="0" width="28" height="28">
                                                                           <xsl:attribute name="src">
                                                                              <xsl:call-template name="resource">
                                                                                 <xsl:with-param name="source">rating06.gif</xsl:with-param>
                                                                                 <xsl:with-param name="forEmail">
                                                                                    <xsl:value-of select="$forEmail" />
                                                                                 </xsl:with-param>
                                                                              </xsl:call-template>
                                                                           </xsl:attribute>
                                                                        </img>
                                                                     </td>
                                                                     <td>Categorie +181 zile</td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td>
                                                                        <img border="0" width="28" height="28">
                                                                           <xsl:attribute name="src">
                                                                              <xsl:call-template name="resource">
                                                                                 <xsl:with-param name="source">rating00.gif</xsl:with-param>
                                                                                 <xsl:with-param name="forEmail">
                                                                                    <xsl:value-of select="$forEmail" />
                                                                                 </xsl:with-param>
                                                                              </xsl:call-template>
                                                                           </xsl:attribute>
                                                                        </img>
                                                                     </td>
                                                                     <td>Fara intarziere</td>
                                                                     <td width="20%">
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </td>
                                                                     <td>
                                                                        <img border="0" width="28" height="28">
                                                                           <xsl:attribute name="src">
                                                                              <xsl:call-template name="resource">
                                                                                 <xsl:with-param name="source">G.gif</xsl:with-param>
                                                                                 <xsl:with-param name="forEmail">
                                                                                    <xsl:value-of select="$forEmail" />
                                                                                 </xsl:with-param>
                                                                              </xsl:call-template>
                                                                           </xsl:attribute>
                                                                        </img>
                                                                     </td>
                                                                     <td>Cont dat la colectare</td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td>
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </td>
                                                                     <td>
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </td>
                                                                     <td>
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </td>
                                                                     <td>
                                                                        <img border="0" width="28" height="28">
                                                                           <xsl:attribute name="src">
                                                                              <xsl:call-template name="resource">
                                                                                 <xsl:with-param name="source">L.gif</xsl:with-param>
                                                                                 <xsl:with-param name="forEmail">
                                                                                    <xsl:value-of select="$forEmail" />
                                                                                 </xsl:with-param>
                                                                              </xsl:call-template>
                                                                           </xsl:attribute>
                                                                        </img>
                                                                     </td>
                                                                     <td>Extrabilantier</td>
                                                                  </tr>
                                                               </table>
                                                            </td>
                                                         </tr>
                                                      </xsl:if>
                                                      <tr>
                                                         <td align="center" />
                                                      </tr>
                                                      <!-- PD REPORT -->
                                                      <xsl:if test="/root/pd_report">
                                                         <tr>
                                                            <td align="center">
                                                               <br />
                                                            </td>
                                                         </tr>
                                                         <tr>
                                                            <td align="center" class="creditReportHeadBlack">
                                                               <h4>Indicatori de predictie</h4>
                                                            </td>
                                                         </tr>
                                                         <tr>
                                                            <td align="center">
                                                                        <table width="60%" border="0" cellpadding="2" cellspacing="0" style="border: 1px outset #000000">
                                                                            <tbody><tr>
                                                                            <th class="creditReportCellHeaderSmall" align="center">Indicator</th>
                                                                                <th class="creditReportCellHeaderSmall" align="center">Probabilitatea</th>
                                                                            </tr>
                                                                            <tr>
                                                                                <td class="creditReportCellDataSmall">Intrarea in 30-60 zile intirziere</td>
                                                                                <td class="creditReportCellDataSmall centered"><xsl:value-of select="/root/pd_report/pd_d30/prediction1" /> %</td>
                                                                            </tr><tr>
                                                                                <td class="creditReportCellDataSmall">Intrarea in 60-90 zile intirziere</td>
                                                                                <td class="creditReportCellDataSmall centered"><xsl:value-of select="/root/pd_report/pd_d60/prediction1" /> %</td>
                                                                            </tr><tr>
                                                                                <td class="creditReportCellDataSmall">Transmiterea la colectare</td>
                                                                                <td class="creditReportCellDataSmall centered"><xsl:value-of select="/root/pd_report/pd_col/prediction1" /> %</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td class="creditReportCellDataSmall">Credit compromis (extrabilantier)</td>
                                                                                <td class="creditReportCellDataSmall centered"><xsl:value-of select="/root/pd_report/pd_exb/prediction1" /> %</td>
                                                                            </tr>
                                                                        </tbody></table>
                                                                    <tr>
                                                                         <td align="center" />
                                                                    </tr>
                                                                 </td>
                                                          </tr>
                                                      </xsl:if>
                                                      <!-- / PD REPORT -->
                                                      <!-- FISC REPORT -->
                                                      <xsl:if test="/root/fisc_report">
                                                         <tr>
                                                            <td align="center">
                                                               <br />
                                                            </td>
                                                         </tr>
                                                         <tr>
                                                            <td align="center" class="creditReportHeadBlack">
                                                               <h4>Informatiile privind veniturile si datoriile la bugetul public national</h4>
                                                            </td>
                                                         </tr>
                                                         <tr>
                                                            <td align="center">
                                                               <b>Date generale</b>
                                                            </td>
                                                         </tr>
                                                         <tr>
                                                            <td align="center">
                                                               <table border="0" style="border: 1px solid #000000;" class="tableType1">
                                                                  <tr>
                                                                     <td style="width: 200px !important; text-align: right;">
                                                                        <b>IDNP/IDNO</b>
                                                                     </td>
                                                                     <td>
                                                                        <xsl:value-of select="/root/fisc_report/customer/idnx" />
                                                                     </td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td style="width: 200px !important; text-align: right;">
                                                                        <b>Tip persoana</b>
                                                                     </td>
                                                                     <td>
                                                                        <xsl:value-of select="/root/fisc_report/customer/type_taxpayer" />
                                                                     </td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td style="width: 200px !important; text-align: right;">
                                                                        <b>Nume Prenume</b>
                                                                     </td>
                                                                     <td>
                                                                        <xsl:value-of select="/root/fisc_report/customer/full_name" />
                                                                     </td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td style="width: 200px !important; text-align: right;">
                                                                        <b>
                                                                           Restante in contul curent
                                                                           <br />
                                                                           al contribuabulului
                                                                        </b>
                                                                     </td>
                                                                     <td>
                                                                        <xsl:if test="/root/fisc_report/customer/num_rest=0">Lipsa</xsl:if>
                                                                        <xsl:if test="/root/fisc_report/customer/num_rest>0"><xsl:value-of select="/root/fisc_report/customer/num_rest" /></xsl:if>
                                                                     </td>
                                                                  </tr>
                                                               </table>
                                                            </td>
                                                         </tr>
                                                         <xsl:if test="/root/fisc_report/customer/type_taxpayer='Persoana fizica'">
                                                            <xsl:if test="/root/fisc_report/reports">
                                                               <xsl:for-each select="/root/fisc_report/reports/report">
                                                                  <xsl:sort select="year" data-type="number"/>
                                                                  <xsl:variable name="fisc_report_year" select="year" />
                                                                  <tr>
                                                                     <td align="center" class="creditReportHeadBlack">
                                                                        <br />
                                                                        INFORMATII PENTRU ANUL
                                                                        <xsl:value-of select="year" />
                                                                     </td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td align="center">
                                                                        <b>Sursa de venit</b>
                                                                        <table border="0" style="border: 1px solid #000000;" class="tableType1">
                                                                           <tr>
                                                                              <td class="creditReportCellHeaderSmall">CUATM</td>
                                                                              <td class="creditReportCellHeaderSmall">IDNO</td>
                                                                              <td class="creditReportCellHeaderSmall">DENUMIREA</td>
                                                                           </tr>
                                                                           <xsl:for-each select="organisations/organisation">
                                                                              <tr>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:value-of select="cuatm" />
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:value-of select="idno" />
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall" style="width: 50%">
                                                                                    <xsl:value-of select="name" />
                                                                                 </td>
                                                                              </tr>
                                                                           </xsl:for-each>
                                                                        </table>
                                                                        <br />
                                                                        <b>Venituri inregistrate</b>
                                                                        <table border="0" style="border: 1px solid #000000;" class="tableType1">
                                                                           <tr>
                                                                              <td class="creditReportCellHeaderSmall">Sursa</td>
                                                                              <td class="creditReportCellHeaderSmall">Perioada</td>
                                                                              <td class="creditReportCellHeaderSmall">Suma</td>
                                                                           </tr>
                                                                           <xsl:for-each select="incomes/income">
                                                                              <xsl:sort select="month" data-type="number"/>
                                                                              <tr>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:value-of select="sursa" />
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall">
                                                                                    <xsl:if test="month='0'">
                                                                                       Anul
                                                                                       <xsl:value-of select="$fisc_report_year" />
                                                                                    </xsl:if>
                                                                                    <xsl:if test="month &gt; 0">
                                                                                       <xsl:if test="month='1'">Ianuarie </xsl:if>
                                                                                       <xsl:if test="month='2'">Februarie </xsl:if>
                                                                                       <xsl:if test="month='3'">Martie </xsl:if>
                                                                                       <xsl:if test="month='4'">Aprilie </xsl:if>
                                                                                       <xsl:if test="month='5'">Mai </xsl:if>
                                                                                       <xsl:if test="month='6'">Iunie </xsl:if>
                                                                                       <xsl:if test="month='7'">Iulie </xsl:if>
                                                                                       <xsl:if test="month='8'">August </xsl:if>
                                                                                       <xsl:if test="month='9'">Septembrie </xsl:if>
                                                                                       <xsl:if test="month='10'">Octombrie </xsl:if>
                                                                                       <xsl:if test="month='11'">Noiembrie </xsl:if>
                                                                                       <xsl:if test="month='12'">Decembrie </xsl:if>
                                                                                       <xsl:value-of select="$fisc_report_year" />
                                                                                    </xsl:if>
                                                                                 </td>
                                                                                 <td class="creditReportCellDataSmall" style="width: 50%">
                                                                                    <xsl:value-of select="amount" />
                                                                                 </td>
                                                                              </tr>
                                                                           </xsl:for-each>
                                                                        </table>
                                                                     </td>
                                                                  </tr>
                                                               </xsl:for-each>
                                                            </xsl:if>
                                                         </xsl:if>
                                                                  <tr>
                                                                  <td>
                                                                  <br/>
                                                                  <table class="table legend">
                                                                      <tr><th colspan="2">Legenda</th></tr>
                                                                      <tr><td colspan="2"><i>Codurile surselor de venit</i></td></tr>
                                                                      <tr><td>
                                                                          <table>
                                                                              <tr><th>ALT</th><td>alte venituri;</td></tr>
                                                                              <tr><th>ALTB</th><td>alte plăți efectuate în folosul nerezidentului;</td></tr>
                                                                              <tr><th>DIVA</th><td>veniturile din care se efectuează reținerea finală a impozitului;</td></tr>
                                                                              <tr><th>DIVB</th><td>veniturile nerezidentului, art. 91 din CF.;</td></tr>
                                                                              <tr><th>DOB</th><td>dobânzi, art.89 din Codul fiscal;</td></tr>
                                                                              <tr><th>DOBA</th><td>dobânzi persoane fizice rezidente cu excepția II și GT, art.89;</td></tr>
                                                                              <tr><th>DOBB</th><td>royalty (redevente) și dobânzi, art. 89 din CF;</td></tr>
                                                                              <tr><th>FOL</th><td>venit. din care se efectuează reținerea finală a impozitului;</td></tr>
                                                                              <tr><th>FOND</th><td>veniturile contribuabilului întreprinzător individual (cu excepția GT);</td></tr>
                                                                              <tr><th>FONDG</th><td>veniturile contribuabilului întreprinzător individual (GT);</td></tr>
                                                                              <tr><th>LIV</th><td>plățile în folosul persoanei fizice din fitotehnie și horticultură;</td></tr>
                                                                              <tr><th>NEDA</th><td>venit din care se efectuează reținerea finală a impozitului;</td></tr>
                                                                              <tr><th>NEDB</th><td>plățile persoanei nerezidente a căror sumă nu e deductibilă;</td></tr>
                                                                          </table>
                                                                      </td><td>
                                                                          <table>
                                                                              <tr><th>NOR</th><td>veniturile din care se efectuează reținerea finală a impozitului;</td></tr>
                                                                              <tr><th>PLT</th><td>plățile nerezidentului de la art. 71;</td></tr>
                                                                              <tr><th>PUB</th><td>veniturile din care se efectuează reținerea finală a impozitului;</td></tr>
                                                                              <tr><th>RCSA</th><td>suma retrasă din capitalul social;</td></tr>
                                                                              <tr><th>RCSB</th><td>suma retrasă din capitalul social al nerezidentului;</td></tr>
                                                                              <tr><th>ROY</th><td>royalty achitate în folosul persoanelor fizice;</td></tr>
                                                                              <tr><th>ROYA</th><td>royalty (redevente) și dobânzi, art. 89 din CF.;</td></tr>
                                                                              <tr><th>ROYB</th><td>veniturile nerezidentului, art. 91 din CF.;</td></tr>
                                                                              <tr><th>SAL</th><td>plăți salariale, art. 88 din CF;</td></tr>
                                                                              <tr><th>SALA</th><td>plăți salariale, art. 24 alin.(21) din Legea nr.1164-XIII;</td></tr>
                                                                              <tr><th>SER</th><td>veniturile din care se reține impozit, art. 90 din CF.;</td></tr>
                                                                              <tr><th>SERB</th><td>veniturile din care se reține impozit, art. 90 din CF. </td></tr>
                                                                          </table>
                                                                      </td></tr>
                                                                  </table>
                                                                  </td>
                                                                  </tr>
                                                      </xsl:if>
                                                      <!-- ./FISC REPORT -->
                                                      <tr>
                                                         <td align="center" />
                                                      </tr>
                                                      <!-- BNS REPORT-->
                                                      <xsl:if test="/root/bns_report">
                                                      <xsl:if test="string(/root/bns_report/code)!=''">
                                                         <tr>
                                                            <td align="center">
                                                               <br />
                                                            </td>
                                                         </tr>
                                                         <tr>
                                                            <td align="center" class="creditReportHeadBlack">
                                                               <h4>Informatiile privind Situatiile Financiare</h4>
                                                            </td>
                                                         </tr>
                                                         <tr>
                                                            <td align="center">
                                                               <table border="0" cellpadding="0" cellspacing="0" align="center" width="100%">
                                                                  <tr>
                                                                     <td>
                                                                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                     </td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td valign="middle" align="center">
                                                                        <font color="red" size="3"> <xsl:value-of select="/root/bns_report/message" /></font>
                                                                     </td>
                                                                  </tr>
                                                               </table>
                                                            </td>
                                                         </tr>
                                                      </xsl:if>
                                                      <xsl:if test="string(/root/bns_report/code)=''">
                                                         <tr>
                                                            <td align="center">
                                                               <br />
                                                            </td>
                                                         </tr>
                                                         <tr>
                                                            <td align="center" class="creditReportHeadBlack">
                                                               <h4>Informatiile privind Situatiile Financiare</h4>
                                                            </td>
                                                         </tr>
                                                         <tr>
                                                            <td class="creditReportHeadBlack" align="center" />
                                                         </tr>
                                                         <tr>
                                                            <td>
                                                               <table border="0" width="80%" align="center" class="bnsreport">
                                                                  <tr>
                                                                     <td style="width: 50%; text-align: center;" />
                                                                     <td style="width: 50%; text-align: right;">
                                                                        Anexe  la SNC
                                                                        <br />
                                                                        “Prezentarea situatiilor financiare”
                                                                        <br />
                                                                        Aprobat de Ministerul Finantelor
                                                                        <br />
                                                                        al Republicii Moldova
                                                                     </td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td colspan="2" style="text-align: center;">
                                                                        <b>Date generale</b>
                                                                        <br />
                                                                        pentru perioada
                                                                        <u>
                                                                           an
                                                                           <xsl:value-of select="/root/bns_report/customer/year" />
                                                                        </u>
                                                                     </td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td class="td-8">
                                                                        Entitatea:
                                                                        <b>
                                                                           <xsl:value-of select="/root/bns_report/customer/company_name" />
                                                                        </b>
                                                                     </td>
                                                                     <td class="td-4 centered">
                                                                        <fld>
                                                                           <xsl:value-of select="/root/bns_report/customer/idno" />
                                                                        </fld>
                                                                        <small>Cod IDNO</small>
                                                                     </td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td class="td-8">
                                                                        Sediul:
                                                                        <b>
                                                                           <xsl:value-of select="/root/bns_report/customer/address" />
                                                                        </b>
                                                                     </td>
                                                                     <td class="td-4 centered">
                                                                        <fld>
                                                                           <xsl:value-of select="/root/bns_report/customer/region_code" />
                                                                        </fld>
                                                                        <small>Cod CUATM</small>
                                                                     </td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td class="td-8">
                                                                        Activitatea principala:
                                                                        <b>
                                                                           <xsl:value-of select="/root/bns_report/customer/caem2_description" />
                                                                        </b>
                                                                     </td>
                                                                     <td class="td-4 centered">
                                                                        <fld>
                                                                           <xsl:value-of select="/root/bns_report/customer/caem2_code" />
                                                                        </fld>
                                                                        <small>Cod CAEM, rev.2</small>
                                                                     </td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td class="td-8">
                                                                        Forma de proprietate:
                                                                        <b>
                                                                           <xsl:value-of select="/root/bns_report/customer/cpf_description" />
                                                                        </b>
                                                                     </td>
                                                                     <td class="td-4 centered">
                                                                        <fld>
                                                                           <xsl:value-of select="/root/bns_report/customer/cpf_code" />
                                                                        </fld>
                                                                        <small>Cod CFP</small>
                                                                     </td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td class="td-8">
                                                                        Forma organizatorico-juridica:
                                                                        <b>
                                                                           <xsl:value-of select="/root/bns_report/customer/cofj_description" />
                                                                        </b>
                                                                     </td>
                                                                     <td class="td-4 centered">
                                                                        <fld>
                                                                           <xsl:value-of select="/root/bns_report/customer/cofj_code" />
                                                                        </fld>
                                                                        <small>Cod CFOJ</small>
                                                                     </td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td class="td-8">
                                                                        Date de contact: tel:
                                                                        <u>
                                                                           <xsl:value-of select="/root/bns_report/customer/phone1" />
                                                                           ,
                                                                           <xsl:value-of select="/root/bns_report/customer/phone2" />
                                                                        </u>
                                                                     </td>
                                                                     <td class="td-4 centered">Unitatea de masura: mii lei</td>
                                                                  </tr>
                                                                  <tr>
                                                                     <td class="td-8">
                                                                        Conducator:
                                                                        <b>
                                                                           <xsl:value-of select="/root/bns_report/customer/director" />
                                                                        </b>
                                                                     </td>
                                                                     <td class="td-4 centered" />
                                                                  </tr>
                                                                  <tr>
                                                                     <td class="td-8">
                                                                        Salariati:
                                                                        <b>
                                                                           <xsl:value-of select="/root/bns_report/customer/personal" />
                                                                        </b>
                                                                     </td>
                                                                     <td class="td-4 centered" />
                                                                  </tr>
                                                               </table>
                                                            </td>
                                                         </tr>
                                                         <tr>
                                                            <td colspan="2" class="row-separator" />
                                                         </tr>
                                                         <xsl:if test="/root/bns_report/app8">
                                                            <tr>
                                                               <td valign="top" align="right">
                                                                  <span class="pull-right">Anexa 8</span>
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                               <td valign="top" class="creditReportHeadBlack" align="center">Nota informativa privind veniturile şi cheltuielile clasificate dupa natura</td>
                                                            </tr>
                                                            <tr>
                                                               <td align="center">
                                                                  <!-- Anexa 8 -->
                                                                  <table width="100%" border="0" cellpadding="2" class="creditReportTable" cellspacing="0" style="border: 1px outset #000000">
                                                                     <tr>
                                                                        <th rowspan="2" class="creditReportCellHeaderSmall" align="center">Indicatori</th>
                                                                        <th rowspan="2" class="creditReportCellHeaderSmall" align="center">Cod rd.</th>
                                                                        <th colspan="2" class="creditReportCellHeaderSmall" align="center">Perioada de gestiune</th>
                                                                     </tr>
                                                                     <tr>
                                                                        <th class="creditReportCellHeaderSmall" align="center">precedenta</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">curenta</th>
                                                                     </tr>
                                                                     <tr>
                                                                        <th class="creditReportCellHeaderSmall" align="center">1</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">2</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">3</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">4</th>
                                                                     </tr>
                                                                     <xsl:for-each select="/root/bns_report/app8/row">
                                                                        <xsl:if test="nrow='10'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" width="50%">Venituri din vinzari</td>
                                                                              <td class="creditReportCellDataSmall" align="center">010</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='20'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" width="50%">Alte venituri din activitatea operationala</td>
                                                                              <td class="creditReportCellDataSmall" align="center">020</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='30'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" width="50%">Venituri din alte activitati</td>
                                                                              <td class="creditReportCellDataSmall" align="center">030</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='40'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" width="50%">
                                                                                 <b>Total venituri</b>
                                                                                 (rd.010 + rd.020 + rd.030)
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">040</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='50'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" width="50%">Variatia stocurilor</td>
                                                                              <td class="creditReportCellDataSmall" align="center">050</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='60'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" width="50%">Costul vinzarilor marfurilor vindute</td>
                                                                              <td class="creditReportCellDataSmall" align="center">060</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='70'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" width="50%">Cheltuieli privind stocurile</td>
                                                                              <td class="creditReportCellDataSmall" align="center">070</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='80'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" width="50%">Cheltuieli cu personalul privind remunerarea muncii</td>
                                                                              <td class="creditReportCellDataSmall" align="center">080</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='90'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" width="50%">Contributii de asigurari sociale de stat obligatorii şi prime de asigurare obligatorie de asistenta medicala</td>
                                                                              <td class="creditReportCellDataSmall" align="center">090</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='100'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" width="50%">Cheltuieli cu amortizarea şi deprecierea activelor imobilizate</td>
                                                                              <td class="creditReportCellDataSmall" align="center">100</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='110'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" width="50%">Alte cheltuieli</td>
                                                                              <td class="creditReportCellDataSmall" align="center">110</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='120'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" width="50%">Cheltuieli din alte activitati</td>
                                                                              <td class="creditReportCellDataSmall" align="center">120</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='130'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" width="50%">
                                                                                 <b>Total cheltuieli</b>
                                                                                 (rd.050 + rd.060 + rd.070 + rd.080 + rd.090 + rd.100 + rd.110 + rd.120)
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">130</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='140'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" width="50%">Profit (pierdere) pina la impozitare (rd.040 – rd.130)</td>
                                                                              <td class="creditReportCellDataSmall" align="center">140</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='150'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" width="50%">Cheltuieli privind impozitul pe venit</td>
                                                                              <td class="creditReportCellDataSmall" align="center">150</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='160'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" width="50%">Profit (pierdere) net al perioadei de gestiune (rd.140 – rd.150)</td>
                                                                              <td class="creditReportCellDataSmall" align="center">160</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                     </xsl:for-each>
                                                                  </table>
                                                                  <!-- Anexa 8 -->
                                                               </td>
                                                            </tr>
                                                         </xsl:if>
                                                         <xsl:if test="/root/bns_report/app1">
                                                            <tr>
                                                               <td class="row-separator" />
                                                            </tr>
                                                            <tr>
                                                               <td valign="top" align="right">
                                                                  <span class="pull-right">Anexa 1</span>
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                               <td valign="top" class="creditReportHeadBlack" align="center">
                                                                  BILANTUL
                                                                  <br />
                                                                  la
                                                                  <u>
                                                                     an
                                                                     <xsl:value-of select="/root/bns_report/customer/year" />
                                                                  </u>
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                               <td valign="top">
                                                                  <!-- Anexa 1-->
                                                                  <table width="100%" border="0" cellpadding="2" class="creditReportTable" cellspacing="0" style="border: 1px outset #000000">
                                                                     <tr>
                                                                        <th rowspan="2" class="creditReportCellHeaderSmall" align="center">Nr. cpt.</th>
                                                                        <th rowspan="2" class="creditReportCellHeaderSmall" align="center">A C T I V</th>
                                                                        <th rowspan="2" class="creditReportCellHeaderSmall" width="10%" align="center">Cod rd.</th>
                                                                        <th colspan="2" class="creditReportCellHeaderSmall" align="center">Sold la</th>
                                                                     </tr>
                                                                     <tr>
                                                                        <th class="creditReportCellHeaderSmall" align="center">Inceputul perioadei de gestiune</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">Sfirşitul perioadei de gestiune</th>
                                                                     </tr>
                                                                     <tr>
                                                                        <th class="creditReportCellHeaderSmall" align="center">1</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">2</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">3</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">4</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">5</th>
                                                                     </tr>
                                                                     <tr>
                                                                        <td class="creditReportCellDataSmall" rowspan="14">1.</td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <b>Active imobilizate</b>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                     </tr>
                                                                     <xsl:for-each select="/root/bns_report/app1/row">
                                                                        <xsl:if test="nrow='10'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Imobilizari necorporale</td>
                                                                              <td class="creditReportCellDataSmall" align="center">010</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='20'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Imobilizari corporale in curs de executie</td>
                                                                              <td class="creditReportCellDataSmall" align="center">020</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='30'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Terenuri</td>
                                                                              <td class="creditReportCellDataSmall" align="center">030</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='40'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Mijloace fixe</td>
                                                                              <td class="creditReportCellDataSmall" align="center">040</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='50'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Resurse minerale</td>
                                                                              <td class="creditReportCellDataSmall" align="center">050</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='60'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Active biologice imobilizate</td>
                                                                              <td class="creditReportCellDataSmall" align="center">060</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='70'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Investitii financiare pe termen lung in parti neafiliate</td>
                                                                              <td class="creditReportCellDataSmall" align="center">070</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='80'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Investitii financiare pe termen lung in parti afiliate</td>
                                                                              <td class="creditReportCellDataSmall" align="center">080</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='90'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Investitii imobiliare</td>
                                                                              <td class="creditReportCellDataSmall" align="center">090</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='100'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Creante pe termen lung</td>
                                                                              <td class="creditReportCellDataSmall" align="center">100</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='110'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Avansuri acordate pe termen lung</td>
                                                                              <td class="creditReportCellDataSmall" align="center">110</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='120'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Alte active imobilizate</td>
                                                                              <td class="creditReportCellDataSmall" align="center">120</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='130'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">
                                                                                 <b>Total active imobilizate</b>
                                                                                 <br />
                                                                                 (rd.010 + rd.020 + rd.030 + rd.040 + rd.050 + rd.060 + rd.070 + rd.080 + rd.090 + rd.100 + rd.110 + rd.120)
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">130</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                     </xsl:for-each>
                                                                     <tr>
                                                                        <td class="creditReportCellDataSmall" rowspan="19">2.</td>
                                                                        <td class="creditReportCellDataSmall">Active circulante</td>
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                     </tr>
                                                                     <xsl:for-each select="/root/bns_report/app1/row">
                                                                        <xsl:if test="nrow='140'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Materiale</td>
                                                                              <td class="creditReportCellDataSmall" align="center">140</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='150'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Active biologice circulante</td>
                                                                              <td class="creditReportCellDataSmall" align="center">150</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='160'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Obiecte de mica valoare si scurta durata</td>
                                                                              <td class="creditReportCellDataSmall" align="center">160</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='170'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Productia in curs de executie si produse</td>
                                                                              <td class="creditReportCellDataSmall" align="center">170</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='180'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Marfuri</td>
                                                                              <td class="creditReportCellDataSmall" align="center">180</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='190'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Creante comerciale</td>
                                                                              <td class="creditReportCellDataSmall" align="center">190</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='200'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Creante ale partilor afiliate</td>
                                                                              <td class="creditReportCellDataSmall" align="center">200</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='210'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Avansuri acordate curente</td>
                                                                              <td class="creditReportCellDataSmall" align="center">210</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='220'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Creante ale bugetului</td>
                                                                              <td class="creditReportCellDataSmall" align="center">220</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='230'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Creante ale personalului</td>
                                                                              <td class="creditReportCellDataSmall" align="center">230</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='240'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Alte creante curente</td>
                                                                              <td class="creditReportCellDataSmall" align="center">240</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='250'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Numerar in casierie si la conturi curente</td>
                                                                              <td class="creditReportCellDataSmall" align="center">250</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='260'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Alte elemente de numerar</td>
                                                                              <td class="creditReportCellDataSmall" align="center">260</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='270'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Investitii financiare curente in parti neafiliate</td>
                                                                              <td class="creditReportCellDataSmall" align="center">270</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='280'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Investitii financiare curente in parti afiliate</td>
                                                                              <td class="creditReportCellDataSmall" align="center">280</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='290'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Alte active circulante</td>
                                                                              <td class="creditReportCellDataSmall" align="center">290</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='300'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">
                                                                                 <b>Total active circulante</b>
                                                                                 <br />
                                                                                 (rd.140 + rd.150 + rd.160 + rd.170 + rd.180 + rd.190 + rd.200 + rd.210 + rd.220 + rd.230 + rd.240 + rd.250<br/> + rd.260 + rd.270 + rd.280 + rd.290)
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">300</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='310'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">
                                                                                 <b>Total active</b>
                                                                                 <br />
                                                                                 (rd.130 + rd.300)
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">310</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                     </xsl:for-each>
                                                                  </table>
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                               <td colspan="2" class="row-separator" />
                                                            </tr>
                                                            <tr>
                                                               <td valign="top">
                                                                  <table width="100%" border="0" cellpadding="2" class="creditReportTable" cellspacing="0" style="border: 1px outset #000000">
                                                                     <tr>
                                                                        <th rowspan="2" class="creditReportCellHeaderSmall" align="center">Nr. cpt.</th>
                                                                        <th rowspan="2" class="creditReportCellHeaderSmall" align="center">P A S I V</th>
                                                                        <th rowspan="2" class="creditReportCellHeaderSmall" width="10%" align="center">Cod rd.</th>
                                                                        <th colspan="2" class="creditReportCellHeaderSmall" align="center">Sold la</th>
                                                                     </tr>
                                                                     <tr>
                                                                        <th class="creditReportCellHeaderSmall" align="center">Inceputul perioadei de gestiune</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">Sfirsitul perioadei de gestiune</th>
                                                                     </tr>
                                                                     <tr>
                                                                        <th class="creditReportCellHeaderSmall" align="center">1</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">2</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">3</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">4</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">5</th>
                                                                     </tr>
                                                                     <tr>
                                                                        <td class="creditReportCellDataSmall" rowspan="9">3.</td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <b>Capital propriu</b>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                     </tr>
                                                                     <xsl:for-each select="/root/bns_report/app1/row">
                                                                        <xsl:if test="nrow='320'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Capital social si suplimentar</td>
                                                                              <td class="creditReportCellDataSmall" align="center">320</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='330'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Rezerve</td>
                                                                              <td class="creditReportCellDataSmall" align="center">330</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='340'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Corectii ale rezultatelor anilor precedenti</td>
                                                                              <td class="creditReportCellDataSmall" align="center">340</td>
                                                                              <td class="creditReportCellDataSmall" align="center">x</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='350'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Profit nerepartizat (pierdere neacoperita) al anilor precedenti</td>
                                                                              <td class="creditReportCellDataSmall" align="center">350</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='360'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Profit net (pierdere neta) al perioadei de gestiune</td>
                                                                              <td class="creditReportCellDataSmall" align="center">360</td>
                                                                              <td class="creditReportCellDataSmall" align="center">x</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='370'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Profit utilizat al perioadei de gestiune</td>
                                                                              <td class="creditReportCellDataSmall" align="center">370</td>
                                                                              <td class="creditReportCellDataSmall" align="center">x</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='380'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Alte elemente de capital propriu</td>
                                                                              <td class="creditReportCellDataSmall" align="center">380</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='390'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">
                                                                                 Total capital propriu
                                                                                 <br />
                                                                                 (rd.320 + rd.330 + rd.340 + rd.350 + rd.360 - rd.370 + rd.380)
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">390</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                     </xsl:for-each>
                                                                     <tr>
                                                                        <td class="creditReportCellDataSmall" rowspan="6">4.</td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <b>Datorii pe termen lung</b>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                     </tr>
                                                                     <xsl:for-each select="/root/bns_report/app1/row">
                                                                        <xsl:if test="nrow='400'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Credite bancare pe termen lung</td>
                                                                              <td class="creditReportCellDataSmall" align="center">400</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='410'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Imprumuturi pe termen lung</td>
                                                                              <td class="creditReportCellDataSmall" align="center">410</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='420'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Datorii pe termen lung privind leasingul financiar</td>
                                                                              <td class="creditReportCellDataSmall" align="center">420</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='430'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Alte datorii pe termen lung</td>
                                                                              <td class="creditReportCellDataSmall" align="center">430</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='440'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">
                                                                                 <b>Total datorii pe termen lung</b>
                                                                                 <br />
                                                                                 (rd.400 + rd.410 + rd.420 + rd.430)
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">440</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                     </xsl:for-each>
                                                                     <tr>
                                                                        <td class="creditReportCellDataSmall" rowspan="16">5.</td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <b>Datorii curente</b>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                     </tr>
                                                                     <xsl:for-each select="/root/bns_report/app1/row">
                                                                        <xsl:if test="nrow='450'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Credite bancare pe termen scurt</td>
                                                                              <td class="creditReportCellDataSmall" align="center">450</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='460'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Imprumuturi pe termen scurt</td>
                                                                              <td class="creditReportCellDataSmall" align="center">460</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='470'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Datorii comerciale</td>
                                                                              <td class="creditReportCellDataSmall" align="center">470</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='480'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Datorii fata de partile afiliate</td>
                                                                              <td class="creditReportCellDataSmall" align="center">480</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='490'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Avansuri primite curente</td>
                                                                              <td class="creditReportCellDataSmall" align="center">490</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='500'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Datorii fata de personal</td>
                                                                              <td class="creditReportCellDataSmall" align="center">500</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='510'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Datorii privind asigurarile sociale şi medicale</td>
                                                                              <td class="creditReportCellDataSmall" align="center">510</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='520'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Datorii fata de buget</td>
                                                                              <td class="creditReportCellDataSmall" align="center">520</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='530'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Venituri anticipate curente</td>
                                                                              <td class="creditReportCellDataSmall" align="center">530</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='540'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Datorii fata de proprietari</td>
                                                                              <td class="creditReportCellDataSmall" align="center">540</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='550'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Finantari şi incasari cu destinatie speciala curente</td>
                                                                              <td class="creditReportCellDataSmall" align="center">550</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='560'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Provizioane curente</td>
                                                                              <td class="creditReportCellDataSmall" align="center">560</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='570'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Alte datorii curente</td>
                                                                              <td class="creditReportCellDataSmall" align="center">570</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='580'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">
                                                                                 <b>Total datorii curente</b>
                                                                                 <br />
                                                                                 (rd.450 + rd.460 + rd.470 + rd.480 + rd.490 + rd.500 + rd.510 + rd.520 +  rd.530 + rd.540 + rd.550 + rd.560<br/> + rd.570)
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">580</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='590'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">
                                                                                 <b>Total pasive</b>
                                                                                 <br />
                                                                                 (rd.390 + rd.440 + rd.580)
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">590</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                     </xsl:for-each>
                                                                  </table>
                                                                  <!-- Anexa 1 -->
                                                               </td>
                                                            </tr>
                                                         </xsl:if>
                                                         <xsl:if test="/root/bns_report/app2">
                                                            <tr>
                                                               <td class="row-separator" />
                                                            </tr>
                                                            <tr>
                                                               <td valign="top" align="right">
                                                                  <span class="pull-right">Anexa 2</span>
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                               <td class="creditReportHeadBlack" align="center">
                                                                  SITUATIA DE PROFIT ŞI PIERDERE
                                                                  <br />
                                                                  de la
                                                                  <u>ianuarie</u>
                                                                  pina la
                                                                  <u>decembrie</u>
                                                                  <xsl:value-of select="/root/bns_report/customer/year" />
                                                                  <!-- Anexa 2 -->
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                               <td align="center">
                                                                  <table width="100%" border="0" cellpadding="2" class="creditReportTable" cellspacing="0" style="border: 1px outset #000000">
                                                                     <tr>
                                                                        <th rowspan="2" class="creditReportCellHeaderSmall" align="center">Indicatori</th>
                                                                        <th rowspan="2" class="creditReportCellHeaderSmall" align="center">Cod rd.</th>
                                                                        <th colspan="2" class="creditReportCellHeaderSmall" align="center">Perioada de gestiune</th>
                                                                     </tr>
                                                                     <tr>
                                                                        <th class="creditReportCellHeaderSmall" align="center">precedenta</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">curenta</th>
                                                                     </tr>
                                                                     <tr>
                                                                        <th class="creditReportCellHeaderSmall" align="center">1</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">2</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">3</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">4</th>
                                                                     </tr>
                                                                     <xsl:for-each select="/root/bns_report/app2/row">
                                                                        <xsl:if test="nrow='10'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Venituri din vinzari</td>
                                                                              <td class="creditReportCellDataSmall" align="center">010</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='20'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Costul vinzarilor</td>
                                                                              <td class="creditReportCellDataSmall" align="center">020</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='30'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Profit brut (pierdere bruta)  (rd.010 – rd.020)</td>
                                                                              <td class="creditReportCellDataSmall" align="center">030</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='40'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Alte venituri din activitatea operationala</td>
                                                                              <td class="creditReportCellDataSmall" align="center">040</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='50'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Cheltuieli de distribuire</td>
                                                                              <td class="creditReportCellDataSmall" align="center">050</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='60'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Cheltuieli administrative</td>
                                                                              <td class="creditReportCellDataSmall" align="center">060</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='70'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Alte cheltuieli din activitatea operationala</td>
                                                                              <td class="creditReportCellDataSmall" align="center">070</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='80'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Rezultatul din activitatea operationala: profit (pier-dere) (rd.030 + rd.040 – rd.050 – rd.060 – rd.070)</td>
                                                                              <td class="creditReportCellDataSmall" align="center">080</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='90'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Rezultatul din alte activitati: profit (pierdere)</td>
                                                                              <td class="creditReportCellDataSmall" align="center">090</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='100'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">
                                                                                 Profit (pierdere) pina la impozitare
                                                                                 <br />
                                                                                 (rd.080 + rd.090)
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">100</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='110'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Cheltuieli privind impozitul pe venit</td>
                                                                              <td class="creditReportCellDataSmall" align="center">110</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='120'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">
                                                                                 Profit net (pierdere neta) al perioadei de gestiune
                                                                                 <br />
                                                                                 (rd.100 – rd.110)
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">120</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                     </xsl:for-each>
                                                                  </table>
                                                                  <!-- Anexa 2 -->
                                                               </td>
                                                            </tr>
                                                         </xsl:if>
                                                         <xsl:if test="/root/bns_report/app3">
                                                            <tr>
                                                               <td class="row-separator" />
                                                            </tr>
                                                            <tr>
                                                               <td valign="top" align="right">Anexa 3</td>
                                                            </tr>
                                                            <tr>
                                                               <td class="creditReportHeadBlack" align="center">
                                                                  SITUATIA MODIFICARILOR CAPITALULUI PROPRIU
                                                                  <br />
                                                                  de la
                                                                  <u>ianuarie</u>
                                                                  pina la
                                                                  <u>decembrie</u>
                                                                  <xsl:value-of select="/root/bns_report/customer/year" />
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                               <td align="center">
                                                                  <table width="100%" border="0" cellpadding="2" class="creditReportTable" cellspacing="0" style="border: 1px outset #000000">
                                                                     <tr>
                                                                        <th class="creditReportCellHeaderSmall" align="center">Nr. d/o</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">Indicatori</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">Cod rd.</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">Sold la inceputul perioadei  de gestiune</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">Majorari</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">Diminuari</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">Sold la sfirşitul perioadei de gestiune</th>
                                                                     </tr>
                                                                     <tr>
                                                                        <th class="creditReportCellHeaderSmall" align="center">1</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">2</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">3</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">4</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">5</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">6</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">7</th>
                                                                     </tr>
                                                                     <tr>
                                                                        <td class="creditReportCellDataSmall" rowspan="7">1</td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <b>Capital social şi suplimentar</b>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                     </tr>
                                                                     <xsl:for-each select="/root/bns_report/app3/row">
                                                                        <xsl:if test="nrow='10'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Capital social</td>
                                                                              <td class="creditReportCellDataSmall" align="center">010</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='20'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Capital suplimentar</td>
                                                                              <td class="creditReportCellDataSmall" align="center">020</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='30'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Capital nevarsat</td>
                                                                              <td class="creditReportCellDataSmall" align="center">030</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='40'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Capital neinregistrat</td>
                                                                              <td class="creditReportCellDataSmall" align="center">040</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='50'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Capital retras</td>
                                                                              <td class="creditReportCellDataSmall" align="center">050</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='60'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">
                                                                                 <b>Total capital social şi suplimentar</b>
                                                                                 <br />
                                                                                 (rd.010 + rd.020 + rd.030 + rd.040 + rd.050)
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">060</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                     </xsl:for-each>
                                                                     <tr>
                                                                        <td class="creditReportCellDataSmall" rowspan="5">2</td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <b>Rezerve</b>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                     </tr>
                                                                     <xsl:for-each select="/root/bns_report/app3/row">
                                                                        <xsl:if test="nrow='70'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Capital de rezerva</td>
                                                                              <td class="creditReportCellDataSmall" align="center">070</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='80'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Rezerve statutare</td>
                                                                              <td class="creditReportCellDataSmall" align="center">080</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='90'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Alte rezerve</td>
                                                                              <td class="creditReportCellDataSmall" align="center">090</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='100'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">
                                                                                 <b>Total reserve</b>
                                                                                 (rd.070 + rd.080 + rd.090)
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">100</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                     </xsl:for-each>
                                                                     <tr>
                                                                        <td class="creditReportCellDataSmall" rowspan="7">3</td>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <b>Profit nerepartizat (pierdere neacoperita)</b>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                     </tr>
                                                                     <xsl:for-each select="/root/bns_report/app3/row">
                                                                        <xsl:if test="nrow='110'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Corectii ale rezultatelor anilor precedenti</td>
                                                                              <td class="creditReportCellDataSmall" align="center">110</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='120'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Profit nerepartizat (pierdere neacoperita) al anilor precedenti</td>
                                                                              <td class="creditReportCellDataSmall" align="center">120</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='130'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Profit net (pierdere neta) al perioadei de gestiune</td>
                                                                              <td class="creditReportCellDataSmall" align="center">130</td>
                                                                              <td class="creditReportCellDataSmall" align="center">x</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='140'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Profit utilizat al perioadei de gestiune</td>
                                                                              <td class="creditReportCellDataSmall" align="center">140</td>
                                                                              <td class="creditReportCellDataSmall" align="center">x</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='150'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Rezultatul din tranzitia la noile reglementari contabile</td>
                                                                              <td class="creditReportCellDataSmall" align="center">150</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='160'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">
                                                                                 <b>Total profit nerepartizat (pierdere neacoperita)</b>
                                                                                 (rd.110 + rd.120 + rd.130 + rd.140 + rd.150)
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">160</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                     </xsl:for-each>
                                                                     <xsl:for-each select="/root/bns_report/app3/row">
                                                                        <xsl:if test="nrow='170'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" rowspan="4">4</td>
                                                                              <td class="creditReportCellDataSmall">
                                                                                 <b>Alte elemente de capital propriu, din care</b>
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">170</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='171'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Diferente din reevaluare</td>
                                                                              <td class="creditReportCellDataSmall" align="center">171</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='172'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Subventii entitatilor cu proprietate publica</td>
                                                                              <td class="creditReportCellDataSmall" align="center">172</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='180'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">
                                                                                 <b>Total capital propriu</b>
                                                                                 (rd.060 + rd.100 + rd.160 + rd.170)
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">180</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                     </xsl:for-each>
                                                                  </table>
                                                                  <!-- Anexa 3 -->
                                                               </td>
                                                            </tr>
                                                         </xsl:if>
                                                         <xsl:if test="/root/bns_report/app4">
                                                            <tr>
                                                               <td class="row-separator" />
                                                            </tr>
                                                            <!-- Anexa 4 -->
                                                            <tr>
                                                               <td valign="top" align="right">Anexa 4</td>
                                                            </tr>
                                                            <tr>
                                                               <td class="creditReportHeadBlack" align="center">
                                                                  SITUATIA FLUXURILOR DE NUMERAR
                                                                  <br />
                                                                  de la
                                                                  <u>ianuarie</u>
                                                                  pina la
                                                                  <u>decembrie</u>
                                                                  <xsl:value-of select="/root/bns_report/customer/year" />
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                               <td align="center">
                                                                  <table width="100%" border="0" cellpadding="2" class="creditReportTable" cellspacing="0" style="border: 1px outset #000000">
                                                                     <tr>
                                                                        <th rowspan="2" class="creditReportCellHeaderSmall" align="center">Indicatori</th>
                                                                        <th rowspan="2" class="creditReportCellHeaderSmall" align="center">Cod. rd.</th>
                                                                        <th colspan="2" class="creditReportCellHeaderSmall" align="center">Perioada de gestiune</th>
                                                                     </tr>
                                                                     <tr>
                                                                        <th class="creditReportCellHeaderSmall" align="center">precedenta</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">curenta</th>
                                                                     </tr>
                                                                     <tr>
                                                                        <th class="creditReportCellHeaderSmall" align="center">1</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">2</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">3</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">4</th>
                                                                     </tr>
                                                                     <tr>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <b>Fluxuri de numerar din activitatea operationala</b>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                     </tr>
                                                                     <xsl:for-each select="/root/bns_report/app4/row">
                                                                        <xsl:if test="nrow='10'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Incasari din vinzari</td>
                                                                              <td class="creditReportCellDataSmall" align="center">010</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='20'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Plati pentru stocuri şi servicii procurate</td>
                                                                              <td class="creditReportCellDataSmall" align="center">020</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='30'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Plati catre angajati şi organe de asigurare sociala şi medicala</td>
                                                                              <td class="creditReportCellDataSmall" align="center">030</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='40'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Dobinzi platite</td>
                                                                              <td class="creditReportCellDataSmall" align="center">040</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='50'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Plata impozitului pe venit</td>
                                                                              <td class="creditReportCellDataSmall" align="center">050</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='60'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Alte incasari</td>
                                                                              <td class="creditReportCellDataSmall" align="center">060</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='70'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Alte plati</td>
                                                                              <td class="creditReportCellDataSmall" align="center">070</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='80'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">
                                                                                 <b>Fluxul net de numerar din activitatea operationala</b>
                                                                                 (rd.010 – rd.020 – rd.030 – rd.040 – rd.050 + rd.060 – rd.070 )
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">080</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                     </xsl:for-each>
                                                                     <tr>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <b>Fluxuri de numerar din activitatea de investitii</b>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                     </tr>
                                                                     <xsl:for-each select="/root/bns_report/app4/row">
                                                                        <xsl:if test="nrow='90'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Incasari din vinzarea activelor imobilizate</td>
                                                                              <td class="creditReportCellDataSmall" align="center">090</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='100'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Plati aferente intrarilor de active imobilizate</td>
                                                                              <td class="creditReportCellDataSmall" align="center">100</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='110'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Dobinzi incasate</td>
                                                                              <td class="creditReportCellDataSmall" align="center">110</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='120'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Dividende incasate</td>
                                                                              <td class="creditReportCellDataSmall" align="center">120</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='130'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Alte incasari (plati)</td>
                                                                              <td class="creditReportCellDataSmall" align="center">130</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='140'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">
                                                                                 <b>Fluxul net de numerar din activitatea de investitii</b>
                                                                                 (rd.090 – rd.100 + rd.110 + rd.120 ± rd.130)
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">140</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                     </xsl:for-each>
                                                                     <tr>
                                                                        <td class="creditReportCellDataSmall">
                                                                           <b>Fluxuri de numerar din activitatea financiara</b>
                                                                        </td>
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                        <td class="creditReportCellDataSmall" />
                                                                     </tr>
                                                                     <xsl:for-each select="/root/bns_report/app4/row">
                                                                        <xsl:if test="nrow='150'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Incasari sub forma de credite şi imprumuturi</td>
                                                                              <td class="creditReportCellDataSmall" align="center">150</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='160'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Plati aferente rambursarii creditelor şi imprumuturilor</td>
                                                                              <td class="creditReportCellDataSmall" align="center">160</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='170'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Dividende platite</td>
                                                                              <td class="creditReportCellDataSmall" align="center">170</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='180'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Incasari din operatiuni de capital</td>
                                                                              <td class="creditReportCellDataSmall" align="center">180</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='190'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Alte incasari (plati)</td>
                                                                              <td class="creditReportCellDataSmall" align="center">190</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='200'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">
                                                                                 <b>Fluxul net de numerar din activitatea financiara</b>
                                                                                 (rd.150 – rd.160 – rd.170 + rd.180 ± rd.190)
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">200</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='210'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">
                                                                                 <b>Fluxul net de numerar total</b>
                                                                                 <br />
                                                                                 (± rd.080 ± rd.140 ± rd.200)
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">210</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='220'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">Diferente de curs valutar favorabile (nefavorabile)</td>
                                                                              <td class="creditReportCellDataSmall" align="center">220</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='230'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">
                                                                                 <b>Sold de numerar la inceputul perioadei de gestiune</b>
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">230</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='240'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">
                                                                                 <b>Sold de numerar la sfirşitul perioadei de gestiune</b>
                                                                                 (± rd.210 ± rd.220 + rd.230)
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">240</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col1" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                     </xsl:for-each>
                                                                  </table>
                                                                  <!-- Anexa 4 -->
                                                               </td>
                                                            </tr>
                                                         </xsl:if>
                                                         <xsl:if test="/root/bns_report/app7">
                                                            <tr>
                                                               <td class="row-separator" />
                                                            </tr>
                                                            <!-- Anexa 7 -->
                                                            <tr>
                                                               <td valign="top" align="right">Anexa 7</td>
                                                            </tr>
                                                            <tr>
                                                               <td class="creditReportHeadBlack" align="center">
                                                                  INFORMATIILE PRIVIND ACTIVELE IMOBILIZATE
                                                                  <br />
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                               <td align="center">
                                                                  <table width="100%" border="0" cellpadding="2" class="creditReportTable" cellspacing="0" style="border: 1px outset #000000">
                                                                     <tr>
                                                                        <th class="creditReportCellHeaderSmall" align="center">Indicatori</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">Nr.rind</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">Existenta la  inceputul perioadei (la costul de intrare)</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">Amortizarea acumulata la  inceputul perioadei</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">Deprecierea acumulata la  inceputul perioadei</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">Intrarea in cursul perioadei (la costul de intrare)</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">Ieşirea in cursul perioadei (la costul de intrare)</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">Existenta la  sfirşitul perioadei (la costul de intrare)</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">Amortizarea acumulata la  sfirşitul perioadei</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">Deprecierea acumulata la  sfirşitul perioadei</th>
                                                                     </tr>
                                                                     <tr>
                                                                        <th class="creditReportCellHeaderSmall" align="center">A</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">1</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">2</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">3</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">4</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">5</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">6</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">7</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">8</th>
                                                                        <th class="creditReportCellHeaderSmall" align="center">9</th>
                                                                     </tr>
                                                                     <xsl:for-each select="/root/bns_report/app7/row">
                                                                        <xsl:if test="nrow='100'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" align="left">1.Imobilizari necorporale in curs de executie</td>
                                                                              <td class="creditReportCellDataSmall" align="center">100</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col8" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col9" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='200'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" align="left">2. Imobilizari necorporale in utilizare, total</td>
                                                                              <td class="creditReportCellDataSmall" align="center">200</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col8" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col9" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='210'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" style="padding-left: 15px">
                                                                                 inclusiv:
                                                                                 <br />
                                                                                 2.1. brevete şi marci
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">210</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col8" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col9" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='220'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" style="padding-left: 15px">2.2. licente de activitate</td>
                                                                              <td class="creditReportCellDataSmall" align="center">220</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col8" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col9" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='230'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" style="padding-left: 15px">2.3. programe informatice</td>
                                                                              <td class="creditReportCellDataSmall" align="center">230</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col8" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col9" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='300'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">3. Imobilizari corporale in curs de executie</td>
                                                                              <td class="creditReportCellDataSmall" align="center">300</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col8" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col9" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='400'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">4. Terenuri</td>
                                                                              <td class="creditReportCellDataSmall" align="center">400</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">x</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">x</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col9" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='500'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">5. Mijloace fixe, total</td>
                                                                              <td class="creditReportCellDataSmall" align="center">500</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col8" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col9" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='510'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" style="padding-left: 15px">
                                                                                 din care:
                                                                                 <br />
                                                                                 5.1. cladiri
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall" align="center">510</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col8" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col9" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='520'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" style="padding-left: 15px">5.2. constructii  speciale</td>
                                                                              <td class="creditReportCellDataSmall" align="center">520</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col8" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col9" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='530'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" style="padding-left: 15px">5.3. maşini, utilaje, instalatii de transmisie</td>
                                                                              <td class="creditReportCellDataSmall" align="center">530</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col8" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col9" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='531'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" style="padding-left: 35px">inclusiv: tehnica de calcul</td>
                                                                              <td class="creditReportCellDataSmall" align="center">531</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col8" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col9" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='540'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" style="padding-left: 15px">5.4. mijloace de transport</td>
                                                                              <td class="creditReportCellDataSmall" align="center">540</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col8" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col9" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='550'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" style="padding-left: 15px">5.5. instrumente şi inventar</td>
                                                                              <td class="creditReportCellDataSmall" align="center">550</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col8" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col9" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='560'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" style="padding-left: 15px">5.6. costuri ulterioare aferente obiectelor neinregistrate in bilant</td>
                                                                              <td class="creditReportCellDataSmall" align="center">560</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col8" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col9" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='570'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" style="padding-left: 15px">5.7. mijloace fixe primite in leasing financiar</td>
                                                                              <td class="creditReportCellDataSmall" align="center">570</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col8" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col9" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='580'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" style="padding-left: 15px">5.8. mijloace fixe primite in gestiune economica</td>
                                                                              <td class="creditReportCellDataSmall" align="center">580</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col8" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col9" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='590'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall" style="padding-left: 15px">5.9. alte mijloace fixe</td>
                                                                              <td class="creditReportCellDataSmall" align="center">590</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col8" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col9" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='600'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">6. Resurse minerale</td>
                                                                              <td class="creditReportCellDataSmall" align="center">600</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col8" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col9" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                        <xsl:if test="nrow='700'">
                                                                           <tr>
                                                                              <td class="creditReportCellDataSmall">7. Investitii imobiliare, total</td>
                                                                              <td class="creditReportCellDataSmall" align="center">700</td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col2" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col3" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col4" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col5" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col6" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col7" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col8" />
                                                                              </td>
                                                                              <td class="creditReportCellDataSmall text-right">
                                                                                 <xsl:value-of select="col9" />
                                                                              </td>
                                                                           </tr>
                                                                        </xsl:if>
                                                                     </xsl:for-each>
                                                                  </table>
                                                                  <!-- Anexa 7 -->
                                                               </td>
                                                            </tr>
                                                         </xsl:if>
                                                      </xsl:if>
                                                      </xsl:if>
                                                      <!-- ./BNS REPORT-->
                                                      <tr>
                                                         <td>
                                                            <table style="border: 2px solid #777777; background: #eee; margin-top: 10px;" align="center">
                                                               <tr>
                                                                  <td style="padding: 20px;">
                                                                      <i class="glyphicon glyphicon-info-sign" style="font-size: 35px;"></i>
                                                                  </td>
                                                                  <td>
                                                                     <xsl:if test="string($situatiaInscrierii)!='true'">
                                                                        <xsl:call-template name="RC_Copyright01" />
                                                                     </xsl:if>
                                                                     <xsl:if test="string($situatiaInscrierii)='true'">
                                                                        <xsl:call-template name="SI_Copyright01" />
                                                                     </xsl:if>
                                                                  </td>
                                                               </tr>
                                                            </table>
                                                         </td>
                                                      </tr>
                                                      <tr>
                                                         <td>
                                                         </td>
                                                      </tr>
                                                      <tr>
                                                         <td>
                                                            <table border="0" style="margin-top: 10px; border: none;" class="tableType1" align="center" cellpadding="0" cellspacing="0">
                                                               <tr>
                                                                  <td style="wi-dth: 49%" height="100%">
                                                                     <table style="border: 0px outset #000000" width="100%" height="100%">
                                                                        <tr>
                                                                           <td>
                                                                              <table border="0" width="100%" cellpadding="0" cellspacing="0" height="100%">
                                                                                 <tr>
                                                                                    <td>
                                                                                      <xsl:value-of select="//root/requestor_name" />
                                                                                    </td>
                                                                                    <td align="right">
                                                                                       <xsl:value-of select="inquiry_date/date" />
                                                                                    </td>
                                                                                 </tr>
                                                                                 <tr>
                                                                                    <td colspan="2">
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                    </td>
                                                                                 </tr>
                                                                                 <tr>
                                                                                    <td colspan="2">
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                    </td>
                                                                                 </tr>
                                                                                 <tr>
                                                                                    <td colspan="2">
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                    </td>
                                                                                 </tr>
                                                                                 <tr>
                                                                                    <td colspan="2">
                                                                                       <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                                                                    </td>
                                                                                 </tr>
                                                                                 <tr>
                                                                                    <td height="100%" valign="bottom">L.S.
                                                                                         _______________________</td>
                                                                                    <td align="right" valign="bottom">Stampila</td>
                                                                                 </tr>
                                                                              </table>
                                                                           </td>
                                                                        </tr>
                                                                     </table>
                                                                  </td>
                                                               </tr>
                                                               <xsl:if test="string($situatiaInscrierii)='true'">
                                                                  <tr style="height: 140px;" valign="bottom">
                                                                     <td>
                                                                        <p>
                                                                           Silviu Foca    ______________________
                                                                           <br />
                                                                           <br />
                                                                           <br />
                                                                           Director general
                                                                           <br />
                                                                           IM "Biroul de Credit" SRL
                                                                        </p>
                                                                     </td>
                                                                  </tr>
                                                               </xsl:if>
                                                            </table>
                                                         </td>
                                                      </tr>
                                                   </xsl:if>
                                                   <!-- error != '' -->
                                                </td>
                                             </tr>
                                          </table>
                                       </td>
                                    </tr>
                                    <xsl:if test="position()!=last()">
                                       <tr>
                                          <td>
                                             <div style="page-break-after:always">
                                                <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                             </div>
                                          </td>
                                       </tr>
                                    </xsl:if>
                                 </xsl:for-each>
                                 <!-- /root/credit_reports/credit_report -->
                                 <xsl:if test="count(/root/credit_reports/credit_report/cr_signature)">
                                    <!--ATENTIE : acest camp indica appletului ce functie sa apeleze pentru a permite utilizatorului sa faca validarea semnaturii digitale doar dupa ce appletul a fost initializat -->
                                    <input type="hidden" name="jsFunction" id="jsFunction" value="onAppletStart" />
                                    <xsl:element name="input">
                                       <xsl:attribute name="type">hidden</xsl:attribute>
                                       <xsl:attribute name="id">signatureNumber</xsl:attribute>
                                       <xsl:attribute name="value">
                                          <xsl:value-of select="count(/root/credit_reports/credit_report/cr_signature)" />
                                       </xsl:attribute>
                                    </xsl:element>
                                    <!--<applet codebase="../sivabon_md/APPLETS/" code="md.deeplace.xsig.applet.XAdESBESApplet"-->
                                    <!--archive="xadesbes.jar" width="0" height="0" MAYSCRIPT="true"/>-->
                                    <applet archive="../sivabon_md/APPLETS/xadesbes.jar" jnlp_href="../sivabon_md/APPLETS/xadesbes.jnlp" code="md.deeplace.xsig.applet.XAdESBESApplet" name="XMLSigningApplet" id="SignApplet" style="width:0; height: 0" mayscript="true">
                                       <param name="codebase_lookup" value="false" />
                                       <param name="allowCertSelect" value="true" />
                                       <param name="language" value="ro" />
                                    </applet>
                                 </xsl:if>
                              </form>
                           </table>
                        </td>
                     </tr>
                  </table>
               </xsl:if>
               <!-- error != '' -->
               <xsl:if test="contains(string(/root), 'SUCCESS')">
                  <table align="center">
                     <tr>
                        <td class="creditReportHeadBlack" align="center">
                           Cererea a fost inregistrata cu succes.
                           <BR />
                           Rezultatul va fi fie transmis prin email, fie salvat pe disc,
                           <BR />
                           in functie de specificatiile cererii si de cantitatea de date
                           <BR />
                           (In cazul in care este depasit un anumit numar de Rapoarte de Credit intr-o singura cerere
                           <BR />
                           atunci rezultatul va fi salvat automat pe disc).
                        </td>
                     </tr>
                  </table>
               </xsl:if>
               <script language="javascript">
                  function toggleDetails()
{
    document.all( "detailsTR" ).style.display = document.all( "detailsTR" ).style.display == "inline" ? "none" : "inline";
}
var _keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
// public method for decoding
function decode(input)
{
    var output = "";
    var chr1, chr2, chr3;
    var enc1, enc2, enc3, enc4;
    var i = 0;
    input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");
    while (i &lt; input.length)
    {
        enc1 = _keyStr.indexOf(input.charAt(i++));
        enc2 = _keyStr.indexOf(input.charAt(i++));
        enc3 = _keyStr.indexOf(input.charAt(i++));
        enc4 = _keyStr.indexOf(input.charAt(i++));
        chr1 = (enc1 &lt;&lt; 2) | (enc2 &gt;&gt; 4);
        chr2 = ((enc2 &amp; 15) &lt;&lt; 4) | (enc3 &gt;&gt; 2);
        chr3 = ((enc3 &amp; 3) &lt;&lt; 6) | enc4;
        output = output + String.fromCharCode(chr1);
        if (enc3 != 64)
        {
            output = output + String.fromCharCode(chr2);
        }
        if (enc4 != 64)
        {
            output = output + String.fromCharCode(chr3);
        }
    }
    output = _utf8_decode(output);
    return output;
}
// private method for UTF-8 decoding
function _utf8_decode(utftext)
{
    var string = "";
    var i = 0;
    var c = c1 = c2 = 0;
    while ( i &lt; utftext.length )
    {
        c = utftext.charCodeAt(i);
        if (c &lt; 128)
        {
            string += String.fromCharCode(c);
            i++;
        }
        else if((c &gt; 191) &amp;&amp; (c &lt; 224))
        {
            c2 = utftext.charCodeAt(i+1);
            string += String.fromCharCode(((c &amp; 31) &lt;&lt; 6) | (c2 &amp; 63));
            i += 2;
        }
        else
        {
            c2 = utftext.charCodeAt(i+1);
            c3 = utftext.charCodeAt(i+2);
            string += String.fromCharCode(((c &amp; 15) &lt;&lt; 12) | ((c2 &amp; 63) &lt;&lt; 6) | (c3 &amp; 63));
            i += 3;
        }
    }
    return string;
}
function validateDocument(signatureIndex)
{
    var validImage = document.getElementById( "valid" + signatureIndex );
    var invalidImage = document.getElementById( "invalid" + signatureIndex );
    var message = document.getElementById( "signatureValidationMessage" + signatureIndex );
    validImage.style.display = "none";
    invalidImage.style.display = "none";
    message.style.display = "";
    var signature = decode( document.getElementById( "cr_signature" + signatureIndex ).value );
    var initialCreditReport = decode( document.getElementById( "cr_initialCreditReport" + signatureIndex ).value );
    var isValid = ( document.applets[ 0 ].checkIntegrity( initialCreditReport, signature ) ) &amp;&amp; ( document.applets[ 0 ].verify( signature ) );
    if( isValid )
    {
        validImage.style.display = "";
        message.innerHTML = "Raportul de Credit a fost semnat cu o semnatura valida";
    }
    else
    {
        invalidImage.style.display = "";
        message.innerHTML = "Raportul de Credit nu a fost semnat cu o semnatura valida sau a fost alterat";
    }
}
                  <!--Daca RC a fost semnat, atunci utilizatorul va putea valida semnatura doar in momentul in-->
                  <!--care appletul este incarcat. Functia de mai jos este apelata in applet pentru a anunta utilizatorul ca appletul este-->
                  <!--incarcat, iar el poate valida semnatura digitala.    -->
                  function onAppletStart()
    {
        var total = document.getElementById('signatureNumber').value;
        for ( var i = 1; i &lt;= total; i++ )
        {
            document.getElementById('validationWaitingSpan'+i).style.display = "none";
            document.getElementById('validationReadySpan'+i).style.display = "";
            document.getElementById('validationReadyLink'+i).style.display = "";
        }
    }
               </script>
            </body>
         </html>
      </xsl:if>
   </xsl:template>
</xsl:stylesheet>
