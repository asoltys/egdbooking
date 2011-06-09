<cfcomponent>
	<cfset this.name = "EGD Booking" />
	<cfset this.sessionmanagement = true />
	<cfset this.sessiontimeout = CreateTimeSpan(2,0,0,0) />
	<cfset this.clientmanagement = false />
	<cfset setEncoding("url","iso-8859-1") />

	<cffunction name="onRequest" access="public" returntype="void">
		<cfargument name="targetPage" type="String" required="true" />

		<cfinclude template="../server_settings.cfm" />
    <cfset this.mappings["/egdbooking"] = FileDir />

    <cfif ServerType EQ "Production" AND cgi.server_port NEQ 443 AND cgi.request_method EQ "get">
      <cflocation url="https://#cgi.server_name##cgi.script_name#?#cgi.query_string#" addtoken="no" />
    </cfif>

    <cfset SetLocale("English (Canadian)")>

    <cfquery name="getEmail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
      SELECT	Email
      FROM	Configuration
    </cfquery>

    <cfif not IsDefined("Session.AdminLoggedIn")>
      <cflocation url="#RootDir#ols-login/ols-login.cfm" addtoken="no">
    </cfif>

    <cfparam name="lang" default="eng">

    <cfset Variables.MaxLength = 347.67>
    <cfset Variables.MaxWidth = 45.40>

    <cfif NOT IsDefined("URL.lang")>
      <cfparam name="url.lang" default="eng">
    </cfif>
    <cfif lcase(url.lang) NEQ "eng">
      <cfparam name="url.lang" default="eng">
    </cfif>

    <cfinclude template="#RootDir#includes/generalLanguageVariables.cfm">

    <cfinclude template="#arguments.targetPage#" />
  </cffunction>
</cfcomponent>
