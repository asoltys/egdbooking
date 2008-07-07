<cfset language.noFirstName = "Please enter a first name.">
<cfset language.noLastName = "Please enter a last name.">

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

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="editUser.cfm?lang=#lang#&amp;userID=#form.userID#" addtoken="no">
</cfif>


<cfif isdefined("form.userID")>

	<cfquery name="editUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE Users
		SET
			<!---LoginID = '#trim(form.loginID)#',--->
			FirstName = '#trim(form.firstname)#',
			LastName = '#trim(form.lastname)#',
			ReadOnly = '#trim(form.ReadOnly)#'
		WHERE UserID = #form.userID#
	</cfquery>

</cfif>

<!--- doesn't seem to need a success notice since it gets sent back to the same page with 
	the new info on it.  It really should be painfully obvious. --->

<cflocation addtoken="no" url="editUser.cfm?lang=#lang#&amp;userID=#form.userID#">
