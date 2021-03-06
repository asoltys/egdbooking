<cfsavecontent variable="js">
	<cfoutput>
	<meta name="dcterms.title" content="PWGSC - ESQUIMALT GRAVING DOCK - Edit Booking">
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta name="dcterms.description" content="" />
	<meta name="dcterms.subject" title="gccore" content="" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Booking</title>
	<script type="text/javascript">
		/* <![CDATA[ */
		function EditSubmit ( selectedform )
			{
			  document.forms[selectedform].submit();
			}
		var bookingLength = 2;
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
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm"> &gt;
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
				<h1 id="wb-cont">
						<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
						Edit Booking Information
						<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
						</h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<!------------------------------------------------------------------------------------------------------------>
				<cfparam name="Variables.BRID" default="">
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
					<cfif isDefined("form.BRID")>
						<cfset Variables.BRID = #form.BRID#>
					</cfif>
				</cfif>

				<cfif (NOT IsDefined("Form.BRID") OR Form.BRID eq '') AND (NOT IsDefined("URL.BRID") OR URL.BRID eq '') AND NOT IsDefined("Session.Return_Structure")>
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
								Companies.CID, Bookings.UID
						FROM	Vessels, Docks, Bookings, Companies
						WHERE	Vessels.VNID = Bookings.VNID
						AND		Vessels.CID = Companies.CID
						AND		Docks.BRID = Bookings.BRID
						AND		Bookings.BRID = <cfqueryparam value="#Variables.BRID#" cfsqltype="cf_sql_integer" />
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
				<cfelseif (IsDefined("Form.BRID") AND Form.BRID neq '') OR (IsDefined("URL.BRID") AND URL.BRID neq '')>
					<CFIF IsDefined("Form.BRID")>
						<cfset Variables.BRID = Form.BRID>
					<CFELSEIF IsDefined("URL.BRID")>
						<cfset Variables.BRID = URL.BRID>
					</CFIF>
					<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT	Vessels.Name AS VesselName,
								Bookings.StartDate, Bookings.EndDate, Bookings.BookingTime,
								Status, Section1, Section2, Section3,
								Companies.Name AS CompanyName,
								Companies.CID, Bookings.UID
						FROM	Vessels, Docks, Bookings, Companies
						WHERE	Vessels.VNID = Bookings.VNID
							AND	Vessels.CID = Companies.CID
							AND	Docks.BRID = Bookings.BRID
							AND	Bookings.BRID = <cfqueryparam value="#Variables.BRID#" cfsqltype="cf_sql_integer" />
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
					SELECT	Users.UID, lastname + ', ' + firstname AS UserName
					FROM	Users INNER JOIN UserCompanies ON Users.UID = UserCompanies.UID
							INNER JOIN Companies ON UserCompanies.CID = Companies.CID
					WHERE	Companies.CID = <cfqueryparam value="#getBooking.CID#" cfsqltype="cf_sql_integer" /> AND Users.Deleted = 0
							AND UserCompanies.Deleted = 0 AND UserCompanies.Approved = 1
					ORDER BY lastname, firstname
				</cfquery>

				<cfif url.referrer NEQ "Booking Details">
					<cfset variables.referrer = "Edit Booking">
				<cfelse>
					<cfset variables.referrer = "Booking Details">
				</cfif>

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

				<cfform action="editBooking_process.cfm?#urltoken#&referrer=#URLEncodedFormat(variables.referrer)##variables.dateValue#" method="post" id="editBookingForm" preservedata="Yes">
				<cfoutput>
				<input type="hidden" name="BRID" value="#Variables.BRID#" />

				<table style="width:100%;">
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
							<td headers="Agent"><cfselect name="UID" query="getAgents" display="UserName" value="UID" selected="#getBooking.UID#" /></td>
						<cfelse>
							<td headers="Agent">No agents currently registered.</td>
						</cfif>
					</tr>
					<tr>
						<td id="Start">Start Date:</td>
						<td headers="Start">
							<cfoutput>
							<cfinput id="startDate" type="text" name="startDate" message="Please enter a start date." validate="date" required="yes" class="datepicker startDate" value="#DateFormat(startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" /> #language.dateform#</cfoutput>
						</td>
					</tr>
					<tr>
						<td id="End">End Date:</td>
						<td headers="End">
							<cfoutput>
							<cfinput id="endDate" type="text" name="endDate" message="Please enter an end date." validate="date" required="yes" class="datepicker endDate" value="#DateFormat(endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" /> #language.dateform#</cfoutput>
						</td>
					</tr>
					<tr>
						<td id="bookingDT">Booking Date:</td>
						<td headers="bookingDT">
							<cfoutput>
								<cfinput id="bookingDate" name="bookingDate" type="text" class="datepicker" value="#DateFormat(Variables.TheBookingDate, 'mm/dd/yyyy')#" size="15" maxlength="10" required="yes" message="Please enter a valid booking date." validate="date" /> #language.dateform#
              </cfoutput>
						</td>
					</tr>
          <tr>
            <td>Booking Time:</td>
            <td>
              <cfinput name="bookingTime" type="text" value="#TimeFormat(Variables.TheBookingTime, 'HH:mm:ss')#" size="5" maxlength="8" required="yes" message="Please enter a valid booking time." validate="time" /> (HH:MM)
            </td>
          </tr>
					<tr>
						<td id="Status" valign="top">Status:</td>
						<td headers="Status">
							<cfif getBooking.Status EQ "C">
								<strong>Confirmed</strong>
								<a href="javascript:EditSubmit('chgStatus_2t#BRID#');" class="textbutton">Make Tentative</a>
								<a href="javascript:EditSubmit('chgStatus_2p#BRID#');" class="textbutton">Make Pending</a>
							<cfelseif getBooking.Status EQ "T">
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
				</table>

				<table style="width:100%;">
					<cfif getBooking.Status EQ 'c'>
					<tr><td colspan="2">Please choose the sections of the dock that you wish to book</td></tr>
					<tr>
						<td id="Section1_header" style="width:25%;" align="right">&nbsp;&nbsp;&nbsp;<label for="Section1">Section 1</label></td>
						<td headers="Section1_header"><input type="checkbox" id="Section1" name="Section1" <cfoutput>#Variables.Section1#</cfoutput>></td>
					</tr>
					<tr>
						<td id="Section2_header" align="right">&nbsp;&nbsp;&nbsp;<label for="Section2">Section 2</label></td>
						<td headers="Section2_header"><input type="checkbox" id="Section2" name="Section2" <cfoutput>#Variables.Section2#</cfoutput>></td>
					</tr>
					<tr>
						<td id="Section3_header" align="right">&nbsp;&nbsp;&nbsp;<label for="Section3">Section 3</label></td>
						<td headers="Section3_header"><input type="checkbox" id="Section3" name="Section3" <cfoutput>#Variables.Section3#</cfoutput>></td>
					</tr>
					</cfif>
					<tr>
						<td colspan="2" align="center">
							<!--a href="javascript:document.editBookingForm.submitForm.click();" class="textbutton">Submit</a-->
							<input type="submit" class="textbutton" value="submit" />
							<a href="#returnTo#?#urltoken#&BRID=#variables.BRID##variables.dateValue#" class="textbutton">Cancel</a>
							<!--- <a href="bookingManage.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" class="textbutton">Cancel</a> --->
						</td>
					</tr>
				</table>
				</cfoutput>
				</cfform>
				<!--- <cfoutput>
				<form method="post" action="chgStatus_2c.cfm?startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" name="chgStatus_2c#BRID#">
					<input type="hidden" name="BRID" value="#BRID#" />
				</form>

				<form method="post" action="chgStatus_2p.cfm?startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" name="chgStatus_2p#BRID#">
					<input type="hidden" name="BRID" value="#BRID#" />
				</form>

				<form method="post" action="chgStatus_2t.cfm?startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" name="chgStatus_2t#BRID#">
					<input type="hidden" name="BRID" value="#BRID#" />
				</form>
				</cfoutput> --->
			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
