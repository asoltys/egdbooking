<CFPROCESSINGDIRECTIVE pageencoding="utf-8" />

<cfquery name="ApproveCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE 	Companies
	SET		Approved = 1, 
			Abbreviation = <cfqueryparam value="#trim(form.abbrev)#" cfsqltype="cf_sql_varchar" />
	WHERE 	CID = <cfqueryparam value="#Form.CID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cflocation url="companyApprove.cfm?lang=#lang#" addtoken="no">
