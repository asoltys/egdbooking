<cfif isDefined("form.BRID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<CFIF IsDefined('Form.BRID')>
	<CFSET Variables.BRID = Form.BRID>
<CFELSEIF IsDefined('URL.BRID')>
	<CFSET Variables.BRID = URL.BRID>
<CFELSE>
	<cflocation addtoken="no" url="#RootDir#admin/menu.cfm?lang=#lang#">
</CFIF>

<CFPARAM name="url.referrer" default="Jetty Booking Management">
<CFIF url.referrer eq "Booking Details">
	<CFSET returnTo = "#RootDir#comm/detail-res-book.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#admin/JettyBookings/jettyBookingManage.cfm">
</CFIF>


<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Bookings.StartDate, Bookings.EndDate, Vessels.Name AS VesselName, Vessels.*,
			Users.LastName + ', ' + Users.FirstName AS UserName,
			Companies.Name AS CompanyName, Jetties.NorthJetty, Jetties.SouthJetty,
			Jetties.Status
	FROM 	Bookings INNER JOIN Jetties ON Bookings.BRID = Jetties.BRID
			INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
			INNER JOIN Users ON Bookings.UID = Users.UID
			INNER JOIN Companies ON Vessels.CID = Companies.CID
	WHERE	Bookings.BRID = <cfqueryparam value="#Variables.BRID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfif DateCompare(PacificNow, getBooking.startDate, 'd') NEQ 1 OR (DateCompare(PacificNow, getBooking.startDate, 'd') EQ 1 AND DateCompare(PacificNow, getBooking.endDate, 'd') NEQ 1)>
	<cfset variables.actionCap = "Cancel">
	<cfset variables.action = "cancel">
<cfelse>
	<cfset variables.actionCap = "Delete">
	<cfset variables.action = "delete">
</cfif>


<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm <cfoutput>#variables.actionCap#</cfoutput> Booking"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm #variables.actionCap# Booking</title>">
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
				<a href="bookingManage.cfm?lang=#lang#">Jetty Management</a> &gt;
			Confirm #variables.actionCap# Booking
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>Confirm #variables.actionCap# Booking</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">


				<cfif isDefined("url.date")>
					<cfset variables.dateValue = "&date=#url.date#">
				<cfelse>
					<cfset variables.dateValue = "">
				</cfif>

				<cfform action="deleteJettyBooking_action.cfm?#urltoken#&referrer=#URLEncodedFormat(url.referrer)##variables.dateValue#" method="post" id="delBookingConfirm">
					<p><div style="text-align:center;">Are you sure you want to <cfoutput>#variables.action#</cfoutput> the following booking?</div></p>
					<input type="hidden" name="BRID" value="<cfoutput>#variables.BRID#</cfoutput>" />
					<cfoutput query="getBooking">
					<table style="padding-top:10px;" style="width:70%;">
						<tr>
							<td id="Vessel" valign="top" style="width:25%;" align="left">Vessel:</td>
							<td header="Vessel">#vesselName#</td>
						</tr>
						<tr>
							<td id="Company" valign="top" style="width:25%;" align="left">Company:</td>
							<td header="Company" style="width:85%;">#companyName#</td>
						</tr>
						<tr>
							<td id="Agent" valign="top" style="width:25%;" align="left">Agent:</td>
							<td header="Agent">#UserName#</td>
						</tr>
						<tr>
							<td id="Start" valign="top" style="width:25%;" align="left">Start Date:</td>
							<td header="Start">#dateformat(startDate, "mmm d, yyyy")#</td>
						</tr>
						<tr>
							<td id="End" valign="top" style="width:25%;" align="left">End Date:</td>
							<td header="End">#dateformat(endDate, "mmm d, yyyy")#</td>
						</tr>
						<tr>
							<td id="Days" valign="top" style="width:25%;" align="left">## of Days:</td>
							<td header="Days">#datediff('d', startDate, endDate) + 1#</td>
						</tr>
						<tr>
							<td id="Jetty" valign="top" style="width:25%;" align="left">Jetty:</td>
							<td header="Jetty">
								<CFIF NorthJetty>North Landing Wharf
								<CFELSE>South Jetty
								</CFIF>
							</td>
						</tr>
						<tr>
							<td id="Status" valign="top" style="width:25%;" align="left">Status:</td>
							<td header="Status">
								<cfif status EQ 'c'>
									Confirmed
								<cfelse>
									Pending
								</cfif>
							</td>
						</tr>
					</table>
					</cfoutput>
					<br />
					<div style="text-align:center;">
						<input type="submit" name="submitForm" class="textbutton" value="<cfoutput>#variables.action#</cfoutput> booking" />
						<cfoutput><input type="button" onclick="javascript:self.location.href='#returnTo#?#urltoken#&BRID=#variables.BRID##variables.dateValue####variables.BRID#'" value="Back" class="textbutton" /></cfoutput>
					</div>

				</cfform>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
