<CFIF trim(form.name) eq ''>
	<cfoutput>#ArrayAppend(Variables.Errors, "Please enter a vessel name.")#</cfoutput>
	<cfset Proceed_OK = "No">
</CFIF>

<!--- 
commented out 09/23/05 as not all ships have a Lloyd's ID or IMO Number
<CFIF trim(form.lloydsID) eq ''>
	<cfoutput>#ArrayAppend(Variables.Errors, "Please enter a valid Lloyd's ID.")#</cfoutput>
	<cfset Proceed_OK = "No">
</CFIF>
--->

<cfif isDefined('form.VNID')>

	<cfquery name="editVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE Vessels
		SET
			name = <cfqueryparam value="#trim(form.name)#" cfsqltype="cf_sql_varchar" />,
			length = <cfqueryparam value="#trim(form.length)#" cfsqltype="cf_sql_float" />,
			width = <cfqueryparam value="#trim(form.width)#" cfsqltype="cf_sql_float" />,
			blocksetuptime = <cfqueryparam value="#trim(form.blocksetuptime)#" cfsqltype="cf_sql_float" />,
			blockteardowntime = <cfqueryparam value="#trim(form.blockteardowntime)#" cfsqltype="cf_sql_float" />,
			LloydsID = <cfqueryparam value="#trim(form.LloydsID)#" cfsqltype="cf_sql_varchar" />,			
			Tonnage = <cfqueryparam value="#trim(form.tonnage)#" cfsqltype="cf_sql_float" />,
			Anonymous = <cfqueryparam value="#(Form.Anonymous)#" cfsqltype="cf_sql_bit" /><!---,
			EndHighlight = '#DateFormat(Form.EndHighlight, "mm/dd/yyyy")#'--->
		WHERE VNID = <cfqueryparam value="#form.VNID#" cfsqltype="cf_sql_integer" />
		AND deleted = 0
	</cfquery>

</cfif>

<cfset Session.Success.Breadcrumb = "Edit Vessel">
<cfset Session.Success.Title = "Edit Vessel">
<cfset Session.Success.Message = "<b>#form.Name#</b>'s information has been updated.">
<cfset Session.Success.Back = "Back to Edit Vessel">
<cfset Session.Success.Link = "#RootDir#admin/editVessel.cfm?lang=#lang#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">
