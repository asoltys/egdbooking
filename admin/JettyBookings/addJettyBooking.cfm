<cfsavecontent variable="js">
	<cfoutput>
	<meta name="dc.title" content="PWGSC - ESQUIMALT GRAVING DOCK - Add Jetty Booking">
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta name="dc.subject" scheme="gccore" content="" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Add Jetty Booking</title>
	<script type="text/javascript">
		/* <![CDATA[ */
		var bookingLength = 0;
		/* ]]> */
	</script>
	<script type="text/javascript" src="#RootDir#scripts/tandemDateFixer.js"></script>
	</cfoutput>
</cfsavecontent>
<cfhtmlhead text="#js#">

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT CompanyID, Name
	FROM Companies
	WHERE Deleted = 0 AND Approved = 1
	ORDER BY Name
</cfquery>


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
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt;
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			<a href="jettyBookingManage.cfm?lang=#lang#">Jetty Management</a> &gt;
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
					Create New Jetty Booking
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<cfparam name="form.compID" default="">
				<cfparam name="Variables.compID" default="#form.compID#">
				<cfparam name="Variables.vesselID" default="">
				<cfparam name="Variables.userID" default="">
				<cfparam name="form.StartDate" default="#DateAdd('d', 1, PacificNow)#">
				<cfparam name="form.EndDate" default="#DateAdd('d', 1, PacificNow)#">
				<cfparam name="Variables.StartDate" default="#form.StartDate#">
				<cfparam name="Variables.EndDate" default="#form.endDate#">
				<cfparam name="Variables.NorthJetty" default="0">
				<cfparam name="Variables.SouthJetty" default="0">
				<cfparam name="Variables.Status" default="P">
				<cfparam name="Variables.TheBookingDate" default="#CreateODBCDate(PacificNow)#">
				<cfparam name="Variables.TheBookingTime" default="#CreateODBCTime(PacificNow)#">
					<cfset override="0">
				<cfif IsDefined("Session.Return_Structure")>
					<cfinclude template="#RootDir#includes/getStructure.cfm">
					<cfset override="1">
				</cfif>
				<cfif NOT IsDefined("Session.form_Structure")>
					<cfinclude template="#RootDir#includes/build_form_struct.cfm">
					<cfinclude template="#RootDir#includes/restore_params.cfm">
				<cfelse>
					<cfinclude template="#RootDir#includes/restore_params.cfm">
					<cfif isDefined("form.vesselID")>
						<cfset Variables.compID = #form.compID#>
						<cfset Variables.vesselID = #form.vesselID#>
						<cfset Variables.userID = #form.userID#>
						<cfset Variables.StartDate = #form.startDate#>
						<cfset Variables.EndDate = #form.endDate#>
						<cfset Variables.TheBookingDate = #Form.bookingDate#>
						<cfset Variables.TheBookingTime = #Form.bookingTime#>
						<cfif isDefined("form.status")><cfset Variables.Status = form.status></cfif>
						<cfif isDefined("form.jetty") AND form.jetty EQ "north">
							<cfset Variables.NorthJetty = "1">
							<cfset Variables.SouthJetty = "0">
						<cfelseif isDefined("form.jetty") AND form.jetty EQ "south">
							<cfset Variables.SouthJetty = "1">
							<cfset Variables.NorthJetty = "0">
						</cfif>
					</cfif>
				</cfif>


				<cfform action="addJettyBooking.cfm?#urltoken#" method="post" id="chooseUserForm">
					<p><label for="selectCompany">Select Company:</label> <cfselect query="getCompanies" id="selectCompany" name="compID" value="CompanyID" display="Name" selected="#Variables.compID#" />
					&nbsp;&nbsp;&nbsp;
					<!--a href="javascript:EditSubmit('chooseUserForm');" class="textbutton">Submit</a-->
					<input type="submit" name="submitForm" class="textbutton" value="submit" />
					<cfoutput><input type="button" value="Back" onclick="self.location.href='jettybookingmanage.cfm?#urltoken#'" class="textbutton" /></cfoutput>
				</cfform>

				<cfif Variables.compID NEQ "">

					<cflock timeout=20 scope="Session" type="Exclusive">
						<cfset Session.Company = "#form.compID#">
					</cflock>

					<cfform action="addJettyBooking_process.cfm?#urltoken#" method="post" id="addBookingForm">
					<cfoutput>

					<cfquery name="getVessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT VesselID, Name
						FROM Vessels
						WHERE CompanyID = #Variables.compID# AND Deleted = 0
						ORDER BY Name
					</cfquery>

					<cfquery name="getAgents" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT	Users.UserID, lastname + ', ' + firstname AS UserName
						FROM	Users INNER JOIN UserCompanies ON Users.UserID = UserCompanies.UserID
								INNER JOIN Companies ON UserCompanies.CompanyID = Companies.CompanyID
						WHERE	Companies.companyID = #Variables.compID# AND Users.Deleted = 0
								AND UserCompanies.Deleted = 0 AND UserCompanies.Approved = 1
						ORDER BY lastname, firstname
					</cfquery>


					<table align="center" style="padding-left:10px;" style="width:100%;">
						<tr>
							<cfquery name="getCompanyName" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
								SELECT Name
								FROM Companies
								WHERE CompanyID = #Variables.compID#
							</cfquery>

							<td id="Company" style="width:20%;">Company:</td>
							<td headers="Company" style="width:80%;"><input type="hidden" name="companyID" value="#variables.compID#" />
						</tr>
						<tr>
							<td id="Vessel">Vessel:</td>
							<cfif getVessels.recordCount GE 1>
								<td headers="Vessel"><cfselect name="vesselID" query="getVessels" display="Name" value="VesselID" selected="#Variables.vesselID#" /></td>
							<cfelse>
								<td headers="Vessel">No ships currently registered.</td>
							</cfif>
						</tr>
						<cfif getVessels.recordCount GE 1>
							<tr>
								<td id="">Agent:</td>
								<cfif getAgents.recordCount GE 1>
									<td headers="Agent"><cfselect name="userID" query="getAgents" display="UserName" value="UserID" selected="#Variables.userID#" /></td>
								<cfelse>
									<td headers="Agent">No agents currently registered.</td>
								</cfif>
							</tr>
						</cfif>
						<cfif getVessels.recordCount GE 1 AND getAgents.recordCount GE 1>
							<tr>
								<td id="Startdate"><label for="start">Start Date:</label></td>
								<td headers="Startdate">
									<cfoutput>
									<cfinput type="text" name="startDate" message="Please enter a start date." validate="date" required="yes" class="startDate" value="#DateFormat(startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" /> #language.dateform#</cfoutput>
									<img src="#RootDir#images/calendar.gif" alt="" class="calendar" />
								</td>
							</tr>
							<tr>
								<td id="Enddate"><label for="end">End Date:</label></td>
								<td headers="Enddate">
									<cfoutput>
									<cfinput type="text" name="endDate" message="Please enter an end date." validate="date" required="yes" class="endDate" value="#DateFormat(endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" /> #language.dateform#</cfoutput>
									<img src="#RootDir#images/calendar.gif" alt="" class="calendar" />
								</td>
							</tr>
							<tr>
								<td id="bookingDT">Booking Time:</td>
								<td headers="bookingDT">
									<cfoutput>
										<cfinput name="bookingDate" type="text" value="#DateFormat(Variables.TheBookingDate, 'mm/dd/yyyy')#" size="15" maxlength="10" required="yes" message="Please enter a valid booking date." validate="date" />
										<cfinput name="bookingTime" type="text" value="#TimeFormat(Variables.TheBookingTime, 'HH:mm:ss')#" size="5" maxlength="8" required="yes" message="Please enter a valid booking time." validate="time" />
									</cfoutput>
									<img src="#RootDir#images/calendar.gif" alt="" class="calendar" />
								</td>
							</tr>
							<tr><td colspan="2"><p><b>Note: Booking dates are inclusive</b>; i.e. a three day booking is denoted as from May 1 to May 3.</p></td></tr>
							<tr><td colspan="2">Please set the status of the booking:</td></tr>
							<tr>
								<td id="pend" align="right"><label for="pending">Pending</label></td>
								<td headers="pend"><input type="radio" name="Status" id="pending" value="P" <cfif Variables.Status EQ "P" />
							</tr>
							<tr>
								<td id="tent" align="right"><label for="tentative">Tentative</label></td>
								<td headers="tent"><input type="radio" name="Status" id="tentative" value="T" <cfif Variables.Status EQ "T" />
							</tr>
							<tr>
								<td id="conf" align="right"><label for="confirmed">Confirmed</label></td>
								<td headers="conf"><input type="radio" name="Status" id="confirmed" value="C" <cfif Variables.Status EQ "C" />
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td colspan="2">Please select the jetty that you wish to book:</td>
							</tr>
							<tr>
								<td colspan="2">
								<table align="center">
									<tr>
										<td id="nj" style="width:50%;"><label for="northJetty">North Landing Wharf</label></td>
										<td headers="nj"><input type="radio" name="Jetty" id="northJetty" value="north" <cfif Variables.NorthJetty EQ 1 OR Variables.SOuthJetty EQ 0>checked="true"</cfif> /></td>
									</tr>
									<tr>
										<td id="sj"><label for="southJetty">South Jetty</label></td>
										<td headers="sj"><input type="radio" name="Jetty" id="southJetty" value="south" <cfif Variables.SouthJetty EQ 1>checked="checeked"</cfif> /></td>
									</tr>
								</table>
								</td>
							</tr>
						</cfif>
						<tr><td>&nbsp;</td></tr>
						<tr>
							<td colspan="2" align="center">
								<cfif getVessels.recordCount GE 1 AND getAgents.recordCount GE 1>
								<!--a href="javascript:document.addBookingForm.submitForm.click();" class="textbutton">Submit</a-->
									<input type="hidden" name="compID" value="#Variables.compID#" />
									<input type="submit" name="submitForm" class="textbutton" value="submit" />
									<cfif override EQ "1">
									<input type="submit" name="submitForm" class="textbutton" value="override" />
									</cfif>
								</cfif>
								<cfoutput><input type="button" value="Back" onclick="self.location.href='jettybookingmanage.cfm?#urltoken#'" class="textbutton" /></cfoutput>
							</td>
						</tr>
					</table>
					</cfoutput>
					</cfform>
				</cfif>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
