<!-- Gets all Bookings with the same ship that have an overlap with the current booking --->

<cffunction access="public" name="getOverlaps_Conf" returntype="query">
<!--- 	Input: BookingID of the selected booking for confirmation
		Returns: list of tentative BookingIDs that overlap with this booking
--->
	<cfargument type="numeric" name="BookingID" required="yes">

	<cfquery name="theBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	BookingID, StartDate, EndDate, BookingTime, VesselID
		FROM	Bookings
		WHERE	BookingID = '#arguments.BookingID#'
	</cfquery>

	<cfset Variables.BookingTime = theBooking.BookingTime>
	<cfset Variables.StartDate = CreateODBCDate(theBooking.StartDate)>
	<cfset Variables.EndDate = CreateODBCDate(theBooking.EndDate)>
	<cfset Variables.BookingID = theBooking.BookingID>
	<cfset Variables.VesselID = theBooking.VesselID>

	<cfquery name="checkDblBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT 	Bookings.VesselID, Vessels.Name, Bookings.StartDate, Bookings.EndDate, Docks.Status, Bookings.BookingTime, Bookings.BookingID
		FROM 	Bookings
					INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID
					INNER JOIN Docks ON Bookings.BookingID = Docks.BookingID
		WHERE 	Bookings.VesselID = '#Variables.VesselID#'
		AND	Bookings.BookingID <> '#arguments.BookingID#'
		AND 	
				(
					(	Bookings.StartDate <= #Variables.StartDate# AND #Variables.StartDate# < Bookings.EndDate AND #Variables.StartDate# <> #Variables.EndDate# AND Bookings.StartDate <> Bookings.EndDate)
				OR 	(	Bookings.StartDate < #Variables.EndDate# AND #Variables.EndDate# <= Bookings.EndDate AND #Variables.StartDate# <> #Variables.EndDate# AND Bookings.StartDate <> Bookings.EndDate)
				OR	(	Bookings.StartDate >= #Variables.StartDate# AND #Variables.EndDate# >= Bookings.EndDate AND #Variables.StartDate# <> #Variables.EndDate# AND Bookings.StartDate <> Bookings.EndDate)
				OR  (	(Bookings.StartDate = Bookings.EndDate OR #Variables.StartDate# = #Variables.EndDate#) AND Bookings.StartDate <> #Variables.StartDate# AND Bookings.EndDate <> #Variables.EndDate# AND 
							(	(	Bookings.StartDate <= #Variables.StartDate# AND #Variables.StartDate# < Bookings.EndDate)
								OR 	(	Bookings.StartDate < #Variables.EndDate# AND #Variables.EndDate# <= Bookings.EndDate)
								OR	(	Bookings.StartDate >= #Variables.StartDate# AND #Variables.EndDate# >= Bookings.EndDate)
							 )
						)
				)
		AND		Bookings.Deleted = 0
		ORDER BY StartDate, EndDate DESC
	</cfquery>
	<cfreturn checkDblBooking>
</cffunction>
