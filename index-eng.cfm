<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">

<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,slash)>
<cfset PageDir = listDeleteAt(cgi.CF_TEMPLATE_PATH, listLen(cgi.CF_TEMPLATE_PATH,slash), slash)>
<cfdirectory action="LIST" directory="#PageDir#" name="GetFile" filter="#PageFileName#">
<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,slash)>
<head>
<!-- CLF 2.0 TEMPLATE VERSION 1.04 | VERSION 1.04 DU GABARIT NSI 2.0 -->
<!-- PWGSC TEMPLATE VERSION 1.0 | VERSION 1.0 DU GABARIT TPSGC -->
<!-- HEADER BEGINS | DEBUT DE L'EN-TETE -->

<!-- METADATA BEGINS | DEBUT DES METADONNEES -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="schema.dc" href="http://purl.org/dc/elements/1.1/" />
<link rel="schema.dc" href="http://purl.org/dc/terms/" />

<meta name="dc.language" scheme="ISO639-2/T" content="eng" />
<meta name="dc.creator" content="Government of Canada, Public Works and Government Services Canada" />
<meta name="dc.publisher" content="Government of Canada, Public Works and Government Services Canada" />

<meta name="dc.audience" content=" " />
<meta name="dc.contributor" content=" " />
<meta name="dc.coverage" content=" " />

<meta name="dc.format" content=" " />
<meta name="dc.identifier" content=" " />
<meta name="dc.type" content="" />

<meta name="dc.rights" content="http://www.tpsgc-pwgsc.gc.ca/comm/ai-in-eng.html" />
<meta name="dcterms.issued" scheme="W3CDTF" content="2007-09-20" />
<meta name="dcterms.modified" scheme="W3CDTF" content="#myDateFormat(parseDateTime(GetFile.DateLastModified,"mm-dd-yyyy"), "yyyy-mm-dd")#" />
<meta name="pwgsc.contact.email" content="questions@pwgsc.gc.ca" />


<meta name="dcterms.title" content="Booking Space at the EGD - Esquimalt Graving Dock - PWGSC" />
<meta name="keywords" content="Booking Space at the Esquimalt Graving Dock" />
<meta name="description" content="Introduction page for the booking application." />
<meta name="dcterms.subject" scheme="gccore" content="#language.masterSubjects#" />
<title>Booking Space at the EGD - Esquimalt Graving Dock - PWGSC</title>
<!-- METADATA ENDS | FIN DES METADONNEES -->

