<cfquery datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
ALTER TABLE Vessels ADD EndHighlight datetime
</cfquery>