<cfif isDefined("form.userID")>
	<cfquery name="editUserCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	UserCompanies
		SET		Deleted = 1
		WHERE	UserCompanies.UserID = #form.UserID# AND UserCompanies.CompanyID = #form.companyID#
	</cfquery>
	
	<cflocation addtoken="no" url="editUser.cfm?lang=#lang#&amp;userID=#form.userID#">
	
<cfelseif isDefined("url.userID")>
	<cfquery name="removeUserCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	UserCompanies
		SET		Deleted = 1
		WHERE	UserCompanies.UserID = #url.UserID# AND UserCompanies.CompanyID = #url.companyID#
	</cfquery>
	
	<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT FirstName, LastName
		FROM Users
		WHERE UserID = #url.UserID#
	</cfquery>
	
	<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Name AS CompanyName
		FROM	Companies
		WHERE	CompanyID = #url.CompanyID#
	</cfquery>
	
	<cfset Session.Success.Breadcrumb = "Delete User">
	<cfset Session.Success.Title = "Delete User">
	<cfset Session.Success.Message = "<strong>#getUser.FirstName# #getUser.LastName#</strong> has been removed from <strong>#getCompany.CompanyName#</strong>.">
	<cfset Session.Success.Back = "Back to Admin Functions Home">
	<cfset Session.Success.Link = "#RootDir#admin/menu.cfm?lang=#lang#">
	<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">
</cfif>
