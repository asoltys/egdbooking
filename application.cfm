<cfif ServerType EQ "Production" AND cgi.server_port NEQ 443 AND cgi.request_method EQ "get">
<cflocation url="https://#cgi.server_name##cgi.script_name#?#cgi.query_string#" />
</cfif>

<cfapplication name="EGD" Sessiontimeout=#CreateTimeSpan(0, 0, 0, 60)# Sessionmanagement="Yes">
   
<!--- Set a global variable for the datasource --->
<cfset Foobar = SetLocale("English (Canadian)")>

<!--- Include the server-specific settings --->
<cfinclude template="server_settings.cfm">

<cfparam name="lang" default="e">