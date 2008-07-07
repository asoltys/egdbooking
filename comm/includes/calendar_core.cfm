<h2><cfoutput>#LSDateFormat(CreateDate(url.year, url.month, 1), 'mmmm')# #url.year#</cfoutput></h2>

<!--- Create an array for the days of the month --->
<cfset DaysofMonth = ArrayNew(1)>
<cfloop index="kounting" from="1" to="31" step="1">
	<cfif isDate(url.year & "/" & url.month & "/" & kounting) eq "yes">
		<cfset DaysofMonth[kounting] = #kounting#>
	</cfif>
</cfloop>
<cfset LastDayofMonth = ArrayMax(DaysofMonth)>

<!--- Find the day of the week for the first day of the month, used for finding events in the query --->
<cfset FirstDay = CreateDate(url.year, url.month, 1)>
<cfset LastDay = CreateDate(url.year, url.month, LastDayofMonth)>
<cfset CurDayofWeek = LSDateFormat(FirstDay, "dddd")>

<table class="calendar" id="calendar<cfoutput>#url.month#</cfoutput>" CELLSPACING="0" WIDTH="100%">
	<!--- Output the days of the week at the top of the calendar --->
	<tr>
		<cfloop index="doh" from="1" to="#ArrayLen(DaysofWeek)#" step="1">
		<cfoutput>
			<!---th class="calendar">#Left(DaysofWeek[kounter],3)#</th--->
			<CFSET dummydate = CreateDate(2005, 5, doh)>
			<th>#LSDateFormat(dummydate, 'ddd')#</th>
		</cfoutput>
		</cfloop>
	</tr>
	
	<!--- Output all the weeks in the calendar --->
	<cfset DateCounter = 0>
	<cfset WeekCounter = 0>
	<cfset FirstDay = "No">
	<cfloop condition="Variables.DateCounter LT ArrayLen(DaysofMonth)">
	<tr class="week">
		<cfset WeekCounter = WeekCounter + 1>
		<cfloop index="kounter" from="1" to="#ArrayLen(DaysofWeek)#" step="1">
			<cfif WeekCounter EQ 1>
				<cfif Variables.CurDayofWeek EQ DaysofWeek[kounter]>
					<cfset DateCounter = DateCounter + 1>
					<cfset FirstDay = "Yes">
				<cfelse>
					<cfif FirstDay IS "Yes">
						<cfset DateCounter = DateCounter + 1>
					</cfif>
				</cfif>
			<cfelse>
				<cfset DateCounter = DateCounter + 1>
			</cfif>
			<td>
				<cfif not (Variables.DateCounter IS 0) AND NOT (Variables.DateCounter GT Variables.LastDayofMonth)>
					<cfset taday = "#url.month#" & "/" & "#DaysofMonth[DateCounter]#" & "/" & "#url.year#">
					<cfoutput><a href="javascript:self.location.href='detail.cfm?lang=#lang#&date=#taday#';" title="#language.detailsFor# #taday#"><b>#DaysofMonth[DateCounter]#</b></a></cfoutput>
					<!---cfset CurrentDate = #CreateDate(url.year, url.month, DaysofMonth[DateCounter])#--->
	
					<cfquery name="GetEventsonDay" dbtype="query">
						SELECT 	VesselName, VesselID,
								Anonymous,
								Section1, Section2, Section3,
								Status
						FROM	GetEvents
						WHERE	<cfqueryparam value="#taday#" cfsqltype="cf_sql_date"> >= StartDate
							AND <cfqueryparam value="#taday#" cfsqltype="cf_sql_date"> <= EndDate
					</cfquery>
	
					<!--- Doing the craaaazeh query math.  Need to combine records and count them all!
						Using Left and my magicnumber to make it all pretty, too.
						Dance wit me!
						Lois Chan, May 2005 --->
	
					<CFSET sec1.num = 0>
					<CFSET sec2.num = 0>
					<CFSET sec3.num = 0>
					<CFSET tent.num = 0>
					<CFSET pend.num = 0>
	
					<CFSET sec1.name = "">
					<CFSET sec2.name = "">
					<CFSET sec3.name = "">
					<CFSET tent.name = "">
					<CFSET pend.name = "">
	
					<CFSET sec1.maint = false>
					<CFSET sec2.maint = false>
					<CFSET sec3.maint = false>
	
					<cfoutput query="GetEventsonDay">
						<!---check if ship belongs to user's company--->
						<cflock timeout="20" throwontimeout="no" type="READONLY" scope="SESSION">
							<cfquery name="userVessel#vesselID#" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
								SELECT	Vessels.VesselID
								FROM	Users INNER JOIN UserCompanies ON Users.UserID = UserCompanies.UserID
										INNER JOIN Vessels ON UserCompanies.CompanyID = Vessels.CompanyID
								WHERE	Users.UserID = #Session.UserID# AND VesselID = #VesselID#
									AND UserCompanies.Approved = 1 AND Users.Deleted = 0 AND UserCompanies.Deleted = 0
							</cfquery>
						</cflock>
						
						<cfset Variables.countQName = "userVessel" & #vesselID# & ".recordCount">
						<cfset Variables.count = EVALUATE(countQName)>

						<CFSCRIPT>
	
						if (Status eq 'm') {  // maintenance
							for (frika = 1; frika LTE 3; frika = frika + 1) {
								if (Evaluate('Section' & frika)) {
									Evaluate('sec' & frika).maint = true;
									Evaluate('sec' & frika).name = "";
	}
							}
							
						} else if (Status eq 'c') {  // confirmed
							for (frika = 1; frika LTE 3; frika = frika + 1) {
								buzzard = 'sec' & frika;
								if (Evaluate('Section' & frika) AND (Evaluate(buzzard).maint eq false)) {
									Evaluate(buzzard).num = Evaluate(buzzard).num + 1;
									if (Evaluate(buzzard).num eq 1) {
										Evaluate(buzzard).name = VesselName;
	} else {
										Evaluate(buzzard).name = Evaluate(buzzard).num & " #language.bookings#";
	}
								}
							}
						} else if (Status eq 't') {
							tent.num = tent.num + 1;
							if (tent.num eq 1) {
								if (Anonymous AND (NOT IsDefined('session.adminLoggedIn')) AND Variables.count eq 0) {
									tent.name = "#language.deepsea#";
	} else {
									tent.name = VesselName;
	}
							} else {
								tent.name = tent.num & " #language.tentative#";
	}
						} else if (Status eq 'p') {  // pending
							pend.num = pend.num + 1;
							if (pend.num eq 1) {
								pend.name = "#language.pending#";
	} else {
								pend.name = pend.num & " #language.pending#";
	}
						} else {  // unrecognised character;
	}
	
						</CFSCRIPT>
					</cfoutput>
	
					<cfoutput>
						
						<CFLOOP from="1" to="3" index="bloop">
								
							<CFSET sec = "sec" & #bloop#>
							<CFIF Evaluate(sec).maint eq true>
								<div class="maintenance"><a href="detail.cfm?lang=#lang#&date=#taday#" class="maintenance" title="#language.maintenance#">#Left(language.maintenance, magicnum)#...</a></div>
							<CFELSEIF Evaluate(sec).name neq "">
								<div class="#sec#"><a href="detail.cfm?lang=#lang#&date=#taday#" class="confirmed" title="#Evaluate(sec).name#">#Left(Evaluate(sec).name, magicnum)#...</a></div>
							<CFELSE>
								<div>&nbsp;</div>
							</CFIF>
						</CFLOOP>
						<cfif tent.num neq 0>
							<div><a href="detail.cfm?lang=#lang#&date=#taday#" class="tentative" title="#tent.name#">#Left(tent.name, magicnum)#...</a></div>
						<cfelse>
							<div>&nbsp;</div>
						</cfif>
						<cfif pend.num neq 0>
							<div><a href="detail.cfm?lang=#lang#&date=#taday#" class="pending" title="#pend.name#">#Left(pend.name, magicnum)#...</a></div>
						<cfelse>
							<div>&nbsp;</div>
						</cfif>
					</cfoutput>
				<cfelse>
					&nbsp;
				</cfif>
			</td>
		</cfloop>
	</tr>
	</cfloop>
</table>
