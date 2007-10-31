<cfapplication name="egd" sessiontimeout=#CreateTimeSpan(0, 2, 0, 0)# sessionmanagement="yes" clientmanagement="yes">

<!--- Set a global variable for the datasource --->
<cfif NOT IsDefined("URL.lang")>
	<cflocation url="#CGI.PATH_INFO#?lang=e" addtoken="no">
</cfif>
<cfif lcase(url.lang) NEQ "e" AND lcase(url.lang) NEQ "f">
	<cflocation url="#CGI.PATH_INFO#?lang=e" addtoken="no">
</cfif>

<!--- Set a global variable for the datasource --->
<cfif lcase(url.lang) EQ "e">
	<cfset Foobar = SetLocale("English (Canadian)")>
<cfelseif lcase(url.lang) EQ "f">
	<cfset Foobar = SetLocale("French (Canadian)")>
</cfif>
<cfset RootDir = "/">
<cfinclude template="#RootDir#server_settings.cfm">


<cfquery name="getEmail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Email
	FROM	Configuration
</cfquery>
<cfset Variables.AdminEmail = "#getEmail.email#">
APPLICATION.CFM<BR>
<!--- <cfif (NOT IsDefined("Session.LoggedIn") AND NOT IsDefined("Session.AdminLoggedIn")) AND GetFileFromPath(GetCurrentTemplatePath()) NEQ "public.cfm">
	<cflocation url="#RootDir#text/login/login.cfm" addtoken="no">
</cfif> --->

<cfparam name="lang" default="e">

<cfset Variables.MaxLength = 347.67>
<cfset Variables.MaxWidth = 45.40>

<cfparam name="url.StartDate" default="#now()#">
<cfparam name="url.EndDate" default="#DateAdd('d', 30, Now())#">
<cfparam name="url.showConfirmed" default="off">
<cfparam name="url.showPending" default="off">
<!--- <cfparam name="url.userID" default="#session.userID#"> --->

<cfinclude template="#RootDir#includes/generalLanguageVariables.cfm">