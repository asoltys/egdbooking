<cfapplication name="egd" sessiontimeout=#CreateTimeSpan(0, 2, 0, 0)# sessionmanagement="yes" clientmanagement="yes">
   
<!--- Include the server-specific settings --->
<cfinclude template="server_settings.cfm">

<cfif ServerType EQ "Production" AND cgi.server_port NEQ 443 AND cgi.request_method EQ "get">
	<cflocation url="https://#cgi.server_name##cgi.script_name#?#cgi.query_string#" />
</cfif>

<cfset SetLocale("English (Canadian)")>

<cfparam name="url.lang" default="eng">
<cfif findnocase("-e",CGI.PATH_INFO) or findnocase("-eng",CGI.PATH_INFO)>
	<cfset url.lang = "eng">
<cfelseif findnocase("-f",CGI.PATH_INFO) or findnocase("-fra",CGI.PATH_INFO)>
	<cfset url.lang = "fra">
</cfif>

<cfset SetLocale("English (Canadian)")>

<cfset Variables.MaxLength = 347.67>
<cfset Variables.MaxWidth = 45.40>

