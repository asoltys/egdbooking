<cfif lang eq "eng" OR (IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true)>
	<cfset language.warning = "Your browser is not capable of displaying this portion of the application properly.  Please upgrade your browser before proceeding.">
	<cfset language.1monthCal = "1 month calendar">
	<cfset language.3monthCal = "3 month calendar">
	<cfset language.projectCal = "project calendar">
	<cfset language.bookingsSummary = "bookings summary">
<cfelse>
	<cfset language.warning = "Votre navigateur ne peut afficher cette partie de l'application correctement. Veuillez mettre votre navigateur &agrave; niveau avant de continuer.">
	<cfset language.1monthCal = "calendrier pour 1 mois">
	<cfset language.3monthCal = "calendrier pour 3 mois">
	<cfset language.projectCal = "calendrier de projet">
	<cfset language.bookingsSummary = "r&eacute;sum&eacute; des r&eacute;servations">
</cfif>

<cfsavecontent variable="js">
<script type="text/javascript">
/* <![CDATA[ */
function popUp(pageID) {
		window.open("<cfoutput>#RootDir#</cfoutput>" + pageID + ".cfm?lang=<cfoutput>#lang#</cfoutput>", "", "width=800, height=400, resizable=yes, menubar=yes, scrollbars=yes, toolbar=no");
}
/* ]]> */
</script>
</cfsavecontent>
<cfhtmlhead text="#js#" />

<cfoutput>
<div>
	<a href="calend-jet.cfm?lang=#lang##datetoken#">#language.1monthCal#</a> |
	<a href="calend-jet-3m.cfm?lang=#lang##datetoken#">#language.3monthCal#</a> |
<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
	<a href="javascript:popUp('text/admin/projectCalendar_choose')">#language.projectCal#</a> |
</CFIF>
	<a href="resume-summary_ch.cfm?lang=#lang#">#language.bookingsSummary#</a>
</div>
</cfoutput>

