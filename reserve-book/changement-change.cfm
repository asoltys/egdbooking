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
	<meta name=""dc.title"" content=""#language.changeForm# - #language.bookingForms# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.changeForm# - #language.bookingForms# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			</CFIF>
			<a href="#RootDir#reserve-book/formulaires-forms.cfm?lang=#lang#">#language.bookingForms#</a> &gt;
			#language.changeForm#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.changeForm#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>
					<cfoutput>
					<div class="alternate-format">
		<a href="#RootDir#formes-forms/changement-change-#lang#.pdf" title="#language.pdfformat#">#language.pdfversion# (6K#language.bytes#)</a><br />
		#language.helpformats#</div>

				<p><strong>This section to be completed by booking agent/company</strong></p>
				
				<h2>Part I - Tentative Booking</h2>
				<ol class="decimal">
				<li>Name of Vessel (required): _____________________________</li>
				<li>International Ship Security Certificate Number (Mandatory): _____________________________</li>
				<li>International Maritime Organization Number (Mandatory): _____________________________</li>
				<li>Weight of Vessel: _____________________________</li>
				<li>Length of Vessel: _____________________________</li>
				<li>Berthage @ <acronym title="North Landing Wharf">NLW</acronym> date(s): _____________________________</li>
				<li>Drydock date(s): _____________________________</li>
				<li>Other: _____________________________</li>
				<li>Remarks: _____________________________</li>
				</ol>
				
				<h2>Part II - Amendments to Drydock/Berthage</h2>
				<ol class="decimal">
				<li>Name of Vessel (required): _____________________________</li>
				<li>Date of Original Drydock: _____________________________</li>
				<li>Drydock amended date(s): _____________________________</li>
				<li>Date of Original Berthage: _____________________________</li>
				<li>Berthage @ <acronym title="North Landing Wharf">NLW</acronym> amended date(s): _____________________________</li>
				<li>Remarks: _____________________________</li>
				</ol>
				
				<h2>Part III - Contact Information</h2>
				<ol class="decimal">
				<li>Name of Booking Agent/Company: _____________________________</li>
				<li>Contact Name: _____________________________</li>
				<li>Date: _____________________________</li>
				<li>Telephone number: _____________________________</li>
				<li>Fax number: _____________________________</li>
				</ol>
				
				<p>Fax this form to <acronym title="Esquimalt Graving Dock">EGD</abbr> at <strong>(250) 363-8059<br />
				<acronym title="Esquimalt Graving Dock">EGD</abbr> will confirm receipt by faxing back to the number listed above</strong></p>
				
				<hr />
				
				<p>This section to be completed by <strong><acronym title="Esquimalt Graving Dock">EGD</abbr> Operatons Center</strong></p>
				
				<ul class="noBullet">
				<li>Received by: _____________________________</li>
				<li>Date Rec'd: _____________________________</li>
				<li>Comments to Booking Agent/Company: __________________________________________________________</li>
				<li><strong>Date</strong> form faxed back to Booking Agent/Company: ____________________</li>
				</ul>
				
				<p><strong>Note: To Confirm a Vessel, Schedule 1 Application and Idemnification Clause, must be received with the Booking fee at the <acronym title="Esquimalt Graving Dock">EGD</abbr> Operations Center.</strong></p>
				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

