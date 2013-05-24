<cfif lang EQ "eng">
	<cfset language.bookingDetail = "Booking Details">
	<cfset language.description = "Retrieves information for all bookings on a given day.">
	<cfset language.detailsFor = "Details for">
	<cfset language.drydockBookings = "Drydock Bookings">
	<cfset language.dates = "Dates">
	<cfset language.MaintenanceBlock = "Maintenance Block">
	<cfset language.closedForMaint = "The following docks are closed for maintenance and are not available for booking.">
	<cfset language.JettyBookings = "Jetty Bookings">
	<cfset language.noBookings = "There are no bookings for this date range.">
	<cfset language.sectionsBooked = "Sections Booked">
	<cfset language.dockingDates = "Docking Dates">
	<cfset language.to = "to">
	<cfset language.drydock1 = "Section 1">
	<cfset language.drydock2 = "Section 2">
	<cfset language.drydock3 = "Section 3">
	<cfset language.deepsea = "Deepsea Vessel">
<cfelse>
	<cfset language.bookingDetail = "D&eacute;tails&nbsp;- R&eacute;servation">
	<cfset language.description = "R&eacute;cup&eacute;ration de renseignements sur toutes les r&eacute;servations d'une journ&eacute;e donn&eacute;e.">
	<cfset language.detailsFor = "D&eacute;tails pour">
	<cfset language.drydockBookings = "R&eacute;servations de cale s&egrave;che">
	<cfset language.dates = "Dates">
	<cfset language.MaintenanceBlock = "P&eacute;riode de maintenance">
	<cfset language.closedForMaint = "Les &eacute;l&eacute;ments suivants sont ferm&eacute;s aux fins de maintenance et ne peuvent pas &ecirc;tre r&eacute;serv&eacute;s.">
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
</cfif>

<cfquery name="vessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
  SELECT DISTINCT Vessels.VNID
  FROM Vessels 
    INNER JOIN UserCompanies ON UserCompanies.CID = Vessels.CID
    INNER JOIN Users ON UserCompanies.UID = <cfqueryparam value="#Session.UID#" cfsqltype="cf_sql_integer" /> 
    WHERE UserCompanies.Approved = 1 
    AND Users.Deleted = 0 
    AND UserCompanies.Deleted = 0
</cfquery>

<cfoutput>

<cfsavecontent variable="head">
	<meta name="dcterms.title" content="#language.detailsFor# #myDateFormat(URL.date, request.longdatemask)# - #language.PWGSC# - #language.esqGravingDock# -  #language.bookingDetail#" />
	<meta name="keywords" content="#Language.masterKeywords#, #language.bookingDetail#" />
	<meta name="description" content="#language.description#" />
	<meta name="dcterms.description" content="#language.description#" />
	<meta name="dcterms.subject" title="gccore" content="#Language.masterSubjects#" />
	<title>#language.detailsFor# #myDateFormat(URL.date, request.longdatemask)# - #language.PWGSC# - #language.esqGravingDock# -  #language.bookingDetail#</title>
</cfsavecontent>
<cfhtmlhead text="#head#">

<cfset request.title = language.DetailsFor & " " & myDateFormat(URL.date, request.longdatemask) />
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFPARAM name="url.referrer" default="#language.bookingHome#">
<cfif url.referrer eq "detail">
	<CFSET returnTo = "#RootDir#comm/detail.cfm">
<cfelse>
	<CFSET returnTo = "#RootDir#reserve-book/reserve-booking.cfm">
</cfif>
<cfif not IsDefined('URL.Date') or URL.Date eq ''>
	<cflocation addtoken="no" url="#RootDir#comm/calend-cale-dock.cfm?lang=#lang#">
