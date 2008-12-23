<cfif isDefined("form.BRID") AND (NOT isDefined("url.referrer") OR url.referrer NEQ "Edit Booking")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm Booking"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm Booking</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFPARAM name="url.referrer" default="Booking Management">
<CFIF url.referrer eq "Edit Booking" OR url.referrer eq "Booking Details">
	<CFSET returnTo = "#RootDir#admin/DockBookings/editBooking.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#admin/DockBookings/bookingManage.cfm">
</CFIF>
<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt;
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
				<a href="bookingManage.cfm?lang=#lang#">Drydock Management</a> &gt;
				Confirm Booking
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Confirm Booking
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<!--- -------------------------------------------------------------------------------------------- --->
				<cfparam name="Variables.BRID" default="">
				<cfparam name="Variables.Section1" default="false">
				<cfparam name="Variables.Section2" default="false">
				<cfparam name="Variables.Section3" default="false">

				<cfif IsDefined("Session.Return_Structure")>
					<cfinclude template="#RootDir#includes/getStructure.cfm">
				<cfelseif IsDefined("Form.BRID")>
					<cfset Variables.BRID = Form.BRID>
				<cfelse>
					<cflocation url="#returnTo#?#urltoken##dateValue#&referrer=#url.referrer#" addtoken="no">
				</cfif>

				<cfinclude template="includes/getConflicts.cfm">
				<cfset conflictArray = getConflicts_Conf(Variables.BRID)>
				<cfif ArrayLen(conflictArray) GT 0>
					<cfset Variables.waitListText = "The following vessels are on the wait list ahead of this booking.  The companies/agents should be given 24 hours notice to submit a downpayment.">
					<cfinclude template="includes/displayWaitList.cfm">
				</cfif>

				<cfinclude template="includes/getOverlaps.cfm">
				<cfset overlapQuery = getOverlaps_Conf(Variables.BRID)>
				<cfif overlapQuery.RecordCount GT 0>
				<div class="critical">
					<p>This vessel has other overlapping bookings listed below:</p>
					<table class="basic smallFont">
						<tr>
							<th id="Booked" align="left">Booked</th>
							<th id="Vessel" align="left">Vessel</th>
							<th id="Dates" align="left">Docking Dates</th>
							<th align=left>Status</th>
						</tr>
						<cfloop query="overlapQuery">
						<cfoutput>
						<tr valign="top">
							<td headers="Booked" valign="top">#DateFormat(overlapQuery.BookingTime, 'mmm dd, yyyy')#<br />at #TimeFormat(overlapQuery.BookingTime, 'H:mm')#</td>
							<td headers="Vessel" valign="top">#trim(overlapQuery.Name)#</td>
							<td headers="Dates" valign="top">#DateFormat(overlapQuery.StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#DateFormat(overlapQuery.StartDate, ", yyyy")#</CFIF> -<br />#DateFormat(overlapQuery.EndDate, "mmm d, yyyy")#</td>
							<td headers="Vessel" valign="top">
							<cfif #trim(overlapQuery.Status)# EQ "C">Confirmed
							<cfelseif #trim(overlapQuery.Status)# EQ "T">Tentative
							<cfelseif #trim(overlapQuery.Status)# EQ "P">Pending
							<cfelse>Cancelling
							</cfif>
							</td>
						</tr>
						</cfoutput>
				</cfloop>
					</table>
				</div>
				</cfif>

				<cfquery name="theBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	BRID, StartDate, EndDate, Vessels.VNID, Vessels.Length, Vessels.Width, Vessels.Name AS VesselName, Companies.Name AS CompanyName, BookingTime
					FROM	Bookings, Vessels, Companies
					WHERE	Bookings.BRID = '#Variables.BRID#'
					AND		Vessels.VNID = Bookings.VNID
					AND		Companies.CID = Vessels.CID
				</cfquery>

				<cfset Variables.VNID = theBooking.VNID>
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
				<cfform id="BookingConfirm" action="chgStatus_2c_action.cfm?#urltoken#&referrer=#URLEncodedFormat(url.referrer)#" method="post">
				<cfoutput><input type="hidden" name="BRID" value="#Variables.BRID#" /></cfoutput>
				<table style="width:85%; padding-left:15px;" >
				<tr>
					<td id="Vessel" style="width:25%;" align="left">Vessel:</td>
					<td headers="Vessel"><input type="hidden" name="VNID" value="<cfoutput>#Variables.VNID#</cfoutput>" /><cfoutput>#Variables.VesselName#</cfoutput></td>
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
						<td headers="section1_header"><input type="checkbox" id="Section1" name="Section1" <CFIF Section1>checked="true"</CFIF> /></td></tr>
					<tr>
						<td id="section2_header">&nbsp;&nbsp;<label for="Section2">Section 2</label></td>
						<td headers="section2_header"><input type="checkbox" id="Section2" name="Section2" <CFIF Section2>checked="true"</CFIF> /></td>
					</tr>
					<tr>
						<td id="section3_header">&nbsp;&nbsp;<label for="Section3">Section 3</label></td>
						<td headers="section3_header"><input type="checkbox" id="Section3" name="Section3" <CFIF Section3>checked="true"</CFIF> /></td>
					</tr>
				</cfif>
				<tr><td>&nbsp;</td></tr>
				</table>
				<table>
				<tr>
					<td>
						<input type="submit" value="Confirm" class="textbutton" />
						<cfoutput><input type="button" onclick="self.location.href='#returnTo#?#urltoken##dateValue#&referrer=#URLEncodedFormat(url.referrer)#&BRID=#Variables.BRID###id#Variables.BRID#'" value="Cancel" class="textbutton" /></cfoutput>
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

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
