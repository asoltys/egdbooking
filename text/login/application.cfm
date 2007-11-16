<cfapplication name="egd" sessiontimeout=#CreateTimeSpan(0, 2, 0, 0)# sessionmanagement="yes" clientmanagement="yes">

<!--- Include the server-specific settings --->
<cfinclude template="../../server_settings.cfm">

<cfif ServerType EQ "Production" AND cgi.server_port NEQ 443 AND cgi.request_method EQ "get">
	<cflocation url="https://#cgi.server_name##cgi.script_name#?#cgi.query_string#" />
</cfif>

<cfquery name="getEmail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Email
	FROM	Configuration
</cfquery>


<!--- <cflock timeout="60" throwontimeout="no" type="exclusive" scope="session">

<cfif IsDefined("url.lang")>
	<cfset session.lang = url.lang>
	<cfoutput>Is Defined URL.lang</cfoutput>
<cfelse>
	<cfif IsDefined("Session.Lang")>
		<cfset url.lang = session.lang>
		<cfoutput>Is Defined session.lang</cfoutput>
	<cfelse>
		<cfset url.lang = "e">
		<cfset session.lang = "e">
		<cfoutput>Nothing defined</cfoutput>
	</cfif>
</cfif>

</cflock> --->

<cfif NOT IsDefined("URL.lang")>
	<cflocation url="#CGI.PATH_INFO#?lang=e" addtoken="no">
</cfif>
<cfif lcase(url.lang) NEQ "e" AND lcase(url.lang) NEQ "f">
	<cflocation url="#CGI.PATH_INFO#?lang=e" addtoken="no">
</cfif>

<cfinclude template="#RootDir#includes/generalLanguageVariables.cfm">