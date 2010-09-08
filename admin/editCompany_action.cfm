<cfif isdefined('form.CID')>
	<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT Name
		FROM Companies
		WHERE Name = '#trim(form.Name)#'
		AND CID <> #form.CID#
		AND Deleted = 0
	</cfquery>
	
	<cfquery name="getAbbrev" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT Abbreviation
		FROM Companies
		WHERE Abbreviation = '#trim(form.abbr)#'
		AND CID <> #form.CID#
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
	
	<CFIF trim(form.abbr) eq ''>
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
		<cflocation url="editCompany.cfm?CID=#form.CID#" addtoken="no">
	</cfif>
	
	
	
	<cfquery name="editCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE Companies
		SET
			name = '#trim(form.name)#',
			address1 = '#trim(form.address1)#',
			<cfif isDefined('form.address2')>
				address2 = '#trim(form.address2)#',
			</cfif>
			city = '#trim(form.city)#',
			province = '#trim(form.province)#',
			country = '#trim(form.country)#',
			zip = '#trim(form.zip)#',
			phone = '#trim(form.phone)#',
			abbreviation = '#trim(ucase(form.abbr))#',
			Deleted = 0, 
			fax = '#trim(form.fax)#',
			approved = 1
		WHERE CID = #form.CID#
	</cfquery>


</cfif>


<cfset Session.Success.Breadcrumb = "Edit Company">
<cfset Session.Success.Title = "Edit Company">
<cfset Session.Success.Message = "<b>#form.Name#</b>'s information has been updated.">
<cfset Session.Success.Back = "Back to Edit Company">
<cfset Session.Success.Link = "#RootDir#admin/editCompany.cfm?lang=#lang#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">
