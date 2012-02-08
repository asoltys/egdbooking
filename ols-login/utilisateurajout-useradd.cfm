<cfinclude template="#RootDir#includes/companyInfoVariables.cfm">
<cfif lang EQ "eng">
	<cfset language.createUser = "Account Registration">
	<cfset language.keywords = "#language.masterKeywords#" & ", Add New User Account">
	<cfset language.description = "Allows user to create a new user account.">
	<cfset language.password = "Password">
	<cfset language.repeatPassword = "Repeat Password">
	<cfset language.firstName = "First Name">
	<cfset language.lastName = "Last Name">
	<cfset language.email = "Email">
	<cfset language.firstNameError = "Please enter your first name.">
	<cfset language.lastNameError = "Please enter your last name.">
	<cfset language.password1Error = "Please enter your password.">
	<cfset language.password2Error = "Please repeat your password for verification.">
	<cfset language.emailError = "Please enter your email address.">
	<cfset language.characters = "characters">
	<cfset language.continue = "Continue">
<cfelse>
	<cfset language.createUser = "Inscription pour les comptes">
	<cfset language.keywords = "#language.masterKeywords#" & ", Ajout d'un nouveau compte d'utilisateur">
	<cfset language.description = "Permet &agrave; l'utilisateur de cr&eacute;er un nouveau compte d'utilisateur.">
	<cfset language.password = "Mot de passe">
	<cfset language.repeatPassword = "Retaper le mot de passe">
	<cfset language.firstName = "Pr&eacute;nom">
	<cfset language.lastName = "Nom de famille">
	<cfset language.email = "Courriel">
	<cfset language.firstNameError = "Veuillez entrer votre pr&eacute;nom.">
	<cfset language.lastNameError = "Veuillez entrer votre nom de famille.">
	<cfset language.password1Error = "Veuillez entrer votre mot de passe.">
	<cfset language.password2Error = "Veuillez entrer de nouveau votre mot de passe aux fins de v&eacute;rification.">
	<cfset language.emailError = "Veuillez entrer votre adresse de courriel.">
	<cfset language.characters = "caract&egrave;res">
	<cfset language.continue = "Continuer">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.CreateUser# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.masterSubjects#"" />
	<title>#language.PWGSC#-#language.esqGravingDock#-#language.CreateUser#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfset Variables.onLoad = "javascript:document.addUserForm.firstname.focus();">

<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT CID, Name FROM Companies WHERE Deleted = 0 ORDER BY CID
</cfquery>
<cfparam name="variables.FirstName" default="">
<cfparam name="variables.LastName" default="">
<cfparam name="variables.email" default="">
<cfparam name="variables.CID" default="#getCompanies.CID#">
<cfif isDefined("url.info")>
	<cfset Variables.userInfo = cfusion_decrypt(ToString(ToBinary(URLDecode(url.info))), "boingfoip")>
	<cfset Variables.firstname = ListGetAt(userInfo, 1)>
	<cfset Variables.lastname = ListGetAt(userInfo, 2)>
	<cfset Variables.email = ListGetAt(userInfo, 3)>
</cfif>
<!-- Start JavaScript Block -->
<script type="text/javascript">
/* <![CDATA[ */
function EditSubmit ( selectedform )
	{
	  document.forms[selectedform].submit();
	}
/* ]]> */
</script>
		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<a href="#RootDir#ols-login/ols-login.cfm?lang=#lang#">#language.login#</a> &gt;
			#language.CreateUser#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.CreateUser#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<cfoutput>

					<cfif IsDefined("Session.Return_Structure")>
					<!--- Populate the Variables Structure with the Return Structure.
							Also display any errors returned --->
					<cfinclude template="#RootDir#includes/getStructure.cfm">
					</cfif>
					<cfif isDefined("url.companies")>
						<cfset Variables.action = "entrpdemande-comprequest.cfm?lang=#lang#&companies=#url.companies#">
						<cfelse>
						<cfset Variables.action = "entrpdemande-comprequest.cfm?lang=#lang#">
					</cfif>
					<form action="#Variables.action#" id="addUserForm" method="post">
            <fieldset>
              <legend>#language.CreateUser#</legend>
              <label for="firstname">#language.FirstName#:</label>
              <input name="firstname" type="text" value="#variables.firstName#" size="23" maxlength="40" id="firstname" />
              <br />

              <label for="lastname">#language.LastName#:</label>
              <input name="lastname" type="text" value="#variables.lastName#" size="23" maxlength="40" id="lastname" />
              <br />

              <label for="password1">#language.Password#:</label>
              <input type="password" name="password1" id="password1" size="23" />
                <span class="smallFont">(*min. 8 #language.characters#)</span>
              <br />

              <label for="password2">#language.RepeatPassword#:</label>
              <input type="password" name="password2" id="password2"  size="23" />
              <br />

              <label for="email">#language.Email#:</label>
              <input name="email" type="text" value="#variables.email#" size="40" maxlength="100" id="email" />
              <br />

              <input type="submit" value="#language.continue#" class="textbutton" />
            </fieldset>
					</form>
				</cfoutput>
			</div>
			<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
