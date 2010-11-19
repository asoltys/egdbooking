<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT VNID
FROM Vessels
WHERE CID = '#newCID#' AND Name = '#vesselNameURL#'
</cfquery>

<cfquery name="insertdata" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
UPDATE Bookings
SET
<cfoutput query="getVessel">	VNID = '#Trim(VNID)#', </cfoutput>
	UID = '#Trim(newUserName)#'
WHERE BRID = #BRIDURL#
</cfquery>

<cflocation url="#RootDir#admin/JettyBookings/jettyBookingManage.cfm" addtoken="no" />
