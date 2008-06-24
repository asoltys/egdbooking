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
		SELECT	@@Identity AS BookingID
		FROM	Bookings
	</cfquery>
	<cfquery name="insertDock" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	INSERT INTO Docks (BookingID)
	VALUES	('#getID.BookingID#')
	</cfquery>
</cftransaction>

<CFQUERY name="getDetails" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Vessels.Name AS vesselName, companyID
	FROM	Vessels
		INNER JOIN	Bookings ON Bookings.VesselID = Vessels.VesselID
	WHERE	BookingID = ('#getID.BookingID#')
</CFQUERY>
	
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
	<cfset Session.Success.Message = "Une nouvelle r&eacute;servation du <b>#getDetails.vesselName#</b> au #LSDateFormat(CreateODBCDate(form.startDate), 'mmm d, yyyy')# to #LSDateFormat(CreateODBCDate(form.endDate), 'mmm d, yyyy')# a &eacute;t&eacute; cr&eacute;&eacute;e et est en attente d'approbation.">
	<cfset Session.Success.Back = "Pr&eacute;ciser les services et les installations">
</cfif>
<cfset Session.Success.Link = "#RootDir#reserve-book/tarif-tariff.cfm?lang=#lang#&BookingID=#getID.BookingID#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">

<cflocation url="" addtoken="no">

