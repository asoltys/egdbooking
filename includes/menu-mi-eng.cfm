<cfif structKeyExists(session, 'uid')>
  <cfquery name="readonlycheck" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
    SELECT ReadOnly
    FROM Users
    WHERE UID = <cfqueryparam value="#Session.UID#" cfsqltype="cf_sql_integer" />
  </cfquery>
  <cfoutput query="readonlycheck">
    <cfset Session.ReadOnly = #ReadOnly#>
  </cfoutput>
</cfif>

<cfset Variables.BookingRequestString = "">
<cfif IsDefined("URL.VNID")>
  <cfset Variables.BookingRequestString = "&amp;VNID=#URL.VNID#">
<cfelseif IsDefined("URL.CID")>
  <cfset Variables.BookingRequestString = "&amp;CID=#URL.CID#">
</cfif>
<cfif IsDefined("URL.Date") AND DateCompare(#url.date#, #PacificNow#, 'd') EQ 1>
  <cfset Variables.BookingRequestString = "#Variables.BookingRequestString#&amp;Date=#URL.Date#">
</cfif>

<CFSET variables.datetoken = "">
<CFIF structKeyExists(url, 'm-m')>
  <CFSET variables.datetoken = variables.datetoken & "&amp;m-m=#url['m-m']#">
</CFIF>
<CFIF structKeyExists(form, 'a-y')>
  <CFSET variables.datetoken = variables.datetoken & "&amp;a-y=#url['a-y']#">
</CFIF>

<!-- ====== /includes/MENU-MI-ENG.html ====== -->
<cfoutput>
<ul class="leftNav">
  <li><h2><a href="#EGD_URL#/index-eng.html"><acronym title="Esquimalt Graving Dock">EGD</acronym></a></h2></li>
	<li><h2><a href="#RootDir#reserve-book-#lang#.cfm">#language.booking#</a></h2>
    <ul>
      <cfif structKeyExists(session, 'loggedin')>
        <li><a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#" title="#language.BookingHomeButton#">#language.BookingHomeButton#</a></li>
        <li><a href="#RootDir#comm/resume-summary_ch.cfm?lang=#lang#">#language.bookingsSummary#</a></li>
        <li><a href="#RootDir#comm/calend-cale-dock.cfm?lang=#lang##datetoken#">#language.drydockCalendar#</a></li>
        <li><a href="#RootDir#comm/calend-jet.cfm?lang=#lang##datetoken#">#language.JettyCalendar#</a></li>

        <cfif structKeyExists(session, 'readonly') and Session.ReadOnly NEQ 1>
        <li><a href="#RootDir#reserve-book/resdemande-bookrequest.cfm?lang=#lang##Variables.BookingRequestString#" title="#language.requestBooking#">#language.requestBooking#</a></li>
        <li><a href="#RootDir#reserve-book/navireajout-vesseladd.cfm?lang=#lang#">#Language.addVessel#</a></li>
        </cfif>
        <li><a href="#RootDir#reserve-book/formulaires-forms.cfm?lang=#lang#">#language.BookingForms#</a></li>
        <li><a href="#RootDir#reserve-book/archives.cfm?lang=#lang#">#language.archivedBookings#</a></li>
        <li><a href="#RootDir#reserve-book/profilmod-profileedit.cfm?lang=#lang#">#language.EditProfileButton#</a></li>
        <li><a href="#RootDir#reserve-book/avis-notices.cfm?lang=#lang#">#language.notices#</a></li>
        <li><a href="#RootDir#ols-login/fls-logout.cfm?lang=#lang#">#language.LogoutButton#</a></li>
      <cfelse>
        <li><a href="#RootDir#ols-login/ols-login.cfm?lang=#lang#">#language.Login#</a></li>
      </cfif>
    </ul>
  <li><h2><acronym title="Esquimalt Graving Dock">EGD</acronym> Resources</h2>
    <ul>
			<li><a href="#EGD_URL#/site-eng.html" title="Site Map">Site Map</a></li>
			<li><a href="#EGD_URL#/cn-cu-eng.html" title="Contact EGD">Contact EGD</a></li>
		</ul>
	</li>
</ul>
</cfoutput>
<!-- ====== /includes/MENU-MI-ENG.html ====== -->
