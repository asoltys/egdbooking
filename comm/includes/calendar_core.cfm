<cfoutput>

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

					<cfquery name="GetEventsonDay" dbtype="query">
						SELECT 	BRID, VesselName, VNID,
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

					<cfset sec1.num = 0>
					<cfset sec2.num = 0>
					<cfset sec3.num = 0>
					<cfset tent.num = 0>
					<cfset pend.num = 0>

					<cfset sec1.name = "">
					<cfset sec2.name = "">
					<cfset sec3.name = "">
					<cfset sec1.BRID = "">
					<cfset sec2.BRID = "">
					<cfset sec3.BRID = "">
					<cfset tent.name = "">
					<cfset pend.name = "">

					<cfset sec1.maint = false>
					<cfset sec2.maint = false>
					<cfset sec3.maint = false>

					<cfloop query="GetEventsonDay">
						<!---check if ship belongs to user's company--->
						<cflock timeout="20" throwontimeout="no" type="READONLY" scope="SESSION">
							<cfquery name="userVessel#VNID#" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
								SELECT	Vessels.VNID
								FROM	Users INNER JOIN UserCompanies ON Users.UID = UserCompanies.UID
										INNER JOIN Vessels ON UserCompanies.CID = Vessels.CID
								WHERE	Users.UID = <cfqueryparam value="#Session.UID#" cfsqltype="cf_sql_integer" /> AND VNID = <cfqueryparam value="#VNID#" cfsqltype="cf_sql_integer" />
									AND UserCompanies.Approved = 1 AND Users.Deleted = 0 AND UserCompanies.Deleted = 0
							</cfquery>
						</cflock>

						<cfset Variables.countQName = "userVessel" & #VNID# & ".recordCount">
						<cfset Variables.count = EVALUATE(countQName)>

						<cfscript>

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
										Evaluate(buzzard).BRID = BRID;
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

						</cfscript>
					</cfloop>

          <cfloop from="1" to="3" index="bloop">
            <cfset sec = "sec" & #bloop#>
            <cfset vessel_name = Evaluate(sec).name />
            <cfset BRID = Evaluate(sec).BRID />

            <cfif Evaluate(sec).maint eq true>
              <div class="maintenance">
                <a href="detail.cfm?lang=#lang#&amp;date=#taday###booking-#BRID#" class="maintenance" title="#taday# #language.maintenance#">
                  <span class="navaid" rel="nofollow">
                    #language.detailsFor# #language.maintenance# - #taday#
                  </span> 
                  #language.maintenance#
                </a>
              </div>
            <cfelseif vessel_name neq "">
            <div class="vessel #sec#">
              <a href="detail.cfm?lang=#lang#&amp;date=#taday###booking-#BRID#" class="confirmed" title="#taday# #vessel_name#" rel="nofollow">
                <span class="navaid">#language.detailsFor# #vessel_name# - #taday#</span>#vessel_name#
              </a>
              <a class="legend" href="###sec#">
                <sup title="#legend[bloop]#">
                  <span class="navaid">#bloop# - #legend[bloop]#</span>#bloop#
                </sup>
              </a>
            </div>
            </cfif>
          </cfloop>

          <cfif tent.num neq 0>
            <div>
              <a href="detail.cfm?lang=#lang#&amp;date=#taday#" class="tentative" title="#taday# #tent.name#" rel="nofollow">
                <span class="navaid">
                  #language.detailsFor# #tent.name# - #taday#
                </span> 
                #tent.name#
              </a>
              <a href="##tentative" class="legend tentative">
                <sup title="#legend[4]#">
                  <span class="navaid">#legend[4]#</span>4
                </sup>
              </a>
            </div>
          </cfif>

          <cfif pend.num neq 0>
            <div>
              <a href="detail.cfm?lang=#lang#&amp;date=#taday#" class="pending" title="#taday# #pend.name#" rel="nofollow">
                <span class="navaid">#language.detailsFor# #pend.name# - #taday#</span> #pend.name#
              </a>
              <a href="##pending" class="legend pending">
                <cfif sec3.name NEQ "">
                  <sup title="#legend[5]#">
                    <span class="navaid">#legend[5]#</span>5
                  </sup>
                <cfelse>
                  <sup title="#legend[3]#">
                    <span class="navaid">#legend[3]#</span>3
                  </sup>
                </cfif>
              </a>
            </div>
          </cfif>
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
