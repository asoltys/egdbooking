<cfif isDefined("form.UID")>
	<cfquery name="editUserCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	UserCompanies
		SET		Deleted = 1
		WHERE	UserCompanies.UID = <cfqueryparam value="#form.UID#" cfsqltype="cf_sql_integer" /> AND UserCompanies.CID = <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" />
	</cfquery>
	
	<cflocation addtoken="no" url="editUser.cfm?lang=#lang#&UID=#form.UID#">
	
<cfelseif isDefined("url.UID")>
	<cfquery name="removeUserCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	UserCompanies
		SET		Deleted = 1
		WHERE	UserCompanies.UID = <cfqueryparam value="#url.UID#" cfsqltype="cf_sql_integer" /> AND UserCompanies.CID = <cfqueryparam value="#url.CID#" cfsqltype="cf_sql_integer" />
	</cfquery>
	
	<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT FirstName, LastName
		FROM Users
		WHERE UID = <cfqueryparam value="#url.UID#" cfsqltype="cf_sql_integer" />
	</cfquery>
	
	<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Name AS CompanyName
		FROM	Companies
		WHERE	CID = <cfqueryparam value="#url.CID#" cfsqltype="cf_sql_integer" />
	</cfquery>
	
	<cfset Session.Success.Breadcrumb = "Delete User">
	<cfset Session.Success.Title = "Delete User">
	<cfset Session.Success.Message = "<strong>#getUser.FirstName# #getUser.LastName#</strong> has been removed from <strong>#getCompany.CompanyName#</strong>.">
	<cfset Session.Success.Back = "Back to Admin Functions Home">
	<cfset Session.Success.Link = "#RootDir#admin/menu.cfm?lang=#lang#">
	<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">
</cfif>
