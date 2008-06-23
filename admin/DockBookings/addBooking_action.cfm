<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">


<cfif IsDefined("Session.Return_Structure")>
	<cfoutput>#StructDelete(Session, "Return_Structure")#</cfoutput>
</cfif>

<cfset Variables.BookingDateTime = #CreateDateTime(DatePart('yyyy',Form.bookingDate), DatePart('m',Form.bookingDate), DatePart('d',Form.bookingDate), DatePart('h',Form.bookingTime), DatePart('n',Form.bookingTime), DatePart('s',Form.bookingTime))#>

<cfset Errors = ArrayNew(1)>
<cfset Success = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfoutput>#ArrayAppend(Success, "The booking has been successfully added.")#</cfoutput>

<!--- Validate the form data --->
<cfif (NOT isDefined("Form.Section1B")) AND (NOT isDefined("Form.Section2B")) AND (NOT isDefined("Form.Section3B")) AND (isDefined("Form.Confirmed"))>
	<cfoutput>#ArrayAppend(Errors, "You must choose at least one section of the dock for confirmed bookings.")#</cfoutput>
	no sections
	<cfset Proceed_OK = "No">
</cfif>


<cfif Proceed_OK EQ "No">
	<!--- Save the form data in a session structure so it can be sent back to the form page --->
	<cfset Session.Return_Structure.StartDate = Form.StartDate>
	<cfset Session.Return_Structure.EndDate = Form.EndDate>
	<cfset Session.Return_Structure.VesselID = Form.vesselID>
	<cfset Session.Return_Structure.UserID = Form.UserID>
	<cfif isDefined("Form.Section1B")><cfset Session.Return_Structure.Section1B = Form.Section1B></cfif>
	<cfif isDefined("Form.Section2B")><cfset Session.Return_Structure.Section2B = Form.Section2B></cfif>	
	<cfif isDefined("Form.Section3B")><cfset Session.Return_Structure.Section3B = Form.Section3B></cfif>
	<cfif isDefined("Form.Tentative")><cfset Session.Return_Structure.Tentative = Form.Tentative></cfif>
	<cfif isDefined("Form.Confirmed")><cfset Session.Return_Structure.Confirmed = Form.Confirmed></cfif>
		
	<cfset Session.Return_Structure.Errors = Errors>
	
 	<cflocation url="addBooking_process.cfm?startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" addtoken="no"> 
<cfelse>

<cftransaction>
	<cfquery name="insertbooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		INSERT INTO	Bookings
				(VesselID,
				StartDate,
				EndDate, 
				BookingTime, 
				UserID)
		VALUES	
				(#form.vesselID#,
				#CreateODBCDate(Form.StartDate)#,
				#CreateODBCDate(Form.EndDate)#, 
				#CreateODBCDateTime(Variables.BookingDateTime)#, 
				'#form.UserID#')
	</cfquery>
	<cfquery name="getID" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	@@IDENTITY AS BookingID
		FROM	Bookings
	</cfquery>
</cftransaction>

	<cfquery name="bookDock" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		INSERT INTO	Docks( 	<CFIF (isDefined("Form.Section1B") AND Form.Status EQ "C") OR (isDefined("Form.Section1A") AND Form.Section1A EQ 1)>
							Section1,
							</CFIF>
							<CFIF (isDefined("Form.Section2B") AND Form.Status EQ "C") OR (isDefined("Form.Section2A") AND Form.Section2A EQ 1)>
							Section2,
							</CFIF>
							<CFIF (isDefined("Form.Section3B") AND Form.Status EQ "C") OR (isDefined("Form.Section3A") AND Form.Section3A EQ 1)>
							Section3, 
							</CFIF>
							BookingID, Status)
		VALUES		(<CFIF (isDefined("Form.Section1B") AND Form.Status EQ "C") OR (isDefined("Form.Section1A") AND Form.Section1A EQ 1)>
					1,
					</CFIF>
					<CFIF (isDefined("Form.Section2B") AND Form.Status EQ "C") OR (isDefined("Form.Section2A") AND Form.Section2A EQ 1)>
					1,
					</CFIF>
					<CFIF (isDefined("Form.Section3B") AND Form.Status EQ "C") OR (isDefined("Form.Section3A") AND Form.Section3A EQ 1)>
					1,
					</CFIF>
					'#getID.BookingID#',
					'#Form.Status#'
					)
	</cfquery>

	<cfquery name="insertBlankForm" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		INSERT INTO TariffForms(BookingID)
		VALUES		('#getID.BookingID#')
	</cfquery>
	
	<cfquery name="getDetails" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Email, Vessels.Name AS VesselName, StartDate, EndDate
		FROM	Bookings INNER JOIN Users ON Bookings.UserID = Users.UserID 
				INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID
		WHERE	BookingID = '#getID.BookingID#'
	</cfquery>
		
	<cflock throwontimeout="no" scope="session" timeout="30" type="readonly">
		<cfquery name="getAdmin" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT	Email
			FROM	Users
			WHERE	UserID = '#session.userID#'
		</cfquery>
	</cflock>
		
	<cfoutput>
	<cfmail to="#getDetails.Email#" from="#Session.AdminEmail#" subject="New Booking - Nouvelle r&eacute;servation" type="html">
<p>#getDetails.Vesselname# has been booked in the dock from #DateFormat(getDetails.StartDate, 'mmm d, yyyy')# to #DateFormat(getDetails.EndDate, 'mmm d, yyyy')#.</p>
<p>Esquimalt Graving Dock</p>
<br>
<p>Il y a une r&eacute;servation pour #getDetails.Vesselname# dans la cale s&egrave;che du #DateFormat(getDetails.StartDate, 'mmm d, yyyy')# au #DateFormat(getDetails.EndDate, 'mmm d, yyyy')#.</p>
<p>Cale s&egrave;che d'Esquimalt</p>
	</cfmail>
	</cfoutput>
	
	<!--- URL tokens set-up.  Do not edit unless you KNOW something is wrong, otherwise I will beat you.
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
	<cfset Session.Success.Breadcrumb = "<A href='../admin/DockBookings/bookingmanage.cfm?lang=#lang#'>Drydock Management</A> &gt; Create Booking">
	<cfset Session.Success.Title = "Create New Dock Booking">
	<cfset Session.Success.Message = "A new booking for <b>#getDetails.vesselName#</b> from #LSDateFormat(CreateODBCDate(getDetails.startDate), 'mmm d, yyyy')# to #LSDateFormat(CreateODBCDate(getDetails.endDate), 'mmm d, yyyy')# has been successfully created.  Email notification of this new booking has been sent to the agent.">
	<cfset Session.Success.Back = "Back to Dock Bookings Management">
	<cfset Session.Success.Link = "#RootDir#text/admin/DockBookings/bookingmanage.cfm?#urltoken#">
	<cflocation addtoken="no" url="#RootDir#text/comm/success.cfm?lang=#lang#">

	<!---cflocation url="bookingmanage.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" addtoken="no"--->
</CFIF>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

