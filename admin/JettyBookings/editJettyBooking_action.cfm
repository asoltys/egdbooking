<cfset Variables.Start = CreateODBCDate(url.editStart)>
<cfset Variables.End = CreateODBCDate(url.editEnd)>
<cfset Variables.BookingDateTime = #CreateDateTime(DatePart('yyyy',Form.bookingDate), DatePart('m',Form.bookingDate), DatePart('d',Form.bookingDate), DatePart('h',Form.bookingTime), DatePart('n',Form.bookingTime), DatePart('s',Form.bookingTime))#>
	
<CFQUERY name="updateBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE	Bookings
	SET		StartDate = #Variables.Start#, 
			EndDate = #Variables.End#,
			BookingTime = #CreateODBCDateTime(Variables.BookingDateTime)#,
			UserID = #Form.UserID#,
			BookingTimeChange = #PacificNow#,
			BookingTimeChangeStatus = 'Edited at'
	WHERE	BookingID = '#url.BookingID#'
</CFQUERY>

<CFQUERY name="updateBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE	Jetties
	SET		<cfif url.jetty EQ "north">
				NorthJetty = 1,
				SouthJetty = 0
			<cfelse>
				NorthJetty = 0,
				SouthJetty = 1 
			</cfif>
	WHERE	BookingID = '#url.BookingID#'
</CFQUERY>
	

<cfif IsDefined("Session.Return_Structure")>
	<cfset StructDelete(Session, "Return_Structure")>
</cfif>

<CFQUERY name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	startDate, endDate
	from	Bookings
	WHERE	BookingID = '#FORM.BookingID#'
</CFQUERY>

<CFQUERY name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Vessels.Name AS vesselName
	FROM	Vessels
		INNER JOIN	Bookings ON Bookings.VesselID = Vessels.VesselID
	WHERE	BookingID = '#Form.BookingID#'
</CFQUERY>

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
<CFIF url.referrer eq "Booking Details">
	<CFSET returnTo = "#RootDir#comm/getBookingDetail.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#admin/JettyBookings/jettybookingManage.cfm">
</CFIF>

<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>

<!--- create structure for sending to mothership/success page. --->
<cfset Session.Success.Breadcrumb = "<a href=../admin/JettyBookings/jettyBookingmanage.cfm?lang=#lang#'>Jetty Management</A> &gt; Edit Jetty Booking">
<cfset Session.Success.Title = "Edit Jetty Booking Information">
<cfset Session.Success.Message = "Booking for <b>#getVessel.vesselName#</b> from #LSDateFormat(CreateODBCDate(form.startDate), 'mmm d, yyyy')# to #LSDateFormat(CreateODBCDate(form.endDate), 'mmm d, yyyy')# has been updated.">
<cfset Session.Success.Back = "Back to #url.referrer#">
<cfset Session.Success.Link = "#returnTo#?#urltoken#&bookingID=#form.bookingID##variables.dateValue####form.bookingid#">
<cflocation addtoken="no" url="#RootDir#comm/success.cfm?lang=#lang#">

<!---cflocation url="jettyBookingmanage.cfm?#urltoken#" addToken="no"--->

