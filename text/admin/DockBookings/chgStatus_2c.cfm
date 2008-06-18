<cfif isDefined("form.bookingID") AND (NOT isDefined("url.referrer") OR url.referrer NEQ "Edit Booking")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm Booking"">
	<meta name=""keywords"" lang=""eng"" content="""">
	<meta name=""description"" lang=""eng"" content="""">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm Booking</title>">

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

<cfinclude template="#RootDir#ssi/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-eng.html"><cfinclude template="#RootDir#ssi/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
			<CFELSE>
				 <a href="#RootDir#text/booking/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
				<A href="bookingmanage.cfm?lang=#lang#">Drydock Management</A> &gt;
				Confirm Booking
			</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#ssi/left-menu-gauche-eng.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Confirm Booking
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>
					
			<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>
			
			<!--- -------------------------------------------------------------------------------------------- --->
			<cfparam name="Variables.BookingID" default="">
			<cfparam name="Variables.Section1" default="false">
			<cfparam name="Variables.Section2" default="false">
			<cfparam name="Variables.Section3" default="false">
			
			<cfif IsDefined("Session.Return_Structure")>
				<cfinclude template="#RootDir#includes/getStructure.cfm">
			<cfelseif IsDefined("Form.BookingID")>
				<cfset Variables.BookingID = Form.BookingID>
			<cfelse>
				<cflocation url="#returnTo#?#urltoken##dateValue#&referrer=#url.referrer#" addtoken="no">
			</cfif>
			
			<cfinclude template="includes/getConflicts.cfm">
			<cfset conflictArray = getConflicts_Conf(Variables.BookingID)>
			<cfif ArrayLen(conflictArray) GT 0>
				<cfset Variables.waitListText = "The following vessels are on the wait list ahead of this booking.  The companies/agents should be given 24 hours notice to submit a downpayment.">
				<cfinclude template="includes/displayWaitList.cfm">
			</cfif>
			
			<cfinclude template="includes/getOverlaps.cfm">
			<cfset overlapQuery = getOverlaps_Conf(Variables.BookingID)>
			<cfif overlapQuery.RecordCount GT 0>
			<div class="waitList">
				<p>This vessel has other overlapping bookings listed below:</p>
				<table class="waitlistBookings">
					<tr>
						<th id="Booked" align="left">Booked</th>
						<th id="Vessel" align="left">Vessel</th>
						<th id="Dates" align="left">Docking Dates</th>
						<th align=left>Status</th>
					</tr>
					<cfloop query="overlapQuery">
					<cfoutput>
					<TR valign="top">
						<td headers="Booked" valign="top">#DateFormat(overlapQuery.BookingTime, 'mmm dd, yyyy')#<br>at #TimeFormat(overlapQuery.BookingTime, 'H:mm')#</td>
						<td headers="Vessel" valign="top">#trim(overlapQuery.Name)#</td>
						<td headers="Dates" valign="top">#DateFormat(overlapQuery.StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#DateFormat(overlapQuery.StartDate, ", yyyy")#</CFIF> -<br>#DateFormat(overlapQuery.EndDate, "mmm d, yyyy")#</td>
						<td headers="Vessel" valign="top">
						<cfif #trim(overlapQuery.Status)# EQ "C">
							Confirmed 
						<cfelseif #trim(overlapQuery.Status)# EQ "T">
							Tentative
						<cfelseif #trim(overlapQuery.Status)# EQ "P">
							Pending
						<cfelse>
							Cancelling
						</cfif>
						</td>
					</tr>
					</cfoutput>
			</cfloop>
				</table>
			</div>
			</cfif>
				
			<cfquery name="theBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				SELECT	BookingID, StartDate, EndDate, Vessels.VesselID, Vessels.Length, Vessels.Width, Vessels.Name AS VesselName, Companies.Name AS CompanyName, BookingTime
				FROM	Bookings, Vessels, Companies
				WHERE	Bookings.BookingID = '#Variables.BookingID#'
				AND		Vessels.VesselID = Bookings.VesselID
				AND		Companies.CompanyID = Vessels.CompanyID
			</cfquery>
			
			<cfset Variables.VesselID = theBooking.VesselID>
			<cfset Variables.VesselName = theBooking.VesselName>
			<cfset Variables.CompanyName = theBooking.CompanyName>
			<cfset Variables.Start = CreateODBCDate(theBooking.StartDate)>
			<cfset Variables.End = CreateODBCDate(theBooking.EndDate)>
			
			<cfif url.referrer EQ "Edit Booking" AND isDefined("form.startDate")>
				<cfset Variables.Start = CreateODBCDate(form.StartDate)>
				<cfset Variables.End = CreateODBCDate(form.EndDate)>
			</cfif>
			
			<cfinclude template="includes/towerCheck.cfm">
			
			<cfset Variables.reOrder = BookingTower.ReorderTower()>
			<cfif NOT Variables.reOrder> <!--- Check if the booking can be slotted in without problems --->
				<cflock scope="session" type="exclusive" timeout="30">
					<cfset Session.PassStructure.reOrder = false>
				</cflock>
				<p>The submitted booking request conflicts with other bookings.  Would you like to add the booking anyway?</p>
				
			<cfelse>
				<cflock timeout="60" throwontimeout="No" type="exclusive" scope="session">
					<cfset Session.PassStructure = StructNew()>
					<cfset Session.PassStructure.Tower = BookingTower.getTower()>
					<cfset Session.PassStructure.reOrder = true>
				</cflock>	
				
				<p>Please confirm the following information.</p>
			</cfif>
						<!--- -------------------------------------------------------------------------------------------- --->
			<cfform name="BookingConfirm" action="chgStatus_2c_action.cfm?#urltoken#&referrer=#URLEncodedFormat(url.referrer)#" method="post">
			<cfoutput><input type="hidden" name="BookingID" value="#Variables.BookingID#"></cfoutput>
			<table width="85%" style="padding-left:15px;">
			<tr>
				<td id="Vessel" width="25%" align="left">Vessel:</td>
				<td headers="Vessel"><input type="hidden" name="vesselID" value="<cfoutput>#Variables.VesselID#</cfoutput>" /><cfoutput>#Variables.VesselName#</cfoutput></td>
			</tr>
			<tr>
				<td id="Company" align="left">Company:</td>
				<td headers="Company"><cfoutput>#Variables.CompanyName#</cfoutput></td>
			</tr>		
			<tr>
				<td id="Start" align="left">Start Date:</td>
				<td headers="Start"><cfoutput>#DateFormat(Variables.Start,"mmm dd, yyyy")#</cfoutput></td>
			</tr>
			
			<tr>
				<td id="End" align="left">End Date:</td>
				<td headers="End"><cfoutput>#DateFormat(Variables.End,"mmm dd, yyyy")#</cfoutput></td>
			</tr>
			<cfif Variables.reOrder EQ false>
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td colspan="2">Please choose the sections of the dock that you wish to book</td></tr>
				<tr>
					<td id="section1_header">&nbsp;&nbsp;<label for="Section1">Section 1</label></td>
					<td headers="section1_header"><input type="Checkbox" id="Section1" name="Section1" <CFIF Section1>checked</CFIF>></td></tr>
				<tr>
					<td id="section2_header">&nbsp;&nbsp;<label for="Section2">Section 2</label></td>
					<td headers="section2_header"><input type="Checkbox" id="Section2" name="Section2" <CFIF Section2>checked</CFIF>></td>
				</tr>
				<tr>
					<td id="section3_header">&nbsp;&nbsp;<label for="Section3">Section 3</label></td>
					<td headers="section3_header"><input type="Checkbox" id="Section3" name="Section3" <CFIF Section3>checked</CFIF>></td>
				</tr>
			</cfif>
			<tr><td>&nbsp;</td></tr>
			</table>
			<table align="center">
			<tr>
				<td>
					<input type="submit" value="Confirm" class="textbutton">
					<cfoutput><input type="button" onClick="self.location.href='#returnTo#?#urltoken##dateValue#&referrer=#URLEncodedFormat(url.referrer)#&bookingID=#Variables.bookingID###id#Variables.bookingid#'" value="Cancel" class="textbutton"></cfoutput>
				</td>
			</tr>
			</table>
			
			
			<cfif NOT Variables.reOrder>
				<cfinclude template="#RootDir#includes/showConflicts.cfm">
			</cfif>
			
			
			</cfform>
			
			
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#ssi/foot-pied-#lang#.cfm">
