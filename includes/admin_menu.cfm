<div id="menu2">
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

<CFSET variables.datetoken = "">
<CFIF IsDefined('url.month')>
	<CFSET variables.datetoken = variables.datetoken & "&month=#url.month#">
</CFIF>
<CFIF IsDefined('url.year')>
	<CFSET variables.datetoken = variables.datetoken & "&year=#url.year#">
</CFIF>

<DIV align="center" style="min-height: 30px;">
<CFOUTPUT>
<a href="#RootDir#admin/menu.cfm?lang=#lang#" class="textbutton">Admin Home</a><script language="javascript" type="text/javascript">if (!checkIt()) document.write('&nbsp;');</script>
<a href="#RootDir#comm/dockCalendar.cfm?lang=#lang##datetoken#" class="textbutton">Drydock Calendar</a><script language="javascript" type="text/javascript">if (!checkIt()) document.write('&nbsp;');</script>
<a href="#RootDir#comm/jettyCalendar.cfm?lang=#lang##datetoken#" class="textbutton">Jetty Calendar</a>
<DIV style="height: 5px; ">&nbsp;</DIV>
<a href="#RootDir#admin/DockBookings/bookingmanage.cfm?lang=#lang#" class="textbutton">Drydock Bookings</a><script language="javascript" type="text/javascript">if (!checkIt()) document.write('&nbsp;');</script>
<a href="#RootDir#admin/JettyBookings/jettyBookingmanage.cfm?lang=#lang#" class="textbutton">Jetty Bookings</a><script language="javascript" type="text/javascript">if (!checkIt()) document.write('&nbsp;');</script>
<a href="#RootDir#admin/egd_admindoc-e.html" class="textbutton" target="_blank">Help</a>
<a href="#RootDir#ols-login/logout.cfm?lang=#lang#" class="textbutton">Logout</a>
</CFOUTPUT>
</DIV>

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