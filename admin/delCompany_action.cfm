<!---delete company action page.

	1. deletes company
	2. deletes all unconfirmed bookings for the company
	3. deletes all vessels for the company
	
	
	--->


<cfif isDefined('form.CID')>

	<cfquery name="getCompanyUsers" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT Users.UID
		FROM Users INNER JOIN UserCompanies ON Users.UID = UserCompanies.UID
		WHERE UserCompanies.CID = <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" />
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
			WHERE	UID = <cfqueryparam value="#UID#" cfsqltype="cf_sql_integer" /> AND CID = <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" />
		</cfquery>
			
	</cfloop>
			
	<cfquery name="getVessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT VNID
		FROM Vessels
		WHERE CID = <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" />
	</cfquery>
	
	<cfloop query="getVessels">

		<cfquery name="updateBooking#VNID#" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			UPDATE	Bookings
			SET		Deleted = 1
			WHERE	VNID = <cfqueryparam value="#VNID#" cfsqltype="cf_sql_integer" />
		</cfquery>
		
		<cfquery name="deleteVessel#VNID#" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			UPDATE	Vessels
			SET		Deleted = 1
			WHERE	VNID = <cfqueryparam value="#VNID#" cfsqltype="cf_sql_integer" />
		</cfquery>
		
	</cfloop>
	
	<cfquery name="delCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	Companies
		SET		Deleted = 1
		WHERE	CID = <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" />
	</cfquery>
	
</cfif>

<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Name FROM Companies WHERE CID = <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" />
</cfquery>


<cfset Session.Success.Breadcrumb = "Delete Company">
<cfset Session.Success.Title = "Delete Company">
<cfset Session.Success.Message = "<strong>#getCompany.Name#</strong> has been deleted.">
<cfset Session.Success.Back = "Back to Admin Functions Home">
<cfset Session.Success.Link = "#RootDir#admin/menu.cfm?lang=#lang#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">
