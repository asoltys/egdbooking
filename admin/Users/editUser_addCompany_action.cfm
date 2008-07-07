<!---<cfquery name="getDeletedCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Name
	FROM Companies
	WHERE Name = '#trim(form.Name)#'
	AND Deleted = 1
</cfquery>--->

<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Name
	FROM Companies
	WHERE Name = '#trim(form.Name)#' AND Deleted = 0
</cfquery>

<cfquery name="getAbbrev" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Abbreviation
	FROM Companies
	WHERE Abbreviation = '#trim(form.abbrev)#'
	AND Deleted = 0
</cfquery>

<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif getCompany.recordcount GE 1>
	<cfoutput>#ArrayAppend(Variables.Errors, "A company with that name already exists.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif getAbbrev.recordcount GE 1>
	<cfoutput>#ArrayAppend(Variables.Errors, "A company with that abbreviation already exists.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Len(form.phone) LT 10>
	<cfoutput>#ArrayAppend(Variables.Errors, "Please enter a valid phone number.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>
<!---cfif Len(form.zip) LT 5>
	<cfoutput>#ArrayAppend(Variables.Errors, "Please enter a valid postal / zip code.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif--->

<CFIF trim(form.abbrev) eq ''>
	<cfoutput>#ArrayAppend(Variables.Errors, "Please enter a company abbreviation.")#</cfoutput>
	<cfset Proceed_OK = "No">
</CFIF>

<CFIF trim(form.name) eq ''>
	<cfoutput>#ArrayAppend(Variables.Errors, "Please enter a company name.")#</cfoutput>
	<cfset Proceed_OK = "No">
</CFIF>

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="editUser_addCompany.cfm?lang=#lang#$amp;userID=#url.userID#" addtoken="no">
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
			Deleted = 0, 
			Approved = 1
		WHERE Name = '#trim(form.Name)#'
	</cfquery>
	
	<cfquery name="addUserRelation" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		INSERT INTO	UserCompanies (UserID, CompanyID, Approved)
		VALUES		(#url.userID# , #getDeletedCompany.CompanyID#, 1)
	</cfquery>--->

<cfif getCompany.recordcount EQ 0>

	<cftransaction>
		<cfquery name="insertNewCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			INSERT INTO Companies
			(
				Name,
				abbreviation,
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
				Deleted, 
				Approved
			)
		
			VALUES
			(
				'#trim(form.Name)#',
				'#trim(form.abbrev)#',
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
				0,
				1
			)
		</cfquery>
	
		<cfquery name="getID" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT	@@IDENTITY AS CompanyID
			FROM	Companies
		</cfquery>
	
		<cfquery name="addUserRelation" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			INSERT INTO	UserCompanies (UserID, CompanyID, Approved)
			VALUES		(#url.userID# , #getID.CompanyID#, 1)
		</cfquery>
	</cftransaction>

</cfif>

<!--- doesn't seem to need a success notice since it gets sent back to the same page with 
	the new info on it.  It really should be painfully obvious. --->

<cflocation addtoken="no" url="editUser.cfm?lang=#lang#$amp;userID=#url.userID#">
