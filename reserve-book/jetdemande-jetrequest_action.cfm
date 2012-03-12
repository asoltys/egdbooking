<cfinclude template="#RootDir#includes/errorMessages.cfm">

<cftransaction>
	<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT 	CID
		FROM 	Vessels
		WHERE 	VNID = <cfqueryparam value="#Form.VNID#" cfsqltype="cf_sql_integer" />
		AND		Vessels.Deleted = 0
	</cfquery>

	<cfquery name="createBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		INSERT INTO Bookings
					(VNID,
					StartDate,
					EndDate,
					BookingTime,
					UID)
		VALUES		(<cfqueryparam value="#Form.VNID#" cfsqltype="cf_sql_integer" />,
					<cfqueryparam value="#Form.StartDate#" cfsqltype="cf_sql_date" />,
					<cfqueryparam value="#Form.EndDate#" cfsqltype="cf_sql_date" />,
					<cfqueryparam value="#CreateODBCDateTime(PacificNow)#" cfsqltype="cf_sql_timestamp" />,
					<cfqueryparam value="#session.UID#" cfsqltype="cf_sql_integer" />)
	</cfquery>

	<cfquery name="getID" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	@@IDENTITY AS BRID
		FROM	Bookings
	</cfquery>

	<cfquery name="bookJetty" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		INSERT INTO Jetties(<cfif Form.jetty EQ "north">
								NorthJetty,
							</cfif>
							<cfif Form.jetty EQ "south">
								SouthJetty,
							</cfif>
							<cfif Form.status NEQ "tentative">
								Status,
							</cfif>
							BRID)
		VALUES		(<cfif Form.jetty EQ "north">
						1,
					</cfif>
					<cfif Form.jetty EQ "south">
						1,
					</cfif>
					<cfif Form.status NEQ "tentative">
						'PC',
					</cfif>
						<cfqueryparam value="#getID.BRID#" cfsqltype="cf_sql_integer" />)
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

<cfif Form.jetty EQ "north"><cfset northorsouth = "North Landing Wharf"></cfif>
<cfif Form.jetty EQ "south"><cfset northorsouth = "South Jetty"></cfif>

<cfoutput>
<cfif ServerType EQ "Development">
<cfset Variables.AdminEmail = DevEmail />
</cfif>
	<cfmail to="#Variables.AdminEmail#" from="#getUser.email#" subject="Jetty Booking Requested" type="html" username="#mailuser#" password="#mailpassword#">
<p>#getUser.userName# of #getUser.companyName# has requested a <strong>#variables.status#</strong> #northorsouth# booking for #getDetails.VesselName# from #DateFormat(form.StartDate, request.datemask)# to #DateFormat(form.EndDate, request.datemask)#.</p>
	</cfmail>
</cfoutput>


<cfset Session.Eng.Success.Breadcrumb = "Submit Jetty Booking Request">
<cfset Session.Eng.Success.Title = "Create New Jetty Booking">
<cfset Session.Eng.Success.Message = "A new booking for <strong>#getDetails.vesselName#</strong> from #DateFormat(CreateODBCDate(form.startDate), request.datemask)# to #DateFormat(CreateODBCDate(form.endDate), request.datemask)# has been successfully created.">
<cfset Session.Eng.Success.Back = "Back to Booking Home">
<cfset Session.Eng.Success.Link = "#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#&amp;CID=#getCompany.CID#">
<cfset Session.Fra.Success.Breadcrumb = "Pr&eacute;sentation d'une demande de r&eacute;servation de jet&eacute;e">
<cfset Session.Fra.Success.Title = "&Eacute;tablir une nouvelle r&eacute;servation de jet&eacute;e">
<cfset Session.Fra.Success.Message = "Une nouvelle r&eacute;servation pour <strong>#getDetails.vesselName#</strong> du #DateFormat(CreateODBCDate(form.startDate), request.datemask)# au #DateFormat(CreateODBCDate(form.endDate), request.datemask)# a &eacute;t&eacute; faite avec succ&egrave;s.">
<cfset Session.Fra.Success.Back = "Retour &agrave; Accueil&nbsp;- R&eacute;servation">
<cfset Session.Fra.Success.Link = "#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#&amp;CID=#getCompany.CID#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">
