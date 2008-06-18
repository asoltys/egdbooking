<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Booking Calendar"">
<meta name=""keywords"" lang=""eng"" content=""Calendar, three month view, 3 month view, jetty side"">
<meta name=""description"" lang=""eng"" content=""Allows user to view all bookings in the jetties in a given three-month period."">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Booking Calendar</title>">

<CFSET Variables.onLoad="setCalendar()">

<cfinclude template="#RootDir#ssi/tete-header-#lang#.cfm">

<cfoutput>
	<style type="text/css" media="screen,print">@import url(#RootDir#css/events.css);</style>
</cfoutput>
	<cfset Language.SubNav1 = "Community / Fun">
	<cfset language.PageTitle = "Calendar of Events">
	<cfset language.ButtonLabel1 = "Submit new Drydock Booking request">
	<cfset language.ButtonLabel3 = "Submit new South Jetty / North Landing Wharf Booking request">
	<cfset language.Label1 = "Starting Date:">
	<cfset language.Label2 = "Ending Date:">
	<cfset language.Label3 = "Description:">
	<cfset language.ButtonLabel2 = "Details">
	<cfset language.ScreenMessage = "There are no events available for display">
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

<div class="breadcrumbs"><a href="<cfoutput>http://www.pwgsc.gc.ca/text/home-#lang#.html</cfoutput>">PWGSC</a> &gt; Pacific Region &gt; <a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-e.html">Esquimalt Graving Dock</a> &gt; <A href="../menu.cfm?lang=#lang#">Admin</A> &gt; North Landing Wharf/South Jetty Calendar</div>

<div class="main">

<!--div style="text-align: right; font-size: 10pt;"><a href="booking.cfm?lang=#lang#">Back</a></div-->

<H1>Calendar</H1>
<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

<CFINCLUDE template="#RootDir#includes/jetty_calendar_menu.cfm">

<div id="eventmain">

<CFINCLUDE template="#RootDir#text/booking/includes/calendar_variables.cfm">
<cfset firstdayofbunch = CreateDate(url.year, url.month, 1)>
<cfset ahead3months= DateAdd('m', 3, firstdayofbunch)>
<cfset lastdayofbunch = CreateDate(year(ahead3months), month(ahead3months), daysinmonth(ahead3months))>
<cfquery name="GetEvents" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Status,
		StartDate, EndDate,
		NorthJetty AS Section1, SouthJetty AS Section2, '0' AS Section3,
		Vessels.Name AS VesselName,
		Vessels.Anonymous
	FROM	Bookings
		INNER JOIN	Jetties ON Bookings.BookingID = Jetties.BookingID
		INNER JOIN	Vessels ON Bookings.VesselID = Vessels.VesselID
	WHERE	StartDate <= #lastdayofbunch#
		AND EndDate >= #firstdayofbunch#
		AND	Bookings.Deleted = '0'
		AND	Vessels.Deleted = '0'
		
	UNION
	
	SELECT	Status,
		StartDate, EndDate,
		NorthJetty AS Section1, SouthJetty AS Section2, '0' AS Section3,
		'o' AS dummy1,
		'0' AS dummy2
	FROM	Bookings
		INNER JOIN	Jetties ON Bookings.BookingID = Jetties.BookingID
	WHERE	StartDate <= #lastdayofbunch#
		AND EndDate >= #firstdayofbunch#
		AND	Bookings.Deleted = '0'
		AND	Status = 'm'
</cfquery>

<SCRIPT language="javascript">
//function to refresh the calendar if users select a month or a year
function go() {
	formObj = document.selection;
	var yearIndex = formObj.selYear.selectedIndex;
	var monthIndex = formObj.selMonth.selectedIndex;
	var year = formObj.selYear.options[yearIndex].text;
	var month = formObj.selMonth.options[monthIndex].value;
	window.location = "threemonthCalendar.cfm?month="+ month + "&year=" + year;
}

//populate the calendar based on the url query string
function setCalendar() {

    formObj = document.selection;
	//set the month 
	for (var j = 0; j < formObj.selMonth.length; j++) {	  
	   if (formObj.selMonth.options[j].value == <cfoutput>#url.month#</cfoutput>) {
	       formObj.selMonth.options.selectedIndex = j;
	   }
	}
	//set the year
    for (var i = 0; i < formObj.selYear.length; i++) {
	   if (formObj.selYear.options[i].text == <cfoutput>#url.year#</cfoutput>) {
	         formObj.selYear.options.selectedIndex = i;
	   }
	}
}
</SCRIPT>

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
			<td><a href ="javascript:go('jetty3MonthCalendar')" class="textbutton">Go</a></td>
		</tr>
	</table>
</form>

<CFINCLUDE template="#RootDir#includes/calendar_js.cfm">

<p><cfoutput>#language.ScreenMessage#</cfoutput></p>

<!---div class="EventAdd"><a href="bookingRequest.cfm" class="textbutton"><cfoutput>#language.ButtonLabel1#</cfoutput></a></div><br>
<div class="EventAdd"><a href="jettyRequest.cfm" class="textbutton"><cfoutput>#language.ButtonLabel3#</cfoutput></a></div><br>
<div class="EventAdd"><A href="bookingRequest_choose.cfm" class="textbutton"><cfoutput>Submit New Booking Request</cfoutput></A></div--->

<!--- MEGA TABLE BEGINS HERE --->

<CFLOOP from="0" to="2" index="i">
	<cfif i neq 0>
		<cfif url.month neq 12>
			<cfset url.month = url.month+1>
		<cfelse>
			<cfset url.month = 1>
			<cfset url.year = url.year+1>
		</cfif>
	</cfif>
	
	<CFINCLUDE template="#RootDir#text/booking/includes/calendar_core.cfm">
	
	<!---div class="EventAdd"><a href="bookingRequest.cfm" class="textbutton"><cfoutput>#language.ButtonLabel1#</cfoutput></a></div><br>
	<div class="EventAdd"><a href="jettyRequest.cfm" class="textbutton"><cfoutput>#language.ButtonLabel3#</cfoutput></a></div><br>
	<div class="EventAdd"><A href="bookingRequest_choose.cfm" class="textbutton"><cfoutput>Submit New Booking Request</cfoutput></A></div--->

</CFLOOP>

<br><br>

<table class="keytable" cellspacing="0" align="center" cellpadding="2" style="width: 300px">
<tr align="center"><td style="border-bottom: 1px solid #cccccc;" colspan="2">Colour Key</td></tr>
<tr><td class="pending" style="border-right: 1px solid #cccccc;" width="50%">Pending Booking</td><td class="sec1">North Landing Wharf</td></tr>
<tr><td class="confirmed" style="border-right: 1px solid #cccccc;">Confirmed Booking</td><td class="sec2">South Jetty</td></tr>
<!--tr><td style="border-right: 1px solid #cccccc;">&nbsp;</td><td class="njetty">North Jetty</td></tr>
<tr><td style="border-right: 1px solid #cccccc;">&nbsp;</td><td class="sjetty">South Jetty</td></tr-->
</table>

<br><br>

</div>

</div>

<!--- <cfinclude template="#RootDir#ssi/foot-pied-#lang#.cfm"> --->