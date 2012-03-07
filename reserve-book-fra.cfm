<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr" xml:lang="fr">

<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,slash)>
<cfset PageDir = listDeleteAt(cgi.CF_TEMPLATE_PATH, listLen(cgi.CF_TEMPLATE_PATH,slash), slash)>
<cfdirectory action="LIST" directory="#PageDir#" name="GetFile" filter="#PageFileName#">
<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,slash)>
<head>
<!-- VERSION 1.04 DU GABARIT NSI 2.0 | CLF 2.0 TEMPLATE VERSION 1.04 -->
<!-- VERSION 1.0 DU GABARIT TPSGC | PWGSC TEMPLATE VERSION 1.0 -->
<!-- DEBUT DE L'EN-TETE | HEADER BEGINS -->

<!-- DEBUT DU TITRE | title BEGINS -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="schema.dc" href="http://purl.org/dc/elements/1.1/" />
<link rel="schema.dc" href="http://purl.org/dc/terms/" />

<meta name="dc.language" scheme="ISO639-2/T" content="fra" />
<meta name="dc.creator" content="Gouvernement du Canada, Travaux publics et Services gouvernementaux Canada" />
<meta name="dc.publisher" content="Gouvernement du Canada, Travaux publics et Services gouvernementaux Canada" />

<meta name="dc.audience" content=" " />
<meta name="dc.contributor" content=" " />
<meta name="dc.coverage" content=" " />

<meta name="dc.format" content=" " />
<meta name="dc.identifier" content=" " />
<meta name="dc.type" content="" />

<meta name="dc.rights" content="http://www.tpsgc-pwgsc.gc.ca/comm/ai-in-fra.html" />
<meta name="dcterms.issued" scheme="W3CDTF" content="2007-09-20" />
<meta name="dcterms.modified" scheme="W3CDTF" content="#LSDateFormat(parseDateTime(GetFile.DateLastModified,"mm-dd-yyyy"), "yyyy-mm-dd")#" />

<meta name="dc.title" content="R&eacute;servation pour travaux le CSE - Cale s&egrave;che d'Esquimalt - TPSGC" />
<meta name="keywords" content="cale seche d'Esquimalt, reservation pour travaux, reparation de navires, bateaux, entretien de navires, cale seche, bassin de radoub, chantier naval" />
<meta name="description" content="Reservation pour travaux le Cale seche d'Esquimalt" />
<meta name="dc.subject" scheme="gccore" content="#language.masterSubjects#" />
<title>R&eacute;servation pour travaux le CSE - Cale s&egrave;che d'Esquimalt - TPSGC</title>

