<cfinclude template="#RootDir#includes/errorMessages.cfm">
<cfif lang EQ "eng">
	<cfset language.dblBookingError = "has already been booked from">
	<cfset language.to = "to">
<cfelse>
	<cfset language.dblBookingError = "fait d&eacute;j&agrave; l'objet d'une r&eacute;servation du">
	<cfset language.to = "au">
</cfif>

<cfif IsDefined("Session.Return_Structure")>
	<cfoutput>#StructDelete(Session, "Return_Structure")#</cfoutput>
</cfif>

<cfset Errors = ArrayNew(1)>
<cfset Success = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<!--- <cfoutput>#ArrayAppend(Success, "The booking has been successfully added.")#</cfoutput> --->

<!--- Validate the form data --->
<cfif Form.StartDate GT Form.EndDate>
	<cfoutput>#ArrayAppend(Errors, "#language.endBeforeStartError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfset Variables.StartDate = CreateODBCDate(Form.StartDate)>
<cfset Variables.EndDate = CreateODBCDate(Form.EndDate)>

<!---Check to see that vessel hasn't already been booked during this time--->
<!--- 25 October 2005: This query now only looks at the drydock bookings --->
<cfquery name="checkDblBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Bookings.VesselID, Vessels.Name, Bookings.StartDate, Bookings.EndDate
	FROM 	Bookings
				INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID
				INNER JOIN Docks ON Bookings.BookingID = Docks.BookingID
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
</cfquery>

<cfif DateCompare(PacificNow, Form.StartDate, 'd') NEQ -1>
	<cfoutput>#ArrayAppend(Errors, "#language.futureStartError#")#</cfoutput>
	<cfset Proceed_OK = "No">
<cfelseif NOT isDefined("checkDblBooking.VesselID") OR checkDblBooking.VesselID NEQ "">
	<cfoutput>#ArrayAppend(Errors, "#checkDblBooking.Name# #language.dblBookingError# #LSdateFormat(checkDblBooking.StartDate, 'mm/dd/yyy')# #language.to# #LSdateFormat(checkDblBooking.EndDate, 'mm/dd/yyy')#.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif DateDiff("d",Form.StartDate,Form.EndDate) LT 0>
	<cfoutput>#ArrayAppend(Errors, "#language.bookingTooShortError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif form.status EQ "tentative">
	<cfset status = 'P'>
<cfelse>
	<cfset status = 'Z'>
</cfif>

<cfif Proceed_OK EQ "No">
	<!--- Save the form data in a session structure so it can be sent back to the form page --->
	<cfset Session.Return_Structure.StartDate = Form.StartDate>
	<cfset Session.Return_Structure.EndDate = Form.EndDate>
	<cfset Session.Return_Structure.VesselID = Form.VesselID>
	<cfset Session.Return_Structure.Errors = Errors>

 	<cflocation url="#RootDir#reserve-book/caledemande-dockrequest.cfm?lang=#lang#" addtoken="no">
<cfelse>
	<cftransaction>
		<cfquery name="insertbooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			INSERT INTO	Bookings ( VesselID, StartDate, EndDate, BookingTime, UserID)
			VALUES	('#Form.VesselID#',
					<cfqueryparam value="#CreateODBCDate(Form.StartDate)#" cfsqltype="cf_sql_date">,
					<cfqueryparam value="#CreateODBCDate(Form.EndDate)#" cfsqltype="cf_sql_date">,
					<cfqueryparam value="#CreateODBCDateTime(PacificNow)#" cfsqltype="cf_sql_timestamp">,
					'#Session.UserID#')
		</cfquery>
		<cfquery name="getID" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT	DISTINCT @@IDENTITY AS BookingID
			FROM	Bookings
		</cfquery>
		<cfquery name="insertDock" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			INSERT INTO Docks (BookingID, Status)
			VALUES		('#getID.BookingID#', '#status#')
		</cfquery>
		<cfquery name="insertBlankForm" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			INSERT INTO TariffForms(BookingID)
			VALUES		('#getID.BookingID#')
		</cfquery>
	</cftransaction>

	<cfquery name="getDetails" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Vessels.Name AS vesselName, CompanyID
		FROM	Vessels
			INNER JOIN	Bookings ON Bookings.VesselID = Vessels.VesselID
		WHERE	BookingID = ('#getID.BookingID#')
	</cfquery>
	
	<cflock scope="session" throwontimeout="no" timeout="30" type="READONLY">
		<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT	firstname + ' ' + lastname AS UserName, Email, Companies.Name AS CompanyName
			FROM	Users INNER JOIN UserCompanies ON Users.UserID = UserCompanies.UserID 
					INNER JOIN Companies ON UserCompanies.CompanyID = Companies.CompanyID
			WHERE	Users.UserID = #session.userID# AND Companies.CompanyID = '#getDetails.companyID#'
		</cfquery>
	</cflock>
	
	<cfif form.status EQ "tentative"><cfset variables.status = #language.tentative#><cfelse><cfset variables.status = #language.confirmed#></cfif>
	
	<cfoutput>
		<cfmail to="#Variables.AdminEmail#" from="#getUser.email#" subject="Drydock Booking Requested" type="html">
	<p>#getUser.userName# of #getUser.companyName# has requested a <strong>#variables.status#</strong> drydock booking for #getDetails.VesselName# from #DateFormat(Form.StartDate, 'mmm d, yyyy')# to #DateFormat(Form.EndDate, 'mmm d, yyyy')#.</p>
		</cfmail>
	</cfoutput>

	<!--- create structure for sending to mothership/success page. --->
	<cfif lang EQ "eng">
		<cfset Session.Success.Breadcrumb = "Submit Drydock Booking Request">
		<cfset Session.Success.Title = "Create New Drydock Booking">
		<cfset Session.Success.Message = "A new booking request for <b>#getDetails.vesselName#</b> from #LSDateFormat(CreateODBCDate(form.startDate), 'mmm d, yyyy')# to #LSDateFormat(CreateODBCDate(form.endDate), 'mmm d, yyyy')# has been successfully created and is pending approval.">
		<cfset Session.Success.Back = "Specify Services and Facilities">
	<cfelse>
		<cfset Session.Success.Breadcrumb = "Pr&eacute;senter une nouvelle demande de r&eacute;servation de la cale s&egrave;che">
		<cfset Session.Success.Title = "&Eacute;tablir une nouvelle r&eacute;servation de cale s&egrave;che">
		<cfset Session.Success.Message = "Une nouvelle demande de r&eacute;servation pour le #getDetails.vesselName# du #LSDateFormat(CreateODBCDate(form.startDate), 'mmm d, yyyy')# au #LSDateFormat(CreateODBCDate(form.endDate), 'mmm d, yyyy')# a &eacute;t&eacute; cr&eacute;&eacute;e et est en attente d'approbation.">
		<cfset Session.Success.Back = "Pr&eacute;ciser les services et les installations">
	</cfif>
	<cfset Session.Success.Link = "#RootDir#reserve-book/tarif-tariff.cfm?lang=#lang#&BookingID=#getID.BookingID#">
	<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">

</cfif>

