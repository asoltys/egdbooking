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
	<cfmail to="#Variables.AdminEmail#" from="#getUser.email#" subject="Jetty Booking Requested" type="html">
<p>#getUser.userName# of #getUser.companyName# has requested a <strong>#variables.status#</strong> #northorsouth# booking for #getDetails.VesselName# from #DateFormat(form.StartDate, 'mmm d, yyyy')# to #DateFormat(form.EndDate, 'mmm d, yyyy')#.</p>
	</cfmail>
</cfoutput>

<cfif lang EQ "eng">
	<cfset Session.Success.Breadcrumb = "Submit Jetty Booking Request">
	<cfset Session.Success.Title = "Create New Jetty Booking">
	<cfset Session.Success.Message = "A new booking for <b>#getDetails.vesselName#</b> from #LSDateFormat(CreateODBCDate(form.startDate), 'mmm d, yyyy')# to #LSDateFormat(CreateODBCDate(form.endDate), 'mmm d, yyyy')# has been successfully created.">
	<cfset Session.Success.Back = "Back to Booking Home">
<cfelse>
	<cfset Session.Success.Breadcrumb = "Pr&eacute;sentation d'une demande de r&eacute;servation de jet&eacute;e">
	<cfset Session.Success.Title = "&Eacute;tablir une nouvelle r&eacute;servation de jet&eacute;e">
	<cfset Session.Success.Message = "Une nouvelle r&eacute;servation pour <b>#getDetails.vesselName#</b> du #LSDateFormat(CreateODBCDate(form.startDate), 'mmm d, yyyy')# au #LSDateFormat(CreateODBCDate(form.endDate), 'mmm d, yyyy')# a &eacute;t&eacute; faite avec succ&egrave;s.">
	<cfset Session.Success.Back = "Retour &agrave; Accueil&nbsp;- R&eacute;servation">
</cfif>
<cfset Session.Success.Link = "#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#&amp;CID=#getCompany.CID#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">
