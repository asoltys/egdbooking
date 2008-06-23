<cfapplication name="egd" sessiontimeout=#CreateTimeSpan(0, 2, 0, 0)# sessionmanagement="yes" clientmanagement="yes">

<!--- Include the server-specific settings --->
<cfinclude template="../../server_settings.cfm">

<cfif ServerType EQ "Production" AND cgi.server_port NEQ 443 AND cgi.request_method EQ "get">
	<cflocation url="https://#cgi.server_name##cgi.script_name#?#cgi.query_string#" />
</cfif>

<!--- Set a global variable for the datasource --->
<CFSET Foobar = SetLocale("English (Canadian)")>

<cfquery name="getEmail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Email
	FROM	Configuration
</cfquery>


<CFIF NOT IsDefined("Session.AdminLoggedIn")>
	<CFLOCATION URL="#RootDir#text/ols-login/login.cfm" addtoken="no">
</CFIF>

<cfparam name="lang" default="eng">

<cfset Variables.MaxLength = 347.67>
<cfset Variables.MaxWidth = 45.40>

<!--- <cfparam name="url.StartDate" default="#PacificNow#">
<cfparam name="url.EndDate" default="#DateAdd('d', 30, PacificNow)#">
<cfparam name="url.showConfirmed" default="off">
<cfparam name="url.showPending" default="off"> --->
<!--- <cfparam name="url.userID" default="#session.userID#"> --->

<cfif NOT IsDefined("URL.lang")>
	<cfparam name="url.lang" default="eng">
</cfif>
<cfif lcase(url.lang) NEQ "eng">
	<cfparam name="url.lang" default="eng">
</cfif>

<cfinclude template="#RootDir#includes/generalLanguageVariables.cfm">