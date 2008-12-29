<cfhtmlhead text="
	<meta name=""dc.title"" content=""TPSGC - CALE S&Egrave;CHE D'ESQUIMALT - R&eacute;servation pour travaux le Cale S&egrave;che d'Esquimalt"" />
	<meta name=""keywords"" content=""cale seche d'Esquimalt, reservation pour travaux, reparation de navires, bateaux, entretien de navires, cale seche, bassin de radoub, chantier naval"" />
	<meta name=""description"" content=""Reservation pour travaux le Cale seche d'Esquimalt"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""Quai, Transport maritime, Navire, Traversier, Bateau de plaisance, Embarcation, Repair, Entretien, Gestion"" />
	<title>TPSGC - CALE S&Egrave;CHE D'ESQUIMALT - Booking Space at the Esquimalt Graving Dock</title>">
<cfinclude template="#RootDir#includes/tete-header-fra.cfm">

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
			<!-- DEBUT DU CONTENU | CONTENT BEGINS -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- DEBUT DU TITRE DU CONTENU | CONTENT TITLE BEGINS -->
					R&eacute;servation pour travaux le <acronym title="Cale s&egrave;che d'Esquimalt">CSE</acronym>
					<!-- FIN DU TITRE DU CONTENU | CONTENT TITLE ENDS -->
					</a></h1>
					
				<cfoutput>
				<img src="#RootDir#images/EGD_aerial_small.jpg" alt="Aerial view of the Esquimalt Graving Dock" width="435" height="342" title="Aerial view of the Esquimalt Graving Dock" />

				<p>Afin de r&eacute;server une place pour un navire &agrave; l'une des installations de la Cale s&egrave;che d'Esquimalt, veuillez lancer <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=fra">l'application des r&eacute;servations</a>.
				  Si vous &eacute;prouvez des probl&egrave;mes avec l'application des r&eacute;servations, pri&egrave;re d'utiliser la <a href="#egd_url#/cse-egd/cn-cu-fra.html">page Contactez-nous</a>.</p>
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


