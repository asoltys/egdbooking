<cfinclude template="#RootDir#includes/bookingInfoVariables.cfm">
<cfif lang EQ "e">
	<cfset language.bookingForms = "Booking Forms">
	<cfset language.keywords = language.masterKeywords & ", Booking Forms">
	<cfset language.description = "Contains informaiton on available forms.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.form = "Form">
	<cfset language.schedule = "Schedule 1">
	<cfset language.indemnification = "Indemnification Clause">
	<cfset language.changeForm = "Tentative Vessel and Change Booking Form">
	<cfset language.acrobatrequired = 'The following files may require <A href="http://www.adobe.com/products/acrobat/readstep2_allversions.html" target="_blank">Adobe Acrobat Reader</A> to be installed.  The links will open in a new window.'>
	<cfset language.formExplanation = "The following forms(in PDF format) are used in booking the drydock.<br><br><i>Schedule 1</i> and the <i>Indemnification Clause</i> are required to confirm a booking.  The <i>Schedule 1 - Drydock Application Form</i> provides EGD with vessel details and acts as a formal booking agreement between you and the Esquimalt Graving Dock.  The <i>Indemnification Clause</i> is a legal disclaimer that indemnifies the Crown against liability for injuries or damages.<br><br>The <i>Tentative Vessel and Change Booking Form</i> is required if you wish to make any changes after submitting a request for booking.">
<cfelse>
	<cfset language.bookingForms = "Formulaires de r&eacute;servation">
	<cfset language.keywords = language.masterKeywords & ",  Formulaire de r&eacute;servation">
	<cfset language.description = "Contient de l'information sur les formulaires offerts.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.form = "Formulaire">
	<cfset language.schedule = "Tableau 1">
	<cfset language.indemnification = "Clause d'indemnit&eacute;">
	<cfset language.changeForm = "Formulaire de r&eacute;servation provisoire pour les navires et les modifications">
	<cfset language.acrobatrequired = 'Vous pourriez avoir besoin d''<A href="http://www.adobe.com/products/acrobat/readstep2_allversions.html" target="_blank">Adobe Acrobat Reader</A> pour les fichiers suivants. Les liens ouvriront une nouvelle fenêtre.'>	
	<cfset language.formExplanation = "Les formulaires suivants (en format PDF) servent aux réservations de la cale sèche. <br><br>Le <em>Tableau 1</em> et la <em>Clause d'indemnisation</em> doivent être soumis pour que la réservation puisse être confirmée. Le <em>Tableau 1 - Formulaire de demande de réservation</em> donne à la CSE les renseignements nécessaires sur le navire et sert d'entente de réservation formelle entre vous et la CSE. La <em>Clause d'indemnisation</em> est un document juridique qui dégage la Couronne de toute responsabilité en cas de blessures ou de dommages.<br><br>Vous aurez besoin du formulaire de modification d'une réservation si vous voulez apporte un changement après avoir soumis une demande de réservation.">

</cfif>

<cfoutput>
	<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.bookingForms#"">
	<meta name=""keywords"" lang=""eng"" content=""#language.keywords#"">
	<meta name=""description"" lang=""eng"" content=""#language.description#"">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""#language.subjects#"">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.bookingForms#</title>">
	<cfinclude template="#RootDir#includes/header-#lang#.cfm">

	<div class="breadcrumbs">
		<a href="http://www.pwgsc.gc.ca/text/home-#lang#.html">#language.PWGSC#</a> &gt;
		#language.PacificRegion# &gt;
		<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-#lang#.html">#language.EsqGravingDock#</a> &gt;
	  <CFOUTPUT>
			<a href="#RootDir#text/booking-#lang#.cfm">#language.Booking#</A> &gt;
		<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
		<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">#language.Admin#</A> &gt;
	<CFELSE>
		<a href="#RootDir#text/booking/booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
	</CFIF>
	  </CFOUTPUT>
		#language.bookingForms#
	</div>

	<div class="main">
	<H1>#language.bookingForms#</H1>
	<CFINCLUDE template="#RootDir#includes/user_menu.cfm">

	<br>
	<p>#language.formExplanation#</p>
	
	<p>#language.acrobatrequired#</p>

	&nbsp;&nbsp;<a href="../forms/DockBookingApplication.pdf" target="pdf" title="#language.schedule#">#language.schedule# (#LSDateFormat(CreateDate(2004, 7, 14), 'long')#) [PDF 55.8 KB]</a><br>
	&nbsp;&nbsp;<a href="../forms/indemnificationClause.pdf" target="pdf" title="#language.Indemnification#">#language.Indemnification# (#LSDateFormat(CreateDate(2002, 6, 18), 'long')#) [PDF 5.58 KB]</a><br>
	&nbsp;&nbsp;<a href="../forms/Tentative_ChangeForm.pdf" target="pdf" title="#language.changeForm#">#language.changeForm# [PDF 5.51 KB]</a>
<br>
	&nbsp;&nbsp;<a href="./viewFeesForm.cfm?<cfoutput>lang=#lang#</cfoutput>" title="Tariff of Dock Charges">Tariff of Dock Charges [HTML]</a>
	<br>

	</div>
</cfoutput>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">