<!-- Gets all Bookings that would be affected by the requested booking --->

<cffunction access="public" name="getConflicts_Conf" returntype="array">
<!--- 	Input: BRID of the selected booking for confirmation
		Returns: list of tentative BRIDs that conflict with this booking and have an earlier booking stamp
--->
	<cfargument type="numeric" name="BRID" required="yes">
	<cfquery name="theBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	BRID, StartDate, EndDate, BookingTime
		FROM	Bookings
		WHERE	BRID = '#arguments.BRID#'
	</cfquery>
	
	<cfif theBooking.recordCount GT 0>
		<cfset Variables.BookingTime = theBooking.BookingTime>
		<cfset Variables.StartDate = CreateODBCDate(theBooking.StartDate)>
		<cfset Variables.EndDate = CreateODBCDate(theBooking.EndDate)>
		<cfset Variables.BRID = theBooking.BRID>
	<cfelseif isDefined("form.startDate")>
		<cfset Variables.BookingTime = #CreateDateTime(DatePart('yyyy',form.BookingDate), DatePart('m',form.BookingDate), DatePart('d',form.BookingDate), DatePart('h',form.BookingTime), DatePart('n',form.BookingTime), DatePart('s',form.BookingTime))#>
		<cfset Variables.StartDate = CreateODBCDate(form.StartDate)>
		<cfset Variables.EndDate = CreateODBCDate(form.EndDate)>
		<cfset Variables.BRID = arguments.BRID>
	</cfif>

	<cfquery name="getConflicts" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Bookings.StartDate, Bookings.EndDate, Bookings.BRID, Vessels.Width, Vessels.Length
		FROM	Bookings, Vessels, Docks
		WHERE	Bookings.VNID = Vessels.VNID
		AND		Docks.BRID = Bookings.BRID
		AND		Docks.Status = 'T'
		AND		Bookings.Deleted = '0'
		AND		Vessels.Deleted = '0'
		AND		Bookings.BookingTime <= <cfqueryparam value="#CreateODBCDateTime(Variables.BookingTime)#" cfsqltype="cf_sql_timestamp">
		AND		Bookings.BRID != '#Variables.BRID#'
		AND		(
					(	Bookings.StartDate <= <cfqueryparam value="#CreateODBCDate(Variables.StartDate)#" cfsqltype="cf_sql_date"> AND <cfqueryparam value="#CreateODBCDate(Variables.StartDate)#" cfsqltype="cf_sql_date"> <= Bookings.EndDate )
				OR 	(	Bookings.StartDate <= <cfqueryparam value="#CreateODBCDate(Variables.EndDate)#" cfsqltype="cf_sql_date"> AND <cfqueryparam value="#CreateODBCDate(Variables.EndDate)#" cfsqltype="cf_sql_date"> <= Bookings.EndDate )
				OR	(	Bookings.StartDate >= <cfqueryparam value="#CreateODBCDate(Variables.StartDate)#" cfsqltype="cf_sql_date"> AND <cfqueryparam value="#CreateODBCDate(Variables.EndDate)#" cfsqltype="cf_sql_date"> >= Bookings.EndDate )
				)
	</cfquery>
	<cfset returnArray = ArrayNew(1)>

	<cfloop query="getConflicts">
		<cfset Variables.cStartDate = getConflicts.StartDate>
		<cfset Variables.cEndDate = getConflicts.EndDate>
		<cftransaction>
			<cfquery name="GetMinDate" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				SELECT	Min(StartDate) AS StartDate
				FROM	Bookings, Docks
				WHERE	(Docks.Status = 'C' OR Docks.Status = 'T')
				AND		Deleted = '0'
				AND		Docks.BRID = Bookings.BRID
				AND		(
							(	Bookings.StartDate <= <cfqueryparam value="#CreateODBCDate(Variables.cStartDate)#" cfsqltype="cf_sql_date"> AND <cfqueryparam value="#CreateODBCDate(Variables.cStartDate)#" cfsqltype="cf_sql_date"> <= Bookings.EndDate )
						OR 	(	Bookings.StartDate <= <cfqueryparam value="#CreateODBCDate(Variables.cEndDate)#" cfsqltype="cf_sql_date"> AND <cfqueryparam value="#CreateODBCDate(Variables.cEndDate)#" cfsqltype="cf_sql_date"> <= Bookings.EndDate )
						OR	(	Bookings.StartDate >= <cfqueryparam value="#CreateODBCDate(Variables.cStartDate)#" cfsqltype="cf_sql_date"> AND <cfqueryparam value="#CreateODBCDate(Variables.cEndDate)#" cfsqltype="cf_sql_date"> >= Bookings.EndDate )
						)
			</cfquery>
			<cfquery name="GetMaxDate" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				SELECT	Max(EndDate) AS EndDate
				FROM	Bookings, Docks
				WHERE	(Docks.Status = 'C' OR Docks.Status = 'T')
				AND		Deleted = '0'
				AND		Docks.BRID = Bookings.BRID
				AND		(
							(	Bookings.StartDate <= <cfqueryparam value="#CreateODBCDate(Variables.cStartDate)#" cfsqltype="cf_sql_date"> AND <cfqueryparam value="#CreateODBCDate(Variables.cStartDate)#" cfsqltype="cf_sql_date"> <= Bookings.EndDate )
						OR 	(	Bookings.StartDate <= <cfqueryparam value="#CreateODBCDate(Variables.cEndDate)#" cfsqltype="cf_sql_date"> AND <cfqueryparam value="#CreateODBCDate(Variables.cEndDate)#" cfsqltype="cf_sql_date"> <= Bookings.EndDate )
						OR	(	Bookings.StartDate >= <cfqueryparam value="#CreateODBCDate(Variables.cStartDate)#" cfsqltype="cf_sql_date"> AND <cfqueryparam value="#CreateODBCDate(Variables.cEndDate)#" cfsqltype="cf_sql_date"> >= Bookings.EndDate )
						)
			</cfquery>
			
			<cfquery name="GetBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				SELECT	Vessels.Length, Vessels.Width, Bookings.BRID, StartDate, EndDate
				FROM	Bookings, Vessels, Docks
				WHERE	Bookings.VNID = Vessels.VNID
				AND		Docks.BRID = Bookings.BRID
				AND		(Docks.Status = 'C' OR Docks.Status = 'T')
				AND		Vessels.Deleted = '0'
				AND		Bookings.Deleted = '0'
				AND		StartDate >= '#getMinDate.StartDate#'
				AND		EndDate <=	'#getMaxDate.EndDate#'
				ORDER BY StartDate
			</cfquery>
			<cfquery name="GetMaintenance" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				SELECT	Bookings.BRID, StartDate, EndDate, Section1, Section2, Section3
				FROM	Bookings,Docks
				WHERE	Docks.BRID = Bookings.BRID
				AND		Docks.Status = 'M'
				AND		Deleted = '0'	
				AND		(
							(	Bookings.StartDate <= '#getMinDate.StartDate#' AND '#getMinDate.StartDate#' <= Bookings.EndDate )
						OR 	(	Bookings.StartDate <= '#getMaxDate.EndDate#' AND '#getMaxDate.EndDate#' <= Bookings.EndDate )
						OR	(	Bookings.StartDate >= '#getMinDate.StartDate#' AND '#getMaxDate.EndDate#' >= Bookings.EndDate )
						)
				ORDER BY StartDate
			</cfquery>
		</cftransaction>			
		<cfif not isDefined('Variables.Tower1')>
		  <cfset Variables.BookingTower = createObject("component","tower").init()>
		</cfif>
		<cfloop query="GetBookings">
			<cfscript>
				BookingTower.addBlock(#GetBookings.BRID#, #GetBookings.StartDate#, #GetBookings.EndDate#, #GetBookings.Length#, #GetBookings.Width#);
			</cfscript>
		</cfloop>
		<cfscript>BookingTower.addBlock(#getConflicts.BRID#, #getConflicts.StartDate#, #getConflicts.EndDate#, #getConflicts.Length#, #getConflicts.Width#);</cfscript>
		<cfloop query="GetMaintenance">
			<cfscript>
				BookingTower.addMaint(#GetMaintenance.BRID#, #GetMaintenance.StartDate#, #GetMaintenance.EndDate#, #GetMaintenance.Section1#, #GetMaintenance.Section2#, #GetMaintenance.Section3#);
			</cfscript>
		</cfloop>
		<cfif NOT BookingTower.reorderTower()>
			<cfscript>ArrayAppend(returnArray,getConflicts.BRID);</cfscript>
		</cfif>
	</cfloop>
	<cfreturn returnArray>
</cffunction>

<cffunction access="public" name="getConflicts_remConf" returntype="array">
<!--- 	Input: BRID of the selected booking for confirmation
		Returns: list of tentative BRIDs that conflict with this booking
--->
	<cfargument type="numeric" name="BRID" required="yes">
	<cfquery name="theBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	BRID, StartDate, EndDate, BookingTime
		FROM	Bookings
		WHERE	BRID = '#arguments.BRID#'
	</cfquery>
	
	<cfset Variables.BookingTime = theBooking.BookingTime>
	<cfset Variables.StartDate = CreateODBCDate(theBooking.StartDate)>
	<cfset Variables.EndDate = CreateODBCDate(theBooking.EndDate)>
	<cfset Variables.BRID = theBooking.BRID>

	<cfquery name="getConflicts" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Bookings.StartDate, Bookings.EndDate, Bookings.BRID, Vessels.Width, Vessels.Length
		FROM	Bookings, Vessels, Docks
		WHERE	Bookings.VNID = Vessels.VNID
		AND		Docks.BRID = Bookings.BRID
		AND		Docks.Status = 'T'
		AND		Vessels.Deleted = '0'
		AND		Bookings.Deleted = '0'	
		AND		Bookings.BRID != '#Variables.BRID#'
		AND		(
					(	Bookings.StartDate <= #Variables.StartDate# AND #Variables.StartDate# <= Bookings.EndDate )
				OR 	(	Bookings.StartDate <= #Variables.EndDate# AND #Variables.EndDate# <= Bookings.EndDate )
				OR	(	Bookings.StartDate >= #Variables.StartDate# AND #Variables.EndDate# >= Bookings.EndDate )
				)
		ORDER BY BookingTime
	</cfquery>

	<cfset returnArray = ArrayNew(1)>

	<cfloop query="getConflicts">
		<cfset Variables.cStartDate = CreateODBCDate(getConflicts.StartDate)>
		<cfset Variables.cEndDate = CreateODBCDate(getConflicts.EndDate)>
		
		<cftransaction>
			<cfquery name="GetMinDate" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				SELECT	Min(StartDate) AS StartDate
				FROM	Bookings, Docks
				WHERE	Docks.Status = 'C'
				AND		Deleted = '0'
				AND		Docks.BRID = Bookings.BRID
				AND		(
							(	Bookings.StartDate <= #Variables.cStartDate# AND #Variables.cStartDate# <= Bookings.EndDate )
						OR 	(	Bookings.StartDate <= #Variables.cEndDate# AND #Variables.cEndDate# <= Bookings.EndDate )
						OR	(	Bookings.StartDate >= #Variables.cStartDate# AND #Variables.cEndDate# >= Bookings.EndDate )
						)
			</cfquery>
			<cfquery name="GetMaxDate" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				SELECT	Max(EndDate) AS EndDate
				FROM	Bookings, Docks
				WHERE	Docks.Status = 'C'
				AND		Deleted = '0'
				AND		Docks.BRID = Bookings.BRID
				AND		(
							(	Bookings.StartDate <= #Variables.cStartDate# AND #Variables.cStartDate# <= Bookings.EndDate )
						OR 	(	Bookings.StartDate <= #Variables.cEndDate# AND #Variables.cEndDate# <= Bookings.EndDate )
						OR	(	Bookings.StartDate >= #Variables.cStartDate# AND #Variables.cEndDate# >= Bookings.EndDate )
						)
			</cfquery>
			
			<cfquery name="GetBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				SELECT	Vessels.Length, Vessels.Width, Bookings.BRID, StartDate, EndDate
				FROM	Bookings, Vessels, Docks
				WHERE	Bookings.VNID = Vessels.VNID
				AND		Docks.BRID = Bookings.BRID
				AND		Docks.Status = 'C'
				AND		Vessels.Deleted = '0'	
				AND		Bookings.Deleted = '0'
				AND		StartDate >= '#getMinDate.StartDate#'
				AND		EndDate <=	'#getMaxDate.EndDate#'
				ORDER BY StartDate
			</cfquery>
			
			<cfquery name="GetMaintenance" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				SELECT	Bookings.BRID, StartDate, EndDate, Section1, Section2, Section3
				FROM	Bookings,Docks
				WHERE	Docks.BRID = Bookings.BRID
				AND		Docks.Status = 'M'
				AND		Deleted = '0'	
				AND		(
							(	Bookings.StartDate <= '#getMinDate.StartDate#' AND '#getMinDate.StartDate#' <= Bookings.EndDate )
						OR 	(	Bookings.StartDate <= '#getMaxDate.EndDate#' AND '#getMaxDate.EndDate#' <= Bookings.EndDate )
						OR	(	Bookings.StartDate >= '#getMinDate.StartDate#' AND '#getMaxDate.EndDate#' >= Bookings.EndDate )
						)
				ORDER BY StartDate
			</cfquery>
		</cftransaction>
		<cfif not isDefined('Variables.Tower1')>
		  <cfset Variables.BookingTower = createObject("component","tower").init()>
		</cfif>
		<cfloop query="GetBookings">
			<cfscript>
				BookingTower.addBlock(#GetBookings.BRID#, #GetBookings.StartDate#, #GetBookings.EndDate#, #GetBookings.Length#, #GetBookings.Width#);
			</cfscript>
		</cfloop>
		<cfscript>BookingTower.addBlock(#getConflicts.BRID#, #getConflicts.StartDate#, #getConflicts.EndDate#, #getConflicts.Length#, #getConflicts.Width#);</cfscript>
		<cfloop query="GetMaintenance">
			<cfscript>
				BookingTower.addMaint(#GetMaintenance.BRID#, #GetMaintenance.StartDate#, #GetMaintenance.EndDate#, #GetMaintenance.Section1#, #GetMaintenance.Section2#, #GetMaintenance.Section3#);
			</cfscript>
		</cfloop>
		<cfif NOT BookingTower.reorderTower() AND DateCompare(PacificNow, getConflicts.startDate, 'd') EQ -1>
			<cfscript>ArrayAppend(returnArray,getConflicts.BRID);</cfscript>
		</cfif>
	</cfloop>
	<cfreturn returnArray>
</cffunction>
