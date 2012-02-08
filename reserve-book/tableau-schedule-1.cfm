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
	<meta name=""dc.title"" content=""#language.schedule# - #language.bookingForms# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.schedule# - #language.bookingForms# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			</CFIF>
			<a href="#RootDir#reserve-book/formulaires-forms.cfm?lang=#lang#">#language.bookingForms#</a> &gt;
			#language.schedule#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.schedule#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>
					<cfoutput>
					<div class="alternate-format">
		<a href="#RootDir#formes-forms/tableau-schedule-1-#lang#.pdf" title="#language.pdfformat#">#language.pdfversion# (56K#language.bytes#)</a><br />
		#language.helpformats#</div>

				<h2>Application for the use of Esquimalt Graving Dock, Public Works and Government Services Canada, Victoria, British Columbia</h2>
				<p>I (We), the undersigned, hereby make application for use of the facilities within the Esquimalt Graving Dock as indicated below:</p>
				
				<ul class="noBullet double-space">
				<li>Dates of Dry-dock: ___________________</li>
				<li>Purpose of Dry-dock: ___________________</li>
				<li>Dates of Berthage (<acronym title="North Landing Wharf">NLW</acronym>): ___________________</li>
				<li>Purpose of Berthage: ___________________</li>
				<li>Master's Name: ___________________</li>
				<li>Agent's Name: ___________________</li>
				<li>Dockmaster's Name: ___________________</li>
				<li>Length, Overall: ___________________</li>
				<li>Breadth, Extreme: ___________________</li>
				<li>Draft, Aft: ___________________</li>
				<li>Engines: Steam/Gasoline/Oil ___________________</li>
				<li>Keel: Bar/Flat <em>(If bar, state depth)</em> ___________________</li>
				<li>If there any explosive matter on board describe: ___________________</li>
				<li>Name of Vessel: ___________________</li>
				<li>Owner's Name: ___________________</li>
				<li>Port of Registry: ___________________</li>
				<li>Owner's Address: ___________________</li>
				<li>Master's Address: ___________________</li>
				<li>Agent's Address: ___________________</li>
				<li>Gross Tonnage: ___________________</li>
				<li>Length between Perpendiculars: ___________________</li>
				<li>Draft, Forward: ___________________</li>
				<li>Type of Vessel <em>(screw, sailing, not self-propelled, etc.)</em>: ___________________</li>
				<li>Fuel Type: ___________________</li>
				<li>Rise of Floor Amidships: ___________________</li>
				</ul>
				
				<p>Is this vessel carrying or did carry any flammable material or dangerous cargo? If so, describe materials below and attach a copy of the gas free certificate supplied from a marine chemist. _________________________________________________________________</p>
				
				<p>Is there any oil escaping from the vessel? <em>(If so, to what extent?)</em> ________________________________________________</p>

<p>Special features of ship, such as the length of "cut up" forward and aft, camber of keel, if any, and underwater form <em>(State if "usual"; if "unusual", give particulars)</em> _________________________________________________________________</p>
<p>Do you require additional length on the North Landing Wharf other than for the vessel described above? If so, give details below: _________________________________________________________________</p>
<p>International Ship Security Certificate Number (Mandatory): __________________________________</p>
<p>International Maritime Organization Number (Mandatory): __________________________________</p>
<p>Specify any cargo, equipment etc. that relates to the vessel described above, that requires storage within the Esquimalt Graving Dock facility. This should include the description as to how much space will be required, weight and period (dates) of storage:</p>
<ul class="noBullet">
				<li><strong>Date(s) of Storage:</strong> ___________________</li>
				<li><strong>Space Required:</strong> ___________________</li>
				<li><strong>Weight:</strong> ___________________</li>
				<li><strong>Description as to how space will be used:</strong> ___________________</li>
				</ul>
<p><strong>Vessels visiting this facility for more than eight (8) hours are to attach the following documentation with this application: Post Docking Survey, Vessel Fire Control Plans, Vessel Drawings, and the Vessel Crew List. These documents are to be given to Risk Management at the Esquimalt Graving Dock. The documents will be kept in the Incident Command Post, located in the Main Office Building of Esquimalt Graving Dock.</strong></p>
<p>I (We), the undersigned, hereby agree to comply with the <em>Esquimalt Graving Dock Regulations, 1989</em>, and all other applicable Acts and regulations, including, but not limited to, the applicable provisions under the <em>Safe Working Practices Regulations</em> and the <em>Tackle Regulations</em> under the <em>Canada Shipping Act</em>, the <em>Industrial Health and Safety Regulations</em> of the <em>Workers' Compensation Act</em> of British Columbia, the <em>Fisheries Act</em> and the <em>Canadian Environmental Protection Act</em>.</p>
<p>(1) (<em>Signature of Agent</em>) _________________________</p>
<p>Date _______________, 20____</p>
<p>(2) (<em>Signature of Witness</em>) _________________________</p>
<p>Date _______________, 20____</p>

<h3>Special Billing Instructions</h3>
<p>Company Name: __________________________________</p>
<p>G.S.T. Exempt Number: __________________________________</p>
<p>Mailing Address: __________________________________</p>
<p>Contact Name &amp; Telephone Number: __________________________________</p>
<p>Revised: 14 July, 2004<br />SOR/95-462, s. 8.</p>

				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

