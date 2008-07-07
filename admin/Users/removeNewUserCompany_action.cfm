<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<cfif Len(url.companies) EQ 0>
	<cfset companyList = url.companies>
<cfelse>
	<cfset companyList = cfusion_decrypt(ToString(ToBinary(URLDecode(url.companies))), "shanisnumber1")>
</cfif>

<cfset position = ListFind(companyList, "#form.companyID#")>
<cfset companyList = ListDeleteAt(companyList, "#position#")>

<cfif Len(companyList) EQ 0>
	<cfset companies = companyList>
<cfelse>
	<cfset companies = URLEncodedFormat(ToBase64(cfusion_encrypt(companyList, "shanisnumber1")))>
</cfif>

<cflocation addtoken="no" url="addNewUserCompany.cfm?lang=#lang#&amp;companies=#companies#&amp;info=#url.info#">
