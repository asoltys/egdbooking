<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">

<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,"\")>
<cfset PageDir = listDeleteAt(cgi.CF_TEMPLATE_PATH, listLen(cgi.CF_TEMPLATE_PATH,"\"), "\")>
<cfdirectory action="LIST" directory="#PageDir#" name="GetFile" filter="#PageFileName#">
<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,"\")>
<head>
<!-- CLF 2.0 TEMPLATE VERSION 1.04 | VERSION 1.04 DU GABARIT NSI 2.0 -->
<!-- PWGSC TEMPLATE VERSION 1.0 | VERSION 1.0 DU GABARIT TPSGC -->
<!-- HEADER BEGINS | DEBUT DE L'EN-TETE -->

<!-- METADATA BEGINS | DEBUT DES METADONNEES -->
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="schema.dc" href="http://purl.org/dc/elements/1.1/" />
<link rel="schema.dc" href="http://purl.org/dc/terms/" />

<meta name="dc.language" scheme="ISO639-2/T" content="eng" />
<meta name="dc.creator" content="Government of Canada, Public Works and Government Services Canada" />
<meta name="dc.publisher" content="Government of Canada, Public Works and Government Services Canada" />

<meta name="dc.audience" content=" " />
<meta name="dc.contributor" content=" " />
<meta name="dc.coverage" content=" " />
<meta name="dc.date.created" content="2008-06-13" />
<meta name="dc.date.modified" content="2008-12-29" />
<meta name="dc.format" content=" " />
<meta name="dc.identifier" content=" " />
<meta name="dc.type" content="" />

<meta name="dc.rights" content="http://www.tpsgc-pwgsc.gc.ca/comm/ai-in-eng.html" />
<meta name="dcterms.issued" scheme="W3CDTF" content="2007-09-20" />
<meta name="dcterms.modified" scheme="W3CDTF" content="<cfoutput query="GetFile">#LSDateFormat(parseDateTime(GetFile.DateLastModified,"mm-dd-yyyy"), "yyyy-mm-dd")#</cfoutput>" />
<meta name="pwgsc.contact.email" content="questions@pwgsc.gc.ca" />


<meta name="dc.title" content="PWGSC - ESQUIMALT GRAVING DOCK - Booking Space at the Esquimalt Graving Dock" />
<meta name="keywords" content="Booking Space at the Esquimalt Graving Dock" />
<meta name="description" content="Introduction page for the booking application." />
<meta name="dc.subject" scheme="gccore" content="Wharfs, Ships, Ferries, Pleasure Craft, Vessels, Repair, Maintenance, Management" />
<title>PWGSC - ESQUIMALT GRAVING DOCK - Booking Space at the Esquimalt Graving Dock</title>
<!-- METADATA ENDS | FIN DES METADONNEES -->

<!-- TEMPLATE SCRIPTS/CSS BEGIN | DEBUT DES SCRIPTS/CSS DU GABARIT -->
<link href="<cfoutput>#CLF_URL#</cfoutput>/clf20/css/base.css" media="screen, print" rel="stylesheet" type="text/css" />
<link href="<cfoutput>#CLF_URL#</cfoutput>/clf20/css/3col.css" media="screen, print" rel="stylesheet" type="text/css" />
<style type="text/css" media="all">
/* <![CDATA[ */
	@import url(<cfoutput>#CLF_URL#</cfoutput>/clf20/css/base2.css);
/* ]]> */
</style>
<!-- TEMPLATE SCRIPTS/CSS END | FIN DES SCRIPTS/CSS DU GABARIT -->

<!-- PROGRESSIVE ENHANCEMENT BEGINS | DEBUT DE L'AMELIORATION PROGRESSIVE -->
<cfoutput>
<script src="#CLF_URL#/clf20/scripts/pe-ap.js" type="text/javascript"></script>
<script src="#Rootdir#scripts/external.js" type="text/javascript"></script>

<script type="text/javascript">
	/* <![CDATA[ */
		var params = {
			lng:"eng",
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

<!-- TEMPLATE PRINT CSS BEGINS | DEBUT DU CSS DU GABARIT POUR L'IMPRESSION -->
<link href="#CLF_URL#/clf20/css/pf-if.css" rel="stylesheet" type="text/css" />
</cfoutput>
<!-- TEMPLATE PRINT CSS ENDS | FIN DU CSS DU GABARIT POUR L'IMPRESSION -->
</head>

<cfparam name="Variables.onLoad" default="">

<body onload="<cfoutput>#Variables.onLoad#</cfoutput>">

<div class="page">
	<div class="core">
		<!-- HEADER BEGINS | DEBUT DE L'EN-TETE -->
		<cfinclude template="#CLF_Path#/clf20/ssi/tete-header-eng.html">
		<!-- HEADER ENDS | FIN DE L'EN-TETE -->


<cfoutput>
<script type="text/javascript">
/* <![CDATA[ */
	function popUp(pageID) {
		window.open("#RootDir#" + pageID + ".cfm?lang=<cfoutput>#lang#</cfoutput>", "", "width=640, height=480, resizable=yes, menubar=yes, scrollbars=yes, toolbar=no");
	}
/* ]]> */
</script>
</cfoutput>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-eng.html"><cfinclude template="#RootDir#includes/bread-pain-eng.cfm">
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-eng.cfm">
					<!-- RIGHT SIDE MENU BEGINS | DEBUT DU MENU LATERAL DROIT -->
			<div class="right">
				<!-- ====== /pac/cse-egd/SSI/RIGHT-MENU-DROITE-ENG.HTML ====== -->
				<cfoutput>
				<ul class="rightNav">
				
					<li>
						<h2>Did you know?</h2>
				
						<ul>
							<li><acronym title="Esquimalt Graving Dock">EGD</acronym> is one of the few large ship repair facilities in the world who has implemented
								<acronym title="International Organization for Standardization">ISO</acronym> 14001.  <a title="EGD: Leading the Way with ISO 14001" href="#EGD_URL#/env/voie-way-eng.html">More &gt; </a></li>
						</ul>
					</li>
				</ul>
				<br />
				<ul class="rightNav">
				
					<li>
						<h2>What's New</h2>
				
						<ul>
							<li><a title="EGD: Rates" href="#EGD_URL#/env/tarifs-rates-eng.html">Proposed changes to the Esquimalt Graving Dock rates now in the final stages.</a></li>

              <li><a title="EGD: Capital Projects" href="#EGD_URL#/env/projects-projets-eng.html">Upcoming capital projects impacting operations for the Esquimalt Graving Dock.</a></li>

              <li><a title="EGD Regulations" href="http://gazette.gc.ca/rp-pr/p2/2009/2009-12-23/html/sor-dors324-eng.html">Regulations amending the Esquimalt Graving Dock regulations.</a></li>
						</ul>
					</li>
				</ul>
				</cfoutput>
			<!-- <a href="http://www.iso.org/iso/iso_catalogue/catalogue_tc/catalogue_detail.htm?csnumber=31807"><img src="/pac/cse-egd/images/ISO14001.gif" width="195" height="68" alt="ISO 14001" title="ISO 14001" /></a> -->
			<!-- ====== /pac/cse-egd/SSI/RIGHT-MENU-DROITE-ENG.HTML ====== -->
			</div>
			<!-- RIGHT SIDE MENU ENDS | FIN DU MENU LATERAL DROIT -->

			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Booking Space at the <acronym title="Esquimalt Graving Dock">EGD</acronym>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>
				<cfoutput>
				<img src="#RootDir#images/EGD_aerial_small.jpg" alt="Aerial view of the Esquimalt Graving Dock" width="405" height="342" title="Aerial view of the Esquimalt Graving Dock" />

				<p>To reserve space for a vessel at any of the facilities of the Esquimalt Graving
				  Dock, please proceed to the <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=eng">Booking 
				  Application</a>.  If you experience any problems with the booking application, please
				  use the <a href="#EGD_URL#/cn-cu-eng.html">contact us</a> page.</p>
				<p>The Esquimalt Graving Dock booking fee is $3,500 Cdn. plus $175.00 Goods &amp; Services Tax (GST) for a total of $3675.00 payable in cash, certified cheque drawn on a Canadian bank or by an international money order. Effective April 1, 2008, interest will be applied on any account outstanding over 30 days.  Reservation requests are tentative until the booking fee is paid. Booking fees are non-refundable.</p>
				<p><a href="#RootDir#reserve-book/reserve-booking.cfm?lang=eng">Booking Application</a> - Book drydock and jetty space online.</p>
				<p><a href="#RootDir#utils/resume-summary_ch.cfm?lang=eng">Booking Summary</a> - View all bookings.</p>
				<p><em>The following links will direct you to an external site:</em><br /></p>
				(<img src="#RootDir#images/www1.gif" width="31" height="9" alt="www site" title="www site" />) <p><a href="http://laws.justice.gc.ca/en/p-38.2/sor-89-332/92221.html">EGD Regulations</a></p>
				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-eng.cfm">

