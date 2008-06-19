<cfif lang EQ "eng" OR isDefined("session.AdminLoggedIn")>
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

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-eng.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>#language.title#</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-eng.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<CFOUTPUT>#language.title#</CFOUTPUT>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFOUTPUT>
					<p>#language.thankYou#</p>
					<div align="center"><a href="login.cfm?lang=#lang#" class="textbutton">#language.returnlogin#</a></div><br />
				</CFOUTPUT>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
		
