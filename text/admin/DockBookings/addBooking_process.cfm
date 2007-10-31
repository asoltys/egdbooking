<cfif isDefined("form.startDate")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Create New Dock Booking"">
<meta name=""keywords"" lang=""eng"" content="""">
<meta name=""description"" lang=""eng"" content="""">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Create New Dock Booking</title>">

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
		<A href="bookingmanage.cfm?lang=#lang#">Drydock Management</A> &gt;
	</CFOUTPUT>
	Create Booking
</div>

<div class="main">
<H1>Create New Dock Booking</H1>
<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>


<cfset Errors = ArrayNew(1)>
<cfset Success = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<!---<cfoutput>#ArrayAppend(Success, "The booking has been successfully added.")#</cfoutput>--->

<cfparam name = "Form.StartDate" default="">
<cfparam name = "Form.EndDate" default="">
<cfparam name = "Variables.StartDate" default = "#Form.StartDate#">
<cfparam name = "Variables.EndDate" default = "#Form.EndDate#">
<cfparam name = "Form.VesselID" default="">
<cfparam name = "Variables.VesselID" default = "#Form.VesselID#">
<cfparam name = "Form.UserID" default="">
<cfparam name = "Variables.UserID" default = "#Form.UserID#">

<cfif IsDefined("Session.Return_Structure")>
	<cfinclude template="#RootDir#includes/getStructure.cfm">
</cfif>

<cfif Variables.StartDate EQ "">
	<cflocation addtoken="no" url="addbooking.cfm?#urltoken#">
</cfif>

