<cfif lang EQ "eng">
	<cfset language.editProfile = "Edit Profile">
	<cfset language.editNameAndEmail = "Change name or email address">
	<cfset language.keywords = language.masterKeywords & ", Edit Profile">
	<cfset language.description = "Allows user to edit his profile.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.firstName = "First Name">
	<cfset language.lastName = "Last Name">
	<cfset language.email = "Email">
	<cfset language.remove = "Remove">
	<cfset language.awaitingApproval = "awaiting approval">
	<cfset language.addCompany = "Add Company">
	<cfset language.createCompany = "If the desired company is not listed, click <a href='addCompany.cfm?lang=#lang#'>here</a> to create one.">
	<cfset language.password = "Password">
	<cfset language.changePassword = "Change Password">
	<cfset language.repeatPassword = "Repeat Password">
	<cfset language.add = "Add">
	<cfset language.characters = "characters">
	<cfset language.firstNameError = "Please enter your first name.">
	<cfset language.lastNameError = "Please enter your last name.">
	<cfset language.emailError = "Please enter your email.">
	<cfset language.password1Error = "Please enter your password.">
	<cfset language.password2Error = "Please repeat your password for verification.">
	<cfset language.selectCompany = "Please select a company.">
	<cfset language.saveName = "Save Changes">
	<cfset language.yourCompanies = "Your Companies">
	<cfset language.yourCompany = "Your Company">
<cfelse>
	<cfset language.editProfile = "Modifier le profil">
	<cfset language.editNameAndEmail = "Changement de nom ou courriel" />
	<cfset language.keywords = language.masterKeywords & ", Modifier le profil">
	<cfset language.description = "Permet &agrave; l'utilisateur de modifier son profil.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.firstName = "Pr&eacute;nom">
	<cfset language.lastName = "Nom de famille">
	<cfset language.email = "Courriel">
	<cfset language.remove = "Supprimer">
	<cfset language.awaitingApproval = "en attente d'approbation">
	<cfset language.addCompany = "Ajout d'une entreprise">
	<cfset language.createCompany = "Si l'entreprise recherch&eacute;e ne se trouve pas dans la liste, cliquez <a href='addCompany.cfm?lang=#lang#'>ici</a> pour en cr&eacute;er une.">
	<cfset language.password = "Mot de passe">
	<cfset language.changePassword = "Changement de mot de passe">
	<cfset language.repeatPassword = "Retaper le mot de passe">
	<cfset language.add = "Ajouter">
	<cfset language.characters = "caract&egrave;res">
	<cfset language.firstNameError = "Veuillez entrer votre pr&eacute;nom.">
	<cfset language.lastNameError = "Veuillez entrer votre nom de famille.">
	<cfset language.emailError = "Veuillez entrer votre email.">
	<cfset language.password1Error = "Veuillez entrer votre mot de passe.">
	<cfset language.password2Error = "Veuillez entrer de nouveau votre mot de passe aux fins de v&eacute;rification.">
	<cfset language.selectCompany = "Veuillez s&eacute;lectionner une entreprise.">
  <cfset language.saveName = "Sauvegarde des changements" />
	<cfset language.yourCompanies = "Vos entreprises">
	<cfset language.yourCompany = "Votre entreprise">
</cfif>

<!---clear form structure if clrfs is set--->
<cfif isDefined("url.clrfs")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""#language.EditProfile# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dcterms.subject"" content=""#language.subjects#"" />
	<title>#language.EditProfile# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfset request.title = language.EditProfile />
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT 	Companies.CID, Name
		FROM 	Companies
		WHERE 	Companies.Deleted = '0'
		AND		NOT EXISTS
				(	SELECT	UserCompanies.CID
					FROM	UserCompanies
					WHERE	UserCompanies.Deleted = '0'
					AND		UserCompanies.CID = Companies.CID
					AND		UserCompanies.UID = <cfqueryparam value="#Session.UID#" cfsqltype="cf_sql_integer" />
				)
		ORDER BY Companies.Name
	</cfquery>

	<cfquery name="getUserCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Name, UserCompanies.Approved, Companies.CID
		FROM	UserCompanies INNER JOIN Users ON UserCompanies.UID = Users.UID
				INNER JOIN Companies ON UserCompanies.CID = Companies.CID
		WHERE	Users.UID = <cfqueryparam value="#Session.UID#" cfsqltype="cf_sql_integer" /> AND UserCompanies.Deleted = 0
		ORDER BY UserCompanies.Approved DESC, Companies.Name
	</cfquery>

	<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT *
		FROM Users
		WHERE UID = <cfqueryparam value="#Session.UID#" cfsqltype="cf_sql_integer" />
	</cfquery>
