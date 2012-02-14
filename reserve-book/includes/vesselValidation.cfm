<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif trim(form.name) EQ "">
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.nameError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif not isNumeric(trim(form.width))>
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.widthError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif not isNumeric(trim(form.length))>
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.lengthError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif not isNumeric(trim(form.blockSetupTime))>
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.setupError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif not isNumeric(trim(form.BlockTearDownTime))>
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.teardownError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif not isNumeric(trim(form.tonnage))>
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.tonnageError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="#return_url#" addtoken="no">
</cfif>
