<cfapplication name="egd" sessiontimeout=#CreateTimeSpan(0, 2, 0, 0)# sessionmanagement="yes" clientmanagement="yes">

<!--- Include the server-specific settings --->
<cfinclude template="../server_settings.cfm">

<cfif ServerType EQ "Production" AND cgi.server_port NEQ 443 AND cgi.request_method EQ "get">
	<cflocation url="https://#cgi.server_name##cgi.script_name#?#cgi.query_string#" />
</cfif>

<cfif NOT IsDefined("URL.lang")>
	<cflocation url="#CGI.PATH_INFO#?lang=eng" addtoken="no">
</cfif>
<cfif lcase(url.lang) NEQ "eng" AND lcase(url.lang) NEQ "fra">
	<cflocation url="#CGI.PATH_INFO#?lang=eng" addtoken="no">
</cfif>

<!--- Set a global variable for the datasource --->
<cfif lcase(url.lang) EQ "eng">
	<cfset Foobar = SetLocale("English (Canadian)")>
<cfelseif lcase(url.lang) EQ "fra">
	<cfset Foobar = SetLocale("French (Canadian)")>
</cfif>

<cfquery name="getEmail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Email
	FROM	Configuration
</cfquery>
<cfset variables.adminEmail = "">
<cfscript>
	adminEmail = ValueList(getEmail.Email);
</cfscript>

<cflock scope="session" throwontimeout="no" timeout="60" type="readonly">
<cfif IsDefined("Session.AdminLoggedIn")>
	<cflocation url="#RootDir#admin/menu.cfm?lang=#lang#" addtoken="no">
</cfif>

<cfif NOT IsDefined("Session.LoggedIn")>
	<cflocation url="#RootDir#ols-login/ols-login.cfm?lang=#lang#" addtoken="no">
</cfif>
</cflock>

<cfset Variables.MaxLength = 347.67>
<cfset Variables.MaxWidth = 45.40>

<cfinclude template="#RootDir#includes/generalLanguageVariables.cfm">
