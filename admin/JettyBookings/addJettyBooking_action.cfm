<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfset Variables.BookingDateTime = #CreateDateTime(DatePart('yyyy',Form.bookingDate), DatePart('m',Form.bookingDate), DatePart('d',Form.bookingDate), DatePart('h',Form.bookingTime), DatePart('n',Form.bookingTime), DatePart('s',Form.bookingTime))#>

<cftransaction>
	<cfquery name="insertbooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		INSERT INTO	Bookings
				(VNID,
				StartDate,
				EndDate, 
				BookingTime, 
				UID)
		VALUES	(#form.VNID#,
				#CreateODBCDate(Form.StartDate)#,
				#CreateODBCDate(Form.EndDate)#, 
				#CreateODBCDateTime(Variables.BookingDateTime)#, 
				#form.UID#)
	</cfquery>
	<cfquery name="getID" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT @@IDENTITY AS BRID
		FROM Bookings
	</cfquery>
	<!---cfquery name="getID" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	BRID
		FROM	Bookings
		WHERE	VNID = '#Form.VNID#' AND 
				StartDate = #CreateODBCDate(Form.StartDate)# AND 
				EndDate = #CreateODBCDate(Form.EndDate)# AND
				BookingTime = #CreateODBCDateTime(Variables.BookingDateTime)#
	</cfquery--->
</cftransaction>

<cfquery name="bookJetty" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	INSERT INTO Jetties(BRID, 
						<cfif Form.Jetty EQ "north">
						NorthJetty
						<cfelse>
						SouthJetty
						</cfif>, Status)
	VALUES		('#getID.BRID#', 1, '#Form.Status#')
</cfquery>

<cflock timeout=20 scope="Session" type="Exclusive">
	<cfset StructDelete(Session, "EGDuser")>
</cflock>

<cfquery name="getDetails" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Email, Vessels.Name AS VesselName, StartDate, EndDate, NorthJetty, SouthJetty
	FROM	Bookings INNER JOIN Users ON Bookings.UID = Users.UID 
			INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
			INNER JOIN Jetties ON Jetties.BRID = Bookings.BRID
	WHERE	Bookings.BRID = '#getID.BRID#'
</cfquery>
		
			
<cfoutput>
	<cfif getDetails.NorthJetty EQ 1>
		<cfset jetty = "North Landing Wharf">
	<cfelse>
		<cfset jetty = "South Jetty">
	</cfif>
	
	<cflock throwontimeout="no" scope="session" timeout="30" type="readonly">
		<cfquery name="getAdmin" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT	Email
			FROM	Users
			WHERE	UID = '#session.UID#'
		</cfquery>
	</cflock>
	
	<cfmail to="#getDetails.Email#" from="#Session.AdminEmail#" subject="New Booking - Nouvelle r&eacute;servation: #getDetails.VesselName#" type="html">
<p>#getDetails.Vesselname# has been booked on the #jetty# from #DateFormat(getDetails.StartDate, 'mmm d, yyyy')# to #DateFormat(getDetails.EndDate, 'mmm d, yyyy')#.</p>
<p>Esquimalt Graving Dock</p>
<br />
<cfif jetty eq "North Landing Wharf">
<p>Il y a une r&eacute;servation pour #getDetails.Vesselname# au quai de d&eacute;barquement nord du #DateFormat(getDetails.StartDate, 'mmm d, yyyy')# au #DateFormat(getDetails.EndDate, 'mmm d, yyyy')#.</p>
<cfelse>
<p>Il y a une r&eacute;servation pour #getDetails.Vesselname# &agrave; la jet&eacute;e sud du #DateFormat(getDetails.StartDate, 'mmm d, yyyy')# au #DateFormat(getDetails.EndDate, 'mmm d, yyyy')#.</p>
</cfif>
<p>Cale s&egrave;che d'Esquimalt</p>
	</cfmail>
</cfoutput>


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
<cfset Session.Success.Breadcrumb = "<a href='../admin/JettyBookings/jettyBookingManage.cfm?lang=#lang#'>Jetty Management</a> &gt; Create Booking">
<cfset Session.Success.Title = "Create New Jetty Booking">
<cfset Session.Success.Message = "A new booking for <b>#getDetails.vesselName#</b> from #LSDateFormat(CreateODBCDate(getDetails.startDate), 'mmm d, yyyy')# to #LSDateFormat(CreateODBCDate(getDetails.endDate), 'mmm d, yyyy')# has been successfully created.  Email notification of this new booking has been sent to the agent.">
<cfset Session.Success.Back = "Back to Jetty Bookings Management">
<cfset Session.Success.Link = "#RootDir#admin/JettyBookings/jettybookingManage.cfm?#urltoken#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">
