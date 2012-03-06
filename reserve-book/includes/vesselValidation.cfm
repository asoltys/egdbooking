<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif trim(form.name) EQ "">
  <cfset session['errors']['name'] = language.nameError />
	<cfset Proceed_OK = "No">
</cfif>

<cfif not isNumeric(trim(form.width))>
  <cfset session['errors']['width'] = language.widthError />
	<cfset Proceed_OK = "No">
</cfif>

<cfif not isNumeric(trim(form.length))>
  <cfset session['errors']['length'] = language.lengthError />
	<cfset Proceed_OK = "No">
</cfif>

<cfif not isNumeric(trim(form.blockSetupTime))>
  <cfset session['errors']['blockSetupTime'] = language.setupError />
	<cfset Proceed_OK = "No">
</cfif>

<cfif not isNumeric(trim(form.BlockTearDownTime))>
  <cfset session['errors']['BlockTearDownTime'] = language.teardownError />
	<cfset Proceed_OK = "No">
</cfif>

<cfif not isNumeric(trim(form.tonnage))>
  <cfset session['errors']['tonnage'] = language.tonnageError />
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="#return_url#" addtoken="no">
</cfif>
