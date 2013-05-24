<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<cfif lang EQ 'eng'>
	<cfset language.keywords = language.masterKeywords & ", Booking Request" />
	<cfset language.description = "The Esquimalt Graving Dock booking application homepage." />
	<cfset language.subjects = language.masterSubjects />
<cfelse>
	<cfset language.keywords = language.masterKeywords & ", Demande de r&eacute;servation" />
	<cfset language.description = "Page d'accueil de l'application des r&eacute;servations de la Cale s&eacute;che d'Esquimalt." />
	<cfset language.subjects = language.masterSubjects />
</cfif>

<cfoutput>

<cfsavecontent variable="head">
	<meta name="dcterms.title" content="#language.Booking# - #language.esqGravingDock# - #language.PWGSC#" />
	<meta name="keywords" content="#language.keywords#" />
	<meta name="description" content="#language.description#" />
	<meta name="dcterms.description" content="#language.description#" />
	<meta name="dcterms.subject" title="gccore" content="#language.subjects#" />
	<title>#language.Booking# - #language.esqGravingDock# - #language.PWGSC#</title>
</cfsavecontent>
<cfhtmlhead text="#head#" />
<cfset request.title = #language.bookingHome# />
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfquery name="readonlycheck" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT ReadOnly
	FROM Users
	WHERE UID = <cfqueryparam value="#Session.UID#" cfsqltype="cf_sql_integer" />
</cfquery>
<cfset Session.ReadOnly = readonlycheck.ReadOnly />
<h1 id="wb-cont">#language.bookingHome#</h1>

<p>#language.Welcome# #Session.Firstname# #Session.LastName#!</p>
<cfinclude template="#RootDir#includes/notice.cfm" />
<cfinclude template="#RootDir#includes/user_menu.cfm">
<cfinclude template="#RootDir#reserve-book/includes/companyApproval.cfm" />
<cfinclude template="#RootDir#reserve-book/includes/companySelection.cfm" />
<cfinclude template="#RootDir#reserve-book/includes/bookingsQueries.cfm" />
<cfinclude template="#RootDir#reserve-book/includes/vesselSelection.cfm" />

<h2>#language.bookingsFor# #current_company#</h2>

<h3>#language.Drydock#</h3>
#bookingsTable(dock_bookings, dock_counts)#

<h3>#language.NorthLandingWharf#</h3>
#bookingsTable(nlw_bookings, nlw_counts)#

<h3>#language.SouthJetty#</h3>
#bookingsTable(sj_bookings, sj_counts)#
  
</cfoutput>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
