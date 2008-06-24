<cfif isDefined("form.bookingID") AND (NOT isDefined("url.referrer") OR url.referrer NEQ "Edit Booking")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<CFPARAM name="url.referrer" default="Booking Management">
<CFIF url.referrer eq "Edit Booking" OR url.referrer eq "Booking Details">
	<CFSET returnTo = "#RootDir#admin/DockBookings/editBooking.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#admin/DockBookings/bookingManage.cfm">
</CFIF>

<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>

<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Status, Bookings.BookingID, StartDate, EndDate,
			Vessels.Name AS VesselName, Companies.Name AS CompanyName,
			Section1, Section2, Section3
	FROM	Docks, Bookings, Vessels, Companies
	WHERE	Bookings.BookingID = Docks.BookingID
	AND		Bookings.BookingID = '#Form.BookingID#'
	AND		Vessels.VesselID = Bookings.VesselID
	AND		Companies.CompanyID = Vessels.CompanyID
</cfquery>

<cfif url.referrer EQ "Edit Booking" AND isDefined("form.startDate")>
	<cfset Variables.Start = CreateODBCDate(form.StartDate)>
	<cfset Variables.End = CreateODBCDate(form.EndDate)>
<cfelse>
	<cfset Variables.Start = CreateODBCDate(getBooking.StartDate)>
	<cfset Variables.End = CreateODBCDate(getBooking.EndDate)>
</cfif>

<!-- Start JavaScript Block -->
<script language="JavaScript" type="text/javascript">
	<!--
	function EditSubmit ( selectedform )
	{
	  document.forms[selectedform].submit() ;
	}
	//-->
</script>
<!-- End JavaScript Block -->

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<A href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			<A href="bookingManage.cfm?lang=#lang#">Drydock Management</A> &gt;
			Change Booking Status
			</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Change Booking Status
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

			<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>
			<cfif getBooking.Status EQ "C">
				<cfinclude template="includes/getConflicts.cfm">
				<cfset conflictArray = getConflicts_remConf(Form.BookingID)>
				<cfif ArrayLen(conflictArray) GT 0>
					<cfset Variables.waitListText = "The booking slot that this vessel held is now available for the following tentative bookings.  The companies/agents should be given 24 hours notice to submit a downpayment.">
					<cfinclude template="includes/displayWaitList.cfm">
					
				</cfif>
			</cfif>
			
			<cfform action="chgStatus_2t_action.cfm?#urltoken#&referrer=#URLEncodedFormat(url.referrer)#" method="post" name="change2tentative">
				Are you sure you want to change this booking's status to tentative?
			<br><br>
				<cfoutput>
				<input type="hidden" name="BookingID" value="#Form.BookingID#">
				<table align="center" style="padding-top:5px;">
					<tr>
						<td><strong>Booking Details:</strong></td>
					</tr>
					<tr>
						<td id="Vessel">Vessel:</td>
						<td headers="Vessel">#getBooking.VesselName#</td>
					</tr>
					<tr>
						<td id="Company">Company:</td>
						<td headers="Company">#getBooking.CompanyName#</td>
					</tr>
					<cfif getBooking.Status EQ "C">
					<!---<tr>
						<td id="Section1">Section 1:</td>
						<td headers="Section1"><cfif getBooking.section1 EQ 1>Yes<cfelse>No</cfif></td>
					</tr>
					<tr>
						<td id="Section2">Section 2:</td>
						<td headers="Section2"><cfif getBooking.section2 EQ 1>Yes<cfelse>No</cfif></td>
					</tr>
					<tr>
						<td id="Section3">Section 3:</td>
						<td headers="Section3"><cfif getBooking.section3 EQ 1>Yes<cfelse>No</cfif></td>
					</tr>--->
					<tr>
						<td id="Sections" align="left">Section(s):</td>
						<td headers="Sections">
							<CFIF getBooking.Section1>Section 1</CFIF>
							<CFIF getBooking.Section2><CFIF getBooking.Section1> &amp; </CFIF>Section 2</CFIF>
							<CFIF getBooking.Section3><CFIF getBooking.Section1 OR getBooking.Section2> &amp; </CFIF>Section 3</CFIF>
						</td>
					</tr>
					</cfif>
					<tr>
						<td id="Start">Start Date:</td>
						<td headers="Start">#DateFormat(Variables.Start, "mmm d, yyyy")#</td>
					</tr>
					<tr>
						<td id="End">End Date:</td>
						<td headers="End">#DateFormat(Variables.End, "mmm d, yyyy")#</td>
					</tr>
				</table>	
				</cfoutput>
				
				<p><div align="center">
				<!--a href="javascript:EditSubmit('change2tentative');" class="textbutton">Submit</a-->
				<input type="submit" name="submitForm" class="textbutton" value="submit">
				<cfoutput><input type="button" value="Cancel" onClick="self.location.href='#returnTo#?#urltoken##dateValue#&referrer=#URLEncodedFormat(url.referrer)#&bookingID=#getBooking.bookingID###id#getBooking.bookingid#'" class="textbutton"></cfoutput>
				</div></p>
			</cfform>
			
			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
