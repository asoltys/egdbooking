<cfif isDefined("form.bookingID") AND (NOT isDefined("url.referrer") OR url.referrer NEQ "Edit Booking")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<CFPARAM name="url.referrer" default="Booking Management">
<CFIF url.referrer eq "Edit Booking" OR url.referrer eq "Booking Details">
	<CFSET returnTo = "#RootDir#text/admin/DockBookings/editBooking.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#text/admin/DockBookings/bookingManage.cfm">
</CFIF>

<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>

<cfinclude template="#RootDir#includes/header-#lang#.cfm">

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
<cfoutput>
<div class="breadcrumbs">
	<a href="http://www.pwgsc.gc.ca/text/home-#lang#.html">PWGSC</a> &gt; 
	Pacific Region &gt; 
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-e.html">Esquimalt Graving Dock</a> &gt; 
	<a href="#RootDir#text/booking-#lang#.cfm">Booking</A> &gt;
	<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
		<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
	<CFELSE>
		 <a href="#RootDir#text/booking/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
	</CFIF>
	<A href="jettyBookingManage.cfm?lang=#lang#">Jetty Booking Management</A> &gt;
	Change Booking Status
</div>
</cfoutput>

<div class="main">
<H1>Change Booking Status</H1>
<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>

<cfform action="deny_action.cfm?#urltoken#&referrer=#URLEncodedFormat(url.referrer)#" method="post" name="deny">
	Are you sure you want to deny the confirmation and change this booking's status to tentative?
<br>
<br>
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
	</cfoutput>
	
	<div align="center"><p>
	<input type="submit" value="Submit" class="textbutton">
	<cfoutput><input type="button" onClick="self.location.href='#returnTo#?#urltoken##dateValue#&referrer=#URLEncodedFormat(url.referrer)#&bookingID=#getBooking.bookingID###id#getBooking.bookingid#'" value="Cancel" class="textbutton"></cfoutput>
	</p></div>
</cfform>

</div>

<cfinclude template="#RootDir#includes/footer-#lang#.cfm">