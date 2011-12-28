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

    <!--- Set the session variables for the session --->
    <cflock timeout="60" throwontimeout="No" type="EXCLUSIVE" scope="SESSION">
      <CFSCRIPT>
      Session.UID = 41;
      Session.FirstName = 'Demo';
      Session.LastName = 'Account';
      Session.EMail = 'adam.soltys@pwgsc.gc.ca';
      Session.LoggedIn = 1;
      </CFSCRIPT>
    </cflock>
    <cflocation url="/egdbooking/reserve-book/reserve-booking.cfm" addtoken="no" />

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
    <cfinclude template="#arguments.targetPage#" />
  </cffunction>

</cfcomponent>
