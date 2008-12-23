<!---error checking for adding a company--->
<cfif lang EQ "eng">
	<cfset language.selectCompany = "Please select a company.">
<cfelse>
	<cfset language.selectCompany = "Veuillez s&eacute;lectionner une entreprise.">
</cfif>

<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif isDefined("form.CID") AND form.CID EQ "">
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.selectCompany#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation addtoken="no" url="#RootDir#reserve-book/profilmod-profileedit.cfm?lang=#lang#">
</cfif>

<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	FirstName + ' ' + LastName AS UserName, Email
		FROM	Users INNER JOIN UserCompanies ON Users.UID = UserCompanies.UID
		WHERE	Users.UID = #session.UID#
	</cfquery>
	
	<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Name AS CompanyName
		FROM	Companies
		WHERE	CID = #form.CID#
	</cfquery>
	
	<cfquery name="getUserCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	CID
		FROM	UserCompanies
		WHERE	UserCompanies.UID = #session.UID# AND UserCompanies.CID = #form.CID#
	</cfquery>
	
	<cfquery name="userCompaniesApproved" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	CID
		FROM	Users INNER JOIN UserCompanies ON Users.UID = UserCompanies.UID
		WHERE	UserCompanies.Approved = 1 AND UserCompanies.Deleted = 0 AND Users.UID = #session.UID#
	</cfquery>

	<cfif getUserCompanies.recordCount EQ 1>
		<cfquery name="editUserCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			UPDATE	UserCompanies
			SET		Deleted = '0', Approved = '0'
			WHERE	UserCompanies.UID = '#session.UID#' AND UserCompanies.CID = '#form.CID#' 
					AND UserCompanies.Deleted = '1'
		</cfquery>
	<cfelse>
		<cfquery name="insertUserCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			INSERT INTO UserCompanies(UID, CID)
			VALUES		('#session.UID#', '#form.CID#')
		</cfquery>
	</cfif>
</cflock>

<cfoutput>
	<cfif userCompaniesApproved.RecordCount EQ 0>
		<cfmail to="#Variables.AdminEmail#" from="#getUser.Email#" subject="New User" type="html">
<p>A new user, #getUser.UserName#, has requested to create an account for #getCompany.CompanyName#.</p>
		</cfmail>
	<cfelse>
		<cfmail to="#Variables.AdminEmail#" from="#getUser.Email#" subject="User Company Request" type="html">
<p>#getUser.UserName# has requested to be added to #getCompany.CompanyName#'s user list.</p>
		</cfmail>
	</cfif>
</cfoutput>

<cflocation addtoken="no" url="#RootDir#reserve-book/profilmod-profileedit.cfm?lang=#lang#">
