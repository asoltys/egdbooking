<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/build_form_struct.cfm">

<cfif lang EQ "eng">
	<cfset language.noCompaniesError = "You must select at least one company.">
	<cfset language.firstNameError = "Please enter your first name.">
	<cfset language.lastNameError = "Please enter your last name.">
	<cfset language.mismatchedPassError = "Your passwords do not match.">
	<cfset language.pass1ShortError = "Your password must be at least 6 characters.">
<cfelse>
	<cfset language.noCompaniesError = "Vous devez choisir au moins une entreprise.">
	<cfset language.firstNameError = "Veuillez entrer votre pr&eacute;nom.">
	<cfset language.lastNameError = "Veuillez entrer votre nom de famille.">
	<cfset language.mismatchedPassError = "Votre mot de passe ne correspond pas &agrave; votre adresse de courriel.">
	<cfset language.pass1ShortError = "Votre mot de passe doit &ecirc;tre compos&eacute; d'au moins six caract&egrave;res.">
</cfif>

<cfif Len(form.companies) EQ 0>
	<cfset companyList = form.companies>
<cfelse>
	<cfset companyList = cfusion_decrypt(ToString(ToBinary(URLDecode(form.companies))), "shanisnumber1")>
</cfif>

<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif Len(companyList) EQ 0>
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.noCompaniesError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<!---<CFIF trim(form.firstname) eq ''>
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.firstNameError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</CFIF>

<CFIF trim(form.lastname) eq ''>
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.lastNameError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</CFIF>

<CFIF len(trim(form.password1)) LT 6>
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.pass1ShortError#")#</cfoutput>
	<cfset Proceed_OK = "No">
<CFELSEIF trim(form.password1) neq trim(form.password2)>
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.mismatchedPassError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</CFIF>--->

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="addUserCompanies.cfm?lang=#lang#&info=#url.info#" addtoken="no">
</cfif>

<!---<cfquery name="getDeletedUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Email
	FROM 	Users
	WHERE 	Email = '#trim(form.Email)#'
	AND 	Deleted = 1
</cfquery>--->

<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Email
	FROM	Users
	WHERE 	EMail = '#trim(form.Email)#'
	AND		Deleted = '0'
</cfquery>

<!---<cfif getDeletedUser.recordcount GT 0>
	<cftransaction>
		<cfquery name="reviveUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			UPDATE Users
			SET
				<!---LoginID = '#trim(form.loginID)#',--->
				FirstName = '#trim(form.firstname)#',
				LastName = '#trim(form.lastname)#',
				Password = '#trim(form.password1)#',
				Deleted = 0
			WHERE Email = '#trim(form.Email)#'
		</cfquery>
		
		<cfquery name="getID" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT 	UserID
			FROM 	Users
			WHERE 	EMail = '#trim(form.Email)#'
		</cfquery>
		
		<cfloop list="companyList" index="companyID">
			<cfquery name="companyRequests" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				INSERT INTO	UserCompanies(UserID, CompanyID)
				VALUES		(#getID.userID#, #companyID#)
			</cfquery>
		</cfloop>
	</cftransaction>
	
<cfoutput>
	<cfmail to="#Variables.AdminEmail#" from="#form.Email#" subject="Reactivating Account" type="html">
#form.firstname# #form.lastname#, has requested to reactivate his/her account.
	</cfmail>
</cfoutput>--->
	
<cfif getUser.recordcount EQ 0>
	<cftransaction>
		<cfquery name="insertNewUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			INSERT INTO Users
			(
				<!---LoginID,--->
				FirstName,
				LastName,
				Password,
				Email,
				Deleted
			)
			
			VALUES
			(
				<!---'#trim(form.loginID)#',--->
				'#trim(form.firstname)#',
				'#trim(form.lastname)#',
				'#trim(form.password1)#',
				'#trim(form.email)#',
				0
			)
		</cfquery>
		
		<cfquery name="getID2" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT UserID
			FROM Users
			WHERE EMail = '#trim(form.Email)#'
			AND Deleted = 0 <!--- Joao Edit --->
		</cfquery>

		<cfloop list="#companyList#" index="companyID">
			<cfquery name="getRelationship" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				SELECT	*
				FROM	UserCompanies
				WHERE	UserID = #getID2.userID# AND CompanyID = #companyID# AND Deleted = 0
			</cfquery>
			
			<cfif getRelationship.recordCount EQ 0>
				<cfquery name="companyRequests" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					INSERT INTO	UserCompanies(UserID, CompanyID)
					VALUES		(#getID2.userID#, #companyID#)
				</cfquery>
			</cfif>
		</cfloop>
	</cftransaction>
	
<cfoutput>
	<cfmail to="#Variables.AdminEmail#" from="#form.Email#" subject="New User" type="html">
<p>A new user, #form.firstname# #form.lastname#, has requested to create an account.</p>
	</cfmail>
</cfoutput>

</cfif>


<cfif lang EQ "eng">
	<cfset language.title = "Create New User">
	<cfset language.keywords = "#language.masterKeywords#" & " Add New User Account">
	<cfset language.description = "Notifies user that their account has been created successfully.">
	<cfset language.login = "Return to login">
	<cfset language.message = "You have successfully created a new account.  You will receive email confirmation when your account request has been approved.">
	<cfset language.username = "Username">
	<cfset language.password = "Password">
<cfelse>
	<cfset language.title = "Cr&eacute;er un nouvel utilisateur">
	<cfset language.keywords = "#language.masterKeywords#" & ", Ajout d'un nouveau compte d'utilisateur">
	<cfset language.description = "Avise l'utilisateur que son compte a &eacute;t&eacute; cr&eacute;&eacute;.">
	<cfset language.login = "Ouvrir la session">
	<cfset language.message = "Vous avez cr&eacute;&eacute; un nouveau compte. Vous recevrez une confirmation par courrier &eacute;lectronique lorsque votre demande de compte aura &eacute;t&eacute; approuv&eacute;e.">
	<cfset language.username = "Nom d'utilisateur">
	<cfset language.password = "Mot de passe">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""#language.PWGSC# - #language.esqGravingDockCaps# - #language.title#"">
	<meta name=""keywords"" lang=""eng"" content=""#language.keywords#"">
	<meta name=""description"" lang=""eng"" content=""#language.description#"">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""#language.masterSubjects#"">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>#language.PWGSC# - #language.esqGravingDockCaps# - #language.title#</title>">

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>
			<a href="#RootDir#text/login/login.cfm?lang=#lang#">#language.login#</a> &gt; 
			#language.title#
			</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<CFOUTPUT>#language.title#</CFOUTPUT>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>
				<cfoutput>
					<p>#language.message#</p>
					<div align="center">
						<br>#language.Username#: #form.email#<br>#language.Password#: #form.password1#
					</div>
					
					<br><br>	
					<div align="center"><a href="login.cfm?lang=#lang#" class="textbutton">#language.login#</a></div>
				</cfoutput>
			</div>
			<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
