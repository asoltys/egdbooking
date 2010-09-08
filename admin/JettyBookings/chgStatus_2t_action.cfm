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

<cfquery name="getDetails" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 
		Email, 
		Vessels.Name AS VesselName, 
		StartDate, 
		EndDate, 
		Status 		
	FROM 
		Users INNER JOIN Bookings 
			ON Users.UID = Bookings.UID 
		INNER JOIN Jetties 
			ON Jetties.BRID = Bookings.BRID
		INNER JOIN Vessels 
			ON Bookings.VNID = Vessels.VNID
	WHERE 
		Bookings.BRID = '#Form.BRID#'
</cfquery>

<cfquery name="confirmBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE 	Jetties
	SET 	Status = 'T'	
	WHERE 	BRID = #Form.BRID#
</cfquery>

<cflock throwontimeout="no" scope="session" timeout="30" type="readonly">
	<cfquery name="getAdmin" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Email
		FROM	Users
		WHERE	UID = '#session.UID#'
	</cfquery>
</cflock>


<cfif getDetails.Status EQ 'C'>
<cfquery name="insertbooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE  Bookings
	SET		BookingTimeChange = #PacificNow#,
			BookingTimeChangeStatus = 'Set tentative at'
	WHERE	BRID = '#Form.BRID#'
</cfquery>
<cfoutput>
<cfmail to="#getDetails.Email#" from="#Session.AdminEmail#" subject="Booking Unconfirmed - R&eacute;servation non confirm&eacute;e: #getDetails.VesselName#" type="html">
<p>The confirmation on your jetty booking for #getDetails.VesselName# from #DateFormat(getDetails.StartDate, 'mmm d, yyyy')# to #DateFormat(getDetails.EndDate, 'mmm d, yyyy')# has been removed.  The booking status is now tentative.</p>
<p>Esquimalt Graving Dock</p>
<br />
<p>La confirmation de votre r&eacute;servation de jet&eacute;e pour #getDetails.VesselName# du #DateFormat(getDetails.StartDate, 'mmm d, yyyy')# au #DateFormat(getDetails.EndDate, 'mmm d, yyyy')# a &eacute;t&eacute; supprim&eacute;e.  La r&eacute;servation est maintenant provisoire.
</p>
<p>Cale s&egrave;che d'Esquimalt</p>
</cfmail>
</cfoutput>

<cfelseif getDetails.Status EQ 'PT'>
<cfquery name="insertbooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE  Bookings
	SET		BookingTimeChange = #PacificNow#,
			BookingTimeChangeStatus = 'Set tentative at'
	WHERE	BRID = '#Form.BRID#'
</cfquery>
<cfoutput>
	<cfmail to="#getDetails.Email#" from="#Session.AdminEmail#" subject="Booking Approved - R&eacute;servation approuv&eacute;: #getDetails.VesselName#" type="html">
<p>Your jetty booking for #getDetails.VesselName# from #DateFormat(getDetails.StartDate, 'mmm d, yyyy')# to #DateFormat(getDetails.EndDate, 'mmm d, yyyy')# has been approved.  The booking status is now tentative.  You will receive further notification on confirmation.</p>
<p>Esquimalt Graving Dock</p>
<br />
<p>Votre r&eacute;servation de jet&eacute;e pour #getDetails.VesselName# du #DateFormat(getDetails.StartDate, 'mmm d, yyyy')# au #DateFormat(getDetails.EndDate, 'mmm d, yyyy')# a &eacute;t&eacute; approuv&eacute;e.  La r&eacute;servation est maintenant provisoire.
  Vous recevrez un nouvel avis apr&egrave;s confirmation.</p>
<p>Cale s&egrave;che d'Esquimalt</p>
	</cfmail>
</cfoutput>
</cfif>

<cfif url.referrer NEQ "Edit Booking">
	<!--- create structure for sending to mothership/success page. --->
	<cfset Session.Success.Breadcrumb = "<a href='../admin/JettyBookings/jettyBookingManage.cfm?lang=#lang#'>Jetty Management</a> &gt; Change Booking Status">
	<cfset Session.Success.Title = "Change Booking Status">
	<cfset Session.Success.Message = "Booking status for <b>#getDetails.vesselName#</b> from #LSDateFormat(CreateODBCDate(getDetails.startDate), 'mmm d, yyyy')# to #LSDateFormat(CreateODBCDate(getDetails.endDate), 'mmm d, yyyy')# is now <b>Tentative</b>.  Email notification of this change has been sent to the agent.">
	<cfset Session.Success.Back = "Back to #url.referrer#">
	<cfset Session.Success.Link = "#returnTo#?#urltoken##dateValue#&referrer=#URLEncodedFormat(url.referrer)#&BRID=#Form.BRID###id#form.BRID#">
	<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">
<cfelse>
	<cflocation addtoken="no" url="#returnTo#?#urltoken##dateValue#&BRID=#Form.BRID#">
</cfif>

