<cfinclude template="#RootDir#includes/bookingInfoVariables.cfm">
<cfinclude template="#RootDir#includes/vesselInfoVariables.cfm">
<cfif lang EQ "e">
	<cfset language.bookingDetail = "Booking Details">
	<cfset language.description = "Retrieves information for all bookings on a given day.">
	<cfset language.detailsFor = "Details for">
	<cfset language.drydockBookings = "Drydock Bookings">
	<cfset language.dates = "Dates">
	<cfset language.MaintenanceBlock = "Maintenance Block">
	<cfset language.closedForMaint = "The following docks are closed for maintenance and are not available for booking.">
	<cfset language.moreInfo = "more information on this booking">
	<cfset language.JettyBookings = "Jetty Bookings">
	<cfset language.noBookings = "There are no bookings for this date range.">
	<cfset language.sectionsBooked = "Sections Booked">
	<cfset language.dockingDates = "Docking Dates">
	<cfset language.to = "to">
	<cfset language.drydock1 = "Section 1">
	<cfset language.drydock2 = "Section 2">
	<cfset language.drydock3 = "Section 3">
	<cfset language.deepsea = "Deepsea Vessel">
	<cfset language.drydockCalButton = "Drydock Calendar">
	<cfset language.jettyCalButton = "Jetties Calendar">
	<cfset language.yourbookings = "Shaded bookings below belong to your company.">
<cfelse>
	<cfset language.bookingDetail = "D&eacute;tails&nbsp;- R&eacute;servation">
	<cfset language.description = "R&eacute;cup&eacute;ration de renseignements sur toutes les r&eacute;servations d'une journ&eacute;e donn&eacute;e.">
	<cfset language.detailsFor = "D&eacute;tails pour">
	<cfset language.drydockBookings = "R&eacute;servations de cale s&egrave;che">
	<cfset language.dates = "Dates">
	<cfset language.MaintenanceBlock = "P&eacute;riode de maintenance">
	<cfset language.closedForMaint = "Les &eacute;l&eacute;ments suivants sont ferm&eacute;s aux fins de maintenance et ne peuvent pas être r&eacute;serv&eacute;s.">
	<cfset language.moreInfo = "renseignements suppl&eacute;mentaires sur cette r&eacute;servation">
	<cfset language.JettyBookings = "R&eacute;servations de jet&eacute;e">
	<cfset language.noBookings = "Il n'existe aucune r&eacute;servation pour cette p&eacute;riode.">
	<cfset language.sectionsBooked = "Sections r&eacute;serv&eacute;es">
	<cfset language.sectionRequested = "Section demand&eacute;e">
	<cfset language.dockingDates = "Dates d'amarrage">
	<cfset language.to = "&agrave;">
	<cfset language.drydock1 = "Section 1">
	<cfset language.drydock2 = "Section 2">
	<cfset language.drydock3 = "Section 3">
	<cfset language.deepsea = "Navire oc&eacute;anique">
	<cfset language.drydockCalButton = "Calendrier de la cale sèche">
	<cfset language.jettyCalButton = "Calendrier des jetées">
	<cfset language.yourbookings = "Les r&eacute;servations ombrag&eacute;es ci-dessous appartiennent &agrave; votre entreprise.">
</cfif>

<cfoutput>
<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# -  #language.bookingDetail#"">
<meta name=""keywords"" lang=""eng"" content=""#Language.masterKeywords#, #language.bookingDetail#"">
<meta name=""description"" lang=""eng"" content=""#language.description#"">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""#Language.masterSubjects#"">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>#language.PWGSC# - #language.EsqGravingDockCaps# -  #language.bookingDetail#</title>">

<CFPARAM name="url.referrer" default="Booking Home">
<CFIF url.referrer eq "Details For">
	<CFSET returnTo = "#RootDir#text/common/getDetail.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#text/booking/booking.cfm">
</CFIF>

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
	#language.bookingDetail#
</div>

<CFIF NOT IsDefined('URL.Date') OR URL.Date eq ''>
	<cflocation addtoken="no" url="#RootDir#text/common/dockCalendar.cfm?lang=#lang#">
</CFIF>

<CFSET moonth=GetToken(URL.Date, 1, '/')>
<CFSET daay=GetToken(URL.Date, 2, '/')>
<CFSET yeaar=getToken(URL.Date, 3, '/')>

