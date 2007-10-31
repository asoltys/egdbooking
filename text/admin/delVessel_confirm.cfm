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
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm Delete Vessel"">
<meta name=""keywords"" lang=""eng"" content="""">
<meta name=""description"" lang=""eng"" content="""">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm Delete Vessel</title>">
<cfinclude template="#RootDir#includes/header-#lang#.cfm">

<cfif isDefined("form.vesselID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<!---retrieve information on the company selected--->
<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Vessels.*, Companies.Name AS companyName
	FROM Vessels INNER JOIN Companies ON Vessels.companyID = Companies.companyID
	WHERE Vessels.VesselID = #form.vesselID#
</cfquery>

<!-- 2005-09-27: Added new resriction on the following two queries, Deleted must be 0 -->
<CFQUERY name="getVesselDockBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	*
	FROM	Bookings INNER JOIN Vessels ON Vessels.VesselID = Bookings.VesselID 
			INNER JOIN Docks ON Bookings.BookingID = Docks.BookingID
	WHERE	EndDate >= #CreateODBCDate(Now())# AND Vessels.VesselID = #form.VesselID# AND Bookings.Deleted = 0
</CFQUERY>

<CFQUERY name="getVesselJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	*
	FROM	Bookings INNER JOIN Vessels ON Vessels.VesselID = Bookings.VesselID 
			INNER JOIN Jetties ON Bookings.BookingID = Jetties.BookingID
	WHERE	EndDate >= #CreateODBCDate(Now())# AND Vessels.VesselID = #form.VesselID# AND Bookings.Deleted = 0
</CFQUERY>


<div class="breadcrumbs">
	<a href="<cfoutput>http://www.pwgsc.gc.ca/text/home-#lang#.html</cfoutput>">PWGSC</a> &gt; 
	Pacific Region &gt; 
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-e.html">Esquimalt Graving Dock</a> &gt; 
	<CFOUTPUT>
		<a href="#RootDir#text/booking-#lang#.cfm">Booking</A> &gt;<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
			<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
		<CFELSE>
			 <a href="#RootDir#text/booking/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
		</CFIF>
	</CFOUTPUT>
	Confirm Delete Vessel
</div>

<div class="main">
<H1>Confirm Delete Vessel</H1>
<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>

<cfif IsDefined("Session.Return_Structure")>
	<!--- Populate the Variables Structure with the Return Structure.
			Also display any errors returned --->
	<cfinclude template="#RootDir#includes/getStructure.cfm">
</cfif>

<cfif getVesselDockBookings.recordCount EQ 0 AND getVesselJettyBookings.recordCount EQ 0>
	<cfform action="delVessel_action.cfm?lang=#lang#" method="post" name="delVesselConfirmForm">
		Are you sure you want to delete <cfoutput><strong>#getVessel.Name#</strong></cfoutput>?
		
		<input type="hidden" name="vesselID" value="<cfoutput>#form.vesselID#</cfoutput>">
<br><br>
		<cfoutput query="getVessel">
		<table align="center" style="padding-top:10px;">
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
		<br>
		<div align="center">
			<input type="submit" class="textbutton" value="submit">
			<input type="button" value="Back" onClick="self.location.href='delVessel.cfm?lang=#lang#'" class="textbutton">
			<input type="button" value="Cancel" onClick="self.location.href='menu.cfm?lang=#lang#'" class="textbutton">
		</div>
		</cfoutput>
	</cfform>
	
<cfelse>
		
		<cfoutput><strong>#getVessel.name#</strong></cfoutput> cannot be deleted as it is booked for the following dates:<br>
		
		<cfif getVesselDockBookings.recordCount GT 0>
			<br><br>
			&nbsp;&nbsp;&nbsp;<strong>Drydock</strong>
			<table style="padding-left:20px;font-size:10pt;" width="100%">
				<tr>
					<th id="start" width="25%"><strong>Start Date</strong></th>
					<th id="end" width="60%"><strong>End Date</strong></th>
					<th id="status" width="15%"><strong>Status</strong></th>
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
			<br>
			&nbsp;&nbsp;&nbsp;<strong>Jetty</strong>
			<table style="padding-left:20px;font-size:10pt;" width="100%">
				<tr>
					<th id="start" width="25%"><strong>Start Date</strong></th>
					<th id="end" width="25%"><strong>End Date</strong></th>
					<th id="jetty" width="35%"><strong>Jetty</strong></th>
					<th id="status" width="15%"><strong>Status</strong></th>
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
			
		<p><div align="center">
			<input type="button" value="Back" onClick="self.location.href='delVessel.cfm?lang=<cfoutput>#lang#</cfoutput>'" class="textbutton">
			<input type="button" value="Return to Administrative Functions" onClick="self.location.href='menu.cfm?lang=<cfoutput>#lang#</cfoutput>'" class="textbutton">
		</div></p>
	</div>
</cfif>

</div>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">