<cfif isDefined("form.todate")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfif lang EQ "e">
	<cfset language.bookingsSummary = "Bookings Summary">
	<cfset language.description = "Allows user to view a summary of all bookings from present onward.">
	<cfset language.vesselCaps = "VESSEL">
	<cfset language.dockingCaps = "DOCKING DATES">
	<cfset language.bookingDateCaps = "BOOKING DATE">
	<cfset language.sectionCaps = "SECTION">
	<cfset language.deepsea = "Deepsea Vessel">
	<cfset language.noBookings = "There are no bookings to view.">
	<cfset language.booked = "Booked">
	<cfset language.printable = "VIEW PRINTABLE VERSION">
	<cfset language.legend = "Legend">
<cfelse>
	<cfset language.bookingsSummary = "R&eacute;sum&eacute; des r&eacute;servations">
	<cfset language.description = "Permet &agrave; l'utilisateur de voir un r&eacute;sum&eacute; de toutes les r&eacute;servations, depuis le moment pr&eacute;sent.">
	<cfset language.vesselCaps = "NAVIRE">
	<cfset language.dockingCaps = "DATES D'AMARRAGE">
	<cfset language.bookingDateCaps = "DATE DE LA R&Eacute;SERVATION">
	<cfset language.sectionCaps = "SECTION">
	<cfset language.deepsea = "Navire oc&eacute;anique">
	<cfset language.noBookings = "Il n'existe aucune r&eacute;servation &agrave; afficher.">
	<cfset language.booked = "R&eacute;serv&eacute;">
	<cfset language.printable = "VOIR LA VERSION IMPRIMABLE">
	<cfset language.legend = "Légende">
</cfif>


