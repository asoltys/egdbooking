<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">

<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,"\")>
<cfset PageDir = listDeleteAt(cgi.CF_TEMPLATE_PATH, listLen(cgi.CF_TEMPLATE_PATH,"\"), "\")>
<cfdirectory action="LIST" directory="#PageDir#" name="GetFile" filter="#PageFileName#">
<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,"\")>
<HEAD>
<!-- CLF 2.0 TEMPLATE VERSION 1.04 | VERSION 1.04 DU GABARIT NSI 2.0 -->
<!-- PWGSC TEMPLATE VERSION 1.0 | VERSION 1.0 DU GABARIT TPSGC -->
<!-- HEADER BEGINS | DEBUT DE L'EN-TETE -->
<!-- METADATA BEGINS | DEBUT DES METADONNEES -->
<META http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<LINK rel="schema.dc" href="http://purl.org/dc/elements/1.1/" />
<LINK rel="schema.dc" href="http://purl.org/dc/terms/" />

<META name="dc.language" SCHEME="ISO639-2/T" content="eng" />
<META name="dc.creator" content="Government of Canada, Public Works and Government Services Canada" />
<META name="dc.publisher" content="Government of Canada, Public Works and Government Services Canada" />
<META name="dc.audience" content=" " />
<META name="dc.contributor" content=" " />
<META name="dc.coverage" content=" " />
<META name="dc.format" content=" " />
<META name="dc.identifier" content=" " />
<META name="dc.rights" content="http://www.tpsgc-pwgsc.gc.ca/comm/ai-in-eng.html" />
<META name="dcterms.issued" SCHEME="W3CDTF" content="2007-09-20" />
<META name="dcterms.modified" SCHEME="W3CDTF" content="<cfoutput query="GetFile">	#LSDateFormat(parseDateTime(GetFile.DateLastModified,"mm-dd-yyyy"), "yyyy-mm-dd")#</cfoutput>" />

<META name="pwgsc.contact.email" content="questions@pwgsc-tpgsc.gc.ca" />

<!-- TEMPLATE SCRIPTS/CSS BEGIN | DEBUT DES SCRIPTS/CSS DU GABARIT -->
<LINK href="/clf20/css/base.css" media="screen, print" rel="stylesheet" type="text/css" />
<LINK href="/clf20/css/2col.css" media="screen, print" rel="stylesheet" type="text/css" />
<STYLE type="text/css" media="all">@import url(/clf20/css/base2.css);</STYLE>
<!-- TEMPLATE SCRIPTS/CSS END | FIN DES SCRIPTS/CSS DU GABARIT -->
<!-- PROGRESSIVE ENHANCEMENT BEGINS | DEBUT DE L'AMELIORATION PROGRESSIVE -->
<SCRIPT src="/clf20/scripts/pe-ap.js" type="text/javascript"></SCRIPT>
<SCRIPT type="text/javascript">
	/* <![CDATA[ */
		var params = {
			lng:"eng",
			pngfix:"/clf20/images/inv.gif"
		};
		PE.progress(params);
	/* ]]> */
</SCRIPT>
<!-- PROGRESSIVE ENHANCEMENT ENDS | FIN DE L'AMELIORATION PROGRESSIVE -->
<!-- CUSTOM SCRIPTS/CSS BEGIN | DEBUT DES SCRIPTS/CSS PERSONNALISES -->
<LINK href="/clf20/css/base-institution.css" media="screen, print" rel="stylesheet" type="text/css" />
<LINK href="/clf20/css/institution.css" media="screen, print" rel="stylesheet" type="text/css" />
<STYLE type="text/css" media="screen,print">@import url(<cfoutput>#RootDir#</cfoutput>css/advanced.css);</STYLE>
<!-- CUSTOM SCRIPTS/CSS END | FIN DES SCRIPTS/CSS PERSONNALISES -->
<!-- TEMPLATE PRINT CSS BEGINS | DEBUT DU CSS DU GABARIT POUR L'IMPRESSION -->
<LINK href="/clf20/css/pf-if.css" rel="stylesheet" type="text/css" />
<!-- TEMPLATE PRINT CSS ENDS | FIN DU CSS DU GABARIT POUR L'IMPRESSION -->
</HEAD>

<cfparam name="Variables.onLoad" default="">

<body onLoad="<cfoutput>#Variables.onLoad#</cfoutput>">

<div class="page">
	<div class="core">
		<!-- HEADER BEGINS | DEBUT DE L'EN-TETE -->
		<cfinclude template="/clf20/ssi/tete-header-eng.html">
		<!-- HEADER ENDS | FIN DE L'EN-TETE -->
