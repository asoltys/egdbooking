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

		<cfinclude template="server_settings.cfm" />
    <cfset this.mappings["/egdbooking"] = FileDir />

    <cfif ServerType EQ "Production" AND cgi.server_port NEQ 443 AND cgi.request_method EQ "get">
      <cflocation url="https://#cgi.server_name##cgi.script_name#?#cgi.query_string#" addtoken="no" />
    </cfif>

    <cfparam name="url.lang" default="eng">
    <cfif findnocase("-e",CGI.script_name) or findnocase("-eng",CGI.script_name)>
      <cfset url.lang = "eng">
    <cfelseif findnocase("-f",CGI.script_name) or findnocase("-fra",CGI.script_name)>
      <cfset url.lang = "fra">
    </cfif>

    <cfif lcase(url.lang) EQ "eng">
      <cfset SetLocale("English (Canadian)")>
      <cfset request.datemask = "mmm d, yyyy" />
      <cfset request.longdatemask = "mmmm d, yyyy" />
    <cfelseif lcase(url.lang) EQ "fra">
      <cfset SetLocale("French (Canadian)")>
      <cfset request.datemask = "d mmm, yyyy" />
      <cfset request.longdatemask = "d mmmm, yyyy" />
    </cfif>

    <cfset Variables.MaxLength = 347.67>
    <cfset Variables.MaxWidth = 45.40>

    <cfinclude template="#RootDir#includes/generalLanguageVariables.cfm">
    <cfinclude template="#RootDir#includes/helperFunctions.cfm" />

    <cfinclude template="#arguments.targetPage#" />
  </cffunction>

</cfcomponent>
