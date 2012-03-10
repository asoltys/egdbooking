<cfquery name="unapprovedCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Name AS CompanyName
		FROM	UserCompanies INNER JOIN Companies ON UserCompanies.CID = Companies.CID
		WHERE	 UID = <cfqueryparam value="#session.UID#" cfsqltype="cf_sql_integer" /> 
    AND UserCompanies.Deleted = 0 
    AND (UserCompanies.Approved = 0 OR Companies.approved = 0)
		ORDER  BY Companies.Name
</cfquery>

<cfoutput>
  <cfif unapprovedCompany.RecordCount GTE 1>
    <h2>#language.awaitingApproval#</h2>
    <ul>
      <cfloop query="unapprovedCompany">
        <li>#CompanyName#</li>
      </cfloop>
    </ul>
  </cfif>
</cfoutput>
