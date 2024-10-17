<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xalan="http://xml.apache.org/xalan"
  xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
  exclude-result-prefixes="xsl xalan i18n"
>

  <xsl:param name="DefaultLang" />
  <xsl:param name="WebApplicationBaseURL" />
  <xsl:param name="ServletsBaseURL" />
  <xsl:param name="MCR.mir-module.MailSender" />
  <xsl:variable name="newline" select="'&#xA;'" />

  <xsl:template match="/">
    <email>
      <from><xsl:value-of select="$MCR.mir-module.MailSender" /></from>
      <xsl:apply-templates select="/*" mode="email" />
    </email>
  </xsl:template>

  <xsl:template match="user" mode="email">
    <to>
      <xsl:value-of select="eMail/text()" />
    </to>
    <subject>
      <xsl:value-of select="i18n:translate('oer.selfregistration.email.subject')" />: <xsl:value-of select="@name" />
    </subject>
    <body>
      <xsl:text>Sehr geehrte Dame, sehr geehrter Herr,</xsl:text><xsl:value-of select="$newline" />
      <xsl:value-of select="$newline" />
      <xsl:text>Ihre neue Benutzerkennung für das OER Repository wurde angelegt.</xsl:text><xsl:value-of select="$newline" />
      <xsl:value-of select="$newline" />
      <xsl:text>Bitte benutzen Sie folgenden Link, um Ihre E-Mail-Adresse zu bestätigen und die Registrierung abzuschließen:</xsl:text><xsl:value-of select="$newline" />
      <xsl:value-of
        select="concat($ServletsBaseURL, 'MirSelfRegistrationServlet?action=verify&amp;user=', @name, '&amp;realm=', @realm, '&amp;token=', attributes/attribute[@name='mailtoken']/@value)" />
      <xsl:value-of select="$newline" />
      <xsl:value-of select="$newline" />
      <xsl:text>OER Repository, WiNoDa Knowledge Lab</xsl:text><xsl:value-of select="$newline" />
      <xsl:value-of select="$newline" />
      <xsl:value-of select="$WebApplicationBaseURL" />
    </body>
  </xsl:template>
</xsl:stylesheet>
