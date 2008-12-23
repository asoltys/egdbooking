<!---error checking for adding a company--->
<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif isDefined("form.CID") AND form.CID EQ "">
	<cfoutput>#ArrayAppend(Variables.Errors, "Please select a company.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation addtoken="no" url="addNewUserCompany.cfm?lang=#lang#&info=#url.info#&companies=#url.companies#">
</cfif>

<!---error checking for new profile info--->
<cfif isDefined("form.Password2")>
	<cfset Variables.Errors = ArrayNew(1)>
	<cfset Proceed_OK = "Yes">

	<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT 	Email
		FROM	Users
		WHERE 	EMail = '#trim(form.Email)#'
		AND		Deleted = '0'
	</cfquery>

	<cfif getUser.RecordCount GT 0>
		<cfoutput>#ArrayAppend(Variables.Errors, "The e-mail address already exists in the system, please try another.")#</cfoutput>
		<cfset Proceed_OK = "No">
	</cfif>

	<CFIF trim(form.firstname) eq ''>
		<cfoutput>#ArrayAppend(Variables.Errors, "Please enter a first name.")#</cfoutput>
		<cfset Proceed_OK = "No">
	</CFIF>

	<CFIF trim(form.lastname) eq ''>
		<cfoutput>#ArrayAppend(Variables.Errors, "Please enter a lastname.")#</cfoutput>
		<cfset Proceed_OK = "No">
	</CFIF>

	<cfif Len(Form.Password1) LT 6>
		<cfoutput>#ArrayAppend(Variables.Errors, "The password must be at least 6 characters.")#</cfoutput>
		<cfset Proceed_OK = "No">
	<cfelseif Form.Password1 NEQ Form.Password2>
		<cfoutput>#ArrayAppend(Variables.Errors, "Passwords do not match, please retype.")#</cfoutput>
		<cfset Proceed_OK = "No">
	</cfif>

	<cfif NOT REFindNoCase("^([a-zA-Z_\.\-\']*[a-zA-Z0-9_\.\-\'])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9])+$",#trim(Form.Email)#)>
		<cfoutput>#ArrayAppend(Variables.Errors, "Please check that the email address is valid.")#</cfoutput>
		<cfset Proceed_OK = "No">
	</cfif>

	<cfif isDefined("url.companies")>
		<cfset Variables.action = "adduser.cfm?lang=#lang#&companies=#url.companies#">
	<cfelse>
		<cfset Variables.action = "adduser.cfm?lang=#lang#">
	</cfif>

	<cfif Proceed_OK EQ "No">
		<cfinclude template="#RootDir#includes/build_return_struct.cfm">
		<cfset Session.Return_Structure.Errors = Variables.Errors>
		<cflocation url="#Variables.action#" addtoken="no">
	</cfif>
</cfif>

<cfif isDefined("form.CID") OR isDefined("form.firstname")>
	<cfset StructDelete(Session, "Form_Structure")>
	<cfinclude template="#RootDir#includes/build_form_struct.cfm">
</cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Create New User"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Create New User</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Companies.CID, Name
	FROM 	Companies
	WHERE 	Companies.Deleted = '0'
	ORDER BY Companies.Name
</cfquery>

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

				<!---decrpyt user info--->
				<cfif isDefined("url.info")><cfset Variables.userInfo = cfusion_decrypt(ToString(ToBinary(URLDecode(url.info))), "boingfoip")></cfif>

				<!---store user info--->
				<cfif isDefined("url.info")><cfset Variables.firstname = ListGetAt(userInfo, 1)><cfelseif isDefined("form.firstname")><cfset Variables.firstname = form.firstname></cfif>
				<cfif isDefined("url.info")><cfset Variables.lastname = ListGetAt(userInfo, 2)><cfelseif isDefined("form.lastname")><cfset Variables.lastname = form.lastname></cfif>
				<cfif isDefined("url.info")><cfset Variables.email = ListGetAt(userInfo, 3)><cfelseif isDefined("form.email")><cfset Variables.email = form.email></cfif>
				<cfif isDefined("url.info")><cfset Variables.password1 = ListGetAt(userInfo, 4)><cfelseif isDefined("form.password1")><cfset Variables.password1 = form.password1></cfif>

				<!---encrypt user info--->
				<cfset Variables.userInfo = ArrayToList(ArrayNew(1))>
				<cfset Variables.userInfo = ListAppend(Variables.userInfo, Variables.firstname)>
				<cfset Variables.userInfo = ListAppend(Variables.userInfo, Variables.lastname)>
				<cfset Variables.userInfo = ListAppend(Variables.userInfo, Variables.email)>
				<cfset Variables.userInfo = ListAppend(Variables.userInfo, Variables.password1)>
				<cfset Variables.info = URLEncodedFormat(ToBase64(cfusion_encrypt(Variables.userInfo, "boingfoip")))>

				<cfinclude template="#RootDir#includes/getStructure.cfm">

				<table style="width:85%;">
						<tr>
							<td colspan="2">Requested companies: </td>
						</tr>
					<cfif NOT isDefined("url.companies")>
						<tr>
							<td style="width:8%;">&nbsp;</td><td>No Companies</td>
						</tr>
						<cfset companyList = ArrayToList(ArrayNew(1))>
					<cfelse>
						<cfif Len(url.companies) EQ 0>
							<cfset companyList = url.companies>
						<cfelse>
							<cfset companyList = cfusion_decrypt(ToString(ToBinary(URLDecode(url.companies))), "shanisnumber1")>
						</cfif>
						<cfif isDefined("form.CID")>
							<cfif ListFind(companyList, "#form.CID#") EQ 0>
								<cfset companyList = ListAppend(companyList, "#form.CID#")>
							</cfif>
						</cfif>

						<cfif Len(companyList) EQ 0>
							<tr>
								<td style="width:8%;">&nbsp;</td><td>No Companies</td>
							</tr>
						</cfif>

						<cfset counter = 1>
						<cfloop index = "ID" list = "#companyList#">
							<cfif Len(companyList) EQ 0>
								<cfset companies = companyList>
							<cfelse>
								<cfset companies = URLEncodedFormat(ToBase64(cfusion_encrypt(companyList, "shanisnumber1")))>
							</cfif>

							<form method="post" action="removeNewUserCompany_confirm.cfm?lang=#lang#&companies=#companies#&info=#Variables.info#" name="remCompany#ID#">
								<input type="hidden" name="CID" value="#ID#" />
							</form>

							<cfset detailsID = "companyDetails#ID#">
							<cfquery name="detailsID" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
								SELECT	Name, Approved
								FROM	Companies
								WHERE	CID = '#ID#'
							</cfquery>
							<tr>
								<td style="width:8%;">&nbsp;</td><td>#detailsID.Name#</td>
								<td align="left" valign="top" style="width:55%;"><a href="javascript:EditSubmit('remCompany#ID#');" class="textbutton">Remove</a>
								<cfif detailsID.approved EQ 0>&nbsp;<i>awaiting approval</i></cfif></td>
							</tr>
							<cfset counter = counter + 1>
						</cfloop>
					</cfif>
				</table><br />

				<cfif Len(companyList) EQ 0>
					<cfset companies = companyList>
				<cfelse>
					<cfset companies = URLEncodedFormat(ToBase64(cfusion_encrypt(companyList, "shanisnumber1")))>
				</cfif>

				<cfform action="addNewUserCompany.cfm?lang=#lang#&companies=#companies#&info=#Variables.info#" id="addUserCompanyForm" method="post">
				<table style="width:88%;">
					<tr>
						<td valign="top"><label for="companies">Add Company:</label></td>
						<td>
							<cfselect name="CID" id="companies" required="yes" message="Please select a company.">
								<option value="">(Please select a company)
								<cfloop query="getCompanies">
									<cfif ListFind(companyList, "#CID#") EQ 0>
										<option value="#CID#">#Name#
									</cfif>
								</cfloop>
							</cfselect>
							<input type="submit" name="submitCompany" value="Add" class="textbutton" />
							<font size="-2">If the desired company is not listed, click <a href="addCompany.cfm?lang=#lang#&info=#Variables.info#&companies=#companies#">here</a> to create one.</font>
						</td>
					</tr>
				</table>
				</cfform>

				<br /><div style="text-align:center;"><cfoutput><input type="button" value="Done" onclick="self.location.href='#RootDir#admin/Users/editUser.cfm?lang=#lang#&UID=#url.UID#'" class="textbutton" /></cfoutput>

				<cfform id="newUserForm" action="addUser_action.cfm?lang=#lang#&info=#Variables.info#">
					<input type="hidden" name="firstname" value="#Variables.firstname#" />
					<input type="hidden" name="lastname" value="#Variables.lastname#" />
					<input type="hidden" name="email" value="#Variables.email#" />
					<input type="hidden" name="password1" value="#Variables.password1#" />
					<input type="hidden" name="companies" value="#companies#" />
					<br /><div style="text-align:right;"><input type="submit" onclick="javascript:EditSubmit('newUserForm');" value="Submit New User" class="textbutton" />
					<input type="button" onclick="javascript:self.location.href='addUser.cfm?lang=#lang#&info=#Variables.info#&companies=#companies#'" value="Edit Profile" class="textbutton" />
					<input type="button" onclick="javascript:self.location.href='../menu.cfm?lang=#lang#'" value="Cancel" class="textbutton" />
				</cfform>

				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
