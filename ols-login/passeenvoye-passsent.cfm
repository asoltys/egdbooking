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
	<meta name=""dcterms.title"" content=""#language.title# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dcterms.subject"" content=""#language.masterSubjects#"" />
	<title>#language.title# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfset Variables.onLoad = "javascript:document.forgotForm.email.focus();">

				<h1><cfoutput>#language.title#</cfoutput></h1>
				<cfoutput>
					<cfif IsDefined("Session.Return_Structure")>
						<cfinclude template="#RootDir#includes/getStructure.cfm">
						<br />
					</cfif>
					
					<div>#language.sentPassword#</div><br />
					
					<div><a href="ols-login.cfm?lang=#lang#" class="textbutton">#language.returnlogin#</a></div>
				</cfoutput>					
			<!-- CONTENT ENDS | FIN DU CONTENU -->
		<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
