<cfoutput>

<cfquery name="userVessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
  SELECT Vessels.VNID
  FROM Users 
    INNER JOIN UserCompanies ON Users.UID = UserCompanies.UID
    INNER JOIN Vessels ON UserCompanies.CID = Vessels.CID
  WHERE	Users.UID = <cfqueryparam value="#Session.UID#" cfsqltype="cf_sql_integer" /> 
    AND UserCompanies.Approved = 1 AND Users.Deleted = 0 AND UserCompanies.Deleted = 0
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

<cfset legend = arrayNew(1) />
<cfif find("jet", cgi.script_name) EQ 0>
  <cfset arrayAppend(legend, language.sec1) />
  <cfset arrayAppend(legend, language.sec2) />
  <cfset arrayAppend(legend, language.sec3) />
  <cfset arrayAppend(legend, language.tentbook) />
  <cfset arrayAppend(legend, language.pendbook) />
<cfelse>
  <cfset arrayAppend(legend, language.NorthLandingWharf) />
  <cfset arrayAppend(legend, language.SouthJetty) />
  <cfset arrayAppend(legend, language.PendBook) />
  <cfset arrayAppend(legend, language.TentBook) />
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
					<cfset taday = LSDateFormat(CreateDate(url['a-y'], url['m-m'], DaysofMonth[DateCounter]), "yyyy-MM-dd")>
          <strong>#DaysofMonth[DateCounter]#</strong>

					<cfquery name="bookings" dbtype="query">
						SELECT 	
              BRID, 
              VesselName, 
              VNID,
              Anonymous,
              Section1, 
              Section2, 
              Section3,
              Status
						FROM	GetEvents
						WHERE	<cfqueryparam value="#taday#" cfsqltype="cf_sql_date"> >= StartDate
							AND <cfqueryparam value="#taday#" cfsqltype="cf_sql_date"> <= EndDate
					</cfquery>

					<cfloop query="bookings">
            <cfif bookings.anonymous and not structKeyExists(session, 'isAdmin') and listContains(valueList(userVessels.VNID), bookings.VNID) eq 0>
              <cfset vessel_name = language.deepsea />
            <cfelse>
              <cfset vessel_name = bookings.vesselname />
            </cfif>

            <cfif listContains("P,PT,PT", bookings.status) gt 1>
              <cfset legendIndex = 5 />
              <cfset type = "pending" />
            <cfelseif bookings.status eq "T">
              <cfset legendIndex = 4 />
              <cfset type = "tentative" />
            <cfelseif bookings.section1>
              <cfset legendIndex = 1 />
              <cfset type = "sec1" />
            <cfelseif bookings.section2>
              <cfset legendIndex = 2 />
              <cfset type = "sec2" />
            <cfelseif bookings.section3>
              <cfset legendIndex = 3 />
              <cfset type = "sec3" />
            </cfif>

            <div class="#type#">
              <a class="#type#" href="detail.cfm?lang=#lang#&amp;date=#taday###res-book-#BRID#" title="#taday# - #language.detailsFor# #language.booking# ###BRID# - #vessel_name#" rel="nofollow">
                <span class="navaid">#taday# - #language.detailsFor# #language.booking# - ###BRID#</span> #vessel_name#
              </a>
              <a class="legend" href="##l#legendIndex#">
                <sup title="#legend[legendIndex]#">
                  <span class="navaid">#legendIndex# - #legend[legendIndex]#</span>#legendIndex#
                </sup>
              </a>
            </div>
          </cfloop>
        </cfif>
			</td>
		</cfloop>
	</tr>
	</cfloop>
</table>

<cfif find("jet", cgi.script_name) EQ 0>
  <cfinclude template="#RootDir#comm/includes/dock_key.cfm" />
<cfelse>
  <cfinclude template="#RootDir#comm/includes/jetty_key.cfm" />
</cfif>

</cfoutput>
