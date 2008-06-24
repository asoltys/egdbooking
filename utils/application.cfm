<CFAPPLICATION NAME="EGD" Sessiontimeout=#CreateTimeSpan(0, 0, 60, 0)# SESSIONMANAGEMENT="Yes" clientmanagement="yes">

<!--- Include the server-specific settings --->
<cfinclude template="../server_settings.cfm">

<cfif ServerType EQ "Production" AND cgi.server_port NEQ 443 AND cgi.request_method EQ "get">
<cflocation url="https://#cgi.server_name##cgi.script_name#?#cgi.query_string#" />
</cfif>

<!--- Set a global variable for the datasource --->
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

<cfparam name="lang" default="eng">

<cfset Variables.MaxLength = 347.67>
<cfset Variables.MaxWidth = 45.40>

<cfparam name="url.StartDate" default="#PacificNow#">
<cfparam name="url.EndDate" default="#DateAdd('d', 30, PacificNow)#">
<cfparam name="url.showConfirmed" default="off">
<cfparam name="url.showPending" default="off">
<!--- <cfparam name="url.userID" default="#session.userID#"> --->