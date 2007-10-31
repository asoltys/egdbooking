<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/build_form_struct.cfm">

<cfif lang EQ "e">
	<cfset language.cancelBooking = "Confirm Cancel Booking">
	<cfset language.keywords = language.masterKeywords & ", Cancel Booking">
	<cfset language.description = "Allows user to cancel a booking.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.areYouSure = "Are you sure you want to cancel your booking for">
	<cfset language.from = "from">
	<cfset language.to = "to">
	<cfset language.cancelWarning = "Bookings cannot be canceled directly, the Esquimalt Graving Dock must be notified of the cancellation request.">
	<cfset language.email = "Email EGD">
	<cfset language.phone = "Phone">
	<cfset language.fax = "Fax">
	<cfset language.emailAddress = "Email">
	<cfset language.or = "or">
<cfelse>
	<cfset language.cancelBooking = "Confirmation de l'annulation de la r&eacute;servation">
	<cfset language.keywords = language.masterKeywords & ", Annulation de la r&eacute;servation">
	<cfset language.description = "Permet &agrave; l'utilisateur d'annuler une r&eacute;servation.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.areYouSure = "Êtes-vous certain de vouloir annuler votre r&eacute;servation pour ">
	<cfset language.from = "du">
	<cfset language.to = "au">
	<cfset language.cancelWarning = "">
	<cfset language.email = "Courriel">
	<cfset language.phone = "T&eacute;l&eacute;phone">
	<cfset language.fax = "Fac-simil&eacute;">
	<cfset language.emailAddress = "Adresse d courriel">
	<cfset language.or = "ou">

</cfif>

<cfoutput>
	<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.CancelBooking#"">
	<meta name=""keywords"" lang=""eng"" content=""#language.keywords#"">
	<meta name=""description"" lang=""eng"" content=""#language.description#"">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""#language.subjects#"">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.CancelBooking#</title>
	<link rel=""STYLESHEET"" type=""text/css"" href=""#RootDir#css/booking.css"">
">
</cfoutput>

<cfinclude template="#RootDir#includes/header-#lang#.cfm">

<CFPARAM name="url.referrer" default="Booking Home">
<CFIF url.referrer eq "Details For">
	<CFSET returnTo = "#RootDir#text/common/getDetail.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#text/booking/booking.cfm">
</CFIF>

<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>

<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Bookings.BookingID,
			StartDate, EndDate,
			Docks.Status AS DStatus, Jetties.Status AS JStatus,
			Vessels.Name AS VesselName,
			Vessels.CompanyID,
			Companies.Name AS CompanyName
	FROM	Bookings
			LEFT JOIN	Docks ON Bookings.BookingID = Docks.BookingID
			LEFT JOIN	Jetties ON Bookings.BookingID = Jetties.BookingID
			INNER JOIN	Vessels ON Bookings.VesselID = Vessels.vesselID
			INNER JOIN	Companies ON Vessels.CompanyID = Companies.CompanyID
	WHERE	Bookings.BookingID = #url.bookingid#
			AND Bookings.Deleted = '0'
			AND Vessels.Deleted = '0'
</cfquery>

<cfoutput>
<div class="breadcrumbs">
	<a href="http://www.pwgsc.gc.ca/text/home-#lang#.html">#language.PWGSC#</a> &gt;
	#language.PacificRegion# &gt;
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-#lang#.html">#language.EsqGravingDock#</a> &gt;
	<a href="#RootDir#text/booking-#lang#.cfm">#language.Booking#</A> &gt;
		<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
		<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">#language.Admin#</A> &gt;
	<CFELSE>
		<a href="#RootDir#text/booking/booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
	</CFIF>
	#language.CancelBooking#
</div>

<div class="main">
<H1>#language.CancelBooking#</H1>
<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
<BR><br>

<div align="left">
	#language.areYouSure# <strong>#getBooking.VesselName#</strong> #language.from# #LSDateFormat(getBooking.StartDate, 'mmm d, yyyy')# #language.to# #LSDateFormat(getBooking.endDate, 'mmm d, yyyy')#?
	  #language.cancelWarning#
</div>

<cfset emailSubject = "#getbooking.CompanyName# cancelling booking for #trim(getbooking.VesselName)# from #LSDateFormat(getbooking.StartDate, 'mmm d, yyyy')# to #LSDateFormat(getbooking.EndDate, 'mmm d, yyyy')#">
<div align="left">
	<br>#language.phone#: (250) 363-3879  #language.or#  (250) 363-8056
	<br>#language.fax#: (250) 363-8059
	<cfif ListLen(#variables.adminEmail#) EQ 1><br>#language.emailAddress#:  <a href="mailto:#Variables.AdminEmail#?subject=#emailSubject#">#Variables.AdminEmail#</a>
	<cfelse>
	<table>
		<tr><td align="left">#language.emailAddress#:</td><td><a href="mailto:#ListGetAt(variables.adminEmail, 1)#?subject=#emailSubject#">#ListGetAt(variables.adminEmail, 1)#</a></td></tr>
		<cfset variables.emailList = ListDeleteAt(#variables.adminEmail#, 1)>
		<cfloop list="#Variables.emailList#" index="email"><tr><td>&nbsp;</td><td><a href="mailto:#email#?subject=#emailSubject#">#email#</a></td></tr></cfloop>
	</table>
	</cfif>
</div>
<br>
<div align="center">
	<!---<a href="mailto:#Variables.AdminEmail#?subject=#emailSubject#" class="textbutton">#language.email#</a>--->
	<!---input type="button" onClick="self.location.href='#RootDir#text/booking/cancelBooking_action.cfm?lang=#lang#&amp;CompanyID=#getBooking.CompanyID#&amp;referrer=#URLEncodedFormat(url.referrer)#'" class="textbutton" value="#language.Continue#"--->
	<input type="button" onClick="self.location.href='#RootDir#text/common/getBookingDetail.cfm?lang=#lang#&amp;bookingID=#url.bookingID#&amp;referrer=#URLEncodedFormat(url.referrer)##variables.dateValue#';" class="textbutton" value="#language.Back#">
</div>
</div>
</cfoutput>

<cfinclude template="#RootDir#includes/footer-#lang#.cfm">