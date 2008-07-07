<cfif isDefined("form.startDate")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfinclude template="#RootDir#includes/bookingInfoVariables.cfm">
<cfinclude template="#RootDir#includes/errorMessages.cfm">
<cfif lang EQ "eng">
	<cfset language.newBooking = "Submit Drydock Booking Information">
	<cfset language.keywords = language.masterKeywords & ", Drydock Booking Information">
	<cfset language.description = "Allows user to submit a new booking request, drydock section.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.dblBookingError = "has already been booked from">
	<cfset language.to = "to">
	<cfset language.theVessel = "The vessel">
	<cfset language.tooLarge = "is too large for the dry dock">
	<cfset language.bookingConflicts = "The submitted booking request conflicts with other bookings.  The booking will be placed on a wait list if you choose to continue. Please confirm the following information.">
	<cfset language.bookingAvailable = "The requested time is available.  Please confirm the following information.">
	<cfset language.new = "New Booking">
	<cfset language.requestedStatus = "Requested Status">
	<cfset language.tplbookingError = "already has a booking for">
<cfelse>
	<cfset language.newBooking = "Pr&eacute;sentation des renseignements pour la r&eacute;servation de la cale s&egrave;che">
	<cfset language.keywords = language.masterKeywords & ", renseignements pour la r&eacute;servation de la cale s&egrave;che">
	<cfset language.description = "Permet &agrave; l'utilisateur de pr&eacute;senter une nouvelle demande de r&eacute;servation sur le site Web de la cale s&egrave;che d'Esquimalt - section de la cale s&egrave;che.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.dblBookingError = "fait d&eacute;j&agrave; l'objet d'une r&eacute;servation du">
	<cfset language.to = "au">
	<cfset language.theVessel = "Les dimensions du navire">
	<cfset language.tooLarge = "sont sup&eacute;rieures &agrave; celles de la cale s&egrave;che.">
	<cfset language.bookingConflicts = "La demande de r&eacute;servation pr&eacute;sent&eacute;e entre en conflit avec d'autres r&eacute;servations. La demande sera inscrite sur une liste d'attente si vous d&eacute;cidez de continuer. Veuillez confirmer les renseignements suivants.">
	<cfset language.bookingAvailable = "La p&eacute;riode demand&eacute;e est libre. Veuillez confirmer les renseignements suivants.">
	<cfset language.new = "Nouvelle r&eacute;servation">
	<cfset language.requestedStatus = "&Eacute;tat demand&eacute;">
	<cfset language.tplbookingError = "a d&eacute;j&agrave; une r&eacute;servation pour :">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.NewBooking#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.NewBooking#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<!-- Start JavaScript Block -->
<script type="text/javascript">
/* <![CDATA[ */
function EditSubmit ( selectedform )
	{
	  document.forms[selectedform].submit();
	}
