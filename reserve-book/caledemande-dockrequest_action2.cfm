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
		SELECT	@@Identity AS BRID
		FROM	Bookings
	</cfquery>
	<cfquery name="insertDock" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	INSERT INTO Docks (BRID)
	VALUES	(<cfqueryparam value="#getID.BRID#" cfsqltype="cf_sql_integer" />)
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
<p>#getUser.userName# of #getUser.companyName# has requested a <strong>#variables.status#</strong> drydock booking for #getDetails.VesselName# from #DateFormat(Form.StartDate, 'mmm d, yyyy')# to #DateFormat(Form.EndDate, 'mmm d, yyyy')#.</p>
	</cfmail>
</cfoutput>

	<!--- create structure for sending to mothership/success page. --->
<cfif lang EQ "eng">
	<cfset Session.Success.Breadcrumb = "Submit Drydock Booking Request">
	<cfset Session.Success.Title = "Create New Drydock Booking">
	<cfset Session.Success.Message = "A new booking request for <strong>#getDetails.vesselName#</strong> from #LSDateFormat(CreateODBCDate(form.startDate), 'mmm d, yyyy')# to #LSDateFormat(CreateODBCDate(form.endDate), 'mmm d, yyyy')# has been successfully created and is pending approval.">
	<cfset Session.Success.Back = "Specify Services and Facilities">
<cfelse>
	<cfset Session.Success.Breadcrumb = "Pr&eacute;senter une nouvelle demande de r&eacute;servation de la cale s&egrave;che">
	<cfset Session.Success.Title = "&Eacute;tablir une nouvelle r&eacute;servation de cale s&egrave;che">
	<cfset Session.Success.Message = "Une nouvelle r&eacute;servation du <strong>#getDetails.vesselName#</strong> au #LSDateFormat(CreateODBCDate(form.startDate), 'mmm d, yyyy')# to #LSDateFormat(CreateODBCDate(form.endDate), 'mmm d, yyyy')# a &eacute;t&eacute; cr&eacute;&eacute;e et est en attente d'approbation.">
	<cfset Session.Success.Back = "Pr&eacute;ciser les services et les installations">
</cfif>
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">

<cflocation url="" addtoken="no">

