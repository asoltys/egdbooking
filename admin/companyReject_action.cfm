<cfquery name="RejectUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE 	UserCompanies
	SET 	Deleted = 1
	WHERE 	CID = <cfqueryparam value="#Form.CID#" cfsqltype="cf_sql_integer" />
</cfquery>
<cfquery name="RejectCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE 	Companies
	SET 	Deleted = 1
	WHERE 	CID = <cfqueryparam value="#Form.CID#" cfsqltype="cf_sql_integer" />
	AND		Approved = '0'
</cfquery>

<cfquery name="getCompanyAgents" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Email
	FROM	Users INNER JOIN UserCompanies ON Users.UID = UserCompanies.UID
	WHERE	CID = <cfqueryparam value="#Form.CID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfquery name="companyName" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Name
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
	<cfloop query="getCompanyAgents">
	<cfif lang EQ "eng">
		<cfif ServerType EQ "Development">
		<cfset Email = DevEmail />
		</cfif>
		<cfmail to="#Email#" from="#AdministratorEmail#" subject="Company Rejected - Entreprise rejet&eacute;e" type="html">
<p>Your requested company, #companyName.Name#, has been rejected.  Please contact the Esquimalt Graving Dock administration for details by replying to this email.</p>
<p>Esquimalt Graving Dock</p>
<br />
<p>L'entreprise que vous avez demand&eacute;e, #companyName.Name#, a &eacute;t&eacute; rejet&eacute;e.  Veuillez communiquer avec l'administration de la Cale s&egrave;che d'Esquimalt pour de plus amples renseignements en r&eacute;pondant &agrave; ce courriel.</p>
<p>Cale s&egrave;che d'Esquimalt</p>
		</cfmail>
	</cfif>
	</cfloop>
</cfoutput>

<cflocation url="companyApprove.cfm?lang=#lang#" addtoken="no">

