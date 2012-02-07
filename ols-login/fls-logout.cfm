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
	<meta name=""dc.title"" content=""#language.title# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.masterKeywords# #language.title#"" />
	<meta name=""description"" content=""#language.title#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.masterSubjects#"" />
	<title>#language.title# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>#language.title#</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.title#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<cfoutput>
					<p>#language.thankYou#</p>
					<p><a href="ols-login.cfm?lang=#lang#" class="textbutton">#language.returnlogin#</a></p>
				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">


