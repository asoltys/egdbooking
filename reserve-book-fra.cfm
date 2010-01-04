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

<meta name="dc.title" content="TPSGC - CALE S&Egrave;CHE D'ESQUIMALT - R&eacute;servation pour travaux le Cale S&egrave;che d'Esquimalt" />
<meta name="keywords" content="cale seche d'Esquimalt, reservation pour travaux, reparation de navires, bateaux, entretien de navires, cale seche, bassin de radoub, chantier naval" />
<meta name="description" content="Reservation pour travaux le Cale seche d'Esquimalt" />
<meta name="dc.subject" scheme="gccore" content="Quai, Transport maritime, Navire, Traversier, Bateau de plaisance, Embarcation, Repair, Entretien, Gestion" />
<title>TPSGC - CALE S&Egrave;CHE D'ESQUIMALT - Booking Space at the Esquimalt Graving Dock</title>

<meta name="pwgsc.contact.email" content="egd-cse@pwgsc-tpsgc.gc.ca" />
<!-- FIN DES METADONNEES | METADATA ENDS -->
<!-- DEBUT DES CSS DU GABARIT TPSGC | PWGSC TEMPLATE CSS BEGIN -->
<link href="<cfoutput>#CLF_URL#</cfoutput>/clf20/css/base.css" media="screen, print" rel="stylesheet" type="text/css" />
<link href="<cfoutput>#CLF_URL#</cfoutput>/clf20/css/3col.css" media="screen, print" rel="stylesheet" type="text/css" />
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
<link href="#RootDir#css/calendar.css" media="screen" rel="stylesheet" type="text/css"/>

<script src="#RootDir#scripts/prototype.js" type="text/javascript"></script>
<script src="#RootDir#scripts/calendar.js" type="text/javascript"></script>
<script src="#RootDir#scripts/common.js" type="text/javascript"></script>
<!-- CUSTOM SCRIPTS/CSS END | FIN DES SCRIPTS/CSS PERSONNALISES -->

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


<cfoutput>
<script type="text/javascript">
/* <![CDATA[ */
function popUp(pageID) {
	window.open("<cfoutput>#RootDir#</cfoutput>" + pageID + ".cfm?lang=<cfoutput>#lang#</cfoutput>", "", "width=640, height=480, resizable=yes, menubar=yes, scrollbars=yes, toolbar=no");
	}
/* ]]> */
</script>
</cfoutput>

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
<cfoutput>
<ul class="rightNav">
	<li>
		<h2>Saviez-vous?</h2>
		<ul>
			<li>La <acronym title="Cale s&egrave;che d'Esquimalt">CSE</acronym> est une des rares installations de réparation de grands bâtiments au monde à avoir adopté la norme <acronym title="Organisation internationale de normailisation">ISO</acronym> 14001.  <a title="EGD: Leading the Way with ISO 14001" href="#EGD_URL#/env/voie-way-fra.html">Détails &gt; </a></li>

		</ul>
		<br />
		<h2>Quoi de neuf...</h2>
		<ul>
			<li>Dernières étapes en vue de la modification des tarifs de la cale sèche d’Esquimalt.   <a title="CSE: tarifs" href="#EGD_URL#/env/tarifs-rates-fra.html">Suite &gt; </a></li>

		</ul>
	</li>
</ul>
</cfoutput>				
<!-- <a href="http://www.iso.org/iso/fr/iso_catalogue/catalogue_tc/catalogue_detail.htm?csnumber=31807"><img src="/pac/cse-egd/images/ISO14001.gif" width="195" height="68" alt="ISO 14001" title="ISO 14001" /></a> -->
<!-- ====== /pac/cse-egd/SSI/RIGHT-MENU-DROITE-FRA.HTML ====== -->
			</div>

			<!-- DEBUT DU CONTENU | CONTENT BEGINS -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- DEBUT DU TITRE DU CONTENU | CONTENT TITLE BEGINS -->
					R&eacute;servation pour travaux le <acronym title="Cale s&egrave;che d'Esquimalt">CSE</acronym>
					<!-- FIN DU TITRE DU CONTENU | CONTENT TITLE ENDS -->
					</a></h1>
					
				<cfoutput>
				<img src="#RootDir#images/EGD_aerial_small.jpg" alt="Aerial view of the Esquimalt Graving Dock" width="405" height="342" title="Aerial view of the Esquimalt Graving Dock" />

				<p>Afin de r&eacute;server une place pour un navire &agrave; l'une des installations de la Cale s&egrave;che d'Esquimalt, veuillez lancer <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=fra">l'application des r&eacute;servations</a>.
				  Si vous &eacute;prouvez des probl&egrave;mes avec l'application des r&eacute;servations, pri&egrave;re d'utiliser la <a href="#EGD_URL#/cn-cu-fra.html">page Contactez-nous</a>.</p>
				<p>Les frais de r&eacute;servation de la cale s&egrave;che d&rsquo;Esquimalt sont de 3&nbsp;500&nbsp;$ canadiens, plus  210,00&nbsp;$ de taxe sur les produits et services&nbsp;(TPS), ce qui donne en  tout 3&nbsp;710,00&nbsp;$ payables en esp&egrave;ces, par ch&egrave;que certifi&eacute; d&rsquo;une banque  canadienne ou par mandat international. Le 1 er avril 2008, des int&eacute;r&ecirc;ts seront appliqu&eacute;s sur un compte en suspens plus de 30 jours.  Les demandes de r&eacute;servation sont  provisoires jusqu&rsquo;&agrave; ce que les frais de r&eacute;servation soient pay&eacute;s. Les frais de r&eacute;servation ne sont pas remboursables.</p>
				<p><a href="#RootDir#reserve-book/reserve-booking.cfm?lang=fra">Application des r&eacute;servations</a> -
					R&eacute;server la cale s&egrave;che et les jet&eacute;es en ligne.</p>
				<p><a href="#RootDir#utils/resume-summary_ch.cfm?lang=fra">R&eacute;sum&eacute; des r&eacute;servations</a> - Voir toutes les r&eacute;servations.</p>
				<p><em>Les liens suivants vous m&egrave;neront &agrave; des sites externes:</em><br /></p>
				(<img src="#RootDir#images/www1.gif" width="31" height="9" alt="emplacement de WWW" title="emplacement de WWW" />)  <p><a href="http://lois.justice.gc.ca/fr/P-38.2/DORS-89-332/index.html">R&egrave;glement CSE</a></p>
				</cfoutput>
			</div>
		<!-- FIN DU CONTENU | CONTENT ENDS -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-fra.cfm">