<div class="main">
<H1>#language.DetailsFor# #LSDateFormat(CreateDate(yeaar, moonth, daay), 'mmmm d, yyyy')#</H1>
</cfoutput>

<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
	<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
<CFELSE>
	<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
</CFIF>

<cfoutput><p>#language.yourbookings#</p></cfoutput>

<CFQUERY name="getDockDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Bookings.BookingID, Bookings.EndHighlight,
		StartDate, EndDate,
		Status,
		Section1, Section2, Section3,
		Vessels.Name AS VesselName, Vessels.VesselID, Anonymous,
		BookingTime, Users.FirstName, Users.LastName
	FROM	Bookings
		INNER JOIN	Vessels ON Bookings.VesselID = Vessels.vesselID
		INNER JOIN	Docks ON Bookings.BookingID = Docks.BookingID
		INNER JOIN	Users ON Bookings.userID = Users.userID
	WHERE	Bookings.StartDate <= '#URL.Date#'
		AND	Bookings.EndDate >= '#URL.Date#'
		AND Bookings.Deleted = '0'
		AND Vessels.Deleted = '0'
	ORDER BY	Status, startdate, enddate, vessels.name
</CFQUERY>

<CFQUERY name="getJettyDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Bookings.BookingID, Bookings.EndHighlight,
		StartDate, EndDate,
		Status,
		NorthJetty, SouthJetty,
		Vessels.Name AS VesselName, Vessels.VesselID, Anonymous,
		BookingTime, Users.FirstName, Users.LastName
	FROM	Bookings
		INNER JOIN	Vessels ON Bookings.VesselID = Vessels.vesselID
		INNER JOIN	Jetties ON Bookings.BookingID = Jetties.BookingID
		INNER JOIN	Users ON Bookings.userID = Users.userID
	WHERE	Bookings.StartDate <= '#URL.Date#'
		AND	Bookings.EndDate >= '#URL.Date#'
		AND Bookings.Deleted = '0'
		AND Vessels.Deleted = '0'
	ORDER BY	Status, startdate, enddate, vessels.name
</CFQUERY>

<CFQUERY name="getDockMaintenanceDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Status,
		StartDate, EndDate,
		Section1, Section2, Section3
	FROM	Bookings
		INNER JOIN	Docks ON Bookings.BookingID = Docks.BookingID
	WHERE	Bookings.StartDate <= '#URL.Date#'
		AND	Bookings.EndDate >= '#URL.Date#'
		AND	Bookings.Deleted = '0'
		AND	Status = 'm'

</CFQUERY>

<CFQUERY name="getJettyMaintenanceDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Status,
		StartDate, EndDate,
		NorthJetty, SouthJetty
	FROM	Bookings
		INNER JOIN	Jetties ON Bookings.BookingID = Jetties.BookingID
	WHERE	Bookings.StartDate <= '#URL.Date#'
		AND	Bookings.EndDate >= '#URL.Date#'
		AND	Bookings.Deleted = '0'
		AND	Status = 'm'

</CFQUERY>

<cfoutput><h2>#language.DrydockBookings#</h2></cfoutput>

<CFOUTPUT query="getDockMaintenanceDetail">
<table cellpadding="2" cellspacing="0" width="400" class="bookingDetails" align="center">
	<TR>
		<td colspan="2"><STRONG>#language.MaintenanceBlock#</STRONG></td>
	</TR>
	<TR>
		<td colspan="2">#language.closedForMaint#</td>
	</TR>
	<TR>
		<td id="SectionsBooked" width="35%">#language.SectionsBooked#:</td>
		<td headers="SectionsBooked"><CFIF Section1>#language.Drydock1#</CFIF><CFIF Section2><CFIF Section1> &amp; </CFIF>#language.Drydock2#</CFIF><CFIF Section3><CFIF Section1 OR Section2> &amp; </CFIF>#language.Drydock3#</CFIF></td>
	</TR>
	<TR>
		<td id="Dates">#language.Dates#:</td>
		<td headers="Dates">#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</CFIF> #language.to# #LSDateFormat(EndDate, "mmm d, yyyy")#</td>
	</TR>
</table>
<br>
<br>
</CFOUTPUT>

