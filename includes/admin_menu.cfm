<div id="menu2">

	<CFSET variables.datetoken = "">
	<CFIF structKeyExists(url, 'm-m')>
		<CFSET variables.datetoken = variables.datetoken & "&m-m=#url['m-m']#">
	</CFIF>
	<CFIF structKeyExists(form, 'a-y')>
		<CFSET variables.datetoken = variables.datetoken & "&year=#url['a-y']#">
	</CFIF>

	<div>
		<cfoutput>
		<a href="#RootDir#admin/menu.cfm?lang=#lang#" class="textbutton">Admin Home</a>
		<a href="#RootDir#comm/calend-cale-dock.cfm?lang=#lang##datetoken#" class="textbutton">Drydock Calendar</a>
		<a href="#RootDir#comm/calend-jet.cfm?lang=#lang##datetoken#" class="textbutton">Jetty Calendar</a>
		<div>&nbsp;</div>
		<a href="#RootDir#admin/DockBookings/bookingmanage.cfm?lang=#lang#" class="textbutton">Drydock Bookings</a>
		<a href="#RootDir#admin/JettyBookings/jettyBookingmanage.cfm?lang=#lang#" class="textbutton">Jetty Bookings</a>
    <a href="#RootDir#comm/resume-summary_ch.cfm?lang=#lang#" class="textbutton">Bookings Summary</a>
		<a href="#RootDir#ols-login/fls-logout.cfm?lang=#lang#" class="textbutton">Logout</a>
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
