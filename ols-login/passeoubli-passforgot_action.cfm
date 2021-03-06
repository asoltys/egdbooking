<cfif lang EQ "eng">
	<cfset language.subject = "EGD Password">
	<cfset language.email = "Your password for the Esquimalt Graving Dock Online Booking System is">
	<cfset language.address = "The email address">
	<cfset language.notReg = "is not registered">
	<cfset language.email2 = "Please enter your login information.">
<cfelse>
	<cfset language.subject = "Mot de passe pour la CSE">
	<cfset language.email = "Votre mot de passe pour le syst&egrave;me de r&eacute;servation en ligne de la cale s&egrave;che d'Esquimalt est">
	<cfset language.address = "L'adresse de courriel">
	<cfset language.notReg = "n'est pas enregistr&eacute;e">
	<cfset language.email2 = "Veuillez entrer les renseignements dont vous avez besoin pour ouvrir une session.">
</cfif>

<cfquery name="getPassword" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	password
	FROM	users
	WHERE	deleted = 0 AND email = <cfqueryparam value="#trim(form.email)#" cfsqltype="cf_sql_varchar" />
</cfquery>

<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif trim(form.email) EQ "">
	<cfset session['errors']['email'] = language.email2 />
	<cfset Proceed_OK = "No">
</cfif>
<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="passeoubli-passforgot.cfm?lang=#lang#" addtoken="no">
</cfif>

<cfif getPassword.recordCount EQ 0>
	<cflocation url="passeenvoye-passsent.cfm?lang=#lang#" addtoken="no">
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.address#, #Form.Email#, #language.notReg#.")#</cfoutput>
</cfif>
	




<!--- Generate random password --->
<cfset chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghiklmnopqrstuvwxyz" />
<cfset strLength = 8 />
<cfset randout = "" />
<cfloop from="1" to="#strLength#" index="i">
	<cfset rnum = ceiling(rand() * len(chars)) / >
	<cfif rnum EQ 0 ><cfset rnum = 1 / ></cfif>
	<cfset randout = randout & mid(chars, rnum, 1) / >
</cfloop> 

<cfscript>
	jbClass = ArrayNew(1);
	jbClass[1] = "#FileDir#lib/jBCrypt-0.3";
  javaloader = createObject('component','lib.javaloader.JavaLoader');
	javaloader.init(jbClass);

	bcrypt = javaloader.create("BCrypt");
	hashed = bcrypt.hashpw(randout, bcrypt.gensalt());
</cfscript>

<cfquery name="newPassword" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE	users
	SET password = <cfqueryparam value="#hashed#" cfsqltype="cf_sql_varchar" />
	WHERE	deleted = 0 AND email = <cfqueryparam value="#trim(form.email)#" cfsqltype="cf_sql_varchar" />
</cfquery>

<cfoutput>
<cfif ServerType EQ "Development">
<cfset form.email = DevEmail />
</cfif>
<cfmail to="#form.email#" from="#variables.adminEmail#" subject="#language.subject#" type="html" username="#mailuser#" password="#mailpassword#">
<p>#language.email# #randout#.</p>
<p>#language.esqGravingDock#</p>
</cfmail>
	
<cflocation url="passeenvoye-passsent.cfm?lang=#lang#" addtoken="no">
</cfoutput>
