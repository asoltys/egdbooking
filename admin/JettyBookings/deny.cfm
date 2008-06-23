<cfif isDefined("form.bookingID") AND (NOT isDefined("url.referrer") OR url.referrer NEQ "Edit Booking")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<CFPARAM name="url.referrer" default="Booking Management">
<CFIF url.referrer eq "Edit Booking" OR url.referrer eq "Booking Details">
	<CFSET returnTo = "#RootDir#text/admin/JettyBookings/editJettyBooking.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#text/admin/JettyBookings/jettyBookingManage.cfm">
</CFIF>

<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>

<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Jetties.Status, Bookings.BookingID, StartDate, EndDate,
			Vessels.Name AS VesselName, Companies.Name AS CompanyName,
			Jetties.NorthJetty, Jetties.SouthJetty
	FROM	Jetties, Bookings, Vessels, Companies
	WHERE	Bookings.BookingID = Jetties.BookingID
	AND		Bookings.BookingID = '#Form.BookingID#'
	AND		Vessels.VesselID = Bookings.VesselID
	AND		Companies.CompanyID = Vessels.CompanyID
</cfquery>

<cfif url.referrer EQ "Edit Booking" AND isDefined("form.startDate")>
	<cfset Variables.Start = CreateODBCDate(form.StartDate)>
	<cfset Variables.End = CreateODBCDate(form.EndDate)>
<cfelse>
	<cfset Variables.Start = CreateODBCDate(getBooking.StartDate)>
	<cfset Variables.End = CreateODBCDate(getBooking.EndDate)>
</cfif>
<cfset Variables.Jetty = "North Landing Wharf">
<cfif getBooking.NorthJetty EQ 0>
	<cfset Variables.Jetty = "South Jetty">
</cfif>

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
			<CFELSE>
				 <a href="#RootDir#text/reserve-book/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			<A href="jettyBookingManage.cfm?lang=#lang#">Jetty Booking Management</A> &gt;
			Change Booking Status
			</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Change Booking Status
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				
				<P>Are you sure you want to deny the confirmation and change this booking's status to tentative?</P>
				<cfform action="deny_action.cfm?#urltoken#&referrer=#URLEncodedFormat(url.referrer)#" method="post" name="deny">
					
					<cfoutput>
					<input type="hidden" name="BookingID" value="#Form.BookingID#">
					<table align="center" style="padding-top:5px;">
						<tr>
							<td><strong>Booking Details:</strong></td>
						</tr>
						<tr>
							<td id="Vessel">Vessel:</td>
							<td headers="Vessel">#getBooking.VesselName#</td>
						</tr>
						<tr>
							<td id="Company">Company:</td>
							<td headers="Company">#getBooking.CompanyName#</td>
						</tr>
						<tr>
							<td id="Start">Start Date:</td>
							<td headers="Start">#DateFormat(Variables.Start, "mmm d, yyyy")#</td>
						</tr>
						<tr>
							<td id="End">End Date:</td>
							<td headers="End">#DateFormat(Variables.End, "mmm d, yyyy")#</td>
						</tr>
						<tr>
							<td id="Jetty" align="left">Jetty:</td>
							<td headers="Jetty"><cfoutput>#Variables.Jetty#</cfoutput></td>
						</tr>
					</table>	
					
					<div align="center">
					<input type="submit" value="Submit" class="textbutton">
					<input type="button" onClick="self.location.href='#returnTo#?#urltoken##dateValue#&referrer=#URLEncodedFormat(url.referrer)#&bookingID=#getBooking.bookingID###id#getBooking.bookingid#'" value="Cancel" class="textbutton">
					</cfoutput>
					</div>
				</cfform>

			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
