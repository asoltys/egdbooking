<!--- <cfif IsDefined("Session.Return_Structure")>
	<cfoutput>#StructDelete(Session, "Return_Structure")#</cfoutput>
</cfif>

<cfset Errors = ArrayNew(1)>
<cfset Success = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<!--- <cfoutput>#ArrayAppend(Success, "The booking has been successfully added.")#</cfoutput> --->

<!--- Validate the form data --->
<cfif Form.StartDate GT Form.EndDate>
	<cfoutput>#ArrayAppend(Errors, "The Start Date must be before the End Date.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>
<cfif DateDiff("d",Form.StartDate,Form.EndDate) LT 1>
	<cfoutput>#ArrayAppend(Errors, "The minimum booking time is 1 day.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfset Variables.StartDate = CreateODBCDate(Form.StartDate)>
<cfset Variables.EndDate = CreateODBCDate(Form.EndDate)>

<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	VNID, Length, Width
	FROM 	Vessels
	WHERE 	VNID = '#Form.BRID#'
	AND 	Deleted= 0
</cfquery>

<!---Check to see that vessel hasn't already been booked during this time--->
<cfquery name="checkDblBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Bookings.VNID, Name, StartDate, EndDate
	FROM 	Bookings, Vessels
	WHERE 	Bookings.VNID = '#getVessel.VNID#'
	AND		Vessels.VNID = Bookings.VNID
	AND		Bookings.BRID != '#Form.BRID#'
	AND 	(
				(	Bookings.StartDate <= #Variables.StartDate# AND #Variables.StartDate# <= Bookings.EndDate )
			OR 	(	Bookings.StartDate <= #Variables.EndDate# AND #Variables.EndDate# <= Bookings.EndDate )
			OR	(	Bookings.StartDate >= #Variables.StartDate# AND #Variables.EndDate# >= Bookings.EndDate)
			)
	AND		Deleted = 0
</cfquery>

<cfif DateCompare(PacificNow, Form.StartDate, 'd') EQ 1>
	<cfoutput>#ArrayAppend(Errors, "The Start Date can not be in the past.")#</cfoutput>
	<cfset Proceed_OK = "No">
<cfelseif DateCompare(PacificNow, Form.StartDate, 'd') EQ 0>
	<cfoutput>#ArrayAppend(Errors, "The start date can not be set for today.")#</cfoutput>
	<cfset Proceed_OK = "No">n
<cfelseif NOT isDefined("checkDblBooking.VNID") OR checkDblBooking.VNID NEQ "">
	<cfoutput>#ArrayAppend(Errors, "#checkDblBooking.Name# has already been booked from #dateFormat(checkDblBooking.StartDate, 'mm/dd/yyy')# to #dateFormat(checkDblBooking.EndDate, 'mm/dd/yyy')#.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>





<cfif Proceed_OK EQ "No">
	<!--- Save the form data in a session structure so it can be sent back to the form page --->
	<cfset Session.Return_Structure.StartDate = Form.StartDate>
	<cfset Session.Return_Structure.EndDate = Form.EndDate>
	<cfset Session.Return_Structure.BRID = Form.BRID>	
	<cfset Session.Return_Structure.Errors = Errors>
	
 	<cflocation url="editBooking.cfm?lang=#lang#" addtoken="no">
<cfelse> --->

<cfset Variables.BookingDateTime = #CreateDateTime(DatePart('yyyy',Form.bookingDate), DatePart('m',Form.bookingDate), DatePart('d',Form.bookingDate), DatePart('h',Form.bookingTime), DatePart('n',Form.bookingTime), DatePart('s',Form.bookingTime))#>
<cfset Variables.EndHighlight = DateAdd("d", 5, PacificNow)>

	<cfquery name="insertbooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE  Bookings
	SET		StartDate = <cfqueryparam value="#CreateODBCDate(Form.StartDate)#" cfsqltype="cf_sql_date">,
			EndDate = <cfqueryparam value="#CreateODBCDate(Form.EndDate)#" cfsqltype="cf_sql_date">, 
			UID = <cfqueryparam value="#Form.UID#" cfsqltype="cf_sql_integer" />,
			BookingTime = <cfqueryparam value="#CreateODBCDateTime(Variables.BookingDateTime)#" cfsqltype="cf_sql_timestamp" />,
			BookingTimeChange = <cfqueryparam value="#PacificNow#" cfsqltype="cf_sql_timestamp" />,
			BookingTimeChangeStatus = 'Edited at',
			EndHighlight = <cfqueryparam value="#DateFormat(Variables.EndHighlight, 'mm/dd/yyyy')#" cfsqltype="cf_sql_timestamp" />
	WHERE	BRID = <cfqueryparam value="#Form.BRID#" cfsqltype="cf_sql_integer" />
	</cfquery>
<!--- </cfif> --->

<cfquery name="updateDock" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE	Docks
	SET		<cfif isDefined("form.section1") AND form.section1 EQ true>section1 = 1,<cfelse>section1 = 0,</cfif>
			<cfif isDefined("form.section2") AND form.section2 EQ true>section2 = 1,<cfelse>section2 = 0,</cfif>
			<cfif isDefined("form.section3") AND form.section3 EQ true>section3 = 1<cfelse>section3 = 0</cfif>
	WHERE	BRID = <cfqueryparam value="#Form.BRID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Vessels.Name AS vesselName
	FROM	Vessels
		INNER JOIN	Bookings ON Bookings.VNID = Vessels.VNID
	WHERE	BRID = <cfqueryparam value="#Form.BRID#" cfsqltype="cf_sql_integer" />
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

<!--- create structure for sending to mothership/success page. --->
<CFPARAM name="url.referrer" default="Drydock Booking Management">
<cfif url.referrer EQ "Edit Booking"><cfset url.referrer = "Drydock Booking Management"></cfif>
<CFIF url.referrer eq "Booking Details">
	<CFSET returnTo = "#RootDir#comm/detail-res-book.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#admin/DockBookings/bookingManage.cfm">
</CFIF>

<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>

<cfset Session.Success.Breadcrumb = "<a href='../admin/DockBookings/bookingManage.cfm?lang=#lang#'>Drydock Management</a> &gt; Edit Dock Booking">
<cfset Session.Success.Title = "Edit Dock Booking Information">
<cfset Session.Success.Message = "Booking for <strong>#getBooking.vesselName#</strong> from #LSDateFormat(CreateODBCDate(form.startDate), 'mmm d, yyyy')# to #LSDateFormat(CreateODBCDate(form.endDate), 'mmm d, yyyy')# has been updated.">
<cfset Session.Success.Back = "Back to #url.referrer#">

<cfset Session.Success.Link = "#returnTo#?#urltoken#&BRID=#form.BRID#&#variables.dateValue###id#form.BRID#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">

<!---CFLOCATION addtoken="no" url="#RootDir#admin/DockBookings/bookingManage.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show####form.BRID#"--->
