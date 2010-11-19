<cfoutput>

<cfif structKeyExists(URL,'BRID')>
  <cfset Form.BRID = URL.BRID />
</cfif>

<cfif isDefined("form.BRID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Bookings.StartDate, Bookings.EndDate, Docks.Section1, Docks.Section2, Docks.Section3
	FROM 	Bookings INNER JOIN Docks ON Bookings.BRID = Docks.BRID
	WHERE	Bookings.BRID = '#Form.BRID#'
</cfquery>

<cfif DateCompare(PacificNow, getBooking.startDate, 'd') NEQ 1 OR (DateCompare(PacificNow, getBooking.startDate, 'd') EQ 1 AND DateCompare(PacificNow, getBooking.endDate, 'd') NEQ 1)>
	<cfset variables.actionCap = "Cancel">
	<cfset variables.actionPast = "cancelled">
<cfelse>
	<cfset variables.actionCap = "Delete">
	<cfset variables.actionPast = "deleted">
</cfif>


<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm #variables.actionCap# Maintenance Block"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm #variables.actionCap# Maintenance Block</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfset Variables.BRID = Form.BRID>
<cfset Variables.Start = getBooking.StartDate>
<cfset Variables.End = getBooking.EndDate>
<cfset Variables.Section1 = getBooking.Section1>
<cfset Variables.Section2 = getBooking.Section2>
<cfset Variables.Section3 = getBooking.Section3>

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
			
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt;
			<CFELSE>
				<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			<a href="bookingManage.cfm?lang=#lang#">Drydock Management</a> &gt;
			Confirm #variables.actionCap# Maintenance Block
			
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Confirm #variables.actionCap# Maintenance Block
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<cfinclude template="#RootDir#includes/admin_menu.cfm">

				<cfif DateCompare(PacificNow, getBooking.endDate, 'd') NEQ 1>
					<cfinclude template="includes/getConflicts.cfm">
					<cfset conflictArray = getConflicts_remConf(Variables.BRID)>
					<cfif ArrayLen(conflictArray) GT 0>
						<cfset Variables.waitListText = "The booking slot that this maintenance block held is now available for the following tentative bookings. The companies/agents should be given 24 hours notice to claim this slot.">
						<cfinclude template="includes/displayWaitList.cfm">
					</cfif>
				</cfif>


				<p>Please confirm the following maintenance block information.</p>
				<cfform action="deleteMaintBlock_action.cfm?#urltoken#" method="post" id="bookingreq" preservedata="Yes">
				<input type="hidden" name="BRID" value="#Variables.BRID#" />

				<table style="width:80%;" align="center">
					<tr><td align="left"><div style="font-weight:bold;">Booking:</div></td></tr>
					<tr>
						<td id="Start" align="left" style="width:25%;">Start Date:</td>
						<td headers="Start"><input type="hidden" name="StartDate" value="#Variables.Start#" />#DateFormat(Variables.Start, 'mmm d, yyyy')#</td>
					</tr>
					<tr>
						<td id="End" align="left">End Date:</td>
						<td headers="End"><input type="hidden" name="EndDate" value="#Variables.End#" />#DateFormat(Variables.End, 'mmm d, yyyy')#</td>
					</tr>
					<tr>
						<td id="Sections" align="left">Sections:</td>
						<td headers="Sections">
							<input type="hidden" name="Section1" value="#Variables.Section1#" />
							<input type="hidden" name="Section2" value="#Variables.Section2#" />
							<input type="hidden" name="Section3" value="#Variables.Section3#" />
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

				<br />
				<table style="width:100%;" cellspacing="0" cellpadding="1" border="0">
					<tr>
						<td colspan="2" align="center">
							<!---a href="javascript:EditSubmit('bookingreq');" class="textbutton">Confirm</a>
							<a href="javascript:history.go(-1);" class="textbutton">Back</a>
							<a href="bookingManage.cfm?#urltoken#" class="textbutton">Cancel</a>
							<br--->
							<input type="submit" value="#variables.actionCap#" class="textbutton" />
							<input type="button" value="Back" class="textbutton" onclick="self.location.href='bookingManage.cfm?#urltoken#';" />
						</td>
					</tr>
				</table>

				</cfform>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
</cfoutput>
