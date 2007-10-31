<CFSET Form_Array 							= ArrayNew(1)>
<CFSET Form_Array 							= StructKeyArray(Form)>
<CFSET Session.Return_Structure 			= StructNew()>


<CFLOOP INDEX="Loop_Kount" FROM="1" TO="#ArrayLen(Form_Array)#" STEP="1">
	<CFSET Curr_Var = "Form." & #Form_Array[Loop_Kount]#>
	<CFSET "Session.Return_Structure.#Form_Array[Loop_Kount]#" = EVALUATE(Curr_Var)>
</CFLOOP>
