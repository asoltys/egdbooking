<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT TOP 1 VNID
FROM Vessels
WHERE CID = <cfqueryparam value="#newCID#" cfsqltype="cf_sql_integer" /> 
AND Name = <cfqueryparam value="#vesselNameURL#" cfsqltype="cf_sql_varchar" />
</cfquery>

<cfquery name="insertdata" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
UPDATE Bookings SET
VNID = <cfqueryparam value="#Trim(VNID)#" cfsqltype="cf_sql_integer" />,
UID = <cfqueryparam value="#Trim(newUserName)#" cfsqltype="cf_sql_integer" />
WHERE BRID = <cfqueryparam value="#BRIDURL#" cfsqltype="cf_sql_integer" />
</cfquery>

<cflocation url="#RootDir#admin/JettyBookings/jettyBookingManage.cfm" addtoken="no" />