<cfset Variables.StartDate = CreateODBCDate(#Variables.StartDate#)>
<cfset Variables.EndDate = CreateODBCDate(#Variables.EndDate#)>
<cfset Variables.TheBookingDate = CreateODBCDate(#Form.bookingDate#)>
<cfset Variables.TheBookingTime = CreateODBCTime(#Form.bookingTime#)>

<cfif IsDefined("Session.Return_Structure")>
	<cfoutput>#StructDelete(Session, "Return_Structure")#</cfoutput>
</cfif>

<!---Check to see that vessel hasn't already been booked during this time--->
<!--- 25 October 2005: This query now only looks at the drydock bookings --->
<cfquery name="checkDblBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Bookings.VesselID, Vessels.Name, Bookings.StartDate, Bookings.EndDate, Docks.Status
	FROM 	Bookings
				INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID
				INNER JOIN Docks ON Bookings.BookingID = Docks.BookingID
	WHERE 	Bookings.VesselID = '#Variables.VesselID#'
	AND 	
	<!---Explanation of hellishly long condition statement: The client wants to be able to overlap the start and end dates 
		of bookings, so if a booking ends on May 6, another one can start on May 6.  This created problems with single day 
		bookings, so if you are changing this query...watch out for them.  The first 3 lines check for any bookings longer than 
		a day that overlaps with the new booking if it is more than a day.  The next 4 lines check for single day bookings that 
		fall within a booking that is more than one day.--->
			(
				(	Bookings.StartDate <= #Variables.StartDate# AND #Variables.StartDate# < Bookings.EndDate AND #Variables.StartDate# <> #Variables.EndDate# AND Bookings.StartDate <> Bookings.EndDate)
			OR 	(	Bookings.StartDate < #Variables.EndDate# AND #Variables.EndDate# <= Bookings.EndDate AND #Variables.StartDate# <> #Variables.EndDate# AND Bookings.StartDate <> Bookings.EndDate)
			OR	(	Bookings.StartDate >= #Variables.StartDate# AND #Variables.EndDate# >= Bookings.EndDate AND #Variables.StartDate# <> #Variables.EndDate# AND Bookings.StartDate <> Bookings.EndDate)
			OR  (	(Bookings.StartDate = Bookings.EndDate OR #Variables.StartDate# = #Variables.EndDate#) AND Bookings.StartDate <> #Variables.StartDate# AND Bookings.EndDate <> #Variables.EndDate# AND 
						((	Bookings.StartDate <= #Variables.StartDate# AND #Variables.StartDate# < Bookings.EndDate)
					OR 	(	Bookings.StartDate < #Variables.EndDate# AND #Variables.EndDate# <= Bookings.EndDate)
					OR	(	Bookings.StartDate >= #Variables.StartDate# AND #Variables.EndDate# >= Bookings.EndDate)))
			)
	AND		Bookings.Deleted = 0
	ORDER BY StartDate, EndDate DESC
</cfquery>

<!--- 25 October 2005: The next two queries have been modified to only get results from the drydock bookings --->
<cfquery name="getNumStartDateBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Bookings.BookingID, Vessels.Name, Bookings.StartDate, Docks.Status
	FROM	Bookings
				INNER JOIN Docks ON Bookings.BookingID = Docks.BookingID
				INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID
	WHERE	StartDate = #Variables.StartDate# 
				AND Bookings.VesselID = '#Variables.VesselID#'
				AND Bookings.Deleted = 0
</cfquery>

<cfquery name="getNumEndDateBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Bookings.BookingID, Vessels.Name, Bookings.EndDate, Docks.Status
	FROM	Bookings
				INNER JOIN Docks ON Bookings.BookingID = Docks.BookingID
				INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID
	WHERE	EndDate = #Variables.EndDate#
				AND Bookings.VesselID = '#Variables.VesselID#' 
				AND Bookings.Deleted = 0
</cfquery>

<cfset Variables.StartDate = DateFormat(Variables.StartDate, 'mm/dd/yyy')>
<cfset Variables.EndDate = DateFormat(Variables.EndDate, 'mm/dd/yyy')>

<!--- Validate the form data --->
<cfif Variables.StartDate GT Variables.EndDate>
	<cfoutput>#ArrayAppend(Errors, "The Start Date must be before the End Date.")#</cfoutput>
	<cfset Proceed_OK = "No">
<cfelseif DateDiff("d",Variables.StartDate,Variables.EndDate) LT 0>
	<cfoutput>#ArrayAppend(Errors, "The minimum booking time is 1 day.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif DateCompare(Now(), Variables.StartDate, 'd') EQ 1>
	<cfoutput>#ArrayAppend(Errors, "The Start Date can not be in the past.")#</cfoutput>
	<cfset Proceed_OK = "No">
<!--- 06-19-2006 Changed to check status for Tentative so admin can overlap booking for that status--->
<cfelseif isDefined("checkDblBooking.VesselID") AND checkDblBooking.VesselID NEQ "" AND (checkDblBooking.Status NEQ "T" OR form.Status NEQ "T")>
	<cfoutput>#ArrayAppend(Errors, "#checkDblBooking.Name# has already been booked from #dateFormat(checkDblBooking.StartDate, 'mm/dd/yyy')# to #dateFormat(checkDblBooking.EndDate, 'mm/dd/yyy')#.")#</cfoutput>
	<cfset Proceed_OK = "No">
<cfelseif getNumStartDateBookings.recordCount GTE 1 AND (getNumStartDateBookings.Status NEQ "T" OR form.Status NEQ "T")>
	<cfoutput>#ArrayAppend(Errors, "#getNumStartDateBookings.Name# already has a booking for #LSdateFormat(getNumStartDateBookings.StartDate, 'mm/dd/yyy')#.")#</cfoutput>
	<cfset Proceed_OK = "No">
<cfelseif getNumEndDateBookings.recordCount GTE 1 AND (getNumStartDateBookings.Status NEQ "T" OR form.Status NEQ "T")>
	<cfoutput>#ArrayAppend(Errors, "#getNumEndDateBookings.Name# already has a booking for #LSdateFormat(getNumEndDateBookings.EndDate, 'mm/dd/yyy')#.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<!--- Save the form data in a session structure so it can be sent back to the form page --->
	<cfset Session.Return_Structure.StartDate = Variables.StartDate>
	<cfset Session.Return_Structure.EndDate = Variables.EndDate>
	<cfset Session.Return_Structure.TheBookingDate = Variables.TheBookingDate>
	<cfset Session.Return_Structure.TheBookingTime = Variables.TheBookingTime>
	<cfset Session.Return_Structure.VesselID = Variables.vesselID>
	<cfset Session.Return_Structure.userID = Variables.userID>
	<cfset Session.Return_Structure.compId = Form.compID>
	<cfset Session.Return_Structure.Status = Form.Status>
	<cfset Session.Return_Structure.Errors = Errors>
	
 	<cflocation url="addbooking.cfm?#urltoken#" addToken="no"> 
</CFIF>
	

<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	VesselID, Length, Width, Vessels.Name AS VesselName, Companies.Name AS CompanyName
	FROM 	Vessels, Companies
	WHERE 	VesselID = '#Variables.VesselID#'
	AND		Companies.CompanyID = Vessels.CompanyID
	AND 	Vessels.Deleted = 0
	AND		Companies.Deleted = 0
</cfquery>

<cfquery name="getAgent" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	lastname + ', ' + firstname AS UserName
	FROM 	Users
	WHERE 	UserID = '#Variables.UserID#'
</cfquery>

 <!--- Gets all Bookings that would be affected by the requested booking --->
<cfset theBooking.width = getVessel.width>
<cfset theBooking.length = getVessel.length>
<cfset theBooking.BookingID = -1>
<cfset Variables.StartDate = #CreateODBCDate(Variables.StartDate)#>
<cfset Variables.EndDate = #CreateODBCDate(Variables.EndDate)#>
<cfinclude template="includes/towerCheck.cfm">

<cfset Variables.reOrder = BookingTower.ReorderTower()>
<cfif NOT Variables.reOrder> <!--- Check if the booking can be slotted in without problems --->
	<cflock scope="session" type="exclusive" timeout="30">
		<cfset Session.PassStructure.reOrder = false>
	</cflock>
	<p>The submitted booking request <strong>conflicts</strong> with other bookings.  Would you like to add the booking anyway?</p>
	
<cfelse>
	<cflock timeout="60" throwontimeout="No" type="exclusive" scope="session">
		<cfset Session.PassStructure = StructNew()>
		<cfset Session.PassStructure.Tower = BookingTower.getTower()>
		<cfset Session.PassStructure.reOrder = true>
	</cflock>	
	
	<cfif form.Status EQ "C">
		<cfinclude template="includes/getConflicts.cfm">
		<cfset conflictArray = getConflicts_Conf(theBooking.BookingID)>
		<cfif ArrayLen(conflictArray) GT 0>
			<cfset Variables.waitListText = "The following vessels are on the wait list ahead of this booking.  The companies/agents should be given 24 hours notice to submit a downpayment.">
			<cfinclude template="includes/displayWaitList.cfm">
		</cfif>
	</cfif>
	
</cfif>

<cfform action="addBooking_action.cfm?#urltoken#" method="POST" enablecab="No" name="bookingreq" preservedata="Yes">
<br>
<div style="font-size:10pt;font-weight:bold;">New Booking:</div>
<table width="100%" align="center" style="font-size:10pt;padding-left:20px;">
	<tr>
		<td id="Vessel" align="left" width="15%">Vessel:</td>
		<td headers="Vessel" width="75%"><input type="hidden" name="vesselID" value="<cfoutput>#Variables.VesselID#</cfoutput>" /><cfoutput>#getVessel.VesselName#</cfoutput></td>
	</tr>
	<tr>
		<td id="Company" align="left">Company:</td>
		<td headers="Company"><cfoutput>#getVessel.CompanyName#</cfoutput></td>
	</tr>	
	<tr>
		<td id="Agent" align="left">Agent:</td>
		<td headers="Agent"><input type="hidden" name="userID" value="<cfoutput>#Variables.userID#</cfoutput>"><cfoutput>#getAgent.UserName#</cfoutput></td>
	</tr>
	<tr>
		<td id="Start" align="left">Start Date:</td>
		<td headers="Start"><input type="hidden" name="StartDate" value="<cfoutput>#Variables.StartDate#</cfoutput>"><cfoutput>#DateFormat(Variables.StartDate, 'mmm d, yyyy')#</cfoutput></td>
	</tr>
	<tr>
		<td id="End" align="left">End Date:</td>
		<td headers="End"><input type="hidden" name="EndDate" value="<cfoutput>#Variables.EndDate#</cfoutput>"><cfoutput>#DateFormat(Variables.EndDate, 'mmm d, yyyy')#</cfoutput></td>
	</tr>
	<tr>
		<td id="bookingDate" align="left">Booking Time:</td>
		<td headers="bookingDate">
			<cfoutput>
				<input type="hidden" name="bookingDate" value="#Variables.TheBookingDate#" />
				<input type="hidden" name="bookingTime" value="#Variables.TheBookingTime#" />
				#DateFormat(Variables.TheBookingDate, 'mmm d, yyyy')# #TimeFormat(Variables.TheBookingTime, 'HH:mm:ss')#
			</cfoutput>
		</td>
	</tr>
	<tr>
		<td id="Length" align="left">Length:</td>
		<td headers="Length"><cfoutput>#getVessel.Length# m</cfoutput></td>
	</tr>
	<cfif form.Status EQ 'C' AND Variables.reOrder>
	<tr>
		<td id="Section" align="left">Section(s):</td>
		<td headers="Section">
			<CFIF Variables.BlockStructure.Section1>Section 1</CFIF>
			<CFIF Variables.BlockStructure.Section2><CFIF Variables.BlockStructure.Section1> &amp; </CFIF>Section 2</CFIF>
			<CFIF Variables.BlockStructure.Section3><CFIF Variables.BlockStructure.Section1 OR Variables.BlockStructure.Section2> &amp; </CFIF>Section 3</CFIF>
			<input type="hidden" name="Section1A" value="<cfoutput>#Variables.BlockStructure.Section1#</cfoutput>">
			<input type="hidden" name="Section2A" value="<cfoutput>#Variables.BlockStructure.Section2#</cfoutput>">
			<input type="hidden" name="Section3A" value="<cfoutput>#Variables.BlockStructure.Section3#</cfoutput>">
		</td>
	</tr>
	</cfif>
	<tr>
		<td id="Status" align="left">Status:</td>
		<td headers="Status">
			<cfif form.Status EQ 'P'>Pending
			<cfelseif form.Status EQ 'T'>Tentative
			<cfelseif form.Status EQ 'C'>Confirmed
			</cfif>
		</td>
	</tr>
</table>

<br>
<cfif NOT Variables.reOrder>
	<cfif Form.Status EQ "C">
		<table width="100%" cellspacing="0" cellpadding="1" border="0" align="center" style="font-size:10pt;">
		<tr><td colspan="2">This booking conflicts with other bookings. Please choose the sections of 
			the dock that you wish to book:</td></tr>
		<tr>
			<td id="header1" width="25%" align="right">&nbsp;&nbsp;&nbsp;<label for="Section1">Section 1</label></td>
			<td headers="header1"><cfinput type="Checkbox" name="Section1B" id="Section1"></td></tr>
		<tr>
			<td id="header2" align="right">&nbsp;&nbsp;&nbsp;<label for="Section2">Section 2</label></td>
			<td headers="header2"><cfinput type="Checkbox" name="Section2B" id="Section2"></td>
		</tr>
		<tr>
			<td id="header3" align="right">&nbsp;&nbsp;&nbsp;<label for="Section3">Section 3</label></td>
			<td headers="header3"><cfinput type="Checkbox" name="Section3B" id="Section3"></td>
		</tr>
		</table>
	</cfif>
	<cfinclude template="#RootDir#includes/showConflicts.cfm">
</cfif>
<BR>
<table align="center">
<tr>
	<td colspan="2" align="center">
		<input type="hidden" value="<cfoutput>#Form.Status#</cfoutput>" name="Status">
		<input type="Submit" value="Submit" class="textbutton">
		<cfoutput><input type="button" value="Back" class="textbutton" onClick="self.location.href='addBooking.cfm?#urltoken#'"></cfoutput>
		<cfoutput><input type="button" value="Cancel" class="textbutton" onClick="self.location.href='bookingmanage.cfm?#urltoken#';"></CFOUTPUT>
	</td>
</tr>
</table>

</cfform>
</div>

<cfinclude template="#RootDir#includes/footer-#lang#.cfm">
