<cfquery name="insertNewVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
  INSERT INTO Vessels
  (
    Name,
    CID,
    length,
    width,
    blocksetuptime,
    blockteardowntime,
    lloydsid,
    tonnage,
    Anonymous,
    Deleted
  )

  VALUES
  (
    <cfqueryparam value="#trim(form.Name)#" cfsqltype="cf_sql_varchar" />,
    <cfqueryparam value="#trim(form.CID)#" cfsqltype="cf_sql_integer" />,
    <cfqueryparam value="#trim(form.length)#" cfsqltype="cf_sql_float" />,
    <cfqueryparam value="#trim(form.width)#" cfsqltype="cf_sql_float" />,
    <cfqueryparam value="#trim(form.blocksetuptime)#" cfsqltype="cf_sql_float" />,
    <cfqueryparam value="#trim(form.blockteardowntime)#" cfsqltype="cf_sql_float" />,
    <cfqueryparam value="#trim(form.lloydsID)#" cfsqltype="cf_sql_varchar" />,
    <cfqueryparam value="#trim(form.tonnage)#" cfsqltype="cf_sql_float" />,
    <cfqueryparam value="#form.anonymous#" cfsqltype="cf_sql_bit" />,
    0
  )
</cfquery>

<cfif lang EQ "eng">
	<cfset Session.Success.Breadcrumb = "Add New Vessel">
	<cfset Session.Success.Title = "Add New Vessel">
	<cfset Session.Success.Message = "The vessel, <strong>#form.Name#</strong>, has been added.">
	<cfset Session.Success.Back = "Back to Booking Home">
<cfelse>
	<cfset Session.Success.Breadcrumb = "Ajout d'un nouveau navire">
	<cfset Session.Success.Title = "Ajout d'un nouveau navire">
	<cfset Session.Success.Message = "Le navire, <strong>#form.Name#</strong>, a &eacute;t&eacute; ajout&eacute;.">
	<cfset Session.Success.Back = "Retour &agrave; Accueil&nbsp;- R&eacute;servation">
</cfif>
<cfset Session.Success.Link = "#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#&amp;CID=#CID#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">
