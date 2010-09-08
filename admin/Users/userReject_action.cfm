<!--- Joao Edit --->
<cfquery name="countCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	*
	FROM 	UserCompanies
	WHERE 	UID = '#Form.UID#' AND Deleted = 0
</cfquery>

<!--- Joao Edit --->
<cfif countCompany.recordCount EQ 1>
	<cfquery name="deleteUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE  Users
		SET     Deleted = 1
		WHERE 	UID = '#Form.UID#'
		AND     Deleted = 0
	</cfquery>
</cfif>

<cfquery name="RejectUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE 	UserCompanies
	SET 	Deleted = 1
	WHERE 	UID = '#Form.UID#'
	AND		CID = '#Form.CID#'
</cfquery>

<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	FirstName + ' ' + LastName AS UserName, Email
	FROM	Users
	WHERE	UID = '#Form.UID#'
</cfquery>

<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Name AS CompanyName
	FROM	Companies
	WHERE	CID = '#Form.CID#'
</cfquery>

<cflock throwontimeout="no" scope="session" timeout="30" type="readonly">
	<cfquery name="getAdmin" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Email
		FROM	Users
		WHERE	UID = '#session.UID#'
	</cfquery>
</cflock>

<cfoutput>

	<cfmail to="#getUser.Email#" from="#Session.AdminEmail#" subject="Company Request Rejected - Demande de l'entreprise rejet&eacute;e" type="html">
<p>#getUser.UserName#,</p>
<p>Your request to be added to #getCompany.CompanyName#'s user list has been rejected.  Please contact the Esquimalt Graving Dock administration for details by replying to this email.</p>
<p>Esquimalt Graving Dock</p>
<br />
<p>La demande d'ajout de votre nom &agrave; la liste d'utilisateurs de #getCompany.CompanyName#'s a &eacute;t&eacute; rejet&eacute;e. Veuillez communiquer avec l'administration de la Cale s&egrave;che d'Esquimalt pour de plus amples renseignements en r&eacute;pondant &agrave; ce courriel.
</p>
<p>Cale s&egrave;che d'Esquimalt</p>
	</cfmail>
</cfoutput>

<!--- doesn't seem to need a success notice since it gets sent back to the same page with 
	the new info on it.  It really should be painfully obvious. --->

<cflocation url="userApprove.cfm?lang=#lang#" addtoken="no">

