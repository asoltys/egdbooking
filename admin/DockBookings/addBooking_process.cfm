<cfif isDefined("form.startDate")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Create New Dock Booking"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Create New Dock Booking</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

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
			Create Booking
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Create New Dock Booking
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>


			<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">


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
				<cflocation addtoken="no" url="addBooking.cfm?#urltoken#">
			</cfif>

			<cfset Variables.StartDate = CreateODBCDate(#Variables.StartDate#)>
			<cfset Variables.EndDate = CreateODBCDate(#Variables.EndDate#)>
			<cfset Variables.TheBookingDate = CreateODBCDate(#Form.bookingDate#)>
			<cfset Variables.TheBookingTime = CreateODBCTime(#Form.bookingTime#)>

			<cfif IsDefined("Session.Return_Structure")>
				<cfoutput>#StructDelete(Session, "Return_Structure")#</cfoutput>
			</cfif>

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

			<cfif DateCompare(PacificNow, Variables.StartDate, 'd') EQ 1>
				<cfoutput>#ArrayAppend(Errors, "The Start Date can not be in the past.")#</cfoutput>
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

				<cflocation url="addBooking.cfm?#urltoken#" addToken="no">
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

			<cfform action="addBooking_action.cfm?#urltoken#" method="post" id="bookingreq" preservedata="Yes">
			<br />
			<div style="font-weight:bold;">New Booking:</div>
			<table style="width:100%; padding-left:20px;" align="center">
				<tr>
					<td id="Vessel" align="left" style="width:15%;">Vessel:</td>
					<td headers="Vessel" style="width:75%;"><input type="hidden" name="vesselID" value="<cfoutput>#Variables.VesselID#</cfoutput>" /><cfoutput>#getVessel.VesselName#</cfoutput></td>
				</tr>
				<tr>
					<td id="Company" align="left">Company:</td>
					<td headers="Company"><cfoutput>#getVessel.CompanyName#</cfoutput></td>
				</tr>
				<tr>
					<td id="Agent" align="left">Agent:</td>
					<td headers="Agent"><input type="hidden" name="userID" value="<cfoutput>#Variables.userID#</cfoutput>" />
				</tr>
				<tr>
					<td id="Start" align="left">Start Date:</td>
					<td headers="Start"><input type="hidden" name="StartDate" value="<cfoutput>#Variables.StartDate#</cfoutput>" /><cfoutput>#DateFormat(Variables.StartDate, 'mmm d, yyyy')#</cfoutput></td>
				</tr>
				<tr>
					<td id="End" align="left">End Date:</td>
					<td headers="End"><input type="hidden" name="EndDate" value="<cfoutput>#Variables.EndDate#</cfoutput>" /><cfoutput>#DateFormat(Variables.EndDate, 'mmm d, yyyy')#</cfoutput></td>
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
						<input type="hidden" name="Section1A" value="<cfoutput>#Variables.BlockStructure.Section1#</cfoutput>" />
						<input type="hidden" name="Section2A" value="<cfoutput>#Variables.BlockStructure.Section2#</cfoutput>" />
						<input type="hidden" name="Section3A" value="<cfoutput>#Variables.BlockStructure.Section3#</cfoutput>" />
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

			<br />
			<cfif NOT Variables.reOrder>
				<cfif Form.Status EQ "C">
					<table style="width:100%;" cellspacing="0" cellpadding="1" border="0">
					<tr><td colspan="2">This booking conflicts with other bookings. Please choose the sections of
						the dock that you wish to book:</td></tr>
					<tr>
						<td id="header1" style="width:25%;" align="right">&nbsp;&nbsp;&nbsp;<label for="Section1">Section 1</label></td>
						<td headers="header1"><cfinput type="checkbox" name="Section1B" id="Section1" /></td></tr>
					<tr>
						<td id="header2" align="right">&nbsp;&nbsp;&nbsp;<label for="Section2">Section 2</label></td>
						<td headers="header2"><cfinput type="checkbox" name="Section2B" id="Section2" /></td>
					</tr>
					<tr>
						<td id="header3" align="right">&nbsp;&nbsp;&nbsp;<label for="Section3">Section 3</label></td>
						<td headers="header3"><cfinput type="checkbox" name="Section3B" id="Section3" /></td>
					</tr>
					</table>
				</cfif>
				<cfinclude template="#RootDir#includes/showConflicts.cfm">
			</cfif>
			<br />
			<table>
			<tr>
				<td colspan="2" align="center">
					<input type="hidden" value="<cfoutput>#Form.Status#</cfoutput>" name="Status" />
					<input type="submit" value="submit" class="textbutton" />
					<cfoutput><input type="button" value="Back" class="textbutton" onclick="self.location.href='addBooking.cfm?#urltoken#'" /></cfoutput>
					<cfoutput><input type="button" value="Cancel" class="textbutton" onclick="self.location.href='bookingmanage.cfm?#urltoken#';" /></cfoutput>
				</td>
			</tr>
			</table>

			</cfform>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
