<!---delete company action page.

	1. deletes company
	2. deletes all unconfirmed bookings for the company
	3. deletes all vessels for the company
	
	
	--->


<cfif isDefined('form.companyID')>

	<cfquery name="getCompanyUsers" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT Users.UserID
		FROM Users INNER JOIN UserCompanies ON Users.UserID = UserCompanies.UserID
		WHERE UserCompanies.companyID = #form.companyID#
		AND Users.Deleted = 0 AND UserCompanies.Deleted = 0
	</cfquery>
	
	<cfloop query="getCompanyUsers">
			
		<!---<cfquery name="updateUser#UserID#" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			UPDATE Users
			SET Deleted = 1
			WHERE UserID = #userID#
		</cfquery>--->
		
		<cfquery name="delUserCompanies#userID#" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			UPDATE	UserCompanies
			SET		Deleted = 1
			WHERE	UserID = #userID# AND CompanyID = '#form.companyID#'
		</cfquery>
			
	</cfloop>
			
	<cfquery name="getVessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT VesselID
		FROM Vessels
		WHERE companyID = #form.companyID#
	</cfquery>
	
	<cfloop query="getVessels">

		<cfquery name="updateBooking#vesselID#" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			UPDATE	Bookings
			SET		Deleted = 1
			WHERE	VesselID = #vesselID#
		</cfquery>
		
		<cfquery name="deleteVessel#vesselID#" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			UPDATE	Vessels
			SET		Deleted = 1
			WHERE	VesselID = #vesselID#
		</cfquery>
		
	</cfloop>
	
	<cfquery name="delCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	Companies
		SET		Deleted = 1
		WHERE	companyID = #form.companyID#
	</cfquery>
	
</cfif>

<CFQUERY name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Name FROM Companies WHERE companyID = #form.companyID#
</CFQUERY>


<cfset Session.Success.Breadcrumb = "Delete Company">
<cfset Session.Success.Title = "Delete Company">
<cfset Session.Success.Message = "<b>#getCompany.Name#</b> has been deleted.">
<cfset Session.Success.Back = "Back to Admin Functions Home">
<cfset Session.Success.Link = "#RootDir#text/admin/menu.cfm?lang=#lang#">
<cflocation addtoken="no" url="#RootDir#text/common/success.cfm?lang=#lang#">