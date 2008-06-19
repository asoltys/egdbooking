<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Name
	FROM	Vessels
	WHERE	VesselID = '#Form.VesselID#'
</cfquery>
<cfquery name="delVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE Vessels
	SET Deleted = 1
	WHERE VesselID = #Form.VesselID#
</cfquery>

<cfif lang EQ "eng">
	<cfset Session.Success.Breadcrumb = "Delete Vessel">
	<cfset Session.Success.Title = "Delete Vessel">
	<cfset Session.Success.Message = "The vessel, <b>#getVessel.Name#</b>, has been deleted.">
	<cfset Session.Success.Back = "Back to Booking Home">
<cfelse>
	<cfset Session.Success.Breadcrumb = "Suppression de navire">
	<cfset Session.Success.Title = "Suppression de navire">
	<cfset Session.Success.Message = "Le navire, <b>#getVessel.Name#</b>, a &eacute;t&eacute; supprim&eacute;.">
	<cfset Session.Success.Back = "Retour &agrave; Accueil&nbsp;- R&eacute;servation">
</cfif>
<cfset Session.Success.Link = "#RootDir#text/booking/booking.cfm?lang=#lang#">
<cflocation addtoken="no" url="#RootDir#text/common/success.cfm?lang=#lang#">