</cflock>

<cfparam name="variables.FirstName" default="#getUser.FirstName#">
<cfparam name="variables.LastName" default="#getUser.LastName#">
<cfparam name="variables.email" default="#getUser.Email#">
<cfparam name="err_fname" default="">
<cfparam name="err_lname" default="">
<cfparam name="err_email" default="">
<cfparam name="err_pass1" default="">
<cfparam name="err_pass2" default="">

<!-- Start JavaScript Block -->
<script type="text/javascript">
/* <![CDATA[ */
function EditSubmit ( selectedform )
	{
	  document.forms[selectedform].submit();
	}
/* ]]> */
</script>
<!-- End JavaScript Block -->

				<h1 id="wb-cont"><cfoutput>#language.EditProfile#</cfoutput></h1>

		<cfif not error("firstname") EQ "">
            <cfset err_fname = "form-attention" />
        </cfif>
        <cfif not error("lastname") EQ "">
            <cfset err_lname = "form-attention" />
        </cfif>
        <cfif not error("email") EQ "">
            <cfset err_email = "form-attention" />
        </cfif>
        <cfif not error("password") EQ "">
            <cfset err_pass1 = "form-attention" />
        </cfif>
        <cfif not error("password2") EQ "">
            <cfset err_pass2 = "form-attention" />
        </cfif>

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">

				<cfif IsDefined("Session.Return_Structure")>
					<!--- Populate the Variables Structure with the Return Structure.
							Also display any errors returned --->
					<cfinclude template="#RootDir#includes/getStructure.cfm">
				</cfif>

				<cfoutput>
					<form action="#RootDir#reserve-book/profilmod-profileedit_action.cfm?lang=#lang#" id="editUserForm" method="post">
						<fieldset>
              <legend style="display: block; text-decoration: none; border: none;">#language.editNameAndEmail#</legend>
              <p>#language.requiredFields#</p>

							<div class="#err_fname#">
                <label for="firstname">
                  <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                  #language.FirstName#:
                </label>
                <input name="firstname" id="firstname" type="text" value="#variables.firstName#" size="25" maxlength="40"  />
                <span class="form-text-inline">#error('firstname')#</span>
							</div>

							<div class="#err_lname#">
                <label for="lastname">
                  <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                  #language.LastName#:
                </label>
                <input name="lastname" id="lastname" type="text" value="#variables.lastName#" size="25" maxlength="40"  />
                <span class="form-text-inline">#error('lastname')#</span>
							</div>


							<div class="#err_email#">
                <label for="email">
                  <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                  #language.Email#:
                </label>
                <input name="email" id="email" type="text" value="#variables.email#" size="25" maxlength="40"  />
                <span class="form-text-inline">#error('email')#</span>
							</div>
							
              <div>
                <input type="submit" class="button button-accent" name="submitForm" value="#language.saveName#" />
              </div>
						</fieldset>
					</form>
				</cfoutput>

				<cfoutput>
					<form action="#RootDir#reserve-book/passechange.cfm?lang=eng" method="post" id="changePassForm">
						<fieldset>
              <legend style="display: block; text-decoration: none; border: none;">#language.ChangePassword#</legend>
              <p>#language.requiredFields#</p>

							<div class="#err_pass1#">
                <label for="password">
                  <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                  #language.Password# 
                  <span class="smallFont">(min. 8 #language.characters#)</span>:
                </label>
                <input type="password" id="password" name="password1" />
                <span class="form-text-inline">#error('password')#</span>
							</div>

							<div class="#err_pass2#">
                <label for="password2">
                  <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                  #language.RepeatPassword#:
                </label>
                <input type="password" id="password2" name="password2" />
                <span class="form-text-inline">#error('password2')#</span>
							</div>

              <div>
                <input type="submit" class="button button-accent" name="submitForm" value="#language.ChangePassword#" />
              </div>
						</fieldset>
					</form>
				</cfoutput>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

