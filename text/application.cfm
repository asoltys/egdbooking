<cfif ServerType EQ "Production" AND cgi.server_port NEQ 443 AND cgi.request_method EQ "get">
<cflocation url="https://#cgi.server_name##cgi.script_name#?#cgi.query_string#" />
</cfif>

<cfapplication name="egd" sessiontimeout=#CreateTimeSpan(0, 2, 0, 0)# sessionmanagement="yes" clientmanagement="yes">
 
<!--- Set a global variable for the datasource --->
<cfset Foobar = SetLocale("English (Canadian)")>

<!--- Include the server-specific settings --->
<cfinclude template="../server_settings.cfm">

<cfset Variables.MaxLength = 347.67>
<cfset Variables.MaxWidth = 45.40>

<cfparam name="url.lang" default="e">
<!--- <cfif (findnocase("-e",CGI.PATH_INFO )) OR (IsDefined("URL.Lang") AND LCASE(URL.Lang) EQ "e")>
 --->
<cfif findnocase("-e",CGI.PATH_INFO )>
	<cfset url.lang = "e">
<cfelseif findnocase("-f",CGI.PATH_INFO )>
	<cfset url.lang = "f">
</cfif>

<!--- <cflock timeout="60" throwontimeout="no" type="exclusive" scope="session">

<cfif IsDefined("url.lang")>
	<cfset session.lang = url.lang>
<cfelse>
	<cfif IsDefined("Session.Lang")>
		<cfset url.lang = session.lang>
	<cfelse>
		<cfset url.lang = "e">
		<cfset session.lang = "e">
	</cfif>
</cfif>

</cflock> --->

<!--- <cflock timeout="60" throwontimeout="no" type="exclusive" scope="session"> 
<cfparam name="url.lang" default="#session.lang#">
<cfif IsDefined("url.lang")>
	<cfif url.lang EQ "e">
		<cfset session.lang = "e">
	<cfelseif url.lang EQ "f">
		<cfset session.lang = "f">
	<cfelse>
		<cfset session.lang = "e">
		<cfset url.lang = "e">
	</cfif>
</cfif>
<cfif NOT IsDefined("Session.Lang")>
	<cfset session.lang = "e">
	<cfset url.lang = "e">
</cfif>
</cflock> --->