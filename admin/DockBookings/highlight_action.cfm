<cfif Form.EndHighlight GTE "1">
<cfset Form.EndHighlight = DateAdd("d", Form.EndHighlight, PacificNow) >
<cfelse>
<cfset Form.EndHighlight = DateAdd("yyyy", "-100", PacificNow) >
</cfif>
<cfset Variables.EndHighlight = Form.EndHighlight>
	
	
	
	
	<cfquery name="editHighlight" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE Bookings
		SET
			EndHighlight = '#DateFormat(Form.EndHighlight, "mm/dd/yyyy")#'
		WHERE BRID = #BRID#
		AND deleted = 0
	</cfquery>

<cflocation url = "bookingManage.cfm">

<!---<cfset Session.Success.Breadcrumb = "Edit Vessel">
<cfset Session.Success.Title = "Edit Vessel">
<cfset Session.Success.Message = "<b>#form.Name#</b>'s information has been updated.">
<cfset Session.Success.Back = "Back to Edit Vessel">
<cfset Session.Success.Link = "#RootDir#admin/editVessel.cfm?lang=#lang#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">--->
