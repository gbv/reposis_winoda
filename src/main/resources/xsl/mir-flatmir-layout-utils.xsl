<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
    xmlns:mcrver="xalan://org.mycore.common.MCRCoreVersion"
    xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions"
    exclude-result-prefixes="i18n mcrver mcrxsl">

  <xsl:import href="resource:xsl/layout/mir-common-layout.xsl" />

  <xsl:template name="mir.navigation">

    <div class="container">
      <nav class="mir-prop-nav">
        <ul class="nav navbar-nav navbar-expand">
          <xsl:call-template name="mir.loginMenu" />
          <xsl:call-template name="mir.languageMenu" />
        </ul>
      </nav>
    </div>

    <div class="container">
      <div class="header_box">

        <div id="project_logo_box" class="project_logo_box">
          <a title="zur Startseite" href="{$WebApplicationBaseURL}">
            <img alt="Logo WiNoDa" src="{$WebApplicationBaseURL}images/winoda-logo-white-back.png" />
          </a>
        </div>

        <div class="project_nav_box">

          <div class="mir-main-nav project-main-nav">
            <nav class="navbar navbar-expand-lg navbar-light">
              <button
                class="navbar-toggler"
                type="button"
                data-toggle="collapse"
                data-target=".mir-main-nav__entries--mobile"
                aria-controls="mir-main-nav__entries--mobile"
                aria-expanded="false"
                aria-label="Toggle navigation">
                <span class="navbar-toggler-icon text-primary"></span>
              </button>
              <div class="collapse navbar-collapse mir-main-nav__entries">
                <ul class="navbar-nav">
                  <xsl:call-template name="project.generate_single_menu_entry">
                    <xsl:with-param name="menuID" select="'brand'"/>
                  </xsl:call-template>
                  <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='search']" />
                  <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='browse']" />
                  <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='publish']" />
                  <xsl:call-template name="mir.basketMenu" />
                </ul>
              </div>
            </nav>
          </div>


          <form
            action="{$WebApplicationBaseURL}servlets/solr/find"
            class="searchfield_box form-inline my-2 my-lg-0"
            role="search">
            <input
              name="condQuery"
              placeholder="{i18n:translate('mir.navsearch.placeholder')}"
              class="form-control mr-sm-2 search-query"
              id="searchInput"
              type="text"
              aria-label="Search" />
            <xsl:choose>
              <xsl:when test="contains($isSearchAllowedForCurrentUser, 'true')">
                <input name="owner" type="hidden" value="createdby:*" />
              </xsl:when>
              <xsl:when test="not(mcrxsl:isCurrentUserGuestUser())">
                <input name="owner" type="hidden" value="createdby:{$CurrentUser}" />
              </xsl:when>
            </xsl:choose>
            <button type="submit" class="btn btn-primary my-2 my-sm-0">
              <i class="fas fa-search"></i>
            </button>
          </form>

        </div>
      </div>
    </div>

    <div class="collapse mir-main-nav__entries--mobile">
      <button
        class="mir-main-nav__entries--mobile-close btn"
        type="button"
        data-toggle="collapse"
        data-target=".mir-main-nav__entries--mobile"
        aria-controls="mir-main-nav__entries--mobile"
        aria-expanded="false"
        aria-label="Toggle navigation">
        <i class="far fa-times-circle "></i>
      </button>

      <ul class="navbar-nav">
        <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='about']" />
        <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='search']" />
        <xsl:call-template name="project.generate_single_menu_entry">
          <xsl:with-param name="menuID" select="'citation'"/>
        </xsl:call-template>
        <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='publish']" />
        <xsl:call-template name="mir.basketMenu" />
      </ul>
    </div>
  </xsl:template>

  <xsl:template name="mir.jumbotwo">
    <!-- show only on startpage -->
    <xsl:if test="//div/@class='jumbotwo'">
    </xsl:if>
  </xsl:template>

  <xsl:template name="mir.footer">

    <div class="footer-logos">
    </div>
    <div class="footer-copyright text-center">
      Copyright © 2024 WiNoDa Knowledge Lab
    </div>
    <div class="footer-menu">
      <ul class="internal_links">
        <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='below']/*" />
      </ul>
    </div>

  </xsl:template>

  <xsl:template name="mir.powered_by">
    <xsl:variable name="mcr_version" select="concat('MyCoRe ',mcrver:getCompleteVersion())" />
    <div id="powered_by">
      <a href="http://www.mycore.de">
        <img src="{$WebApplicationBaseURL}mir-layout/images/mycore_logo_small_invert.png" title="{$mcr_version}" alt="powered by MyCoRe" />
      </a>
    </div>
  </xsl:template>


  <xsl:template name="project.generate_single_menu_entry">
    <xsl:param name="menuID" />

    <xsl:variable name="activeClass">
      <xsl:choose>
        <xsl:when test="$loaded_navigation_xml/menu[@id=$menuID]/item[@href = $browserAddress ]">
        <xsl:text>active</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>not-active</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <li class="nav-item {$activeClass}">

      <a id="{$menuID}" href="{$WebApplicationBaseURL}{$loaded_navigation_xml/menu[@id=$menuID]/item/@href}" class="nav-link" >
        <xsl:choose>
          <xsl:when test="$loaded_navigation_xml/menu[@id=$menuID]/item/label[lang($CurrentLang)] != ''">
            <xsl:value-of select="$loaded_navigation_xml/menu[@id=$menuID]/item/label[lang($CurrentLang)]" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$loaded_navigation_xml/menu[@id=$menuID]/item/label[lang($DefaultLang)]" />
          </xsl:otherwise>
        </xsl:choose>
      </a>
    </li>
  </xsl:template>

</xsl:stylesheet>