</cfif>

				<h1 id="wb-cont">#language.DetailsFor# #myDateFormat(URL.date, request.longdatemask)#</h1>

				<cfif IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
					<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				<cfelse>
					<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
				</cfif>

				<cfquery name="getDockDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	Bookings.BRID, Bookings.EndHighlight,
						StartDate, EndDate,
						Status,
						Section1, Section2, Section3,
						Vessels.Name AS VesselName, Vessels.VNID, Anonymous,
						BookingTime, Users.FirstName, Users.LastName
					FROM	Bookings
						INNER JOIN	Vessels ON Bookings.VNID = Vessels.VNID
						INNER JOIN	Docks ON Bookings.BRID = Docks.BRID
						INNER JOIN	Users ON Bookings.UID = Users.UID
					WHERE	Bookings.StartDate <= <cfqueryparam value="#URL.Date#" cfsqltype="cf_sql_date" />
						AND	Bookings.EndDate >= <cfqueryparam value="#URL.Date#" cfsqltype="cf_sql_date" />
						AND Bookings.Deleted = '0'
						AND Vessels.Deleted = '0'
					orDER BY	Status, startdate, enddate, vessels.name
				</cfquery>

				<cfquery name="getJettyDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	Bookings.BRID, Bookings.EndHighlight,
						StartDate, EndDate,
						Status,
						NorthJetty, SouthJetty,
						Vessels.Name AS VesselName, Vessels.VNID, Anonymous,
						BookingTime, Users.FirstName, Users.LastName
					FROM	Bookings
						INNER JOIN	Vessels ON Bookings.VNID = Vessels.VNID
						INNER JOIN	Jetties ON Bookings.BRID = Jetties.BRID
						INNER JOIN	Users ON Bookings.UID = Users.UID
					WHERE	Bookings.StartDate <= <cfqueryparam value="#URL.Date#" cfsqltype="cf_sql_date" />
						AND	Bookings.EndDate >= <cfqueryparam value="#URL.Date#" cfsqltype="cf_sql_date" />
						AND Bookings.Deleted = '0'
						AND Vessels.Deleted = '0'
					orDER BY	Status, startdate, enddate, vessels.name
				</cfquery>

				<cfquery name="getDockMaintenanceDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	Status,
						StartDate, EndDate,
						Section1, Section2, Section3
					FROM	Bookings
						INNER JOIN	Docks ON Bookings.BRID = Docks.BRID
					WHERE	Bookings.StartDate <= <cfqueryparam value="#URL.Date#" cfsqltype="cf_sql_date" />
						AND	Bookings.EndDate >= <cfqueryparam value="#URL.Date#" cfsqltype="cf_sql_date" />
						AND	Bookings.Deleted = '0'
						AND	Status = 'm'

				</cfquery>

				<cfquery name="getJettyMaintenanceDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	Status,
						StartDate, EndDate,
						NorthJetty, SouthJetty
					FROM	Bookings
						INNER JOIN	Jetties ON Bookings.BRID = Jetties.BRID
					WHERE	Bookings.StartDate <= <cfqueryparam value="#URL.Date#" cfsqltype="cf_sql_date" />
						AND	Bookings.EndDate >= <cfqueryparam value="#URL.Date#" cfsqltype="cf_sql_date" />
						AND	Bookings.Deleted = '0'
						AND	Status = 'm'

				</cfquery>

				<h2>#language.DrydockBookings#</h2>

				<cfloop query="getDockMaintenanceDetail">
				<table class="details">
					<tr>
						<th scope="row" colspan="2">#language.MaintenanceBlock#</th>
					</tr>
					<tr>
						<th scope="row" colspan="2">#language.closedForMaint#</th>
					</tr>
					<tr>
						<th scope="row" id="SectionsBooked">#language.SectionsBooked#:</th>
						<td><cfif Section1>#language.Drydock1#</cfif><cfif Section2><cfif Section1> &amp; </cfif>#language.Drydock2#</cfif><cfif Section3><cfif Section1 or Section2> &amp; </cfif>#language.Drydock3#</cfif></td>
					</tr>
					<tr>
						<th scope="row" id="Dates">#language.Dates#:</th>
						<td>#myDateFormat(StartDate, request.datemask)# #language.to# #myDateFormat(EndDate, request.datemask)#</td>
					</tr>
				</table>
				</cfloop>

				<cfloop query="getDockDetail">
				<table class="details">
					<tr id="res-book-#BRID#">
						<th scope="col" colspan="2">
							<cfif Anonymous AND not viewable(vessels, VNID) AND not IsDefined('session.AdminLoggedIn') AND Status neq 'c' >
								#language.Deepsea#
							<cfelse>
              <a href="detail-res-book.cfm?lang=#lang#&amp;BRID=#BRID#&amp;date=#url.date#&amp;referrer=detail" title="#language.booking# ###BRID#: #VesselName#">#language.booking# ###BRID#: #VesselName#</a>
							</cfif>
						</th>
					</tr>
					<cfif not Anonymous or viewable(vessels, VNID) or IsDefined('session.AdminLoggedIn')>
					<tr>
						<th scope="row">#language.Agent#:</th>
						<td>#LastName#, #FirstName#</td>
					</tr>
					</cfif>
					<tr>
						<th scope="row">#language.Status#:</th>
						<td>
							<cfif Status eq 'c'>
                #language.Confirmed#
							<cfelseIF Status eq 't'>
                #language.Tentative#
							<cfelse>
                #language.Pending#
							</cfif>
						</td>
					</tr>
					<cfif Status eq 'c'>
						<tr>
							<th scope="row">#language.SectionsBooked#:</th>
              <td>
                <cfif Section1>#language.Drydock1#</cfif>
                <cfif Section2>#language.Drydock2#</cfif>
                <cfif Section3>#language.Drydock3#</cfif>
              </td>
						</tr>
					</cfif>
					<tr>
						<th scope="row">#language.DockingDates#:</th>
						<td>#myDateFormat(StartDate, request.datemask)# #language.to# #myDateFormat(EndDate, request.datemask)#</td>
					</tr>
				</table>
				</cfloop>
        <cfif getDockDetail.RecordCount eq 0 AND getDockMaintenanceDetail.RecordCount eq 0><p>#language.noBookings#</p></cfif>
        <p><a href="#RootDir#comm/calend-cale-dock.cfm?lang=#lang#">#language.drydockCalendar#</a></p>

				<h2>#language.JettyBookings#</h2>
				<cfloop query="getJettyMaintenanceDetail">
          <table class="details">
            <tr>
              <th scope="col" colspan="2">#language.MaintenanceBlock#</th>
            </tr>
            <tr>
              <th scope="col" colspan="2">#language.closedForMaint#</th>
            </tr>
            <tr>
              <th scope="row">#language.SectionsBooked#:</th>
              <td><cfif NorthJetty>#language.NorthLandingWharf#</cfif><cfif SouthJetty><cfif NorthJetty> &amp; </cfif>#language.SouthJetty#</cfif></td>
            </tr>
            <tr>
              <th scope="row">#language.Dates#:</th>
            </tr>
          </table>
				</cfloop>

				<cfloop query="getJettyDetail">
				<cflock timeout="20" throwontimeout="no" type="READONLY" scope="SESSION">
					<cfquery name="jUserVessel#BRID#" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT	Vessels.VNID
						FROM	Users INNER JOIN UserCompanies ON Users.UID = UserCompanies.UID
								INNER JOIN Vessels ON UserCompanies.CID = Vessels.CID
						WHERE	Users.UID = <cfqueryparam value="#Session.UID#" cfsqltype="cf_sql_integer" /> AND Vessels.VNID = <cfqueryparam value="#VNID#" cfsqltype="cf_sql_integer" />
							AND UserCompanies.Approved = 1 AND UserCompanies.Deleted = 0
					</cfquery>
				</cflock>

				<cfset Variables.count = "jUserVessel" & #BRID# & ".recordCount">
				<cfset "#Variables.count#" = evaluate(count)>

				<table class="details">
					<tr id="res-book-#BRID#">
						<th scope="col" colspan="2">
							<cfif Anonymous AND not viewable(vessels, VNID) AND not IsDefined('session.AdminLoggedIn') AND Status neq 'c'>
								#language.Deepsea#
							<cfelse>
              <a href="detail-res-book.cfm?lang=#lang#&amp;BRID=#BRID#&amp;date=#url.date#&amp;referrer=detail" title="#language.booking# ###BRID#: #VesselName#">#language.booking# ###BRID#: #VesselName#</a>
							</cfif>
						</th>
					</tr>
					<cfif not Anonymous or viewable(vessels, VNID) or IsDefined('session.AdminLoggedIn')>
					<tr>
						<th scope="row">#language.Agent#:</th>
						<td>#LastName#, #FirstName#</td>
					</tr>
					</cfif>
					<tr>
						<th scope="row">#language.Status#:</th>
						<td>
							<cfif Status eq 'c'>
								#language.Confirmed#
							<cfelseIF Status eq 't'>
                #language.Tentative#
							<cfelse>
                #language.Pending#
							</cfif>
						</td>
					</tr>
					<cfif Status eq 'c'>
						<tr>
							<th scope="row">#language.SectionsBooked#:</th>
							<td>
                <cfif NorthJetty>#language.NorthLandingWharf#</cfif>
                <cfif SouthJetty>#language.SouthJetty#</cfif>
              </td>
						</tr>
					</cfif>
					<tr>
						<th scope="row">#language.DockingDates#:</th>
						<td>#myDateFormat(StartDate, request.datemask)# #language.to# #myDateFormat(EndDate, request.datemask)#</td>
					</tr>
				</table>


				</cfloop>
        <cfif getJettyDetail.RecordCount eq 0 AND getJettyMaintenanceDetail.RecordCount eq 0><p>#language.noBookings#</p></cfif>
        <p><a href="#RootDir#comm/calend-jet.cfm?lang=#lang#">#language.JettyCalendar#</a></p>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
</cfoutput>
