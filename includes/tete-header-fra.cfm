<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr" xml:lang="fr">

<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,"\")>
<cfset PageDir = listDeleteAt(cgi.CF_TEMPLATE_PATH, listLen(cgi.CF_TEMPLATE_PATH,"\"), "\")>
<cfdirectory action="LIST" directory="#PageDir#" name="GetFile" filter="#PageFileName#">
<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,"\")>
<head>
<!-- VERSION 1.04 DU GABARIT NSI 2.0 | CLF 2.0 TEMPLATE VERSION 1.04 -->
<!-- VERSION 1.0 DU GABARIT TPSGC | PWGSC TEMPLATE VERSION 1.0 -->
<!-- DEBUT DE L'EN-TETE | HEADER BEGINS -->

<!-- DEBUT DU TITRE | title BEGINS -->
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="schema.dc" href="http://purl.org/dc/elements/1.1/" />
<link rel="schema.dc" href="http://purl.org/dc/terms/" />

<meta name="dc.language" scheme="ISO639-2/T" content="fra" />
<meta name="dc.creator" content="Gouvernement du Canada, Travaux publics et Services gouvernementaux Canada" />
<meta name="dc.publisher" content="Gouvernement du Canada, Travaux publics et Services gouvernementaux Canada" />

<meta name="dc.audience" content=" " />
<meta name="dc.contributor" content=" " />
<meta name="dc.coverage" content=" " />
<meta name="dc.date.created" content="2008-06-13" />
<meta name="dc.date.modified" content="2008-11-12" />
<meta name="dc.format" content=" " />
<meta name="dc.identifier" content=" " />
<meta name="dc.type" content="" />

<meta name="dc.rights" content="http://www.tpsgc-pwgsc.gc.ca/comm/ai-in-fra.html" />
<meta name="dcterms.issued" scheme="W3CDTF" content="2007-09-20" />
<meta name="dcterms.modified" scheme="W3CDTF" content="<cfoutput query="GetFile">#LSDateFormat(parseDateTime(GetFile.DateLastModified,"mm-dd-yyyy"), "yyyy-mm-dd")#</cfoutput>" />

<meta name="pwgsc.contact.email" content="questions@tpsgc.gc.ca" />
<!-- FIN DES METADONNEES | METADATA ENDS -->
<!-- DEBUT DES CSS DU GABARIT TPSGC | PWGSC TEMPLATE CSS BEGIN -->
<link href="<cfoutput>#CLF_URL#</cfoutput>/clf20/css/base.css" media="screen, print" rel="stylesheet" type="text/css" />
<link href="<cfoutput>#CLF_URL#</cfoutput>/clf20/css/2col.css" media="screen, print" rel="stylesheet" type="text/css" />
<style type="text/css" media="all">
/* <![CDATA[ */
	@import url(<cfoutput>#CLF_URL#</cfoutput>/clf20/css/base2.css);
/* ]]> */
</style>
<!-- FIN DES SCRIPTS/CSS DU GABARIT | TEMPLATE SCRIPTS/CSS END -->

<!-- PROGRESSIVE ENHANCEMENT BEGINS | DEBUT DE L'AMELIORATION PROGRESSIVE -->
<cfoutput>
<script src="#CLF_URL#/clf20/scripts/pe-ap.js" type="text/javascript"></script>
<script src="#Rootdir#scripts/external.js" type="text/javascript"></script>

<script type="text/javascript">
	/* <![CDATA[ */
		var params = {
			lng:"fra",
			pngfix:"#CLF_URL#/clf20/images/inv.gif"
		};
		PE.progress(params);
	/* ]]> */
</script>
</cfoutput>
<!-- PROGRESSIVE ENHANCEMENT ENDS | FIN DE L'AMELIORATION PROGRESSIVE -->

<!-- CUSTOM SCRIPTS/CSS BEGIN | DEBUT DES SCRIPTS/CSS PERSONNALISES -->
<cfoutput>
<link href="#CLF_URL#/clf20/css/base-institution.css" media="screen, print" rel="stylesheet" type="text/css" />
<link href="#CLF_URL#/clf20/css/institution.css" media="screen, print" rel="stylesheet" type="text/css" />

<link href="#RootDir#css/custom.css" media="screen, print" rel="stylesheet" type="text/css" />
<style type="text/css" media="screen,print">@import url(#RootDir#css/advanced.css);</style>
<link href="#RootDir#css/calendar.css" media="screen" rel="stylesheet" type="text/css"/>

<script src="#RootDir#scripts/prototype.js" type="text/javascript"></script>
<script src="#RootDir#scripts/calendar.js" type="text/javascript"></script>
<script src="#RootDir#scripts/common.js" type="text/javascript"></script>
<!-- CUSTOM SCRIPTS/CSS END | FIN DES SCRIPTS/CSS PERSONNALISES -->

<noscript>JavaScript requis</noscript>

<!-- DEBUT DU CSS DU GABARIT POUR L'IMPRESSION | TEMPLATE PRINT CSS BEGINS -->
<link href="#CLF_URL#/clf20/css/pf-if.css" rel="stylesheet" type="text/css" />
</cfoutput>
<!-- FIN DU CSS DU GABARIT POUR L'IMPRESSION | TEMPLATE PRINT CSS ENDS -->
</head>
<body>
<div class="page">
	<div class="core">
		<!-- HEADER BEGINS | DEBUT DE L'EN-TETE -->
		<cfinclude template="#CLF_Path#/clf20/ssi/tete-header-fra.html">
		<!-- HEADER ENDS | FIN DE L'EN-TETE -->
