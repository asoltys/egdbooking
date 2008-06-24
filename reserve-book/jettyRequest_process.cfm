<cfif isDefined("form.startDate")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfinclude template="#RootDir#includes/errorMessages.cfm">
<cfinclude template="#RootDir#includes/bookingInfoVariables.cfm">
<cfif lang EQ "eng">
	<cfset language.submitJettyBooking = "Submit Jetty Booking Information">
	<cfset language.keywords = language.masterKeywords & ", Jetty Booking Information">
	<cfset language.description = "Allows user to submit a new booking request, jetties section.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.newBooking = "Submit New Booking Information">
	<cfset language.dblBookingError = "has already been booked from">
	<cfset language.requestedJetty = "Requested Jetty">
	<cfset language.to = "to">
	<cfset language.bookingAvailable = "Please confirm the following information:">
	<cfset language.northJetty = "North Landing Wharf">
	<cfset language.southJetty = "South Jetty">
	<cfset language.tplbookingError = "already has a booking for">
	<cfset language.requestedStatus = "Requested Status">
<cfelse>
	<cfset language.submitJettyBooking = "Pr&eacute;sentation des renseignements pour la r&eacute;servation de jet&eacute;e">
	<cfset language.keywords = language.masterKeywords & ", renseignements pour la r&eacute;servation de jet&eacute;e">
	<cfset language.description = "Permet &agrave; l'utilisateur de soumettre une nouvelle demande de r&eacute;servation - section de jet&eacute;e">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.newBooking = "Pr&eacute;sentation de nouveaux renseignements pour la r&eacute;servation">
	<cfset language.dblBookingError = "fait d&eacute;j&agrave; l'objet d'une r&eacute;servation du">
	<cfset language.requestedJetty = "Jet&eacute;e demand&eacute;e">
	<cfset language.to = "au">
	<cfset language.bookingAvailable = "Veuillez confirmer l'information suivante&nbsp;.">
	<cfset language.northJetty = "Quai de d&eacute;barquement nord">
	<cfset language.southJetty = "Jet&eacute;e sud">
	<cfset language.tplbookingError = "a d&eacute;j&agrave; une r&eacute;servation pour le">
	<cfset language.requestedStatus = "&Eacute;tat demand&eacute;">
</cfif>


<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.NewBooking#"">
	<meta name=""keywords"" lang=""eng"" content=""#language.keywords#"">
	<meta name=""description"" lang=""eng"" content=""#language.description#"">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""#language.subjects#"">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.NewBooking#</title>"> 

<cfif IsDefined("Session.Return_Structure")>
	<cfoutput>#StructDelete(Session, "Return_Structure")#</cfoutput>
</cfif>

<cfset Errors = ArrayNew(1)>
<cfset Success = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfset Variables.StartDate = CreateODBCDate(Form.StartDate)>
<cfset Variables.EndDate = CreateODBCDate(Form.EndDate)>
<cfset Variables.VesselID = Form.VesselID>

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
<!--- 25 October 2005: This query now only looks at the jetties bookings --->
<cfquery name="checkDblBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Bookings.VesselID, Bookings.BookingID, Name, Bookings.StartDate, Bookings.EndDate
	FROM 	Bookings
				INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID
				INNER JOIN Jetties ON Bookings.BookingID = Jetties.BookingID
	WHERE 	Bookings.VesselID = '#Form.VesselID#'
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
	<cfif IsDefined("Form.Jetty") AND form.Jetty EQ "north">
		AND Jetties.NorthJetty = 1
	<cfelse>
		AND Jetties.SouthJetty = 1
	</cfif>	
</cfquery>

<!--- 25 October 2005: The next two queries have been modified to only get results from the jetties bookings --->
<cfquery name="getNumStartDateBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Bookings.BookingID, Vessels.Name, Bookings.StartDate
	FROM	Bookings
				INNER JOIN Jetties ON Bookings.BookingID = Jetties.BookingID
				INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID
	WHERE	StartDate = #Variables.StartDate#
				AND Bookings.VesselID = '#Form.VesselID#'
				AND Bookings.Deleted = 0
			<cfif IsDefined("Form.Jetty") AND form.Jetty EQ "north">
				AND Jetties.NorthJetty = 1
			<cfelse>
				AND Jetties.SouthJetty = 1
			</cfif>	
</cfquery>

<cfquery name="getNumEndDateBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Bookings.BookingID, Vessels.Name, Bookings.EndDate
	FROM	Bookings
				INNER JOIN Jetties ON Bookings.BookingID = Jetties.BookingID
				INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID
	WHERE	EndDate = #Variables.EndDate# 
					AND Bookings.VesselID = '#Form.VesselID#'
					AND Bookings.Deleted = 0
				<cfif IsDefined("Form.Jetty") AND form.Jetty EQ "north">
					AND Jetties.NorthJetty = 1
				<cfelse>
					AND Jetties.SouthJetty = 1
				</cfif>	
</cfquery>

<!--- Validate the form data --->
<cfif DateCompare(DateAdd('d', 1, PacificNow), Form.StartDate, 'd') EQ 1>
	<cfoutput>#ArrayAppend(Errors, "#language.futureStartError#")#</cfoutput>
	<cfset Proceed_OK = "No">

<cfelseif isDefined("checkDblBooking.VesselID") AND checkDblBooking.VesselID NEQ "">
	<cfoutput>#ArrayAppend(Errors, "#checkDblBooking.Name# #language.dblBookingError# #LSdateFormat(checkDblBooking.StartDate, 'mm/dd/yyy')# #language.to# #LSdateFormat(checkDblBooking.EndDate, 'mm/dd/yyy')#.")#</cfoutput>
	<cfset Proceed_OK = "No">
