<!---error checking for adding a company--->
<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif isDefined("form.companyID") AND form.companyID EQ "">
	<cfoutput>#ArrayAppend(Variables.Errors, "Please select a company.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation addtoken="no" url="editUser.cfm?lang=#lang#&userID=#form.userID#">
</cfif>

<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfquery name="getUserCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	CompanyID
		FROM	UserCompanies
		WHERE	UserCompanies.UserID = '#form.userID#' AND UserCompanies.CompanyID = '#form.companyID#'
	</cfquery>

	<cfif getUserCompanies.recordCount EQ 1>
		<cfquery name="editUserCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			UPDATE	UserCompanies
			SET		Deleted = '0', Approved = '1'
			WHERE	UserCompanies.UserID = '#form.userID#' AND UserCompanies.CompanyID = '#form.companyID#' 
					AND UserCompanies.Deleted = '1'
		</cfquery>
	<cfelse>
		<cfquery name="insertUserCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			INSERT INTO UserCompanies(UserID, CompanyID, Approved)
			VALUES		('#form.userID#', '#form.companyID#', 1)
		</cfquery>
	</cfif>
</cflock>


<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT FirstName, LastName, email
	FROM Users
	WHERE UserID = #form.UserID#
</cfquery>

<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT name AS companyName
	FROM Companies
	WHERE CompanyID = #form.CompanyID#
</cfquery>


	
<cflock throwontimeout="no" scope="session" timeout="30" type="readonly">
	<cfquery name="getAdmin" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Email
		FROM	Users
		WHERE	UserID = '#session.userID#'
	</cfquery>
</cflock>

<cflock scope="session" throwontimeout="no" timeout="30" type="READONLY">
	<cfif form.UserID NEQ "#session.userID#">
		<cfoutput>
			<cfmail to="#getUser.Email#" from="#Session.AdminEmail#" subject="Company Added - Entreprise ajout&eacute;e" type="html">
				<p>#getUser.firstName# #getUser.lastName#,</p>
				<p>You have been given booking access for #getCompany.companyName# for the Esquimalt Graving Dock Online Booking System.</p>
				<p>Esquimalt Graving Dock</p>
				<br />
				<p>Vous avez maintenant acc&egrave;s aux fonctions de r&eacute;servation pour #getCompany.companyName# dans le syst&egrave;me de r&eacute;servation en ligne de la cale s&egrave;che d'Esquimalt.</p>
				<p>Cale s&egrave;che d'Esquimalt</p>
			</cfmail>
		</cfoutput>
	</cfif>
</cflock>
<!---CFQUERY name="getDetails">
	SELECT	Users.FirstName, Users.LastName, Companies.Name AS CompanyName
	FROM	UserCompanies
		INNER JOIN	Users ON UserCompanies.UserID = Users.UserID
		INNER JOIN	Companies ON UserCompanies.CompanyID = Companies.CompanyID
	WHERE	UserCompanies.UserID = '#form.userID#'
		AND	UserCompanies.CompanyID = '#form.companyID#'
</CFQUERY>

<cfif lang EQ "eng">
	<cfset Session.Success.Title = "Add User to Company">
	<cfset Session.Success.Message = "<b>#getDetails.FirstName# #getDetails.LastName#</b> now represents <b>#getDetails.CompanyName#</b>.">
	<cfset Session.Success.Back = "Back to Admin Functions Home">
<cfelse>
	<cfset Session.Success.Title = "">
	<cfset Session.Success.Message = "">
	<cfset Session.Success.Back = "">
</cfif>
<cfset Session.Success.Link = "addNewUserCompany.cfm?userID=#url.userID#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#"--->

<!--- doesn't seem to need a success notice since it gets sent back to the same page with 
	the new info on it.  It really should be painfully obvious. --->

<cflocation addtoken="no" url="editUser.cfm?lang=#lang#&userID=#form.userID#">

