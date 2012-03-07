<cfcomponent>
	<cfset this.name = "EGD Booking" />
	<cfset this.sessionmanagement = true />
	<cfset this.sessiontimeout = CreateTimeSpan(2,0,0,0) />
	<cfset this.clientmanagement = false />
	<cfset setEncoding("url","iso-8859-1") />

	<cffunction name="onRequest" access="public" returntype="void">
		<cfargument name="targetPage" type="String" required="true" />

    <cfinclude template="../server_settings.cfm">
    <cfset this.mappings["/egdbooking"] = FileDir />

    <cfif ServerType EQ "Production" AND cgi.server_port NEQ 443 AND cgi.request_method EQ "get">
      <cflocation url="https://#cgi.server_name##cgi.script_name#?#cgi.query_string#" />
    </cfif>

    <cfif NOT IsDefined("URL.lang")>
      <cflocation url="#CGI.PATH_INFO#?lang=eng" addtoken="no">
    </cfif>
    <cfif lcase(url.lang) NEQ "eng" AND lcase(url.lang) NEQ "fra">
      <cflocation url="#CGI.PATH_INFO#?lang=eng" addtoken="no">
    </cfif>

    <cfif lcase(url.lang) EQ "eng">
      <cfset SetLocale("English (Canadian)")>
      <cfset request.datemask = "mmm d, yyyy" />
    <cfelseif lcase(url.lang) EQ "fra">
      <cfset SetLocale("French (Canadian)")>
      <cfset request.datemask = "d mmm, yyyy" />
    </cfif>

    <cfquery name="getEmail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
      SELECT	Email
      FROM	Configuration
    </cfquery>

    <cfif (NOT IsDefined("Session.LoggedIn") AND NOT IsDefined("Session.AdminLoggedIn")) AND GetFileFromPath(GetCurrentTemplatePath()) NEQ "public.cfm">
      <cflocation url="#RootDir#ols-login/ols-login.cfm" addtoken="no">
    </cfif>

    <cfparam name="lang" default="eng">

    <cfset Variables.MaxLength = 347.67>
    <cfset Variables.MaxWidth = 45.40>

    <cfparam name="url.StartDate" default="#PacificNow#">
    <cfparam name="url.EndDate" default="#DateAdd('d', 30, PacificNow)#">
    <cfparam name="url.showConfirmed" default="off">
    <cfparam name="url.showPending" default="off">

    <cfinclude template="#RootDir#includes/generalLanguageVariables.cfm">
    <cfinclude template="#RootDir#includes/helperFunctions.cfm" />

    <cfif structKeyExists(Session, lang)>
      <cfset Session.Success = structCopy(Session[lang].Success) />
    </cfif>

    <cfif not structKeyExists(session, 'errors')>
      <cfset session['errors'] = structNew() />
    </cfif>

    <cfinclude template="#arguments.targetPage#" />

    <cfif structKeyExists(session, 'errors')>
      <cfset structClear(session['errors']) />
    </cfif>
  </cffunction>

</cfcomponent>
