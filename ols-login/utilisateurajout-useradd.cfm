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
	<meta name=""dcterms.title"" content=""#language.CreateUser# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dcterms.subject"" content=""#language.masterSubjects#"" />
	<title>#language.CreateUser# - #language.esqGravingDock# - #language.PWGSC#</title>">
	<cfset request.title = language.CreateUser />
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfset Variables.onLoad = "javascript:document.addUserForm.firstname.focus();">

<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT CID, Name FROM Companies WHERE Deleted = 0 ORDER BY CID
</cfquery>
<cfparam name="variables.FirstName" default="">
<cfparam name="variables.LastName" default="">
<cfparam name="variables.email" default="">
<cfparam name="variables.CID" default="#getCompanies.CID#">
<cfparam name="err_newfname" default="">
<cfparam name="err_newlname" default="">
<cfparam name="err_newpass1" default="">
<cfparam name="err_newpass2" default="">
<cfparam name="err_newemail" default="">

<cfif isDefined("url.info")>
	<cfset Variables.userInfo = cfusion_decrypt(ToString(ToBinary(URLDecode(url.info))), "boingfoip")>
	<cfset Variables.firstname = ListGetAt(userInfo, 1)>
	<cfset Variables.lastname = ListGetAt(userInfo, 2)>
	<cfset Variables.email = ListGetAt(userInfo, 3)>
</cfif>

<cfif not error("firstName") EQ "">
  <cfset err_newfname = "form-attention" />
</cfif>
<cfif not error("lastname") EQ "">
  <cfset err_newlname = "form-attention" />
</cfif>
<cfif not error("password1") EQ "">
  <cfset err_newpass1 = "form-attention" />
</cfif>
<cfif not error("password2") EQ "">
  <cfset err_newpass2 = "form-attention" />
</cfif>
<cfif not error("email") EQ "">
  <cfset err_newemail = "form-attention" />
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
				<h1 id="wb-cont"><cfoutput>#language.CreateUser#</cfoutput></h1>

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
              <p>#language.requiredFields#</p>

              <div class="#err_newfname#">
                <label for="firstname">
                  <abbr title="#language.required#" class="required">*</abbr>&nbsp;#language.FirstName#:
                </label>
                <input name="firstname" type="text" value="#variables.firstName#" size="23" maxlength="40" id="firstname" />
                <span class="form-text-inline">#error('firstname')#</span>
              </div>

              <div class="#err_newlname#">
                <label for="lastname">
                  <abbr title="#language.required#" class="required">*</abbr>&nbsp;#language.LastName#:
                  #error('lastname')#
                </label>
                <input name="lastname" type="text" value="#variables.lastName#" size="23" maxlength="40" id="lastname" />
              </div>

              <div class="#err_newpass1#">
                <label for="password1">
                  <abbr title="#language.required#" class="required">*</abbr>&nbsp;#language.Password#:<br />
                  <small>(min. 8 #language.characters#)</small>
                </label>
                <input type="password" name="password1" id="password1" size="23" />
                <span class="form-text-inline">#error('password1')#</span>
              </div>

              <div class="#err_newpass2#">
                <label for="password2">
                  <abbr title="#language.required#" class="required">*</abbr>&nbsp;#language.RepeatPassword#:
                </label>
                <input type="password" name="password2" id="password2"  size="23" />
                <span class="form-text-inline">#error('password2')#</span>
              </div>

              <div class="#err_newemail#">
                <label for="email">
                  <abbr title="#language.required#" class="required">*</abbr>&nbsp;#language.Email#:
                </label>
                <input name="email" type="text" value="#variables.email#" size="40" maxlength="100" id="email" />
                <span class="form-text-inline">#error('email')#</span>
              </div>

              <input type="submit" value="#language.continue#" class="button button-accent" />
            </fieldset>
					</form>
				</cfoutput>
			<!-- CONTENT ENDS | FIN DU CONTENU -->

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
