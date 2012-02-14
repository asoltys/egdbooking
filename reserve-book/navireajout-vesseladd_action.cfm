

<!--- <cfquery name="getDeletedVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Name
	FROM Vessels
	WHERE Name = '#trim(form.Name)#'
	AND Deleted = 1
</cfquery>
 --->
<!--- <cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Name
	FROM Vessels
	WHERE Name = '#trim(form.Name)#'
	AND Deleted = 0
</cfquery> --->

<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<!--- <cfif getVessel.recordcount GE 1>
	<cfoutput>#ArrayAppend(Variables.Errors, "A vessel with that name already exists.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif> --->

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="#RootDir#reserve-book/navireajout-vesseladd.cfm?lang=#lang#&CID=#CID#" addtoken="no">
</cfif>
<!---
<cfif getDeletedVessel.recordcount GT 0>

	<cfquery name="reviveVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE Vessels
		SET
			name = '#trim(form.name)#',
			CID = #trim(form.CID)#,
			<!---CID = #session.CID#,--->
			length = '#trim(form.length)#',
			width = '#trim(form.width)#',
			blocksetuptime = '#trim(form.blocksetuptime)#',
			blockteardowntime = '#trim(form.blockteardowntime)#',
			LloydsID = '#trim(form.LloydsID)#',
			Tonnage = '#trim(form.tonnage)#',
			<cfif IsDefined("Form.Anonymous")>
				Anonymous = '1',
			<cfelse>
				Anonymous = '0',
			</cfif>
			Deleted = 0
		WHERE Name = '#trim(form.Name)#'
	</cfquery>

<cfelseif getVessel.recordcount EQ 0> --->

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
			<cfqueryparam value="#Form.Anonymous#" cfsqltype="cf_sql_bit" />,
			0
		)
	</cfquery>

<!--- </cfif>

 --->

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
