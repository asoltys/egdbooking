<div id="menu1">

	<cfquery name="readonlycheck" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT ReadOnly
		FROM Users
		WHERE UID = #Session.UID#
	</cfquery>
	<cfoutput query="readonlycheck">
		<cfset Session.ReadOnly = #ReadOnly#>
	</cfoutput>
	<cfif lang EQ 'eng'>
		<cfset language.bookingHomeButton = "Booking Home">
		<cfset language.drydockCalButton = "Drydock Calendar">
		<cfset language.jettyCalButton = "Jetties Calendar">
		<cfset language.requestBookingButton = "Request Booking">
		<cfset language.editProfileButton = "Edit Profile">
		<cfset language.help = "Help">
    <cfset language.bookingsSummary = "Bookings Summary">
		<cfset language.logoutButton = "Logout">
	<cfelse>
		<cfset language.bookingHomeButton = "Accueil - R&eacute;servation">
		<cfset language.drydockCalButton = "Calendrier de la cale s&egrave;che">
		<cfset language.jettyCalButton = "Calendrier des jet&eacute;es">
		<cfset language.requestBookingButton = "Pr&eacute;senter une r&eacute;servation">
		<cfset language.editProfileButton = "Modifier le profil">
		<cfset language.help = "Aide">
    <cfset language.bookingsSummary = "R&eacute;sum&eacute; des R&eacute;servations">
		<cfset language.logoutButton = "Fermer la session">
	</cfif>

	<cfset Variables.BookingRequestString = "">
	<cfif IsDefined("URL.VNID")>
		<cfset Variables.BookingRequestString = "&amp;VNID=#URL.VNID#">
	<cfelseif IsDefined("URL.CID")>
		<cfset Variables.BookingRequestString = "&amp;CID=#URL.CID#">
	</cfif>
	<cfif IsDefined("URL.Date") AND DateCompare(#url.date#, #PacificNow#, 'd') EQ 1>
		<cfset Variables.BookingRequestString = "#Variables.BookingRequestString#&amp;Date=#URL.Date#">
	</cfif>

	<CFSET variables.datetoken = "">
	<CFIF structKeyExists(url, 'm-m')>
		<CFSET variables.datetoken = variables.datetoken & "&amp;m-m=#url['m-m']#">
	</CFIF>
	<CFIF structKeyExists(form, 'a-y')>
		<CFSET variables.datetoken = variables.datetoken & "&amp;a-y=#url['a-y']#">
	</CFIF>


	<cffile action="read" file="#FileDir#intromsg.txt" variable="intromsg">
	<cfif #Trim(intromsg)# EQ "">
	<cfelse>
		<cfinclude template="#RootDir#includes/helperFunctions.cfm" />
		<div class="notice">
		<h2>Notice</h2>
		<cfoutput>#FormatParagraph(intromsg)#</cfoutput>
		</div>
	</cfif>

	<div>
		<cfoutput>
		<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#" class="textbutton">#language.BookingHomeButton#</a>
		<a href="#RootDir#comm/calend-cale-dock.cfm?lang=#lang##datetoken#" class="textbutton">#language.DrydockCalButton#</a>
		<a href="#RootDir#comm/calend-jet.cfm?lang=#lang##datetoken#" class="textbutton">#language.JettyCalButton#</a>
		<div>&nbsp;</div>

		<cfif #Session.ReadOnly# EQ "1"><cfelse>
		<a href="#RootDir#reserve-book/resdemande-bookrequest.cfm?lang=#lang##Variables.BookingRequestString#" class="textbutton">#language.RequestBookingButton#</a>
		</cfif>

		<a href="#RootDir#reserve-book/profilmod-profileedit.cfm?lang=#lang#" class="textbutton">#language.EditProfileButton#</a>
    <a href="#RootDir#comm/resume-summary_ch.cfm?lang=#lang#" class="textbutton">#language.bookingsSummary#</a>
		<a href="#RootDir#ols-login/fls-logout.cfm?lang=#lang#" class="textbutton">#language.LogoutButton#</a>
		</cfoutput>

	</div>

	<CFSET variables.urltoken = "lang=#lang#">
	<CFIF IsDefined('variables.startDate')>
		<CFSET variables.urltoken = variables.urltoken & "&startDate=#DateFormat(variables.startDate, 'mm/dd/yyyy')#">
	<CFELSEIF IsDefined('url.startDate')>
		<CFSET variables.urltoken = variables.urltoken & "&startDate=#DateFormat(url.startDate, 'mm/dd/yyyy')#">
	</CFIF>
	<CFIF IsDefined('variables.endDate')>
		<CFSET variables.urltoken = variables.urltoken & "&endDate=#DateFormat(variables.endDate, 'mm/dd/yyyy')#">
	<CFELSEIF IsDefined('url.endDate')>
		<CFSET variables.urltoken = variables.urltoken & "&endDate=#DateFormat(url.endDate, 'mm/dd/yyyy')#">
	</CFIF>
	<CFIF IsDefined('variables.show')>
		<CFSET variables.urltoken = variables.urltoken & "&show=#variables.show#">
	<CFELSEIF IsDefined('url.show')>
		<CFSET variables.urltoken = variables.urltoken & "&show=#url.show#">
	</CFIF>
</div>

<br />
