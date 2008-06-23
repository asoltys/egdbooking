<cfif isdefined('form.vesselID')>
	
	<cfquery name="delVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE Vessels
		SET Deleted = 1
		WHERE vesselID = #form.vesselID#
	</cfquery>
	
</cfif>

<CFQUERY name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Name FROM Vessels WHERE vesselID = #form.vesselID#
</CFQUERY>

<cfset Session.Success.Breadcrumb = "Delete Vessel">
<cfset Session.Success.Title = "Delete Vessel">
<cfset Session.Success.Message = "<b>#getVessel.Name#</b> has been deleted.">
<cfset Session.Success.Back = "Back to Delete Vessels">
<cfset Session.Success.Link = "#RootDir#text/admin/delVessel.cfm?lang=#lang#">
<cflocation addtoken="no" url="#RootDir#text/comm/success.cfm?lang=#lang#">