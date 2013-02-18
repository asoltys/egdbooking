<cfif isDefined("form.UID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit User"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit User</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfquery name="getUserList" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT UID, LastName + ', ' + FirstName AS UserName, ReadOnly
	FROM Users
	WHERE Deleted = 0
	ORDER BY LastName
</cfquery>

<cfparam name="form.UID" default="#session.UID#">
<cfif isDefined("url.UID")>
	<cfset form.UID = #url.UID#>
</cfif>


<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Companies.CID, Name
	FROM 	Companies
	WHERE 	Companies.Deleted = '0'
	AND		NOT EXISTS
			(	SELECT	UserCompanies.CID
				FROM	UserCompanies
				WHERE	UserCompanies.Deleted = '0'
				AND		UserCompanies.CID = Companies.CID
				AND		UserCompanies.UID = <cfqueryparam value="#form.UID#" cfsqltype="cf_sql_integer" />
			)
	ORDER BY Companies.Name
</cfquery>

<!---<cfparam name="url.UID" default="#form.UID#">
<cfif isDefined("form.UID")>
	<cfset url.UID = #form.UID#>
</cfif>--->

<cfquery name="getUserCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Name, UserCompanies.Approved, Companies.CID
	FROM	UserCompanies INNER JOIN Users ON UserCompanies.UID = Users.UID
			INNER JOIN Companies ON UserCompanies.CID = Companies.CID
	WHERE	Users.UID = <cfqueryparam value="#form.UID#" cfsqltype="cf_sql_integer" /> AND UserCompanies.Deleted = 0
	ORDER BY UserCompanies.Approved DESC, Companies.Name
</cfquery>

<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT *
	FROM Users
	WHERE UID = <cfqueryparam value="#form.UID#" cfsqltype="cf_sql_integer" />
</cfquery>


<cfparam name="variables.ReadOnly" default="#getUser.ReadOnly#">
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
		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt;
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			Edit User Profile</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Edit User Profile
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<cfif IsDefined("Session.Return_Structure")>
					<!--- Populate the Variables Structure with the Return Structure.
							Also display any errors returned --->
					<cfinclude template="#RootDir#includes/getStructure.cfm"><br />
				</cfif>

				<div style="text-align:left;">
					<cfform action="editUser.cfm?lang=#lang#" id="chooseUserForm" method="post">
						<cfselect name="UID" query="getUserList" value="UID" display="UserName" selected="#form.UID#" />
						<!--a href="javascript:EditSubmit('chooseUserForm');" class="textbutton">Edit</a-->
						<input type="submit" name="submitForm" value="View" class="textbutton" />
					</cfform>
				</div>

				<cfform action="editUser_action.cfm?lang=#lang#" id="editUserForm" method="post">
					<table style="width:81%;">
						<tr>
							<td colspan="2"><strong>Edit Profile:</strong></td>
						</tr>
						<tr>
							<td id="First"><label for="firstname">First Name:</label></td>
							<td headers="First"><cfinput name="firstname" type="text" value="#variables.firstName#" size="25" maxlength="40" required="yes" id="firstName" message="Please enter a first name." /></td>
						</tr>
						<tr>
							<td id="Last"><label for="lastName">Last Name:</label></td>
							<td headers="Last"><cfinput name="lastname" type="text" value="#variables.lastName#" size="25" maxlength="40" required="yes" id="lastName" message="Please enter a last name." /></td>
						</tr>
						<tr>
							<td id="Email">Read Only:</td>
							<cfif #variables.ReadOnly# NEQ "1">
							<td headers="ReadOnly"><cfinput type="radio" name="ReadOnly" value="0" checked>No<cfinput type="radio" name="ReadOnly" value="1" />Yes
							<cfelse>
							<td headers="ReadOnly"><cfinput type="radio" name="ReadOnly" value="0" />No<cfinput type="radio" name="ReadOnly" value="1" checked="true" />Yes
							</cfif>
							</td>
						</tr>
						<tr>
							<td id="Email">Email:</td>
							
							<td headers="Email"><cfinput name="email" type="text" value="#variables.email#" size="25" maxlength="40" required="yes" id="email" /></td>
							
							<!---<td headers="Email"><cfoutput>#variables.email#</cfoutput></td>--->
							
							
							
						</tr>
						<tr>
							<td colspan="2" align="center">
								<!--a href="javascript:document.editUserForm.submitForm.click();" class="textbutton">Submit</a-->
								<cfif isDefined("form.UID")><cfoutput><input type="hidden" name="UID" value="#form.UID#" /></cfoutput></cfif>
								<input type="submit" value="Save Profile Changes" class="textbutton" />
							</td>
						</tr>
						</table>
				</cfform>

				<hr width="65%" align="center">

				<cfoutput query="getUserCompanies">
					<form method="post" action="removeUserCompany_confirm.cfm?lang=#lang#" name="remCompany#CID#">
						<input type="hidden" name="CID" value="#CID#" />
						<input type="hidden" name="UID" value="#form.UID#" />
					</form>
				</cfoutput>

				<table style="width:81%;">
				<tr>
					<cfoutput><td valign="top"colspan="2"><cfif getUserCompanies.recordCount GT 1><strong>User Companies:</strong><cfelse><strong>User Company:</strong></cfif></td></cfoutput>
				</tr>
				<cfoutput query="getUserCompanies">
					<tr>
						<td id="#name#">&nbsp;</td><td style="width:50%;" valign="top">#name#</td>
						<td headers="#name#" align="right" valign="top" style="width:20%;"><cfif getUserCompanies.recordCount GT 1><a href="javascript:EditSubmit('remCompany#CID#');" class="textbutton">Remove</a></cfif></td>
						<td headers="#name#" align="right" valign="top" style="width:30%;"><cfif approved EQ 0><i>awaiting approval</i><cfelse>&nbsp;</cfif></td>
					</tr>
				</cfoutput>
				</table>

				<cfform action="addUserCompany_action.cfm?lang=#lang#" id="addUserCompanyForm" method="post">
					<table style="width:81%;">
						<tr><td>&nbsp;</td></tr>
						<tr>
							<td colspan="2"><label for="companySelect">Add Company:</label></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td colspan="3">
								<cfselect name="CID" id="companySelect" required="yes" message="Please select a company.">
									<option value="">(Please select a company)
									<cfloop query="getCompanies">
										<cfoutput><option value="#CID#">#Name#</cfoutput>
									</cfloop>
								</cfselect>
								<input type="submit" name="submitForm" value="Add" class="textbutton" />
								<cfoutput><input type="hidden" name="UID" value="#form.UID#" /></cfoutput>
								<br />
								<cfoutput><font size="-2">If the desired company is not listed, click <a href="editUser_addCompany.cfm?lang=#lang#&UID=#form.UID#">here</a> to create one.</font></cfoutput>
							</td>
						</tr>
					</table>
				</cfform>

				<hr width="65%" align="center"><br />

				<cfform action="changePassword.cfm?lang=#lang#" method="post" id="changePassForm">
						<table style="width:81%;">
						<tr>
							<td colspan="2"><strong>Change Password:</strong></td>
						</tr>
						<tr>
							<td id="Password"><label for="pass">Password <span class="smallFont">(*min. 8 characters)</span>:</label></td>
							<td headers="Password"><cfinput type="password" id="pass" name="password1" required="yes" size="25" message="Please enter a password." /></td>
						</tr>
						<tr>
							<td id="Repeat"><label for="repeatPass">Repeat Password:</label></td>
							<td headers="Repeat"><cfinput type="password" id="repeatPass" name="password2" required="yes" size="25" message="Please repeat the password for verification." /></td>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<input type="submit" value="Change Password" class="textbutton" />
								<cfoutput><input type="hidden" name="UID" value="#form.UID#" /></cfoutput>
								<input type="button" value="Cancel" class="button" onclick="javascript:location.href='#RootDir#reserve-book-e.cfm'" />
							</td>
						</tr>
					</table>
					<br />
					<div style="text-align:right;"><cfoutput><a href="../menu.cfm?lang=#lang#" class="textbutton">Cancel</a></cfoutput>
				</cfform>

				<p><em>*Email notification of profile updates is automatically sent to the user after their password is changed or a company is added to their profile.</em></p>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
