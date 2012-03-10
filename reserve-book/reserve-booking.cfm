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
	<meta name="dc.title" content="#language.Booking# - #language.esqGravingDock# - #language.PWGSC#" />
	<meta name="keywords" content="#language.keywords#" />
	<meta name="description" content="#language.description#" />
	<meta name="dc.subject" scheme="gccore" content="#language.subjects#" />
	<title>#language.Booking# - #language.esqGravingDock# - #language.PWGSC#</title>
</cfsavecontent>
<cfhtmlhead text="#head#" />

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfquery name="readonlycheck" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT ReadOnly
	FROM Users
	WHERE UID = <cfqueryparam value="#Session.UID#" cfsqltype="cf_sql_integer" />
</cfquery>
<cfset Session.ReadOnly = readonlycheck.ReadOnly />

<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
<p class="breadcrumb">
  <cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html">
  <cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm"> 
  &gt; #language.bookingHome#
</p>
<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->

<div class="colLayout">
<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
  <!-- CONTENT BEGINS | DEBUT DU CONTENU -->
  <div class="center">
    <h1><a name="cont" id="cont">
      <!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
      #language.bookingHome#
      <!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
      </a></h1>

    <div class="content">
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

      </div>
  </div>
<!-- CONTENT ENDS | FIN DU CONTENU -->
</div>

</cfoutput>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
