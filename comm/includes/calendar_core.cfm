<cfoutput>

<cfquery name="vessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
  SELECT DISTINCT Vessels.VNID
  FROM Vessels 
    INNER JOIN UserCompanies ON UserCompanies.CID = Vessels.CID
    INNER JOIN Users ON UserCompanies.UID = <cfqueryparam value="#Session.UID#" cfsqltype="cf_sql_integer" /> 
    WHERE UserCompanies.Approved = 1 
    AND Users.Deleted = 0 
    AND UserCompanies.Deleted = 0
    AND Vessels.Deleted = 0
</cfquery>


<div class="selector">
  <form id="dateSelect" action="#CGI.script_name#?lang=#lang#" method="post">
    <fieldset>
      <legend>#language.dateSelect#</legend>
      <div>
        <label for="month">#language.month#</label>
        <select name="m-m" id="month">
          <cfloop index="i" from="1" to="12">
            <option value="#i#" <cfif i eq url['m-m']>selected="selected"</cfif>>#LSDateFormat(CreateDate(2005, i, 1), 'mmmm')#</option>
          </cfloop>
        </select>
      </div>
      <div>
        <label for="year">#language.year#</label>
        <select name="a-y" id="year">
          <CFLOOP index="i" from="-5" to="25">
            <cfset year = #LSDateFormat(DateAdd('yyyy', i, PacificNow), 'yyyy')# />
            <option <cfif year eq url['a-y']>selected="selected"</cfif>>#year#</option>
          </CFLOOP>
        </select>
      </div>
      <input type="submit" value="#language.submit#" />
    </fieldset>
  </form>
</div>

<h2>#LSDateFormat(CreateDate(url['a-y'], url['m-m'], 1), 'mmmm')# #url['a-y']#</h2>

<cfif find("jet", cgi.script_name) EQ 0>
  <cfinclude template="#RootDir#comm/includes/dock_key.cfm" />
<cfelse>
  <cfinclude template="#RootDir#comm/includes/jetty_key.cfm" />
</cfif>

<!--- Create an array for the days of the month --->
<cfset DaysofMonth = ArrayNew(1)>
<cfloop index="kounting" from="1" to="31" step="1">
	<cfif isDate(url['a-y'] & "/" & url['m-m'] & "/" & kounting) eq "yes">
		<cfset DaysofMonth[kounting] = #kounting#>
	</cfif>
</cfloop>
<cfset LastDayofMonth = ArrayMax(DaysofMonth)>

<!--- Find the day of the week for the first day of the month, used for finding events in the query --->
<cfset FirstDay = CreateDate(url['a-y'], url['m-m'], 1)>
<cfset LastDay = CreateDate(url['a-y'], url['m-m'], LastDayofMonth)>
<cfset CurDayofWeek = LSDateFormat(FirstDay, "dddd")>

<table class="basic calendar" id="calendar#url['m-m']#" 
summary="#language.calendar#">
	<!--- Output the days of the week at the top of the calendar --->
	<tr>
		<cfloop index="doh" from="1" to="#ArrayLen(DaysofWeek)#" step="1">
			<cfset dummydate = CreateDate(2005, 5, doh)>
			<th scope="row">#LSDateFormat(dummydate, 'dddd')#</th>
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
					<cfset taday = DateFormat(CreateDate(url['a-y'], url['m-m'], DaysofMonth[DateCounter]), "yyyy-MM-dd")>
          <strong>#DaysofMonth[DateCounter]#</strong>

					<cfquery name="bookings" dbtype="query">
						SELECT 	
              BRID, 
              VesselName, 
              VNID,
              Anonymous,
              Status,
              Section1,
              Section2,
              Section3
						FROM	GetEvents
						WHERE	<cfqueryparam value="#taday#" cfsqltype="cf_sql_date"> >= StartDate
							AND <cfqueryparam value="#taday#" cfsqltype="cf_sql_date"> <= EndDate
					</cfquery>

					<cfloop query="bookings">
            <cfif status neq 'C'>
              #booking(BRID, status, anonymous)#
            <cfelse>
              <cfif section1>#booking(BRID, status, anonymous, 1)#</cfif>
              <cfif section2>#booking(BRID, status, anonymous, 2)#</cfif>
              <cfif section3>#booking(BRID, status, anonymous, 3)#</cfif>
            </cfif>
          </cfloop>
        </cfif>
			</td>
		</cfloop>
	</tr>
	</cfloop>
</table>

</cfoutput>
