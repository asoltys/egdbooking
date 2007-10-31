<cfinclude template="#RootDir#includes/build_form_struct.cfm">

<cfquery name="getDeletedCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Name
	FROM Companies
	WHERE Name = '#trim(form.Name)#'
	AND Deleted = 1
</cfquery>

<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Name AS CompanyName
	FROM Companies
	WHERE Name = '#trim(form.Name)#'
</cfquery>

<cfif lang EQ "e">
	<cfset language.phoneShortError = "Please enter a valid phone number.">
	<cfset language.zipShortError = "Please enter a valid postal / zip code.">
	<cfset language.enterName = "Please enter the company name.">
	<cfset language.nameExists = "A company with that name already exists.">
<cfelse>
	<cfset language.phoneShortError = "Veuillez entrer un num&eacute;ro de t&eacute;l&eacute;phone valide.">
	<cfset language.zipShortError = "Veuillez entrer un code postal valide.">
	<cfset language.enterName = "Veuillez entrer la raison sociale.">
	<cfset language.nameExists = "Une entreprise du même nom existe d&eacute;j&agrave;.">
</cfif>

<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif getCompany.recordcount GE 1>
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.nameExists#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>
<cfif trim(form.name) EQ "">
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.enterName#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Len(form.phone) LT 10>
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.phoneShortError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>
<!--- <cfif Len(form.zip) LT 5>
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.zipShortError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif> --->

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="addCompany.cfm?lang=#lang#" addtoken="no">
</cfif>


<!---<cfif getDeletedCompany.recordcount GT 0>

	<cfquery name="reviveCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE Companies
		SET
			address1 = '#trim(form.address1)#',
			<cfif isDefined('form.address2')>
				address2 = '#trim(form.address2)#',
			</cfif>
			city = '#trim(form.city)#',
			province = '#trim(form.province)#',
			country = '#trim(form.country)#',
			zip = '#trim(form.zip)#',
			phone = '#trim(form.phone)#',
			Deleted = 0
		WHERE Name = '#trim(form.Name)#'
	</cfquery>

	<cflock throwontimeout="no" timeout="30" scope="session">
		<cfquery name="addUserRelation" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			INSERT INTO	UserCompanies (UserID, CompanyID)
			VALUES		(#Session.userID# , #getDeletedCompany.CompanyID#)
		</cfquery>
	</cflock>--->
	
<cfif getCompany.recordcount EQ 0>

	<cftransaction>
		<cfquery name="insertNewCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			INSERT INTO Companies
			(
				Name,
				address1,
				<cfif isDefined('form.address2')>
					address2,
				</cfif>
				city,
				province,
				country,
				zip,
				phone, 
				fax,
				Deleted
			)
			
			VALUES
			(
				'#trim(form.Name)#',
				'#trim(form.address1)#',
				<cfif isDefined('form.address2')>
					'#trim(form.address2)#',
				</cfif>
				'#trim(form.city)#',
				'#trim(form.province)#',
				'#trim(form.country)#',
				'#trim(form.zip)#',
				'#trim(form.phone)#',
				 <cfif isDefined('form.fax')>
					'#trim(form.fax)#',
				</cfif>
				0
			)
		</cfquery>
	
		<cfquery name="getID" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT	@@IDENTITY AS CompanyID
			FROM	Companies
		</cfquery>
	
		<cflock throwontimeout="no" timeout="30" scope="session">
			<cfquery name="addUserRelation" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				INSERT INTO	UserCompanies (UserID, CompanyID)
				VALUES		(#Session.userID# , #getID.CompanyID#)
			</cfquery>
		</cflock>
	</cftransaction>
</cfif>

<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	FirstName + ' ' + LastName AS UserName, Email
	FROM	Users INNER JOIN UserCompanies ON Users.UserID = UserCompanies.UserID
	WHERE	Users.UserID = #session.userID#
</cfquery>

	
<cfoutput>	
	<cfmail to="#Variables.AdminEmail#" from="#getUser.Email#" subject="New Company Request" type="html">
<p>#getUser.UserName# has requested to create an account for #form.Name#.</p>
	</cfmail>
</cfoutput>

<cflocation addtoken="no" url="editUser.cfm?lang=#lang#">