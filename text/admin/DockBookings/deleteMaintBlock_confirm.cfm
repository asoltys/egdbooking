<cfif isDefined("form.bookingID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Bookings.StartDate, Bookings.EndDate, Docks.Section1, Docks.Section2, Docks.Section3
	FROM 	Bookings INNER JOIN Docks ON Bookings.BookingID = Docks.BookingID
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

<cfset Variables.BookingID = Form.BookingID>
<cfset Variables.Start = getBooking.StartDate>
<cfset Variables.End = getBooking.EndDate>
<cfset Variables.Section1 = getBooking.Section1>
<cfset Variables.Section2 = getBooking.Section2>
<cfset Variables.Section3 = getBooking.Section3>

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
				<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
			<CFELSE>
				<a href="#RootDir#text/reserve-book/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			<A href="bookingManage.cfm?lang=#lang#">Drydock Management</A> &gt;
			Confirm #variables.actionCap# Maintenance Block
			</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<CFOUTPUT>Confirm #variables.actionCap# Maintenance Block</CFOUTPUT>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<cfinclude template="#RootDir#includes/admin_menu.cfm">
				
				<cfif DateCompare(PacificNow, getBooking.endDate, 'd') NEQ 1>
					<cfinclude template="includes/getConflicts.cfm">
					<cfset conflictArray = getConflicts_remConf(Variables.BookingID)>
					<cfif ArrayLen(conflictArray) GT 0>
						<cfset Variables.waitListText = "The booking slot that this maintenance block held is now available for the following tentative bookings. The companies/agents should be given 24 hours notice to claim this slot.">
						<cfinclude template="includes/displayWaitList.cfm">
					</cfif>
				</cfif>
				
				
				<p>Please confirm the following maintenance block information.</p>
				<cfform action="deleteMaintBlock_action.cfm?#urltoken#" method="POST" enablecab="No" name="bookingreq" preservedata="Yes">
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
							<input type="hidden" name="Section1" value="<cfoutput>#Variables.Section1#</cfoutput>">
							<input type="hidden" name="Section2" value="<cfoutput>#Variables.Section2#</cfoutput>">
							<input type="hidden" name="Section3" value="<cfoutput>#Variables.Section3#</cfoutput>">
							<cfif Variables.Section1 EQ 1>
								Section 1
							</cfif>
							<cfif Variables.Section2 EQ 1>
								<cfif Variables.Section1 EQ 1> 
									&amp; 
								</cfif>
								Section 2
							</cfif>
							<cfif Variables.Section3 EQ 1>
								<cfif Variables.Section1  EQ 1 OR Variables.Section2 EQ 1> 
									&amp;
								</cfif>
								Section 3
							</cfif>
						</td>
					</tr>
				</table>
				
				<br>
				<table width="100%" cellspacing="0" cellpadding="1" border="0" align="center" style="font-size:10pt;">
					<tr>
						<td colspan="2" align="center">
							<!---a href="javascript:EditSubmit('bookingreq');" class="textbutton">Confirm</a>
							<a href="javascript:history.go(-1);" class="textbutton">Back</a>
							<cfoutput><a href="bookingmanage.cfm?#urltoken#" class="textbutton">Cancel</a></cfoutput>
							<BR--->
							<input type="Submit" value="<cfoutput>#variables.actionCap#</cfoutput>" class="textbutton">
							<CFOUTPUT><input type="button" value="Back" class="textbutton" onClick="self.location.href='bookingmanage.cfm?#urltoken#';"></CFOUTPUT>
						</td>
					</tr>
				</table>
				
				</cfform>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
