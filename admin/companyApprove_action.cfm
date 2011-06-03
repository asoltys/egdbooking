<CFPROCESSINGDIRECTIVE pageencoding="utf-8" />

<cfquery name="ApproveCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE 	Companies
	SET		Approved = 1, 
			Abbreviation = <cfqueryparam value="#trim(form.abbrev)#" cfsqltype="cf_sql_varchar" />
	WHERE 	CID = <cfqueryparam value="#Form.CID#" cfsqltype="cf_sql_integer" />
</cfquery>


<!---<cfquery name="getCompanyAgents" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Email
	FROM	Users INNER JOIN UserCompanies ON Users.UID = UserCompanies.UID
	WHERE	CID = '#Form.CID#'
</cfquery>--->

<!---<cfquery name="companyName" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Name
	FROM	Companies
	WHERE	CID = '#Form.CID#'
</cfquery>

<cfoutput>
	<cfloop query="getCompanyAgents">
		<cfmail to="#Email#" from="#Variables.AdminEmail#" subject="Company Approved" type="html">
Your requested company, #companyName.Name#, has been approved.

Esquimalt Graving Dock


french, #companyName.Name#, french.

Cale s&egrave;che d'Esquimalt
		</cfmail>
	</cfloop>
</cfoutput>--->

<cflocation url="companyApprove.cfm?lang=#lang#" addtoken="no">
