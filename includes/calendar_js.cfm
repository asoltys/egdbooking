<CFIF IsDefined('Variables.EndDate') AND Variables.EndDate neq "" AND IsDefined('Variables.StartDate') AND Variables.EndDate neq "">
	<CFSET Variables.BookingLen = Variables.EndDate - Variables.StartDate>
</CFIF>

<CFPARAM name="Variables.BookingLen" default="1">



