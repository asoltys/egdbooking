<cfif isDefined("form.numDays")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfinclude template="#RootDir#includes/bookingInfoVariables.cfm">
<cfinclude template="#RootDir#includes/errorMessages.cfm">
<cfif lang EQ "e">
	<cfset language.newBooking = "Submit Drydock Booking Information">
	<cfset language.keywords = language.masterKeywords & ", Drydock Booking Information">
	<cfset language.description = "Allows user to submit a new booking request, drydock section.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.theVessel = "The vessel">
	<cfset language.tooLarge = "is too large for the dry dock">
	<cfset language.requestBooking = "Request Booking">
	<cfset language.bookingFound = "A booking has been found for">
	<cfset language.requestedStatus = "Requested Status">
	<cfset language.tplbookingError = "already has a booking for">
<cfelse>
	<cfset language.newBooking = "Pr&eacute;sentation des renseignements pour la r&eacute;servation de la cale s&egrave;che">
	<cfset language.keywords = language.masterKeywords & ", renseignements pour la r&eacute;servation de la cale s&egrave;che">
	<cfset language.description = "Permet &agrave; l'utilisateur de pr&eacute;senter une nouvelle demande de r&eacute;servation sur le site Web de la cale s&egrave;che d'Esquimalt - section de la cale s&egrave;che.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.theVessel = "Les dimensions du navire">
	<cfset language.tooLarge = "sont sup&eacute;rieures &agrave; celles de la cale s&egrave;che.">
	<cfset language.requestBooking = "Pr&eacute;senter la r&eacute;servation">
	<cfset language.bookingFound = "Une r&eacute;servation a &eacute;t&eacute; trouv&eacute;e pour ">
	<cfset language.requestedStatus = "État demandé">
	<cfset language.tplbookingError = "a déjà une réservation pour :">
</cfif>

<cfoutput>
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
	<cfinclude template="#RootDir#includes/header-#lang#.cfm">
</cfoutput>

<!--- Query to get Vessel Information --->
<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	VesselID, Length, Width, Vessels.Name AS VesselName, Companies.Name AS CompanyName
	FROM 	Vessels, Companies
	WHERE 	VesselID = '#Form.VesselID#'
	AND		Companies.CompanyID = Vessels.CompanyID
	AND 	Vessels.Deleted = 0
	AND		Companies.Deleted = 0
</cfquery>

<!--- Error Checks -------------------------------------------------------------------------------->
<cfif IsDefined("Session.Return_Structure")>
	<cfoutput>#StructDelete(Session, "Return_Structure")#</cfoutput>
</cfif>

<cfset Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">
<cfif DateCompare(Form.StartDate,Form.EndDate) EQ 1>
	<cfoutput>#ArrayAppend(Errors, "#language.endBeforeStartError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif DateCompare(Now(), Form.StartDate, 'd') NEQ -1>
	<cfoutput>#ArrayAppend(Errors, "#language.futureStartError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif DateDiff("d",Form.StartDate,Form.EndDate) LT Form.NumDays-1>
	<cfoutput>#ArrayAppend(Errors, "#language.bookingTooShortErrorB#")#</cfoutput>
		<cfoutput>#ArrayAppend(Errors, "#language.StartDate#: #LSDateFormat(CreateODBCDate(Form.StartDate), 'mmm d, yyyy')#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif getVessel.RecordCount EQ 0>
	<cfoutput>#ArrayAppend(Errors, "#language.noVesselError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif NOT IsDefined("Form.NumDays")>
	<cfoutput>#ArrayAppend(Errors, "#language.needBookingDaysError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif IsDefined("Form.NumDays") AND Form.NumDays LTE 0>
	<cfoutput>#ArrayAppend(Errors, "#language.bookingTooShortError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif getVessel.Width GT Variables.MaxWidth OR getVessel.Length GT Variables.MaxLength>
	<cfoutput>#ArrayAppend(Errors, "#language.theVessel#, #getVessel.VesselName#, #language.tooLarge#.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<!--- Save the form data in a session structure so it can be sent back to the form page --->
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Errors>
 	<cflocation url="bookingRequest.cfm?lang=#lang#" addtoken="no">
</cfif>
<!------------------------------------------------------------------------------------------------->
<cfinclude template="includes/towerCheck.cfm">
<cfset count = 0>
<cfset found = false>
<cfset finish = false>
<cfset Variables.StartDate = "">
<cfset Variables.EndDate = "">
<cfset Variables.FoundStartDate = "">
<cfset Variables.FoundEndDate = "">
<cfset Variables.VesselID = Form.VesselID>  <!--- Added 25/01/2006 DS to fix CF error in bookings --->

