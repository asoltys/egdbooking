<cfcomponent>
	<cfset this.name = "EGD Booking" />
	<cfset this.sessionmanagement = true />
	<cfset this.sessiontimeout = CreateTimeSpan(2,0,0,0) />
	<cfset this.clientmanagement = false />
	<cfset setEncoding("url","iso-8859-1") />

	<cffunction name="onApplicationStart">
		<!---<cfset application.router = createObject('component', 'supermodel2.router') />--->
	</cffunction>
	
	<cffunction name="onRequest" access="public" returntype="void">
		<cfargument name="targetPage" type="String" required="true" />

		<cfinclude template="../server_settings.cfm" />
    <cfset this.mappings["/egdbooking"] = FileDir>

    <cfif ServerType EQ "Production" AND cgi.server_port NEQ 443 AND cgi.request_method EQ "get">
      <cflocation url="https://#cgi.server_name##cgi.script_name#?#cgi.query_string#" addtoken="no" />
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

    <cfquery name="getEmail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
      SELECT	Email
      FROM	Configuration
    </cfquery>
    <cfset variables.adminEmail = "">
    <cfscript>
      adminEmail = ValueList(getEmail.Email);
    </cfscript>

    <cfinclude template="#RootDir#includes/generalLanguageVariables.cfm">

    <cfif not structKeyExists(session, 'errors')>
      <cfset session['errors'] = structNew() />
    </cfif>

    <cfinclude template="#arguments.targetPage#" />
    <cfset structClear(session['errors']) />
  </cffunction>

</cfcomponent>
