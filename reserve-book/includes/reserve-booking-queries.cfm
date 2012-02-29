<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Name AS CompanyName
	FROM	Companies
	WHERE	CID = <cfqueryparam value="#variables.CID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfquery name="getVessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT VNID, Name
	FROM Vessels
	WHERE CID = <cfqueryparam value="#variables.CID#" cfsqltype="cf_sql_integer" />
	AND Deleted = 0
	ORDER BY Name
</cfquery>

<cfquery name="currentCompany" dbtype="query">
	SELECT	CompanyName
	FROM	getCompanies
	WHERE	 getCompanies.CID = <cfqueryparam value="#variables.CID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfquery name="unapprovedCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Name AS CompanyName
		FROM	UserCompanies INNER JOIN Companies ON UserCompanies.CID = Companies.CID
		WHERE	 UID = <cfqueryparam value="#session.UID#" cfsqltype="cf_sql_integer" /> 
    AND UserCompanies.Deleted = 0 
    AND (UserCompanies.Approved = 0 OR Companies.approved = 0)
		ORDER  BY Companies.Name
</cfquery>

<cfquery name="readonlycheck" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT ReadOnly
	FROM Users
	WHERE UID = <cfqueryparam value="#Session.UID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cffunction name="bookingsTable" output="true">
  <cfargument name="location" />
  <cfset var counter = 0 />
  <cfset var query = "" />

  <cfquery name="query" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
    SELECT  
      Bookings.BRID, 
      Bookings.EndHighlight.
      Bookings.StartDate,
      Bookings.EndDate,
      Vessels.Name
    FROM Bookings INNER JOIN
      Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
      Companies ON Vessels.CID = Companies.CID INNER JOIN
      <cfif location eq "drydock">
        Docks ON Bookings.BRID = Docks.BRID INNER JOIN
      <cfelse>
        Jetties ON Bookings.BRID = Jetties.BRID INNER JOIN
      </cfif>
      Users ON Bookings.UID = Users.UID
    WHERE Companies.CID = <cfqueryparam value="#variables.CID#" cfsqltype="cf_sql_integer" /> 
    <cfswitch expression="#location#">
      <cfcase value="drydock">
      </cfcase>
      <cfcase value="nlw">
        AND Jetties.NorthLandingWharf = '1' 
      </cfcase>
      <cfcase value="sj">
        AND Jetties.SouthJetty = '1' 
      </cfcase>
    </cfswitch>
    AND Bookings.Deleted = '0' 
    AND Vessels.Deleted = 0 
    AND endDate >= <cfqueryparam value="#CreateODBCDate(PacificNow)#" cfsqltype="cf_sql_date" /> 
  </cfquery>

  <cfquery name="counts" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
    SELECT 
      count(case when (Status = 'P' OR Status ='PT' OR Status = 'PC') then 1 end) as numPending,
      count(case when Status = 'T' then 1 end) as numTentative,
      count(case when Status = 'C' then 1 end) as numConfirmed,
      count(case when Status = 'PX' then 1 end) as numCancelling
    FROM Bookings INNER JOIN
      Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
      Companies ON Vessels.CID = Companies.CID INNER JOIN
      <cfif location eq "drydock">
        Docks ON Bookings.BRID = Docks.BRID INNER JOIN
      <cfelse>
        Jetties ON Bookings.BRID = Jetties.BRID INNER JOIN
      </cfif>
      Users ON Bookings.UID = Users.UID
    WHERE Companies.CID = <cfqueryparam value="#PacificNow#" cfsqltype="cf_sql_integer" /> 
    <cfswitch expression="#location#">
      <cfcase value="drydock">
      </cfcase>
      <cfcase value="nlw">
        AND Jetties.NorthLandingWharf = '1' 
      </cfcase>
      <cfcase value="sj">
        AND Jetties.SouthJetty = '1' 
      </cfcase>
    </cfswitch>
    AND Bookings.Deleted = '0' 
    AND Vessels.Deleted = 0 
    AND endDate >= <cfqueryparam value="#PacificNow#" cfsqltype="cf_sql_date" /> 
  </cfquery>

  <cfif query.recordCount GE 1>
    <table class="basic">
      <thead>
        <tr>
          <th scope="col">#language.booking#</th>
          <th scope="col">#language.startdate#</th>
          <th scope="col">#language.enddate#</th>
          <th scope="col">#language.status#</th>
        </tr>
      </thead>
      <tbody>
        <cfloop query="query">
          <tr>
            <td>
              <a href="#RootDir#comm/detail-res-book.cfm?lang=#lang#&amp;BRID=#BRID#" title="#language.booking# ###BRID#">
                <span class="navaid">#language.booking# ###BRID#:</span>
                <cfif #EndHighlight# GTE PacificNow>*</cfif>
                #Name#
              </a>
            </td>
            <td>#lsdateformat(CreateODBCDate(startDate), 'mmm d, yyyy')#</td>
            <td>#lsdateformat(endDate, 'mmm d, yyyy')#</td>
            <td>
              <cfif status EQ "P" or status EQ "PT"><span class="pending">#language.pending#</span>
              <cfelseif status EQ "C"><span class="confirmed">#language.confirmed#</span>
              <cfelseif status EQ "T"><span class="tentative">#language.tentative#</span>
              <cfelseif status EQ "PC"><span class="pending">#language.confirming#</span>
              <cfelseif status EQ "PX"><span class="cancelled">#language.pending_cancelling#</span>
              </cfif>
            </td>
          </tr>
          <cfset counter = counter + 1>
        </cfloop>
      </tbody>
    </table>
    <p class="total">
      Total:&nbsp;&nbsp;
      <span class="pending">#language.pending# - #counts.numPending#</span>
      <span class="tentative">#language.tentative# - #counts.numTentative#</span>
      <span class="confirmed">#language.confirmed# - #counts.numConfirmed#</span>
      <span class="cancelled">#language.pending_cancelling# - #counts.numCancelling#</span>
    </p>
  <cfelse>
    #language.None#.
  </cfif>
</cffunction>
