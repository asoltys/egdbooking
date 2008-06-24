<cfif lang EQ 'eng' OR isDefined("session.AdminLoggedIn")>
	<cfset language.formProblemError = "There was a problem submitting the form.">
<cfelse>
	<cfset language.formProblemError = "Il y a eu un probl&egrave;me lors de la pr&eacute;sentation du formulaire.">
</cfif>


<!--- If there is improper input, the action.cfm will send back a 
	structure containing the field information and error messages --->
<cflock scope="session" timeout="10" type="readonly">
	<cfif IsDefined("Session.Return_Structure")>
		<cfset Variables.Form_Array = ArrayNew(1)>
		<cfset Variables.Form_Array = StructKeyArray(Session.Return_Structure)>
		
		<cfloop index="i" from="1" to="#ArrayLen(Form_Array)#" step="1">
			<cfif Variables.Form_Array[i] NEQ "FIELDNAMES" AND Variables.Form_Array[i] NEQ "Errors">
				<cfset Variables.Curr_Var = "Variables." & #Variables.Form_Array[i]#>
				<cfset Variables.Curr_Element = "Session.Return_Structure." & #Variables.Form_Array[i]#>
				<cfset "#Variables.Curr_Var#" = EVALUATE(Curr_Element)>
			</cfif>
		</cfloop>
	</cfif>
</cflock>

<!--- Displaying error information --->

<cfif IsDefined("Session.Return_Structure.Errors") AND ArrayLen(Session.Return_Structure.Errors) GT 0>
<div id="actionErrors"><cfoutput>#language.formProblemError#</cfoutput><br />
				
<cfloop index="i" from="1" to="#ArrayLen(Session.Return_Structure.Errors)#" step="1">
	<cfoutput>#Session.Return_Structure.Errors[i]#<br></cfoutput>
</cfloop>
<cfset overwrite = '1'>
</div>
</cfif>
<cfif IsDefined("Session.Return_Structure")>
	<cfset StructDelete(Session, "Return_Structure")>
</cfif>
