<!--- Gets all Bookings that would be affected by the requested booking --->
<cffunction name="Validate" access="public">
	<cfargument name="FormArray" type="Array" required="yes">
	
	<cfset Errors = ArrayNew(1)>
	<cfset Proceed_OK = true>
	
	
	<cfloop index="Loop_Kount" from="1" to="#ArrayLen(FormArray)#" step="1">
		<cfset Curr_Var = "Form." & #FormArray[Loop_Kount]#>
		<cfset "Variables.#Form_Array[Loop_Kount]#" = EVALUATE(Curr_Var)>
	</cfloop>
	
	<cfif IsDefined("Variables.VesselID")>
	</cfif>
	
	<cfif IsDefined("Variables.StartDate") AND IsDefined("Variables.EndDate")>
		<!--- End Date can't be before Start Date --->
		<cfif DateCompare(Variables.StartDate,Variables.EndDate) EQ 1>
			<cfoutput>#ArrayAppend(Errors, "#language.endBeforeStartError#")#</cfoutput>
			<cfset Proceed_OK = false>
		</cfif>
		<!--- Start Date can't be before Today --->
		<cfif DateCompare(Now(), Variables.StartDate, 'd') NEQ -1>
			<cfoutput>#ArrayAppend(Errors, "language.futureStartError")#</cfoutput>
			<cfset Proceed_OK = false>
		</cfif>
	</cfif>
	
	<cfoutput>#Proceed_OK#</cfoutput>

	

	
	
<!--- 	<!--- The Vessel must exist --->
	<cfif getVessel.RecordCount EQ 0>
		<cfoutput>#ArrayAppend(Errors, "#language.noVesselError#")#</cfoutput>
		<cfset Proceed_OK = "No">
	</cfif>
	
	<!--- The Vessel must be of the right size --->
	<cfif getVessel.Width GTE Variables.MaxWidth OR getVessel.Length GTE Variables.MaxLength>
		<cfoutput>#ArrayAppend(Errors, "#language.theVessel#, #getVessel.VesselName#, #language.tooLarge#.")#</cfoutput>
		<cfset Proceed_OK = "No">
	</cfif> --->


</cffunction>

<!--- A
<!--- Check that the Vessel is not already booked for that date range --->
<cfif NOT isDefined("checkDblBooking.VesselID") OR checkDblBooking.VesselID NEQ "">
	<cfoutput>#ArrayAppend(Errors, "#checkDblBooking.Name# #language.dblBookingError# #LSdateFormat(checkDblBooking.StartDate, 'mm/dd/yyy')# #language.to# #LSdateFormat(checkDblBooking.EndDate, 'mm/dd/yyy')#.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif DateDiff("d",Form.StartDate,Form.EndDate) LT 0>
	<cfoutput>#ArrayAppend(Errors, "#language.bookingTooShortError#")#</cfoutput>
		<cfoutput>#ArrayAppend(Errors, "#language.StartDate#: #LSDateFormat(Form.StartDate, 'mmm d, yyyy')#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

B
<!--- Date Range must be at least have the same number of days as the Number of Days asked for --->
<cfif DateDiff("d",Form.StartDate,Form.EndDate) LT Form.NumDays-1>
	<cfoutput>#ArrayAppend(Errors, "#language.bookingTooShortError#")#</cfoutput>
		<cfoutput>#ArrayAppend(Errors, "#language.StartDate#: #LSDateFormat(CreateODBCDate(Form.StartDate), 'mmm d, yyyy')#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<!--- The Number of Days must exist --->
<cfif NOT IsDefined("Form.NumDays")>
	<cfoutput>#ArrayAppend(Errors, "#language.needBookingDaysError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<!--- The Number of days must be 1 or greater --->
<cfif IsDefined("Form.NumDays") AND Form.NumDays LTE 0>
	<cfoutput>#ArrayAppend(Errors, "#language.bookingTooShortError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif> --->