<cfinclude template="#RootDir#includes/errorMessages.cfm">
<cfif lang EQ "eng">
	<cfset language.address = "The email address">
	<cfset language.notReg = "is not registered">
	<cfset language.enterInfoError = "Please enter your login information.">
<cfelse>
	<cfset language.address = "L'adresse de courriel">
	<cfset language.notReg = "n'est pas enregistr&eacute;e">
	<cfset language.enterInfoError = "Veuillez entrer les renseignements dont vous avez besoin pour ouvrir une session.">
</cfif>

<!-- If a cookie is present on the system, bypass the login and go right into the system -->
<cfif IsDefined("Cookie.email")>
	<cfquery name="GetUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	*
		FROM	Users
		WHERE	email = '#Cookie.email#'
	</cfquery>
<cfelse>
	<!---Lookup the login in the database --->
	<cfquery name="IsValidLogin" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Count(*) AS Login_Match
		FROM	Users
		WHERE	email = '#Form.email#'
		AND		Password = '#Form.Password#'
		AND 	Deleted = '0'
		AND	EXISTS (SELECT	*
					FROM	UserCompanies
					WHERE	UserCompanies.UserID = Users.UserID 
					AND 	Approved = 1
					AND		Deleted = 0)
	</cfquery>

	<!---If it was an invalid login or the user is invalid, send them back to the login page --->
	<cfif IsValidLogin.Login_Match IS "0">
		<cfset Variables.Errors = ArrayNew(1)>
		
		<!--- Check for errors --->
		<cfquery name="checkEmail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT	Count(*) AS NumFound
			FROM	Users
			WHERE	email = '#Form.email#'
			AND 	Deleted = '0'
		</cfquery>
		<cfquery name="notApproved" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT	Count(*) AS NumFound
			FROM	Users
			WHERE	email = '#Form.email#'
			AND 	Deleted = '0'
			AND	NOT EXISTS (SELECT	*
							FROM	UserCompanies
							WHERE	UserCompanies.UserID = Users.UserID
							AND 	Approved = 1
							AND		Deleted = 0)
		</cfquery>
		<cfquery name="wrongPassword" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT	Count(*) AS NumFound
			FROM	Users
			WHERE	email = '#Form.email#'
			AND		Password != '#Form.Password#'
			AND 	Deleted = '0'
		</cfquery>
		
		<cfparam name="Variables.passError" default="false">
		
		<cfif form.email EQ ''>
			<cfoutput>#ArrayAppend(Variables.Errors, "#language.enterInfoError#")#</cfoutput>
		<cfelseif NOT REFindNoCase("^([a-zA-Z_\.\-\']*[a-zA-Z0-9_\.\-\'])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9])+$",#trim(Form.Email)#)>
			<cfoutput>#ArrayAppend(Variables.Errors, "#language.invalidEmailError#")#</cfoutput>
		<cfelseif checkEmail.NumFound EQ 0>
			<cfoutput>#ArrayAppend(Variables.Errors, "#language.address#, #Form.Email#, #language.notReg#.")#</cfoutput>
		<cfelseif notApproved.NumFound GT 0 AND checkEmail.NumFound GT 0>
			<cfoutput>#ArrayAppend(Variables.Errors, "#language.unapprovedEmailError#")#</cfoutput>
		<cfelseif wrongPassword.NumFound GT 0 AND checkEmail.NumFound GT 0>
			<cfoutput>#ArrayAppend(Variables.Errors, "#language.incorrectPasswordError#")#</cfoutput>
			<cfset Variables.passError = "true">
		</cfif>

		
		<cfinclude template="#RootDir#includes/build_return_struct.cfm">
		<cfset Session.Return_Structure.Errors = Variables.Errors>
		<cflocation url="login.cfm?lang=#lang#&pass=#Variables.passError#" addtoken="no">
		
	<!---Otherwise send them to the home page of the application --->
	<cfelse>
		<cfquery name="GetUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT	*
			FROM	Users 
			WHERE	email = '#Form.email#'
			AND		Password = '#Form.Password#'
			AND     Deleted = 0 <!--- Joao Edit --->
		</cfquery>
	</cfif>
</cfif>

<CFCOOKIE NAME="LoggedIn" VALUE="Yes" PATH="/EGD" DOMAIN=".monster.pac.pwgsc.gc.ca">

<!---Remember user's email address--->
<CFIF IsDefined('form.remember')>
	<!---SET COOKIE--->
	<CFOUTPUT>
	<CFLOCK timeout="60" throwontimeout="No" type="READONLY" scope="SESSION">
		<CFCOOKIE NAME="login" VALUE="#Form.email#" EXPIRES="Never">
	</CFLOCK>
	</CFOUTPUT>
<CFELSE>
	<!---DELETE COOKIE--->
	<cflock timeout="60" throwontimeout="No" type="EXCLUSIVE" scope="SESSION">
		<CFCOOKIE NAME="login" VALUE="empty" EXPIRES="Now">
	</cflock>
</CFIF>

<!--- Set the session variables for the session --->
<cflock timeout="60" throwontimeout="No" type="EXCLUSIVE" scope="SESSION">
	<CFSCRIPT>
	Session.UserID = Trim(GetUser.UserID);
	Session.FirstName = Trim(GetUser.Firstname);
	Session.LastName = Trim(GetUser.LastName);
	Session.EMail = Trim(GetUser.EMail);
	</CFSCRIPT>
</cflock>

<cfquery name="CheckAdmin" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Count(UserID) AS NumFound
	FROM	Administrators
	WHERE	UserID = '#GetUser.UserID#'
</cfquery>

<cfif CheckAdmin.NumFound GT 0>
	<CFLOCK TIMEOUT="60" THROWONTIMEOUT="No" TYPE="EXCLUSIVE" SCOPE="SESSION"> 
		<CFSET Session.AdminLoggedIn = "1">
		<CFSET Session.AdminEmail = "lois.chan@pwgsc.gc.ca">
		<!--- change this back to EGDBooking@pwgsc.gc.ca when done --->
	</CFLOCK>
	<CFHEADER STATUSCODE="302" STATUSTEXT="Object Temporarily Moved">
	<CFHEADER NAME="location" VALUE="#RootDir#text/admin/menu.cfm?lang=#lang#">
<cfelse>
	<CFLOCK TIMEOUT="60" THROWONTIMEOUT="No" TYPE="EXCLUSIVE" SCOPE="SESSION"> 
		<CFSET Session.LoggedIn = "1">
	</CFLOCK>
	<CFHEADER STATUSCODE="302" STATUSTEXT="Object Temporarily Moved">
	<CFHEADER NAME="location" VALUE="#RootDir#text/booking/booking.cfm?lang=#lang#">
</cfif>


<!--- Jump right to the main menu page --->
