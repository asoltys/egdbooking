<cfquery name="ApproveUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE	UserCompanies
	SET		Approved = 1
	WHERE	UID = <cfqueryparam value="#Form.UID#" cfsqltype="cf_sql_integer" /> 
	AND		CID = <cfqueryparam value="#Form.CID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	FirstName + ' ' + LastName AS UserName, Email
	FROM	Users
	WHERE	UID = <cfqueryparam value="#Form.UID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Name AS CompanyName
	FROM	Companies
	WHERE	CID = <cfqueryparam value="#Form.CID#" cfsqltype="cf_sql_integer" />
</cfquery>



<cflock throwontimeout="no" scope="session" timeout="30" type="readonly">
	<cfquery name="getAdmin" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Email
		FROM	Users
		WHERE	UID = <cfqueryparam value="#session.UID#" cfsqltype="cf_sql_integer" />
	</cfquery>
</cflock>

<cfoutput>
<cfif ServerType EQ "Development">
<cfset getUser.Email = DevEmail />
</cfif>
	<cfmail to="#getUser.Email#" from="#AdministratorEmail#" subject="Company Request Approved - Demande de l'entreprise approuv&eacute;e" type="html">
<p>#getUser.UserName#,</p>
	<p>Your request to be added to #getCompany.CompanyName#'s user list has been approved.</p>
<p>Esquimalt Graving Dock</p>
<br />
<p>La demande d'ajout de votre nom &agrave; la liste d'utilisateurs de #getCompany.CompanyName#'s a &eacute;t&eacute; approuv&eacute;e.</p>
<p>Cale s&egrave;che d'Esquimalt</p>
	</cfmail>
</cfoutput>

<!--- doesn't seem to need a success notice since it gets sent back to the same page with 
	the new info on it.  It really should be painfully obvious. --->

<cflocation url="userApprove.cfm?lang=#lang#" addtoken="no">

