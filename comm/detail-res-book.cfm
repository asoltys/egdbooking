<cfinclude template="#RootDir#includes/bookingInfoVariables.cfm">
<cfinclude template="#RootDir#includes/vesselInfoVariables.cfm">
<cfif lang eq "eng" OR (IsDefined("Session.AdminLoggedIn") AND Session.AdminLoggedIn neq "")>
	<cfset language.bookingDetail = "Booking Details">
	<cfset language.description = "Retrieves information for a booking.">
	<cfset language.company = "Company">
	<cfset language.sectionsBooked = "Sections Booked">
	<cfset language.sectionRequested = "Section Requested">
	<cfset language.dockingDates = "Docking Dates">
	<cfset language.origin = "Origin">
	<cfset language.bookingDate = "Date of Booking">
	<cfset language.tariff = "View / Edit Tariff Form">
	<cfset language.cancelBooking = "Cancel Booking">
	<cfset language.requestCancelBooking = "Request Cancellation">
	<cfset language.editBooking = "Edit Booking">
	<cfset language.deleteBooking = "Delete Booking">
	<cfset language.to = "to">
	<cfset language.from = "from">
	<cfset language.drydock1 = "Section 1">
	<cfset language.drydock2 = "Section 2">
	<cfset language.drydock3 = "Section 3">
	<cfset language.deepsea = "Deepsea Vessel">
	<cfset language.confirmbooking = "Confirm Booking">
<cfelse>
	<cfset language.bookingDetail = "D&eacute;tails&nbsp;- R&eacute;servation">
	<cfset language.description = "R&eacute;cup&eacute;ration de renseignements sur une r&eacute;servation.">
	<cfset language.company = "Entreprise">
	<cfset language.sectionsBooked = "Sections r&eacute;serv&eacute;es">
	<cfset language.sectionRequested = "Section demand&eacute;e">
	<cfset language.dockingDates = "Dates d'amarrage">
	<cfset language.origin = "Origine">
	<cfset language.bookingDate = "Date de la r&eacute;servation">
	<cfset language.tariff = "Consulter / Modifier le formulaire de tarif">
	<cfset language.cancelBooking = "Annuler la r&eacute;servation">
	<cfset language.requestCancelBooking = "Demande d'annulation">
	<cfset language.editBooking = "Modification de r&eacute;servation">
	<cfset language.deleteBooking = "Supprimer la r&eacute;servation">
	<cfset language.to = "&agrave;">
	<cfset language.from = "du">
	<cfset language.drydock1 = "Section 1">
	<cfset language.drydock2 = "Section 2">
	<cfset language.drydock3 = "Section 3">
	<cfset language.deepsea = "Navire oc&eacute;anique">
	<cfset language.confirmbooking = "Confirmer la r&eacute;servation">
</cfif>
<cfquery name="readonlycheck" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT ReadOnly
	FROM Users
	WHERE UserID = #Session.UserID#
</cfquery>
<cfoutput query="readonlycheck">
	<cfset Session.ReadOnly = #ReadOnly#>
</cfoutput>
<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.PWGSC# - #language.EsqGravingDock# - #language.bookingDetail#"" />
	<meta name=""keywords"" content=""#Language.masterKeywords#, #language.bookingDetail#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#Language.masterSubjects#"" />
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.bookingDetail#</title>
	<link rel=""styleSHEET"" type=""text/css"" href=""#RootDir#css/custom.css"">
">

<cfif NOT IsDefined('url.bookingid') OR NOT IsNumeric(url.bookingid)>
	<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
		<cflocation addtoken="no" url="#RootDir#admin/menu.cfm?lang=#lang#"><br />
	<CFELSE>
		<cflocation addtoken="no" url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">
	</CFIF>
</cfif>

<CFPARAM name="url.referrer" default="Booking Home">
<CFIF url.referrer eq "Details For">
	<CFSET returnTo = "#RootDir#comm/detail.cfm">
<CFELSEIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
	<CFSET returnTo = "#RootDir#comm/detail.cfm">
	<CFSET url.referrer = "Details For">
<CFELSEIF url.referrer eq "Archive">
	<CFSET returnTo = "#RootDir#reserve-book/archives.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#reserve-book/reserve-booking.cfm">
</CFIF>

