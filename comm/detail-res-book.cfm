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
	WHERE UID = #Session.UID#
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
">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">


<cfif NOT IsDefined('url.BRID') OR NOT IsNumeric(url.BRID)>
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
	SELECT	Bookings.EndHighlight, Bookings.BRID, Docks.BRID as DBID, Jetties.BRID as JBID,
		StartDate, EndDate,
		Section1, Section2, Section3,
		NorthJetty, SouthJetty,
		Docks.Status AS DStatus, Jetties.Status AS JStatus,
		Vessels.Name AS VesselName, Vessels.VNID, Anonymous,
		Length, Width, LloydsID, Tonnage,
		BookingTime,
		Companies.Name AS CompanyName, Companies.CID, City, Country,
		FirstName, LastName
	FROM	Bookings
		LEFT JOIN	Docks ON Bookings.BRID = Docks.BRID
		LEFT JOIN	Jetties ON Bookings.BRID = Jetties.BRID
		INNER JOIN	Vessels ON Bookings.VNID = Vessels.VNID
		INNER JOIN	Companies ON Vessels.CID = Companies.CID
		INNER JOIN	Users ON Bookings.UID = Users.UID
	WHERE	Bookings.BRID = #url.BRID#
		AND Bookings.Deleted = '0'
		AND Vessels.Deleted = '0'
</cfquery>

<cfquery name="isUsers" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	UID, CID
	FROM	UserCompanies
	WHERE	UID = '#session.UID#'
		AND	CID = '#getBookingDetail.CID#'
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
	<CFIF DBID eq BRID>
		<CFSET Variables.isJetty = 0>
	<CFELSE>
		<CFSET Variables.isJetty = 1>
	</CFIF>
</cfoutput>

