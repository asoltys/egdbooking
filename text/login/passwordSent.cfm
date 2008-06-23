<cfif lang EQ "eng">
	<cfset language.title = "Password Sent">
	<cfset language.description = "Notifies user that their password has been emailed to them.">
	<cfset language.keywords = "#language.masterKeywords#" & " Retrieve Forget Lost Password">
	<cfset language.sentPassword = "Your password has been emailed to you.">
	<cfset language.returnlogin = "Return to login">
<cfelse>
	<cfset language.title = "Mot de passe envoy&eacute;">
	<cfset language.description = "Avise l'utilisateur que son mot de passe lui a &eacute;t&eacute; envoy&eacute; par courrier &eacute;lectronique.">
	<cfset language.keywords = "#language.masterKeywords#" & " R&eacute;cup&eacute;ration d'un mot de passe perdu">
	<cfset language.sentPassword = "Votre mot de passe vous a &eacute;t&eacute; communiqu&eacute; par courriel.">
	<cfset language.returnlogin = "Retourner &agrave; l'ouverture d'une session">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.title#"">
	<meta name=""keywords"" lang=""eng"" content=""#language.keywords#"">
	<meta name=""description"" lang=""eng"" content=""#language.description#"">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""#language.masterSubjects#"">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.title#</title>">

<cfset Variables.onLoad = "javascript:document.forgotForm.email.focus();">

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm"> &gt; 
			<cfoutput>
			<a href="#RootDir#text/login/login.cfm?lang=#lang#">#language.login#</a> &gt; 
			#language.title#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					#language.title#
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>
				<cfoutput>
					<cfif IsDefined("Session.Return_Structure")>
						<cfinclude template="#RootDir#includes/getStructure.cfm">
						<br />
					</cfif>
					
					<div align="center">#language.sentPassword#</div><br>
					
					<div align="center"><a href="login.cfm?lang=#lang#" class="textbutton">#language.returnlogin#</a></div>
				</cfoutput>					
			</div>
			<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
		<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
