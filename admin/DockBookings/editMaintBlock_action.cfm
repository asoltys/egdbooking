<cftransaction>
	<cfquery name="updatebooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	Bookings
		SET		StartDate = <cfqueryparam value="#CreateODBCDate(Form.StartDate)#" cfsqltype="cf_sql_date">,
				EndDate = <cfqueryparam value="#CreateODBCDate(Form.EndDate)#" cfsqltype="cf_sql_date">
		WHERE	Bookings.BRID = <cfqueryparam value="#Form.BRID#" cfsqltype="cf_sql_integer" />
	</cfquery>
	<cfquery name="updateDock" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	Docks
		SET		Section1 = <cfqueryparam value="#Form.Section1#" cfsqltype="cf_sql_bit" />,
				Section2 = <cfqueryparam value="#Form.Section2#" cfsqltype="cf_sql_bit" />,
				Section3 = <cfqueryparam value="#Form.Section3#" cfsqltype="cf_sql_bit" />
		WHERE	Docks.BRID = <cfqueryparam value="#Form.BRID#" cfsqltype="cf_sql_integer" />
	</cfquery>
</cftransaction>
	
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
<cfset Session.Success.Breadcrumb = "<a href='../admin/DockBookings/bookingManage.cfm?lang=#lang#'>Drydock Management</a> &gt; Edit Maintenance Block">
<cfset Session.Success.Title = "Edit Maintenance Block">
<cfset Session.Success.Message = "Maintenance block is now from #LSDateFormat(CreateODBCDate(form.startDate), 'mmm d, yyyy')# to #LSDateFormat(CreateODBCDate(form.endDate), 'mmm d, yyyy')#.">
<cfset Session.Success.Back = "Back to Dock Bookings Management">
<cfset Session.Success.Link = "#RootDir#admin/DockBookings/bookingManage.cfm?#urltoken###id#form.BRID#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">

<!---cflocation addtoken="no" url="Bookingmanage.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#"--->
