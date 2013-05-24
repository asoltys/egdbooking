<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/build_form_struct.cfm">

<cfif lang EQ "eng">
	<cfset language.noCompaniesError = "You must select at least one company.">
	<cfset language.firstNameError = "Please enter your first name.">
	<cfset language.lastNameError = "Please enter your last name.">
	<cfset language.mismatchedPassError = "Your passwords do not match.">
	<cfset language.pass1ShortError = "Your password must be at least 8 characters.">
<cfelse>
	<cfset language.noCompaniesError = "Vous devez choisir au moins une entreprise.">
	<cfset language.firstNameError = "Veuillez entrer votre pr&eacute;nom.">
	<cfset language.lastNameError = "Veuillez entrer votre nom de famille.">
	<cfset language.mismatchedPassError = "Votre mot de passe ne correspond pas &agrave; votre adresse de courriel.">
	<cfset language.pass1ShortError = "Votre mot de passe doit &ecirc;tre compos&eacute; d'au moins huit caract&egrave;res.">
</cfif>

<cfif Len(form.companies) EQ 0>
	<cfset companyList = form.companies>
<cfelse>
	<cfset companyList = cfusion_decrypt(ToString(ToBinary(URLDecode(form.companies))), "shanisnumber1")>
</cfif>

<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif Len(companyList) EQ 0>
  <cfset session['errors']['email'] = language.noCompaniesError />
	<cfset Proceed_OK = "No">
</cfif>



<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="entrpdemande-comprequest.cfm?lang=#lang#&info=#url.info#" addtoken="no">
</cfif>

<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Email
	FROM	Users
	WHERE 	EMail = <cfqueryparam value="#trim(form.Email)#" cfsqltype="cf_sql_varchar" />
	AND		Deleted = '0'
</cfquery>
	
<cfif getUser.recordcount EQ 0>
	<cfscript>
		jbClass = ArrayNew(1);
		jbClass[1] = "#FileDir#lib/jBCrypt-0.3";
    javaloader = createObject('component','lib.javaloader.JavaLoader');
		javaloader.init(jbClass);

		bcrypt = javaloader.create("BCrypt");
		hashed = bcrypt.hashpw(trim(form.password1), bcrypt.gensalt());
	</cfscript>

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
				<cfqueryparam value="#trim(form.firstname)#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#trim(form.lastname)#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#hashed#" cfsqltype="cf_sql_varchar" />,
				<cfqueryparam value="#trim(form.email)#" cfsqltype="cf_sql_varchar" />,
				0
			)
		</cfquery>
		
		<cfquery name="getID2" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT UID
			FROM Users
			WHERE EMail = <cfqueryparam value="#trim(form.email)#" cfsqltype="cf_sql_varchar" />
			AND Deleted = 0 <!--- Joao Edit --->
		</cfquery>

		<cfloop list="#companyList#" index="CID">
			<cfquery name="getRelationship" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				SELECT	*
				FROM	UserCompanies
				WHERE	UID = <cfqueryparam value="#getID2.UID#" cfsqltype="cf_sql_integer" /> AND CID = <cfqueryparam value="#CID#" cfsqltype="cf_sql_integer" /> AND Deleted = 0
			</cfquery>
			
			<cfif getRelationship.recordCount EQ 0>
				<cfquery name="companyRequests" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					INSERT INTO	UserCompanies(UID, CID)
					VALUES		(<cfqueryparam value="#getID2.UID#" cfsqltype="cf_sql_integer" />, <cfqueryparam value="#CID#" cfsqltype="cf_sql_integer" />)
				</cfquery>
			</cfif>
		</cfloop>
	</cftransaction>
	
<cfoutput>
<cfif ServerType EQ "Development">
<cfset Variables.AdminEmail = DevEmail />
</cfif>
	<cfmail to="#Variables.AdminEmail#" from="#form.Email#" subject="New User" type="html" username="#mailuser#" password="#mailpassword#">
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
	<meta name=""dcterms.title"" content=""#language.title# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dcterms.subject"" content=""#language.masterSubjects#"" />
	<title>#language.title# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1 id="wb-cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.title#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</h1>
				<cfoutput>
					<p>#language.message#</p>
					<div>
						<br />#language.Username#: #form.email#<br />#language.Password#: #form.password1#
					</div>
					
					<br /><br />	
					<div><a href="ols-login.cfm?lang=#lang#" class="textbutton">#language.login#</a></div>
				</cfoutput>
			</div>
			<!-- CONTENT ENDS | FIN DU CONTENU -->
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
