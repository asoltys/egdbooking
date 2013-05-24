<cfoutput>
<!DOCTYPE html>
<!--[if IE 7]><html lang="en" class="no-js ie7"><![endif]-->
<!--[if IE 8]><html lang="en" class="no-js ie8"><![endif]-->
<!--[if gt IE 8]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->

<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,slash)>
<cfset PageDir = listDeleteAt(cgi.CF_TEMPLATE_PATH, listLen(cgi.CF_TEMPLATE_PATH,slash), slash)>
<cfdirectory action="LIST" directory="#PageDir#" name="GetFile" filter="#PageFileName#">
<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,slash)>
<head>
<!-- Web Experience Toolkit (WET) / Boîte à outils de l'expérience Web (BOEW)
wet-boew.github.com/wet-boew/License-eng.txt / wet-boew.github.com/wet-boew/Licence-fra.txt -->
<!-- WET 3.0, PWGSC 1.0 file: 2col-nav-eng.html -->
<!-- MetadataStart -->
<meta charset="utf-8" />
<meta name="dcterms.creator" content="Government of Canada, Public Works and Government Services Canada" />
<meta name="dcterms.modified" title="W3CDTF" content="#DateFormat(GetFile.DateLastModified, "yyyy-mm-dd")#" />
<meta name="dcterms.language" title="ISO639-2" content="eng" />
<!-- MetadataEnd -->
<cfinclude template="/boew-wet/wet3.0/html5/includes/tete-head.html" />
<!-- CustomScriptsCSSStart -->
<link href="#RootDir#css/custom.css" rel="stylesheet" type="text/css" />
<link href="#RootDir#css/jquery-ui.css" media="screen" rel="stylesheet" type="text/css"/>
<cfif structKeyExists(Session, 'AdminLoggedIn') AND Session.AdminLoggedIn>
  <script src="#RootDir#scripts/prototype.js" type="text/javascript"></script>
  <script src="#RootDir#scripts/calendar.js" type="text/javascript"></script>
  <script src="#RootDir#scripts/common.js" type="text/javascript"></script>
</cfif>
<script type="text/javascript" src="#RootDir#scripts/jquery-ui-1.8.17.custom.min.js"></script>
<script type="text/javascript" src="#RootDir#scripts/jquery.ui.datepicker-en.js"></script>
<script type="text/javascript" src="#RootDir#scripts/application.js"></script>
<!-- CustomScriptsCSSEnd -->
</head>

<body><div id="wb-body-sec">
<div id="wb-skip">
<ul id="wb-tphp">
<li id="wb-skip1"><a href="##wb-cont">Skip to main content</a></li>
<li id="wb-skip2"><a href="##wb-nav">Skip to secondary menu</a></li>
</ul>
</div>

<div id="wb-head"><div id="wb-head-in"><header>
<!-- HeaderStart -->
<cfinclude template="#RootDir#includes/app_banner_gc-gc_banner_app-eng.cfm" />
<cfinclude template="/site/wet3.0/html5/includes/app_banner_site-site_banner_app-eng.html" />
<nav role="navigation">

<cfinclude template="/site/wet3.0/html5/includes/app_nav_site-site_nav_app-eng.html" />

<div id="gcwu-bc"><h2>Breadcrumb trail</h2><div id="gcwu-bc-in">
<ol>
<cfinclude template="/site/wet3.0/html5/includes/app_pain-bread_app-eng.html" />
<cfinclude template="#RootDir#includes/bread-pain-eng.cfm" />

</ol>
</div></div>
</nav>
<!-- HeaderEnd -->
</header></div></div>

<div id="wb-core"><div id="wb-core-in" class="equalize">
<div id="wb-main" role="main"><div id="wb-main-in">
<!-- MainContentStart --></cfoutput>