<cfquery name="getBookingDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Bookings.EndHighlight, Bookings.BookingID, Docks.BookingID as DBID, Jetties.BookingID as JBID,
		StartDate, EndDate,
		Section1, Section2, Section3,
		NorthJetty, SouthJetty,
		Docks.Status AS DStatus, Jetties.Status AS JStatus,
		Vessels.Name AS VesselName, Vessels.VesselID, Anonymous,
		Length, Width, LloydsID, Tonnage,
		BookingTime,
		Companies.Name AS CompanyName, Companies.CompanyID, City, Country,
		FirstName, LastName
	FROM	Bookings
		LEFT JOIN	Docks ON Bookings.BookingID = Docks.BookingID
		LEFT JOIN	Jetties ON Bookings.BookingID = Jetties.BookingID
		INNER JOIN	Vessels ON Bookings.VesselID = Vessels.vesselID
		INNER JOIN	Companies ON Vessels.CompanyID = Companies.CompanyID
		INNER JOIN	Users ON Bookings.userID = Users.userID
	WHERE	Bookings.BookingID = #url.bookingid#
		AND Bookings.Deleted = '0'
		AND Vessels.Deleted = '0'
</cfquery>

<cfquery name="isUsers" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	UserID, CompanyID
	FROM	UserCompanies
	WHERE	UserID = '#session.userID#'
		AND	CompanyID = '#getBookingDetail.CompanyID#'
		AND	Approved = 1
		AND	Deleted = 0
</cfquery>

<cfif getBookingDetail.recordCount EQ 0>
	<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
		<cflocation addtoken="no" url="#RootDir#admin/menu.cfm?lang=#lang#">
	<CFELSE>
		<cflocation addtoken="no" url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">
	</CFIF>
</cfif>

<cfoutput query="getBookingDetail">
	<CFIF DBID eq BookingID>
		<CFSET Variables.isDock = true>
	<CFELSE>
		<CFSET Variables.isDock = false>
	</CFIF>
</cfoutput>

