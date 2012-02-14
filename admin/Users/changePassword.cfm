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

<cfscript>
	jbClass = ArrayNew(1);
	jbClass[1] = "#FileDir#lib/jBCrypt-0.3";
	javaloader = createObject('component', 'javaloader.JavaLoader');
	javaloader.init(jbClass);

	bcrypt = javaloader.create("BCrypt");
	hashed = bcrypt.hashpw(trim(form.password1), bcrypt.gensalt());
</cfscript>

<cfif isdefined('form.UID')>
	<cfquery name="editPass" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE Users
		SET Password = <cfqueryparam value="#hashed#" cfsqltype="cf_sql_varchar" />
		WHERE UID = <cfqueryparam value="#form.UID#" cfsqltype="cf_sql_integer" />
	</cfquery>
</cfif>

<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT FirstName, LastName, email
	FROM Users
	WHERE UID = <cfqueryparam value="#form.UID#" cfsqltype="cf_sql_integer" />
</cfquery>


	
<cflock throwontimeout="no" scope="session" timeout="30" type="readonly">
	<cfquery name="getAdmin" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Email
		FROM	Users
		WHERE	UID = <cfqueryparam value="#session.UID#" cfsqltype="cf_sql_integer" />
	</cfquery>
</cflock>

<cflock scope="session" throwontimeout="no" timeout="30" type="READONLY">
	<cfif form.UID NEQ "#session.UID#">
		<cfoutput>
		<cfif ServerType EQ "Development">
<cfset getUser.Email = DevEmail />
</cfif>
			<cfmail to="#getUser.Email#" from="#AdministratorEmail#" subject="Password Changed - Mot de passe chang&eacute;" type="html">
				<p>#getUser.firstName# #getUser.lastName#,</p>
				<p>Your password for the Esquimalt Graving Dock Online Booking System has been changed to <strong>#trim(form.password1)#</strong>.</p>
				<p>Esquimalt Graving Dock</p>
				<br />
				<p>Votre mot de passe pour le syst&egrave;me de r&eacute;servation en ligne de la cale s&egrave;che d'Esquimalt a &eacute;t&eacute; chang&eacute; et est maintenant <strong>#trim(form.password1)#</strong>.</p>
				<p>Cale s&egrave;che d'Esquimalt</p>
			</cfmail>
		</cfoutput>
	</cfif>
</cflock>



<cfset Session.Success.Breadcrumb = "Change Password">
<cfset Session.Success.Title = "Change Password">
<cfset Session.Success.Message = "<strong>#getUser.FirstName# #getUser.LastName#</strong>'s password has been changed.">
<cfset Session.Success.Back = "Back to Edit User Profile">
<cfset Session.Success.Link = "#RootDir#admin/Users/editUser.cfm?lang=#lang#&UID=#form.UID#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">

