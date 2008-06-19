<cfif isDefined("form.bookingID") AND (NOT isDefined("url.referrer") OR url.referrer NEQ "Edit Booking")>
  <cfinclude template="#RootDir#includes/build_form_struct.cfm">
</cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm Booking"">
	<meta name=""keywords"" lang=""eng"" content="""">
	<meta name=""description"" lang=""eng"" content="""">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm Booking</title>
">
<CFPARAM name="url.referrer" default="Booking Management">
<CFIF url.referrer eq "Edit Jetty Booking" OR url.referrer eq "Booking Details">
  <CFSET returnTo = "#RootDir#text/admin/JettyBookings/editJettyBooking.cfm">
  <CFELSE>
  <CFSET returnTo = "#RootDir#text/admin/JettyBookings/jettyBookingManage.cfm">
</CFIF>
<cfif isDefined("url.date")>
  <cfset variables.dateValue = "&date=#url.date#">
  <cfelse>
  <cfset variables.dateValue = "">
</cfif>

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-eng.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">Admin</A> &gt;
			<CFELSE>
				<a href="#RootDir#text/booking/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			<A href="bookingmanage.cfm?lang=#lang#">Jetty Management</A> &gt;
			Confirm Booking
			</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-eng.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Confirm Booking
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<!--- -------------------------------------------------------------------------------------------- --->
				<cfparam name="Variables.BookingID" default="">
				<cfif IsDefined("Session.Return_Structure")>
				  <cfinclude template="#RootDir#includes/getStructure.cfm">
				  <cfelseif IsDefined("Form.BookingID")>
				  <cfset Variables.BookingID = Form.BookingID>
				  <cfelse>
				  <cflocation url="#returnTo#?#urltoken##dateValue#&referrer=#url.referrer#" addtoken="no">
				</cfif>
				<cfquery name="theBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				SELECT
						Bookings.BookingID, 
						StartDate, 
						EndDate, 
						Vessels.VesselID,
						Vessels.Length, 
						Vessels.Name AS VesselName, 
						Companies.Name AS CompanyName, 
						NorthJetty,
						SouthJetty
					FROM 
						Bookings INNER JOIN Jetties
							ON Bookings.BookingID = Jetties.BookingID
						INNER JOIN Vessels
							ON Vessels.VesselID = Bookings.VesselID
						INNER JOIN Companies 
							ON Companies.CompanyID = Vessels.CompanyID
					WHERE 
						Bookings.BookingID = '#Variables.BookingID#'
				</cfquery>
				<!---Check to see if jetty has already reached capacity (304m for NLW and 301m for South Jetty)--->
				<CFIF theBooking.NorthJetty>
				  <CFSET error=0>
				  <CFSET tempDate = #theBooking.StartDate#>
				  <!---Loop through each day of the booking to check for capacity--->
				  <CFLOOP condition = "#tempDate# LESS THAN OR EQUAL TO #theBooking.EndDate#">
					<cfquery name="checkLength" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	SUM(Vessels.Length) as sumLength
					FROM		Bookings INNER JOIN
					Jetties ON Bookings.BookingID = Jetties.BookingID INNER JOIN
					Vessels ON Bookings.VesselID = Vessels.VesselID
					WHERE		((Bookings.StartDate <= '#tempDate#' AND Bookings.EndDate >= '#tempDate#'))
					AND Jetties.NorthJetty = '1'
					AND	Bookings.Deleted = '0'
					AND Jetties.Status = 'C'
					</cfquery>
					<CFOUTPUT>
					  <!---check capacity for that day and see if it's the first error--->
					  <CFIF (#checkLength.sumLength# NEQ "") AND (#checkLength.sumLength#+#theBooking.Length#) GT 304 AND NOT #error#>
						<CFSET error=1>
						<div class="waitList">
						<p> <strong>WARNING: Max Length (304m) Exceeded on #DateFormat(tempDate, "mmm d YYYY")#</strong><br />
						  Current Usage: #checkLength.sumLength#m &nbsp;&nbsp; Booking Vessel Length: #theBooking.Length#m
						<table class="waitlistBookings">
						<tr>
						  <th id="Dates" align="left">Docking Dates</th>
						  <th id="Vessel" align="left">Vessel</th>
						  <th align=left>Length</th>
						</tr>
						<CFSET errorDate = #tempDate#>
						<CFELSEIF #theBooking.Length# GT 304 AND NOT #error#>
						<CFSET error=1>
						<div class="waitList">
						<p>
						<strong>WARNING: Max Length (304m) Exceeded on #DateFormat(tempDate, "mmm d YYYY")#</strong><br />
						Current Usage: 0m &nbsp;&nbsp; Booking Vessel Length: #theBooking.Length#m
						<CFSET errorDate = #tempDate#>
					  </CFIF>
					  <CFSET tempDate = DateFormat(DateAdd('d', 1, tempDate))>
					</CFOUTPUT>
				  </CFLOOP>
				  <!---display table cells which list all boats that are confirmed on that day--->
				  <CFIF #error#>
					<cfquery name="getLengthConflicts" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	Bookings.StartDate, Bookings.EndDate, Vessels.Length, Vessels.Name
					FROM		Bookings INNER JOIN
					Jetties ON Bookings.BookingID = Jetties.BookingID INNER JOIN
					Vessels ON Bookings.VesselID = Vessels.VesselID
					WHERE		((Bookings.StartDate <= '#errorDate#' AND Bookings.EndDate >= '#errorDate#'))
					AND Jetties.NorthJetty = '1'
					AND	Bookings.Deleted = '0'
					AND Jetties.Status = 'C'
					</cfquery>
					<CFLOOP QUERY="getLengthConflicts">
					  <CFOUTPUT>
						<TR valign="top">
						  <td headers="Dates" valign="top">#DateFormat(getLengthConflicts.StartDate, "mmm d")# - #DateFormat(getLengthConflicts.EndDate, "mmm d")#</td>
						  <td headers="Vessel" valign="top">#trim(getLengthConflicts.Name)#</td>
						  <td headers="Length" valign="top">#trim(getLengthConflicts.Length)#m</td>
						</tr>
					  </CFOUTPUT>
					</CFLOOP>
					</table>
					</div>
				  </CFIF>
				  <CFELSEIF theBooking.SouthJetty>
				  <CFSET error=0>
				  <CFSET tempDate = #theBooking.StartDate#>
				  <!---Loop through each day of the booking to check for capacity--->
				  <CFLOOP condition = "#tempDate# LESS THAN OR EQUAL TO #theBooking.EndDate#">
					<cfquery name="checkLength" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	SUM(Vessels.Length) as sumLength
					FROM		Bookings INNER JOIN
					Jetties ON Bookings.BookingID = Jetties.BookingID INNER JOIN
					Vessels ON Bookings.VesselID = Vessels.VesselID
					WHERE		((Bookings.StartDate <= '#tempDate#' AND Bookings.EndDate >= '#tempDate#'))
					AND Jetties.SouthJetty = '1'
					AND	Bookings.Deleted = '0'
					AND Jetties.Status = 'C'
					</cfquery>
					<CFOUTPUT>
					  <!---check capacity for that day and see if it's the first error--->
					  <CFIF (#checkLength.sumLength# NEQ "") AND (#checkLength.sumLength#+#theBooking.Length#) GT 301 AND NOT #error#>
						<CFSET error=1>
						<div class="waitList">
						<p> <strong>WARNING: Max Length (301m) Exceeded on #DateFormat(tempDate, "mmm d YYYY")#</strong><br />
						  Current Usage: #checkLength.sumLength#m &nbsp;&nbsp; Booking Vessel Length: #theBooking.Length#m
						<table class="waitlistBookings">
						<tr>
						  <th id="Dates" align="left">Docking Dates</th>
						  <th id="Vessel" align="left">Vessel</th>
						  <th align=left>Length</th>
						</tr>
						<CFSET errorDate = #tempDate#>
						<CFELSEIF #theBooking.Length# GT 301 AND NOT #error#>
						<CFSET error=1>
						<div class="waitList">
						<p>
						<strong>WARNING: Max Length (301m) Exceeded on #DateFormat(tempDate, "mmm d YYYY")#</strong><br />
						Current Usage: 0m &nbsp;&nbsp; Booking Vessel Length: #theBooking.Length#m
						<CFSET errorDate = #tempDate#>
					  </CFIF>
					  <CFSET tempDate = DateFormat(DateAdd('d', 1, tempDate))>
					</CFOUTPUT>
				  </CFLOOP>
				  <!---display table cells which list all boats that are confirmed on that day--->
				  <CFIF #error#>
					<cfquery name="getLengthConflicts" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	Bookings.StartDate, Bookings.EndDate, Vessels.Length, Vessels.Name
					FROM		Bookings INNER JOIN
					Jetties ON Bookings.BookingID = Jetties.BookingID INNER JOIN
					Vessels ON Bookings.VesselID = Vessels.VesselID
					WHERE		((Bookings.StartDate <= '#errorDate#' AND Bookings.EndDate >= '#errorDate#'))
					AND Jetties.SouthJetty = '1'
					AND	Bookings.Deleted = '0'
					AND Jetties.Status = 'C'
					</cfquery>
					<CFLOOP QUERY="getLengthConflicts">
					  <CFOUTPUT>
						<TR valign="top">
						  <td headers="Dates" valign="top">#DateFormat(getLengthConflicts.StartDate, "mmm d")# - #DateFormat(getLengthConflicts.EndDate, "mmm d")#</td>
						  <td headers="Vessel" valign="top">#trim(getLengthConflicts.Name)#</td>
						  <td headers="Length" valign="top">#trim(getLengthConflicts.Length)#m</td>
						</tr>
					  </CFOUTPUT>
					</CFLOOP>
					</table>
					</div>
				  </CFIF>
				</CFIF>
				<cfset Variables.VesselID = theBooking.VesselID>
				<cfset Variables.VesselName = theBooking.VesselName>
				<cfset Variables.CompanyName = theBooking.CompanyName>
				<cfset Variables.Start = CreateODBCDate(theBooking.StartDate)>
				<cfset Variables.End = CreateODBCDate(theBooking.EndDate)>
				<cfset Variables.Jetty = "North Landing Wharf">
				<cfif theBooking.NorthJetty EQ 0>
				  <cfset Variables.Jetty = "South Jetty">
				</cfif>
				<cfif url.referrer EQ "Edit Booking" AND isDefined("form.startDate")>
				  <cfset Variables.Start = CreateODBCDate(form.StartDate)>
				  <cfset Variables.End = CreateODBCDate(form.EndDate)>
				</cfif>
				<p>Please confirm the following information.</p>
				<!--- -------------------------------------------------------------------------------------------- --->
				<cfform name="BookingConfirm" action="chgStatus_2c_action.cfm?#urltoken#&referrer=#URLEncodedFormat(url.referrer)#" method="post">
				  <cfoutput>
					<input type="hidden" name="BookingID" value="#Variables.BookingID#">
				  </cfoutput>
				  <table width="85%" style="padding-left:15px;">
					<tr>
					  <td id="Vessel" width="25%" align="left">Vessel:</td>
					  <td headers="Vessel"><input type="hidden" name="vesselID" value="<cfoutput>#Variables.VesselID#</cfoutput>" />
						<cfoutput>#Variables.VesselName#</cfoutput></td>
					</tr>
					<tr>
					  <td id="Company" align="left">Company:</td>
					  <td headers="Company"><cfoutput>#Variables.CompanyName#</cfoutput></td>
					</tr>
					<tr>
					  <td id="Start" align="left">Start Date:</td>
					  <td headers="Start"><cfoutput>#DateFormat(Variables.Start,"mmm dd, yyyy")#</cfoutput></td>
					</tr>
					<tr>
					  <td id="End" align="left">End Date:</td>
					  <td headers="End"><cfoutput>#DateFormat(Variables.End,"mmm dd, yyyy")#</cfoutput></td>
					</tr>
					<tr>
					  <td id="Jetty" align="left">Jetty:</td>
					  <td headers="Jetty"><cfoutput>#Variables.Jetty#</cfoutput></td>
					</tr>
					<tr>
					  <td>&nbsp;</td>
					</tr>
				  </table>
				  <table align="center">
					<tr>
					  <td><input type="submit" value="Confirm" class="textbutton">
						<cfoutput>
						  <input type="button" onClick="self.location.href='#returnTo#?#urltoken##dateValue#&referrer=#URLEncodedFormat(url.referrer)#&bookingID=#Variables.bookingID###id#Variables.bookingid#'" value="Cancel" class="textbutton">
						</cfoutput> </td>
					</tr>
				  </table>
				</cfform>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
