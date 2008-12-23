<div class="critical">
	<p><cfoutput>#Variables.waitListText#</cfoutput></p>
	<table class="basic smallFont">
		<tr>
			<th align="left" id="Booked" style="width:18%;">Booked</th>
			<th id="Agent" align="left">Agent</th>
			<th id="Company" align="left">Company</th>
			<th id="Vessel" align="left">Vessel</th>
			<th align="left" id="Dates" style="width:20%;">Docking Dates</th>
		</tr>
	<cfset count = 1>
	<cfloop condition="count LTE ArrayLen(conflictArray)">
		<cfquery name="getOtherBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT	Vessels.Name, Bookings.StartDate, Bookings.EndDate, Companies.Name AS CompanyName, 
						Users.FirstName + ' ' + Users.LastName AS Agent, Bookings.BookingTime
			FROM	Vessels, Bookings, Users, Companies
			WHERE	Bookings.VNID = Vessels.VNID 
			AND		Bookings.UID = Users.UID 
			AND		Vessels.CID = Companies.CID
			AND		Bookings.BRID = '#conflictArray[count]#'
			AND		Bookings.Deleted = 0
			AND		Vessels.Deleted = 0
		</cfquery>
		<CFIF count mod 2 eq 0>
			<CFSET rowClass = "highlight">
		<CFELSE>
			<CFSET rowClass = "">
		</CFIF>
		<cfoutput>
			<tr class="#rowClass#" valign="top">
				<td headers="Booked" valign="top">#DateFormat(getOtherBookings.BookingTime, 'mmm dd, yyyy')#<br />at #TimeFormat(getOtherBookings.BookingTime, 'H:mm')#</td>
				<td headers="Agent" valign="top">#trim(getOtherBookings.Agent)#</td>
				<td headers="Company" valign="top">#trim(getOtherBookings.CompanyName)#</td>
				<td headers="Vessel" valign="top">#trim(getOtherBookings.Name)#</td>
				<td headers="Dates" valign="top">#DateFormat(getOtherBookings.StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#DateFormat(getOtherBookings.StartDate, ", yyyy")#</CFIF> -<br />#DateFormat(getOtherBookings.EndDate, "mmm d, yyyy")#</td>
			</tr>
		</cfoutput>
		<cfset count = count + 1>
	</cfloop>
	</table>
</div>
