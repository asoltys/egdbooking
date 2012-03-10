<cfquery name="companies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
  SELECT DISTINCT 
    Companies.CID, 
    Companies.Name
  FROM Companies
  INNER JOIN UserCompanies 
    ON UserCompanies.CID = Companies.CID 
    AND UserCompanies.UID = <cfqueryparam value="#Session.UID#" cfsqltype="cf_sql_integer" /> 
  WHERE UserCompanies.Approved = 1 
  AND UserCompanies.Deleted = 0
</cfquery>

<cfparam name="session.CID" default="#companies.CID#" />
<cfif structKeyExists(url, 'CID') and listContains(url.CID, companies.CID)>
  <cfset session['CID'] = url.CID />
</cfif>

<cfif companies.recordcount gt 1>
  <cfoutput>
    <cfset selected = "" />
    <form action="#RootDir#/reserve-booking/reserve-booking.cfm" method="get">
      <fieldset>
        <legend>#language.companySelection#</legend>
        <label for="CID">#language.selectCompany#</label>
        <select id="CID" name="CID">
          <cfloop query="companies">
            <cfif session['CID'] eq companies.CID>
              <cfset selected = "selected=""selected""" />
            </cfif>
            <option value="#companies.CID#" #selected#>#companies.name#</option>
          </cfloop>
        </select>
        <input type="submit" value="#language.go#" />
      </fieldset>
    </form>
  </cfoutput>
</cfif>
