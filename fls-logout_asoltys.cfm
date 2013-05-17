<cfif lang EQ "eng" OR isDefined("session.AdminLoggedIn")>
	<cfset language.title = "Logout">
	<cfset language.thankYou = "Thank you for for using the Esquimalt Graving Dock Online Booking System.  You have now been logged out of your session.">
	<cfset language.returnlogin = "Return to login">
<cfelse>
	<cfset language.title = "Fermer la session">
	<cfset language.thankYou = "Merci d'avoir utilis&eacute; le syst&egrave;me de r&eacute;servation en ligne de la Cale s&egrave;che d'Esquimalt. Votre session est maintenant termin&eacute;e.">
	<cfset language.returnlogin = "Retourner &agrave; l'ouverture d'une session">
</cfif>

<cfscript>StrUCTCLEAR(Session);</cfscript>

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""#language.title# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.masterKeywords# #language.title#"" />
	<meta name=""description"" content=""#language.title#"" />
	<meta name=""dcterms.subject"" content=""#language.masterSubjects#"" />
	<title>#language.title# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">
<h1 id="wb-cont"><cfoutput>#language.title#</cfoutput></h1>

<cfoutput>
<p>#language.thankYou#</p>
<p><a href="ols-login.cfm?lang=#lang#" class="textbutton">#language.returnlogin#</a></p>
</cfoutput>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">


