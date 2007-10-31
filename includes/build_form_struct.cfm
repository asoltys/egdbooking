<CFSET Form_Array 							= ArrayNew(1)>
<CFSET Form_Array 							= StructKeyArray(Form)>
<CFSET Session.Form_Structure 			= StructNew()>
<!---<CFSET Session.Form_Structure.ReturnPage	= Variables.ThisPage>--->

<CFLOOP INDEX="Loop_Kount" FROM="1" TO="#ArrayLen(Form_Array)#" STEP="1">
	<CFSET Curr_Var = "Form." & #Form_Array[Loop_Kount]#>
	<CFSET "Session.Form_Structure.#Form_Array[Loop_Kount]#" = EVALUATE(Curr_Var)>
</CFLOOP>
