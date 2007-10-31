<cfif Form.EndHighlight GTE "1">
<cfset Form.EndHighlight = DateAdd("d", Form.EndHighlight, Now()) >
<cfelse>
<cfset Form.EndHighlight = DateAdd("yyyy", "-100", Now()) >
</cfif>
<cfset Variables.EndHighlight = Form.EndHighlight>
	
	
	
	
	<cfquery name="editHighlight" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE Bookings
		SET
			EndHighlight = '#DateFormat(Form.EndHighlight, "mm/dd/yyyy")#'
		WHERE BookingID = #BookingID#
		AND deleted = 0
	</cfquery>

<cflocation url = "jettyBookingManage.cfm">

<!---<cfset Session.Success.Breadcrumb = "Edit Vessel">
<cfset Session.Success.Title = "Edit Vessel">
<cfset Session.Success.Message = "<b>#form.Name#</b>'s information has been updated.">
<cfset Session.Success.Back = "Back to Edit Vessel">
<cfset Session.Success.Link = "#RootDir#text/admin/editVessel.cfm?lang=#lang#">
<cflocation addtoken="no" url="#RootDir#text/common/success.cfm?lang=#lang#">--->