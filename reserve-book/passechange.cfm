<cfif lang EQ "eng">
	<cfset language.unmatchedPasswordsError = "Passwords do not match, please retype.">
	<cfset language.pass1ShortError = "Your password must be at least 8 characters.">
<cfelse>
	<cfset language.unmatchedPasswordsError = "Les mots de passe ne concordent pas, veuillez les retaper.">
	<cfset language.pass1ShortError = "Votre mot de passe doit &ecirc;tre compos&eacute; d'au moins huit caract&egrave;res.">
</cfif>

<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif Len(trim(Form.Password1)) LT 8>
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.pass1ShortError#")#</cfoutput>
	<cfset Proceed_OK = "No">
<cfelseif Form.Password1 NEQ Form.Password2>
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.unmatchedPasswordsError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="#RootDir#reserve-book/profilmod-profileedit.cfm?lang=#lang#" addtoken="no">
</cfif>


<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfscript>
		jbClass = ArrayNew(1);
		jbClass[1] = "#FileDir#lib/jBCrypt-0.3";
    javaloader = createObject('component','egdbooking.lib.javaloader.JavaLoader');
		javaloader.init(jbClass);

		bcrypt = javaloader.create("BCrypt");
		hashed = bcrypt.hashpw(trim(form.password1), bcrypt.gensalt());
	</cfscript>

	<cfquery name="editPass" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE Users
		SET Password = <cfqueryparam value="#hashed#" cfsqltype="cf_sql_varchar" />
		WHERE UID = <cfqueryparam value="#session.UID#" cfsqltype="cf_sql_integer" />
	</cfquery>

</cflock>


<cfset Session.Eng.Success.Breadcrumb = "Edit Profile">
<cfset Session.Eng.Success.Title = "Edit Profile">
<cfset Session.Eng.Success.Message = "Your password for the Esquimalt Graving Dock Online Booking System has been changed to ""#form.password1#"".">
<cfset Session.Eng.Success.Back = "Back to Edit Profile">
<cfset Session.Eng.Success.Link = "#RootDir#reserve-book/profilmod-profileedit.cfm?lang=#lang#">
<cfset Session.Fra.Success.Breadcrumb = "Modifier le profil">
<cfset Session.Fra.Success.Title = "Modifier le profil">
<cfset Session.Fra.Success.Message = "Votre mot de passe pour le syst&egrave;me de r&eacute;servation en ligne de la cale s&egrave;che d'Esquimalt est ""#form.password1#"".">
<cfset Session.Fra.Success.Back = "Retour &agrave; modifier le profil">
<cfset Session.Fra.Success.Link = "#RootDir#reserve-book/profilmod-profileedit.cfm?lang=#lang#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">

