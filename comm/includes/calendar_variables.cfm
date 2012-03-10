<CFIF url.lang eq 'eng' OR url.lang eq 'jabber'>
	<CFSET language.maintenance = "Maintenace Block">
	<cfset language.bookings = "bookings">
	<cfset language.pending = "pending bookings">
	<cfset language.tentative = "tentative bookings">
	<cfset language.deepsea = "Deepsea Vessel">
	<cfset language.details = "Details">
<CFELSEIF url.lang eq 'fra'>
	<CFSET language.maintenance = "P&eacute;riode de maintenance">
	<cfset language.bookings = "r&eacute;servations">
	<cfset language.pending = "r&eacute;servations en traitement">
	<cfset language.tentative = "r&eacute;servations provisoire">
	<cfset language.deepsea = "Navire oc&eacute;anique">
	<cfset language.details = "D&eacute;tails">
</CFIF>

<cfif NOT structKeyExists(url, 'm-m')>
	<cfset url['m-m'] = myDateFormat(PacificNow, "M")>
</cfif>

<cfif NOT structKeyExists(url, 'a-y')>
	<cfset url['a-y'] = myDateFormat(PacificNow, "YYYY")>
</cfif>

<!--- Create an array for the days of the week --->
<cfset DaysofWeek = ArrayNew(1)>
<cfloop index="daysCounter" from="1" to="7" step="1">
	<cfset DaysofWeek[daysCounter] = myDateFormat(CreateDate(6,1,daysCounter),"dddd")>
</cfloop>

