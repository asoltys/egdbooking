<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Name
	FROM	Vessels
	WHERE	VNID = <cfqueryparam value="#Form.VNID#" cfsqltype="cf_sql_integer" />
</cfquery>
<cfquery name="delVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE Vessels
	SET Deleted = 1
	WHERE VNID = <cfqueryparam value="#Form.VNID#" cfsqltype="cf_sql_integer" />
</cfquery>


<cfset Session.Eng.Success.Breadcrumb = "Delete Vessel">
<cfset Session.Eng.Success.Title = "Delete Vessel">
<cfset Session.Eng.Success.Message = "The vessel, <strong>#getVessel.Name#</strong>, has been deleted.">
<cfset Session.Eng.Success.Back = "Back to Booking Home">
<cfset Session.Eng.Success.Link = "#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">
<cfset Session.Fra.Success.Breadcrumb = "Suppression de navire">
<cfset Session.Fra.Success.Title = "Suppression de navire">
<cfset Session.Fra.Success.Message = "Le navire, <strong>#getVessel.Name#</strong>, a &eacute;t&eacute; supprim&eacute;.">
<cfset Session.Fra.Success.Back = "Retour &agrave; Accueil&nbsp;- R&eacute;servation">
<cfset Session.Fra.Success.Link = "#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">
