<cfinclude template="#RootDir#includes/errorMessages.cfm">

<cftransaction>
	<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT 	CompanyID
		FROM 	Vessels
		WHERE 	VesselID = '#Form.VesselID#'
		AND		Vessels.Deleted = 0
	</cfquery>

	<cfquery name="createBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		INSERT INTO Bookings
					(VesselID,
					StartDate,
					EndDate,
					BookingTime,
					UserID)
		VALUES		('#Form.VesselID#',
					#Form.StartDate#,
					#Form.EndDate#,
					#CreateODBCDateTime(PacificNow)#,
					#session.userID#)
	</cfquery>

	<cfquery name="getID" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	@@IDENTITY AS BookingID
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
							BookingID)
		VALUES		(<cfif Form.jetty EQ "north">
						1,
					</cfif>
					<cfif Form.jetty EQ "south">
						1,
					</cfif>
					<cfif Form.status NEQ "tentative">
						'Y',
					</cfif>
						'#getID.BookingID#')
	</cfquery>
</cftransaction>

<cfquery name="getDetails" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Vessels.Name AS vesselName, companyID
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
<cfset Session.Success.Link = "#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#$amp;companyID=#getCompany.CompanyID#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">
