<CFPROCESSINGDIRECTIVE pageencoding="utf-8" />

<cfquery name="ApproveCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE 	Companies
	SET		Approved = 1, 
			Abbreviation = '#trim(form.abbrev)#'
	WHERE 	CompanyID = '#Form.CompanyID#'
</cfquery>


<!---<cfquery name="getCompanyAgents" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Email
	FROM	Users INNER JOIN UserCompanies ON Users.UserID = UserCompanies.UserID
	WHERE	CompanyID = '#Form.CompanyID#'
</cfquery>--->

<!---<cfquery name="companyName" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Name
	FROM	Companies
	WHERE	CompanyID = '#Form.CompanyID#'
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