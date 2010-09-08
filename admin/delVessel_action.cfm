<cfif isdefined('form.VNID')>
	
	<cfquery name="delVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE Vessels
		SET Deleted = 1
		WHERE VNID = #form.VNID#
	</cfquery>
	
</cfif>

<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Name FROM Vessels WHERE VNID = #form.VNID#
</cfquery>

<cfset Session.Success.Breadcrumb = "Delete Vessel">
<cfset Session.Success.Title = "Delete Vessel">
<cfset Session.Success.Message = "<b>#getVessel.Name#</b> has been deleted.">
<cfset Session.Success.Back = "Back to Delete Vessels">
<cfset Session.Success.Link = "#RootDir#admin/delVessel.cfm?lang=#lang#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">