<!-- TEMPLATE SCRIPTS/CSS BEGIN | DEBUT DES SCRIPTS/CSS DU GABARIT -->
<link href="#CLF_URL#/clf20/css/base.css" media="screen, print" rel="stylesheet" type="text/css" />
<link href="#CLF_URL#/clf20/css/3col.css" media="screen, print" rel="stylesheet" type="text/css" />
<style type="text/css" media="all">
/* <![CDATA[ */
	@import url(#CLF_URL#/clf20/css/base2.css);
/* ]]> */
</style>
<!-- TEMPLATE SCRIPTS/CSS END | FIN DES SCRIPTS/CSS DU GABARIT -->

<!-- PROGRESSIVE ENHANCEMENT BEGINS | DEBUT DE L'AMELIORATION PROGRESSIVE -->

<script src="#CLF_URL#/clf20/scripts/pe-ap.js" type="text/javascript"></script>

<script type="text/javascript">
	/* <![CDATA[ */
		var params = {
			lng:"eng",
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

<!-- TEMPLATE PRINT CSS BEGINS | DEBUT DU CSS DU GABARIT POUR L'IMPRESSION -->
<link href="#CLF_URL#/clf20/css/pf-if.css" rel="stylesheet" type="text/css" />
<!-- TEMPLATE PRINT CSS ENDS | FIN DU CSS DU GABARIT POUR L'IMPRESSION -->
</head>

<cfparam name="Variables.onLoad" default="">

<body onload="#Variables.onLoad#">

<div class="page">
	<div class="core">
		<!-- HEADER BEGINS | DEBUT DE L'EN-TETE -->
		<cfinclude template="#CLF_Path#/clf20/ssi/tete-header-eng.cfm">
		<!-- HEADER ENDS | FIN DE L'EN-TETE -->



<script type="text/javascript">
/* <![CDATA[ */
	function popUp(pageID) {
		window.open("#RootDir#" + pageID + ".cfm?lang=#lang#", "", "width=640, height=480, resizable=yes, menubar=yes, scrollbars=yes, toolbar=no");
	}
/* ]]> */
</script>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-eng.html">
      <cfinclude template="#RootDir#includes/bread-pain-eng.cfm">
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-eng.cfm">
					<!-- RIGHT SIDE MENU BEGINS | DEBUT DU MENU LATERAL DROIT -->
			<div class="right">
        <!-- ====== /pac/cse-egd/SSI/RIGHT-MENU-DROITE-ENG.HTML ====== -->
          <ul class="rightNav">
            <li>
              <h2>Did you know?</h2>

              <ul>
                <li><abbr title="Esquimalt Graving Dock">EGD</abbr> was one of the first large ship repair facilities in the world to implement
                  <abbr title="International Organization for Standardization">ISO</abbr> 14001.  <a title="Environmental Program" href="#EGD_URL#/env/programme-program-eng.html">More &gt; </a></li>
              </ul>
            </li>
          </ul>

          <br />

          <ul class="rightNav">
            <li>
              <h2>What's New</h2>

              <ul>
                <li><a title="EGD: Capital Projects" href="#EGD_URL#/env/projects-projets-eng.html">Upcoming capital projects impacting operations for the Esquimalt Graving Dock</a></li>
                <li><a title="EGD Regulations" href="http://gazette.gc.ca/rp-pr/p2/2009/2009-12-23/html/sor-dors324-eng.html">Regulations amending the Esquimalt Graving Dock regulations.</a></li>
              </ul>
            </li>
          </ul>
        <!-- ====== /pac/cse-egd/SSI/RIGHT-MENU-DROITE-ENG.HTML ====== -->
			</div>
			<!-- RIGHT SIDE MENU ENDS | FIN DU MENU LATERAL DROIT -->

			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
		  <div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					#language.bookingSpace#
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<img src="#RootDir#images/EGD_aerial_small.jpg" alt="" width="405" height="342" />

				<p>To reserve space for a vessel at any of the facilities of the Esquimalt Graving
        Dock, please proceed to the <a href="#RootDir#ols-login/ols-login.cfm?lang=eng">#language.bookingApplicationLogin#</a> page.  If you experience any problems with the booking application, please
			    use the <a href="#EGD_URL#/cn-cu-#lang#.html">#language.contact# <abbr title="#language.esqGravingDock#">#language.egd#</abbr></a> page.</p>
				<p>The Esquimalt Graving Dock booking fee is $4,400.00 Canadian plus $528.00 Harmonized Sales Tax (HST) for a total of $4,928.00 payable in cash, certified cheque drawn on a Canadian bank or by an international money order.  Effective April 1, 2008, interest will be applied on any account outstanding over 30 days.  Reservation requests are tentative until the booking fee is paid. Booking fees are non-refundable.</p>
				<p><a href="#RootDir#ols-login/ols-login.cfm?lang=eng">#language.bookingApplicationLogin#</a> - Book drydock and jetty space online.</p>
				<p><a href="#RootDir#utils/resume-summary_ch.cfm?lang=eng">#language.bookingsSummaryDateSelection#</a> - View all bookings.</p>
				<p><a href="http://gazette.gc.ca/rp-pr/p2/2009/2009-12-23/html/sor-dors324-eng.html">Regulations amending the Esquimalt Graving Dock regulations.</a></p>
			  			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-eng.cfm" />
</cfoutput>

