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
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm <cfoutput>#variables.actionCap#</cfoutput> Maintenance Block"">
<meta name=""keywords"" lang=""eng"" content="""">
<meta name=""description"" lang=""eng"" content="""">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm #variables.actionCap# Maintenance Block</title>">
<cfinclude template="#RootDir#includes/header-#lang#.cfm">


<cfset Variables.BookingID = Form.BookingID>
<cfset Variables.Start = getBooking.StartDate>
<cfset Variables.End = getBooking.EndDate>
<cfset Variables.NorthJetty = getBooking.NorthJetty>
<cfset Variables.SouthJetty = getBooking.SouthJetty>

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
		<A href="jettyBookingmanage.cfm?lang=#lang#">Jetty Management</A> &gt;
	</CFOUTPUT>
	Confirm <cfoutput>#variables.actionCap#</cfoutput> Maintenance Block
</div>

<div class="main">
<H1>Confirm <cfoutput>#variables.actionCap#</cfoutput> Maintenance Block</H1>
<cfinclude template="#RootDir#includes/admin_menu.cfm">


<p>Please confirm the following maintenance block information.</p>
<cfform action="deleteJettyMaintBlock_action.cfm?#urltoken#" method="POST" enablecab="No" name="bookingreq" preservedata="Yes">
<cfoutput><input type="hidden" name="BookingID" value="#Variables.BookingID#"></cfoutput>

<table width="80%" align="center" style="font-size:10pt;">	
	<tr><td align="left"><div style="font-size:10pt;font-weight:bold;">Booking:</div></td></tr>
	<tr>
		<td id="Start" align="left" width="25%">Start Date:</td>
		<td headers="Start"><input type="hidden" name="StartDate" value="<cfoutput>#Variables.Start#</cfoutput>"><cfoutput>#DateFormat(Variables.Start, 'mmm d, yyyy')#</cfoutput></td>
	</tr>
	<tr>
		<td id="End" align="left">End Date:</td>
		<td headers="End"><input type="hidden" name="EndDate" value="<cfoutput>#Variables.End#</cfoutput>"><cfoutput>#DateFormat(Variables.End, 'mmm d, yyyy')#</cfoutput></td>
	</tr>
	<tr>
		<td id="Sections" align="left">Sections:</td>
		<td headers="Sections">
			<input type="hidden" name="NorthJetty" value="<cfoutput>#Variables.NorthJetty#</cfoutput>">
			<input type="hidden" name="SouthJetty" value="<cfoutput>#Variables.SouthJetty#</cfoutput>">
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

<br>
<table width="100%" cellspacing="0" cellpadding="1" border="0" align="center" style="font-size:10pt;">


	<tr>
		<td colspan="2" align="center">
			<input type="Submit" value="<cfoutput>#variables.actionCap#</cfoutput> Maintenance" class="textbutton">
			<CFOUTPUT><input type="button" value="Back" class="textbutton" onClick="self.location.href='jettybookingmanage.cfm?#urltoken#';"></CFOUTPUT>
		</td>
	</tr>
</table>

</cfform>

</div>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">