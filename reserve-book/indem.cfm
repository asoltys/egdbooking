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
	<cfset language.helpformats = "<a class=""help"" href=""http://www.tpsgc-pwgsc.gc.ca/comm/aformats-eng.html"">Help on File Formats</a>">
	<cfset language.pdfformat = "Other Format - PDF">
	<cfset language.pdfversion = "PDF Version">
	<cfset language.bytes = "B">
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
	<cfset language.helpformats = "<a class=""help"" href=""http://www.tpsgc-pwgsc.gc.ca/comm/aformats-fra.html"">Aide sur les formats de fichier</a>">
	<cfset language.pdfformat = "Version - PDF">
	<cfset language.pdfversion = "Version PDF">
	<cfset language.bytes = "o">
  <cfset language.formExplanation = "Les formulaires suivants servent aux r&eacute;servations de la cale s&egrave;che. <br /><br />Le <em>Tableau 1</em> et la <em>Clause d'indemnisation</em> doivent &ecirc;tre soumis pour que la r&eacute;servation puisse &ecirc;tre confirm&eacute;e. Le <em>Tableau 1 - Formulaire de demande de r&eacute;servation</em> donne &agrave; la <abbr title=""Cale S&egrave;che d'Esquimalt"">CSE</abbr> les renseignements n&eacute;cessaires sur le navire et sert d'entente de r&eacute;servation formelle entre vous et la <abbr title=""Cale S&egrave;che d'Esquimalt"">CSE</abbr>. La <em>Clause d'indemnisation</em> est un document juridique qui d&eacute;gage la Couronne de toute responsabilit&eacute; en cas de blessures ou de dommages.<br /><br />Vous aurez besoin du formulaire de modification d'une r&eacute;servation si vous voulez apporte un changement apr&egrave;s avoir soumis une demande de r&eacute;servation.">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.indemnification# - #language.bookingForms# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.indemnification# - #language.bookingForms# - #language.esqGravingDock# - #language.PWGSC#</title>">
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
			<a href="#RootDir#reserve-book/formulaires-forms.cfm.cfm?lang=#lang#">#language.bookingForms#</a> &gt;
			#language.indemnification#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.indemnification#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>
					<cfoutput>
					<div class="alternate-format">
		<a href="#RootDir#formes-forms/indem-#lang#.pdf" title="#language.pdfformat#">#language.pdfversion# (6K#language.bytes#)</a><br />
		#language.helpformats#</div>

				<p>I (We), the undersigned, hereby indemnify Canada for the vessel described below, located at ___________________________ within the Esquimalt Graving Dock, for the purpose and time stated, for the period of _________________________________, 20___.</p>
				
				<ul class="noBullet">
				<li>Name of Vessel: ___________________</li>
				<li>Vessel Owner's Name: ___________________</li>
				</ul>
				
				<p>The Agent assumes and agrees to hold harmless, indemnify, protect and defend Her Majesty the Queen in right of Canada (“Her Majesty”), Her agents and employees, against any and all liability for injuries and damages to Her Majesty, the Vessel, crew, employees, agents, subcontractors, guests, third parties or otherwise, incident to or resulting from the Vessel using the facilities of Esquimalt Graving Dock, except in instances of an act or acts of negligence by Her Majesty or agents, servant of the Corporation of the Township of Esquimalt and all mutual aid partners. Damages will be deemed to include liability which is attributable to environmental impairment, or clean up expenses, including fire fighting.</p>
				
				<p>Should the Agent and the Vessel owner not be one and the same, the authorized signatory verifies
that the following clause has also been included in the contract between the Agent and the Vessel
owner:</p>

<ul class="noBullet">
<li>The Vessel owner assumes and agrees to hold harmless, indemnify, protect and defend Her Majesty the Queen in right of Canada (“Her Majesty”), Her agents and employees, against any and all injuries and damages to Her Majesty, the Vessel, crew, employees, agents, sub-contractors, guests, third parties on a contractual, tort, statutory or any other legal or equitable basis including not limited to public safety service providers, fire protection officials, police, and rescue workers, related to the Vessel using the facilities of Esquimalt Graving Dock, and resulting from an act or acts of negligence by the Vessel Owner, its agents and employees. Damages are deemed to include but not be limited to the liability which is attributable to environment impairment or clean up expenses, including fire fighting.</li>
</ul>

<p>Authorized Signature of Agent: __________________________________</p>
<p>Company Name: __________________________________</p>
<p>Signature of Witness: __________________________________</p>
<p>Date: __________________________________</p>
<p>Revised: 18/June/2002</p>

				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

