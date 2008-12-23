<!---delete company action page.

	1. deletes company
	2. deletes all unconfirmed bookings for the company
	3. deletes all vessels for the company
	
	
	--->


<cfif isDefined('form.CID')>

	<cfquery name="getCompanyUsers" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT Users.UID
		FROM Users INNER JOIN UserCompanies ON Users.UID = UserCompanies.UID
		WHERE UserCompanies.CID = #form.CID#
		AND Users.Deleted = 0 AND UserCompanies.Deleted = 0
	</cfquery>
	
	<cfloop query="getCompanyUsers">
			
		<!---<cfquery name="updateUser#UID#" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			UPDATE Users
			SET Deleted = 1
			WHERE UID = #UID#
		</cfquery>--->
		
		<cfquery name="delUserCompanies#UID#" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			UPDATE	UserCompanies
			SET		Deleted = 1
			WHERE	UID = #UID# AND CID = '#form.CID#'
		</cfquery>
			
	</cfloop>
			
	<cfquery name="getVessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT VNID
		FROM Vessels
		WHERE CID = #form.CID#
	</cfquery>
	
	<cfloop query="getVessels">

		<cfquery name="updateBooking#VNID#" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			UPDATE	Bookings
			SET		Deleted = 1
			WHERE	VNID = #VNID#
		</cfquery>
		
		<cfquery name="deleteVessel#VNID#" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			UPDATE	Vessels
			SET		Deleted = 1
			WHERE	VNID = #VNID#
		</cfquery>
		
	</cfloop>
	
	<cfquery name="delCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	Companies
		SET		Deleted = 1
		WHERE	CID = #form.CID#
	</cfquery>
	
</cfif>

<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Name FROM Companies WHERE CID = #form.CID#
</cfquery>


<cfset Session.Success.Breadcrumb = "Delete Company">
<cfset Session.Success.Title = "Delete Company">
<cfset Session.Success.Message = "<b>#getCompany.Name#</b> has been deleted.">
<cfset Session.Success.Back = "Back to Admin Functions Home">
<cfset Session.Success.Link = "#RootDir#admin/menu.cfm?lang=#lang#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">
