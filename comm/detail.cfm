<cfinclude template="#RootDir#includes/bookingInfoVariables.cfm">
<cfinclude template="#RootDir#includes/vesselInfoVariables.cfm">
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
	<cfset language.yourbookings = "Shaded bookings below belong to your company.">
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
	<cfset language.yourbookings = "Les r&eacute;servations ombrag&eacute;es ci-dessous appartiennent &agrave; votre entreprise.">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.PWGSC# - #language.esqGravingDock# -  #language.bookingDetail#"" />
	<meta name=""keywords"" content=""#Language.masterKeywords#, #language.bookingDetail#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#Language.masterSubjects#"" />
	<title>#language.PWGSC# - #language.esqGravingDock# -  #language.bookingDetail#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFPARAM name="url.referrer" default="Booking Home">
<CFIF url.referrer eq "Details For">
	<CFSET returnTo = "#RootDir#comm/detail.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#reserve-book/reserve-booking.cfm">
</CFIF>
<CFIF NOT IsDefined('URL.Date') OR URL.Date eq ''>
	<cflocation addtoken="no" url="#RootDir#comm/calend-cale-dock.cfm?lang=#lang#">
</CFIF>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			<CFELSE>
				<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			</CFIF>
			#language.bookingDetail#</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.DetailsFor# #LSDateFormat(URL.date, "mmmm dd, yyyy")#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
					<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				<CFELSE>
					<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
				</CFIF>

				<p><cfoutput>#language.yourbookings#</cfoutput></p>

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
					ORDER BY	Status, startdate, enddate, vessels.name
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
					ORDER BY	Status, startdate, enddate, vessels.name
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

				<cfoutput><h2>#language.DrydockBookings#</h2></cfoutput>

				<cfoutput query="getDockMaintenanceDetail">
				<table class="details">
					<tr>
						<th colspan="2"><strong>#language.MaintenanceBlock#</strong></th>
					</tr>
					<tr>
						<th colspan="2">#language.closedForMaint#</th>
					</tr>
					<tr>
						<th id="SectionsBooked">#language.SectionsBooked#:</th>
						<td><CFIF Section1>#language.Drydock1#</CFIF><CFIF Section2><CFIF Section1> &amp; </CFIF>#language.Drydock2#</CFIF><CFIF Section3><CFIF Section1 OR Section2> &amp; </CFIF>#language.Drydock3#</CFIF></td>
					</tr>
					<tr>
						<th id="Dates">#language.Dates#:</th>
						<td>#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</CFIF> #language.to# #LSDateFormat(EndDate, "mmm d, yyyy")#</td>
					</tr>
				</table>
				</cfoutput>

				<cfoutput query="getDockDetail">
				<!---check if ship belongs to user's company--->
				<cflock timeout="20" throwontimeout="no" type="READONLY" scope="SESSION">
					<cfquery name="userVessel#BRID#" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT	Vessels.VNID
						FROM	Users INNER JOIN UserCompanies ON Users.UID = UserCompanies.UID
								INNER JOIN Vessels ON UserCompanies.CID = Vessels.CID
						WHERE	Users.UID = <cfqueryparam value="#Session.UID#" cfsqltype="cf_sql_integer" /> AND Vessels.VNID = <cfqueryparam value="#getDockDetail.VNID#" cfsqltype="cf_sql_integer" />
							AND UserCompanies.Approved = 1 AND Users.Deleted = 0 AND UserCompanies.Deleted = 0
					</cfquery>
				</cflock>

				<cfset Variables.countQName = "userVessel" & #BRID# & ".recordCount">
				<cfset Variables.count = EVALUATE(countQName)>

				<table class="details">
					<tr id="#BRID#">
						<th colspan="2"><CFIF Status eq 'c'><strong></cfif><cfif #EndHighlight# GTE PacificNow>* </cfif>
							<CFIF Anonymous AND #EVALUATE(Variables.count)# EQ 0 AND not IsDefined('session.AdminLoggedIn') AND Status neq 'c' >
								#language.Deepsea#
							<CFELSE>
							<a href="detail-res-book.cfm?lang=#lang#&amp;BRID=#BRID#&amp;date=#url.date#&amp;referrer=Details For" title="#language.booking# ###BRID# #VesselName#">#VesselName#</a>
							</CFIF>
							<CFIF Status eq 'c'></strong></cfif>
						</th>
					</tr>
					<CFIF NOT Anonymous OR #EVALUATE(Variables.count)# GT 0 OR IsDefined('session.AdminLoggedIn')>
					<tr>
						<th>#language.Agent#:</th>
						<td>#LastName#, #FirstName#</td>
					</tr>
					</cfif>
					<tr>
						<th>#language.Status#:</th>
						<td>
							<CFIF Status eq 'c'>
								#language.Confirmed#
							<CFELSEIF Status eq 't'>
								<i>#language.Tentative#</i>
							<CFELSE>
								<i>#language.Pending#</i>
							</CFIF>
						</td>
					</tr>
					<CFIF Status eq 'c'>
						<tr>
							<th>#language.SectionsBooked#:</th>
							<td><CFIF Section1>#language.Drydock1#</CFIF><CFIF Section2><CFIF Section1> &amp; </CFIF>#language.Drydock2#</CFIF><CFIF Section3><CFIF Section1 OR Section2> &amp; </CFIF>#language.Drydock3#</CFIF></td>
						</tr>
					</CFIF>
					<tr>
						<th>#language.DockingDates#:</th>
						<td>#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</CFIF> #language.to# #LSDateFormat(EndDate, "mmm d, yyyy")#</td>
					</tr>
				</table>
				</cfoutput>
				<cfoutput>
				<CFIF getDockDetail.RecordCount eq 0 AND getDockMaintenanceDetail.RecordCount eq 0>#language.noBookings#<br /><br /></CFIF>
				<div class="buttons"><a href="calend-cale-dock.cfm?lang=#lang#&amp;m-m=#Month(URL.date)#&amp;a-y=#Year(URL.date)#" class="textbutton">#language.drydockCalendar#</a></div>


				<h2>#language.JettyBookings#</h2>
				</cfoutput>
				<cfoutput query="getJettyMaintenanceDetail">
				<table class="details">
					<tr>
						<th colspan="2"><strong>#language.MaintenanceBlock#</strong></th>
					</tr>
					<tr>
						<th colspan="2">#language.closedForMaint#</th>
					</tr>
					<tr>
						<th>#language.SectionsBooked#:</th>
						<td><CFIF NorthJetty>#language.NorthLandingWharf#</CFIF><CFIF SouthJetty><CFIF NorthJetty> &amp; </CFIF>#language.SouthJetty#</CFIF></td>
					</tr>
					<tr>
						<th>#language.Dates#:</th>
						<td>#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</CFIF> #language.to# #LSDateFormat(EndDate, "mmm d, yyyy")#</td>
					</tr>
				</table>

				</cfoutput>
				<cfoutput query="getJettyDetail">
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
				<cfset "#Variables.count#" = EVALUATE(count)>

				<table class="details">
					<tr id="#BRID#">
						<th colspan="2">
						<CFIF Status eq 'c'><strong></cfif>
							<cfif #EndHighlight# GTE PacificNow>* </cfif>
							<CFIF Anonymous AND #EVALUATE(Variables.count)# EQ 0 AND NOT IsDefined('session.AdminLoggedIn') AND Status neq 'c'>
								#language.Deepsea#
							<CFELSE>
								 <a href="detail-res-book.cfm?lang=#lang#&amp;BRID=#BRID#&amp;date=#url.date#&amp;referrer=Details For" title="#language.booking# ###BRID# #VesselName#">#VesselName#</a>
							</CFIF>
							<CFIF Status eq 'c'></strong></cfif>
						</th>
					</tr>
					<CFIF NOT Anonymous OR #EVALUATE(Variables.count)# GT 0 OR IsDefined('session.AdminLoggedIn')>
					<tr>
						<th>#language.Agent#:</th>
						<td>#LastName#, #FirstName#</td>
					</tr>
					</cfif>
					<tr>
						<th>#language.Status#:</th>
						<td>
							<CFIF Status eq 'c'>
								#language.Confirmed#
							<CFELSEIF Status eq 't'>
								<i>#language.Tentative#</i>
							<CFELSE>
								<i>#language.Pending#</i>
							</CFIF>
						</td>
					</tr>
					<CFIF Status eq 'c'>
						<tr>
							<th>#language.SectionsBooked#:</th>
							<td><CFIF NorthJetty>#language.NorthLandingWharf#</CFIF><CFIF SouthJetty><CFIF NorthJetty>, </CFIF>#language.SouthJetty#</CFIF></td>
						</tr>
					</CFIF>
					<tr>
						<th>#language.DockingDates#:</th>
						<td>#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</CFIF> #language.to# #LSDateFormat(EndDate, "mmm d, yyyy")#</td>
					</tr>
				</table>


				</cfoutput>
				<cfoutput>
				<CFIF getJettyDetail.RecordCount eq 0 AND getJettyMaintenanceDetail.RecordCount eq 0>#language.noBookings#</CFIF>

				<div class="buttons"><a href="calend-jet.cfm?lang=#lang#&amp;m-m=#Month(URL.date)#&amp;a-y=#Year(URL.date)#" class="textbutton">#language.jettyCalendar#</a></div>
				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
