<cfif isDefined('form.userID')>
	<cfquery name="delUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE Users
		SET Deleted = 1
		WHERE UserID = #form.userID#
	</cfquery>
	
	<cfquery name="delUserCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	UserCompanies
		SET		Deleted = 1
		WHERE	UserID = #form.userID#
	</cfquery>
</cfif>

<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT FirstName, LastName
	FROM Users
	WHERE UserID = #form.UserID#
</cfquery>


<cfset Session.Success.Breadcrumb = "Delete User">
<cfset Session.Success.Title = "Delete User">
<cfset Session.Success.Message = "<b>#getUser.FirstName# #getUser.LastName#</b> has been removed.">
<cfset Session.Success.Back = "Back to Admin Functions Home">
<cfset Session.Success.Link = "#RootDir#text/admin/menu.cfm?lang=#lang#">
<cflocation addtoken="no" url="#RootDir#text/comm/success.cfm?lang=#lang#">