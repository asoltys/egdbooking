<cfset language.noFirstName = "Please enter a first name.">
<cfset language.noLastName = "Please enter a last name.">
<cfset language.noEmail = "Please enter a last name.">

<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif trIM(Form.FirstName) EQ "">
	<cfoutput>#ArrayAppend(Errors, "#language.noFirstName#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif trIM(Form.LastName) EQ "">
	<cfoutput>#ArrayAppend(Errors, "#language.noLastName#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif trIM(Form.Email) EQ "">
	<cfoutput>#ArrayAppend(Errors, "#language.noEmail#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="editUser.cfm?lang=#lang#&UID=#form.UID#" addtoken="no">
</cfif>


<cfif isdefined("form.UID")>

	<cfquery name="editUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE Users
		SET
			<!---LoginID = '#trim(form.loginID)#',--->
			FirstName = <cfqueryparam value="#trim(form.firstname)#" cfsqltype="cf_sql_varchar" />,
			LastName = <cfqueryparam value="#trim(form.lastname)#" cfsqltype="cf_sql_varchar" />,
			ReadOnly = <cfqueryparam value="#trim(form.ReadOnly)#" cfsqltype="cf_sql_varchar" />,
			Email = <cfqueryparam value="#trim(form.email)#" cfsqltype="cf_sql_varchar" />
		WHERE UID = <cfqueryparam value="#form.UID#" cfsqltype="cf_sql_integer" />
	</cfquery>

</cfif>

<!--- doesn't seem to need a success notice since it gets sent back to the same page with 
	the new info on it.  It really should be painfully obvious. --->

<cflocation addtoken="no" url="editUser.cfm?lang=#lang#&UID=#form.UID#">
