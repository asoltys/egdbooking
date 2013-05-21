<cfinclude template="#RootDir#includes/companyInfoVariables.cfm">
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
	WHERE Name = <cfqueryparam value="#trim(form.Name)#" cfsqltype="cf_sql_varchar" /> AND Deleted = 0
</cfquery>

<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif getCompany.recordcount GE 1>
	<cfset session['errors']['name'] = language.companyError />
	<cfset Proceed_OK = "No">
</cfif>
<cfif trim(form.name) EQ "">
	<cfset session['errors']['name'] = language.enterName />
	<cfset Proceed_OK = "No">
</cfif>

<cfif Len(form.phone) LT 10>
	<cfset session['errors']['phone'] = language.phoneShortError />
	<cfset Proceed_OK = "No">
</cfif>

<cfif trim(form.phone) EQ "">
	<cfset session['errors']['phone'] = language.phoneError />
	<cfset Proceed_OK = "No">
</cfif>

<cfif trim(form.address1) EQ "">
	<cfset session['errors']['address1'] = language.addressError />
	<cfset Proceed_OK = "No">
</cfif>

<cfif trim(form.city) EQ "">
	<cfset session['errors']['city'] = language.cityError />
	<cfset Proceed_OK = "No">
</cfif>

<cfif trim(form.province) EQ "">
	<cfset session['errors']['province'] = language.provinceError />
	<cfset Proceed_OK = "No">
</cfif>

<cfif trim(form.country) EQ "">
	<cfset session['errors']['country'] = language.countryError />
	<cfset Proceed_OK = "No">
</cfif>

<cfif trim(form.zip) EQ "">
	<cfset session['errors']['zip'] = language.zipError />
	<cfset Proceed_OK = "No">
</cfif>

<cfif Len(form.zip) LT 5>
	<cfset session['errors']['zip'] = language.zipShortError />
	<cfset Proceed_OK = "No">
</cfif>
<!---cfif Len(form.zip) LT 5>
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.zipShortError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif--->

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="entrpajout-compadd.cfm?lang=#lang#&info=#url.info#&companies=#url.companies#" addtoken="no">
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
			<cfqueryparam value="#trim(form.Name)#" cfsqltype="cf_sql_varchar" />,
			<cfqueryparam value="#trim(form.address1)#" cfsqltype="cf_sql_varchar" />,
			<cfif isDefined('form.address2')>
				<cfqueryparam value="#trim(form.address2)#" cfsqltype="cf_sql_varchar" />,
			</cfif>
			<cfqueryparam value="#trim(form.city)#" cfsqltype="cf_sql_varchar" />,
			<cfqueryparam value="#trim(form.province)#" cfsqltype="cf_sql_varchar" />,
			<cfqueryparam value="#trim(form.country)#" cfsqltype="cf_sql_varchar" />,
			<cfqueryparam value="#trim(form.zip)#" cfsqltype="cf_sql_varchar" />,
			<cfqueryparam value="#trim(form.phone)#" cfsqltype="cf_sql_varchar" />,
			<cfif isDefined('form.fax')>
				<cfqueryparam value="#trim(form.fax)#" cfsqltype="cf_sql_varchar" />,
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
	<cfmail to="#Variables.AdminEmail#" from="#Variables.email#" subject="New Company Request" type="html" username="#mailuser#" password="#mailpassword#">
<p>A new user, #variables.firstname# #variables.lastname#, has requested to create a company account for #trim(form.Name)#.</p>
	</cfmail>
</cfoutput>

<cfquery name="getCID" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT CID
	FROM Companies
	WHERE Name = <cfqueryparam value="#trim(form.Name)#" cfsqltype="cf_sql_varchar" /> AND Deleted = 0
</cfquery>

<cfif Len(url.companies) EQ 0>
	<cfset companyList = url.companies>
<cfelse>
	<cfset companyList = cfusion_decrypt(ToString(ToBinary(URLDecode(url.companies))), "shanisnumber1")>
</cfif>
<cfif getCID.recordCount GT 0>
	<cfif ListFind(companyList, "#getCID.CID#") EQ 0>
		<cfset companyList = ListAppend(companyList, "#getCID.CID#")>
	</cfif>
</cfif>

<cfset companies = URLEncodedFormat(ToBase64(cfusion_encrypt(companyList, "shanisnumber1")))>

<cflocation addtoken="no" url="entrpdemande-comprequest.cfm?lang=#lang#&info=#url.info#&companies=#companies#">

