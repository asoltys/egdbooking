<cfif isDefined('form.UID')>
	<cfquery name="delUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE Users
		SET Deleted = 1
		WHERE UID = #form.UID#
	</cfquery>
	
	<cfquery name="delUserCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	UserCompanies
		SET		Deleted = 1
		WHERE	UID = #form.UID#
	</cfquery>
</cfif>

<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT FirstName, LastName
	FROM Users
	WHERE UID = #form.UID#
</cfquery>


<cfset Session.Success.Breadcrumb = "Delete User">
<cfset Session.Success.Title = "Delete User">
<cfset Session.Success.Message = "<b>#getUser.FirstName# #getUser.LastName#</b> has been removed.">
<cfset Session.Success.Back = "Back to Admin Functions Home">
<cfset Session.Success.Link = "#RootDir#admin/menu.cfm?lang=#lang#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">
