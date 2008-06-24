<cfoutput>
     <CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
      
      <CFELSE>
      
    </CFIF>
    
</CFOUTPUT>

<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT VesselID
FROM Vessels
WHERE CompanyID = '#newCompanyID#' AND Name = '#vesselNameURL#'
</cfquery>

<!---
<cfoutput query="getVessel">
#BookingIDURL#
<br />
#newUserName#
<br />
#VesselID#
</cfoutput>--->


<cfquery name="insertdata" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
UPDATE Bookings
SET
<cfoutput query="getVessel">	VesselID = '#Trim(VesselID)#', </cfoutput>
	UserID = '#Trim(newUserName)#'
WHERE BookingID = #BookingIDURL#
</cfquery>

<!---<cflocation url="#RootDir#admin/JettyBookings/jettyBookingmanage.cfm">--->
<cflocation url="https://www.egdbooking.gc.ca/admin/JettyBookings/jettyBookingmanage.cfm">
