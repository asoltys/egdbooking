<CFAPPLICATION NAME="EGD" Sessiontimeout=#CreateTimeSpan(0, 0, 60, 0)# SESSIONMANAGEMENT="Yes" clientmanagement="yes">

<!--- Include the server-specific settings --->
<cfinclude template="../../server_settings.cfm">

<cfif ServerType EQ "Production" AND cgi.server_port NEQ 443 AND cgi.request_method EQ "get">
<cflocation url="https://#cgi.server_name##cgi.script_name#?#cgi.query_string#" />
</cfif>

<!--- Set a global variable for the datasource --->
<cfif NOT IsDefined("URL.lang")>
	<cflocation url="#CGI.PATH_INFO#?lang=e" addtoken="no">
</cfif>
<cfif lcase(url.lang) NEQ "e" AND lcase(url.lang) NEQ "f">
	<cflocation url="#CGI.PATH_INFO#?lang=e" addtoken="no">
</cfif>

<!--- Set a global variable for the datasource --->
<cfif lcase(url.lang) EQ "e">
	<cfset Foobar = SetLocale("English (Canadian)")>
<cfelseif lcase(url.lang) EQ "f">
	<cfset Foobar = SetLocale("French (Canadian)")>
</cfif>

<cfparam name="lang" default="e">

<cfset Variables.MaxLength = 347.67>
<cfset Variables.MaxWidth = 45.40>

<cfparam name="url.StartDate" default="#now()#">
<cfparam name="url.EndDate" default="#DateAdd('d', 30, Now())#">
<cfparam name="url.showConfirmed" default="off">
<cfparam name="url.showPending" default="off">
<!--- <cfparam name="url.userID" default="#session.userID#"> --->