<CFPARAM name="url.date" default="#DateFormat(getBookingDetail.startDate, 'mm/dd/yyyy')#">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			<CFELSE>
				<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			</CFIF>
			#language.bookingDetail#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.bookingDetail#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
					<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				<CFELSE>
					<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
				</CFIF>


				<!---check if ship belongs to user's company--->
				<cflock timeout="20" throwontimeout="no" type="READONLY" scope="SESSION">
					<cfquery name="userVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT	Vessels.VesselID
						FROM	Users INNER JOIN UserCompanies ON Users.UserID = UserCompanies.UserID
								INNER JOIN Vessels ON UserCompanies.CompanyID = Vessels.CompanyID
						WHERE	Users.UserID = #Session.UserID# AND Vessels.VesselID = #getBookingDetail.VesselID#
					</cfquery>
				</cflock>

				<cfoutput query="getBookingDetail">

				<h2>
					<cfif #EndHighlight# GTE PacificNow>* </cfif>
					<CFIF Anonymous AND userVessel.recordCount EQ 0 AND (NOT IsDefined('Session.AdminLoggedIn') OR Session.AdminLoggedIn eq false) AND ((isDock AND DStatus neq 'c') OR (NOT isDock AND JStatus neq 'c'))>
						#language.Deepsea#
					<CFELSE>
						#VesselName#
					</CFIF>
				</h2>

				<table style="width:90%;" class="bookingDetails" align="center">
					<CFIF NOT Anonymous OR userVessel.recordCount GT 0 OR IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
					<tr>
						<td id="Agent">#language.Agent#:</td>
						<td headers="Agent">#LastName#, #FirstName#</td>
					</tr>
					</cfif>
					<tr>
						<td id="Status">#language.Status#:</td>
						<CFIF (isDefined("DStatus") AND DStatus eq 'C') OR (isDefined("JStatus") AND JStatus eq 'C')>
							<td headers="Status"><b>#language.Confirmed#</b></td>
						<CFELSEIF (isDefined("DStatus") AND DStatus eq 't') OR (isDefined("JStatus") AND JStatus eq 't')>
							<td headers="Status"><i>#language.Tentative#</i></td>
						<CFELSE>
							<td headers="Status"><i>#language.Pending#</i></td>
						</CFIF>
					</tr>
					<CFIF NOT Anonymous OR userVessel.recordCount GT 0 OR (IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true) OR (isDock AND DStatus eq 'c') OR (NOT isDock AND JStatus eq 'c')>
					<tr>
						<td id="Company" style="width:35%;">#language.Company#:</td>
						<td headers="Company">#CompanyName#</td>
					</tr>
					<tr>
						<td id="Length">#language.Length#:</td>
						<td headers="Length">#Length# m</td>
					</tr>
					</cfif>
					<cfif NOT Anonymous OR userVessel.recordCount GT 0 OR (IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true)>
					<tr>
						<td id="Width">#language.Width#:</td>
						<td headers="Width">#Width# m</td>
					</tr>
					<tr>
						<td id="Tonnage">#language.Tonnage#:</td>
						<td headers="Tonnage">#Tonnage#</td>
					</tr>
					</cfif>
					<tr>
						<CFIF isDock>
							<CFIF DStatus eq 'c'>
								<td id="SectionsBooked">#language.SectionsBooked#:</td>
								<td headers="SectionsBooked"><CFIF Section1>#language.Drydock1#</CFIF><CFIF Section2><CFIF Section1> &amp; </CFIF>#language.Drydock2#</CFIF><CFIF Section3><CFIF Section1 OR Section2> &amp; </CFIF>#language.Drydock3#</CFIF></td>
							<CFELSEIF DStatus eq 't'>
								<td id="SectionRequested">#language.SectionRequested#:</td>
								<td headers="SectionRequested">#language.Drydock#</td>
							<CFELSE>
								<td id="SectionRequested">#language.SectionRequested#:</td>
								<td headers="SectionRequested">#language.Drydock#</td>
							</CFIF>
						<CFELSE>
							<CFIF JStatus eq 'c'>
								<td id="SectionsBooked2">#language.SectionsBooked#:</td>
								<td headers="SectionsBooked2"><CFIF NorthJetty>#language.NorthLandingWharf#</CFIF><CFIF SouthJetty><CFIF NorthJetty>, </CFIF>#language.SouthJetty#</CFIF></td>
							<CFELSE>
								<td id="SectionRequested2">#language.SectionRequested#:</td>
								<td headers="SectionRequested2"><CFIF NorthJetty> #language.NorthLandingWharf#<CFELSE>#language.SouthJetty#</CFIF></td>
							</CFIF>
						</CFIF>
					</tr>
					<tr>
						<td id="DockingDates">#language.DockingDates#:</td>
						<td headers="DockingDates">#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</CFIF> to #LSDateFormat(EndDate, "mmm d, yyyy")#</td>
					</tr>
					<CFIF NOT Anonymous OR userVessel.recordCount GT 0 OR IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
					<tr>
						<td id="Origin">#language.Origin#:</td>
						<td headers="Origin">#City#, #Country#</td>
					</tr>
					</cfif>
					<CFIF NOT Anonymous OR userVessel.recordCount GT 0 OR (IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true) OR (isDock AND DStatus eq 'c') OR (NOT isDock AND JStatus eq 'c')>
					<tr>
						<td id="Time"><cfif IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>Time of Booking:<cfelse>#language.bookingDate#:</cfif></td>
						<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
						<td headers="Time">#LSDateFormat(BookingTime, 'mmm d, yyyy')# @ #LSTimeFormat(BookingTime, 'HH:mm')#</td>
						<cfelse>
						<td headers="Time">#LSDateFormat(BookingTime, 'mmm d, yyyy')#</td>
						</cfif>
					</tr>
					</cfif>
				</table>

				<div style="text-align:center;">
					<cfif #Session.ReadOnly# EQ "1">
						<a href="#returnTo#?lang=#lang#&date=#url.date#" class="textbutton">#language.Back#</a>
					<cfelse>

						<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
							<cfif isDock>
								<a href="#RootDir#admin/DockBookings/feesForm_admin.cfm?#urltoken#&bookingid=#url.bookingid#&referrer=Booking%20Details&amp;date=#url.date#" class="textbutton">#language.tariff#</a>
								<a href="#RootDir#admin/DockBookings/editBooking.cfm?lang=#lang#&bookingid=#url.bookingid#&referrer=Booking%20Details&date=#url.date#" class="textbutton">
							<cfelse>
								<a href="#RootDir#admin/JettyBookings/editJettyBooking.cfm?lang=#lang#&bookingid=#url.bookingid#&companyID=#companyID#&referrer=Booking%20Details&date=#url.date#" class="textbutton">
							</cfif>#language.EditBooking#</a>

							<cfif isDock AND (DateCompare(PacificNow, getBookingDetail.startDate, 'd') NEQ 1 OR (DateCompare(PacificNow, getBookingDetail.startDate, 'd') EQ 1 AND DateCompare(PacificNow, getBookingDetail.endDate, 'd') NEQ 1))>
								<a href="#RootDir#admin/DockBookings/deleteBooking_confirm.cfm?lang=#lang#&bookingID=#url.bookingID#&CompanyID=#getBookingDetail.CompanyID#&referrer=Booking%20Details&amp;date=#url.date#" class="textbutton">#language.CancelBooking#</a>
							<cfelseif isDock AND DateCompare(PacificNow, getBookingDetail.endDate, 'd') EQ 1>
								<a href="#RootDir#admin/DockBookings/deleteBooking_confirm.cfm?lang=#lang#&bookingID=#url.bookingID#&CompanyID=#getBookingDetail.CompanyID#&referrer=Booking%20Details&amp;date=#url.date#" class="textbutton">#language.DeleteBooking#</a>
							<cfelseif NOT isDock AND (DateCompare(PacificNow, getBookingDetail.startDate, 'd') NEQ 1 OR (DateCompare(PacificNow, getBookingDetail.startDate, 'd') EQ 1 AND DateCompare(PacificNow, getBookingDetail.endDate, 'd') NEQ 1))>
								<a href="#RootDir#admin/JettyBookings/deleteJettyBooking_confirm.cfm?lang=#lang#&bookingID=#url.bookingID#&CompanyID=#getBookingDetail.CompanyID#&referrer=Booking%20Details&amp;date=#url.date#" class="textbutton">#language.CancelBooking#</a>
							<cfelseif NOT isDock AND DateCompare(PacificNow, getBookingDetail.endDate, 'd') EQ 1>
								<a href="#RootDir#admin/JettyBookings/deleteJettyBooking_confirm.cfm?lang=#lang#&bookingID=#url.bookingID#&CompanyID=#getBookingDetail.CompanyID#&referrer=Booking%20Details&amp;date=#url.date#" class="textbutton">#language.DeleteBooking#</a>
							</cfif>
							<a href="#returnTo#?lang=#lang#&date=#url.date#" class="textbutton">#language.Back#</a>
						<CFELSE>
							<CFIF isUsers.RecordCount neq 0>
								<cfif DateCompare(PacificNow, getBookingDetail.startDate, 'd') EQ -1 AND (getBookingDetail.DStatus NEQ 'C' AND getBookingDetail.JStatus NEQ 'C') AND userVessel.recordCount GT 0>

									<CFIF (isDefined("DStatus") AND DStatus eq 't') OR (isDefined("JStatus") AND JStatus eq 't')>
										<CFIF isDock>
											<a href="#RootDir#reserve-book/resconf-bookconf_confirm.cfm?lang=#lang#&bookingID=#url.bookingID#&referrer=#URLEncodedFormat(url.referrer)#&date=#url.date#&jetty=0" class="textbutton">#language.confirmbooking#</a>
										<CFELSE>
											<a href="#RootDir#reserve-book/resconf-bookconf_confirm.cfm?lang=#lang#&bookingID=#url.bookingID#&referrer=#URLEncodedFormat(url.referrer)#&date=#url.date#&jetty=1" class="textbutton">#language.confirmbooking#</a>
										</CFIF>
									</CFIF>
									<a href="#RootDir#reserve-book/resmod-bookedit.cfm?lang=#lang#&BookingID=#url.bookingid#&referrer=#URLEncodedFormat(url.referrer)#&date=#url.date#" class="textbutton">#language.EditBooking#</a>
									<CFIF isDock>
										<a href="#RootDir#reserve-book/resannul-bookcancel_confirm.cfm?lang=#lang#&bookingID=#url.bookingID#&referrer=#URLEncodedFormat(url.referrer)#&date=#url.date#&jetty=0" class="textbutton">#language.requestCancelBooking#</a>
									<CFELSE>
										<a href="#RootDir#reserve-book/resannul-bookcancel_confirm.cfm?lang=#lang#&bookingID=#url.bookingID#&referrer=#URLEncodedFormat(url.referrer)#&date=#url.date#&jetty=1" class="textbutton">#language.requestCancelBooking#</a>
									</CFIF>

								<cfelseif (getBookingDetail.DStatus EQ 'C' OR getBookingDetail.JStatus EQ 'C' OR DateCompare(PacificNow, getBookingDetail.StartDate, 'd') NEQ -1) AND DateCompare(PacificNow, getBookingDetail.endDate, 'd') NEQ 1 AND userVessel.recordCount GT 0>
									<CFIF isDock>
										<a href="#RootDir#reserve-book/resannul-bookcancel_confirm.cfm?lang=#lang#&bookingID=#url.bookingID#&referrer=#URLEncodedFormat(url.referrer)#&date=#url.date#&jetty=0" class="textbutton">#language.requestCancelBooking#</a>
									<CFELSE>
										<a href="#RootDir#reserve-book/resannul-bookcancel_confirm.cfm?lang=#lang#&bookingID=#url.bookingID#&referrer=#URLEncodedFormat(url.referrer)#&date=#url.date#&jetty=1" class="textbutton">#language.requestCancelBooking#</a>
									</CFIF>
								</cfif>
							</CFIF>
							<cfif url.referrer eq "Archive">
								<a href="#returnTo#?lang=#lang#&date=#url.date#&companyID=#url.companyID#" class="textbutton">#language.Back#</a>
							<cfelse>
								<a href="#returnTo#?lang=#lang#&date=#url.date#" class="textbutton">#language.Back#</a>
							</cfif>
						</CFIF>
					</cfif>
				</div>
				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
