<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<cfif lang EQ "eng">
	<cfset language.requestBooking = "Request New Booking">
	<cfset language.keywords = language.masterKeywords & ", Booking Request">
	<cfset language.description = "User must choose between the two types of booking request to be made.">
	<cfset language.subjects = language.masterSubjects & "">
	<!--- <cfset language.drydockBooking = "If you would like to submit a Drydock booking request, <br />please">
	<cfset language.jettyBooking = "If you would like to submit a South Jetty / North Landing Wharf booking request, please">
	<cfset language.mainPage = "to return to the Booking Application main page"> --->
	<cfset language.choose = "Please choose the part of the dock for which you wish to request a booking:">
	<cfset language.drydockBooking = "Drydock">
	<cfset language.jettyBooking = "South Jetty / North Landing Wharf">
	<cfset language.mainPage = "return to Booking Home">
<cfelse>
	<cfset language.requestBooking = "Pr&eacute;sentation d'une nouvelle r&eacute;servation">
	<cfset language.keywords = language.masterKeywords & ", Pr&eacute;sentation de r&eacute;servation">
	<cfset language.description = "L'utilisateur doit choisir un des deux types de demande de r&eacute;servation.">
	<cfset language.subjects = language.masterSubjects & "">
	<!--- <cfset language.drydockBooking = "Si vous souhaitez pr&eacute;senter une demande de r&eacute;servation de cale s&egrave;che, veuillez ">
	<cfset language.jettyBooking = "Si vous souhaitez pr&eacute;senter une demande de r&eacute;servation de la jet&eacute;e sud ou du quai de d&eacute;barquement nord, veuillez ">
	<cfset language.mainPage = "pour retourner &agrave; la page principale de l'application des r&eacute;servations "> --->
	<cfset language.choose = "Veuillez choisir la partie de la cale s&egrave;che que vous voulez r&eacute;server :">
	<cfset language.drydockBooking = "de la cale s&egrave;che">
	<cfset language.jettyBooking = "de la jet&eacute;e sud ou du quai de d&eacute;barquement nord">
	<cfset language.mainPage = "Retour &agrave; Accueil&nbsp;- R&eacute;servation">

</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.RequestBooking#"">
	<meta name=""keywords"" lang=""eng"" content=""#language.keywords#"">
	<meta name=""description"" lang=""eng"" content=""#language.description#"">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""#language.subjects#"">
	<meta name=""dc.date.published"" content=""2005-07-25"" />
	<meta name=""dc.date.reviewed"" content=""2005-07-25"" />
	<meta name=""dc.date.modified"" content=""2005-07-25"" />
	<meta name=""dc.date.created"" content=""2005-07-25"" />
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.RequestBooking#</title>
	
">

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			#language.RequestBooking#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.RequestBooking#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
				<cfoutput>
	
				<cfset Variables.BookingRequestString = "">
				<cfif IsDefined("URL.VesselID")>
					<cfset Variables.BookingRequestString = "&VesselID=#URL.VesselID#">
				<cfelseif IsDefined("URL.CompanyID")>
					<cfset Variables.BookingRequestString = "&CompanyID=#URL.CompanyID#">
				</cfif>
				<cfif IsDefined("URL.Date")>
					<cfset Variables.BookingRequestString = "#Variables.BookingRequestString#&Date=#URL.Date#">
				</cfif>
				
				<p>#language.choose#</p>
				<UL>
					<LI><a href="#RootDir#reserve-book/caledemande-dockrequest.cfm?lang=<cfoutput>#lang##Variables.BookingRequestString#</cfoutput>">#language.drydockBooking#</a></LI>
					<LI><a href="#RootDir#reserve-book/jetdemande-jetrequest.cfm?lang=<cfoutput>#lang##Variables.BookingRequestString#</cfoutput>">#language.jettyBooking#</a></LI>
				</UL>
				<br />
				<p><a href="#RootDir#reserve-book/reserve-booking.cfm?lang=<cfoutput>#lang#</cfoutput>" class="textbutton">#language.mainPage#</a></p>
				
				</cfoutput>
			
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