/* ]]> */
</script>
		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			<a href="#RootDir#reserve-book/resdemande-bookrequest.cfm?lang=#lang#">#language.bookingRequest#</a> &gt;
			#language.newBooking#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.newBooking#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>


				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
				
				<cfif IsDefined("Session.Return_Structure")>
					<cfoutput>#StructDelete(Session, "Return_Structure")#</cfoutput>
				</cfif>
				
				<cfset Errors = ArrayNew(1)>
				<cfset Success = ArrayNew(1)>
				<cfset Proceed_OK = "Yes">
				
				<!--- <cfoutput>#ArrayAppend(Success, "The booking has been successfully added.")#</cfoutput> --->
				
				<!--- Validate the form data --->
				<cfif DateCompare(Form.StartDate,Form.EndDate) EQ 1>
					<cfoutput>#ArrayAppend(Errors, "#language.endBeforeStartError#")#</cfoutput>
					<cfset Proceed_OK = "No">
				</cfif>
				
				<cfset Variables.VesselID = Form.VesselID>
				<cfset Variables.StartDate = CreateODBCDate(Form.StartDate)>
				<cfset Variables.EndDate = CreateODBCDate(Form.EndDate)>
				
				<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT 	VesselID, Length, Width, Vessels.Name AS VesselName, Companies.Name AS CompanyName
					FROM 	Vessels, Companies
					WHERE 	VesselID = '#Form.VesselID#'
					AND		Companies.CompanyID = Vessels.CompanyID
					AND 	Vessels.Deleted = 0
					AND		Companies.Deleted = 0
				</cfquery>
				
				<cfif getVessel.RecordCount EQ 0>
					<cfoutput>#ArrayAppend(Errors, "#language.noVesselError#")#</cfoutput>
					<cfset Proceed_OK = "No">
				</cfif>
				
				<!---Check to see that vessel hasn't already been booked during this time--->
				<!--- 25 October 2005: This query now only looks at the drydock bookings --->
				<cfquery name="checkDblBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT 	Bookings.VesselID, Vessels.Name, Bookings.StartDate, Bookings.EndDate
					FROM 	Bookings
								INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID
								INNER JOIN Docks ON Bookings.BookingID = Docks.BookingID
					WHERE 	Bookings.VesselID = '#Variables.VesselID#'
					AND 	
					<!---Explanation of hellishly long condition statement: The client wants to be able to overlap the start and end dates 
						of bookings, so if a booking ends on May 6, another one can start on May 6.  This created problems with single day 
						bookings, so if you are changing this query...watch out for them.  The first 3 lines check for any bookings longer than 
						a day that overlaps with the new booking if it is more than a day.  The next 4 lines check for single day bookings that 
						fall within a booking that is more than one day.--->
							(
								(	Bookings.StartDate <= #Variables.StartDate# AND #Variables.StartDate# < Bookings.EndDate AND #Variables.StartDate# <> #Variables.EndDate# AND Bookings.StartDate <> Bookings.EndDate)
							OR 	(	Bookings.StartDate < #Variables.EndDate# AND #Variables.EndDate# <= Bookings.EndDate AND #Variables.StartDate# <> #Variables.EndDate# AND Bookings.StartDate <> Bookings.EndDate)
							OR	(	Bookings.StartDate >= #Variables.StartDate# AND #Variables.EndDate# >= Bookings.EndDate AND #Variables.StartDate# <> #Variables.EndDate# AND Bookings.StartDate <> Bookings.EndDate)
							OR  (	(Bookings.StartDate = Bookings.EndDate OR #Variables.StartDate# = #Variables.EndDate#) AND Bookings.StartDate <> #Variables.StartDate# AND Bookings.EndDate <> #Variables.EndDate# AND 
										((	Bookings.StartDate <= #Variables.StartDate# AND #Variables.StartDate# < Bookings.EndDate)
									OR 	(	Bookings.StartDate < #Variables.EndDate# AND #Variables.EndDate# <= Bookings.EndDate)
									OR	(	Bookings.StartDate >= #Variables.StartDate# AND #Variables.EndDate# >= Bookings.EndDate)))
							)
					AND		Bookings.Deleted = 0
					AND Docks.Status = 'C'
				</cfquery>
				
				<!--- 25 October 2005: The next two queries have been modified to only get results from the drydock bookings --->
				<cfquery name="getNumStartDateBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	Bookings.BookingID, Vessels.Name, Bookings.StartDate
					FROM	Bookings
								INNER JOIN Docks ON Bookings.BookingID = Docks.BookingID
								INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID
					WHERE	StartDate = #Variables.StartDate# 
								AND Bookings.VesselID = '#Variables.VesselID#'
								AND Bookings.Deleted = 0
				</cfquery>
				
				<cfquery name="getNumEndDateBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	Bookings.BookingID, Vessels.Name, Bookings.EndDate
					FROM	Bookings
								INNER JOIN Docks ON Bookings.BookingID = Docks.BookingID
								INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID
					WHERE	EndDate = #Variables.EndDate#
								AND Bookings.VesselID = '#Variables.VesselID#' 
								AND Bookings.Deleted = 0
				</cfquery>
				
				<cfif DateCompare(PacificNow, Form.StartDate, 'd') NEQ -1>
					<cfoutput>#ArrayAppend(Errors, "#language.futureStartError#")#</cfoutput>
					<cfset Proceed_OK = "No">
				<cfelseif (isDefined("checkDblBooking.VesselID") AND checkDblBooking.VesselID NEQ "")>
					<cfoutput>#ArrayAppend(Errors, "#checkDblBooking.Name# #language.dblBookingError# #LSdateFormat(checkDblBooking.StartDate, 'mm/dd/yyy')# #language.to# #LSdateFormat(checkDblBooking.EndDate, 'mm/dd/yyy')#.")#</cfoutput>
					<cfset Proceed_OK = "No">
				<cfelseif getNumStartDateBookings.recordCount GTE 1>
					<cfoutput>#ArrayAppend(Errors, "#getNumStartDateBookings.Name# #language.tplBookingError# #LSdateFormat(getNumStartDateBookings.StartDate, 'mm/dd/yyy')#.")#</cfoutput>
					<cfset Proceed_OK = "No">
				<cfelseif getNumEndDateBookings.recordCount GTE 1>
					<cfoutput>#ArrayAppend(Errors, "#getNumEndDateBookings.Name# #language.tplBookingError# #LSdateFormat(getNumEndDateBookings.EndDate, 'mm/dd/yyy')#.")#</cfoutput>
					<cfset Proceed_OK = "No">
				</cfif>
				
				<cfif DateDiff("d",Form.StartDate,Form.EndDate) LT 0>
					<cfoutput>#ArrayAppend(Errors, "#language.bookingTooShortError#")#</cfoutput>
						<cfoutput>#ArrayAppend(Errors, "#language.StartDate#: #LSDateFormat(CreateODBCDate(Form.StartDate), 'mmm d, yyyy')#")#</cfoutput>
					<cfset Proceed_OK = "No">
				</cfif>
				
				<cfif getVessel.Width GT Variables.MaxWidth OR getVessel.Length GT Variables.MaxLength>
					<cfoutput>#ArrayAppend(Errors, "#language.theVessel#, #getVessel.VesselName#, #language.tooLarge#.")#</cfoutput>
					<cfset Proceed_OK = "No">
				</cfif>
				
				<cfif Proceed_OK EQ "No">
					<!--- Save the form data in a session structure so it can be sent back to the form page --->
					<cfset Session.Return_Structure.StartDate = Form.StartDate>
					<cfset Session.Return_Structure.EndDate = Form.EndDate>
					<cfset Session.Return_Structure.VesselID = Form.VesselID>
					<cfset Session.Return_Structure.CompanyID = Form.CompanyID>
					<cfset Session.Return_Structure.Status = Form.Status>
					<cfset Session.Return_Structure.Errors = Errors>
				
					<cflocation url="#RootDir#reserve-book/caledemande-dockrequest.cfm?lang=#lang#" addtoken="no">
				</cfif>
				
				
				<!--- Gets all Bookings that would be affected by the requested booking --->
				<cfinclude template="#RootDir#reserve-book/includes/towerCheck.cfm">
				<cfset Variables.spaceFound = findSpace(-1, #Variables.StartDate#, #Variables.EndDate#, #getVessel.Length#, #getVessel.Width#)>
				<cfoutput>
				<table style="width:100%;" cellspacing="0" cellpadding="1" border="0">
				<tr>
					<td>
						<table style="width:100%;" cellspacing="0" cellpadding="10" border="0">
						<tr>
							<cfif NOT variables.spaceFound>
								<td>#language.bookingConflicts#</td>
							<cfelse>
								<td>#language.bookingAvailable#</td>
							</cfif>
						</tr>
						</table>
					</td>
				</tr>
				</table>
				<cfform action="#RootDir#reserve-book/caledemande-dockrequest_action.cfm?lang=#lang#" method="post" enablecab="No" name="bookingreq" preservedata="Yes">
				<table align="center">
					<tr><td align="right" style="width:40%;"><div style="font-weight:bold;">#language.new#:</div></td></tr>
					<tr>
						<td align="left" id="vessel">&nbsp;&nbsp;&nbsp;#language.vessel#:</td>
						<td style="width:60%;" headers="vessel"><input type="hidden" name="vesselID" value="#Variables.VesselID#" />#getVessel.VesselName#</td>
					</tr>
					<tr>
						<td align="left" id="Company">&nbsp;&nbsp;&nbsp;#language.Company#:</td>
						<td headers="Company">#getVessel.CompanyName#</td>
					</tr>
					<tr>
						<td align="left" id="StartDate">&nbsp;&nbsp;&nbsp;#language.StartDate#:</td>
						<td headers="StartDate"><input type="hidden" name="StartDate" value="#Variables.StartDate#)" />#LSDateFormat(Variables.StartDate, 'mmm d, yyyy'" />
					</tr>
					<tr>
						<td align="left" id="EndDate">&nbsp;&nbsp;&nbsp;#language.EndDate#:</td>
						<td headers="EndDate"><input type="hidden" name="EndDate" value="#Variables.EndDate#)" />#LSDateFormat(Variables.EndDate, 'mmm d, yyyy'" />
					</tr>
					<tr>
						<td align="left" id="Status">&nbsp;&nbsp;&nbsp;#language.requestedStatus#:</td>
						<td headers="Status"><input type="hidden" name="Status" value="#Form.Status#"><cfif form.status eq "tentative" />
					</tr>
				</table>
				<!---<cfif NOT Variables.spaceFound>
					<cfinclude template="#RootDir#includes/showConflicts.cfm">
				
				</cfif>--->
				<table align="center">
					<tr><td>&nbsp;</td></tr>
					<tr>
						<td colspan="2" align="center">
							<!---a href="javascript:EditSubmit('bookingreq');" class="textbutton">#language.confirm#</a>
							<a href="resdemande-bookrequest.cfm?lang=<cfoutput>#lang#</cfoutput>" class="textbutton">#language.Cancel#</a>
							<br--->
							<input type="submit" value="#language.Submit#" class="textbutton" />
							<input type="button" value="#language.Back#" class="textbutton" onclick="self.location.href='bookingRequest.cfm?lang=#lang#'" />
							<input type="button" value="#language.Cancel#" class="textbutton" onclick="self.location.href='bookingRequest_choose.cfm?lang=<cfoutput>#lang#</cfoutput>';" />
							<!---<a href="javascript:formReset('bookingreq');">test reset</a>--->
						</td>
					</tr>
				</table>
				
				</cfform>
				</cfoutput>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
