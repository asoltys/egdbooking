

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
	<cflocation url="#RootDir#text/reserve-book/addVessel.cfm?lang=#lang#&CompanyID=#CompanyID#" addtoken="no">
</cfif>
<!--- 
<cfif getDeletedVessel.recordcount GT 0>

	<cfquery name="reviveVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE Vessels
		SET
			name = '#trim(form.name)#',
			companyid = #trim(form.companyid)#,
			<!---companyid = #session.companyid#,--->
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
			companyID,
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
			'#trim(form.Name)#',
			'#trim(form.companyid)#',
			'#trim(form.length)#',
			'#trim(form.width)#',
			'#trim(form.blocksetuptime)#',
			'#trim(form.blockteardowntime)#',
			'#trim(form.lloydsID)#',
			'#trim(form.tonnage)#',
			'#Form.Anonymous#',
			0
		)
	</cfquery>

<!--- </cfif>

 --->

<cfif lang EQ "eng">
	<cfset Session.Success.Breadcrumb = "Add New Vessel">
	<cfset Session.Success.Title = "Add New Vessel">
	<cfset Session.Success.Message = "The vessel, <b>#form.Name#</b>, has been added.">
	<cfset Session.Success.Back = "Back to Booking Home">
<cfelse>
	<cfset Session.Success.Breadcrumb = "Ajout d'un nouveau navire">
	<cfset Session.Success.Title = "Ajout d'un nouveau navire">
	<cfset Session.Success.Message = "Le navire, <b>#form.Name#</b>, a &eacute;t&eacute; ajout&eacute;.">
	<cfset Session.Success.Back = "Retour &agrave; Accueil&nbsp;- R&eacute;servation">
</cfif>
<cfset Session.Success.Link = "#RootDir#text/reserve-book/booking.cfm?lang=#lang#&CompanyID=#CompanyID#">
<cflocation addtoken="no" url="#RootDir#text/comm/success.cfm?lang=#lang#">