<cfelseif getNumStartDateBookings.recordCount GTE 1>
	<cfoutput>#ArrayAppend(Errors, "#getNumStartDateBookings.Name# #language.tplBookingError# #LSdateFormat(getNumStartDateBookings.StartDate, 'mm/dd/yyy')#.")#</cfoutput>
	<cfset Proceed_OK = "No">
<cfelseif getNumEndDateBookings.recordCount GTE 1>
	<cfoutput>#ArrayAppend(Errors, "#getNumEndDateBookings.Name# #language.tplBookingError# #LSdateFormat(getNumEndDateBookings.EndDate, 'mm/dd/yyy')#.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Form.StartDate GT Form.EndDate>
	<cfoutput>#ArrayAppend(Errors, "#language.endBeforeStartError#")#</cfoutput>
	<cfset Proceed_OK = "No">
<cfelseif DateDiff("d",Form.StartDate,Form.EndDate) LT 0>
	<cfoutput>#ArrayAppend(Errors, "#language.bookingTooShortError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<!---<!--- Scheduling Algorithm --->
<cfset Variables.Spacer = 30>
<cfset Variables.NorthLength = 298>
<cfset Variables.SouthLength = 119>
<cfset Variables.SouthlandingLength = 301>--->

 <!--- Save the form data in a session structure so it can be sent back to the form page --->
<cfif Proceed_OK EQ "No">
	<cfset Session.Return_Structure.Jetty = Form.Jetty>
	<cfset Session.Return_Structure.StartDate = Form.StartDate>
	<cfset Session.Return_Structure.EndDate = Form.EndDate>
	<cfset Session.Return_Structure.VesselID = Form.vesselID>
	<cfset Session.Return_Structure.CompanyID = Form.CompanyID>
	<cfset Session.Return_Structure.Errors = Errors>
 	<cflocation url="#RootDir#reserve-book/jettyRequest.cfm?lang=#lang#">
</cfif>

<cfquery name="getInfo" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Companies.Name AS CompanyName, Companies.CompanyID, Vessels.Name AS VesselName, Vessels.VesselID
	FROM 	Vessels, Companies
	WHERE 	VesselID = '#Form.VesselID#'
	AND		Companies.CompanyID = Vessels.CompanyID
	AND 	Companies.Deleted = 0
	AND		Vessels.Deleted = 0
</cfquery>

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>
			<a href="#RootDir#reserve-book/booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			<A href="#RootDir#reserve-book/bookingRequest_choose.cfm?lang=#lang#">#language.bookingRequest#</A> &gt;
			#language.submitJettyBooking#
			</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<CFOUTPUT>#language.submitJettyBooking#</CFOUTPUT>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFOUTPUT>
				
				<p>#language.bookingAvailable#</p>
				
				<cfform action="#RootDir#reserve-book/jettyRequest_action.cfm?lang=#lang#" method="POST" enablecab="No" name="bookingreq" preservedata="Yes">
				<table width="100%" style="padding-left:10px;">
					<tr>
						<td width="30%" id="Agent">
							#language.Agent#:
						</td>
						<td width="70%" headers="Agent">
							<!---<cfinput class="textField" type="Text" name="Name" value="#Variables.Name#" message="Name is a mandatory field" required="Yes" size="65">--->
							<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
								#session.lastName#, #session.firstName#
							</cflock>
						</td>
					</tr>
					<tr>
						<td id="Company">
							#language.Company#:
						</td>
						<td headers="Company"><input type="hidden" name="CompanyID" value="#getInfo.CompanyID#">#getInfo.CompanyName#</td>
					</tr>
					<tr>
						<td id="vessel">#language.vessel#:</td>
						<td headers="vessel"><input type="hidden" name="VesselID" value="#getInfo.VesselID#">#getInfo.VesselName#</td>
					</tr>
					<tr>
						<td id="StartDate">
							#language.StartDate#:
						</td>
						<td headers="StartDate"><input type="hidden" name="startDate" value="#CreateODBCDate(startDate)#">#LSDateFormat(CreateODBCDate(startDate), 'mmm d, yyyy')#</td>
					</tr>
					<tr>
						<td id="EndDate">#language.EndDate#:</td>
						<td headers="EndDate"><input type="hidden" name="endDate" value="#CreateODBCDate(endDate)#">#LSDateFormat(CreateODBCDate(endDate), 'mmm d, yyyy')#</td>
					</tr>
					<tr id="ReqStatus">
						<td headers="ReqStatus">#language.requestedStatus#:</td>
						<td headers="Status"><input type="hidden" name="Status" value="<cfoutput>#Form.Status#</cfoutput>"><cfif form.status eq "tentative">#language.tentative#<cfelse>#language.confirmed#</cfif></td>
					</tr>
					<tr>
						<td id="RequestedJetty">
							<label for="jettySelect">#language.RequestedJetty#:</label>
						</td>
						<td headers="RequestedJetty"><input id="jettySelect" type="hidden" name="jetty" value="#Form.Jetty#">
							<cfif Form.Jetty EQ "north">
								#language.northJetty#
							<cfelse>
								#language.southJetty#
							</cfif>
						</td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
						<td colspan="2" align="center">
							<input type="Submit" value="#language.confirm#" class="textbutton">
							<input type="button" value="#language.Back#" class="textbutton" onClick="self.location.href='jettyRequest.cfm?lang=#lang#&companyID=#url.companyID#'">
						</td>
					</tr>
				</table>
				
				
				</cfform>
				</CFOUTPUT>

			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

