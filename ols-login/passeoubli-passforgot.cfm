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
<meta name=""dc.title"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.forgot#"" />
<meta name=""keywords"" content=""#language.keywords#"" />
<meta name=""description"" content=""#language.description#"" />
<meta name=""dc.subject"" scheme=""gccore"" content=""#language.masterSubjects#"" />
<meta name=""dc.date.published"" content=""2005-07-25"" />
<meta name=""dc.date.reviewed"" content=""2005-07-25"" />
<meta name=""dc.date.modified"" content=""2005-07-25"" />
<meta name=""dc.date.created"" content=""2005-07-25"" />
<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.forgot#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfset Variables.onLoad = "javascript:document.forgotForm.email.focus();">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm"> &gt;
			<cfoutput>
			<a href="#RootDir#ols-login/ols-login.cfm?lang=#lang#">#language.login#</a> &gt; 
			#language.forgot#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.forgot#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>
					
				<cfoutput>
					<cfif IsDefined("Session.Return_Structure")>
						<cfinclude template="#RootDir#includes/getStructure.cfm">
						<br />
					</cfif>

					<div style="text-align:center;">#language.enterEmail#<br />#language.getPassword#</div><br />
	
					<cfform action="passeoubli-passforgot_action.cfm?lang=#lang#" name="forgotForm">
						<table align="center">
							<tr>
								<td><label for="email">#language.Email#:</label>&nbsp;&nbsp;<cfinput class="textField" type="Text" name="email" id="email" size="30" validate="regular_expression" pattern=".+@.+..+"  message="#language.emailError#" /></td>
							</tr>
							<tr>
								<td align="right"><input type="submit" value="#language.Submit#" class="textbutton" />
							</tr>
						</table>
					</cfform>
	
					<div style="text-align:center;"><a href="ols-login.cfm?lang=#lang#">#language.returnlogin#</a></div>
				</cfoutput>
				</div>
			<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
		<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

