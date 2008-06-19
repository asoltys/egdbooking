<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Booking Calendar"">
<meta name=""keywords"" lang=""eng"" content=""calendar, 1 month view, one month view, drydock side"">
<meta name=""description"" lang=""eng"" content=""Allows user to view all bookings in the drydock in a given month."">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Booking Calendar</title>">

<CFSET Variables.onLoad="setCalendar()">

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfoutput>
	<style type="text/css" media="screen,print">@import url(#RootDir#css/events.css);</style>
</cfoutput>

<cfset language.PageTitle = "Booking Calendar">
<cfset language.ButtonLabel1 = "Request New Booking">
<cfset language.ScreenMessage = "Click on a date to view booking information.">
	
<!-- Start JavaScript Block -->
<!-- End JavaScript Block -->

<!--- <cfoutput>
<div class="main">
<div id="title">#language.PageTitle#</div>

<div class="subnav">
	<a href="#RootDir#community-#lang#.cfm" class="subnav">#Language.SubNav1#</a> | 
	<a href="#RootDir#app/events.cfm?lang=#lang#" class="subnav">#language.PageTitle#</a>
</div>
</cfoutput> --->


<div class="breadcrumbs"><a href="<cfoutput>http://www.pwgsc.gc.ca/text/home-#lang#.html</cfoutput>">PWGSC</a> &gt; Pacific Region &gt; <a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-e.html">Esquimalt Graving Dock</a> &gt; <A href="../menu.cfm?lang=#lang#">Admin</A> &gt; Drydock Calendar</div>

<div class="main">

<!--div style="text-align: right; font-size: 10pt;"><a href="booking.cfm?lang=#lang#">Back</a></div-->

<H1>Calendar</H1>
<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

<CFINCLUDE template="#RootDir#includes/dock_calendar_menu.cfm">

<div id="eventmain">

<CFINCLUDE template="#RootDir#text/booking/includes/calendar_variables.cfm">
<cfset firstdayofbunch = CreateDate(url.year, url.month, 1)>
<cfset lastdayofbunch = CreateDate(url.year, url.month, DaysInMonth(firstdayofbunch))>
<cfquery name="GetEvents" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Status,
		StartDate, EndDate,
		Section1, Section2, Section3,
		Vessels.Name AS VesselName,
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
		'o' AS dummy1,
		'0' AS dummy2
	FROM	Bookings
		INNER JOIN	Docks ON Bookings.BookingID = Docks.BookingID
	WHERE	StartDate <= #lastdayofbunch#
		AND EndDate >= #firstdayofbunch#
		AND	Bookings.Deleted = '0'
		AND	Status = 'm'
</cfquery>

<form id="selection" name="selection">
	<table border="0">
		<tr>
			<td>
				<select name="selMonth">
					<option value=1>January</option>
					<option value=2>February</option>
					<option value=3>March</option>
					<option value=4>April</option>
					<option value=5>May</option>
					<option value=6>June</option>
					<option value=7>July</option>
					<option value=8>August</option>
					<option value=9>September</option>
					<option value=10>October</option>
					<option value=11>November</option>
					<option value=12>December</option>
				</select>
		   </td>
		   <td>
				<select name="selYear">
					<CFLOOP index="i" from="-5" to="5">
						<option><CFOUTPUT>#DateFormat(DateAdd('yyyy', i, PacificNow), 'yyyy')#</CFOUTPUT></option>
					</CFLOOP>
				</select>
		  </td>
			<td><a href ="javascript:go('dockCalendar')" class="textbutton">Go</a></td>
		</tr>
	</table>
</form>

<CFINCLUDE template="#RootDir#includes/calendar_js.cfm">

<p><cfoutput>#Language.ScreenMessage#</cfoutput></p>

<!---div class="EventAdd"><a href="bookingRequest.cfm" class="textbutton"><cfoutput>#language.ButtonLabel1#</cfoutput></a></div><br>
<div class="EventAdd"><a href="jettyRequest.cfm" class="textbutton"><cfoutput>#language.ButtonLabel3#</cfoutput></a></div><br>
<div class="EventAdd"><A href="bookingRequest_choose.cfm" class="textbutton"><cfoutput>Submit New Booking Request</cfoutput></A></div--->

<!--- THE MEAT OF THE CALENDAR HAS BEEN MOVED --->

<CFINCLUDE template="#RootDir#text/booking/includes/calendar_core.cfm">

<cfoutput>
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

<table width="100%">
	<tr>
		<td align="left"><a href="dockCalendar.cfm?month=#prevmonth#&year=#prevyear#">previous</a></td>
		<td align="right"><a href="dockCalendar.cfm?month=#nextmonth#&year=#nextyear#">next</a></td>
	</tr>
</table>
</cfoutput>

<!---div class="EventAdd"><a href="bookingRequest.cfm" class="textbutton"><cfoutput>#language.ButtonLabel1#</cfoutput></a></div><br>
<div class="EventAdd"><a href="jettyRequest.cfm" class="textbutton"><cfoutput>#language.ButtonLabel3#</cfoutput></a></div><br>
<div class="EventAdd"><A href="bookingRequest_choose.cfm" class="textbutton"><cfoutput>Submit New Booking Request</cfoutput></A></div--->


<BR><br>

<table class="keytable" cellspacing="0" align="center" cellpadding="2" style="width: 300px">
<tr align="center"><td style="border-bottom: 1px solid #cccccc;" colspan="2">Colour Key</td></tr>
<tr><td class="pending" style="border-right: 1px solid #cccccc;" width="50%">Pending Booking</td><td class="sec1">Section 1 of Drydock</td></tr>
<tr><td class="tentative" style="border-right: 1px solid #cccccc;">Tentative Booking</td><td class="sec2">Section 2 of Drydock</td></tr>
<tr><td class="confirmed" style="border-right: 1px solid #cccccc;">Confirmed Booking</td><td class="sec3">Section 3 of Drydock</td></tr>	
<!--tr><td style="border-right: 1px solid #cccccc;">&nbsp;</td><td class="njetty">North Jetty</td></tr>
<tr><td style="border-right: 1px solid #cccccc;">&nbsp;</td><td class="sjetty">South Jetty</td></tr-->
</table>

<br><br>

</div>

</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">