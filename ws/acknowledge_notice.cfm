<cfif structKeyExists(session, 'uid')>
  <cfquery datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
    UPDATE users SET notice_acknowledged = 1
    WHERE UID = <cfqueryparam value="#session.uid#" cfsqltype="cf_sql_integer" />
  </cfquery>
</cfif>
