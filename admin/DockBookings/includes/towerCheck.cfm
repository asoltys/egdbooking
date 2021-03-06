<cfquery name="GetMinDate" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Min(StartDate) AS StartDate
	FROM	Bookings, Docks
	WHERE	Docks.Status = 'C'
	AND		Deleted = '0'
	AND		Docks.BRID = Bookings.BRID
	AND		(
				(	Bookings.StartDate <= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate )
			OR 	(	Bookings.StartDate <= <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate )
			OR	(	Bookings.StartDate >= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> >= Bookings.EndDate )
			)
</cfquery>
<cfquery name="GetMaxDate" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Max(EndDate) AS EndDate
	FROM	Bookings, Docks
	WHERE	Docks.Status = 'C'
	AND		Deleted = '0'
	AND		Docks.BRID = Bookings.BRID
	AND		(
				(	Bookings.StartDate <= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate )
			OR 	(	Bookings.StartDate <= <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate )
			OR	(	Bookings.StartDate >= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> >= Bookings.EndDate )
			)
</cfquery>

<!-- Gets all Bookings that would be affected by the requested booking --->
<cfquery name="GetBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Vessels.Length, Vessels.Width, Bookings.BRID, StartDate, EndDate
	FROM	Bookings, Vessels, Docks
	WHERE	Bookings.VNID = Vessels.VNID
	AND		Docks.BRID = Bookings.BRID
	AND		Docks.Status = 'C'
	AND		Vessels.Deleted = '0'
	AND		Bookings.Deleted = '0'
	AND		StartDate >= <cfqueryparam value="#getMinDate.StartDate#" cfsqltype="cf_sql_date" />
	AND		EndDate <=	<cfqueryparam value="#getMaxDate.EndDate#" cfsqltype="cf_sql_date" />
	ORDER BY StartDate
</cfquery>
<cfquery name="GetMaintenance" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Bookings.BRID, StartDate, EndDate, Section1, Section2, Section3
	FROM	Bookings,Docks
	WHERE	Docks.BRID = Bookings.BRID
	AND		Docks.Status = 'M'
	AND		Deleted = '0'	
	AND		(
				(	Bookings.StartDate <= <cfqueryparam value="#getMinDate.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#getMinDate.StartDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate )
			OR 	(	Bookings.StartDate <= <cfqueryparam value="#getMaxDate.EndDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#getMaxDate.EndDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate )
			OR	(	Bookings.StartDate >= <cfqueryparam value="#getMinDate.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#getMaxDate.EndDate#" cfsqltype="cf_sql_date" /> >= Bookings.EndDate )
			)
	ORDER BY StartDate
</cfquery>
<cfif not isDefined('Variables.Tower1')>
  <cfset Variables.BookingTower = createObject("component","tower").init()>
</cfif>

<cfloop query="GetBookings">
	<cfscript>
		BookingTower.addBlock(#GetBookings.BRID#, #GetBookings.StartDate#, #GetBookings.EndDate#, #GetBookings.Length#, #GetBookings.Width#);
	</cfscript>
</cfloop>
<cfscript>Variables.BlockStructure = BookingTower.addBlock(#theBooking.BRID#, #Variables.StartDate#, #Variables.EndDate#, #theBooking.Length#, #theBooking.Width#);</cfscript>
<cfloop query="GetMaintenance">
	<cfscript>
		BookingTower.addMaint(#GetMaintenance.BRID#, #GetMaintenance.StartDate#, #GetMaintenance.EndDate#, #GetMaintenance.Section1#, #GetMaintenance.Section2#, #GetMaintenance.Section3#);
	</cfscript>
</cfloop>
