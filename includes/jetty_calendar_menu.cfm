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

<script language="javascript" type="text/javascript">
// used to prevent display problems with old versions of Netscape 4.7 and older

function checkIt() {
	//detect Netscape 4.7-
	if (navigator.appName=="Netscape"&&parseFloat(navigator.appVersion)<=4.7) {
		return false;
	}
		
	return true;
}

function popUp(pageID) {
	if (checkIt()) {
		window.open("<CFOUTPUT>#RootDir#</CFOUTPUT>" + pageID + ".cfm?lang=<CFOUTPUT>#lang#</CFOUTPUT>", "", "width=800, height=400, resizable=yes, menubar=yes, scrollbars=yes, toolbar=no");
	} else {
		// window.open(pageID + ".cfm?lang=<CFOUTPUT>#lang#</CFOUTPUT>", pageID);
		alert("<cfoutput>#language.warning#</cfoutput>");
	}
}
</script>

<CFOUTPUT>
<div align="center" style="font-size: 8pt; min-height: 20px; padding-top: 15px;">
	<A href="jettyCalendar.cfm?lang=#lang##datetoken#">#language.1monthCal#</A> |
	<A href="jetty3MonthCalendar.cfm?lang=#lang##datetoken#">#language.3monthCal#</A> |
<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
	<A href="javascript:popUp('text/admin/projectCalendar_choose')">#language.projectCal#</A> |
</CFIF>
	<A href="bookingsSummary_choose.cfm?lang=#lang#">#language.bookingsSummary#</A>
</div>
</CFOUTPUT>

