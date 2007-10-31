<cfif Len(url.companies) EQ 0>
	<cfset companyList = url.companies>
<cfelse>
	<cfset companyList = Decrypt("#ToString(ToBinary(url.companies))#", "shanisnumber1")>
</cfif>

<cfoutput>ArrayAppend(#url.companyArray#, #form.companyID#)</cfoutput>

<cfif Len(companyList) EQ 0>
	<cfset companies = companyList>
<cfelse>
	<cfset companies = ToBase64(Encrypt(companyList, "shanisnumber1"))>
</cfif>

<cflocation addtoken="no" url="addUser.cfm?lang=#lang#&userID=#url.userID#&companyArray=#companyArray#">