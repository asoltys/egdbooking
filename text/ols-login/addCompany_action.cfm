<cfinclude template="#RootDir#includes/build_form_struct.cfm">

<cfif lang EQ "eng">
	<cfset language.phoneShortError = "Please enter a valid phone number.">
	<cfset language.zipShortError = "Please enter a valid postal / zip code.">
	<cfset language.companyError = "A company with that name already exists.">
	<cfset language.enterName = "Please enter the company name.">
<cfelse>
	<cfset language.phoneShortError = "Veuillez entrer un num&eacute;ro de t&eacute;l&eacute;phone valide.">
	<cfset language.zipShortError = "Veuillez entrer un code postal valide.">
	<cfset language.companyError = "Une entreprise du m&ecirc;me nom existe d&eacute;j&agrave;.">
	<cfset language.enterName = "Veuillez entrer la raison sociale.">
</cfif>

<!---<cfquery name="getDeletedCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Name
	FROM Companies
	WHERE Name = '#trim(form.Name)#'
	AND Deleted = 1
</cfquery>--->

<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Name AS CompanyName
	FROM Companies
	WHERE Name = '#trim(form.Name)#' AND Deleted = 0
</cfquery>

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
<!---cfif Len(form.zip) LT 5>
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.zipShortError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif--->

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="addCompany.cfm?lang=#lang#&info=#url.info#&companies=#url.companies#" addtoken="no">
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
	</cfquery>--->

<cfif getCompany.recordcount EQ 0>

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

</cfif>

<!---decrpyt user info--->
<cfif isDefined("url.info")><cfset Variables.userInfo = cfusion_decrypt(ToString(ToBinary(url.info)), "boingfoip")></cfif>

<!---store user info--->
<cfif isDefined("url.info")><cfset Variables.firstname = ListGetAt(userInfo, 1)></cfif>
<cfif isDefined("url.info")><cfset Variables.lastname = ListGetAt(userInfo, 2)></cfif>
<cfif isDefined("url.info")><cfset Variables.email = ListGetAt(userInfo, 3)></cfif>

<cfoutput>
	<cfmail to="#Variables.AdminEmail#" from="#Variables.email#" subject="New Company Request" type="html">
<p>A new user, #variables.firstname# #variables.lastname#, has requested to create a company account for #trim(form.Name)#.</p>
	</cfmail>
</cfoutput>

<cfquery name="getCompanyID" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT CompanyID
	FROM Companies
	WHERE Name = '#trim(form.Name)#' AND Deleted = 0
</cfquery>

<cfif Len(url.companies) EQ 0>
	<cfset companyList = url.companies>
<cfelse>
	<cfset companyList = cfusion_decrypt(ToString(ToBinary(URLDecode(url.companies))), "shanisnumber1")>
</cfif>
<cfif getCompanyID.recordCount GT 0>
	<cfif ListFind(companyList, "#getCompanyID.companyID#") EQ 0>
		<cfset companyList = ListAppend(companyList, "#getCompanyID.companyID#")>
	</cfif>
</cfif>

<cfset companies = URLEncodedFormat(ToBase64(cfusion_encrypt(companyList, "shanisnumber1")))>

<cflocation addtoken="no" url="addUserCompanies.cfm?lang=#lang#&info=#url.info#&companies=#companies#">

