<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">


<cfif Len(trim(Form.Password1)) LT 6>
	<cfoutput>#ArrayAppend(Variables.Errors, "The password must be at least 6 characters.")#</cfoutput>
	<cfset Proceed_OK = "No">
<cfelseif Form.Password1 NEQ Form.Password2>
	<cfoutput>#ArrayAppend(Variables.Errors, "Passwords do not match, please retype.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="editUser.cfm?lang=#lang#" addtoken="no">
</cfif>

<cfif isdefined('form.userid')>
	<cfquery name="editPass" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE Users
		SET Password = '#trim(form.password1)#'
		WHERE UserID = #form.userID#
	</cfquery>
</cfif>

<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT FirstName, LastName, email, password
	FROM Users
	WHERE UserID = #form.UserID#
</cfquery>


	
<cflock throwontimeout="no" scope="session" timeout="30" type="readonly">
	<cfquery name="getAdmin" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Email
		FROM	Users
		WHERE	UserID = '#session.userID#'
	</cfquery>
</cflock>

<cflock scope="session" throwontimeout="no" timeout="30" type="READONLY">
	<cfif form.UserID NEQ "#session.userID#">
		<cfoutput>
			<cfmail to="#getUser.Email#" from="#Session.AdminEmail#" subject="Password Changed - Mot de passe chang&eacute;" type="html">
				<p>#getUser.firstName# #getUser.lastName#,</p>
				<p>Your password for the Esquimalt Graving Dock Online Booking System has been changed to <strong>#getUser.password#</strong>.</p>
				<p>Esquimalt Graving Dock</p>
				<br>
				<p>Votre mot de passe pour le syst&egrave;me de r&eacute;servation en ligne de la cale s&egrave;che d'Esquimalt a &eacute;t&eacute; chang&eacute; et est maintenant <strong>#getUser.password#</strong>.</p>
				<p>Cale s&egrave;che d'Esquimalt</p>
			</cfmail>
		</cfoutput>
	</cfif>
</cflock>



<cfset Session.Success.Breadcrumb = "Change Password">
<cfset Session.Success.Title = "Change Password">
<cfset Session.Success.Message = "<b>#getUser.FirstName# #getUser.LastName#</b>'s password has been changed.">
<cfset Session.Success.Back = "Back to Edit User Profile">
<cfset Session.Success.Link = "#RootDir#admin/Users/editUser.cfm?lang=#lang#&userID=#form.userID#">
<cflocation addtoken="no" url="#RootDir#comm/success.cfm?lang=#lang#">

