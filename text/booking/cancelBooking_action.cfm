<!---cfquery name="cancelBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE	Bookings
	SET		Deleted = 1
	WHERE	BookingID = #Form.BookingID#
</cfquery--->
<CFIF #url.jetty#>
	<cfquery name="cancelRequest" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	Jetties
		SET		Status = 'X'
		WHERE	BookingID = #Form.BookingID#
	</cfquery>
<CFELSE>
	<cfquery name="cancelRequest" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	Docks
		SET		Status = 'X'
		WHERE	BookingID = #Form.BookingID#
	</cfquery>
</CFIF>
<CFQUERY name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Vessels.Name AS vesselName, StartDate, EndDate
	FROM	Bookings INNER JOIN	Vessels ON Bookings.VesselID = Vessels.VesselID
	WHERE	Bookings.BookingID = '#Form.BookingID#'
</CFQUERY>

<cflock scope="session" throwontimeout="no" timeout="30" type="READONLY">
	<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	firstname + ' ' + lastname AS UserName, Email
		FROM	Users
		WHERE	UserID = #session.userID#
	</cfquery>
</cflock>

<cfoutput>

<cfquery name="insertbooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE  Bookings
	SET		BookingTimeChange = #Now()#,
			BookingTimeChangeStatus = '#getUser.UserName# requested to cancel at'
	WHERE	BookingID = '#Form.BookingID#'
</cfquery>

	<cfmail to="#Variables.AdminEmail#" from="#getUser.email#" subject="Booking Cancellation Request" type="html">
<p>#getUser.UserName# has requested to cancel the booking for #getBooking.VesselName# from #DateFormat(getBooking.StartDate, 'mmm d, yyyy')# to #DateFormat(getBooking.EndDate, 'mmm d, yyyy')#.</p>
	</cfmail>
	
	<cfmail to="#getUser.email#" from="#Variables.AdminEmail#" subject="Booking Cancellation Request - Demande d'annulation de réservation" type="html">
<p>Your cancellation request for the booking for #getBooking.VesselName# from #DateFormat(getBooking.StartDate, 'mmm d, yyyy')# to #DateFormat(getBooking.EndDate, 'mmm d, yyyy')# is now pending.  EGD administration has been notified of your request.  You will receive a follow-up email responding to your request shortly.</p>
<p>&nbsp;</p>
<p>Votre demande d'annulation de la réservation pour le #getBooking.VesselName# du #DateFormat(getBooking.StartDate, 'mmm d, yyyy')# au #DateFormat(getBooking.EndDate, 'mmm d, yyyy')# est en cours de traitement. L'administration de la CSE a été avisée de votre demande. Vous recevrez sous peu un courriel de suivi en réponse à votre demande. D'ici là, votre place est considérée comme réservée pour les dates indiquées.</p>
	</cfmail>
</cfoutput>

<CFPARAM name="url.referrer" default="Booking Home">
<CFIF url.referrer eq "Details For">
	<CFSET returnTo = "#RootDir#text/common/getDetail.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#text/booking/booking.cfm">
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
<cfif lang EQ "e">
	<cfset Session.Success.Breadcrumb = "Booking Cancellation Request">
	<cfset Session.Success.Title = "Booking Cancellation Request">
	<cfset Session.Success.Message = "<div align='left'>Your cancellation request for the booking for <b>#getBooking.vesselName#</b> from #LSDateFormat(CreateODBCDate(getBooking.startDate), 'mmm d, yyyy')# to #LSDateFormat(CreateODBCDate(getBooking.endDate), 'mmm d, yyyy')# is now pending.  EGD administration has been notified of your request.  You will receive a follow-up email responding to your request shortly.</div>">
	<cfset Session.Success.Back = "Back to #url.referrer#">
<cfelse>
	<cfset Session.Success.Breadcrumb = "Demande d'annulation de réservation">
	<cfset Session.Success.Title = "Demande d'annulation de réservation">
	<cfset Session.Success.Message = "<div align='left'>Votre demande d'annulation de la réservation pour le <b>#getBooking.vesselName#</b> du #LSDateFormat(CreateODBCDate(getBooking.startDate), 'mmm d, yyyy')# au #LSDateFormat(CreateODBCDate(getBooking.endDate), 'mmm d, yyyy')#  est en cours de traitement. L'administration de la CSE a été avisée de votre demande. Vous recevrez sous peu un courriel de suivi en réponse à votre demande.</div>">
	<cfset Session.Success.Back = "Retour &agrave;">
</cfif>
<cfset Session.Success.Link = "#returnTo#?#urltoken#&CompanyID=#url.CompanyID##variables.dateValue#">
<cflocation addtoken="no" url="#RootDir#text/common/success.cfm?lang=#lang#">
