<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Booking"">
	<meta name=""keywords"" lang=""eng"" content="""">
	<meta name=""description"" lang=""eng"" content="""">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""" />
	<meta name=""dc.date.published"" content=""2005-07-25"" />
	<meta name=""dc.date.reviewed"" content=""2005-07-25"" />
	<meta name=""dc.date.modified"" content=""2005-07-25"" />
	<meta name=""dc.date.created"" content=""2005-07-25"" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Booking</title>">

<CFPARAM name="url.referrer" default="Booking Management">
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
<script language="JavaScript" type="text/javascript">
	<!--
	function EditSubmit ( selectedform )
	{
	  document.forms[selectedform].submit() ;
	}
	//-->
</script>
<!-- End JavaScript Block -->

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm"> &gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt; 
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			<a href="bookingManage.cfm?lang=#lang#">Drydock Management</a> &gt;
			Edit Booking Information
			</cfoutput>
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

				<!------------------------------------------------------------------------------------------------------------>
				<cfparam name="Variables.BookingID" default="">
				<cfparam name="Variables.StartDate" default="">
				<cfparam name="Variables.EndDate" default="">
				<cfparam name="Variables.Section1" default="">
				<cfparam name="Variables.Section2" default="">
				<cfparam name="Variables.Section3" default="">
				
				<cfif NOT IsDefined("Session.form_Structure")>
					<cfinclude template="#RootDir#includes/build_form_struct.cfm">
					<cfinclude template="#RootDir#includes/restore_params.cfm">
				<cfelse>
					<cfinclude template="#RootDir#includes/restore_params.cfm">
					<cfif isDefined("form.bookingID")>
						<cfset Variables.bookingID = #form.bookingID#>
					</cfif>
				</cfif>
				
				<cfif (NOT IsDefined("Form.BookingID") OR Form.BookingID eq '') AND (NOT IsDefined("URL.BookingID") OR URL.BookingID eq '') AND NOT IsDefined("Session.Return_Structure")>
					<cflocation addtoken="no" url="#RootDir#admin/DockBookings/bookingManage.cfm?#urltoken#">
				</cfif>
				
				<cfif IsDefined("Session.Return_Structure")>
					<!--- Populate the Variables Structure with the Return Structure.
							Also display any errors returned --->
					<cfinclude template="#RootDir#includes/getStructure.cfm">
					<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT	Vessels.Name AS VesselName,
								Bookings.StartDate, Bookings.EndDate,
								Status, Docks.Section1, Docks.Section2, Docks.Section3,
								Companies.Name AS CompanyName, 
								Companies.CompanyID, Bookings.UserID
						FROM	Vessels, Docks, Bookings, Companies
						WHERE	Vessels.VesselID = Bookings.VesselID
						AND		Vessels.CompanyID = Companies.CompanyID
						AND		Docks.BookingID = Bookings.BookingID
						AND		Bookings.BookingID = '#Variables.BookingID#'
					</cfquery>
					<cfif Variables.Section1 EQ 1>
						<cfset Variables.Section1 = "checked">
					</cfif>
					<cfif Variables.Section2 EQ 1>
						<cfset Variables.Section2 = "checked">
					</cfif>
					<cfif Variables.Section3 EQ 1>
						<cfset Variables.Section3 = "checked">
					</cfif>
				<cfelseif (IsDefined("Form.BookingID") AND Form.BookingID neq '') OR (IsDefined("URL.BookingID") AND URL.BookingID neq '')>
					<CFIF IsDefined("Form.BookingID")>
						<cfset Variables.BookingID = Form.BookingID>
					<CFELSEIF IsDefined("URL.BookingID")>
						<cfset Variables.BookingID = URL.BookingID>
					</CFIF>
					<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT	Vessels.Name AS VesselName,
								Bookings.StartDate, Bookings.EndDate, Bookings.BookingTime,
								Status, Section1, Section2, Section3,
								Companies.Name AS CompanyName, 
								Companies.CompanyID, Bookings.UserID
						FROM	Vessels, Docks, Bookings, Companies
						WHERE	Vessels.VesselID = Bookings.VesselID
							AND	Vessels.CompanyID = Companies.CompanyID
							AND	Docks.BookingID = Bookings.BookingID
							AND	Bookings.BookingID = '#Variables.BookingID#'
					</cfquery>
					
					<cfset Variables.StartDate = getBooking.StartDate>
					<cfset Variables.EndDate = getBooking.EndDate>
					<cfset Variables.TheBookingDate = DateFormat(getBooking.BookingTime, 'mm/dd/yyyy')>
					<cfset Variables.TheBookingTime = TimeFormat(getBooking.BookingTime, 'HH:mm:ss')>
					
					<cfif getBooking.Section1 EQ 1>
						<cfset Variables.Section1 = "checked">
					</cfif>
					<cfif getBooking.Section2 EQ 1>
						<cfset Variables.Section2 = "checked">
					</cfif>
					<cfif getBooking.Section3 EQ 1>
						<cfset Variables.Section3 = "checked">
					</cfif>
				</cfif>
				
				<cfif IsDefined("Session.form_Structure")>
					<cfif isDefined("form.startDate")>
						<cfset Variables.StartDate = #form.startDate#>
						<cfset Variables.EndDate = #form.endDate#>
						<cfif isDefined("form.section1")><cfset Variables.Section1 = "checked"><cfelse><cfset Variables.Section1 = ""></cfif>
						<cfif isDefined("form.section2")><cfset Variables.Section2 = "checked"><cfelse><cfset Variables.Section2 = ""></cfif>
						<cfif isDefined("form.section3")><cfset Variables.Section3 = "checked"><cfelse><cfset Variables.Section3 = ""></cfif>
					</cfif>
				</cfif>
					
				<cfquery name="getAgents" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	Users.UserID, lastname + ', ' + firstname AS UserName
					FROM	Users INNER JOIN UserCompanies ON Users.UserID = UserCompanies.UserID
							INNER JOIN Companies ON UserCompanies.CompanyID = Companies.CompanyID
					WHERE	Companies.companyID = #getBooking.companyID# AND Users.Deleted = 0 
							AND UserCompanies.Deleted = 0 AND UserCompanies.Approved = 1
					ORDER BY lastname, firstname
				</cfquery>
				
				<cfif url.referrer NEQ "Booking Details">
					<cfset variables.referrer = "Edit Booking">
				<cfelse>
					<cfset variables.referrer = "Booking Details">
				</cfif>
				
				<CFINCLUDE template="#RootDir#includes/calendar_js.cfm">
				
				<cfoutput query="getBooking">
					<form method="post" action="chgStatus_2c.cfm?#urltoken#&referrer=#URLEncodedFormat(variables.referrer)##variables.dateValue#" name="chgStatus_2c#BookingID#" style="margin: 0; padding: 0; ">
						<input type="hidden" name="BookingID" value="#BookingID#">
					</form>
					
					<form method="post" action="chgStatus_2p.cfm?#urltoken#&referrer=#URLEncodedFormat(variables.referrer)##variables.dateValue#" name="chgStatus_2p#BookingID#" style="margin: 0; padding: 0; ">
						<input type="hidden" name="BookingID" value="#BookingID#">
					</form>
					
					<form method="post" action="chgStatus_2t.cfm?#urltoken#&referrer=#URLEncodedFormat(variables.referrer)##variables.dateValue#" name="chgStatus_2t#BookingID#" style="margin: 0; padding: 0; ">
						<input type="hidden" name="BookingID" value="#BookingID#">
					</form>
				</cfoutput>
				
				<cfform action="editBooking_process.cfm?#urltoken#&referrer=#URLEncodedFormat(variables.referrer)##variables.dateValue#" method="POST" enablecab="No" name="editBookingForm" preservedata="Yes">
				<cfoutput>
				<input type="hidden" name="BookingID" value="#Variables.BookingID#">
				
				<table width="100%">
					<tr>
						<td id="Vessel">Vessel:</td>
						<td headers="Vessel">#getBooking.vesselName#</td>
					</tr>
					<tr>
						<td id="Company">Company:</td>
						<td headers="Company">#getBooking.companyName#</td>
					</tr>
					<tr>
						<td id="Agent">Agent:</td>
						<cfif getAgents.recordCount GE 1>
							<td headers="Agent"><cfselect name="userID" query="getAgents" display="UserName" value="UserID" selected="#getBooking.userID#" /></td>
						<cfelse>
							<td headers="Agent">No agents currently registered.</td>
						</cfif>
					</tr>
					<tr>
						<td id="Start">Start Date:</td>
						<td headers="Start">
							<cfoutput>
							<!---input class="textField" type="Text" name="startDateShow" id="start" disabled value="#DateFormat(startDate, 'mmm d, yyyy')#" size="17"--->
							<cfinput name="startDate" type="text" value="#DateFormat(startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" required="yes" message="Please enter a start date." validate="date" class="textField" onChange="setLaterDate('self', 'editBookingForm', #Variables.bookingLen#)" onFocus="setEarlierDate('self', 'editBookingForm', #Variables.bookingLen#)"> #language.dateform#</cfoutput>
							<a href="javascript:void(0);" onclick="javascript:getCalendar('editBookingForm', 'start')" class="textbutton">calendar</a>
							<!---a href="javascript:void(0);" onClick="javascript:document.bookingreq.startDateShow.value=''; document.editBookingForm.startDate.value='';" class="textbutton">clear</a--->
						</td>
					</tr>
					<tr>
						<td id="End">End Date:</td>
						<td headers="End">
							<cfoutput>
							<!---input type="text" name="endDateShow" id="end" class="textField" disabled value="#DateFormat(endDate, 'mmm d, yyyy')#" size="17"---> 
							<cfinput name="endDate" type="text" value="#DateFormat(endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" required="yes" message="Please enter an end date." validate="date" class="textField" onChange="setEarlierDate('self', 'editBookingForm', #Variables.bookingLen#)" onFocus="setLaterDate('self', 'editBookingForm', #Variables.bookingLen#)"> #language.dateform#</cfoutput>
							<a href="javascript:void(0);" onclick="javascript:getCalendar('editBookingForm', 'end')" class="textbutton">calendar</a>
							<!---a href="javascript:void(0);" onClick="javascript:document.editBookingForm.startDateShow.value=''; document.editBookingForm.startDate.value='';" class="textbutton">clear</a--->
						</td>
					</tr>
					<tr>
						<td id="bookingDT">Booking Time:</td>
						<td headers="bookingDT">
							<cfoutput>
								<cfinput name="bookingDate" type="text" value="#DateFormat(Variables.TheBookingDate, 'mm/dd/yyyy')#" size="15" maxlength="10" required="yes" message="Please enter a valid booking date." validate="date" class="textField">
								<cfinput name="bookingTime" type="text" value="#TimeFormat(Variables.TheBookingTime, 'HH:mm:ss')#" size="5" maxlength="8" required="yes" message="Please enter a valid booking time." validate="time" class="textField">
							</cfoutput>
							<a href="javascript:void(0);" onclick="javascript:getCalendar('editBookingForm', 'booking')" class="textbutton">calendar</a>
						</td>
					</tr>
				<!--- 	<tr>
						<td>Status:</td>
						<td>
							<cfif getBooking.confirmed EQ 1>
								Confirmed
								&nbsp;&nbsp;&nbsp;<a href="javascript:EditSubmit('chgStatus_2p#BookingID#');" class="textbutton">Pending</a>
								&nbsp;<a href="javascript:EditSubmit('chgStatus_2t#BookingID#');" class="textbutton">Tentative</a>
							<cfelseif getBooking.tentative EQ 1>
								Tentative
								&nbsp;&nbsp;&nbsp;<a href="javascript:EditSubmit('chgStatus_2p#BookingID#');" class="textbutton">Pending</a>
								&nbsp;<a href="javascript:EditSubmit('chgStatus_2c#BookingID#');" class="textbutton">Confirmed</a>
							<cfelse>
								Pending
								&nbsp;&nbsp;&nbsp;<a href="javascript:EditSubmit('chgStatus_2t#BookingID#');" class="textbutton">Tentative</a>
								&nbsp;<a href="javascript:EditSubmit('chgStatus_2c#BookingID#');" class="textbutton">Confirmed</a>
							</cfif>
						</td>
					</tr> --->
					<tr>
						<td id="Status" valign="top">Status:</td>
						<td headers="Status">
							<cfif getBooking.Status EQ "C">
								<strong>Confirmed</strong>
								<a href="javascript:EditSubmit('chgStatus_2t#BookingID#');" class="textbutton">Make Tentative</a>
								<a href="javascript:EditSubmit('chgStatus_2p#BookingID#');" class="textbutton">Make Pending</a>
							<cfelseif getBooking.Status EQ "T">
								<a href="javascript:EditSubmit('chgStatus_2c#BookingID#');" class="textbutton">Make Confirmed</a>
								<strong>Tentative</strong>
								<a href="javascript:EditSubmit('chgStatus_2p#BookingID#');" class="textbutton">Make Pending</a>
							<cfelse>
								<a href="javascript:EditSubmit('chgStatus_2c#BookingID#');" class="textbutton">Make Confirmed</a>
								<a href="javascript:EditSubmit('chgStatus_2t#BookingID#');" class="textbutton">Make Tentative</a>	
								<strong>Pending</strong>
								<cfif getBooking.Status EQ "Y">
									<a href="javascript:EditSubmit('deny#BookingID#');" class="textbutton">Deny Request</a>
								</cfif>
							</cfif>
						</td>
					</tr>
				</table>
				
				<table width="100%">
					<cfif getBooking.Status EQ 'c'>
					<tr><td colspan="2">Please choose the sections of the dock that you wish to book</td></tr>
					<tr>
						<td id="Section1_header" width="25%" align="right">&nbsp;&nbsp;&nbsp;<label for="Section1">Section 1</label></td>
						<td headers="Section1_header"><input type="Checkbox" id="Section1" name="Section1" <cfoutput>#Variables.Section1#</cfoutput>></td>
					</tr>
					<tr>
						<td id="Section2_header" align="right">&nbsp;&nbsp;&nbsp;<label for="Section2">Section 2</label></td>
						<td headers="Section2_header"><input type="Checkbox" id="Section2" name="Section2" <cfoutput>#Variables.Section2#</cfoutput>></td>
					</tr>
					<tr>
						<td id="Section3_header" align="right">&nbsp;&nbsp;&nbsp;<label for="Section3">Section 3</label></td>
						<td headers="Section3_header"><input type="Checkbox" id="Section3" name="Section3" <cfoutput>#Variables.Section3#</cfoutput>></td>
					</tr>
					</cfif>
					<tr>
						<td colspan="2" align="center">
							<!--a href="javascript:document.editBookingForm.submitForm.click();" class="textbutton">Submit</a-->
							<input type="submit" class="textbutton" value="submit">
							<input type="button" value="Cancel" onClick="self.location.href='#returnTo#?#urltoken#&bookingID=#variables.bookingID##variables.dateValue#'" class="textbutton">
							<!--- <a href="bookingmanage.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" class="textbutton">Cancel</a> --->
						</td>
					</tr>
				</table>
				</cfoutput>
				</cfform>
				<!--- <cfoutput>
				<form method="post" action="chgStatus_2c.cfm?startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" name="chgStatus_2c#BookingID#">
					<input type="hidden" name="BookingID" value="#BookingID#">
				</form>
				
				<form method="post" action="chgStatus_2p.cfm?startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" name="chgStatus_2p#BookingID#">
					<input type="hidden" name="BookingID" value="#BookingID#">
				</form>
				
				<form method="post" action="chgStatus_2t.cfm?startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" name="chgStatus_2t#BookingID#">
					<input type="hidden" name="BookingID" value="#BookingID#">
				</form>
				</cfoutput> --->
			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
