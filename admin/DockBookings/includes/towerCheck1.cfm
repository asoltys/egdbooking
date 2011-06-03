<!-- Gets all Bookings that would be affected by the requested booking --->
<cfquery name="GetBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Vessels.Length, Vessels.Width, Bookings.BRID, StartDate, EndDate
	FROM	Bookings, Vessels, Docks
	WHERE	Bookings.VNID = Vessels.VNID
	AND		Docks.BRID = Bookings.BRID
	AND		Docks.Confirmed = '1'	
	AND		StartDate >= (
						SELECT	Min(StartDate) AS StartDate
						FROM	Bookings, Docks
						WHERE	Docks.Confirmed = '1'
						AND		Docks.BRID = Bookings.BRID
						AND		(
									(	Bookings.StartDate <= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate )
								OR 	(	Bookings.StartDate <= #Variables.EndDate# AND #Variables.EndDate# <= Bookings.EndDate )
								OR	(	Bookings.StartDate >= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND #Variables.EndDate# >= Bookings.EndDate )
								)
						)

			AND

			EndDate <=	(
						SELECT	Max(EndDate) AS EndDate
						FROM	Bookings
						WHERE	Docks.Confirmed = '1'
						AND		Docks.BRID = Bookings.BRID
						AND		(
									(	Bookings.StartDate <= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate )
								OR 	(	Bookings.StartDate <= <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate )
								OR	(	Bookings.StartDate >= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> >= Bookings.EndDate )
								)
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
<cfscript>BookingTower.addBlock(-1, #Variables.StartDate#, #Variables.EndDate#, #getVessel.Length#, #getVessel.Width#);</cfscript>
