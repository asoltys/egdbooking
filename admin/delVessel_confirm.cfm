<cfif isDefined("form.VesselID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfset Errors = ArrayNew(1)>
<cfset Success = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<!--- Validate the form data --->
<cfif NOT isDefined("Form.CompanyID") OR form.companyID EQ "">
	<cfoutput>#ArrayAppend(Errors, "You must select a company.")#</cfoutput>
	<cfset Proceed_OK = "No">
<cfelseif NOT isDefined("Form.VesselID") OR form.VesselID EQ "">
	<cfoutput>#ArrayAppend(Errors, "You must select a user to delete.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>


<cfif Proceed_OK EQ "No">
	<!--- Save the form data in a session structure so it can be sent back to the form page --->
	<cfset Session.Return_Structure.CompanyID = Form.CompanyID>
	<cfset Session.Return_Structure.UserID = Form.VesselID>

	<cfset Session.Return_Structure.Errors = Errors>

 	<cflocation url="delVessel.cfm?lang=#lang#" addToken="no">
</cfif>


<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm Delete Vessel"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm Delete Vessel</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfif isDefined("form.vesselID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<!---retrieve information on the company selected--->
<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Vessels.*, Companies.Name AS companyName
	FROM Vessels INNER JOIN Companies ON Vessels.companyID = Companies.companyID
	WHERE Vessels.VesselID = #form.vesselID#
</cfquery>

<!-- 2005-09-27: Added new resriction on the following two queries, Deleted must be 0 -->
<cfquery name="getVesselDockBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	*
	FROM	Bookings INNER JOIN Vessels ON Vessels.VesselID = Bookings.VesselID
			INNER JOIN Docks ON Bookings.BookingID = Docks.BookingID
	WHERE	EndDate >= #CreateODBCDate(PacificNow)# AND Vessels.VesselID = #form.VesselID# AND Bookings.Deleted = 0
</cfquery>

<cfquery name="getVesselJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	*
	FROM	Bookings INNER JOIN Vessels ON Vessels.VesselID = Bookings.VesselID
			INNER JOIN Jetties ON Bookings.BookingID = Jetties.BookingID
	WHERE	EndDate >= #CreateODBCDate(PacificNow)# AND Vessels.VesselID = #form.VesselID# AND Bookings.Deleted = 0
</cfquery>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt;
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			Confirm Delete Vessel
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Confirm Delete Vessel
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

			<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

			<cfif IsDefined("Session.Return_Structure")>
				<!--- Populate the Variables Structure with the Return Structure.
						Also display any errors returned --->
				<cfinclude template="#RootDir#includes/getStructure.cfm">
			</cfif>

			<cfif getVesselDockBookings.recordCount EQ 0 AND getVesselJettyBookings.recordCount EQ 0>
				<cfform action="delVessel_action.cfm?lang=#lang#" method="post" id="delVesselConfirmForm">
					Are you sure you want to delete <cfoutput><strong>#getVessel.Name#</strong></cfoutput>?

					<input type="hidden" name="vesselID" value="<cfoutput>#form.vesselID#</cfoutput>" />
			<br /><br />
					<cfoutput query="getVessel">
					<table style="padding-top:10px;">
						<tr>
							<td id="Name">Name:</td>
							<td headers="Name">#Name#</td>
						</tr>
						<!---<tr>
							<td>Owner:</td>
							<td>#userName#</td>
						</tr>--->
						<tr>
							<td id="Company">Company:</td>
							<td headers="Company">#companyName#</td>
						</tr>
						<tr>
							<td id="Length">Length:</td>
							<td headers="Length">#length# m</td>
						</tr>
						<tr>
							<td id="Width">Width:</td>
							<td headers="Width">#width# m</td>
						</tr>
						<tr>
							<td id="Setup">Block Setup Time:</td>
							<td headers="Setup">#blockSetupTime#</td>
						</tr>
						<tr>
							<td id="Teardown">Block Teardown Time:</td>
							<td headers="Teardown">#blockteardowntime#</td>
						</tr>
						<tr>
							<td id="lloydsID">International Maritime Organization (I.M.O.) number:</td>
							<td headers="lloydsID">#lloydsID#</td>
						</tr>
						<tr>
							<td id="Tonnage">Tonnage:</td>
							<td headers="Tonnage">#tonnage#</td>
						</tr>
					</table>
					<br />
					<div style="text-align:center;">
						<input type="submit" class="textbutton" value="submit" />
						<input type="button" value="Back" onclick="self.location.href='delVessel.cfm?lang=#lang#'" class="textbutton" />
						<input type="button" value="Cancel" onclick="self.location.href='menu.cfm?lang=#lang#'" class="textbutton" />
					</div>
					</cfoutput>
				</cfform>

			<cfelse>

					<cfoutput><strong>#getVessel.name#</strong></cfoutput> cannot be deleted as it is booked for the following dates:<br />

					<cfif getVesselDockBookings.recordCount GT 0>
						<br /><br />
						&nbsp;&nbsp;&nbsp;<strong>Drydock</strong>
						<table style="padding-left:20px; width:100%;" >
							<tr>
								<th id="start" style="width:25%;"><strong>Start Date</strong></th>
								<th id="end" style="width:60%;"><strong>End Date</strong></th>
								<th id="status" style="width:15%;"><strong>Status</strong></th>
							</tr>
							<cfoutput query="getVesselDockBookings">
								<tr>
									<td headers="start" valign="top">#dateformat(startDate, "mmm d, yyyy")#</td>
									<td headers="end" valign="top">#dateformat(endDate, "mmm d, yyyy")#</td>
									<td headers="status" valign="top">
										<cfif status EQ 'p'><i>pending</i>
										<cfelseif status EQ 't'><i>tentative</i>
										<cfelse><i>confirmed</i></cfif>
									</td>
								</tr>
							</cfoutput>
						</table>
					</cfif>

					<cfif getVesselJettyBookings.recordCount GT 0>
						<br />
						&nbsp;&nbsp;&nbsp;<strong>Jetty</strong>
						<table style="padding-left:20px; width:100%;">
							<tr>
								<th id="start" style="width:25%;"><strong>Start Date</strong></th>
								<th id="end" style="width:25%;"><strong>End Date</strong></th>
								<th id="jetty" style="width:35%;"><strong>Jetty</strong></th>
								<th id="status" style="width:15%;"><strong>Status</strong></th>
							</tr>
							<cfoutput query="getVesselJettyBookings">
								<tr>
									<td headers="start" valign="top">#dateformat(startDate, "mmm d, yyyy")#</td>
									<td headers="end" valign="top">#dateformat(endDate, "mmm d, yyyy")#</td>
									<td headers="jetty" valign="top">
										<cfif getVesselJettyBookings.NorthJetty EQ 1>
											North Landing Wharf
										<cfelseif getVesselJettyBookings.SouthJetty EQ 1>
											South Jetty
										</cfif>
									</td>
									<td headers="status" valign="top">
										<cfif status EQ 'p'><i>pending</i>
										<cfelse><i>confirmed</i></cfif>
									</td>
								</tr>
							</cfoutput>
						</table>
					</cfif>

					<p><div style="text-align:center;">
						<input type="button" value="Back" onclick="self.location.href='delVessel.cfm?lang=<cfoutput>#lang#</cfoutput>'" class="textbutton" />
						<input type="button" value="Return to Administrative Functions" onclick="self.location.href='menu.cfm?lang=<cfoutput>#lang#</cfoutput>'" class="textbutton" />
					</div></p>
				</div>
			</cfif>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
