<cfif lang EQ "e" OR isDefined("session.AdminLoggedIn")>
	<cfset language.title = "Logout">
	<cfset language.subjects = "Wharfs, Ships, Ferries, Pleasure Craft, Vessels, Repair, Maintenance, Management">
	<cfset language.thankYou = "Thank you for for using the Esquimalt Graving Dock Online Booking System.  You have now been logged out of your session.">
	<cfset language.returnlogin = "Return to login">
<cfelse>
	<cfset language.title = "Fermer la session">
	<cfset language.subjects = "#language.masterSubjects#">
	<cfset language.thankYou = "Merci d'avoir utilisé le système de réservation en ligne de la Cale sèche d'Esquimalt. Votre session est maintenant terminée.">
	<cfset language.returnlogin = "Retourner &agrave; l'ouverture d'une session">
</cfif>


<cfscript>STRUCTCLEAR(Session);</cfscript>

<cfoutput>
<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.title#"">
<meta name=""keywords"" lang=""eng"" content=""#language.masterKeywords# #language.title#"">
<meta name=""description"" lang=""eng"" content=""#language.title#"">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""#language.subjects#"">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.title#</title>">
<cfinclude template="#RootDir#includes/header-#lang#.cfm">

<div class="breadcrumbs">
	<a href="http://www.pwgsc.gc.ca/text/home-#lang#.html">#language.PWGSC#</a> &gt; 
	#language.PacificRegion# &gt; 
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-#lang#.html">#language.EsqGravingDock#</a> &gt; <a href="#RootDir#text/booking-#lang#.cfm">#language.Booking#</A> &gt; <a href="#RootDir#text/login/login.cfm?lang=#lang#">#language.login#</a> &gt; #language.title#
</div>

<div class="main">
<H1>#language.title#</H1>

<div align="left">#language.thankYou#</div>
<br><br>
<div align="center"><a href="login.cfm?lang=#lang#" class="textbutton">#language.returnlogin#</a></div><br>

</div>
</cfoutput>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">