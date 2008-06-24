<!--- Gets all Bookings that would be affected by the requested booking --->
<cffunction name="findSpace" access="public" returntype="boolean">
	<cfargument name="BookingID" type="numeric" required="yes">
	<cfargument name="startDate" type="date" required="yes">
	<cfargument name="endDate" type="date" required="yes">
	<cfargument name="Length" type="numeric" required="yes">
	<cfargument name="Width" type="numeric" required="yes">
	
	<cfset Variables.BookingID = Arguments.BookingID>
	<cfset Variables.startDate = Arguments.startDate>
	<cfset Variables.endDate = Arguments.endDate>
	<cfset Variables.Length = Arguments.Length>
	<cfset Variables.Width = Arguments.Width>
	
	<cfquery name="GetMinDate" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Min(StartDate) AS StartDate
		FROM	Bookings, Docks
		WHERE	Docks.Status = 'C'
		AND		Deleted = '0'
		AND		Docks.BookingID = Bookings.BookingID
		AND		(
					(	Bookings.StartDate <= #Variables.StartDate# AND #Variables.StartDate# <= Bookings.EndDate )
				OR 	(	Bookings.StartDate <= #Variables.EndDate# AND #Variables.EndDate# <= Bookings.EndDate )
				OR	(	Bookings.StartDate >= #Variables.StartDate# AND #Variables.EndDate# >= Bookings.EndDate )
				)
	</cfquery>
	<cfquery name="GetMaxDate" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Max(EndDate) AS EndDate
		FROM	Bookings, Docks
		WHERE	Docks.Status = 'C'
		AND		Deleted = '0'
		AND		Docks.BookingID = Bookings.BookingID
		AND		(
					(	Bookings.StartDate <= #Variables.StartDate# AND #Variables.StartDate# <= Bookings.EndDate )
				OR 	(	Bookings.StartDate <= #Variables.EndDate# AND #Variables.EndDate# <= Bookings.EndDate )
				OR	(	Bookings.StartDate >= #Variables.StartDate# AND #Variables.EndDate# >= Bookings.EndDate )
				)
	</cfquery>
	<cfquery name="GetBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Vessels.Length, Vessels.Width, Bookings.BookingID, StartDate, EndDate
		FROM	Bookings, Vessels, Docks
		WHERE	Bookings.VesselID = Vessels.VesselID
		AND		Docks.BookingID = Bookings.BookingID
		AND		Docks.Status = 'C'
		AND		Vessels.Deleted = '0'
		AND		Bookings.Deleted = '0'	
		AND		StartDate >= '#getMinDate.StartDate#'
		AND		EndDate <=	'#getMaxDate.EndDate#'
		ORDER BY StartDate
	</cfquery>
	<cfquery name="GetMaintenance" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Bookings.BookingID, StartDate, EndDate, Section1, Section2, Section3
		FROM	Bookings,Docks
		WHERE	Docks.BookingID = Bookings.BookingID
		AND		Docks.Status = 'M'
		AND		Deleted = '0'	
		AND		(
					(	Bookings.StartDate <= '#getMinDate.StartDate#' AND '#getMinDate.StartDate#' <= Bookings.EndDate )
				OR 	(	Bookings.StartDate <= '#getMaxDate.EndDate#' AND '#getMaxDate.EndDate#' <= Bookings.EndDate )
				OR	(	Bookings.StartDate >= '#getMinDate.StartDate#' AND '#getMaxDate.EndDate#' >= Bookings.EndDate )
				)
		ORDER BY StartDate
	</cfquery>
	<cfif not isDefined('Variables.Tower1')>
	  <cfset Variables.BookingTower = createObject("component","tower").init()>
	</cfif>
	
	<cfloop query="GetBookings">
		<cfscript>
			BookingTower.addBlock(#GetBookings.BookingID#, #GetBookings.StartDate#, #GetBookings.EndDate#, #GetBookings.Length#, #GetBookings.Width#);
		</cfscript>
	</cfloop>
	<cfscript>BookingTower.addBlock(#Variables.BookingID#, #Variables.StartDate#, #Variables.EndDate#, #Variables.Length#, #Variables.Width#);</cfscript>
	<cfloop query="GetMaintenance">
		<cfscript>
			BookingTower.addMaint(#GetMaintenance.BookingID#, #GetMaintenance.StartDate#, #GetMaintenance.EndDate#, #GetMaintenance.Section1#, #GetMaintenance.Section2#, #GetMaintenance.Section3#);
		</cfscript>
	</cfloop>
	<cfreturn BookingTower.reorderTower()>
</cffunction>