<CFOUTPUT query="getDockDetail">
<!---check if ship belongs to user's company--->
<cflock timeout="20" throwontimeout="no" type="READONLY" scope="SESSION">
	<cfquery name="userVessel#bookingID#" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Vessels.VesselID
		FROM	Users INNER JOIN UserCompanies ON Users.UserID = UserCompanies.UserID
				INNER JOIN Vessels ON UserCompanies.CompanyID = Vessels.CompanyID
		WHERE	Users.UserID = #Session.UserID# AND Vessels.VesselID = #getDockDetail.VesselID#
			AND UserCompanies.Approved = 1 AND Users.Deleted = 0 AND UserCompanies.Deleted = 0
	</cfquery>
</cflock>

<cfset Variables.countQName = "userVessel" & #bookingID# & ".recordCount">
<cfset Variables.count = EVALUATE(countQName)>

<!--- <p>countQname = #Variables.countQName#</p>
<p>variables.count = #Variables.count#</p> --->
<table cellpadding="2" cellspacing="0" width="400" class="bookingDetails" align="center"<CFIF EVALUATE(Variables.count) GT 0> bgcolor="##E0E6CF"</CFIF>>
	<TR>
		<td colspan="2" <CFIF Status eq 'c'>style="font-weight: bold;"</CFIF> ><cfif #EndHighlight# GTE PacificNow>* </cfif>
			<CFIF Anonymous AND #EVALUATE(Variables.count)# EQ 0 AND not IsDefined('session.AdminLoggedIn') AND Status neq 'c' >
				#language.Deepsea#
			<CFELSE>#VesselName#</CFIF>
		</td>
	</TR>
	<CFIF NOT Anonymous OR #EVALUATE(Variables.count)# GT 0 OR IsDefined('session.AdminLoggedIn')>
	<tr>
		<td id="Agent" width="35%">#language.Agent#:</td>
		<td headers="Agent">#LastName#, #FirstName#</td>
	</tr>
	</cfif>
	<TR>
		<td id="Status" width="35%">#language.Status#:</td>
		<CFIF Status eq 'c'>
			<td headers="Status">#language.Confirmed#</td>
		<CFELSEIF Status eq 't'>
			<td headers=""><i>#language.Tentative#</i></td>
		<CFELSE>
			<td headers=""><i>#language.Pending#</i></td>
		</CFIF>
	</TR>
	<CFIF Status eq 'c'>
		<TR>
			<td id="SectionsBooked2">#language.SectionsBooked#:</td>
			<td headers="SectionsBooked2"><CFIF Section1>#language.Drydock1#</CFIF><CFIF Section2><CFIF Section1> &amp; </CFIF>#language.Drydock2#</CFIF><CFIF Section3><CFIF Section1 OR Section2> &amp; </CFIF>#language.Drydock3#</CFIF></td>
		</TR>
	</CFIF>
	<TR>
		<td id="DockingDates">#language.DockingDates#:</td>
		<td headers="DockingDates">#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</CFIF> #language.to# #LSDateFormat(EndDate, "mmm d, yyyy")#</td>
	</TR>
</table>
<CFIF NOT Anonymous OR EVALUATE(Variables.count) GT 0 OR (IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true) OR Status eq 'c' >
	<div style="float: right; padding-right: 20px;"><a href="getBookingDetail.cfm?lang=#lang#&amp;bookingid=#BookingID#&date=#url.date#&referrer=Details%20For">#language.moreInfo#</a></div>
</cfif>
<br>
<br>
</CFOUTPUT>
<cfoutput>
<CFIF getDockDetail.RecordCount eq 0 AND getDockMaintenanceDetail.RecordCount eq 0>#language.noBookings#<br><br></CFIF>
<div align="center"><a href="dockCalendar.cfm?lang=#lang#&month=#moonth#&year=#yeaar#" class="textbutton">#language.drydockCalButton#</a></div>


