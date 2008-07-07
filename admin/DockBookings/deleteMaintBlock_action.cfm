<cfquery name="deleteBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE	Bookings
	SET		Deleted = 1
	WHERE	BookingID = '#Form.BookingID#'
</cfquery>

<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	startDate, endDate
	from	Bookings
	WHERE	BookingID = '#FORM.BookingID#'
</cfquery>

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

<cfif DateCompare(PacificNow, getBooking.startDate, 'd') NEQ 1 OR (DateCompare(PacificNow, getBooking.startDate, 'd') EQ 1 AND DateCompare(PacificNow, getBooking.endDate, 'd') NEQ 1)>
	<cfset variables.actionCap = "Cancel">
	<cfset variables.actionPast = "cancelled">
<cfelse>
	<cfset variables.actionCap = "Delete">
	<cfset variables.actionPast = "deleted">
</cfif>

<!--- create structure for sending to mothership/success page. --->
<cfset Session.Success.Breadcrumb = "<a href='../admin/DockBookings/bookingmanage.cfm?lang=#lang#'>Drydock Management</a> &gt; <cfoutput>#variables.actionCap#</cfoutput> Drydock Maintenance Block">
<cfset Session.Success.Title = "<cfoutput>#variables.actionCap#</cfoutput> Drydock Maintenance Block">
<cfset Session.Success.Message = "Maintenance block from #LSDateFormat(CreateODBCDate(getBooking.startDate), 'mmm d, yyyy')# to #LSDateFormat(CreateODBCDate(getBooking.endDate), 'mmm d, yyyy')# has been <cfoutput>#variables.actionPast#</cfoutput>.">
<cfset Session.Success.Back = "Back to Dock Bookings Management">
<cfset Session.Success.Link = "#RootDir#admin/DockBookings/bookingmanage.cfm?#urltoken#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">

<!---cflocation addToken="no" url="Bookingmanage.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#"--->
