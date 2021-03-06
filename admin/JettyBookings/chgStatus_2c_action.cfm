<!--- URL tokens set-up.  Do not edit unless you KNOW something is wrong.
	Lois Chan, July 2007 --->
<CFSET variables.urltoken = "lang=#lang#">
<CFIF IsDefined('variables.startDate')>
	<CFSET variables.urltoken = variables.urltoken & "&startDate=#variables.startDate#">
<CFELSEIF IsDefined('url.startDate')>
	<CFSET variables.urltoken = variables.urltoken & "&startDate=#url.startDate#">
</CFIF>
<CFIF IsDefined('variables.endDate')>
	<CFSET variables.urltoken = variables.urltoken & "&endDate=#variables.endDate#">
<CFELSEIF IsDefined('url.endDate')>
	<CFSET variables.urltoken = variables.urltoken & "&endDate=#url.endDate#">
</CFIF>
<CFIF IsDefined('variables.show')>
	<CFSET variables.urltoken = variables.urltoken & "&show=#variables.show#">
<CFELSEIF IsDefined('url.show')>
	<CFSET variables.urltoken = variables.urltoken & "&show=#url.show#">
</CFIF>

<CFPARAM name="url.referrer" default="Booking Management">
<CFIF url.referrer eq "Edit Jetty Booking" OR url.referrer eq "Booking Details">
	<CFSET returnTo = "#RootDir#admin/JettyBookings/editJettyBooking.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#admin/JettyBookings/jettyBookingManage.cfm">
</CFIF>

<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>


<!--- Actual meat of 2c app begins here --->
<cfif IsDefined("Session.Return_Structure")>
	<cfoutput>#StructDelete(Session, "Return_Structure")#</cfoutput>
</cfif>


<cfquery name="confirmBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE 	Jetties
	SET 	Status = 'C'	
	WHERE 	BRID = <cfqueryparam value="#Form.BRID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfquery name="getDetails" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 
		Email, 
		Vessels.Name AS VesselName, 
		StartDate, 
		EndDate
	FROM 
		Users INNER JOIN Bookings 
			ON Users.UID = Bookings.UID 
		INNER JOIN Vessels 
			ON Bookings.VNID = Vessels.VNID
	WHERE 
		BRID = <cfqueryparam value="#Form.BRID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cflock throwontimeout="no" scope="session" timeout="30" type="readonly">
	<cfquery name="getAdmin" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Email
		FROM	Users
		WHERE	UID = <cfqueryparam value="#session.UID#" cfsqltype="cf_sql_integer" />
	</cfquery>
</cflock>
<cfquery name="insertbooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE  Bookings
	SET		BookingTimeChange = <cfqueryparam value="#PacificNow#" cfsqltype="cf_sql_timestamp" />,
			BookingTimeChangeStatus = 'Confirmed at'
	WHERE	BRID = <cfqueryparam value="#Form.BRID#" cfsqltype="cf_sql_integer" />
</cfquery>
<cfoutput>
<cfif ServerType EQ "Development">
<cfset getDetails.Email = DevEmail />
</cfif>
<cfmail to="#getDetails.Email#" from="#AdministratorEmail#" subject="Booking Confirmed - R&eacute;servation confirm&eacute;e: #getDetails.VesselName#" type="html" username="#mailuser#" password="#mailpassword#">
<p>Your requested jetty booking for #getDetails.VesselName# from #DateFormat(getDetails.StartDate, 'mmm d, yyyy')# to #DateFormat(getDetails.EndDate, 'mmm d, yyyy')# has been confirmed.</p>
<p>Esquimalt Graving Dock</p>
<br />
<p>La r&eacute;servation concernant le jet&eacute;e demand&eacute;e pour #getDetails.VesselName# du #DateFormat(getDetails.StartDate, 'mmm d, yyyy')# au #DateFormat(getDetails.EndDate, 'mmm d, yyyy')# a &eacute;t&eacute; confirm&eacute;e.</p>
<p>Cale s&egrave;che d'Esquimalt</p>
</cfmail>
</cfoutput>

<cfif url.referrer NEQ "Edit Booking">
	<!--- create structure for sending to mothership/success page. --->
	<cfset Session.Success.Breadcrumb = "<a href='../admin/JettyBookings/jettyBookingManage.cfm?lang=#lang#'>Jetty Management</a> &gt; Confirm Booking">
	<cfset Session.Success.Title = "Change Booking Status">
	<cfset Session.Success.Message = "Booking status for <strong>#getDetails.vesselName#</strong> from #LSDateFormat(CreateODBCDate(getDetails.startDate), 'mmm d, yyyy')# to #LSDateFormat(CreateODBCDate(getDetails.endDate), 'mmm d, yyyy')# is now <strong>Confirmed</strong>.  Email notification of this change has been sent to the agent.">
	<cfset Session.Success.Back = "Back to #url.referrer#">
	<cfset Session.Success.Link = "#returnTo#?#urltoken##dateValue#&referrer=#URLEncodedFormat(url.referrer)#&BRID=#Form.BRID###id#form.BRID#">
	<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">
<cfelse>
	<cflocation addtoken="no" url="#returnTo#?#urltoken##dateValue#&BRID=#Form.BRID#">
</cfif>

<!---cflocation addtoken="no" url="bookingManage.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show####form.BRID#"--->

