
<cfquery name="getUserCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	CompanyID
	FROM	UserCompanies
	WHERE	UserCompanies.UserID = #form.userID# AND UserCompanies.CompanyID = #form.companyID#
</cfquery>

<cfif getUserCompanies.recordCount EQ 1>
	<cfquery name="editUserCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	UserCompanies
		SET		Deleted = '0', Approved = '0'
		WHERE	UserCompanies.UserID = '#form.userID#' AND UserCompanies.CompanyID = '#form.companyID#' 
				AND UserCompanies.Deleted = '1'
	</cfquery>
<cfelse>
	<cfquery name="insertUserCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		INSERT INTO UserCompanies(UserID, CompanyID)
		VALUES		('#form.userID#', '#form.companyID#')
	</cfquery>
</cfif>


<cflocation addtoken="no" url="addUserCompanies.cfm?lang=#lang#&userID=#url.userID#">