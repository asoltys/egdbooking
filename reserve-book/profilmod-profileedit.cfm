<cfif lang EQ "eng">
	<cfset language.editProfile = "Edit Profile">
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
	<cfset language.password1Error = "Please enter your password.">
	<cfset language.password2Error = "Please repeat your password for verification.">
	<cfset language.selectCompany = "Please select a company.">
	<cfset language.saveName = "Save Name Changes">
	<cfset language.yourCompanies = "Your Companies">
	<cfset language.yourCompany = "Your Company">
<cfelse>
	<cfset language.editProfile = "Modifier le profil">
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
	<cfset language.password1Error = "Veuillez entrer votre mot de passe.">
	<cfset language.password2Error = "Veuillez entrer de nouveau votre mot de passe aux fins de v&eacute;rification.">
	<cfset language.selectCompany = "Veuillez s&eacute;lectionner une entreprise.">
	<cfset language.saveName = "Sauvegarde des changements de nom">
	<cfset language.yourCompanies = "Vos entreprises">
	<cfset language.yourCompany = "Votre entreprise">
</cfif>

<!---clear form structure if clrfs is set--->
<cfif isDefined("url.clrfs")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.EditProfile#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.EditProfile#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT 	Companies.CompanyID, Name
		FROM 	Companies
		WHERE 	Companies.Deleted = '0'
		AND		NOT EXISTS
				(	SELECT	UserCompanies.CompanyID
					FROM	UserCompanies
					WHERE	UserCompanies.Deleted = '0'
					AND		UserCompanies.CompanyID = Companies.CompanyID
					AND		UserCompanies.UserID = '#Session.UserID#'
				)
		ORDER BY Companies.Name
	</cfquery>

	<cfquery name="getUserCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Name, UserCompanies.Approved, Companies.CompanyID
		FROM	UserCompanies INNER JOIN Users ON UserCompanies.UserID = Users.UserID
				INNER JOIN Companies ON UserCompanies.CompanyID = Companies.CompanyID
		WHERE	Users.UserID = '#session.UserID#' AND UserCompanies.Deleted = 0
		ORDER BY UserCompanies.Approved DESC, Companies.Name
	</cfquery>

	<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT *
		FROM Users
		WHERE UserID = #session.UserID#
	</cfquery>
</cflock>

<cfparam name="variables.FirstName" default="#getUser.FirstName#">
<cfparam name="variables.LastName" default="#getUser.LastName#">
<cfparam name="variables.email" default="#getUser.Email#">

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

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			<CFELSE>
				<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			</CFIF>
			#language.EditProfile#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.EditProfile#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">

				<cfif IsDefined("Session.Return_Structure")>
					<!--- Populate the Variables Structure with the Return Structure.
							Also display any errors returned --->
					<cfinclude template="#RootDir#includes/getStructure.cfm">
				</cfif>

				<cfoutput>
				<cfform action="#RootDir#reserve-book/profilmod-profileedit_action.cfm?lang=#lang#" id="editUserForm" method="post">
				<table align="center" style="width:81%;">
				<tr>
					<td colspan="2"><strong>#language.EditProfile#:</strong></td>
				</tr>
				<tr>
					<td id="first"><label for="firstName">#language.FirstName#:</label></td>
					<td headers="first"><cfinput name="firstname" type="text" value="#variables.firstName#" size="25" maxlength="40" required="yes" id="firstName" message="#language.firstNameError#" /></td>
				</tr>
				<tr>
					<td id="last"><label for="lastName">#language.LastName#:</label></td>
					<td headers="last"><cfinput name="lastname" type="text" value="#variables.lastName#" size="25" maxlength="40" required="yes" id="lastName" message="#language.lastNameError#" /></td>
				</tr>
				<tr>
					<td id="email">#language.Email#:</td>
					<td headers="email">#variables.email#</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit" name="submitForm" value="#language.saveName#" class="textbutton" />
				</tr>
				</table>
				</cfform>
				</cfoutput>

				<hr width="65%" align="center"><br />

				<table align="center" style="width:81%;">
				<tr>
					<cfoutput><td valign="top"colspan="2"><cfif getUserCompanies.recordCount GT 1><strong>#language.yourCompanies#:</strong><cfelse><strong>#language.yourCompany#:</strong></cfif></td></cfoutput>
				</tr>
				<cfoutput query="getUserCompanies">
					<tr>
						<td style="width:3%;">&nbsp;</td><td style="width:50%;" valign="top">#name#</td>
						<td align="right" valign="top" style="width:17%;">
							<form method="post" action="#RootDir#reserve-book/entrpsup-comprem_confirm.cfm?lang=#lang#" name="remCompany#CompanyID#" id="remCompany#CompanyID#">
								<input type="hidden" name="CompanyID" value="#CompanyID#" />
								<cfif getUserCompanies.recordCount GT 1>
									<a href="javascript:EditSubmit('remCompany#CompanyID#');" class="textbutton">#language.Remove#</a>
								</cfif>
							</form>
						</td>
						<td align="right" valign="top" style="width:30%;"><cfif approved EQ 0><em class="smallFont">#language.awaitingApproval#</em><cfelse>&nbsp;</cfif></td>
					</tr>
				</cfoutput>
				</table>

				<hr width="65%" align="center"><br />

				<cfoutput>
					<cfform action="#RootDir#reserve-book/passechange.cfm?lang=eng" method="post" id="changePassForm">
					<table align="center" style="width:81%;">
					<tr>
						<td colspan="2"><strong>#language.ChangePassword#:</strong></td>
					</tr>
					<tr>
						<td id="pass1"><label for="password">#language.Password# <span class="smallFont">(*6 - 10 #language.characters#)</span>:</label></td>
						<td headers="pass1"><cfinput type="password" id="password" name="password1" required="yes" size="25" maxlength="10" message="#language.password1Error#" /></td>
					</tr>
					<tr>
						<td id="pass2"><label for="password2">#language.RepeatPassword#:</label></td>
						<td headers="pass2"><cfinput type="password" id="password2" name="password2" required="yes" size="25" maxlength="10" message="#language.password2Error#" /></td>
					</tr>
					<tr>
						<td colspan="2" align="center"><input type="submit" name="submitForm" value="#language.ChangePassword#" class="textbutton" />
					</tr>
					</table>
					</cfform>
				</cfoutput>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

