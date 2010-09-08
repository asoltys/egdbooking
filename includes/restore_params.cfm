<cfif isDefined("session.form_structure")>
	<CFSET Form_Array = ArrayNew(1)>
	<CFSET Form_Array = StructKeyArray(Session.Form_Structure)>
	<CFLOOP INDEX="Loop_Kount" FROM="1" TO="#ArrayLen(Form_Array)#" STEP="1">
		<CFIF Form_Array[Loop_Kount] NEQ "FIELDNAMES" AND Form_Array[Loop_Kount] NEQ "ReturnPage" >
			<CFSET Curr_Var = "Form." & #Form_Array[Loop_Kount]#>
			<CFSET Curr_Element = "Session.Form_Structure." & #Form_Array[Loop_Kount]#>
			<CFSET "#Curr_Var#" = EVALUATE(Curr_Element)>
		</CFIF>
	</CFLOOP>
</cfif>
