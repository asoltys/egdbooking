<cfoutput>
<cfsavecontent variable="head">
<title>R&eacute;servation pour travaux le CSE - Cale s&egrave;che d'Esquimalt - TPSGC</title>
<meta name="description" content="Reservation pour travaux le Cale seche d'Esquimalt" />
<meta name="dcterms.description" content="Reservation pour travaux le Cale seche d'Esquimalt" />
<meta name="dcterms.title" content="R&eacute;servation pour travaux le CSE - Cale s&egrave;che d'Esquimalt - TPSGC" />
<meta name="dcterms.issued" title="W3CDTF" content="2007-09-20" />
<meta name="dcterms.subject" title="gccore" content="#language.masterSubjects#" />
<meta name="keywords" content="cale seche d'Esquimalt, reservation pour travaux, reparation de navires, bateaux, entretien de navires, cale seche, bassin de radoub, chantier naval" />
</cfsavecontent>
<cfhtmlhead text="#head#">
<cfset request.title = language.bookingSpace>

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">
<h1>#language.bookingSpace#</h1>

<div class="span-4">
<img src="#RootDir#images/EGD_aerial_small.jpg" alt="" width="405" height="342" />

<p>Afin de r&eacute;server une place pour un navire &agrave; l'une des installations de la Cale s&egrave;che d'Esquimalt, veuillez lancer la page d'<a href="#RootDir#ols-login/ols-login.cfm?lang=fra">#language.bookingApplicationLogin#</a>.
			    Si vous &eacute;prouvez des probl&egrave;mes avec l'application des r&eacute;servations, pri&egrave;re d'utiliser la page <a href="#EGD_URL#/cn-cu-#lang#.html">#language.contact# <abbr title="#language.esqGravingDock#">#language.egd#</abbr></a>.</p>
          <p>Les frais de r&eacute;servation de la cale s&egrave;che d&rsquo;Esquimalt sont de 4&nbsp;800,00$  canadiens, plus 240,00$ de taxe de vente g&eacute;n&eacute;rale (TVG), ce qui donne en  tout 5&nbsp;040,00$ payables en esp&egrave;ces, par ch&egrave;que certifi&eacute; d&rsquo;une banque  canadienne ou par mandat international. Le 1<sup>er</sup> avril 2008, des int&eacute;r&ecirc;ts seront appliqu&eacute;s sur un compte en suspens plus de 30 jours.  Les demandes de r&eacute;servation sont  provisoires jusqu&rsquo;&agrave; ce que les frais de r&eacute;servation soient pay&eacute;s. Les frais de r&eacute;servation ne sont pas remboursables.</p>
				<p><a href="#RootDir#ols-login/ols-login.cfm?lang=fra">#language.bookingApplicationLogin#</a> -
				  R&eacute;server la cale s&egrave;che et les jet&eacute;es en ligne.</p>
<p><a href="#RootDir#utils/resume-summary_ch.cfm?lang=eng">#language.bookingsSummaryDateSelection#</a> - Voir toutes les r&eacute;servations.</p>
<p><a href="http://gazette.gc.ca/rp-pr/p2/2009/2009-12-23/html/sor-dors324-eng.html">R&egrave;glement modifiant le R&egrave;glement de 1989 sur la cale s&egrave;che d'Esquimalt</a></p>
</div>

<cfinclude template="#RootDir#includes/right-menu-droite-fra.cfm">
<cfinclude template="#RootDir#includes/foot-pied-fra.cfm" />
</cfoutput>

