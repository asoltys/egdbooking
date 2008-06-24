<!-- Gets all Bookings that would be affected by the requested booking --->
<cfquery name="GetBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Vessels.Length, Vessels.Width, Bookings.BookingID, StartDate, EndDate
	FROM	Bookings, Vessels, Docks
	WHERE	Bookings.VesselID = Vessels.VesselID
	AND		Docks.BookingID = Bookings.BookingID
	AND		Docks.Confirmed = '1'	
	AND		StartDate >= (
						SELECT	Min(StartDate) AS StartDate
						FROM	Bookings, Docks
						WHERE	Docks.Confirmed = '1'
						AND		Docks.BookingID = Bookings.BookingID
						AND		(
									(	Bookings.StartDate <= #Variables.StartDate# AND #Variables.StartDate# <= Bookings.EndDate )
								OR 	(	Bookings.StartDate <= #Variables.EndDate# AND #Variables.EndDate# <= Bookings.EndDate )
								OR	(	Bookings.StartDate >= #Variables.StartDate# AND #Variables.EndDate# >= Bookings.EndDate )
								)
						)

			AND

			EndDate <=	(
						SELECT	Max(EndDate) AS EndDate
						FROM	Bookings
						WHERE	Docks.Confirmed = '1'
						AND		Docks.BookingID = Bookings.BookingID
						AND		(
									(	Bookings.StartDate <= #Variables.StartDate# AND #Variables.StartDate# <= Bookings.EndDate )
								OR 	(	Bookings.StartDate <= #Variables.EndDate# AND #Variables.EndDate# <= Bookings.EndDate )
								OR	(	Bookings.StartDate >= #Variables.StartDate# AND #Variables.EndDate# >= Bookings.EndDate )
								)
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
<cfscript>BookingTower.addBlock(-1, #Variables.StartDate#, #Variables.EndDate#, #getVessel.Length#, #getVessel.Width#);</cfscript>
