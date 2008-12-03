<cfif isDefined("form.bookingID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Bookings.StartDate, Bookings.EndDate, Jetties.NorthJetty, Jetties.SouthJetty
	FROM 	Bookings INNER JOIN Jetties ON Bookings.BookingID = Jetties.BookingID
	WHERE	Bookings.BookingID = '#Form.BookingID#'
</cfquery>

<cfif DateCompare(PacificNow, getBooking.startDate, 'd') NEQ 1 OR (DateCompare(PacificNow, getBooking.startDate, 'd') EQ 1 AND DateCompare(PacificNow, getBooking.endDate, 'd') NEQ 1)>
	<cfset variables.actionCap = "Cancel">
	<cfset variables.actionPast = "cancelled">
<cfelse>
	<cfset variables.actionCap = "Delete">
	<cfset variables.actionPast = "deleted">
</cfif>


<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm <cfoutput>#variables.actionCap#</cfoutput> Maintenance Block"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm #variables.actionCap# Maintenance Block</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfset Variables.BookingID = Form.BookingID>
<cfset Variables.Start = getBooking.StartDate>
<cfset Variables.End = getBooking.EndDate>
<cfset Variables.NorthJetty = getBooking.NorthJetty>
<cfset Variables.SouthJetty = getBooking.SouthJetty>

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
			Confirm #variables.actionCap# Maintenance Block
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>Confirm #variables.actionCap# Maintenance Block</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<cfinclude template="#RootDir#includes/admin_menu.cfm">


				<p>Please confirm the following maintenance block information.</p>
				<cfform action="deleteJettyMaintBlock_action.cfm?#urltoken#" method="post" enablecab="No" id="bookingreq" preservedata="Yes">
				<cfoutput><input type="hidden" name="BookingID" value="#Variables.BookingID#" />

				<table style="width:80%;" align="center">
					<tr><td align="left"><div style="font-weight:bold;">Booking:</div></td></tr>
					<tr>
						<td id="Start" align="left" style="width:25%;">Start Date:</td>
						<td headers="Start"><input type="hidden" name="StartDate" value="<cfoutput>#Variables.Start#</cfoutput>)" /><cfoutput>#DateFormat(Variables.Start, 'mmm d, yyyy'" />
					</tr>
					<tr>
						<td id="End" align="left">End Date:</td>
						<td headers="End"><input type="hidden" name="EndDate" value="<cfoutput>#Variables.End#</cfoutput>)" /><cfoutput>#DateFormat(Variables.End, 'mmm d, yyyy'" />
					</tr>
					<tr>
						<td id="Sections" align="left">Sections:</td>
						<td headers="Sections">
							<input type="hidden" name="NorthJetty" value="<cfoutput>#Variables.NorthJetty#</cfoutput>" />
							<input type="hidden" name="SouthJetty" value="<cfoutput>#Variables.SouthJetty#</cfoutput>" />
							<cfif Variables.NorthJetty EQ 1>
								North Landing Wharf
							</cfif>
							<cfif Variables.SouthJetty EQ 1>
								<cfif Variables.NorthJetty EQ 1>
									&amp;
								</cfif>
								South Jetty
							</cfif>
						</td>
					</tr>
				</table>

				<br />
				<table style="width:100%;" cellspacing="0" cellpadding="1" border="0" align="center">
					<tr>
						<td colspan="2" align="center">
							<input type="submit" value="<cfoutput>#variables.actionCap#</cfoutput> Maintenance" class="textbutton" />
							<cfoutput><input type="button" value="Back" class="textbutton" onclick="self.location.href='jettybookingmanage.cfm?#urltoken#';" /></cfoutput>
						</td>
					</tr>
				</table>

				</cfform>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
