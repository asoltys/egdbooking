<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="addAdministrator.cfm?lang=#lang#" addtoken="no">
</cfif>

<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT *
		FROM Users
		WHERE UserID = #form.UserID#
	</cfquery>
</cflock>

<cfif isdefined('form.UserId')>

	<cfquery name="addAdministrator" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		INSERT INTO Administrators(UserID)
		VALUES ('#form.UserId#')
	</cfquery>
	
	<cfset Session.Success.Breadcrumb = "Add Administrator">
	<cfset Session.Success.Title = "Add Administrator">
	<cfset Session.Success.Message = "<b>#getUser.FirstName# #getUser.LastName#</b> is now an administrator.">
	<cfset Session.Success.Back = "Back to Add Administrator">
	<cfset Session.Success.Link = "#RootDir#text/admin/Users/addAdministrator.cfm?lang=#lang#">
	<cflocation addtoken="no" url="#RootDir#text/common/success.cfm?lang=#lang#">

</cfif>