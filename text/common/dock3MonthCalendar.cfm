<cfif lang EQ "e">
	<cfset language.ScreenMessage = "There are no events available for display">
	<cfset language.drydockCalendar = "Drydock Calendar">
	<cfset language.description = "Allows user to view all bookings in the drydock in a given three-month period.">
	<cfset language.keywords = "Calendar, three month view, 3 month view, drydock side">
	<cfset language.go = "Go">
	<cfset language.viewInfo = "Click on a date to view booking information.">
	<cfset language.key = "Colour Key">
	<cfset language.bookingtype = "Booking Type">
	<cfset language.sec = "Dock Section">
	<cfset language.tentBook = "Tentative Booking">
	<cfset language.pendBook = "Pending Booking">
	<cfset language.confBook = "Confirmed Booking">
	<cfset language.sec1 = "Section 1 of Drydock">
	<cfset language.sec2 = "Section 2 of Drydock">
	<cfset language.sec3 = "Section 3 of Drydock">
	<cfset language.prev = "previous">
	<cfset language.next = "next">
<cfelse>
	<cfset language.ScreenMessage = "Il n'existe aucune activit&eacute; &agrave; afficher.">
	<cfset language.drydockCalendar = "Calendrier de la cale sèche">
	<cfset language.description = "Permet &agrave; l'utilisateur de voir toutes les r&eacute;servations concernant la cale s&egrave;che pour une p&eacute;riode donn&eacute;e de trois mois.">
	<cfset language.keywords = "Calendrier, visualisation de trois mois, visualisation de 3 mois, secteur de la cale s&egrave;che">
	<cfset language.go = "Afficher">
	<cfset language.viewInfo = "Cliquez sur une date pour voir les renseignements sur la r&eacute;servation.">
	<cfset language.key = "L&eacute;gende des couleurs">
	<cfset language.bookingtype = "Type de r&eacute;servation">
	<cfset language.sec = "Section de la cale s&egrave;che">
	<cfset language.tentBook = "R&eacute;servation provisoire">
	<cfset language.pendBook = "R&eacute;servation en traitement">
	<cfset language.confBook = "R&eacute;servation confirm&eacute;e">
	<cfset language.sec1 = "Section 1 de la cale s&egrave;che">
	<cfset language.sec2 = "Section 2 de la cale s&egrave;che">
	<cfset language.sec3 = "Section 3 de la cale s&egrave;che">
	<cfset language.prev = "pr&eacute;c&eacute;dent">
	<cfset language.next = "suivant">
</cfif>

