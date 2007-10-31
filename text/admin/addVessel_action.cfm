<CFIF trim(form.name) eq ''>
	<cfoutput>#ArrayAppend(Variables.Errors, "Please enter a name for your vessel.")#</cfoutput>
	<cfset Proceed_OK = "No">
</CFIF>

<!--- 
commented out 09/23/05 as not all ships are required to have a Lloyd's ID or IMO Number
<CFIF trim(form.lloydsID) eq ''>
	<cfoutput>#ArrayAppend(Variables.Errors, "Please enter a valid Lloyd's ID.")#</cfoutput>
	<cfset Proceed_OK = "No">
</CFIF>
--->

<!--- <cfquery name="getDeletedVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Name
	FROM Vessels
	WHERE Name = '#trim(form.Name)#'
	AND Deleted = 1
</cfquery>
 --->
<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Name
	FROM Vessels
	WHERE Name = '#trim(form.Name)#'
	AND Deleted = 0
	AND CompanyId = #form.companyID#
</cfquery>

<!---<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif getVessel.recordcount GE 1>
	<cfoutput>#ArrayAppend(Variables.Errors, "A vessel with that name already exists.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="addVessel.cfm?CompanyID=#form.CompanyID#" addtoken="no">
</cfif>--->
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
	</cfquery>--->

<cfif getVessel.recordcount EQ 0> 

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

</cfif>


<cfset Session.Success.Breadcrumb = "Add New Vessel">
<cfset Session.Success.Title = "Add New Vessel">
<cfset Session.Success.Message = "<b>#form.Name#</b> has been created.">
<cfset Session.Success.Back = "Back to Admin Functions Home">
<cfset Session.Success.Link = "#RootDir#text/admin/menu.cfm?lang=#lang#">
<cflocation addtoken="no" url="#RootDir#text/common/success.cfm?lang=#lang#">