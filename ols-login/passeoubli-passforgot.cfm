<cfif lang EQ "eng">
	<cfset language.forgot = "Forgot Password">
	<cfset language.description = "Allows user to retrieve lost password.">
	<cfset language.keywords = "#language.masterKeywords#" & " Retrieve Forget Lost Password">
	<cfset language.enterEmail = "Please enter the e-mail address you use to log in.">
	<cfset language.getPassword = "Your password will be emailed to you.">
	<cfset language.email = "Email Address">
	<cfset language.emailError ="Please enter a valid email address.">
	<cfset language.returnlogin = "Return to login">
<cfelse>
	<cfset language.forgot = "Oubli du mot de passe">
	<cfset language.description = "Permet &agrave; l'utilisateur de r&eacute;cup&eacute;rer un mot de passe perdu.">
	<cfset language.keywords = "#language.masterKeywords#" & " R&eacute;cup&eacute;ration d'un mot de passe perdu">
	<cfset language.enterEmail = "Veuillez entrer l'adresse de courriel que vous utilisez pour ouvrir une session.">
	<cfset language.getPassword = "Votre mot de passe vous a &eacute;t&eacute; transmis par courriel.">
	<cfset language.email = "Adresse de courriel">
	<cfset language.emailError ="Veuillez v&eacute;rifier la validit&eacute; de votre addresse de courriel.">
	<cfset language.returnlogin = "Retourner &agrave; l'ouverture d'une session">
</cfif>


<cfhtmlhead text="
<meta name=""dcterms.title"" content=""#language.forgot# - #language.esqGravingDock# - #language.PWGSC#"" />
<meta name=""keywords"" content=""#language.keywords#"" />
<meta name=""description"" content=""#language.description#"" />
<meta name=""dcterms.subject"" content=""#language.masterSubjects#"" />
<meta name=""dc.date.published"" content=""2005-07-25"" />
<meta name=""dc.date.reviewed"" content=""2005-07-25"" />
<meta name=""dc.date.modified"" content=""2005-07-25"" />
<meta name=""dc.date.created"" content=""2005-07-25"" />
<title>#language.forgot# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfset request.title = language.forgot />
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">
<cfparam name="err_email" default="">

<cfset Variables.onLoad = "javascript:document.forgotForm.email.focus();">

				<h1><cfoutput>#language.forgot#</cfoutput></h1>

				<cfif not error("email") EQ "">
  						<cfset err_email = "form-attention" />
				</cfif>

				<cfoutput>
					<cfif IsDefined("Session.Return_Structure")>
						<cfinclude template="#RootDir#includes/getStructure.cfm">
					</cfif>

					<form action="passeoubli-passforgot_action.cfm?lang=#lang#" id="forgotForm" method="post">
            <fieldset>
              <legend>#language.getPassword#</legend>
              <p>#language.requiredFields#</p>
              
              <div class="#err_email#">
                <label for="email"><abbr title="#language.required#" class="required">*</abbr>&nbsp;#language.Email#:</label>
                <input type="text" name="email" id="email" size="30" />
                <span class="form-text-inline">#error('email')#</span>
              </div>

              <input type="submit" value="#language.Submit#" class="button button-accent" />
            </fieldset>
					</form>

					<div><a href="ols-login.cfm?lang=#lang#">#language.returnlogin#</a></div>
				</cfoutput>
			<!-- CONTENT ENDS | FIN DU CONTENU -->
		<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

