<cfif lang EQ "e" OR (IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true)>
	<cfset language.Agent = "Agent">
	<cfset language.startDate = "Start Date">
	<cfset language.endDate = "End Date">
	<cfset language.company = "Company">
	<cfset language.vessel = "Vessel">
	<cfset language.bookingRequest = "Booking Request">
	<cfset language.enterInfo = "Please enter the dates for your booking.">
	<cfset language.dateInclusive = "<b>Note: Booking dates are inclusive</b>; i.e. a three day booking is denoted as from May 1 to May 3.">
	<cfset language.chooseCompany = "choose a company">
	<cfset language.chooseVessel = "choose a vessel">
	<!--- Deprecated --->
	<!---cfset language.startError = "Please enter a start date.">
	<cfset language.endError = "Please enter an end date."--->
<cfelse>
	<cfset language.agent = "Agent">
	<cfset language.startDate = "Date de d&eacute;but">
	<cfset language.endDate = "Date de fin">
	<cfset language.company = "Entreprise">
	<cfset language.vessel = "Navire">
	<cfset language.bookingRequest = "Demande de r&eacute;servation">
	<cfset language.enterInfo = "Veuillez entrer les dates de votre r&eacute;servation.">
	<cfset language.dateInclusive = "Nota : les dates des réservations sont inclusives; une réservation de trois jours couvrira la période du 1er mai au 3 mai, par exemple.">
	<cfset language.chooseCompany = "s&eacute;lectionner une entreprise">
	<cfset language.chooseVessel = "s&eacute;lectionner un navire">
	<!---cfset language.startError = "">
	<cfset language.endError = ""--->
</cfif>