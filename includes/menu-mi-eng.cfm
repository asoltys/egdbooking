<cflock scope="session" throwontimeout="no" timeout="60" type="readonly">
  <cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
    SELECT	Companies.CID, Name AS CompanyName, UserCompanies.Approved
    FROM	UserCompanies INNER JOIN Companies ON UserCompanies.CID = Companies.CID
    WHERE	UID = <cfqueryparam value="#session.UID#" cfsqltype="cf_sql_integer" /> AND UserCompanies.Deleted = 0 AND UserCompanies.Approved = 1 AND Companies.approved = 1
    ORDER BY Companies.Name
  </cfquery>
</cflock>

<cfparam name="variables.CID" default="#getCompanies.CID#">
<cfif trim(#variables.CID#) EQ ""><cflocation url="#RootDir#ols-login/fls-logout.cfm?lang=#lang#"></cfif>

<cflock timeout="60" throwontimeout="No" type="exclusive" scope="session">
  <cfif isDefined("URL.CID")>
    <cfoutput query="getCompanies">
      <cfif URL.CID eq CID><cfset Variables.CID = #URL.CID#></cfif>
    </cfoutput>
  <cfelseif IsDefined("Session.LastChoice.CID")>
    <cflocation url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#&CID=#Session.LastChoice.CID#" addtoken="no">
  <cfelse>
    <cflocation url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#&CID=#Variables.CID#" addtoken="no">
  </cfif>
  <cfset Session.LastChoice.CID = Variables.CID>
  <cfset Session.Flow.CID = Variables.CID>
</cflock>


<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
  SELECT	Name AS CompanyName
  FROM	Companies
  WHERE	CID = <cfqueryparam value="#variables.CID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfquery name="getVessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
  SELECT VNID, Name
  FROM Vessels
  WHERE CID = <cfqueryparam value="#variables.CID#" cfsqltype="cf_sql_integer" />
  AND Deleted = 0
  ORDER BY Name
</cfquery>

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
	<li>
	<h2><a href="#EGD_URL#/index-eng.html"><acronym title="Esquimalt Graving Dock">EGD</acronym></a></h2>
	<h2><a href="#RootDir#reserve-book-#lang#.cfm">#language.booking#</a></h2>
  <ul>
    <cfif structKeyExists(session, 'loggedin')>
      <li><a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#" title="#language.BookingHomeButton#">#language.BookingHomeButton#</a></li>
      <li><a href="#RootDir#comm/calend-cale-dock.cfm?lang=#lang##datetoken#">#language.drydockCalendar#</a></li>
      <li><a href="#RootDir#comm/calend-jet.cfm?lang=#lang##datetoken#">#language.JettyCalendar#</a></li>

      <cfif structKeyExists(session, 'readonly') and Session.ReadOnly NEQ 1>
      <li><a href="#RootDir#reserve-book/resdemande-bookrequest.cfm?lang=#lang##Variables.BookingRequestString#" title="#language.requestBooking#">#language.requestBooking#</a></li>
      </cfif>

      <li><a href="#RootDir#reserve-book/profilmod-profileedit.cfm?lang=#lang#">#language.EditProfileButton#</a></li>
      <cfif structKeyExists(session, 'readonly') and Session.ReadOnly EQ 1>
      <li><a href="#RootDir#reserve-book/resdemande-bookrequest.cfm?lang=#lang#&amp;CID=#variables.CID#" class="textbutton" title="#language.requestBooking#">#language.requestBooking#</a></li>
      </cfif>
      <li><a href="#RootDir#reserve-book/formulaires-forms.cfm?lang=#lang#">#language.BookingForms#</a></li>
      <li><a href="#RootDir#reserve-book/archives.cfm?lang=#lang#&amp;CID=#variables.CID#">#language.archivedBookings#</a></li>
      <li><a href="#RootDir#ols-login/fls-logout.cfm?lang=#lang#">#language.LogoutButton#</a></li>
    <cfelse>
      <li><a href="#RootDir#ols-login/ols-login.cfm?lang=#lang#">#language.Login#</a></li>
    </cfif>
  </ul>
	<h2><acronym title="Esquimalt Graving Dock">EGD</acronym> Resources</h2>
			<ul>
			<li><a href="#EGD_URL#/site-eng.html" title="Site Map">Site Map</a></li>
			<li><a href="#EGD_URL#/cn-cu-eng.html" title="Contact EGD">Contact EGD</a></li>
		</ul>
	</li>
</ul>
</cfoutput>
<!-- ====== /includes/MENU-MI-ENG.html ====== -->
