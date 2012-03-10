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
	SELECT 	Bookings.VNID, Vessels.Name, Bookings.StartDate, Bookings.EndDate
	FROM 	Bookings
				INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
				INNER JOIN Docks ON Bookings.BRID = Docks.BRID
	WHERE 	Bookings.VNID = <cfqueryparam value="#Form.VNID#" cfsqltype="cf_sql_integer" />
	AND
	<!---Explanation of hellishly long condition statement: The client wants to be able to overlap the start and end dates
		of bookings, so if a booking ends on May 6, another one can start on May 6.  This created problems with single day
		bookings, so if you are changing this query...watch out for them.  The first 3 lines check for any bookings longer than
		a day that overlaps with the new booking if it is more than a day.  The next 4 lines check for single day bookings that
		fall within a booking that is more than one day.--->
			(
				(	Bookings.StartDate <= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> < Bookings.EndDate AND <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> <> <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND Bookings.StartDate <> Bookings.EndDate)
			OR 	(	Bookings.StartDate < <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate AND <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> <> <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND Bookings.StartDate <> Bookings.EndDate)
			OR	(	Bookings.StartDate >= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> >= Bookings.EndDate AND <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> <> <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND Bookings.StartDate <> Bookings.EndDate)
			OR  (	(Bookings.StartDate = Bookings.EndDate OR <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> = <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" />) AND Bookings.StartDate <> <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND Bookings.EndDate <> <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND
						((	Bookings.StartDate <= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> < Bookings.EndDate)
					OR 	(	Bookings.StartDate < <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate)
					OR	(	Bookings.StartDate >= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> >= Bookings.EndDate)))
			)
	AND		Bookings.Deleted = 0
</cfquery>

<cfif DateCompare(PacificNow, Form.StartDate, 'd') NEQ -1>
	<cfoutput>#ArrayAppend(Errors, "#language.futureStartError#")#</cfoutput>
	<cfset Proceed_OK = "No">
<cfelseif NOT isDefined("checkDblBooking.VNID") OR checkDblBooking.VNID NEQ "">
	<cfoutput>#ArrayAppend(Errors, "#checkDblBooking.Name# #language.dblBookingError# #myDateFormat(checkDblBooking.StartDate, 'mm/dd/yyy')# #language.to# #myDateFormat(checkDblBooking.EndDate, 'mm/dd/yyy')#.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif DateDiff("d",Form.StartDate,Form.EndDate) LT 0>
	<cfoutput>#ArrayAppend(Errors, "#language.bookingTooShortError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif form.status EQ "tentative">
	<cfset status = 'PT'>
<cfelse>
	<cfset status = 'PC'>
</cfif>

<cfif Proceed_OK EQ "No">
	<!--- Save the form data in a session structure so it can be sent back to the form page --->
	<cfset Session.Return_Structure.StartDate = Form.StartDate>
	<cfset Session.Return_Structure.EndDate = Form.EndDate>
	<cfset Session.Return_Structure.VNID = Form.VNID>
	<cfset Session.Return_Structure.Errors = Errors>

 	<cflocation url="#RootDir#reserve-book/caledemande-dockrequest.cfm?lang=#lang#" addtoken="no">
<cfelse>
	<cftransaction>
		<cfquery name="insertbooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			INSERT INTO	Bookings ( VNID, StartDate, EndDate, BookingTime, UID)
			VALUES	(<cfqueryparam value="#Form.VNID#" cfsqltype="cf_sql_integer" />,
					<cfqueryparam value="#CreateODBCDate(Form.StartDate)#" cfsqltype="cf_sql_date">,
					<cfqueryparam value="#CreateODBCDate(Form.EndDate)#" cfsqltype="cf_sql_date">,
					<cfqueryparam value="#CreateODBCDateTime(PacificNow)#" cfsqltype="cf_sql_timestamp">,
					<cfqueryparam value="#Session.UID#" cfsqltype="cf_sql_integer" />)
		</cfquery>
		<cfquery name="getID" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT	DISTINCT @@IDENTITY AS BRID
			FROM	Bookings
		</cfquery>
		<cfquery name="insertDock" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			INSERT INTO Docks (BRID, Status)
			VALUES		(<cfqueryparam value="#getID.BRID#" cfsqltype="cf_sql_integer" />, <cfqueryparam value="#status#" cfsqltype="cf_sql_varchar" />)
		</cfquery>
	</cftransaction>

	<cfquery name="getDetails" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Vessels.Name AS vesselName, CID
		FROM	Vessels
			INNER JOIN	Bookings ON Bookings.VNID = Vessels.VNID
		WHERE	BRID = (<cfqueryparam value="#getID.BRID#" cfsqltype="cf_sql_integer" />)
	</cfquery>

	<cflock scope="session" throwontimeout="no" timeout="30" type="READONLY">
		<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT	firstname + ' ' + lastname AS UserName, Email, Companies.Name AS CompanyName
			FROM	Users INNER JOIN UserCompanies ON Users.UID = UserCompanies.UID
					INNER JOIN Companies ON UserCompanies.CID = Companies.CID
			WHERE	Users.UID = <cfqueryparam value="#session.UID#" cfsqltype="cf_sql_integer" /> AND Companies.CID = <cfqueryparam value="#getDetails.CID#" cfsqltype="cf_sql_integer" />
		</cfquery>
	</cflock>

	<cfif form.status EQ "tentative"><cfset variables.status = #language.tentative#><cfelse><cfset variables.status = #language.confirmed#></cfif>

	<cfoutput>
	<cfif ServerType EQ "Development">
<cfset Variables.AdminEmail = DevEmail />
</cfif>
		<cfmail to="#Variables.AdminEmail#" from="#getUser.email#" subject="Drydock Booking Requested" type="html">
	<p>#getUser.userName# of #getUser.companyName# has requested a <strong>#variables.status#</strong> drydock booking for #getDetails.VesselName# from #DateFormat(Form.StartDate, request.datemask)# to #DateFormat(Form.EndDate, request.datemask)#.</p>
		</cfmail>
	</cfoutput>

	<!--- create structure for sending to mothership/success page. --->
		<cfset Session.Eng.Success.Breadcrumb = "Submit Drydock Booking Request">
		<cfset Session.Eng.Success.Title = "Create New Drydock Booking">
		<cfset Session.Eng.Success.Message = "A new booking request for <strong>#getDetails.vesselName#</strong> from #myDateFormat(CreateODBCDate(form.startDate), request.datemask)# to #myDateFormat(CreateODBCDate(form.endDate), request.datemask)# has been successfully created and is pending approval.">
		<cfset Session.Eng.Success.Back = language.returnTo>
		<cfset Session.Fra.Success.Breadcrumb = "Pr&eacute;senter une nouvelle demande de r&eacute;servation de la cale s&egrave;che">
		<cfset Session.Fra.Success.Title = "&Eacute;tablir une nouvelle r&eacute;servation de cale s&egrave;che">
		<cfset Session.Fra.Success.Message = "Une nouvelle demande de r&eacute;servation pour le #getDetails.vesselName# du #myDateFormat(CreateODBCDate(form.startDate), request.datemask)# au #myDateFormat(CreateODBCDate(form.endDate), request.datemask)# a &eacute;t&eacute; cr&eacute;&eacute;e et est en attente d'approbation.">
		<cfset Session.Fra.Success.Back = language.returnTo>
	<cfset Session.Success.Link = "#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">
	<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">

</cfif>

