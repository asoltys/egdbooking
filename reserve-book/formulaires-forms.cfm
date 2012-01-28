<cfinclude template="#RootDir#includes/bookingInfoVariables.cfm">
<cfif lang EQ "eng">
	<cfset language.bookingForms = "Booking Forms">
	<cfset language.keywords = language.masterKeywords & ", Booking Forms">
	<cfset language.description = "Contains informaiton on available forms.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.form = "Form">
	<cfset language.schedule = "Schedule 1">
	<cfset language.indemnification = "Indemnification Clause">
	<cfset language.changeForm = "Tentative Vessel and Change Booking Form">
	<cfset language.dockcharges = "Tariff of Dock Charges">
  <cfset language.formExplanation = "The following forms are used in booking the drydock.<br /><br /><em>Schedule 1</em> and the <em>Indemnification Clause</em> are required to confirm a booking.  The <em>Schedule 1 - Drydock Application Form</em> provides <abbr title=""Esquimalt Graving Dock"">EGD</abbr> with vessel details and acts as a formal booking agreement between you and the Esquimalt Graving Dock.  The <em>Indemnification Clause</em> is a legal disclaimer that indemnifies the Crown against liability for injuries or damages.<br /><br />The <em>Tentative Vessel and Change Booking Form</em> is required if you wish to make any changes after submitting a request for booking.">
<cfelse>
	<cfset language.bookingForms = "Formulaires de r&eacute;servation">
	<cfset language.keywords = language.masterKeywords & ",  Formulaire de r&eacute;servation">
	<cfset language.description = "Contient de l'information sur les formulaires offerts.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.form = "Formulaire">
	<cfset language.schedule = "Tableau 1">
	<cfset language.indemnification = "Clause d'indemnit&eacute;">
	<cfset language.changeForm = "Formulaire de r&eacute;servation provisoire pour les navires et les modifications">
	<cfset language.dockcharges = "Formulaire de tarif des droits de la cale s&egrave;che">
  <cfset language.formExplanation = "Les formulaires suivants servent aux r&eacute;servations de la cale s&egrave;che. <br /><br />Le <em>Tableau 1</em> et la <em>Clause d'indemnisation</em> doivent &ecirc;tre soumis pour que la r&eacute;servation puisse &ecirc;tre confirm&eacute;e. Le <em>Tableau 1 - Formulaire de demande de r&eacute;servation</em> donne &agrave; la <abbr title=""Cale S&egrave;che d'Esquimalt"">CSE</abbr> les renseignements n&eacute;cessaires sur le navire et sert d'entente de r&eacute;servation formelle entre vous et la <abbr title=""Cale S&egrave;che d'Esquimalt"">CSE</abbr>. La <em>Clause d'indemnisation</em> est un document juridique qui d&eacute;gage la Couronne de toute responsabilit&eacute; en cas de blessures ou de dommages.<br /><br />Vous aurez besoin du formulaire de modification d'une r&eacute;servation si vous voulez apporte un changement apr&egrave;s avoir soumis une demande de r&eacute;servation.">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.bookingForms# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.bookingForms# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			<CFELSE>
				<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			</CFIF>
			#language.bookingForms#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.bookingForms#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
				<cfoutput>
				<p>#language.formExplanation#</p>

				<ul>
					<li><a href="#RootDir#reserve-book/tableau-schedule-1.cfm">#language.schedule#</a></li>
					<li><a href="#RootDir#reserve-book/indem.cfm">#language.Indemnification#</a></li>
					<li><a href="#RootDir#reserve-book/changement-change.cfm" title="#language.changeForm#" rel="external">#language.changeForm#</a></li>
					<li><a href="#RootDir#reserve-book/tarifconsult-tariffview.cfm?lang=#lang#" title="Tariff of Dock Charges">#language.dockcharges#</a></li>
				</ul>
				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

