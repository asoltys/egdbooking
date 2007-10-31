<cfif isDefined("form.bookingID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<CFIF IsDefined('Form.BookingID')>
	<CFSET Variables.BookingID = Form.BookingID>
<CFELSEIF IsDefined('URL.BookingID')>
	<CFSET Variables.BookingID = URL.BookingID>
<CFELSE>
	<cflocation addtoken="no" url="#RootDir#text/admin/menu.cfm?lang=#lang#">
</CFIF>

<CFPARAM name="url.referrer" default="Jetty Booking Management">
<CFIF url.referrer eq "Booking Details">
	<CFSET returnTo = "#RootDir#text/common/getBookingDetail.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#text/admin/JettyBookings/jettybookingManage.cfm">
</CFIF>


<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Bookings.StartDate, Bookings.EndDate, Vessels.Name AS VesselName, Vessels.*, 
			Users.LastName + ', ' + Users.FirstName AS UserName, 
			Companies.Name AS CompanyName, Jetties.NorthJetty, Jetties.SouthJetty, 
			Jetties.Status
	FROM 	Bookings INNER JOIN Jetties ON Bookings.BookingID = Jetties.BookingID
			INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID 
			INNER JOIN Users ON Bookings.UserID = Users.UserID 
			INNER JOIN Companies ON Vessels.CompanyID = Companies.CompanyID
	WHERE	Bookings.BookingID = '#Variables.BookingID#'
</cfquery>

<cfif DateCompare(Now(), getBooking.startDate, 'd') NEQ 1 OR (DateCompare(Now(), getBooking.startDate, 'd') EQ 1 AND DateCompare(Now(), getBooking.endDate, 'd') NEQ 1)>
	<cfset variables.actionCap = "Cancel">
	<cfset variables.action = "cancel">
<cfelse>
	<cfset variables.actionCap = "Delete">
	<cfset variables.action = "delete">
</cfif>


<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm <cfoutput>#variables.actionCap#</cfoutput> Booking"">
<meta name=""keywords"" lang=""eng"" content="""">
<meta name=""description"" lang=""eng"" content="""">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm #variables.actionCap# Booking</title>">
<cfinclude template="#RootDir#includes/header-#lang#.cfm">


<div class="breadcrumbs">
	<a href="<cfoutput>http://www.pwgsc.gc.ca/text/home-#lang#.html</cfoutput>">PWGSC</a> &gt; 
	Pacific Region &gt; 
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-e.html">Esquimalt Graving Dock</a> &gt; 
  <CFOUTPUT>
		<a href="#RootDir#text/booking-#lang#.cfm">Booking</A> &gt;<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
			<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
		<CFELSE>
			 <a href="#RootDir#text/booking/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
		</CFIF>
		<A href="jettyBookingmanage.cfm?lang=#lang#">Jetty Management</A> &gt;
	</CFOUTPUT>
	Confirm <cfoutput>#variables.actionCap#</cfoutput> Booking
</div>

<div class="main">
<H1>Confirm <cfoutput>#variables.actionCap#</cfoutput> Booking</H1>
<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">


<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>

<cfform action="deleteJettyBooking_action.cfm?#urltoken#&referrer=#URLEncodedFormat(url.referrer)##variables.dateValue#" method="post" name="delBookingConfirm">
	<p><div align="center">Are you sure you want to <cfoutput>#variables.action#</cfoutput> the following booking?</div></p>
	<input type="hidden" name="BookingID" value="<cfoutput>#variables.BookingID#</cfoutput>">
	<cfoutput query="getBooking">
	<table align="center" style="padding-top:10px;font-size:10pt;" width="70%">
		<tr>
			<td id="Vessel" valign="top" width="25%" align="left">Vessel:</td>
			<td header="Vessel">#vesselName#</td>
		</tr>
		<tr>
			<td id="Company" valign="top" width="25%" align="left">Company:</td>
			<td header="Company" width="85%">#companyName#</td>
		</tr>
		<tr>
			<td id="Agent" valign="top" width="25%" align="left">Agent:</td>
			<td header="Agent">#UserName#</td>
		</tr>
		<tr>
			<td id="Start" valign="top" width="25%" align="left">Start Date:</td>
			<td header="Start">#dateformat(startDate, "mmm d, yyyy")#</td>
		</tr>
		<tr>
			<td id="End" valign="top" width="25%" align="left">End Date:</td>
			<td header="End">#dateformat(endDate, "mmm d, yyyy")#</td>
		</tr>
		<tr>
			<td id="Days" valign="top" width="25%" align="left">## of Days:</td>
			<td header="Days">#datediff('d', startDate, endDate) + 1#</td>
		</tr>
		<tr>
			<td id="Jetty" valign="top" width="25%" align="left">Jetty:</td>
			<td header="Jetty">
				<CFIF NorthJetty>North Landing Wharf
				<CFELSE>South Jetty
				</CFIF>
			</td>
		</tr>
		<tr>
			<td id="Status" valign="top" width="25%" align="left">Status:</td>
			<td header="Status">
				<cfif status EQ 'c'>
					Confirmed
				<cfelse>
					Pending
				</cfif>
			</td>
		</tr>
	</table>
	</cfoutput>
	<br>
	<div align="center">
		<input type="submit" name="submitForm" class="textbutton" value="<cfoutput>#variables.action#</cfoutput> booking">
		<cfoutput><input type="button" onClick="javascript:self.location.href='#returnTo#?#urltoken#&bookingID=#variables.bookingID##variables.dateValue####variables.bookingID#'" value="Back" class="textbutton"></cfoutput>
	</div>

</cfform>

</div>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">