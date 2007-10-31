<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Bookings Summary"">
<meta name=""keywords"" lang=""eng"" content="""">
<meta name=""description"" lang=""eng"" content=""Allows user to view a summary of all bookings from present onward"">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Booking Summary</title>">

<cfinclude template="#RootDir#includes/header-#lang#.cfm">

<cfoutput>
	<style type="text/css" media="screen,print">@import url(#RootDir#css/events.css);</style>
</cfoutput>

	<cfset Language.SubNav1 = "Community / Fun">
	<cfset language.PageTitle = "Calendar of Events">
	<cfset language.ButtonLabel1 = "Submit a new Booking request">
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


<CFQUERY name="getDockBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT	Bookings.VesselID,
		Name AS VesselName, Anonymous,
		Length AS VesselLength,
		StartDate,
		EndDate,
		Status,
		Section1, Section2, Section3,
		BookingTime
FROM	Bookings
	INNER JOIN	Docks ON Bookings.BookingID = Docks.BookingID
	INNER JOIN	Vessels ON Bookings.VesselID = Vessels.VesselID
WHERE	EndDate >= #Now()#
	AND (Status = 'c' OR Status = 't')
	AND	Bookings.Deleted = '0'
	AND	Vessels.Deleted = '0'
ORDER BY	StartDate, VesselName
</CFQUERY>

<CFQUERY name="getJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT	Bookings.VesselID,
		Name AS VesselName, Anonymous,
		Length AS VesselLength,
		StartDate,
		EndDate,
		Confirmed,
		NorthJetty, SouthJetty,
		BookingTime
FROM	Bookings
	INNER JOIN	Jetties ON Bookings.BookingID = Jetties.BookingID
	INNER JOIN	Vessels ON Bookings.VesselID = Vessels.VesselID

WHERE	EndDate >= #Now()#
	AND	Vessels.Deleted = '0'
ORDER BY	StartDate, VesselName
</CFQUERY>

<CFQUERY name="getNJBookings" dbtype="query">
SELECT	* 
FROM	getJettyBookings
WHERE	NorthJetty = 1
</CFQUERY>

<CFQUERY name="getSJBookings" dbtype="query">
SELECT	* 
FROM	getJettyBookings
WHERE	SouthJetty = 1
</CFQUERY>

<script language="javascript" type="text/javascript">
<!--
function popUp(pageID) {
	window.open(pageID + "-e.cfm", pageID, "width=800, height=400, resizable=yes, menubar=no, scrollbars=yes, toolbar=no");
}
//-->
</script>


<div class="breadcrumbs"><a href="<cfoutput>http://www.pwgsc.gc.ca/text/home-#lang#.html</cfoutput>">PWGSC</a> &gt; Pacific Region &gt; <a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-e.html">Esquimalt Graving Dock</a> &gt; <A href="../menu.cfm?lang=#lang#">Admin</A> &gt; Bookings Summary </div>

<div class="main">

<!--div style="text-align: right; font-size: 10pt;"><a href="booking.cfm?lang=#lang#">Back</a></div-->

<H1>Bookings Summary</H1>
<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

<CFINCLUDE template="#RootDir#includes/dock_calendar_menu.cfm">

<A href="javascript:window.open('bookingsSummary-printable.cfm'); void(0);" class="textbutton">VIEW PRINTABLE VERSION</A>
<BR><BR>
<H2>Drydocks</H2>
<!-- Begin Dry Docks table -->
<TABLE class="calendar" cellpadding="0" cellspacing="0" width="100%">
	<TR>
		<TH class="calendar" style="font-size: 12px; width: 30%;">VESSEL</TH>
		<TH class="calendar" style="font-size: 12px; width: 10%;">SECTION</TH>
		<TH class="calendar" style="font-size: 12px; width: 30%;">DOCKING DATES</TH>
		<TH class="calendar" style="font-size: 12px; width: 30%;">BOOKING DATE</TH>
	</TR>
	<CFIF getDockBookings.RecordCount neq 0>
		<CFOUTPUT query="getDockBookings">
		<TR style="<CFIF Status eq 'c'>text-transform: uppercase; font-weight: bold; <CFELSE> font-style: italic;</CFIF>">
			<TD class="calendar small">#VesselLength#M <CFIF Anonymous>Deapsea Vessel<CFELSE>#VesselName#</CFIF></TD>
			<TD class="calendar small"><DIV align="center"><DIV align="center"><CFIF Status eq 'c'>
									<CFIF Section1 eq true>1</CFIF>
									<CFIF Section2 eq true>
										<CFIF Section1> &amp; </CFIF>
									2</CFIF>
									<CFIF Section3 eq true>
										<CFIF Section1 OR Section2> &amp; </CFIF>
									3</CFIF>
								<CFELSE>Tentative
								</CFIF>
								</DIV></TD>
			<TD class="calendar small">#DateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#DateFormat(StartDate, ", yyyy")#</CFIF> - #DateFormat(EndDate, "mmm d, yyyy")#</TD>
			<TD class="calendar small">#DateFormat(BookingTime, 'mmm d, yyyy')#@#TimeFormat(BookingTime, 'HH:mm')#</TD>
		</TR>
		</CFOUTPUT>
	</TABLE>
<CFELSE>
</TABLE>
<!-- End Dry Docks table -->
There are no bookings to view.
</CFIF>

<h2>North Landing Wharf</h2>
<!-- Begin North Jetty table -->
<TABLE class="calendar" cellpadding="0" cellspacing="0" width="100%">
	<TR>
		<TH class="calendar" style="font-size: 12px; width: 30%;">VESSEL</TH>
		<TH class="calendar" style="font-size: 12px; width: 10%;">SECTION</TH>
		<TH class="calendar" style="font-size: 12px; width: 30%;">DOCKING DATES</TH>
		<TH class="calendar" style="font-size: 12px; width: 30%;">BOOKING DATE</TH>
	</TR>
	<CFIF getNJBookings.RecordCount neq 0>
		<CFOUTPUT query="getNJBookings">
		<TR style="<CFIF Confirmed>text-transform: uppercase; font-weight: bold; <CFELSE> font-style: italic;</CFIF>">
			<TD class="calendar small">#VesselLength#M <CFIF Anonymous eq true>Deapsea Vessel<CFELSE>#VesselName#</CFIF></TD>
			<TD class="calendar small"><DIV align="center"><CFIF Confirmed>Booked
										<CFELSE>Pending
										</CFIF></DIV></TD>
			<TD class="calendar small">#DateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#DateFormat(StartDate, ", yyyy")#</CFIF> - #DateFormat(EndDate, "mmm d, yyyy")#</TD>
			<TD class="calendar small">#DateFormat(BookingTime, 'mmm d, yyyy')#@#TimeFormat(BookingTime, 'HH:mm')#</TD>
		</TR>
		</CFOUTPUT>
	</TABLE>
<CFELSE>
</TABLE>
<!-- End North Jetty table //-->
There are no bookings to view.
</CFIF>

<h2>South Jetty</h2>
<!-- Begin South Jetty table //-->
<TABLE class="calendar" cellpadding="0" cellspacing="0" width="100%">
	<TR>
		<TH class="calendar" style="font-size: 12px; width: 30%;">VESSEL</TH>
		<TH class="calendar" style="font-size: 12px; width: 10%;">SECTION</TH>
		<TH class="calendar" style="font-size: 12px; width: 30%;">DOCKING DATES</TH>
		<TH class="calendar" style="font-size: 12px; width: 30%;">BOOKING DATE</TH>
	</TR>	
	<CFIF getSJBookings.RecordCount neq 0>
		<CFOUTPUT query="getSJBookings">
		<TR style="<CFIF Confirmed>text-transform: uppercase; font-weight: bold; <CFELSE> font-style: italic;</CFIF>">
			<TD class="calendar small">#VesselLength#M <CFIF Anonymous eq true>Deapsea Vessel<CFELSE>#VesselName#</CFIF></TD>
			<TD class="calendar small"><DIV align="center"><CFIF Confirmed>Booked
										<CFELSE>Pending
										</CFIF></DIV></TD>
			<TD class="calendar small">#DateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#DateFormat(StartDate, ", yyyy")#</CFIF> - #DateFormat(EndDate, "mmm d, yyyy")#</TD>
			<TD class="calendar small">#DateFormat(BookingTime, 'mmm d, yyyy')#@#TimeFormat(BookingTime, 'HH:mm')#</TD>
		</TR>
		</CFOUTPUT>
	</TABLE>
<!-- End South Jetty table -->
<CFELSE>
</TABLE>
There are no bookings to view.
</CFIF>
<BR><BR>

</div>

</div>

<!--- <cfinclude template="#RootDir#includes/footer-#lang#.cfm"> --->