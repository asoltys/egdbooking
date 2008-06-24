<!---cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/build_form_struct.cfm"--->

<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Jetty Booking"">
	<meta name=""keywords"" lang=""eng"" content="""">
	<meta name=""description"" lang=""eng"" content="""">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Jetty Booking</title>">

<CFPARAM name="url.referrer" default="Booking Management">
<CFIF url.referrer eq "Booking Details">
	<CFSET returnTo = "#RootDir#comm/getBookingDetail.cfm">
	<cfset variables.referrer = "Booking Details">
<CFELSE>
	<CFSET returnTo = "#RootDir#admin/JettyBookings/jettybookingManage.cfm">
	<cfset variables.referrer = "Edit Jetty Booking">
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
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<A href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
			<CFELSE>
				 <a href="#RootDir#reserve-book/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			<a href="jettyBookingManage.cfm?lang=#lang#">Jetty Management</A> &gt;
			Edit Booking
			</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Edit Jetty Booking Information
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<cfinclude template="#RootDir#includes/admin_menu.cfm"><br>
				
				<!--- Initiate Variables --------------------------------------------------------------------------------------------------->
				<cfparam name="Variables.BookingID" default="">
				<cfparam name="Variables.VesselName" default="">
				<cfparam name="Variables.VesselID" default="">
				<cfparam name="Variables.UserID" default="">
				<cfparam name="Variables.StartDate" default="">
				<cfparam name="Variables.EndDate" default="">
				<cfparam name="Variables.Status" default="">
				<cfparam name="Variables.NorthJetty" default="0">
				<cfparam name="Variables.SouthJetty" default="0">
				<cfparam name="Variables.CompanyName" default="">
				<cfparam name="Variables.Jetty" default="">
				<cfparam name="Variables.CompanyID" default="">
				
				<cfif NOT IsDefined("Session.form_Structure")>
					<cfinclude template="#RootDir#includes/build_form_struct.cfm">
					<cfinclude template="#RootDir#includes/restore_params.cfm">
				<cfelse>
					<cfinclude template="#RootDir#includes/restore_params.cfm">
					<cfif isDefined("form.bookingID")>
						<cfset Variables.bookingID = #form.bookingID#>
					</cfif>
				</cfif>
				<cfif IsDefined("Session.Return_Structure")> 
					<cfinclude template="#RootDir#includes/getStructure.cfm">
					<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT	Companies.CompanyID, Bookings.UserID, Status
						FROM	Vessels, Bookings, Companies, Jetties
						WHERE	Vessels.VesselID = Bookings.VesselID
						AND		Vessels.CompanyID = Companies.CompanyID
						AND		Jetties.BookingID = Bookings.BookingID
						AND		Bookings.BookingID = '#Variables.BookingID#'
						AND 	Bookings.Deleted = '0'
					</cfquery>
					<cfset Variables.CompanyID = getBooking.CompanyID>
					<cfset Variables.UserID = getBooking.UserID>
				<cfelseif IsDefined("Form.BookingID") AND Form.BookingID NEQ "">
					<cfset Variables.BookingID = Form.BookingID>	
					<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT	Vessels.Name AS VesselName,
								Bookings.VesselID,
								Bookings.StartDate, Bookings.EndDate, Bookings.BookingTime,
								Status, NorthJetty, SouthJetty, 
								Companies.Name AS CompanyName, 
								Companies.CompanyID, Bookings.UserID
						FROM	Vessels, Jetties, Bookings, Companies
						WHERE	Vessels.VesselID = Bookings.VesselID
						AND		Vessels.CompanyID = Companies.CompanyID
						AND		Jetties.BookingID = Bookings.BookingID
						AND		Bookings.BookingID = '#Variables.BookingID#'
						AND 	Bookings.Deleted = '0'
					</cfquery>
					<cfset Variables.VesselName = getBooking.VesselName>
					<cfset Variables.VesselID = getBooking.VesselID>
					<cfset Variables.StartDate = getBooking.StartDate>
					<cfset Variables.EndDate = getBooking.EndDate>
					<cfset Variables.TheBookingDate = DateFormat(getBooking.BookingTime, 'mm/dd/yyyy')>
					<cfset Variables.TheBookingTime = TimeFormat(getBooking.BookingTime, 'HH:mm:ss')>
					<cfset Variables.Status = getBooking.Status>
					<cfset Variables.NorthJetty = getBooking.NorthJetty>
					<cfset Variables.SouthJetty = getBooking.SouthJetty>
					<cfset Variables.CompanyName = getBooking.CompanyName>
					<cfset Variables.CompanyID = getBooking.CompanyID>
					<cfset Variables.UserID = getBooking.UserID>
				<cfelseif IsDefined("URL.BookingID") AND URL.BookingID NEQ "">
					<cfset Variables.BookingID = URL.BookingID>
					<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT	Vessels.Name AS VesselName,
								Bookings.VesselID,
								Bookings.StartDate, Bookings.EndDate, Bookings.BookingTime, 
								Status, NorthJetty, SouthJetty, 
								Companies.Name AS CompanyName, 
								Companies.CompanyID, Bookings.UserID
						FROM	Vessels, Jetties, Bookings, Companies
						WHERE	Vessels.VesselID = Bookings.VesselID
						AND		Vessels.CompanyID = Companies.CompanyID
						AND		Jetties.BookingID = Bookings.BookingID
						AND		Bookings.BookingID = '#Variables.BookingID#'
						AND 	Bookings.Deleted = '0'
					</cfquery>
					<cfset Variables.VesselName = getBooking.VesselName>
					<cfset Variables.VesselID = getBooking.VesselID>
					<cfset Variables.StartDate = getBooking.StartDate>
					<cfset Variables.EndDate = getBooking.EndDate>
					<cfset Variables.TheBookingDate = DateFormat(getBooking.BookingTime, 'mm/dd/yyyy')>
					<cfset Variables.TheBookingTime = TimeFormat(getBooking.BookingTime, 'HH:mm:ss')>
					<cfset Variables.Status = getBooking.Status>
					<cfset Variables.NorthJetty = getBooking.NorthJetty>
					<cfset Variables.SouthJetty = getBooking.SouthJetty>
					<cfset Variables.CompanyName = getBooking.CompanyName>
					<cfset Variables.CompanyID = getBooking.CompanyID>
					<cfset Variables.UserID = getBooking.UserID>
				<cfelse>
					<cflocation addtoken="no" url="#returnTo#?lang=#lang#">
				</cfif>
				<cfif IsDefined("Session.form_Structure")>
					<cfinclude template="#RootDir#includes/restore_params.cfm">
					<cfif isDefined("form.userID")>
						<cfset Variables.userID = #form.userID#>
						<cfset Variables.StartDate = #form.startDate#>
						<cfset Variables.EndDate = #form.endDate#>
						<cfif isDefined("form.jetty") AND form.jetty EQ "north">
							<cfset Variables.NorthJetty = 1>
							<cfset Variables.SouthJetty = 0>
						<cfelseif isDefined("form.jetty") AND form.jetty EQ "south">
							<cfset Variables.SouthJetty = 1>
							<cfset Variables.NorthJetty = 0>
						</cfif>
					</cfif>
				</cfif>
				<cfquery name="getAgents" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT 
						Users.UserID, 
						lastname + ', ' + firstname AS UserName 
					FROM 
						Users INNER JOIN UserCompanies 
							ON Users.UserID = UserCompanies.UserID 
						INNER JOIN Companies 
							ON UserCompanies.CompanyID = Companies.CompanyID 
					WHERE 
				<!---		Companies.companyID = #Variables.companyID# 
					AND --->
						Users.Deleted = 0 
					AND 
						UserCompanies.Deleted = 0 
					AND 
						UserCompanies.Approved = 1 
					ORDER BY 
						lastname, 
						firstname
				</cfquery>
				
				
				<!---cfif isDefined("form.vesselID") AND form.vesselID NEQ "">
					<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT	Name
						FROM	Vessels
						WHERE	VesselID = "#Form.vesselID#"
					</cfquery>
					<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT	Name
						FROM	Companies
						WHERE	CompanyID = "#Form.CompanyID#"
					</cfquery>
				
					<cfset variables.vesselName = #getVessel.name#>
					<cfset variables.companyName = #getCompany.name#>
					<cfset variables.vesselID = #form.vesselID#>
					<cfset variables.userID = #form.userID#>
					<cfset variables.startDate = #form.startDate#>
					<cfset variables.endDate = #form.endDate#>
					<cfset variables.jetty = #form.vesselID#>
					<cfset variables.confirmed = #form.confirmed#>
					<cfset variables.companyID = #form.companyID#>
				</cfif--->
				
				<!-------------------------------------------------------------------------------------------------------------------------->
				
				
				<cfoutput query="getBooking">
					<!--- <form method="post" action="jettyBookingManage_action.cfm?#urltoken#&referrer=#URLEncodedFormat(variables.referrer)#" name="confBooking#bookingID#">
						<input type="hidden" name="ID" value="#bookingid#">
						<input type="hidden" name="Status" value="C">
					</form>
					
					<form method="post" action="jettyBookingManage_action.cfm?#urltoken#&referrer=#URLEncodedFormat(variables.referrer)#" name="UnConfBooking#bookingID#">
						<input type="hidden" name="ID" value="#bookingid#">
						<input type="hidden" name="Status" value="P">
					</form> --->
									
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
				
				<cfinclude template="#RootDir#includes/calendar_js.cfm">
				
				<cfform action="editJettyBooking_process.cfm?#urltoken#&referrer=#URLEncodedFormat(variables.referrer)##variables.dateValue#" method="POST" enablecab="No" name="editBookingForm" preservedata="Yes">
				<cfoutput>
				<table width="100%">
					<tr>
						<td id="Vessel">Vessel:</td>
						<td headers="Vessel">#Variables.VesselName#</td>
					</tr>
					<tr>
						<td id="Company">Company:</td>
						<td headers="Company">#Variables.companyName#</td>
					</tr>
					<tr>
						<td id="Agent">Agent:</td>
						<cfif getAgents.recordCount GE 1>
							<td headers="Agent"><cfselect name="userID" query="getAgents" display="UserName" value="UserID" selected="#Variables.UserID#" /></td>
						<cfelse>
							<td headers="Agent">No agents currently registered.</td>
						</cfif>
					</tr>
					<tr>
						<td id="startdate"><label for="start">Start Date:</label></td>
						<td headers="startdate">
							<!---input class="textField" type="Text" name="startDateShow" id="start" disabled value="#DateFormat(startDate, 'mmm d, yyyy')#" size="17"--->
							<cfinput name="startDate" type="text" value="#DateFormat(Variables.startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" required="yes" message="Please enter a start date." validate="date" class="textField" onChange="setLaterDate('self', 'editBookingForm', #Variables.bookingLen#)" onFocus="setEarlierDate('self', 'editBookingForm', #Variables.bookingLen#)"> <font class="light">#language.dateform#</font>
							<a href="javascript:void(0);" onclick="javascript:getCalendar('editBookingForm', 'start')" class="textbutton">calendar</a>
							<!---a href="javascript:void(0);" onClick="javascript:document.editBookingForm.startDateShow.value=''; document.editBookingForm.startDate.value='';" class="textbutton">clear</a--->
						</td>
					</tr>
					<tr>
						<td id="enddate"><label for="end">End Date:</label></td>
						<td headers="enddate">
							<cfinput name="endDate" type="text" value="#DateFormat(Variables.endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" required="yes" message="Please enter an end date." validate="date" class="textField"> <font class="light" onChange="setEarlierDate('self', 'editBookingForm', #Variables.bookingLen#)" onFocus="setLaterDate('self', 'editBookingForm', #Variables.bookingLen#)">#language.dateform#</font>
							<a href="javascript:void(0);" onclick="javascript:getCalendar('editBookingForm', 'end')" class="textbutton">calendar</a>
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
					<tr>
						<td id="Status" valign="top">Status:</td>
						<td headers="Status">
							<cfif variables.Status EQ "C">
								<strong>Confirmed</strong>
								<a href="javascript:EditSubmit('chgStatus_2t#BookingID#');" class="textbutton">Make Tentative</a>
								<a href="javascript:EditSubmit('chgStatus_2p#BookingID#');" class="textbutton">Make Pending</a>
							<cfelseif variables.Status EQ "T">
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
					<tr>
						<td colspan="2">Please select the jetty that you wish to book:</td>
					</tr>
					<tr>
						<td id="nj">&nbsp;&nbsp;&nbsp;<label for="northJetty">North Landing Wharf</label></td>
						<td headers="nj"><input type="radio" name="Jetty" id="northJetty" value="north" <cfif Variables.NorthJetty EQ 1>checked</cfif>></td>		
					</tr>
					<tr>
						<td id="sj">&nbsp;&nbsp;&nbsp;<label for="southJetty">South Jetty</label></td>
						<td headers="sj"><input type="radio" name="Jetty" id="southJetty" value="south" <cfif Variables.SouthJetty EQ 1>checked</cfif>></td>
					</tr>		
					<tr>
						<td colspan="2" align="center">
							<input type="submit" name="submitForm" class="textbutton" value="submit">
							<cfif isdefined('overwrite')>
							<input type="submit" name="submitForm" class="textbutton" value="overwrite">
							</cfif>
							<input type="button" value="Cancel" onClick="self.location.href='#returnTo#?#urltoken#&bookingID=#variables.bookingID##variables.dateValue####variables.bookingID#'" class="textbutton">
							<br>
							<input type="Hidden" name="BookingID" value="#Variables.BookingID#">
							<!---input type="Hidden" name="CompanyID" value="#Variables.CompanyID#"--->
							<input type="Hidden" name="Submitted" value="yes">
						</td>
					</tr>
				</table>
				</cfoutput>
				
				
				</cfform>

			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
