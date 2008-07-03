<div id="menu1">
<script language="javascript" type="text/javascript">
// used to prevent display problems with old versions of Netscape 4.7 and older
function checkIt() {
	//detect Netscape 4.7-
	if (navigator.appName=="Netscape"&&parseFloat(navigator.appVersion)<=4.7) {
		return false;
	}
	return true;
}
</script>
<cfquery name="readonlycheck" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT ReadOnly
	FROM Users
	WHERE UserID = #Session.UserID#
</cfquery>
<cfoutput query="readonlycheck">	
	<cfset Session.ReadOnly = #ReadOnly#>
</cfoutput>
<cfif lang EQ 'eng'>
	<cfset language.bookingHomeButton = "Booking Home">
	<cfset language.drydockCalButton = "Drydock Calendar">
	<cfset language.jettyCalButton = "Jetties Calendar">
	<cfset language.requestBookingButton = "Request Booking">
	<cfset language.editProfileButton = "Edit Profile">
	<cfset language.help = "Help">
	<cfset language.logoutButton = "Logout">
<cfelse>
	<cfset language.bookingHomeButton = "Accueil - R&eacute;servation">
	<cfset language.drydockCalButton = "Calendrier de la cale s&egrave;che">
	<cfset language.jettyCalButton = "Calendrier des jet&eacute;es">
	<cfset language.requestBookingButton = "Pr&eacute;senter une r&eacute;servation">
	<cfset language.editProfileButton = "Modifier le profil">
	<cfset language.help = "Aide">
	<cfset language.logoutButton = "Fermer la session">
</cfif>

<cfset Variables.BookingRequestString = "">
<cfif IsDefined("URL.VesselID")>
	<cfset Variables.BookingRequestString = "&VesselID=#URL.VesselID#">
<cfelseif IsDefined("URL.CompanyID")>
	<cfset Variables.BookingRequestString = "&CompanyID=#URL.CompanyID#">
</cfif>
<cfif IsDefined("URL.Date") AND DateCompare(#url.date#, #PacificNow#, 'd') EQ 1>
	<cfset Variables.BookingRequestString = "#Variables.BookingRequestString#&Date=#URL.Date#">
</cfif>

<CFSET variables.datetoken = "">
<CFIF IsDefined('url.month')>
	<CFSET variables.datetoken = variables.datetoken & "&month=#url.month#">
</CFIF>
<CFIF IsDefined('url.year')>
	<CFSET variables.datetoken = variables.datetoken & "&year=#url.year#">
</CFIF>


<cffile action="read" file="#FileDir#intromsg.txt" variable="intromsg">
<cfif #Trim(intromsg)# EQ "">
<cfelse>
	<div class="notice">
	<h2>Notice</h2>
	<cfoutput>#paragraphformat(intromsg)#</cfoutput>
	</div>
</cfif>


  
<div align="center" style="min-height: 30px; ">
<cfoutput>
<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#" class="textbutton">#language.BookingHomeButton#</a><script language="javascript" type="text/javascript">if (!checkIt()) document.write('&nbsp;');</script>
<a href="#RootDir#comm/calend-cale-dock.cfm?lang=#lang##datetoken#" class="textbutton">#language.DrydockCalButton#</a><script language="javascript" type="text/javascript">if (!checkIt()) document.write('&nbsp;');</script>
<a href="#RootDir#comm/calend-jet.cfm?lang=#lang##datetoken#" class="textbutton">#language.JettyCalButton#</a>
<div style="height: 5px; ">&nbsp;</div>

<cfif #Session.ReadOnly# EQ "1"><cfelse>
<a href="#RootDir#reserve-book/resdemande-bookrequest.cfm?lang=#lang##Variables.BookingRequestString#" class="textbutton">#language.RequestBookingButton#</a>
</cfif>

<script language="javascript" type="text/javascript">if (!checkIt()) document.write('&nbsp;');</script>
<a href="#RootDir#reserve-book/profilmod-profileedit.cfm?lang=#lang#" class="textbutton">#language.EditProfileButton#</a><script language="javascript" type="text/javascript">if (!checkIt()) document.write('&nbsp;');</script>
<a href="#RootDir#reserve-book/aide-help-#lang#.html" class="textbutton" target="_blank">#language.Help#</a>
<a href="#RootDir#ols-login/fls-logout.cfm?lang=#lang#" class="textbutton">#language.LogoutButton#</a>
</cfoutput>

</div>

<CFSET variables.urltoken = "lang=#lang#">
<CFIF IsDefined('variables.startDate')>
	<CFSET variables.urltoken = variables.urltoken & "&startDate=#DateFormat(variables.startDate, 'mm/dd/yyyy')#">
<CFELSEIF IsDefined('url.startDate')>
	<CFSET variables.urltoken = variables.urltoken & "&startDate=#DateFormat(url.startDate, 'mm/dd/yyyy')#">
</CFIF>
<CFIF IsDefined('variables.endDate')>
	<CFSET variables.urltoken = variables.urltoken & "&endDate=#DateFormat(variables.endDate, 'mm/dd/yyyy')#">
<CFELSEIF IsDefined('url.endDate')>
	<CFSET variables.urltoken = variables.urltoken & "&endDate=#DateFormat(url.endDate, 'mm/dd/yyyy')#">
</CFIF>
<CFIF IsDefined('variables.show')>
	<CFSET variables.urltoken = variables.urltoken & "&show=#variables.show#">
<CFELSEIF IsDefined('url.show')>
	<CFSET variables.urltoken = variables.urltoken & "&show=#url.show#">
</CFIF>
</div>
<br />
