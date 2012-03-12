<cfif structKeyExists(form, 'jetty')>
  <cfset url.jetty = form.jetty />
</cfif>
<cfparam name="url.jetty" default="false" />
<CFIF url.jetty>
	<cfquery name="cancelRequest" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	Jetties
		SET		Status = 'PX'
		WHERE	BRID = <cfqueryparam value="#Form.BRID#" cfsqltype="cf_sql_integer" />
	</cfquery>
<CFELSE>
	<cfquery name="cancelRequest" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	Docks
		SET		Status = 'PX'
		WHERE	BRID = <cfqueryparam value="#Form.BRID#" cfsqltype="cf_sql_integer" />
	</cfquery>
</CFIF>
<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Vessels.Name AS vesselName, StartDate, EndDate
	FROM	Bookings INNER JOIN	Vessels ON Bookings.VNID = Vessels.VNID
	WHERE	Bookings.BRID = <cfqueryparam value="#Form.BRID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cflock scope="session" throwontimeout="no" timeout="30" type="READONLY">
	<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	firstname + ' ' + lastname AS UserName, Email
		FROM	Users
		WHERE	UID = <cfqueryparam value="#session.UID#" cfsqltype="cf_sql_integer" />
	</cfquery>
</cflock>

<cfset queryvarchar = getUser.UserName & " requested to cancel at" />

<cfoutput>
<cfquery name="insertbooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE  Bookings
	SET		BookingTimeChange = <cfqueryparam value="#PacificNow#" cfsqltype="cf_sql_timestamp" />,
			BookingTimeChangeStatus = <cfqueryparam value="#queryvarchar#" cfsqltype="cf_sql_varchar" />
	WHERE	BRID = <cfqueryparam value="#Form.BRID#" cfsqltype="cf_sql_integer" />
</cfquery>

	<cfif ServerType EQ "Development">
<cfset Variables.AdminEmail = DevEmail />
</cfif>
	< username="#mailuser#" password="#mailpassword#"cfmail to="#Variables.AdminEmail#" from="#getUser.email#" subject="Booking Cancellation Request" type="html">
<p>#getUser.UserName# has requested to cancel the booking for #getBooking.VesselName# from #myDateFormat(getBooking.StartDate, request.datemask)# to #myDateFormat(getBooking.EndDate, request.datemask)#.</p>
	</cfmail>
	
	<cfif ServerType EQ "Development">
<cfset getUser.email = DevEmail />
</cfif>
	< username="#mailuser#" password="#mailpassword#"cfmail to="#getUser.email#" from="#Variables.AdminEmail#" subject="Booking Cancellation Request - Demande d'annulation de r&eacute;servation: #getBooking.VesselName#" type="html">
<p>Your cancellation request for the booking for #getBooking.VesselName# from #myDateFormat(getBooking.StartDate, request.datemask)# to #myDateFormat(getBooking.EndDate, request.datemask)# is now pending.  EGD administration has been notified of your request.  You will receive a follow-up email responding to your request shortly.</p>
<p>&nbsp;</p>
<p>Votre demande d'annulation de la r&eacute;servation pour le #getBooking.VesselName# du #myDateFormat(getBooking.StartDate, request.datemask)# au #myDateFormat(getBooking.EndDate, request.datemask)# est en cours de traitement. L'administration de la CSE a &eacute;t&eacute; avis&eacute;e de votre demande. Vous recevrez sous peu un courriel de suivi en r&eacute;ponse &agrave; votre demande. D'ici l&agrave;, votre place est consid&eacute;r&eacute;e comme r&eacute;serv&eacute;e pour les dates indiqu&eacute;es.</p>
	</cfmail>
</cfoutput>

<CFPARAM name="url.referrer" default="#language.bookingHome#">
<CFIF url.referrer eq "Details For">
	<CFSET returnTo = "#RootDir#comm/detail.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#reserve-book/reserve-booking.cfm">
</CFIF>

<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>

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

<!--- create structure for sending to mothership/success page. --->
<cfset Session.Eng.Success.Breadcrumb = "Booking Cancellation Request">
<cfset Session.Eng.Success.Title = "Booking Cancellation Request">
<cfset Session.Eng.Success.Message = "<div align='left'>Your cancellation request for the booking for <strong>#getBooking.vesselName#</strong> from #myDateFormat(CreateODBCDate(getBooking.startDate), request.datemask)# to #myDateFormat(CreateODBCDate(getBooking.endDate), request.datemask)# is now pending.  EGD administration has been notified of your request.  You will receive a follow-up email responding to your request shortly.</div>">
<cfset Session.Eng.Success.Link = "#returnTo#?#urltoken#&CID=#url.CID##variables.dateValue#">

<cfset Session.Fra.Success.Breadcrumb = "Demande d'annulation de r&eacute;servation">
<cfset Session.Fra.Success.Title = "Demande d'annulation de r&eacute;servation">
<cfset Session.Fra.Success.Message = "<div align='left'>Votre demande d'annulation de la r&eacute;servation pour le <strong>#getBooking.vesselName#</strong> du #myDateFormat(CreateODBCDate(getBooking.startDate), request.datemask)# au #myDateFormat(CreateODBCDate(getBooking.endDate), request.datemask)#  est en cours de traitement. L'administration de la CSE a &eacute;t&eacute; avis&eacute;e de votre demande. Vous recevrez sous peu un courriel de suivi en r&eacute;ponse &agrave; votre demande.</div>">
<cfset Session.Fra.Success.Link = "#returnTo#?#urltoken#&CID=#url.CID##variables.dateValue#">

<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">

