<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Create New User"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Create New User</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	CompanyID, Name
	FROM 	Companies
	WHERE	Deleted = '0'
	ORDER BY CompanyID
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

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt; 
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			Create New User
			</cfoutput>
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

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				
				<cfif IsDefined("Session.Return_Structure")>
					<!--- Populate the Variables Structure with the Return Structure.
							Also display any errors returned --->
					<cfinclude template="#RootDir#includes/getStructure.cfm">
				</cfif>
				
				<cfif isDefined("url.companies")>
					<cfset Variables.action = "addNewUserCompany.cfm?lang=#lang#&companies=#url.companies#">
				<cfelse>
					<cfset Variables.action = "addNewUserCompany.cfm?lang=#lang#">
				</cfif>
				
				<cfform action="#Variables.action#" name="addUserForm" method="post">
					<table align="center">
						<tr>
							<td id="First"><label for="firstName">First Name:</label></td>
							<td headers="First"><cfinput name="firstName" id="firstName" type="text" value="#variables.firstName#" size="25" maxlength="40" required="yes" CLASS="textField" message="Please enter a first name." /></td>
						</tr>
						<tr>
							<td id="Last"><label for="lastname">Last Name:</label></td>
							<td headers="Last"><cfinput name="lastname" id="lastname" type="text" value="#variables.lastName#" size="25" maxlength="40" required="yes" CLASS="textField" message="Please enter a last name." /></td>
						</tr>
						<!---<tr>
							<td>Login Name:</td>
							<td><cfinput type="text" name="loginID" required="yes" size="25" maxlength="40" value="#variables.loginID#" /></td>
						</tr>--->
						<tr>
							<td id="Passworda"><label for="password1">Password:</label></td>
							<td headers="Passworda"><cfinput id="password1" type="password" name="password1" required="yes" size="25" maxlength="10" class="textField" message="Please enter a password."><span class="smallFont" />(*6 - 10 characters)</span></td>
						</tr>
						<tr>
							<td id="Passwordb"><label for="password2">Repeat Password:</label></td>
							<td headers="Passwordb"><cfinput id="password2" type="password" name="password2" required="yes" size="25" maxlength="10" class="textField" message="Please repeat the password for verification." /></td>
						</tr>
						<tr>
							<td id="mail"><label for="email">Email:</label></td>
							<td headers="mail"><cfinput name="email" id="email" type="text" value="#variables.email#" size="40" maxlength="100" required="yes" CLASS="textField" message="Please enter an email address." /></td>
						</tr>
						<tr>
							<td colspan="2" align="center" style="padding-top:20px;">
								<!--a href="javascript:document.addUserForm.submitForm.click();" class="textbutton">Submit</a-->
								<input type="submit" name="submitForm" value="Continue" class="textbutton" />
								<cfoutput><input type="button" name="submitForm" value="Cancel" class="textbutton" onClick="self.location.href='../menu.cfm?lang=#lang#'" />
							</td>
						</tr>
					</table>
				</cfform>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
