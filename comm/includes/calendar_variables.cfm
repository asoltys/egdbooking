<CFIF url.lang eq 'eng' OR url.lang eq 'jabber'>
	<CFSET language.maintenance = "Maintenace Block">
	<cfset language.bookings = "bookings">
	<cfset language.pending = "pending bookings">
	<cfset language.tentative = "tentative bookings">
	<cfset language.deepsea = "Deepsea Vessel">
	<cfset language.detailsFor = "Details For">
<CFELSEIF url.lang eq 'fra'>
	<CFSET language.maintenance = "Période de maintenance">
	<cfset language.bookings = "réservations">
	<cfset language.pending = "réservations en traitement">
	<cfset language.tentative = "réservations provisoire">
	<cfset language.deepsea = "Navire océanique">
	<cfset language.detailsFor = "D&eacute;tails pour">
</CFIF>

<!--- Magic number used to determine maximum length of vessel name displayed in calendar.
	This prevets long names from breaking the pretty calendar table.  Lois Chan, June 2005 --->
<cfset magicnum = 8>

<cfif NOT IsDefined("url.month")>
	<cfset url.month = DateFormat(PacificNow, "M")>
</cfif>

<cfif NOT IsDefined("url.year")>
	<cfset url.year = DateFormat(PacificNow, "YYYY")>
</cfif>

<!--- Create an array for the days of the week --->
<cfset DaysofWeek = ArrayNew(1)>
<cfloop index="daysCounter" from="1" to="7" step="1">
	<cfset DaysofWeek[daysCounter] = LSDateFormat(CreateDate(6,1,daysCounter),"dddd")>
</cfloop>