<!--- action page for deleting an administrator.--->

<cfif isDefined('form.userID')>
	<cfquery name="delAdministrator" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		DELETE FROM Administrators 
		WHERE UserID = #form.userID#
	</cfquery>
</cfif>

<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT FirstName, LastName
	FROM Users
	WHERE UserID = #form.UserID#
</cfquery>


<cfset Session.Success.Breadcrumb = "Remove Administrator">
<cfset Session.Success.Title = "Remove Administrator">
<cfset Session.Success.Message = "<b>#getUser.FirstName# #getUser.LastName#</b> is no longer an administrator.">
<cfset Session.Success.Back = "Back to Remove Administrator">
<cfset Session.Success.Link = "#RootDir#admin/Users/delAdministrator.cfm?lang=#lang#">
<cflocation addtoken="no" url="#RootDir#comm/success.cfm?lang=#lang#">