<cfoutput>
	<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""#language.PWGSC# - #language.esqGravingDockCaps# - #language.drydockCalendar#"">
	<meta name=""keywords"" lang=""eng"" content=""#Language.masterKeywords#, #language.keywords#"">
	<meta name=""description"" lang=""eng"" content=""#language.description#"">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""#Language.masterSubjects#"">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>#language.PWGSC# - #language.esqGravingDockCaps# - #language.drydockCalendar#</title>
	<style type=""text/css"" media=""screen,print"">@import url(#RootDir#css/events.css);</style>
	">
</cfoutput>

<CFSET Variables.onLoad="setCalendar()">

<cfinclude template="#RootDir#includes/header-#lang#.cfm">

<cfoutput>
<div class="breadcrumbs">
	<a href="http://www.pwgsc.gc.ca/text/home-#lang#.html">#language.PWGSC#</a> &gt;
	#language.PacificRegion# &gt;
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-#lang#.html">#language.esqGravingDock#</a> &gt;
	<a href="#RootDir#text/booking-#lang#.cfm">#language.Booking#</A> &gt; 
		<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
		<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">#language.Admin#</A> &gt;
	<CFELSE>
		<a href="#RootDir#text/booking/booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
	</CFIF>
	#language.drydockCalendar#
</div>

<div class="main">

<H1>#language.drydockCalendar#</H1>
</cfoutput>

<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
	<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
<CFELSE>
	<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
</CFIF>

<CFINCLUDE template="#RootDir#includes/dock_calendar_menu.cfm"><br>

<div id="eventmain">

<CFINCLUDE template="includes/calendar_variables.cfm">
<cfset firstdayofbunch = CreateDate(url.year, url.month, 1)>
<cfset ahead3months= DateAdd('m', 3, firstdayofbunch)>
<cfset lastdayofbunch = CreateDate(year(ahead3months), month(ahead3months), daysinmonth(ahead3months))>
<cfquery name="GetEvents" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Status,
		StartDate, EndDate,
		Section1, Section2, Section3,
		Vessels.Name AS VesselName, Vessels.VesselID,
		Vessels.Anonymous
	FROM	Bookings
		INNER JOIN	Docks ON Bookings.BookingID = Docks.BookingID
		INNER JOIN	Vessels ON Bookings.VesselID = Vessels.VesselID
	WHERE	StartDate <= #lastdayofbunch#
		AND EndDate >= #firstdayofbunch#
		AND	Bookings.Deleted = '0'
		AND	Vessels.Deleted = '0'

	UNION

	SELECT	Status,
		StartDate, EndDate,
		Section1, Section2, Section3,
		'o' AS dummy1, '0' AS dummy2,
		'0' AS dummy3
	FROM	Bookings
		INNER JOIN	Docks ON Bookings.BookingID = Docks.BookingID
	WHERE	StartDate <= #lastdayofbunch#
		AND EndDate >= #firstdayofbunch#
		AND	Bookings.Deleted = '0'
		AND	Status = 'm'
</cfquery>

<cfoutput>#language.viewInfo#</cfoutput><br>

<CFSET pos="top">
<CFINCLUDE template="includes/dock_key.cfm">

<CFIF url.month eq 1>
	<CFSET prevmonth = 12>
	<CFSET prevyear = url.year - 1>
<CFELSE>
	<CFSET prevmonth = url.month - 1>
	<CFSET prevyear = url.year>
</CFIF>

<CFIF url.month eq 12>
	<CFSET nextmonth = 1>
	<CFSET nextyear = url.year + 1>
<CFELSE>
	<CFSET nextmonth = url.month + 1>
	<CFSET nextyear = url.year>
</CFIF>


<cfoutput>
<table width="100%">
	<tr>
		<td align="left" width="23%"><a href="dock3MonthCalendar.cfm?lang=#lang#&amp;month=#prevmonth#&amp;year=#prevyear#">#language.prev#</a></td>
		<td align="center">
			<form id="selection" name="selection" action="" style="margin: 0; padding:0; ">
				<select name="selMonth">
					<CFLOOP index="i" from="1" to="12">
						<cfoutput><option value="#i#">#LSDateFormat(CreateDate(2005, i, 1), 'mmmm')#</option></cfoutput>
					</CFLOOP>
				</select>
				<select name="selYear">
					<CFLOOP index="i" from="-5" to="25">
						<CFOUTPUT><option>#DateFormat(DateAdd('yyyy', i, PacificNow), 'yyyy')#</option></CFOUTPUT>
					</CFLOOP>
				</select>
					<a href="javascript:go('dock3MonthCalendar')" class="textbutton"><cfoutput>#language.Go#</cfoutput></a>
			</form>
			<CFINCLUDE template="#RootDir#includes/calendar_js.cfm">
		</td>
		<td align="right" width="23%"><a href="dock3MonthCalendar.cfm?lang=#lang#&amp;month=#nextmonth#&amp;year=#nextyear#">#language.next#</a></td>
	</tr>
</table>
</cfoutput>


<!---div class="EventAdd"><a href="bookingRequest.cfm" class="textbutton"><cfoutput>#language.ButtonLabel1#</cfoutput></a></div><br>
<div class="EventAdd"><a href="jettyRequest.cfm" class="textbutton"><cfoutput>#language.ButtonLabel3#</cfoutput></a></div><br>
<div class="EventAdd"><A href="bookingRequest_choose.cfm" class="textbutton"><cfoutput>Submit New Booking Request</cfoutput></A></div--->

<!--- MEGA TABLE BEGINS HERE --->

<cfloop from="0" to="2" index="i">
	<cfif i neq 0>
		<cfif url.month neq 12>
			<cfset url.month = url.month+1>
		<cfelse>
			<cfset url.month = 1>
			<cfset url.year = url.year+1>
		</cfif>
	</cfif>

	<cfinclude template="includes/calendar_core.cfm">

	<!---div class="EventAdd"><a href="bookingRequest.cfm" class="textbutton"><cfoutput>#language.ButtonLabel1#</cfoutput></a></div><br>
	<div class="EventAdd"><a href="jettyRequest.cfm" class="textbutton"><cfoutput>#language.ButtonLabel3#</cfoutput></a></div><br>
	<div class="EventAdd"><A href="bookingRequest_choose.cfm" class="textbutton"><cfoutput>Submit New Booking Request</cfoutput></A></div--->

</cfloop>

<cfoutput>
<table width="100%">
	<tr>
		<td align="left"><a href="dock3MonthCalendar.cfm?lang=#lang#&amp;month=#prevmonth#&amp;year=#prevyear#">#language.prev#</a></td>
		<td align="right"><a href="dock3MonthCalendar.cfm?lang=#lang#&amp;month=#nextmonth#&amp;year=#nextyear#">#language.next#</a></td>
	</tr>
</table>
</cfoutput>


<CFSET pos="bottom">
<CFINCLUDE template="includes/dock_key.cfm">

</div>

</div>

<cfinclude template="#RootDir#includes/footer-#lang#.cfm">