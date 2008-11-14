<cfif isDefined("form.startDate")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Dock Booking"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Dock Booking</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFPARAM name="url.referrer" default="Drydock Booking Management">
<CFIF url.referrer eq "Booking Details">
	<CFSET returnTo = "#RootDir#comm/detail-res-book.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#admin/DockBookings/bookingManage.cfm">
</CFIF>

<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>


<!-- Start JavaScript Block -->
<script type="text/javascript">
/* <![CDATA[ */
function EditSubmit ( selectedform )
	{
	  document.forms[selectedform].submit();
	}
/* ]]> */
</script>
<!-- End JavaScript Block -->

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
			<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt; 
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			<a href="bookingManage.cfm?lang=#lang#">Drydock Management</a> &gt;
			Edit Dock Booking
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Edit Booking Information
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

			<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
			
			<cfset Errors = ArrayNew(1)>
			<cfset Success = ArrayNew(1)>
			<cfset Proceed_OK = "Yes">
			
			<!---<cfoutput>#ArrayAppend(Success, "The booking has been successfully added.")#</cfoutput>--->
			
			<cfparam name = "Form.StartDate" default="">
			<cfparam name = "Form.EndDate" default="">
			<cfparam name = "Variables.BookingID" default="#Form.BookingID#">
			<cfparam name = "Variables.StartDate" default = "#Form.StartDate#">
			<cfparam name = "Variables.EndDate" default = "#Form.EndDate#">
			<cfparam name = "Form.VesselID" default="">
			<cfparam name = "Variables.VesselID" default = "#Form.VesselID#">
			<cfparam name = "Form.UserID" default="">
			<cfparam name = "Variables.UserID" default = "#Form.UserID#">
			<cfparam name = "Variables.Section1" default = 0>
			<cfparam name = "Variables.Section2" default = 0>
			<cfparam name = "Variables.Section3" default = 0>
			
			<cfif (NOT IsDefined("Form.BookingID") OR Form.BookingID eq '') AND (NOT IsDefined("URL.BookingID") OR URL.BookingID eq '')>
				<cflocation addtoken="no" url="#RootDir#admin/DockBookings/bookingManage.cfm?#urltoken#">
			</cfif>
			
			
			<cfif IsDefined("Form.Section1")>
				<cfset Variables.Section1 = 1>
			</cfif>
			<cfif IsDefined("Form.Section2")>
				<cfset Variables.Section2 = 1>
			</cfif>
			<cfif IsDefined("Form.Section3")>
				<cfset Variables.Section3 = 1>
			</cfif>
			
			<cfif Variables.StartDate EQ "">
				<cflocation addtoken="no" url="editBooking.cfm?lang=#lang##variables.dateValue#">
			</cfif>
			
			<cfset Variables.StartDate = CreateODBCDate(#Variables.StartDate#)>
			<cfset Variables.EndDate = CreateODBCDate(#Variables.EndDate#)>
			
			<cfif IsDefined("Session.Return_Structure")>
				<cfoutput>#StructDelete(Session, "Return_Structure")#</cfoutput>
			</cfif>
			
			<cfquery name="getData" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				SELECT 	Vessels.VesselID, Length, Width, Vessels.Name AS VesselName, Companies.Name AS CompanyName, Docks.Status
				FROM 	Vessels, Companies, Bookings, Docks
				WHERE 	Vessels.VesselID = Bookings.VesselID
				AND		Bookings.BookingID = '#Form.BookingID#'
				AND		Docks.BookingID = Bookings.BookingID
				AND		Companies.CompanyID = Vessels.CompanyID
				AND 	Vessels.Deleted = 0
				AND		Companies.Deleted = 0
			</cfquery>
			<cfquery name="getAgent" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				SELECT 	lastname + ', ' + firstname AS UserName
				FROM 	Users
				WHERE 	UserID = '#Variables.UserID#'
			</cfquery>
			<cfset Variables.VesselID = getData.VesselID>
			
			<!---Check to see that vessel hasn't already been booked during this time--->
			<cfquery name="checkDblBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				SELECT 	Bookings.VesselID, Name, StartDate, EndDate
				FROM 	Bookings
							INNER JOIN Vessels ON Vessels.VesselID = Bookings.VesselID 
							INNER JOIN Docks ON Bookings.BookingID = Docks.BookingID 
				WHERE 	Bookings.VesselID = '#Variables.VesselID#'
				AND 	Bookings.BookingID != '#Form.BookingID#'
				AND 	(
							(	Bookings.StartDate <= #Variables.StartDate# AND #Variables.StartDate# <= Bookings.EndDate )
						OR 	(	Bookings.StartDate <= #Variables.EndDate# AND #Variables.EndDate# <= Bookings.EndDate )
						OR	(	Bookings.StartDate >= #Variables.StartDate# AND #Variables.EndDate# >= Bookings.EndDate)
						)
				AND		Bookings.Deleted = 0
			</cfquery>
			
			<cfset Variables.StartDate = DateFormat(Variables.StartDate, 'mm/dd/yyyy')>
			<cfset Variables.EndDate = DateFormat(Variables.EndDate, 'mm/dd/yyyy')>
			<cfset Variables.TheBookingDate = CreateODBCDate(#Form.bookingDate#)>
			<cfset Variables.TheBookingTime = CreateODBCTime(#Form.bookingTime#)>
			
			<!--- Validate the form data --->
			<cfif Variables.StartDate GT Variables.EndDate>
				<cfoutput>#ArrayAppend(Errors, "The Start Date must be before the End Date.")#</cfoutput>
				<cfset Proceed_OK = "No">
			</cfif>
			
			<cfif DateDiff("d",Variables.StartDate,Variables.EndDate) LT 0>
				<cfoutput>#ArrayAppend(Errors, "The minimum booking time is 1 day.")#</cfoutput>
				<cfset Proceed_OK = "No">
			</cfif>
			
			<!--- <cfif DateCompare(PacificNow, Variables.StartDate, 'd') EQ 1>
				<cfoutput>#ArrayAppend(Errors, "The Start Date can not be in the past.")#</cfoutput>
				<cfset Proceed_OK = "No"> --->
			<cfif checkDblBooking.RecordCount GT 0>
				<!---<cfoutput>#ArrayAppend(Errors, "#checkDblBooking.Name# has already been booked from #dateFormat(checkDblBooking.StartDate, 'mm/dd/yyy')# to #dateFormat(checkDblBooking.EndDate, 'mm/dd/yyy')#.")#</cfoutput>--->
				<cfoutput><div id="actionErrors">#checkDblBooking.Name# has already been booked from #dateFormat(checkDblBooking.StartDate, 'mm/dd/yyy')# to #dateFormat(checkDblBooking.EndDate, 'mm/dd/yyy')#.</div></cfoutput>
				<cfset Proceed_OK = "Yes">
			</cfif>
			
			<cfif getData.Width GTE Variables.MaxWidth OR getData.Length GTE Variables.MaxLength>
				<cfoutput>#ArrayAppend(Errors, "The vessel, #getData.VesselName#, is too large for the drydock.")#</cfoutput>
				<cfset Proceed_OK = "No">
			</cfif>
			
			<cfif getData.Status EQ 'c' AND NOT isDefined("form.section1") AND NOT isDefined("form.section2") AND NOT isDefined("form.section3")>
				<cfoutput>#ArrayAppend(Errors, "At least one section of the dock must be selected for confirmed bookings.")#</cfoutput>
				<cfset Proceed_OK = "No">
			</cfif>
			
			<cfif Proceed_OK EQ "No">
				<!--- Save the form data in a session structure so it can be sent back to the form page --->
				<cfset Session.Return_Structure.StartDate = Variables.StartDate>
				<cfset Session.Return_Structure.EndDate = Variables.EndDate>
				<cfset Session.Return_Structure.VesselID = Variables.VesselID>
				<cfset Session.Return_Structure.BookingID = Variables.BookingID>
				<cfset Session.Return_Structure.Section1 = Variables.Section1>
				<cfset Session.Return_Structure.Section2 = Variables.Section2>
				<cfset Session.Return_Structure.Section3 = Variables.Section3>
				<cfset Session.Return_Structure.TheBookingDate = Variables.TheBookingDate>
				<cfset Session.Return_Structure.TheBookingTime = Variables.TheBookingTime>
						
				<cfset Session.Return_Structure.Errors = Errors>
				
				<cflocation url="editBooking.cfm?#urltoken##variables.dateValue#" addToken="no"> 
			</CFIF>
				
			<!--- <cfif IsDefined("Form.Section1")>
				<cfset Variables.Section1 = 1>
			</cfif>
			<cfif IsDefined("Form.Section2")>
				<cfset Variables.Section2 = 1>
			</cfif>
			<cfif IsDefined("Form.Section3")>
				<cfset Variables.Section3 = 1>
			</cfif> --->
			
			<!-- Gets all Bookings that would be affected by the requested booking --->
			<cfset Variables.StartDate = #CreateODBCDate(Variables.StartDate)#>
			<cfset Variables.EndDate = #CreateODBCDate(Variables.EndDate)#>
			
			<p>Please confirm the following information.</p>
			<cfform action="editBooking_action.cfm?#urltoken#&referrer=#URLEncodedFormat(url.referrer)##variables.dateValue#" method="post" enablecab="No" name="bookingreq" preservedata="Yes">
			<cfoutput><input type="hidden" name="BookingID" value="#Variables.BookingID#" />
			<div style="font-weight:bold;">Booking:</div>
			<table style="width:100%; padding-left:15px;" align="center" >
				<tr>
					<td id="Vessel" align="left" style="width:20%;">Vessel:</td>
					<td headers="Vessel" style="width:80%;"><cfoutput>#getData.VesselName#</cfoutput></td>
				</tr>
				<tr>
					<td id="Company" align="left">Company:</td>
					<td headers="Company"><cfoutput>#getData.CompanyName#</cfoutput></td>
				</tr>		
				<tr>
					<td id="Agent" align="left">Agent:</td>
					<td headers="Agent"><input type="hidden" name="userID" value="<cfoutput>#Variables.userID#</cfoutput>" />
				</tr>
				<tr>
					<td id="Start" align="left">Start Date:</td>
					<td headers="Start"><input type="hidden" name="StartDate" value="<cfoutput>#Variables.StartDate#</cfoutput>)" /><cfoutput>#DateFormat(Variables.StartDate, 'mmm d, yyyy'" />
				</tr>
				<tr>
					<td id="End" align="left">End Date:</td>
					<td headers="End"><input type="hidden" name="EndDate" value="<cfoutput>#Variables.EndDate#</cfoutput>)" /><cfoutput>#DateFormat(Variables.EndDate, 'mmm d, yyyy'" />
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
					<td headers="Length"><cfoutput>#getData.Length# m</cfoutput></td>
				</tr>
				<tr>
					<td id="Width" align="left">Width:</td>
					<td headers="Width"><cfoutput>#getData.Width# m</cfoutput></td>
				</tr>
				<cfif getData.Status EQ "C">
				<tr>
					<td id="Sections" align="left">Sections:</td>
					<td headers="Sections">
						<CFIF Variables.Section1>Section 1<input type="hidden" name="Section1" value="true" />
						<CFIF Variables.Section2><CFIF Variables.Section1> &amp; </CFIF>Section 2<input type="hidden" name="Section2" value="true" />
						<CFIF Variables.Section3><CFIF Variables.Section1 OR Variables.Section2> &amp; </CFIF>Section 3<input type="hidden" name="Section3" value="true" />
					</td>
				</tr>
				</cfif>
			</table>
			
			<br />
			<table style="width:100%;" cellspacing="0" cellpadding="1" border="0" align="center">
			
			
				<tr>
					<td colspan="2" align="center">
						<!--a href="javascript:EditSubmit('bookingreq');" class="textbutton">Submit</a-->
						<!---input type="submit" name="submitForm" class="textbutton" value="submit">
						<a href="javascript:history.go(-1);" class="textbutton">Back</a>
						<cfoutput><a href="bookingmanage.cfm?#urltoken#" class="textbutton">Cancel</a></cfoutput>
						<br--->
						<input type="submit" value="Confirm" class="textbutton" />
						<cfoutput><input type="button" value="Back" class="textbutton" onclick="self.location.href='editBooking.cfm?#urltoken#&referrer=#URLEncodedFormat(url.referrer)##variables.dateValue#'" />
						<cfoutput><input type="button" value="Cancel" onclick="self.location.href='#returnTo#?#urltoken#&bookingID=#variables.bookingID#&referrer=#URLEncodedFormat(url.referrer)##variables.dateValue#'" class="textbutton" />
						<!---<a href="javascript:formReset('bookingreq');">test reset</a>--->
					</td>
				</tr>
			</table>
			
			</cfform>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
