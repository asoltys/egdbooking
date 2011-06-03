<cfset Variables.Start = CreateODBCDate(url.editStart)>
<cfset Variables.End = CreateODBCDate(url.editEnd)>
<cfset Variables.BookingDateTime = #CreateDateTime(DatePart('yyyy',Form.bookingDate), DatePart('m',Form.bookingDate), DatePart('d',Form.bookingDate), DatePart('h',Form.bookingTime), DatePart('n',Form.bookingTime), DatePart('s',Form.bookingTime))#>
<cfset Variables.EndHighlight = DateAdd("d", 5, PacificNow)>

<cfquery name="updateBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE	Bookings
	SET		StartDate = <cfqueryparam value="#Variables.Start#" cfsqltype="cf_sql_date" />, 
			EndDate = <cfqueryparam value="#Variables.End#" cfsqltype="cf_sql_date" />,
			BookingTime = <cfqueryparam value="#CreateODBCDateTime(Variables.BookingDateTime)#" cfsqltype="cf_sql_timestamp" />,
			UID = <cfqueryparam value="#Form.UID#" cfsqltype="cf_sql_integer" />,
			BookingTimeChange = <cfqueryparam value="#PacificNow#" cfsqltype="cf_sql_timestamp" />,
			BookingTimeChangeStatus = 'Edited at',
			EndHighlight = <cfqueryparam value="#DateFormat(Variables.EndHighlight, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />
	WHERE	BRID = <cfqueryparam value="#url.BRID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfquery name="updateBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE	Jetties
	SET		<cfif url.jetty EQ "north">
				NorthJetty = 1,
				SouthJetty = 0
			<cfelse>
				NorthJetty = 0,
				SouthJetty = 1 
			</cfif>
	WHERE	BRID = <cfqueryparam value="#url.BRID#" cfsqltype="cf_sql_integer" />
</cfquery>
	

<cfif IsDefined("Session.Return_Structure")>
	<cfset StructDelete(Session, "Return_Structure")>
</cfif>

<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	startDate, endDate
	from	Bookings
	WHERE	BRID = <cfqueryparam value="#FORM.BRID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Vessels.Name AS vesselName
	FROM	Vessels
		INNER JOIN	Bookings ON Bookings.VNID = Vessels.VNID
	WHERE	BRID = <cfqueryparam value="#FORM.BRID#" cfsqltype="cf_sql_integer" />
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

<CFPARAM name="url.referrer" default="Booking Management">
<CFIF url.referrer eq "Booking Details">
	<CFSET returnTo = "#RootDir#comm/detail-res-book.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#admin/JettyBookings/jettybookingManage.cfm">
</CFIF>

<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>

<!--- create structure for sending to mothership/success page. --->
<cfset Session.Success.Breadcrumb = "<a href=../admin/JettyBookings/jettyBookingManage.cfm?lang=#lang#'>Jetty Management</a> &gt; Edit Jetty Booking">
<cfset Session.Success.Title = "Edit Jetty Booking Information">
<cfset Session.Success.Message = "Booking for <b>#getVessel.vesselName#</b> from #LSDateFormat(CreateODBCDate(form.startDate), 'mmm d, yyyy')# to #LSDateFormat(CreateODBCDate(form.endDate), 'mmm d, yyyy')# has been updated.">
<cfset Session.Success.Back = "Back to #url.referrer#">
<cfset Session.Success.Link = "#returnTo#?#urltoken#&BRID=#form.BRID##variables.dateValue####form.BRID#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">

