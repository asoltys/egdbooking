<cfparam name="Form.BookingID" default="">

<cfquery name="getDetails" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Status, Email, Vessels.Name AS VesselName, StartDate, EndDate
	FROM	Docks INNER JOIN Bookings ON Docks.BookingID = Bookings.BookingID
			INNER JOIN Users ON Bookings.UserID = Users.UserID 
			INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID
	WHERE	Bookings.BookingID = '#Form.BookingID#'
</cfquery>

<cfquery name="removeConfirmation" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE 	Docks
	SET 	Status = 'T',
			Section1 = '0',
			Section2 = '0',
			Section3 = '0'
	WHERE 	BookingID = '#Form.BookingID#'
</cfquery>

<cflock throwontimeout="no" scope="session" timeout="30" type="readonly">
	<cfquery name="getAdmin" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Email
		FROM	Users
		WHERE	UserID = '#session.userID#'
	</cfquery>
</cflock>

<cfoutput>
	<cfmail to="#getDetails.Email#" from="#Session.AdminEmail#" subject="Booking Denied - Votre Confirmation est Refus&eacute;e" type="html">
<p>Your confirmation is declined due to other priority. The confirmation on your dock booking for #getDetails.VesselName# from #DateFormat(getDetails.StartDate, 'mmm d, yyyy')# to #DateFormat(getDetails.EndDate, 'mmm d, yyyy')# has been removed.  The booking status is now tentative.</p>
<p>Esquimalt Graving Dock</p>
<br>
<p>Votre confirmation est refus&eacute;e parce qu'il y a d'autres priorit&eacute;s. La confirmation de votre r&eacute;servation de la cale s&egrave;che pour #getDetails.VesselName# du #DateFormat(getDetails.StartDate, 'mmm d, yyyy')# au #DateFormat(getDetails.EndDate, 'mmm d, yyyy')# a &eacute;t&eacute; supprim&eacute;e.  La r&eacute;servation est maintenant provisoire.
</p>
<p>Cale s&egrave;che d'Esquimalt</p>
	</cfmail>
</cfoutput>

<CFPARAM name="url.referrer" default="Booking Management">
<CFIF url.referrer eq "Edit Booking" OR url.referrer eq "Booking Details">
	<CFSET returnTo = "#RootDir#admin/DockBookings/editBooking.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#admin/DockBookings/bookingManage.cfm">
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

<cfif url.referrer NEQ "Edit Booking">
	<!--- create structure for sending to mothership/success page. --->
	<cfset Session.Success.Breadcrumb = "<A href='../admin/DockBookings/bookingmanage.cfm?lang=#lang#'>Drydock Management</A> &gt; Change Booking Status">
	<cfset Session.Success.Title = "Change Booking Status">
	<cfset Session.Success.Message = "Booking status for <b>#getDetails.vesselName#</b> from #LSDateFormat(CreateODBCDate(getDetails.startDate), 'mmm d, yyyy')# to #LSDateFormat(CreateODBCDate(getDetails.endDate), 'mmm d, yyyy')# is now <b>Tentative</b>.  Email notification of this change has been sent to the agent.">
	<cfset Session.Success.Back = "Back to #url.referrer#">
	<cfset Session.Success.Link = "#returnTo#?#urltoken##dateValue#&referrer=#URLEncodedFormat(url.referrer)#&bookingID=#Form.BookingId###id#form.bookingid#">
	<cflocation addtoken="no" url="#RootDir#comm/success.cfm?lang=#lang#">
<cfelse>
	<cflocation addtoken="no" url="#returnTo#?#urltoken##dateValue#&bookingID=#Form.BookingId#">
</cfif>

<!---cflocation addtoken="no" url="bookingmanage.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show####form.bookingID#"--->