<meta name="pwgsc.contact.email" content="egd-cse@pwgsc-tpsgc.gc.ca" />
<!-- FIN DES METADONNEES | METADATA ENDS -->
<!-- DEBUT DES CSS DU GABARIT TPSGC | PWGSC TEMPLATE CSS BEGIN -->
<link href="#CLF_URL#/clf20/css/base.css" media="screen, print" rel="stylesheet" type="text/css" />
<link href="#CLF_URL#/clf20/css/3col.css" media="screen, print" rel="stylesheet" type="text/css" />
<style type="text/css" media="all">
/* <![CDATA[ */
	@import url(#CLF_URL#/clf20/css/base2.css);
/* ]]> */
</style>
<!-- FIN DES SCRIPTS/CSS DU GABARIT | TEMPLATE SCRIPTS/CSS END -->

<!-- PROGRESSIVE ENHANCEMENT BEGINS | DEBUT DE L'AMELIORATION PROGRESSIVE -->

<script src="#CLF_URL#/clf20/scripts/pe-ap.js" type="text/javascript"></script>

<script type="text/javascript">
	/* <![CDATA[ */
		var params = {
			lng:"fra",
			pngfix:"#CLF_URL#/clf20/images/inv.gif"
		};
		PE.progress(params);
	/* ]]> */
</script>
<!-- PROGRESSIVE ENHANCEMENT ENDS | FIN DE L'AMELIORATION PROGRESSIVE -->

<!-- CUSTOM SCRIPTS/CSS BEGIN | DEBUT DES SCRIPTS/CSS PERSONNALISES -->

<link href="#CLF_URL#/clf20/css/base-institution.css" media="screen, print" rel="stylesheet" type="text/css" />
<link href="#CLF_URL#/clf20/css/institution.css" media="screen, print" rel="stylesheet" type="text/css" />

<link href="#RootDir#css/custom.css" media="screen, print" rel="stylesheet" type="text/css" />
<link href="#RootDir#css/calendar.css" media="screen" rel="stylesheet" type="text/css"/>

<script src="#RootDir#scripts/prototype.js" type="text/javascript"></script>
<script src="#RootDir#scripts/calendar.js" type="text/javascript"></script>
<script src="#RootDir#scripts/common.js" type="text/javascript"></script>
<!-- CUSTOM SCRIPTS/CSS END | FIN DES SCRIPTS/CSS PERSONNALISES -->

<!-- DEBUT DU CSS DU GABARIT POUR L'IMPRESSION | TEMPLATE PRINT CSS BEGINS -->
<link href="#CLF_URL#/clf20/css/pf-if.css" rel="stylesheet" type="text/css" />
<!-- FIN DU CSS DU GABARIT POUR L'IMPRESSION | TEMPLATE PRINT CSS ENDS -->
</head>
<body>
<div class="page">
	<div class="core">
		<!-- HEADER BEGINS | DEBUT DE L'EN-TETE -->
		<cfinclude template="#CLF_Path#/clf20/ssi/tete-header-fra.cfm">
		<!-- HEADER ENDS | FIN DE L'EN-TETE -->



<script type="text/javascript">
/* <![CDATA[ */
function popUp(pageID) {
	window.open("#RootDir#" + pageID + ".cfm?lang=#lang#", "", "width=640, height=480, resizable=yes, menubar=yes, scrollbars=yes, toolbar=no");
	}
/* ]]> */
</script>

		<!-- DEBUT DE LA PISTE DE NAVIGATION | BREAD CRUMB BEGINS -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-fra.html"><cfinclude template="#RootDir#includes/bread-pain-fra.cfm">
		</p>
		<!-- FIN DE LA PISTE DE NAVIGATION | BREAD CRUMB ENDS -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-fra.cfm">
		<!-- DEBUT DU MENU LATERAL DROIT | RIGHT SIDE MENU BEGINS -->
			<div class="right">

				<!-- ====== /pac/cse-egd/SSI/RIGHT-MENU-DROITE-FRA.HTML ====== -->

<ul class="rightNav">
	<li>
		<h2>Saviez-vous?</h2>
		<ul>
			<li>La <acronym title="Cale s&egrave;che d'Esquimalt">CSE</acronym> est une des rares installations de r&##233;paration de grands b&##226;timents au monde &##224; avoir adopt&##233; la norme <acronym title="Organisation internationale de normailisation">ISO</acronym> 14001.  <a title="Programme environnemental" href="#EGD_URL#/env/programme-program-fra.html">D&eacute;tails &gt; </a></li>

		</ul>
		<br />
		<h2>Quoi de neuf...</h2>
		<ul>
			<li><a title="CSE: Capital Projects" href="#EGD_URL#/env/projects-projets-fra.html">Futurs projets d&##39;investissement impact sur les op&##233;rations de la cale s&##232;che d&##39;Esquimalt.</a></li>
			<li><a title="CSE Reglement" href="http://gazette.gc.ca/rp-pr/p2/2009/2009-12-23/html/sor-dors324-fra.html">R&##232;glement modifiant le R&##232;glement de 1989 sur la cale s&##232;che d'Esquimalt</a>.</li>

		</ul>
	</li>
</ul>
<!-- ====== /pac/cse-egd/SSI/RIGHT-MENU-DROITE-FRA.HTML ====== -->
			</div>

			<!-- DEBUT DU CONTENU | CONTENT BEGINS -->
		  <div class="center">
				<h1><a name="cont" id="cont">
					<!-- DEBUT DU TITRE DU CONTENU | CONTENT TITLE BEGINS -->
					#language.bookingSpace#
					<!-- FIN DU TITRE DU CONTENU | CONTENT TITLE ENDS -->
					</a></h1>
					

				<img src="#RootDir#images/EGD_aerial_small.jpg" alt="" width="405" height="342" />

        <p>Afin de r&eacute;server une place pour un navire &agrave; l'une des installations de la Cale s&egrave;che d'Esquimalt, veuillez lancer l'<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=fra">Application des r&eacute;servations</a>.
			    Si vous &eacute;prouvez des probl&egrave;mes avec l'application des r&eacute;servations, pri&egrave;re d'utiliser la <a href="#EGD_URL#/cn-cu-fra.html">page Contactez-nous</a>.</p>
          <p>Les frais de r&eacute;servation de la cale s&egrave;che d&rsquo;Esquimalt sont de 4&nbsp;400,00$  canadiens, plus 528,00$ de taxe de vente harmonis&eacute;e (TVH), ce qui donne en  tout 4&nbsp;928,00$ payables en esp&egrave;ces, par ch&egrave;que certifi&eacute; d&rsquo;une banque  canadienne ou par mandat international. Le 1<sup>er</sup> avril 2008, des int&eacute;r&ecirc;ts seront appliqu&eacute;s sur un compte en suspens plus de 30 jours.  Les demandes de r&eacute;servation sont  provisoires jusqu&rsquo;&agrave; ce que les frais de r&eacute;servation soient pay&eacute;s. Les frais de r&eacute;servation ne sont pas remboursables.</p>
				<p><a href="#RootDir#ols-login/ols-login.cfm?lang=fra">#language.bookingApplicationLogin#</a> -
				  R&eacute;server la cale s&egrave;che et les jet&eacute;es en ligne.</p>
				<p><a href="#RootDir#utils/resume-summary_ch.cfm?lang=fra">#language.bookingsSummaryDateSelection#</a> - Voir toutes les r&eacute;servations.</p>
				<p><a href="http://gazette.gc.ca/rp-pr/p2/2009/2009-12-23/html/sor-dors324-fra.html">R&##232;glement modifiant le R&##232;glement de 1989 sur la cale s&##232;che d'Esquimalt</a></p>
			  			</div>
		<!-- FIN DU CONTENU | CONTENT ENDS -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-fra.cfm">

</cfoutput>
