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
	<cfset language.closedForMaint = "Les &eacute;l&eacute;ments suivants sont ferm&eacute;s aux fins de maintenance et ne peuvent pas &ecirc;tre r&eacute;serv&eacute;s.">
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
	<cfset language.drydockCalButton = "Calendrier de la cale s&egrave;che">
	<cfset language.jettyCalButton = "Calendrier des jet&eacute;es">
	<cfset language.yourbookings = "Les r&eacute;servations ombrag&eacute;es ci-dessous appartiennent &agrave; votre entreprise.">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# -  #language.bookingDetail#"" />
	<meta name=""keywords"" content=""#Language.masterKeywords#, #language.bookingDetail#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#Language.masterSubjects#"" />
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# -  #language.bookingDetail#</title>">
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

<CFSET moonth=GetToken(URL.Date, 1, '/')>
<CFSET daay=GetToken(URL.Date, 2, '/')>
<CFSET yeaar=getToken(URL.Date, 3, '/')>


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
					<cfoutput>#language.DetailsFor# #LSDateFormat(CreateDate(yeaar, moonth, daay), 'mmmm d, yyyy')#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
					<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				<CFELSE>
					<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
				</CFIF>

				<p><cfoutput>#language.yourbookings#</cfoutput></p>

				<cfquery name="getDockDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
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
				</cfquery>

				<cfquery name="getJettyDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
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
				</cfquery>

				<cfquery name="getDockMaintenanceDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	Status,
						StartDate, EndDate,
						Section1, Section2, Section3
					FROM	Bookings
						INNER JOIN	Docks ON Bookings.BookingID = Docks.BookingID
					WHERE	Bookings.StartDate <= '#URL.Date#'
						AND	Bookings.EndDate >= '#URL.Date#'
						AND	Bookings.Deleted = '0'
						AND	Status = 'm'

				</cfquery>

				<cfquery name="getJettyMaintenanceDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	Status,
						StartDate, EndDate,
						NorthJetty, SouthJetty
					FROM	Bookings
						INNER JOIN	Jetties ON Bookings.BookingID = Jetties.BookingID
					WHERE	Bookings.StartDate <= '#URL.Date#'
						AND	Bookings.EndDate >= '#URL.Date#'
						AND	Bookings.Deleted = '0'
						AND	Status = 'm'

				</cfquery>

				<cfoutput><h2>#language.DrydockBookings#</h2></cfoutput>

				<cfoutput query="getDockMaintenanceDetail">
				<table cellpadding="2" cellspacing="0" style="width:400px;" class="bookingDetails" align="center">
					<tr>
						<td colspan="2"><strong>#language.MaintenanceBlock#</strong></td>
					</tr>
					<tr>
						<td colspan="2">#language.closedForMaint#</td>
					</tr>
					<tr>
						<td id="SectionsBooked" style="width:35%;">#language.SectionsBooked#:</td>
						<td headers="SectionsBooked"><CFIF Section1>#language.Drydock1#</CFIF><CFIF Section2><CFIF Section1> &amp; </CFIF>#language.Drydock2#</CFIF><CFIF Section3><CFIF Section1 OR Section2> &amp; </CFIF>#language.Drydock3#</CFIF></td>
					</tr>
					<tr>
						<td id="Dates">#language.Dates#:</td>
						<td headers="Dates">#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</CFIF> #language.to# #LSDateFormat(EndDate, "mmm d, yyyy")#</td>
					</tr>
				</table>
				<br />
				<br />
				</cfoutput>

				<cfoutput query="getDockDetail">
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
				<table cellpadding="2" cellspacing="0" style="width:400px;" class="bookingDetails" align="center"<CFIF EVALUATE(Variables.count) GT 0> bgcolor="##E0E6CF"</CFIF>>
					<tr>
						<td colspan="2" <CFIF Status eq 'c'>style="font-weight: bold;"</CFIF> ><cfif #EndHighlight# GTE PacificNow>* </cfif>
							<CFIF Anonymous AND #EVALUATE(Variables.count)# EQ 0 AND not IsDefined('session.AdminLoggedIn') AND Status neq 'c' >
								#language.Deepsea#
							<CFELSE>#VesselName#</CFIF>
						</td>
					</tr>
					<CFIF NOT Anonymous OR #EVALUATE(Variables.count)# GT 0 OR IsDefined('session.AdminLoggedIn')>
					<tr>
						<td id="Agent" style="width:35%;">#language.Agent#:</td>
						<td headers="Agent">#LastName#, #FirstName#</td>
					</tr>
					</cfif>
					<tr>
						<td id="Status" style="width:35%;">#language.Status#:</td>
						<CFIF Status eq 'c'>
							<td headers="Status">#language.Confirmed#</td>
						<CFELSEIF Status eq 't'>
							<td headers=""><i>#language.Tentative#</i></td>
						<CFELSE>
							<td headers=""><i>#language.Pending#</i></td>
						</CFIF>
					</tr>
					<CFIF Status eq 'c'>
						<tr>
							<td id="SectionsBooked2">#language.SectionsBooked#:</td>
							<td headers="SectionsBooked2"><CFIF Section1>#language.Drydock1#</CFIF><CFIF Section2><CFIF Section1> &amp; </CFIF>#language.Drydock2#</CFIF><CFIF Section3><CFIF Section1 OR Section2> &amp; </CFIF>#language.Drydock3#</CFIF></td>
						</tr>
					</CFIF>
					<tr>
						<td id="DockingDates">#language.DockingDates#:</td>
						<td headers="DockingDates">#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</CFIF> #language.to# #LSDateFormat(EndDate, "mmm d, yyyy")#</td>
					</tr>
				</table>
				<CFIF NOT Anonymous OR EVALUATE(Variables.count) GT 0 OR (IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true) OR Status eq 'c' >
					<div style="float: right; padding-right: 20px;"><a href="detail-res-book.cfm?lang=#lang#&amp;bookingid=#BookingID#&amp;date=#url.date#&amp;referrer=Details For">#language.moreInfo#</a></div>
				</cfif>
				<br />
				<br />
				</cfoutput>
				<cfoutput>
				<CFIF getDockDetail.RecordCount eq 0 AND getDockMaintenanceDetail.RecordCount eq 0>#language.noBookings#<br /><br /></CFIF>
				<div style="text-align:center;"><a href="calend-cale-dock.cfm?lang=#lang#&month=#moonth#&year=#yeaar#" class="textbutton">#language.drydockCalButton#</a></div>


				<h2>#language.JettyBookings#</h2>
				</cfoutput>
				<cfoutput query="getJettyMaintenanceDetail">
				<table cellpadding="2" cellspacing="0" style="width:400px;" class="bookingDetails" align="center">
					<tr>
						<td colspan="2"><strong>#language.MaintenanceBlock#</strong></td>
					</tr>
					<tr>
						<td colspan="2">#language.closedForMaint#</td>
					</tr>
					<tr>
						<td id="SectionsBooked3" style="width:35%;">#language.SectionsBooked#:</td>
						<td headers="SectionsBooked3"><CFIF NorthJetty>#language.NorthLandingWharf#</CFIF><CFIF SouthJetty><CFIF NorthJetty> &amp; </CFIF>#language.SouthJetty#</CFIF></td>
					</tr>
					<tr>
						<td id="Dates3">#language.Dates#:</td>
						<td headers="Dates3">#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</CFIF> #language.to# #LSDateFormat(EndDate, "mmm d, yyyy")#</td>
					</tr>
				</table>
				<br />
				<br />
				</cfoutput>
				<cfoutput query="getJettyDetail">
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

				f
					<tr>
						<td colspan="2" <CFIF Status eq 'c'>style="font-weight: bold;"</CFIF> ><cfif #EndHighlight# GTE PacificNow>* </cfif><CFIF Anonymous AND #EVALUATE(Variables.count)# EQ 0 AND NOT IsDefined('session.AdminLoggedIn') AND Status neq 'c'>
						#language.Deepsea#<CFELSE>#VesselName#</CFIF></td>
					</tr>
					<CFIF NOT Anonymous OR #EVALUATE(Variables.count)# GT 0 OR IsDefined('session.AdminLoggedIn')>
					<tr>
						<td id="Agent2" style="width:35%;">#language.Agent#:</td>
						<td headers="Agent2">#LastName#, #FirstName#</td>
					</tr>
					</cfif>
					<tr>
						<td id="Status2" style="width:35%;">#language.Status#:</td>
						<CFIF Status eq 'c'>
							<td headers="Status2">#language.Confirmed#</td>
						<CFELSEIF Status eq 't'>
							<td headers=""><i>#language.Tentative#</i></td>
						<CFELSE>
							<td headers="Status2"><i>#language.Pending#</i></td>
						</CFIF>
					</tr>
					<CFIF Status eq 'c'>
						<tr>
							<td id="SectionsBooked4">#language.SectionsBooked#:</td>
							<td headers="SectionsBooked4"><CFIF NorthJetty>#language.NorthLandingWharf#</CFIF><CFIF SouthJetty><CFIF NorthJetty>, </CFIF>#language.SouthJetty#</CFIF></td>
						</tr>
					</CFIF>
					<tr>
						<td id="DockingDates4">#language.DockingDates#:</td>
						<td headers="DockingDates4">#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</CFIF> #language.to# #LSDateFormat(EndDate, "mmm d, yyyy")#</td>
					</tr>
				</table>
				<CFIF NOT Anonymous OR #EVALUATE(Variables.count)# GT 0 OR (IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true) OR Status eq 'c'><div style="float: right; padding-right: 20px;"><a href="detail-res-book.cfm?lang=#lang#&amp;bookingid=#BookingID#&amp;date=#url.date#&referrer=Details For">#language.moreInfo#</a></div></cfif>
				<br />
				<br />
				</cfoutput>
				<cfoutput>
				<CFIF getJettyDetail.RecordCount eq 0 AND getJettyMaintenanceDetail.RecordCount eq 0>#language.noBookings#<br /><br /></CFIF>

				<div style="text-align:center;"><a href="calend-jet.cfm?lang=#lang#&month=#moonth#&year=#yeaar#" class="textbutton">#language.jettyCalButton#</a></div><div style="height:0;">&nbsp;</div>
				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
