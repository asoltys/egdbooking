<!--- Magic number used to determine maximum length of vessel name displayed in calendar.
	This prevets long names from breaking the pretty calendar table.  Lois Chan, June 2005 --->
<cfset magicnum = 7>

<cfif NOT IsDefined("url.month")>
	<cfset url.month = DateFormat(Now(), "M")>
</cfif>

<cfif NOT IsDefined("url.year")>
	<cfset url.year = DateFormat(Now(), "YYYY")>
</cfif>

<!--- Create an array for the days of the week --->
<cfset DaysofWeek = ArrayNew(1)>
<cfloop index="daysCounter" from="1" to="7" step="1">
	<cfset DaysofWeek[daysCounter] = LSDateFormat(CreateDate(6,1,daysCounter),"dddd")>
</cfloop>