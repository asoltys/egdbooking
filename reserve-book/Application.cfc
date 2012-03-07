<cfcomponent>
	<cfset this.name = "EGD Booking" />
	<cfset this.sessionmanagement = true />
	<cfset this.sessiontimeout = CreateTimeSpan(2,0,0,0) />
	<cfset this.clientmanagement = false />
	<cfset setEncoding("url","iso-8859-1") />

	<cffunction name="onRequest" access="public" returntype="void">
		<cfargument name="targetPage" type="String" required="true" />

		<cfinclude template="../server_settings.cfm" />
    <cfset this.mappings["/egdbooking"] = FileDir>

    <cfif ServerType EQ "Production" AND cgi.server_port NEQ 443 AND cgi.request_method EQ "get">
      <cflocation url="https://#cgi.server_name##cgi.script_name#?#cgi.query_string#" addtoken="no" />
    </cfif>

    <cfif not structKeyExists(url, 'lang')>
      <cfparam name="url.lang" default="eng">
      <cfif findnocase("-e",CGI.PATH_INFO) or findnocase("-eng",CGI.PATH_INFO)>
        <cfset url.lang = "eng">
      <cfelseif findnocase("-f",CGI.PATH_INFO) or findnocase("-fra",CGI.PATH_INFO)>
        <cfset url.lang = "fra">
      </cfif>
    </cfif>

    <cfif lcase(url.lang) EQ "eng">
      <cfset SetLocale("English (Canadian)")>
      <cfset request.datemask = "mmm d, yyyy" />
      <cfset request.longdatemask = "mmmm d, yyyy" />
    <cfelseif lcase(url.lang) EQ "fra">
      <cfset SetLocale("French (Canadian)")>
      <cfset request.datemask = "d mmmm yyyy" />
      <cfset request.longdatemask = "d mmmm yyyy" />
    </cfif>

   <cfset Variables.MaxLength = 347.67>
    <cfset Variables.MaxWidth = 45.40>

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

    <cfinclude template="#RootDir#includes/generalLanguageVariables.cfm">
    <cfinclude template="#RootDir#includes/helperFunctions.cfm" />

    <cfif not structKeyExists(session, 'errors')>
      <cfset session['errors'] = structNew() />
    </cfif>

    <cfinclude template="#arguments.targetPage#" />

    <cfif structKeyExists(session, 'errors')>
      <cfset structClear(session['errors']) />
    </cfif>
  </cffunction>

</cfcomponent>
