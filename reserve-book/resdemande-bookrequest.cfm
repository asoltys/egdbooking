<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<cfif lang EQ "eng">
	<cfset language.keywords = language.masterKeywords & ", Booking Request">
	<cfset language.description = "User must choose between the two types of booking request to be made.">
	<cfset language.subjects = language.masterSubjects>
	<cfset language.choose = "Please choose the part of the dock for which you wish to request a booking:">
	<cfset language.drydockBooking = "Drydock">
	<cfset language.jettyBooking = "South Jetty / North Landing Wharf">
<cfelse>
	<cfset language.keywords = language.masterKeywords & ", Pr&eacute;sentation de r&eacute;servation">
	<cfset language.description = "L'utilisateur doit choisir un des deux types de demande de r&eacute;servation.">
	<cfset language.subjects = language.masterSubjects>
	<cfset language.choose = "Veuillez choisir la partie de la cale s&egrave;che que vous voulez r&eacute;server :">
	<cfset language.drydockBooking = "de la cale s&egrave;che">
	<cfset language.jettyBooking = "de la jet&eacute;e sud ou du quai de d&eacute;barquement nord">
</cfif>

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""#language.RequestBooking# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dcterms.subject"" content=""#language.subjects#"" />
	<title>#language.RequestBooking# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfset request.title = language.requestBooking />
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfoutput>
				<h1>#language.RequestBooking#</h1>

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">


        <cfset Variables.BookingRequestString = "">
        <cfif IsDefined("URL.VNID")>
        <cfset Variables.BookingRequestString = "&amp;VNID=#URL.VNID#">
        <cfelseif IsDefined("URL.CID")>
        <cfset Variables.BookingRequestString = "&amp;CID=#URL.CID#">
        </cfif>
        <cfif IsDefined("URL.Date")>
        <cfset Variables.BookingRequestString = "#Variables.BookingRequestString#&amp;Date=#URL.Date#">
        </cfif>

        <p>#language.choose#</p>
        <ul>
          <li><a href="#RootDir#reserve-book/caledemande-dockrequest.cfm?lang=#lang##Variables.BookingRequestString#">#language.drydockBooking#</a></li>
          <li><a href="#RootDir#reserve-book/jetdemande-jetrequest.cfm?lang=#lang##Variables.BookingRequestString#">#language.jettyBooking#</a></li>
        </ul>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
</cfoutput>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

