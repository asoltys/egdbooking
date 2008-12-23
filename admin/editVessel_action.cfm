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
			name = '#trim(form.name)#',
			length = '#trim(form.length)#',
			width = '#trim(form.width)#',
			blocksetuptime = '#trim(form.blocksetuptime)#',
			blockteardowntime = '#trim(form.blockteardowntime)#',
			LloydsID = '#trim(form.LloydsID)#',			
			Tonnage = '#trim(form.tonnage)#',
			Anonymous = '#(Form.Anonymous)#'<!---,
			EndHighlight = '#DateFormat(Form.EndHighlight, "mm/dd/yyyy")#'--->
		WHERE VNID = #form.VNID#
		AND deleted = 0
	</cfquery>

</cfif>

<cfset Session.Success.Breadcrumb = "Edit Vessel">
<cfset Session.Success.Title = "Edit Vessel">
<cfset Session.Success.Message = "<b>#form.Name#</b>'s information has been updated.">
<cfset Session.Success.Back = "Back to Edit Vessel">
<cfset Session.Success.Link = "#RootDir#admin/editVessel.cfm?lang=#lang#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">