<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""#language.PWGSC# - #language.esqGravingDockCaps# - #language.BookingsSummary#"">
<meta name=""keywords"" lang=""eng"" content=""#Language.masterKeywords#"">
<meta name=""description"" lang=""eng"" content=""#language.description#"">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""#Language.masterSubjects#"">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>#language.PWGSC# - #language.esqGravingDockCaps# - #language.BookingsSummary#</title>
<style type=""text/css"" media=""screen,print"">@import url(#RootDir#css/events.css);</style>
">

<cfinclude template="#RootDir#includes/header-#lang#.cfm">

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

<CFIF IsDefined('form.startDate')>
	<CFSET Variables.CalStartDate = form.startDate>
</CFIF>

<CFIF IsDefined('form.endDate')>
	<CFSET Variables.CalENdDate = form.endDate>
</CFIF>

<CFPARAM name="CalStartDate" default="">
<CFPARAM name="CalEndDate" default="">

<CFQUERY name="getDockBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT	Bookings.EndHighlight,
		Bookings.VesselID,
		Vessels.Name AS VesselName, Anonymous,
		Length AS VesselLength,
		Abbreviation, Companies.Name AS CompanyName, Companies.CompanyID,
		StartDate, EndDate,
		Status,
		Section1, Section2, Section3,
		BookingTime
FROM	Bookings
	INNER JOIN	Docks ON Bookings.BookingID = Docks.BookingID
	INNER JOIN	Vessels ON Bookings.VesselID = Vessels.VesselID
	INNER JOIN	Companies ON Vessels.CompanyID = Companies.CompanyID
WHERE	<!--- (Status = 'c' OR Status = 't')
	AND --->	Bookings.Deleted = '0'
	AND	Vessels.Deleted = '0'
	<CFIF IsDefined('CalStartDate') and CalStartDate neq ''>AND EndDate >= '#CalStartDate#'</CFIF>
	<CFIF IsDefined('CalEndDate') and CalEndDate neq ''>AND StartDate <= '#CalEndDate#'</CFIF>
	
ORDER BY	StartDate, VesselName
</CFQUERY>

<CFQUERY name="getJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT	Bookings.EndHighlight,
		Bookings.VesselID,
		Vessels.Name AS VesselName, Anonymous,
		Length AS VesselLength,
		Abbreviation, Companies.Name AS CompanyName, Companies.CompanyID,
		StartDate, EndDate,
		Status,
		NorthJetty, SouthJetty,
		BookingTime
FROM	Bookings
	INNER JOIN	Jetties ON Bookings.BookingID = Jetties.BookingID
		INNER JOIN	Vessels ON Bookings.VesselID = Vessels.VesselID
		INNER JOIN	Companies ON Vessels.CompanyID = Companies.CompanyID

WHERE	Bookings.Deleted = '0'
	AND	Vessels.Deleted = '0'
	<CFIF IsDefined('CalStartDate') and CalStartDate neq ''>AND EndDate >= '#CalStartDate#'</CFIF>
	<CFIF IsDefined('CalEndDate') and CalEndDate neq ''>AND StartDate <= '#CalEndDate#'</CFIF>

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

<CFQUERY name="getCompanies" dbtype="query">
	SELECT Abbreviation, CompanyName
	FROM getDockBookings
	UNION
	SELECT Abbreviation, CompanyName
	FROM getJettyBookings
	
	ORDER BY CompanyName
</CFQUERY>

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
	#language.BookingsSummary#
</div>
</cfoutput>

<div class="main">

<!--div style="text-align: right; font-size: 10pt;"><a href="booking.cfm?lang=#lang#">Back</a></div-->

<H1><cfoutput>#language.BookingsSummary#</cfoutput></H1>

<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
	<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
<CFELSE>
	<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
</CFIF>

<CFINCLUDE template="#RootDir#includes/dock_calendar_menu.cfm"><br>

<CFOUTPUT><A href="bookingsSummary-printable.cfm?lang=#lang#&fromDate=#CalStartDate#&toDate=#CalEndDate#" class="textbutton" target="Bookings_Summary_printable">#language.PRINTABLE#</A></CFOUTPUT>
<BR>
<H2><cfoutput>#language.Drydock#</cfoutput></H2>

<!-- Begin Dry Docks table -->
<TABLE class="calendar" cellpadding="0" cellspacing="0" width="100%">
	<cfoutput>
	<TR>
		<TH id="vessel" class="calendar small" style="width: 30%;">#language.VESSELCaps#</TH>
		<TH id="section" class="calendar small" style="width: 10%;">#language.SECTIONCaps#</TH>
		<TH id="docking" class="calendar small" style="width: 30%;">#language.DOCKINGCaps#</TH>
		<TH id="booking" class="calendar small" style="width: 30%;">#language.BOOKINGDATECaps#</TH>
	</TR>
	</cfoutput>
	<CFIF getDockBookings.RecordCount neq 0>
		<CFOUTPUT query="getDockBookings">
			<!---check if ship belongs to user's company--->
			<cflock timeout="20" throwontimeout="no" type="READONLY" scope="SESSION">
				<cfquery name="userVessel#vesselID#" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	Vessels.VesselID
					FROM	Users INNER JOIN UserCompanies ON Users.UserID = UserCompanies.UserID
							INNER JOIN Vessels ON UserCompanies.CompanyID = Vessels.CompanyID
					WHERE	Users.UserID = #Session.UserID# AND VesselID = #VesselID#
						AND UserCompanies.Approved = 1 AND Users.Deleted = 0 AND UserCompanies.Deleted = 0
				</cfquery>
			</cflock>
			
			<cfset blah = Evaluate("userVessel" & #vesselID#)>
			
			<cfset Variables.countQName = "userVessel" & #vesselID# & ".recordCount">
			<cfset Variables.count = EVALUATE(countQName)>

		<TR style="<CFIF Status eq 'c'>text-transform: uppercase; font-weight: bold; <CFELSE> font-style: italic;</CFIF>">
			<TD headers="vessel" class="calendar small"><cfif #EndHighlight# GTE PacificNow>* </cfif><ABBR title="#CompanyName#">#Abbreviation#</ABBR> #VesselLength#M 
				<CFIF Anonymous 
					AND (NOT IsDefined('Session.AdminLoggedIn') OR NOT Session.AdminLoggedIn) 
					AND Variables.count eq 0 
					AND Status neq 'c'>#language.deepsea#<CFELSE>#VesselName#</CFIF></TD>
			<TD headers="section" class="calendar small"><DIV align="center">
								<CFIF Status eq 'c'>
									<CFIF Section1 eq true>1</CFIF>
									<CFIF Section2 eq true>
										<CFIF Section1> &amp; </CFIF>
									2</CFIF>
									<CFIF Section3 eq true>
										<CFIF Section1 OR Section2> &amp; </CFIF>
									3
								</CFIF>
								<CFELSE>
									<CFIF Status eq 't'>
										#language.Tentative#
									<CFELSE> #language.Pending#
									</CFIF>
								</CFIF>
								</DIV></TD>
			<TD headers="docking" class="calendar small">#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</CFIF> - #LSDateFormat(EndDate, "mmm d, yyyy")#</TD>
			<TD headers="booking" class="calendar small">#LSDateFormat(BookingTime, 'mmm d, yyyy')#@#LSTimeFormat(BookingTime, 'HH:mm')#</TD>
		</TR>
		</CFOUTPUT>
	</TABLE>
<CFELSE>
</TABLE>
<!-- End Dry Docks table -->
<cfoutput>#language.noBookings#</cfoutput>
</CFIF>

<h2><cfoutput>#language.NorthLandingWharf#</cfoutput></h2>
<!-- Begin North Jetty table -->
<TABLE class="calendar" cellpadding="0" cellspacing="0" width="100%"	>
	<cfoutput>
	<TR>
		<TH id="vessel2" class="calendar small" style="width: 30%;">#language.VESSELCaps#</TH>
		<TH id="section2" class="calendar small" style="width: 10%;">#language.SECTIONCaps#</TH>
		<TH id="docking2" class="calendar small" style="width: 30%;">#language.DOCKINGCaps#</TH>
		<TH id="booking2" class="calendar small" style="width: 30%;">#language.BOOKINGDATECaps#</TH>
	</TR>
	</cfoutput>
	<CFIF getNJBookings.RecordCount neq 0>
		<CFOUTPUT query="getNJBookings">
			<!---check if ship belongs to user's company--->
			<cflock timeout="20" throwontimeout="no" type="READONLY" scope="SESSION">
				<cfquery name="userVessel#vesselID#" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	Vessels.VesselID
					FROM	Users INNER JOIN UserCompanies ON Users.UserID = UserCompanies.UserID
							INNER JOIN Vessels ON UserCompanies.CompanyID = Vessels.CompanyID
					WHERE	Users.UserID = #Session.UserID# AND VesselID = #VesselID#
						AND UserCompanies.Approved = 1 AND Users.Deleted = 0 AND UserCompanies.Deleted = 0
				</cfquery>
			</cflock>
			
			<cfset blah = Evaluate("userVessel" & #vesselID#)>
			
			<cfset Variables.countQName = "userVessel" & #vesselID# & ".recordCount">
			<cfset Variables.count = EVALUATE(countQName)>

		<TR style="<CFIF Status eq 'c'>text-transform: uppercase; font-weight: bold; <CFELSE> font-style: italic;</CFIF>">
			<TD headers="vessel2" class="calendar small"><cfif #EndHighlight# GTE PacificNow>* </cfif><ABBR title="#CompanyName#">#Abbreviation#</ABBR> #VesselLength#M 
				<CFIF Anonymous 
					AND (NOT IsDefined('Session.AdminLoggedIn') OR NOT Session.AdminLoggedIn) 
					AND Variables.count eq 0 
					AND Status neq 'c'>#language.deepsea#<CFELSE>#VesselName#</CFIF></TD>
			<TD headers="section2" class="calendar small"><DIV align="center"><CFIF Status eq 'c'>#language.Booked#
										<cfelseif Status eq 't'>#language.Tentative#
										<CFELSE>#language.Pending#
										</CFIF></DIV></TD>
			<TD headers="docking2" class="calendar small">#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</CFIF> - #LSDateFormat(EndDate, "mmm d, yyyy")#</TD>
			<TD headers="booking2" class="calendar small">#LSDateFormat(BookingTime, 'mmm d, yyyy')#@#LSTimeFormat(BookingTime, 'HH:mm')#</TD>
		</TR>
		</CFOUTPUT>
	</TABLE>
<CFELSE>
</TABLE>
<!-- End North Jetty table //-->
<cfoutput>#language.noBookings#</cfoutput>
</CFIF>

<h2><cfoutput>#language.SouthJetty#</cfoutput></h2>
<!-- Begin South Jetty table //-->
<TABLE class="calendar" cellpadding="0" cellspacing="0" width="100%">
	<cfoutput>
	<TR>
		<TH id="vessel3" class="calendar small" style="width: 30%;">#language.VESSELCaps#</TH>
		<TH id="section3" class="calendar small" style="width: 10%;">#language.SECTIONCaps#</TH>
		<TH id="docking3" class="calendar small" style="width: 30%;">#language.DOCKINGCaps#</TH>
		<TH id="booking3" class="calendar small" style="width: 30%;">#language.BOOKINGDATECaps#</TH>
	</TR>	
	</cfoutput>
	<CFIF getSJBookings.RecordCount neq 0>
		<CFOUTPUT query="getSJBookings">
			<!---check if ship belongs to user's company--->
			<cflock timeout="20" throwontimeout="no" type="READONLY" scope="SESSION">
				<cfquery name="userVessel#vesselID#" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	Vessels.VesselID
					FROM	Users INNER JOIN UserCompanies ON Users.UserID = UserCompanies.UserID
							INNER JOIN Vessels ON UserCompanies.CompanyID = Vessels.CompanyID
					WHERE	Users.UserID = #Session.UserID# AND VesselID = #VesselID#
						AND UserCompanies.Approved = 1 AND Users.Deleted = 0 AND UserCompanies.Deleted = 0
				</cfquery>
			</cflock>
			
			<cfset blah = Evaluate("userVessel" & #vesselID#)>
			
			<cfset Variables.countQName = "userVessel" & #vesselID# & ".recordCount">
			<cfset Variables.count = EVALUATE(countQName)>

		<TR style="<CFIF Status eq 'c'>text-transform: uppercase; font-weight: bold; <CFELSE> font-style: italic;</CFIF>">
			<TD headers="vessel3" class="calendar small"><cfif #EndHighlight# GTE PacificNow>* </cfif><ABBR title="#CompanyName#">#Abbreviation#</ABBR> #VesselLength#M 
				<CFIF Anonymous 
					AND (NOT IsDefined('Session.AdminLoggedIn') OR NOT Session.AdminLoggedIn) 
					AND Variables.count eq 0 
					AND Status neq 'c'>#language.deepsea#<CFELSE>#VesselName#</CFIF></TD>
			<TD headers="section3" class="calendar small"><DIV align="center"><CFIF Status eq 'c'>#language.Booked#
										<CFELSEIF Status eq 't'>#language.tentative#
										<CFELSE>#language.Pending#
										</CFIF></DIV></TD>
			<TD headers="docking3" class="calendar small">#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</CFIF> - #LSDateFormat(EndDate, "mmm d, yyyy")#</TD>
			<TD headers="booking3" class="calendar small">#LSDateFormat(BookingTime, 'mmm d, yyyy')#@#LSTimeFormat(BookingTime, 'HH:mm')#</TD>
		</TR>
		</CFOUTPUT>
	</TABLE>
<!-- End South Jetty table -->
<CFELSE>
</TABLE>
<cfoutput>#language.noBookings#</cfoutput>
</CFIF>

<BR><BR>

<!--- Legend of company abbreviations --->
<TABLE class="calendar" cellpadding="0" cellspacing="0" width="80%" align="center">
<CAPTION><cfoutput><STRONG>#language.legend#:</STRONG></cfoutput></CAPTION>
	<TR>
<CFOUTPUT query="getCompanies">
		<TD class="calendar small" width="30%">#Abbreviation# - #CompanyName#</TD>
	<CFIF CurrentRow mod 3 eq 0>
	</TR>
	<TR>
	<CFELSEIF CurrentRow eq RecordCount>
	<!--- finish off the row so the table doesn't look broken --->
	<CFLOOP index="allegro" from="1" to="#3 - (RecordCount MOD 3)#">
		<TD class="calendar small">&nbsp;</TD>
	</CFLOOP>
	</TR>
	</CFIF>
</CFOUTPUT>
</TABLE>

<BR><BR>

</div>

<cfinclude template="#RootDir#includes/footer-#lang#.cfm">