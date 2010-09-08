<cfif isDefined("form.companies")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfif Len(form.companies) EQ 0>
	<cfset companyList = form.companies>
<cfelse>
	<cfset companyList = cfusion_decrypt(ToString(ToBinary(URLDecode(form.companies))), "shanisnumber1")>
</cfif>


<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif Len(companyList) EQ 0>
	<cfoutput>#ArrayAppend(Variables.Errors, "You must select at least one company.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>
<!---checked at addNewUserCompany page
<CFIF trim(form.firstname) eq ''>
	<cfoutput>#ArrayAppend(Variables.Errors, "Please enter a first name.")#</cfoutput>
	<cfset Proceed_OK = "No">
</CFIF>

<CFIF trim(form.lastname) eq ''>
	<cfoutput>#ArrayAppend(Variables.Errors, "Please enter a lastname.")#</cfoutput>
	<cfset Proceed_OK = "No">
</CFIF>


<CFIF len(trim(form.password1)) LT 6 OR len(trim(form.password2)) GT 10>
	<cfoutput>#ArrayAppend(Variables.Errors, "Your password must be between 6 to 10 characters long.")#</cfoutput>
	<cfset Proceed_OK = "No">
<CFELSEIF trim(form.password1) neq trim(form.password2)>
	<cfoutput>#ArrayAppend(Variables.Errors, "Your passwords do not match.")#</cfoutput>
	<cfset Proceed_OK = "No">
</CFIF>--->

<cfif isDefined("url.info")>
	<cfset variables.location = "addNewUserCompany.cfm?lang=#lang#&info=#url.info#">
<cfelse>
	<cfset variables.location = "addNewUserCompany.cfm?lang=#lang#">
</cfif>

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="#variables.location#" addtoken="no">
</cfif>

<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Deleted
	FROM Users
	WHERE EMail = '#trim(form.Email)#' AND Deleted = 0
</cfquery>


<!---<cfif getUser.recordcount GT 0 AND getUser.deleted EQ 1>
	<cftransaction>
		<cfquery name="reviveUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			UPDATE Users
			SET
				FirstName = '#trim(form.firstname)#',
				LastName = '#trim(form.lastname)#',
				Password = '#trim(form.password1)#',
				Deleted = 0
			WHERE Email = '#trim(form.Email)#'
		</cfquery>
	
		<cfquery name="getID" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT UID
			FROM Users
			WHERE EMail = '#trim(form.Email)#'
		</cfquery>
		
		<cfloop list="#companyList#" index="CID">
			<cfquery name="companyRequests" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				INSERT INTO	UserCompanies(UID, CID)
				VALUES		(#getID.UID#, #CID#)
			</cfquery>
		</cfloop>
	</cftransaction>
	
<cfoutput>
	<cfmail to="#form.Email#" from="#Variables.AdminEmail#" subject="Account Reactivated for EGD" type="html">
<p>#form.firstname# #form.lastname#,</p>
<p>Your account for the Esquimalt Graving Dock Online Booking System has been reactivated.</p>
<p>Username: #form.email#<br />Password: #form.password1#</p>
<p>Esquimalt Graving Dock</p>
<br />	
<p>#form.firstname# #form.lastname#,</p>
<p>buncha french stuff</p>
<p>Username: #form.email#<br />Password: #form.password1#</p>
<p>Cale s&egrave;che d'Esquimalt</p>
	</cfmail>
</cfoutput>

	<!---<cflocation addtoken="no" url="addNewUserCompany.cfm?UID=#getID.UID#">--->--->
	
<cfif getUser.recordcount EQ 0>
	<cftransaction>
		<cfquery name="insertNewUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			INSERT INTO Users
			(
				FirstName,
				LastName,
				Password,
				Email,
				Deleted
			)
			
			VALUES
			(
				'#trim(form.firstname)#',
				'#trim(form.lastname)#',
				'#trim(form.password1)#',
				'#trim(form.email)#',
				0
			)
		</cfquery>
	
		<cfquery name="getID2" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT UID
			FROM Users
			WHERE EMail = '#trim(form.Email)#'
		</cfquery>
		
		<cfloop list="#companyList#" index="CID">
			<cfquery name="getRelationship" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				SELECT	*
				FROM	UserCompanies
				WHERE	UID = #getID2.UID# AND CID = #CID# AND Deleted = 0
			</cfquery>
			
			<cfif getRelationship.recordCount EQ 0>
				<cfquery name="companyRequests" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					INSERT INTO	UserCompanies(UID, CID, Approved)
					VALUES		(#getID2.UID#, #CID#, 1)
				</cfquery>
			</cfif>
		</cfloop>
	</cftransaction>
	

	
<cflock throwontimeout="no" scope="session" timeout="30" type="readonly">
	<cfquery name="getAdmin" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Email
		FROM	Users
		WHERE	UID = '#session.UID#'
	</cfquery>
</cflock>
	
<cfoutput>
	<cfmail to="#form.Email#" from="#Session.AdminEmail#" subject="Account Created for EGD - Compte cr&eacute;e pour la CSE" type="html">
<p>#form.firstname# #form.lastname#,</p>
<p>An account has been created for you for the Esquimalt Graving Dock Online Booking System.</p>
<p>Username: #form.email#<br />Password: #form.password1#</p>
<p>Esquimalt Graving Dock</p>
<br />
<p>Un compte a &eacute;t&eacute; cr&eacute;&eacute; pour vous dans le syst&egrave;me de r&eacute;servation en ligne de la cale s&egrave;che d'Esquimalt.</p>
<p>Nom d'utilisateur: #form.email#<br />Mot de passe: #form.password1#</p>
<p>Cale s&egrave;che d'Esquimalt</p>
	</cfmail>
</cfoutput>
	
	<!---<cflocation addtoken="no" url="addNewUserCompany.cfm?UID=#getID2.UID#">--->
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Create New User"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Create New User</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt; 
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			Create New User</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Create New User
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<cfoutput>
				<p>You have successfully created a new account for #form.firstname# #form.lastname#.  Email notification has been sent to the user.</p>
					
				<div style="text-align:center;"><a href="../menu.cfm?lang=#lang#" class="textbutton">Return to Main Menu</a></div>
				</cfoutput>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
