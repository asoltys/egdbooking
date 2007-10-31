



	

<h2><cfoutput>#MonthAsString(url.month)# #url.year#</cfoutput></h2>

<!--- Create an array for the days of the month --->
<cfset DaysofMonth = ArrayNew(1)>
<cfloop index="kounting" from="1" to="31" step="1">
	<cfif isDate(url.year & "/" & url.month & "/" & kounting) is "yes">
		<cfset DaysofMonth[kounting] = #kounting#>
	</cfif>
</cfloop>
<cfset LastDayofMonth = ArrayMax(DaysofMonth)>

<!--- Find the day of the week for the first day of the month, used for finding events in the query --->
<cfset FirstDay = url.year & "/" & url.month & "/" & 01>
<cfset LastDay = url.year & "/" & url.month & "/" & ArrayLen(DaysofMonth)>
<cfset taday = #DayofWeek(FirstDay)#>
<!--- <cfset CurDayofWeek = #DayofWeekAsString(taday)#> --->
<cfset CurDayofWeek = DateFormat(FirstDay,"dddd")>

<table class="calendar" id="calendar" CELLSPACING="0" WIDTH="100%">
<!--- Output the days of the week at the top of the calendar --->
<tr>
	<cfloop index="kounter" from="1" to="#ArrayLen(DaysofWeek)#" step="1">
	<cfoutput>
	<th class="calendar">#Left(DaysofWeek[kounter],3)#</th>
	</cfoutput>
	</cfloop>
</tr>

