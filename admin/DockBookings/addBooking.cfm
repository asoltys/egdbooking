<cfsavecontent variable="js">
	<cfoutput>
	<meta name="dcterms.title" content="pwgsc - esquimalt graving dock - Add Booking">
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta name="dcterms.description" content="" />
	<meta name="dcterms.subject" title="gccore" content="" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Add Booking</title>
	<script type="text/javascript">
		/* <![CDATA[ */
		var bookingLength = 2;
		/* ]]> */
	</script>
	<script type="text/javascript" src="#RootDir#scripts/tandemDateFixer.js"></script>
	</cfoutput>
</cfsavecontent>
<cfhtmlhead text="#js#">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT CID, Name
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
			<cfif IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt;
			<cfelse>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</cfif>
			<a href="bookingManage.cfm?lang=#lang#">Drydock Management</a> &gt;
			Create Booking
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1 id="wb-cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Create New Dock Booking
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<cfparam name="form.compID" default="">
				<cfparam name="Variables.compID" default="#form.compID#">
				<cfparam name="Variables.VNID" default="">
				<cfparam name="Variables.UID" default="">
				<cfparam name="Variables.StartDate" default="#DateAdd('d', 1, PacificNow)#">
				<cfparam name="Variables.EndDate" default="#DateAdd('d', 3, PacificNow)#">
				<cfparam name="Variables.Status" default="PT">
				<cfparam name="Variables.TheBookingDate" default="#CreateODBCDate(PacificNow)#">
				<cfparam name="Variables.TheBookingTime" default="#CreateODBCTime(PacificNow)#">

				<cfif IsDefined("Session.Return_Structure")>
					<cfinclude template="#RootDir#includes/getStructure.cfm">
				</cfif>
				<cfif NOT IsDefined("Session.form_Structure")>
					<cfinclude template="#RootDir#includes/build_form_struct.cfm">
					<cfinclude template="#RootDir#includes/restore_params.cfm">
				<cfelse>
					<cfinclude template="#RootDir#includes/restore_params.cfm">
					<cfif isDefined("form.startDate")>
						<cfset Variables.compID = #form.compID#>
						<cfset Variables.VNID = #form.VNID#>
						<cfset Variables.UID = #form.UID#>
						<cfset Variables.StartDate = #form.startDate#>
						<cfset Variables.EndDate = #form.endDate#>
						<cfset Variables.TheBookingDate = #Form.bookingDate#>
						<cfset Variables.TheBookingTime = #Form.bookingTime#>
						<cfset Variables.Status = form.status>
					</cfif>
				</cfif>

				<cfform action="addBooking.cfm?#urltoken#" method="post" id="chooseUserForm">
					<p><label for="selectCompany">Select Company:</label> <cfselect query="getCompanies" id="selectCompany" name="compID" value="CID" display="Name" selected="#Variables.compID#" />
					&nbsp;&nbsp;&nbsp;
					<!--a href="javascript:EditSubmit('chooseUserForm');" class="textbutton">Submit</a-->
					<input type="submit" name="submitForm" class="textbutton" value="submit" />
					<cfoutput><a href="bookingManage.cfm?#urltoken#" class="textbutton">Back</a></cfoutput>
				</cfform>

				<cfif Variables.compID NEQ "">

					<cflock timeout=20 scope="Session" type="Exclusive">
						<cfset Session.Company = "#form.compID#">
					</cflock>

					<cfform action="addBooking_process.cfm?#urltoken#" method="post" id="addBookingForm">
					<cfoutput>

					<cfquery name="getVessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT VNID, Name
						FROM Vessels
						WHERE CID = <cfqueryparam value="#Variables.compID#" cfsqltype="cf_sql_integer" /> AND Deleted = 0
						ORDER BY Name
					</cfquery>

					<cfquery name="getAgents" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT	Users.UID, lastname + ', ' + firstname AS UserName
						FROM	Users INNER JOIN UserCompanies ON Users.UID = UserCompanies.UID
								INNER JOIN Companies ON UserCompanies.CID = Companies.CID
						WHERE	Companies.CID = <cfqueryparam value="#Variables.compID#" cfsqltype="cf_sql_integer" /> AND Users.Deleted = 0
								AND UserCompanies.Deleted = 0 AND UserCompanies.Approved = 1
						ORDER BY lastname, firstname
					</cfquery>

					<table>
						<tr>
							<cfquery name="getCompanyName" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
								SELECT Name
								FROM Companies
								WHERE CID = <cfqueryparam value="#Variables.compID#" cfsqltype="cf_sql_integer" />
							</cfquery>

							<td id="Company" style="width:20%;">Company:</td>
							<td headers="Company" style="width:80%;">#getCompanyName.Name#</td>
						</tr>
						<tr>
							<td id="Vessel">Vessel:</td>
							<cfif getVessels.recordCount GE 1>
								<td headers="Vessel"><cfselect name="VNID" query="getVessels" display="Name" value="VNID" selected="#Variables.VNID#" /></td>
							<cfelse>
								<td headers="Vessel">No ships currently registered.</td>
							</cfif>
						</tr>
						<cfif getVessels.recordCount GE 1>
						<tr>
							<td id="Agent">Agent:</td>
							<cfif getAgents.recordCount GE 1>
								<td headers="Agent"><cfselect name="UID" query="getAgents" display="UserName" value="UID" selected="#Variables.UID#" /></td>
							<cfelse>
								<td headers="Agent">No agents currently registered.</td>
							</cfif>
						</tr>
						</cfif>
						<cfif getVessels.recordCount GE 1 AND getAgents.recordCount GE 1>
							<tr>
								<td><label for="start">Start Date:</label></td>
								<td headers="startDate">
									<cfoutput>
									<cfinput id="startDate" type="text" name="startDate" message="Please enter a start date." validate="date" required="yes" class="datepicker startDate" value="#DateFormat(Variables.startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" /> #language.dateform#</cfoutput>
								</td>
							</tr>
							<tr>
								<td><label for="end">End Date:</label></td>
								<td headers="endDate">
									<cfoutput>
									<cfinput id="endDate" type="text" name="endDate" message="Please enter an end date." validate="date" required="yes" class="datepicker endDate" value="#DateFormat(Variables.endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" /> #language.dateform#</cfoutput>
								</td>
							</tr>
							<tr>
								<td>Booking Date:</td>
								<td headers="bookingDT">
									<cfoutput>
										<cfinput id="bookingDate" name="bookingDate" type="text" value="#DateFormat(Variables.TheBookingDate, 'mm/dd/yyyy')#" class="datepicker" size="15" maxlength="10" required="yes" message="Please enter a valid booking date." validate="date" /> #language.dateform#
									</cfoutput>
								</td>
							</tr>
              <tr>
                <td>Booking Time:</td>
                <td>
                  <cfinput name="bookingTime" type="text" value="#TimeFormat(Variables.TheBookingTime, 'HH:mm')#" size="5" maxlength="8" required="yes" message="Please enter a valid booking time." validate="time" /> (HH:MM)
                </td>
              </tr>
							<tr><td colspan="2"><p><strong>Note: Booking dates are inclusive</strong>; i.e. a three day booking is denoted as from May 1 to May 3.</p></td></tr>
							<tr><td colspan="2">Please set the status of the booking:</td></tr>
							<tr>
								<td id="pend" align="right">&nbsp;&nbsp;&nbsp;<label for="pending">Pending</label></td>
								<td headers="pend"><input type="radio" name="Status" id="pending" value="PT" <cfif Variables.Status EQ "PT">selected="selected"</cfif>/></td>
							</tr>
							<tr>
								<td id="tent" align="right">&nbsp;&nbsp;&nbsp;<label for="tentative">Tentative</label></td>
								<td headers="tent"><input type="radio" name="Status" id="tentative" value="T" <cfif Variables.Status EQ "T">selected="selected"</cfif>/></td>
							</tr>
							<tr>
								<td id="conf" align="right">&nbsp;&nbsp;&nbsp;<label for="confirmed">Confirmed</label></td>
								<td headers="conf"><input type="radio" name="Status" id="confirmed" value="C" <cfif Variables.Status EQ "C">selected="selected"</cfif>/></td>
							</tr>
						</cfif>
						<tr><td>&nbsp;</td></tr>
						<tr>
							<td colspan="2" align="center">
								<cfif getVessels.recordCount GE 1 AND getAgents.recordCount GE 1>
									<input type="hidden" name="compID" value="#Variables.compID#" />
									<input type="submit" name="submitForm" class="textbutton" value="submit" />
								</cfif>
								<cfoutput><a href="bookingManage.cfm?#urltoken#" class="textbutton">Back</a></cfoutput>

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
