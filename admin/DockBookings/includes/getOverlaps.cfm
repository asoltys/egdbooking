<!-- Gets all Bookings with the same ship that have an overlap with the current booking --->

<cffunction access="public" name="getOverlaps_Conf" returntype="query">
<!--- 	Input: BRID of the selected booking for confirmation
		Returns: list of tentative BRIDs that overlap with this booking
--->
	<cfargument type="numeric" name="BRID" required="yes">

	<cfquery name="theBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	BRID, StartDate, EndDate, BookingTime, VNID
		FROM	Bookings
		WHERE	BRID = '#arguments.BRID#'
	</cfquery>

	<cfset Variables.BookingTime = theBooking.BookingTime>
	<cfset Variables.StartDate = CreateODBCDate(theBooking.StartDate)>
	<cfset Variables.EndDate = CreateODBCDate(theBooking.EndDate)>
	<cfset Variables.BRID = theBooking.BRID>
	<cfset Variables.VNID = theBooking.VNID>

	<cfquery name="checkDblBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT 	Bookings.VNID, Vessels.Name, Bookings.StartDate, Bookings.EndDate, Docks.Status, Bookings.BookingTime, Bookings.BRID
		FROM 	Bookings
					INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
					INNER JOIN Docks ON Bookings.BRID = Docks.BRID
		WHERE 	Bookings.VNID = '#Variables.VNID#'
		AND	Bookings.BRID <> '#arguments.BRID#'
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
