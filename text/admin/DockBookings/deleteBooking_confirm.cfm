<cfif isDefined("form.bookingID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<CFIF IsDefined('Form.BookingID')>
	<CFSET Variables.BookingID = Form.BookingID>
<CFELSEIF IsDefined('URL.BookingID')>
	<CFSET Variables.BookingID = URL.BookingID>
<CFELSE>
	<cflocation addtoken="no" url="#RootDir#text/admin/menu.cfm?lang=#lang#">
</CFIF>

<CFPARAM name="url.referrer" default="Drydock Booking Management">
<CFIF url.referrer eq "Booking Details">
	<CFSET returnTo = "#RootDir#text/common/getBookingDetail.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#text/admin/DockBookings/bookingManage.cfm">
</CFIF>


<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Bookings.StartDate, Bookings.EndDate, Vessels.Name AS VesselName, Vessels.*, 
			Users.LastName + ', ' + Users.FirstName AS UserName, 
			Companies.Name AS CompanyName, Docks.Section1, Docks.Section2, Docks.Section3,
			Docks.Status
	FROM 	Bookings INNER JOIN Docks ON Bookings.BookingID = Docks.BookingID
			INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID 
			INNER JOIN Users ON Bookings.UserID = Users.UserID 
			INNER JOIN Companies ON Vessels.CompanyID = Companies.CompanyID
	WHERE	Bookings.BookingID = '#Variables.BookingID#'
</cfquery>

<cfif DateCompare(PacificNow, getBooking.startDate, 'd') NEQ 1 OR (DateCompare(PacificNow, getBooking.startDate, 'd') EQ 1 AND DateCompare(PacificNow, getBooking.endDate, 'd') NEQ 1)>
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

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
			<CFELSE>
				 <a href="#RootDir#text/booking/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			<a href="bookingmanage.cfm?lang=#lang#">Drydock Management</A> &gt;
			Confirm #variables.actionCap# Booking
			</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<CFOUTPUT>Confirm #variables.actionCap# Booking</CFOUTPUT>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				
				<cfif getBooking.Status EQ 'c' AND DateCompare(PacificNow, getBooking.endDate, 'd') NEQ 1>
					<cfinclude template="includes/getConflicts.cfm">
					<cfset conflictArray = getConflicts_remConf(Variables.BookingID)>
					<cfif ArrayLen(conflictArray) GT 0>
						<cfset Variables.waitListText = "The booking slot that this vessel held is now available for the following tentative bookings. The companies/agents should be given 24 hours notice to claim this slot.">
						<cfinclude template="includes/displayWaitList.cfm">
					</cfif>
				</cfif>
				
				<cfif isDefined("url.date")>
					<cfset variables.dateValue = "&date=#url.date#">
				<cfelse>
					<cfset variables.dateValue = "">
				</cfif>
				
				<cfform action="deleteBooking_action.cfm?#urltoken#&referrer=#URLEncodedFormat(url.referrer)##variables.dateValue#" method="post" name="delBookingConfirm">
					<p align="center">Are you sure you want to <cfoutput>#variables.action#</cfoutput> the following booking?</p>
					
					<input type="hidden" name="BookingID" value="<cfoutput>#Variables.BookingID#</cfoutput>">
					<cfoutput query="getBooking">
					<table align="center" style="padding-top:10px;padding-bottom:10px;padding-left:30px;font-size:10pt;" width="70%">
						<tr>
							<td id="Company" valign="top" width="25%" align="left">Company:</td>
							<td headers="Company" width="75%">#companyName#</td>
						</tr>
						<tr>
							<td id="Agent" valign="top" width="15%" align="left">Agent:</td>
							<td headers="Agent">#UserName#</td>
						</tr>
						<tr>
							<td id="Vessel" valign="top" width="15%" align="left">Vessel:</td>
							<td headers="Vessel">#vesselName#</td>
						</tr>
						<tr>
							<td id="Start" valign="top" width="15%" align="left">Start Date:</td>
							<td headers="Start">#dateformat(startDate, "mmm d, yyyy")#</td>
						</tr>
						<tr>
							<td id="End" valign="top" width="15%" align="left">End Date:</td>
							<td headers="End">#dateformat(endDate, "mmm d, yyyy")#</td>
						</tr>
						<tr>
							<td id="Days" valign="top" width="15%" align="left">## of Days:</td>
							<td headers="Days">#datediff('d', startDate, endDate) + 1#</td>
						</tr>
						<tr>
							<td id="Section" valign="top" width="15%" align="left">Section(s):</td>
							<td headers="Section">
								<CFIF Section1>Section 1</CFIF>
								<CFIF Section2><CFIF Section1> &amp; </CFIF>Section 2</CFIF>
								<CFIF Section3><CFIF Section1 OR Section2> &amp; </CFIF>Section 3</CFIF>
								<CFIF NOT Section1 AND NOT Section2 AND NOT Section3>Unassigned</CFIF>
							</td>
						</tr>
						<tr>
							<td id="Status" valign="top" width="15%" align="left">Status:</td>
							<td headers="Status">
								<cfif status EQ 'c'>
									Confirmed
								<cfelseif status EQ 't'>
									Tentative
								<cfelse>
									Pending
								</cfif>
							</td>
						</tr>
					</table>
					<br>
					<div align="center">
						<input type="submit" name="submitForm" class="textbutton" value="#variables.action#">
						<input type="button" onClick="self.location.href='#returnTo#?#urltoken#&bookingID=#variables.bookingID##variables.dateValue###id#variables.bookingid#'" value="Back" class="textbutton">
					</div>
				
					</cfoutput>
				
				</cfform>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
