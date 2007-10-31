<!doctype HTML public "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html lang="en">

<head>
<!--- 	<meta name="dc.title" lang="eng" content="PWGSC - ESQUIMALT GRAVING DOCK - Welcome">
	<meta name="keywords" lang="eng" content="Ship Repair, Boats, Ship Maintenance, Dry dock, drydock, marine, iso14001, iso-14001">
	<meta name="description" lang="eng" content="The Esquimalt Graving Dock, or EGD, is proud to be federally owned, operated, and maintained. EGD is the largest solid-bottom commercial drydock on the West Coast of the Americas. We are located in an ice free harbour on Vancouver Island near gateways to Alaska and the Pacific Rim.">
	<meta name="dc.subject" scheme="gccore" lang="eng" content="Ship; Wharf; Dock; Boat">
	<meta name="dc.date.created" lang="eng" content="2002-11-29">
	<meta name="dc.date.modified" content="<!--#config timefmt='%Y-%m-%d'--><!--#echo var='LAST_MODIFIED'-->">
	<meta name="dc.date.published" content="2002-12-30">
	<meta name="dc.date.reviewed" content="2004-07-27">
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Booking</title> --->
	<!--INTERNET TEMPLATE VERSION 2.1-->
	
	<!--METADATA PROFILE START-->
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<meta name="MSSmartTagsPreventParsing" content="True">
	<link rel="schema.dc" href="http://purl.org/dc/elements/1.1">
	<meta name="dc.language" scheme="IS0639-2" content="eng">
	<meta name="dc.creator" lang="eng" content="Government of Canada, Public Works and Government Services Canada, Esquimalt Graving Dock">
	<meta name="dc.publisher" lang="eng" content="Public Works and Government Services Canada">
	<meta name="pwgsc.contact.email" content="egd@pwgsc.gc.ca">
	<meta name="dc.rights" lang="eng" content="<cfoutput>http://www.pwgsc.gc.ca/text/home-#lang#.html</cfoutput>/text/generic/copyright-e.html">
	<meta name="robots" content="noindex,nofollow">

	<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Bookings Summary"">
	<meta name=""keywords"" lang=""eng"" content="""">
	<meta name=""description"" lang=""eng"" content=""Allows user to view a summary of all bookings from present onward."">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">

	<meta name="pwgsc.date.retention" content="">
	<!-- leave blank -->
	<meta name="dc.contributor" lang="eng" content="">
	<meta name="dc.identifier" lang="eng" content="">
	<meta name="dc.audience" lang="eng" content="">
	<meta name="dc.type" lang="eng" content="">
	<meta name="dc.format" lang="eng" content="">
	<meta name="dc.coverage" lang="eng" content="">
	<!--METADATA PROFILE END-->
	
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Bookings Summary</title>
</head>
<body>

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
		BookingTime,
		Vessels.Deleted
FROM	Bookings
	INNER JOIN	Docks ON Bookings.BookingID = Docks.BookingID
	INNER JOIN	Vessels ON Bookings.VesselID = Vessels.VesselID
WHERE	EndDate >= #Now()#
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
	AND	Bookings.Deleted = '0'
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


<H1>Bookings Summary</H1>

<H2>Dry Docks</H2>
<CFIF getDockBookings.RecordCount neq 0>
<!-- Begin Dry Dock table -->
<TABLE width="90%" border="1" cellpadding="2">
	<TR bgcolor="#EEEEEE">
		<TH style="width: 30%;">VESSEL</TH>
		<TH style="width: 10%;">SECTION</TH>
		<TH style="width: 30%;">DOCKING DATES</TH>
		<TH style="width: 30%;">BOOKING DATE</TH>
	</TR>
	<CFOUTPUT query="getDockBookings">
	<TR style="<CFIF Status eq 'c'>text-transform: uppercase; font-weight: bold; <CFELSE> font-style: italic;</CFIF>">
		<TD>#VesselLength#M <CFIF Anonymous>Deapsea Vessel<CFELSE>#VesselName#</CFIF></TD>
		<TD><DIV align="center"><DIV align="center"><CFIF Status eq 'c'>
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
		<TD>#DateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)></CFIF> - #DateFormat(EndDate, "mmm d, yyyy")#</TD>
		<TD>#DateFormat(BookingTime, 'mmm d, yyyy')#@#TimeFormat(BookingTime, 'HH:mm')#</TD>
	</TR>
	</CFOUTPUT>
</TABLE>
<CFELSE>
There are no bookings to view.
</CFIF>

<h2>North Landing Wharf</h2>
<!-- Begin North Jetty table -->
<TABLE width="90%" border="1" cellpadding="2">
	<TR bgcolor="#EEEEEE">
		<TH style="width: 30%;">VESSEL</TH>
		<TH style="width: 10%;">SECTION</TH>
		<TH style="width: 30%;">DOCKING DATES</TH>
		<TH style="width: 30%;">BOOKING DATE</TH>
	</TR>
	<CFIF getNJBookings.RecordCount neq 0>
		<CFOUTPUT query="getNJBookings">
		<TR style="<CFIF Confirmed>text-transform: uppercase; font-weight: bold; <CFELSE> font-style: italic;</CFIF>">
			<TD>#VesselLength#M <CFIF Anonymous eq true>Deapsea Vessel<CFELSE>#VesselName#</CFIF></TD>
			<TD><DIV align="center"><CFIF Confirmed>Booked
										<CFELSE>Pending
										</CFIF></DIV></TD>
			<TD>#DateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)></CFIF> - #DateFormat(EndDate, "mmm d, yyyy")#</TD>
			<TD>#DateFormat(BookingTime, 'mmm d, yyyy')#@#TimeFormat(BookingTime, 'HH:mm')#</TD>
		</TR>
		</CFOUTPUT>
	</TABLE>
<CFELSE>
</TABLE>
<!-- End North Jetty table -->
There are no bookings to view.
</CFIF>

<h2>South Jetty</h2>
<!-- Begin South Jetty table -->
<TABLE width="90%" border="1" cellpadding="2">
	<TR bgcolor="#EEEEEE">
		<TH style="width: 30%;">VESSEL</TH>
		<TH style="width: 10%;">SECTION</TH>
		<TH style="width: 30%;">DOCKING DATES</TH>
		<TH style="width: 30%;">BOOKING DATE</TH>
	</TR>	
	<CFIF getSJBookings.RecordCount neq 0>
		<CFOUTPUT query="getSJBookings">
		<TR style="<CFIF Confirmed>text-transform: uppercase; font-weight: bold; <CFELSE> font-style: italic;</CFIF>">
			<TD>#VesselLength#M <CFIF Anonymous eq true>Deapsea Vessel<CFELSE>#VesselName#</CFIF></TD>
			<TD><DIV align="center"><CFIF Confirmed>Booked
										<CFELSE>Pending
										</CFIF></DIV></TD>
			<TD>#DateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)></CFIF> - #DateFormat(EndDate, "mmm d, yyyy")#</TD>
			<TD>#DateFormat(BookingTime, 'mmm d, yyyy')#@#TimeFormat(BookingTime, 'HH:mm')#</TD>
		</TR>
		</CFOUTPUT>
	</TABLE>
<!-- End South Jetty table -->
<CFELSE>
</TABLE>
There are no bookings to view.
</CFIF>


</H1>

</div>

</body>
</HTML>

<!--- <cfinclude template="#RootDir#includes/footer-#lang#.cfm"> --->