<CFPARAM name="url.date" default="#DateFormat(getBookingDetail.startDate, 'mm/dd/yyyy')#">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
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
						SELECT	Vessels.VNID
						FROM	Users INNER JOIN UserCompanies ON Users.UID = UserCompanies.UID
								INNER JOIN Vessels ON UserCompanies.CID = Vessels.CID
						WHERE	Users.UID = #Session.UID# AND Vessels.VNID = #getBookingDetail.VNID#
					</cfquery>
				</cflock>

				<cfoutput query="getBookingDetail">

					<h2>
						<cfif #EndHighlight# GTE PacificNow>* </cfif>
						<CFIF Anonymous AND userVessel.recordCount EQ 0 AND (NOT IsDefined('Session.AdminLoggedIn') OR Session.AdminLoggedIn eq false) AND ((not isJetty AND DStatus neq 'c') OR (NOT not isJetty AND JStatus neq 'c'))>
							#language.Deepsea#
						<CFELSE>
							#VesselName#
						</CFIF>
					</h2>

					<table class="bookingDetails">

						<CFIF NOT Anonymous OR userVessel.recordCount GT 0 OR IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
							<tr>
								<td>#language.Agent#:</td>
								<td>#LastName#, #FirstName#</td>
							</tr>
						</cfif>

						<tr>
							<td>#language.Status#:</td>
							<td>
								<CFIF (isDefined("DStatus") AND DStatus eq 'C') OR (isDefined("JStatus") AND JStatus eq 'C')>
									<b>#language.Confirmed#</b>
								<CFELSEIF (isDefined("DStatus") AND DStatus eq 't') OR (isDefined("JStatus") AND JStatus eq 't')>
									<i>#language.Tentative#</i>
								<CFELSE>
									<i>#language.Pending#</i>
								</CFIF>
							</td>
						</tr>

						<CFIF NOT Anonymous OR userVessel.recordCount GT 0 OR (IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true) OR (not isJetty AND DStatus eq 'c') OR (NOT not isJetty AND JStatus eq 'c')>
							<tr>
								<td>#language.Company#:</td>
								<td>#CompanyName#</td>
							</tr>
							<tr>
								<td>#language.Length#:</td>
								<td>#Length# m</td>
							</tr>
						</cfif>

						<cfif NOT Anonymous OR userVessel.recordCount GT 0 OR (IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true)>
							<tr>
								<td>#language.Width#:</td>
								<td>#Width# m</td>
							</tr>

							<tr>
								<td>#language.Tonnage#:</td>
								<td>#Tonnage#</td>
							</tr>
						</cfif>

						<tr>
							<CFIF not isJetty>
								<CFIF DStatus eq 'c'>
									<td>#language.SectionsBooked#:</td>
									<td><CFIF Section1>#language.Drydock1#</CFIF><CFIF Section2><CFIF Section1> &amp; </CFIF>#language.Drydock2#</CFIF><CFIF Section3><CFIF Section1 OR Section2> &amp; </CFIF>#language.Drydock3#</CFIF></td>
								<CFELSEIF DStatus eq 't'>
									<td>#language.SectionRequested#:</td>
									<td>#language.Drydock#</td>
								<CFELSE>
									<td>#language.SectionRequested#:</td>
									<td>#language.Drydock#</td>
								</CFIF>
							<CFELSE>
								<CFIF JStatus eq 'c'>
									<td>#language.SectionsBooked#:</td>
									<td><CFIF NorthJetty>#language.NorthLandingWharf#</CFIF><CFIF SouthJetty><CFIF NorthJetty>, </CFIF>#language.SouthJetty#</CFIF></td>
								<CFELSE>
									<td>#language.SectionRequested#:</td>
									<td><CFIF NorthJetty> #language.NorthLandingWharf#<CFELSE>#language.SouthJetty#</CFIF></td>
								</CFIF>
							</CFIF>
						</tr>

						<tr>
							<td>#language.DockingDates#:</td>
							<td>#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</CFIF> to #LSDateFormat(EndDate, "mmm d, yyyy")#</td>
						</tr>

						<CFIF NOT Anonymous OR userVessel.recordCount GT 0 OR IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
							<tr>
								<td>#language.Origin#:</td>
								<td>#City#, #Country#</td>
							</tr>
						</cfif>

						<CFIF NOT Anonymous OR userVessel.recordCount GT 0 OR (IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true) OR (not isJetty AND DStatus eq 'c') OR (NOT not isJetty AND JStatus eq 'c')>
						<tr>
							<td><cfif IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>Time of Booking:<cfelse>#language.bookingDate#:</cfif></td>
							<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
							<td>#LSDateFormat(BookingTime, 'mmm d, yyyy')# @ #LSTimeFormat(BookingTime, 'HH:mm')#</td>
							<cfelse>
							<td>#LSDateFormat(BookingTime, 'mmm d, yyyy')#</td>
							</cfif>
						</tr>
						</cfif>

					</table>

					<cfset bookingIsInPast = true />
					<cfset bookingIsInFuture = true />

					<cfif DateCompare(PacificNow, getBookingDetail.startDate, 'd') NEQ 1>
						<!--- booking is in the future --->
						<cfset bookingIsInPast = false />
					<cfelseif DateCompare(PacificNow, getBookingDetail.startDate, 'd') EQ 1 AND DateCompare(PacificNow, getBookingDetail.endDate, 'd') NEQ 1>
						<!--- booking is right now --->
						<cfset bookingIsInPast = false />
						<cfset bookingIsInFuture = false />
					</cfif>

					<div class="buttons">
						<cfif #Session.ReadOnly# EQ "1">
							<a href="#returnTo#?lang=#lang#&date=#url.date#" class="textbutton">#language.Back#</a>
						<cfelse>

							<cfif IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn>
								<cfif not isJetty>
									<a href="#RootDir#admin/DockBookings/feesForm_admin.cfm?#urltoken#&amp;BRID=#url.BRID#&amp;referrer=Booking%20Details&amp;date=#url.date#" class="textbutton">#language.tariff#</a>
									<a href="#RootDir#admin/DockBookings/editBooking.cfm?lang=#lang#&amp;BRID=#url.BRID#&amp;referrer=Booking%20Details&amp;date=#url.date#" class="textbutton">
								<cfelse>
									<a href="#RootDir#admin/JettyBookings/editJettyBooking.cfm?lang=#lang#&amp;BRID=#url.BRID#&amp;CID=#CID#&amp;referrer=Booking%20Details&amp;date=#url.date#" class="textbutton">
								</cfif>#language.EditBooking#</a>

								<cfif isJetty>
									<a href="#RootDir#admin/JettyBookings/deleteJettyBooking_confirm.cfm?lang=#lang#&BRID=#url.BRID#&amp;CID=#getBookingDetail.CID#&referrer=Booking%20Details&amp;date=#url.date#" class="textbutton">
										<cfif bookingIsInPast>
											#language.DeleteBooking#
										<cfelse>
											#language.CancelBooking#
										</cfif>
									</a>
								<cfelse>
									<a href="#RootDir#admin/DockBookings/deleteBooking_confirm.cfm?lang=#lang#& BRID=#url.BRID#&amp;CID=#getBookingDetail.CID#&referrer=Booking%20Details&amp;date=#url.date#" class="textbutton">
										<cfif bookingIsInPast>
											#language.DeleteBooking#
										<cfelse>
											#language.CancelBooking#
										</cfif>
									</a>
								</cfif>
								<a href="#returnTo#?lang=#lang#&amp;date=#url.date#" class="textbutton">#language.Back#</a>
							<cfelse>
								<CFIF isUsers.RecordCount neq 0>
									<cfif bookingIsInFuture AND (getBookingDetail.DStatus NEQ 'C' AND getBookingDetail.JStatus NEQ 'C') AND userVessel.recordCount GT 0>

										<CFIF (isDefined("DStatus") AND DStatus eq 't') OR (isDefined("JStatus") AND JStatus eq 't')>
											<a href="#RootDir#reserve-book/resconf-bookconf_confirm.cfm?lang=#lang#&amp;BRID=#url.BRID#&amp;referrer=#URLEncodedFormat(url.referrer)#&amp;date=#url.date#&amp;jetty=#isJetty#" class="textbutton">#language.confirmbooking#</a>
										</CFIF>

										<a href="#RootDir#reserve-book/resmod-bookedit.cfm?lang=#lang#&amp;BRID=#url.BRID#&amp;referrer=#URLEncodedFormat(url.referrer)#&amp;date=#url.date#" class="textbutton">#language.EditBooking#</a>

										<a href="#RootDir#reserve-book/resannul-bookcancel_confirm.cfm?lang=#lang#&amp;BRID=#url.BRID#&amp;referrer=#URLEncodedFormat(url.referrer)#&amp;date=#url.date#&amp;jetty=#isJetty#" class="textbutton">#language.requestCancelBooking#</a>

									<cfelseif userVessel.recordCount GT 0 AND (getBookingDetail.DStatus EQ 'C' OR getBookingDetail.JStatus EQ 'C' OR DateCompare(PacificNow, getBookingDetail.StartDate, 'd') NEQ -1) AND DateCompare(PacificNow, getBookingDetail.endDate, 'd') NEQ 1>
										<a href="#RootDir#reserve-book/resannul-bookcancel_confirm.cfm?lang=#lang#&amp;BRID=#url.BRID#&amp;referrer=#URLEncodedFormat(url.referrer)#&amp;date=#url.date#&amp;jetty=#isJetty#" class="textbutton">#language.requestCancelBooking#</a>
									</cfif>
								</CFIF>

								<cfif url.referrer eq "Archive">
									<a href="#returnTo#?lang=#lang#&amp;date=#url.date#&amp;CID=#url.CID#" class="textbutton">#language.Back#</a>
								<cfelse>
									<a href="#returnTo#?lang=#lang#&amp;date=#url.date#" class="textbutton">#language.Back#</a>
								</cfif>

							</cfif>
						</cfif>
					</div>
				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