<h2>#language.JettyBookings#</h2>
</cfoutput>
<CFOUTPUT query="getJettyMaintenanceDetail">
<table cellpadding="2" cellspacing="0" width="400" class="bookingDetails" align="center">
	<TR>
		<td colspan="2"><STRONG>#language.MaintenanceBlock#</STRONG></td>
	</TR>
	<TR>
		<td colspan="2">#language.closedForMaint#</td>
	</TR>
	<TR>
		<td id="SectionsBooked3" width="35%">#language.SectionsBooked#:</td>
		<td headers="SectionsBooked3"><CFIF NorthJetty>#language.NorthLandingWharf#</CFIF><CFIF SouthJetty><CFIF NorthJetty> &amp; </CFIF>#language.SouthJetty#</CFIF></td>
	</TR>
	<TR>
		<td id="Dates3">#language.Dates#:</td>
		<td headers="Dates3">#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</CFIF> #language.to# #LSDateFormat(EndDate, "mmm d, yyyy")#</td>
	</TR>
</table>
<br>
<br>
</CFOUTPUT>
<CFOUTPUT query="getJettyDetail">
<cflock timeout="20" throwontimeout="no" type="READONLY" scope="SESSION">
	<cfquery name="jUserVessel#bookingID#" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Vessels.VesselID
		FROM	Users INNER JOIN UserCompanies ON Users.UserID = UserCompanies.UserID
				INNER JOIN Vessels ON UserCompanies.CompanyID = Vessels.CompanyID
		WHERE	Users.UserID = '#Session.UserID#' AND Vessels.VesselID = '#VesselID#'
			AND UserCompanies.Approved = 1 AND UserCompanies.Deleted = 0
	</cfquery>
</cflock>

<cfset Variables.count = "jUserVessel" & #bookingID# & ".recordCount">
<cfset "#Variables.count#" = EVALUATE(count)>

<table cellpadding="2" cellspacing="0" width="400" class="bookingDetails" align="center"<CFIF EVALUATE(Variables.count) GT 0> bgcolor="##E0E6CF"</CFIF>>
	<TR>
		<td colspan="2" <CFIF Status eq 'c'>style="font-weight: bold;"</CFIF> ><cfif #EndHighlight# GTE PacificNow>* </cfif><CFIF Anonymous AND #EVALUATE(Variables.count)# EQ 0 AND NOT IsDefined('session.AdminLoggedIn') AND Status neq 'c'>
		#language.Deepsea#<CFELSE>#VesselName#</CFIF></td>
	</TR>
	<CFIF NOT Anonymous OR #EVALUATE(Variables.count)# GT 0 OR IsDefined('session.AdminLoggedIn')>
	<tr>
		<td id="Agent2" width="35%">#language.Agent#:</td>
		<td headers="Agent2">#LastName#, #FirstName#</td>
	</tr>
	</cfif>
	<TR>
		<td id="Status2" width="35%">#language.Status#:</td>
		<CFIF Status eq 'c'>
			<td headers="Status2">#language.Confirmed#</td>
		<CFELSEIF Status eq 't'>
			<td headers=""><i>#language.Tentative#</i></td>
		<CFELSE>
			<td headers="Status2"><i>#language.Pending#</i></td>
		</CFIF>
	</TR>
	<CFIF Status eq 'c'>
		<TR>
			<td id="SectionsBooked4">#language.SectionsBooked#:</td>
			<td headers="SectionsBooked4"><CFIF NorthJetty>#language.NorthLandingWharf#</CFIF><CFIF SouthJetty><CFIF NorthJetty>, </CFIF>#language.SouthJetty#</CFIF></td>
		</TR>
	</CFIF>
	<TR>
		<td id="DockingDates4">#language.DockingDates#:</td>
		<td headers="DockingDates4">#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</CFIF> #language.to# #LSDateFormat(EndDate, "mmm d, yyyy")#</td>
	</TR>
</table>
<CFIF NOT Anonymous OR #EVALUATE(Variables.count)# GT 0 OR (IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true) OR Status eq 'c'><div style="float: right; padding-right: 20px;"><a href="getBookingDetail.cfm?lang=#lang#&amp;bookingid=#BookingID#&date=#url.date#&referrer=Details%20For">#language.moreInfo#</a></div></cfif>
<br>
<br>
</CFOUTPUT>
<cfoutput>
<CFIF getJettyDetail.RecordCount eq 0 AND getJettyMaintenanceDetail.RecordCount eq 0>#language.noBookings#<br><br></CFIF>

<div align="center"><a href="jettyCalendar.cfm?lang=#lang#&month=#moonth#&year=#yeaar#" class="textbutton">#language.jettyCalButton#</a></div><DIV style="height:0;">&nbsp;</DIV>
</cfoutput>
</div>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">
