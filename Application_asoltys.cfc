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
		<cfquery name="GetUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT	*
			FROM	Users 
			WHERE	email = <cfqueryparam value="adam.soltys@pwgsc.gc.ca" cfsqltype="cf_sql_varchar" />
			AND     Deleted = 0
		</cfquery>

<CFCOOKIE NAME="LoggedIn" value="Yes" PATH="/EGD" DOMAIN="cse-egd.tpsgc-pwgsc.gc.ca">

<!--- Set the session variables for the session --->
<cflock timeout="60" throwontimeout="No" type="EXCLUSIVE" scope="SESSION">
	<CFSCRIPT>
	Session.UID = Trim(GetUser.UID);
	Session.FirstName = Trim(GetUser.Firstname);
	Session.LastName = Trim(GetUser.LastName);
	Session.EMail = Trim(GetUser.EMail);
	</CFSCRIPT>
</cflock>

  <CFSET Session.LoggedIn = "1">
	<cflocation url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">

  </cffunction>
</cfcomponent>