<!--- Output all the weeks in the calendar --->
<cfset DateCounter = 0>
<cfset WeekCounter = 0>
<cfset FirstDay = "No">
<cfloop condition="Variables.DateCounter LT ArrayLen(DaysofMonth)">
<tr class="fixedheight">
	<cfset WeekCounter = WeekCounter + 1>
	<cfloop index="kounter" from="1" to="#ArrayLen(DaysofWeek)#" step="1">
	
	<cfif WeekCounter EQ 1>
		<cfif Variables.CurDayofWeek IS DaysofWeek[kounter]>
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
		<td class="calendar">
			<cfif not (Variables.DateCounter IS 0) AND NOT (Variables.DateCounter GT Variables.LastDayofMonth)>
				<cfset taday = "#url.year#" & "/" & "#url.month#" & "/" & "#DaysofMonth[DateCounter]#">
				<cfoutput><a href="javascript:window.location.href='getdetail.cfm?lang=#lang#&date=#taday#';"><b>#DaysofMonth[DateCounter]#</b></a></cfoutput>
				<!---cfset CurrentDate = #CreateDate(url.year, url.month, DaysofMonth[DateCounter])#--->
				
				<cfquery name="GetEventsonDay" dbtype="query">
					SELECT 	VesselName,
							Anonymous,
							Section1, Section2, Section3,
							Status
					FROM	GetEvents
					WHERE	<cfqueryparam value="#taday#" cfsqltype="cf_sql_date"> >= StartDate
						AND <cfqueryparam value="#taday#" cfsqltype="cf_sql_date"> <= EndDate
						<!---#CurrentDate# BETWEEN StartDate AND EndDate--->
						<!---#CurrentDate# >= StartDate
						AND	#CurrentDate# <= EndDate--->
						<!---#DateCompare(CurrentDate, StartDate)# >= 0
						AND	#DateCompare(CurrentDate, EndDate)# <= 0--->
				</cfquery>
				
				<!--- Doing the craaaazeh query math.  Need to combine records and count them all!
					Using Left and my magicnumber to make it all pretty, too.
					Dance wit me!
					Lois Chan, May 2005 --->
				
				<CFSET maintenance = "Maintenace Block">
				
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
					<CFSCRIPT>
					
					if (Status eq 'm') {  // maintenance
						if (Section1) {
							sec1.maint = true;
							sec1.name = "";
						}
						if (Section2) {
							sec2.maint = true;
							sec2.name = "";
						}
						if (Section3) {
							sec3.maint = true;
							sec3.name = "";
						}
					} else if (Status eq 'c') {
						if (Section1 AND (sec1.maint eq false)) {
							sec1.num = sec1.num + 1;
							if (sec1.num eq 1) {
								sec1.name = Left(VesselName, magicnum);
							} else {
								sec1.name = Left(sec1.num & " bookings", magicnum);
							}
						}
						if (Section2 AND (sec2.maint eq false)) {
							sec2.num = sec2.num + 1;
							if (sec2.num eq 1) {
								sec2.name = Left(VesselName, magicnum);
							} else {
								sec2.name = Left(sec2.num & " bookings", magicnum);
							}
						}
						if (Section3 AND (sec3.maint eq false)) {
							sec3.num = sec3.num + 1;
							if (sec3.num eq 1) {
								sec3.name = Left(VesselName, magicnum);
							} else {
								sec3.name = Left(sec3.num & " bookings", magicnum);
							}
						}
					} else if (Status eq 't') {
						tent.num = tent.num + 1;
						if (tent.num eq 1) {
							if (Anonymous) {
								tent.name = Left("Deapsea Vessel", magicnum);
							} else {
								tent.name = Left(VesselName, magicnum);
							}
						} else {
							tent.name = Left(tent.num & " tentative bookings", magicnum);
						}
					} else if (Status eq 'p') {  // pending
						pend.num = pend.num + 1;
						if (pend.num eq 1) {
							pend.name = Left("pending booking", magicnum);
						} else {
							pend.name = Left(pend.num & " pending bookings", magicnum);
						}
					} else {  // unrecognised character
						;
					}

					</CFSCRIPT>
				</cfoutput>

				<cfoutput>
					<br><center>
					<table WIDTH="100%" CELLPADDING="0" STYLE="font-size: 8pt; ">
						<tr>
							<cfif sec1.maint eq true>
								<td class="maintenance"><a href="getdetail.cfm?lang=#lang#&date=#taday#" class="maintenance	">#Left(maintenance, magicnum)#...</a></td>
							<cfelseif sec1.name neq "">
								<td class="sec1"><a href="getdetail.cfm?lang=#lang#&date=#taday#" class="confirmed">#sec1.name#...</a></td>
							<cfelse>
								<td>&nbsp;</td>
							</cfif>
						</tr>
						<tr>
							<cfif sec2.maint eq true>
								<td class="maintenance"><a href="getdetail.cfm?lang=#lang#&date=#taday#" class="maintenance	">#Left(maintenance, magicnum)#...</a></td>
							<cfelseif sec2.name neq "">
								<td class="sec2"><a href="getdetail.cfm?lang=#lang#&date=#taday#" class="confirmed">#sec2.name#...</a></td>
							<cfelse>
								<td>&nbsp;</td>
							</cfif>
						</tr>
						<tr>
							<cfif sec3.maint eq true>
								<td class="maintenance"><a href="getdetail.cfm?lang=#lang#&date=#taday#" class="maintenance	">#Left(maintenance, magicnum)#...</a></td>
							<cfelseif sec3.name neq "">
								<td class="sec3"><a href="getdetail.cfm?lang=#lang#&date=#taday#" class="confirmed">#sec3.name#...</a></td>
							<cfelse>
								<td>&nbsp;</td>
							</cfif>
						</tr>
						<tr>
							<cfif tent.num neq 0>
								<td><a href="getdetail.cfm?lang=#lang#&date=#taday#" class="tentative">#tent.name#...</a></td>
							<cfelse>
								<td>&nbsp;</td>
							</cfif>
						</tr>
						<tr>
							<cfif pend.num neq 0>
								<td><a href="getdetail.cfm?lang=#lang#&date=#taday#" class="pending">#pend.name#...</a></td>
							<cfelse>
								<td>&nbsp;</td>
							</cfif>
						</tr>
					</table>

				</cfoutput>
			<cfelse>
				<table WIDTH="100%">
					<tr><td class="noborder">&nbsp;</td></tr>
					<tr><td class="noborder">&nbsp;</td></tr>
					<tr><td class="noborder">&nbsp;</td></tr>
				</table>
			</cfif>
		</td>
	</cfloop>
</tr>
</cfloop>
</table>