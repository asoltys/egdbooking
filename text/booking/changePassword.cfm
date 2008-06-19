<cfif lang EQ "eng">
	<cfset language.unmatchedPasswordsError = "Passwords do not match, please retype.">
	<cfset language.pass1ShortError = "Your password must be at least 6 characters.">
<cfelse>
	<cfset language.unmatchedPasswordsError = "Les mots de passe ne concordent pas, veuillez les retaper.">
	<cfset language.pass1ShortError = "Votre mot de passe doit &ecirc;tre compos&eacute; d'au moins six caract&egrave;res.">
</cfif>

<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif Len(trim(Form.Password1)) LT 6>
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.pass1ShortError#")#</cfoutput>
	<cfset Proceed_OK = "No">
<cfelseif Form.Password1 NEQ Form.Password2>
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.unmatchedPasswordsError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="editUser.cfm?lang=#lang#" addtoken="no">
</cfif>


<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">

	<cfquery name="editPass" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE Users
		SET Password = '#trim(form.password1)#'
		WHERE UserID = #session.userID#
	</cfquery>

</cflock>

<cfif lang EQ "eng">
	<cfset Session.Success.Breadcrumb = "Edit Profile">
	<cfset Session.Success.Title = "Edit Profile">
	<cfset Session.Success.Message = "Your password for the Esquimalt Graving Dock Online Booking System has been changed to ""#form.password1#"".">
	<cfset Session.Success.Back = "Back to Edit Profile">
<cfelse>
	<cfset Session.Success.Breadcrumb = "Modifier le profil">
	<cfset Session.Success.Title = "Modifier le profil">
	<cfset Session.Success.Message = "Votre mot de passe pour le syst&egrave;me de r&eacute;servation en ligne de la cale s&egrave;che d'Esquimalt est ""#form.password1#"".">
	<cfset Session.Success.Back = "Retour &agrave; modifier le profil">
</cfif>
<cfset Session.Success.Link = "#RootDir#text/booking/editUser.cfm?lang=#lang#">
<cflocation addtoken="no" url="#RootDir#text/common/success.cfm?lang=#lang#">