<cfloop condition="finish EQ false AND found EQ false">	

	<cfset Variables.StartDate = CreateODBCDate(DateAdd('d', count, Form.StartDate))>
	<cfset Variables.EndDate = CreateODBCDate(DateAdd('d', count + Form.NumDays - 1, Form.StartDate))>
	<cfset count = count + 1>

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
	
	<cfif checkDblBooking.RecordCount EQ 0 AND getNumStartDateBookings.recordCount LTE 1 AND getNumEndDateBookings.recordCount LTE 1>
		<cfif findSpace(-1, #Variables.StartDate#, #Variables.EndDate#, #getVessel.Length#, #getVessel.Width#)>
			<cfset Variables.FoundStartDate = Variables.StartDate>
			<cfset Variables.FoundEndDate = Variables.EndDate>
			<cfset found = true>
		</cfif>
	</cfif>

	<cfif DateCompare(Variables.EndDate, Form.EndDate, "d") EQ 0>
		<cfset finish = true>
	</cfif>
</cfloop>
<cfif NOT found>
	<cfoutput>#ArrayAppend(Errors, "There were no slots found for that time period.")#</cfoutput>
	<!--- Save the form data in a session structure so it can be sent back to the form page --->
	<!--- <cfset Session.Return_Structure.NumDays = Form.NumDays>
	<cfset Session.Return_Structure.VesselID = Form.VesselID>
	<cfset Session.Return_Structure.CompanyID = Form.CompanyID>
	<cfset Session.Return_Structure.StartDate = Form.StartDate>
	<cfset Session.Return_Structure.EndDate = Form.EndDate> --->
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Errors>

 	<cflocation url="bookingRequest.cfm?lang=#lang#" addtoken="no">
</cfif>

<!--- Gets all Bookings that would be affected by the requested booking --->

<cfoutput>
<div class="breadcrumbs">
	<a href="http://www.pwgsc.gc.ca/text/home-#lang#.html">#language.PWGSC#</a> &gt;
	#language.pacificRegion# &gt;
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-#lang#.html">#language.EsqGravingDock#</a> &gt;
	<A href="booking.cfm?lang=<cfoutput>#lang#</cfoutput>">#language.booking#</A> &gt;
	<A href="bookingRequest_choose.cfm?lang=<cfoutput>#lang#</cfoutput>">#language.bookingRequest#</A> &gt;
	#language.NewBooking#
</div>

<div class="main">

<h1>#language.NewBooking#</h1>

<cfinclude template="#RootDir#includes/user_menu.cfm"><br>

<cfform action="bookingRequest_actionB.cfm?lang=#lang#" method="POST" enablecab="No" name="bookingreq" preservedata="Yes">
<p>#language.bookingFound# #LSDateFormat(Variables.FoundStartDate, 'mmm d, yyyy')# - #LSDateFormat(Variables.FoundEndDate, 'mmm d, yyyy')#.</p>
<table width="100%">
	<tr>
		<td width="30%" id="Agent">#language.Agent#:</td>
		<td width="70%" headers="Agent">
			<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
				#session.lastName#, #session.firstName#
			</cflock>
		</td>
	</tr>
	<tr>
		<td id="vessel">#language.vessel#:</td>
		<td headers="vessel"><input type="hidden" name="vesselID" value="#Form.VesselID#" />#getVessel.VesselName#</td>
	</tr>
	<tr>
		<td id="Company">#language.Company#:</td>
		<td headers="Company">#getVessel.CompanyName#</td>
	</tr>
	<tr>
		<td id="StartDate">#language.StartDate#:</td>
		<td headers="StartDate"><input type="hidden" name="startDate" value="#Variables.FoundStartDate#" />#LSDateFormat(CreateODBCDate(Variables.StartDate), 'mmm d, yyyy')#</td>
	</tr>

	<tr>
		<td id="EndDate">#language.EndDate#:</td>
		<td headers="EndDate"><input type="hidden" name="EndDate" value="#Variables.FoundEndDate#" />#LSDateFormat(Variables.EndDate, 'mmm d, yyyy')#</td>
	</tr>
	<tr>
		<td align="left" id="Status">#language.requestedStatus#:</td>
		<td headers="Status"><input type="hidden" name="Status" value="<cfoutput>#Form.Status#</cfoutput>"><cfif form.status eq "tentative">#language.tentative#<cfelse>#language.confirmed#</cfif></td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td colspan="2" align="center">
			<input type="Submit" value="#language.requestBooking#" class="textbutton">
			<input type="button" value="#language.Back#" class="textbutton" onClick="history.go(-1);">
			<input type="button" value="#language.Cancel#" class="textbutton" onClick="self.location.href='bookingRequest_choose.cfm?lang=<cfoutput>#lang#</cfoutput>';">
			<!---<a href="javascript:formReset('bookingreq');">test reset</a>--->
		</td>
	</tr>
</table>

</cfform>
</cfoutput>
</div>

<cfinclude template="#RootDir#includes/footer-#lang#.cfm">