<cfinclude template="#RootDir#includes/companyInfoVariables.cfm">
<cfif lang EQ "eng">
	<cfset language.createUser = "Create New User">
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
	<cfset language.createUser = "Cr&eacute;er un nouvel utilisateur">
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
	<meta name=""dc.title"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.CreateUser#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.masterSubjects#"" />
	<title>#language.PWGSC#-#language.EsqGravingDockCaps#-#language.CreateUser#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfset Variables.onLoad = "javascript:document.addUserForm.firstname.focus();">

<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT CompanyID, Name FROM Companies WHERE Deleted = 0 ORDER BY CompanyID
</cfquery>
<cfparam name="variables.FirstName" default="">
<cfparam name="variables.LastName" default="">
<cfparam name="variables.email" default="">
<cfparam name="variables.companyID" default="#getCompanies.CompanyID#">
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
					<cfform action="#Variables.action#" id="addUserForm" method="post">
						<table align="center" style="width: 100%; padding-left:10px;">
							<tr>
								<td id="firstname_header"><label for="firstname">#language.FirstName#:</label></td>
								<td headers="firstname_header"><cfinput name="firstname" type="text" value="#variables.firstName#" size="23" maxlength="40" required="yes" id="firstname" message="#language.firstNameError#" /></td>
							</tr>
							<tr>
								<td id="lastname_header"><label for="lastname">#language.LastName#:</label></td>
								<td headers="lastname_header"><cfinput name="lastname" type="text" value="#variables.lastName#" size="23" maxlength="40" required="yes" id="lastname" message="#language.lastNameError#" /></td>
							</tr>
							<tr>
								<td id="password1_header"><label for="password1">#language.Password#:</label></td>
								<td headers="password1_header"><cfinput type="password" name="password1" id="password1" required="yes" size="23" maxlength="10" message="#language.password1Error#" />
									<span class="smallFont">(*6 - 10 #language.characters#)</span></td>
							</tr>
							<tr>
								<td id="password2_header"><label for="password2">#language.RepeatPassword#:</label></td>
								<td headers="password2_header"><cfinput type="password" name="password2" id="password2" required="yes" size="23" maxlength="10" message="#language.password2Error#" /></td>
							</tr>
							<tr>
								<td id="email_header"><label for="email">#language.Email#:</label></td>
								<td headers="email_header"><cfinput name="email" type="text" value="#variables.email#" size="40" maxlength="100" required="yes" id="email" message="#language.emailError#" /></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td colspan="2" align="center" style="padding-top:20px;"><!---a href="javascript:EditSubmit('addUserForm');" class="textbutton">Submit</a>
										<a href="ols-login.cfm?<cfoutput>lang=#lang#</cfoutput>" class="textbutton">Cancel</a--->
									<input type="submit" value="#language.continue#" class="textbutton" />
									<input type="button" value="#language.Cancel#" onclick="self.location.href='ols-login.cfm?<cfoutput>lang=#lang#</cfoutput>'" class="textbutton" />								</td>
							</tr>
						</table>
					</cfform>
				</cfoutput>
			</div>
			<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
