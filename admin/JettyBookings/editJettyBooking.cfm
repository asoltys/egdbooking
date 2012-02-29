<cfsavecontent variable="js">
	<cfoutput>
	<meta name=""dc.title" content="PWGSC - ESQUIMALT GRAVING DOCK - Edit Jetty Booking">
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta name="dc.subject" scheme="gccore" content="" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Jetty Booking</title>
	<script type="text/javascript">
		/* <![CDATA[ */
		function EditSubmit ( selectedform )
			{
			  document.forms[selectedform].submit();
			}
		var bookingLength = 0;
		/* ]]> */
	</script>
	<script type="text/javascript" src="#RootDir#scripts/tandemDateFixer.js"></script>
	</cfoutput>
</cfsavecontent>
<cfhtmlhead text="#js#">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFPARAM name="url.referrer" default="Booking Management">
<CFIF url.referrer eq "Booking Details">
	<CFSET returnTo = "#RootDir#comm/detail-res-book.cfm">
	<cfset variables.referrer = "Booking Details">
<CFELSE>
	<CFSET returnTo = "#RootDir#admin/JettyBookings/jettyBookingManage.cfm">
	<cfset variables.referrer = "Edit Jetty Booking">
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
			<a href="jettyBookingManage.cfm?lang=#lang#">Jetty Management</a> &gt;
			Edit Booking
			</cfoutput>
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

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<!--- Initiate Variables --------------------------------------------------------------------------------------------------->
				<cfparam name="Variables.BRID" default="">
				<cfparam name="Variables.VesselName" default="">
				<cfparam name="Variables.VNID" default="">
				<cfparam name="Variables.UID" default="">
				<cfparam name="Variables.StartDate" default="">
				<cfparam name="Variables.EndDate" default="">
				<cfparam name="Variables.Status" default="">
				<cfparam name="Variables.NorthJetty" default="0">
				<cfparam name="Variables.SouthJetty" default="0">
				<cfparam name="Variables.CompanyName" default="">
				<cfparam name="Variables.Jetty" default="">
				<cfparam name="Variables.CID" default="">

				<cfif NOT IsDefined("Session.form_Structure")>
					<cfinclude template="#RootDir#includes/build_form_struct.cfm">
					<cfinclude template="#RootDir#includes/restore_params.cfm">
				<cfelse>
					<cfinclude template="#RootDir#includes/restore_params.cfm">
					<cfif isDefined("form.BRID")>
						<cfset Variables.BRID = #form.BRID#>
					</cfif>
				</cfif>
				<cfif IsDefined("Session.Return_Structure")>
					<cfinclude template="#RootDir#includes/getStructure.cfm">
					<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT	Companies.CID, Bookings.UID, Status
						FROM	Vessels, Bookings, Companies, Jetties
						WHERE	Vessels.VNID = Bookings.VNID
						AND		Vessels.CID = Companies.CID
						AND		Jetties.BRID = Bookings.BRID
						AND		Bookings.BRID = '#Variables.BRID#'
						AND 	Bookings.Deleted = '0'
					</cfquery>
					<cfset Variables.CID = getBooking.CID>
					<cfset Variables.UID = getBooking.UID>
				<cfelseif IsDefined("Form.BRID") AND Form.BRID NEQ "">
					<cfset Variables.BRID = Form.BRID>
					<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT	Vessels.Name AS VesselName,
								Bookings.VNID,
								Bookings.StartDate, Bookings.EndDate, Bookings.BookingTime,
								Status, NorthJetty, SouthJetty,
								Companies.Name AS CompanyName,
								Companies.CID, Bookings.UID
						FROM	Vessels, Jetties, Bookings, Companies
						WHERE	Vessels.VNID = Bookings.VNID
						AND		Vessels.CID = Companies.CID
						AND		Jetties.BRID = Bookings.BRID
						AND		Bookings.BRID = '#Variables.BRID#'
						AND 	Bookings.Deleted = '0'
					</cfquery>
					<cfset Variables.VesselName = getBooking.VesselName>
					<cfset Variables.VNID = getBooking.VNID>
					<cfset Variables.StartDate = getBooking.StartDate>
					<cfset Variables.EndDate = getBooking.EndDate>
					<cfset Variables.TheBookingDate = DateFormat(getBooking.BookingTime, 'mm/dd/yyyy')>
					<cfset Variables.TheBookingTime = TimeFormat(getBooking.BookingTime, 'HH:mm:ss')>
					<cfset Variables.Status = getBooking.Status>
					<cfset Variables.NorthJetty = getBooking.NorthJetty>
					<cfset Variables.SouthJetty = getBooking.SouthJetty>
					<cfset Variables.CompanyName = getBooking.CompanyName>
					<cfset Variables.CID = getBooking.CID>
					<cfset Variables.UID = getBooking.UID>
				<cfelseif IsDefined("URL.BRID") AND URL.BRID NEQ "">
					<cfset Variables.BRID = URL.BRID>
					<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT	Vessels.Name AS VesselName,
								Bookings.VNID,
								Bookings.StartDate, Bookings.EndDate, Bookings.BookingTime,
								Status, NorthJetty, SouthJetty,
								Companies.Name AS CompanyName,
								Companies.CID, Bookings.UID
						FROM	Vessels, Jetties, Bookings, Companies
						WHERE	Vessels.VNID = Bookings.VNID
						AND		Vessels.CID = Companies.CID
						AND		Jetties.BRID = Bookings.BRID
						AND		Bookings.BRID = '#Variables.BRID#'
						AND 	Bookings.Deleted = '0'
					</cfquery>
					<cfset Variables.VesselName = getBooking.VesselName>
					<cfset Variables.VNID = getBooking.VNID>
					<cfset Variables.StartDate = getBooking.StartDate>
					<cfset Variables.EndDate = getBooking.EndDate>
					<cfset Variables.TheBookingDate = DateFormat(getBooking.BookingTime, 'mm/dd/yyyy')>
					<cfset Variables.TheBookingTime = TimeFormat(getBooking.BookingTime, 'HH:mm:ss')>
					<cfset Variables.Status = getBooking.Status>
					<cfset Variables.NorthJetty = getBooking.NorthJetty>
					<cfset Variables.SouthJetty = getBooking.SouthJetty>
					<cfset Variables.CompanyName = getBooking.CompanyName>
					<cfset Variables.CID = getBooking.CID>
					<cfset Variables.UID = getBooking.UID>
				<cfelse>
					<cflocation addtoken="no" url="#returnTo#?lang=#lang#">
				</cfif>
				<cfif IsDefined("Session.form_Structure")>
					<cfinclude template="#RootDir#includes/restore_params.cfm">
					<cfif isDefined("form.UID")>
						<cfset Variables.UID = #form.UID#>
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
						Users.UID,
						lastname + ', ' + firstname AS UserName
					FROM
						Users INNER JOIN UserCompanies
							ON Users.UID = UserCompanies.UID
						INNER JOIN Companies
							ON UserCompanies.CID = Companies.CID
					WHERE
				<!---		Companies.CID = #Variables.CID#
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


				<!-------------------------------------------------------------------------------------------------------------------------->


				<cfoutput query="getBooking">

					<form method="post" action="chgStatus_2c.cfm?#urltoken#&referrer=#URLEncodedFormat(variables.referrer)##variables.dateValue#" name="chgStatus_2c#BRID#" style="margin: 0; padding: 0; ">
						<input type="hidden" name="BRID" value="#BRID#" />
					</form>

					<form method="post" action="chgStatus_2p.cfm?#urltoken#&referrer=#URLEncodedFormat(variables.referrer)##variables.dateValue#" name="chgStatus_2p#BRID#" style="margin: 0; padding: 0; ">
						<input type="hidden" name="BRID" value="#BRID#" />
					</form>

					<form method="post" action="chgStatus_2t.cfm?#urltoken#&referrer=#URLEncodedFormat(variables.referrer)##variables.dateValue#" name="chgStatus_2t#BRID#" style="margin: 0; padding: 0; ">
						<input type="hidden" name="BRID" value="#BRID#" />
					</form>
				</cfoutput>

				<cfform action="editJettyBooking_process.cfm?#urltoken#&referrer=#URLEncodedFormat(variables.referrer)##variables.dateValue#" method="post" id="editBookingForm" preservedata="Yes">
				<cfoutput>
				<table style="width:100%;">
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
							<td headers="Agent"><cfselect name="UID" query="getAgents" display="UserName" value="UID" selected="#Variables.UID#" /></td>
						<cfelse>
							<td headers="Agent">No agents currently registered.</td>
						</cfif>
					</tr>
					<tr>
						<td id="startdate"><label for="start">Start Date:</label></td>
						<td headers="startdate">
							<cfinput type="text" name="startDate" message="Please enter a start date." validate="date" required="yes" class="datepicker startDate" value="#DateFormat(Variables.startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" /> #language.dateform#
						</td>
					</tr>
					<tr>
						<td id="enddate"><label for="end">End Date:</label></td>
						<td headers="enddate">
							<cfinput type="text" name="endDate" message="Please enter an end date." validate="date" required="yes" class="datepicker endDate" value="#DateFormat(Variables.endDate, 'mm/dd/yyyy')#" size="15" maxlength="10"> #language.dateform#
						</td>
					</tr>
					<tr>
						<td id="bookingDT">Booking Date:</td>
						<td headers="bookingDT">
							<cfoutput>
								<cfinput name="bookingDate" type="text" value="#DateFormat(Variables.TheBookingDate, 'mm/dd/yyyy')#" class="datepicker" size="15" maxlength="10" required="yes" message="Please enter a valid booking date." validate="date" /> #language.dateform#
            </td>
          </tr>
          <tr>
            <td>Booking Time:</td>
            <td>
								<cfinput name="bookingTime" type="text" value="#TimeFormat(Variables.TheBookingTime, 'HH:mm:ss')#" size="5" maxlength="8" required="yes" message="Please enter a valid booking time." validate="time" /> (HH:MM)
							</cfoutput>
						</td>
					</tr>
					<tr>
						<td id="Status" valign="top">Status:</td>
						<td headers="Status">
							<cfif variables.Status EQ "C">
								<strong>Confirmed</strong>
								<a href="javascript:EditSubmit('chgStatus_2t#BRID#');" class="textbutton">Make Tentative</a>
								<a href="javascript:EditSubmit('chgStatus_2p#BRID#');" class="textbutton">Make Pending</a>
							<cfelseif variables.Status EQ "T">
								<a href="javascript:EditSubmit('chgStatus_2c#BRID#');" class="textbutton">Make Confirmed</a>
								<strong>Tentative</strong>
								<a href="javascript:EditSubmit('chgStatus_2p#BRID#');" class="textbutton">Make Pending</a>
							<cfelse>
								<a href="javascript:EditSubmit('chgStatus_2c#BRID#');" class="textbutton">Make Confirmed</a>
								<a href="javascript:EditSubmit('chgStatus_2t#BRID#');" class="textbutton">Make Tentative</a>
								<a href="javascript:EditSubmit('chgStatus_2p#BRID#');" class="textbutton">Make Pending</a>
								<cfif getBooking.Status EQ "PC">
									<a href="javascript:EditSubmit('deny#BRID#');" class="textbutton">Deny Request</a>
								</cfif>
							</cfif>
						</td>
					</tr>
					<tr>
						<td colspan="2">Please select the jetty that you wish to book:</td>
					</tr>
					<tr>
						<td id="nj">&nbsp;&nbsp;&nbsp;<label for="northJetty">North Landing Wharf</label></td>
						<td headers="nj"><input type="radio" name="Jetty" id="northJetty" value="north" <cfif Variables.NorthJetty EQ 1>checked="true"</cfif> /></td>
					</tr>
					<tr>
						<td id="sj">&nbsp;&nbsp;&nbsp;<label for="southJetty">South Jetty</label></td>
						<td headers="sj"><input type="radio" name="Jetty" id="southJetty" value="south" <cfif Variables.SouthJetty EQ 1>checked="true"</cfif> /></td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<input type="submit" name="submitForm" class="textbutton" value="submit" />
							<cfif isdefined('overwrite')>
							<input type="submit" name="submitForm" class="textbutton" value="overwrite" />
							</cfif>
							<a href="#returnTo#?#urltoken#&BRID=#variables.BRID##variables.dateValue####variables.BRID#" class="textbutton">Cancel</a>
							<br />
							<input type="Hidden" name="BRID" value="#Variables.BRID#" />
							<input type="Hidden" name="Submitted" value="yes" />
						</td>
					</tr>
				</table>
				</cfoutput>


				</cfform>

			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
