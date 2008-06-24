<cfif lang EQ "eng">
	<cfset language.subject = "EGD Password">
	<cfset language.email = "Your password for the Esquimalt Graving Dock Online Booking System is">
	<cfset language.address = "The email address">
	<cfset language.notReg = "is not registered">
<cfelse>
	<cfset language.subject = "Mot de passe pour la CSE">
	<cfset language.email = "Votre mot de passe pour le syst&egrave;me de r&eacute;servation en ligne de la cale s&egrave;che d'Esquimalt est">
	<cfset language.address = "L'adresse de courriel">
	<cfset language.notReg = "n'est pas enregistr&eacute;e">
</cfif>

<cfquery name="getPassword" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	password
	FROM	users
	WHERE	deleted = 0 AND email = '#trim(form.email)#'
</cfquery>


<cfif getPassword.recordCount EQ 0>
	<cfset Variables.Errors = ArrayNew(1)>
	
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.address#, #Form.Email#, #language.notReg#.")#</cfoutput>

	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="passeoubli-passforgot.cfm?lang=#lang#" addtoken="no">
</cfif>

<cfoutput>
<cfmail to="#form.email#" from="#variables.adminEmail#" subject="#language.subject#" type="html">
<p>#language.email# #getPassword.password#.</p>
<p>#language.esqGravingDock#</p>
</cfmail>
	
<cflocation url="passeenvoye-passsent.cfm?lang=#lang#" addtoken="no">
</cfoutput>
