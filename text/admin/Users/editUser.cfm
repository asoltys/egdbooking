<cfif isDefined("form.userID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit User"">
<meta name=""keywords"" lang=""eng"" content="""">
<meta name=""description"" lang=""eng"" content="""">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit User</title>">
<cfinclude template="#RootDir#includes/header-#lang#.cfm">

<cfquery name="getUserList" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT UserID, LastName + ', ' + FirstName AS UserName, ReadOnly
	FROM Users
	WHERE Deleted = 0
	ORDER BY LastName
</cfquery>

<cfparam name="form.userID" default="#session.userID#">
<cfif isDefined("url.userID")>
	<cfset form.userID = #url.userID#>
</cfif>


<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Companies.CompanyID, Name
	FROM 	Companies
	WHERE 	Companies.Deleted = '0'
	AND		NOT EXISTS
			(	SELECT	UserCompanies.CompanyID
				FROM	UserCompanies
				WHERE	UserCompanies.Deleted = '0'
				AND		UserCompanies.CompanyID = Companies.CompanyID
				AND		UserCompanies.UserID = '#form.UserID#'
			)
	ORDER BY Companies.Name
</cfquery>

<!---<cfparam name="url.userID" default="#form.userID#">
<cfif isDefined("form.UserID")>
	<cfset url.userID = #form.userID#>
</cfif>--->

<cfquery name="getUserCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Name, UserCompanies.Approved, Companies.CompanyID
	FROM	UserCompanies INNER JOIN Users ON UserCompanies.UserID = Users.UserID 
			INNER JOIN Companies ON UserCompanies.CompanyID = Companies.CompanyID
	WHERE	Users.UserID = #form.UserID# AND UserCompanies.Deleted = 0
	ORDER BY UserCompanies.Approved DESC, Companies.Name
</cfquery>

<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT *
	FROM Users
	WHERE UserID = #form.UserID#
</cfquery>


<cfparam name="variables.ReadOnly" default="#getUser.ReadOnly#">
<cfparam name="variables.FirstName" default="#getUser.FirstName#">
<cfparam name="variables.LastName" default="#getUser.LastName#">
<cfparam name="variables.email" default="#getUser.Email#">


<!-- Start JavaScript Block -->
<script language="JavaScript" type="text/javascript">
<!--
function EditSubmit ( selectedform )
{
  document.forms[selectedform].submit() ;
}
//-->
</script>

<div class="breadcrumbs">
	<a href="<cfoutput>http://www.pwgsc.gc.ca/text/home-#lang#.html</cfoutput>">PWGSC</a> &gt; 
	Pacific Region &gt; 
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-e.html">Esquimalt Graving Dock</a> &gt; 
  <CFOUTPUT>
		<a href="#RootDir#text/booking-#lang#.cfm">Booking</A> &gt;
		<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
			<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
		<CFELSE>
			 <a href="#RootDir#text/booking/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
		</CFIF>
	</CFOUTPUT>
	Edit User Profile
</div>

<div class="main">
<H1>Edit User Profile</H1>
<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>

<cfif IsDefined("Session.Return_Structure")>
	<!--- Populate the Variables Structure with the Return Structure.
			Also display any errors returned --->
	<cfinclude template="#RootDir#includes/getStructure.cfm"><br>
</cfif>

<div align="left">
	<cfform action="editUser.cfm?lang=#lang#" name="chooseUserForm" method="post">
		<cfselect name="UserID" query="getUserList" value="UserID" display="UserName" selected="#form.userID#" />
		<!--a href="javascript:EditSubmit('chooseUserForm');" class="textbutton">Edit</a-->
		<input type="submit" name="submitForm" value="View" class="textbutton">
	</cfform>
</div>

<cfform action="editUser_action.cfm?lang=#lang#" name="editUserForm" method="post">
	<table align="center" width="81%">
		<tr>
			<td colspan="2"><strong>Edit Profile:</strong></td>
		</tr>
		<tr>
			<td id="First"><label for="firstName">First Name:</label></td>
			<td headers="First"><cfinput name="firstname" type="text" value="#variables.firstName#" size="25" maxlength="40" required="yes" id="firstName" CLASS="textField" message="Please enter a first name."></td>
		</tr>
		<tr>
			<td id="Last"><label for="lastName">Last Name:</label></td>
			<td headers="Last"><cfinput name="lastname" type="text" value="#variables.lastName#" size="25" maxlength="40" required="yes" id="lastName" CLASS="textField" message="Please enter a last name."></td>
		</tr>
		<tr>
			<td id="Email">Read Only:</td>
			<cfif #variables.ReadOnly# NEQ "1">
			<td headers="ReadOnly"><cfinput type="radio" name="ReadOnly" value="0" checked>No<cfinput type="radio" name="ReadOnly" value="1">Yes
			<cfelse>
			<td headers="ReadOnly"><cfinput type="radio" name="ReadOnly" value="0">No<cfinput type="radio" name="ReadOnly" value="1" checked>Yes
			</cfif>
			</td>
		</tr>
		<tr>
			<td id="Email">Email:</td>
			<td headers="Email"><cfoutput>#variables.email#</cfoutput></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<!--a href="javascript:document.editUserForm.submitForm.click();" class="textbutton">Submit</a-->
				<!---<cfif isDefined("form.UserID")><cfoutput><input type="hidden" name="userId" value="#form.userID#"></cfoutput></cfif>--->
				<cfoutput><input type="hidden" name="userID" value="#form.userID#"></cfoutput>
				<input type="submit" value="Save Name Changes" class="textbutton">
			</td>
		</tr>
		</table>
</cfform>

<hr width="65%" align="center">

<cfoutput query="getUserCompanies">
	<form method="post" action="removeUserCompany_confirm.cfm?lang=#lang#" name="remCompany#CompanyID#">
		<input type="hidden" name="CompanyID" value="#CompanyID#">
		<input type="hidden" name="userID" value="#form.userID#">
	</form>
</cfoutput>

<table align="center" width="81%">
<tr>
	<cfoutput><td valign="top"colspan="2"><cfif getUserCompanies.recordCount GT 1><strong>User Companies:</strong><cfelse><strong>User Company:</strong></cfif></td></cfoutput>
</tr>
<cfoutput query="getUserCompanies">
	<tr>
		<td id="#name#">&nbsp;</td><td width="50%" valign="top">#name#</td>
		<td headers="#name#" align="right" valign="top" width="20%"><cfif getUserCompanies.recordCount GT 1><a href="javascript:EditSubmit('remCompany#CompanyID#');" class="textbutton">Remove</a></cfif></td>
		<td headers="#name#" style="font-size:10pt;" align="right" valign="top" width="30%"><cfif approved EQ 0><i>awaiting approval</i><cfelse>&nbsp;</cfif></td>
	</tr>
</cfoutput>
</table>

<cfform action="addUserCompany_action.cfm?lang=#lang#" name="addUserCompanyForm" method="post">
	<table align="center" width="81%">
		<tr><td>&nbsp;</td></tr>
		<tr>
			<td colspan="2"><label for="companySelect">Add Company:</label></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td colspan="3">
				<!---<cfselect name="companyID" id="companySelect" query="getCompanies" value="companyID" display="Name" />--->
				<cfselect name="companyID" id="companySelect" required="yes" message="Please select a company.">
					<option value="">(Please select a company)
					<cfloop query="getCompanies">
						<cfoutput><option value="#companyID#">#Name#</cfoutput>
					</cfloop>
				</cfselect>
				<!--a href="javascript:document.addUserCompanyForm.submitForm.click();" class="textbutton">Add</a>
				<br-->
				<input type="submit" name="submitForm" value="Add" class="textbutton">
				<cfoutput><input type="hidden" name="userID" value="#form.userID#"></cfoutput>
				<BR>
				<cfoutput><font size="-2">If the desired company is not listed, click <a href="editUser_addCompany.cfm?lang=#lang#&amp;userID=#form.userID#">here</a> to create one.</font></cfoutput>
			</td>
		</tr>	
	</table>
</cfform>

<hr width="65%" align="center"><br>

<cfform action="changePassword.cfm?lang=#lang#" method="post" name="changePassForm">
		<table align="center" width="81%">
		<tr>
			<td colspan="2"><strong>Change Password:</strong></td>
		</tr>
		<tr>
			<td id="Password"><label for="pass">Password <span style="font-size: 9pt;">(*6 - 10 characters)</span>:</label></td>
			<td headers="Password"><cfinput type="password" id="pass" name="password1" required="yes" size="25" maxlength="10" class="textField" message="Please enter a password."></td>
		</tr>
		<tr>
			<td id="Repeat"><label for="repeatPass">Repeat Password:</label></td>
			<td headers="Repeat"><cfinput type="password" id="repeatPass" name="password2" required="yes" size="25" maxlength="10" class="textField" message="Please repeat the password for verification."></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<!--a href="javascript:document.changePassForm.submitForm.click();" class="textbutton">Submit</a>
				<br-->
				<input type="submit" value="Change Password" class="textbutton">
				<cfoutput><input type="hidden" name="userID" value="#form.userID#"></cfoutput>
				<!---<input type="button" value="Cancel" class="button" onClick="javascript:location.href='../booking-e.cfm'">--->
			</td>
		</tr>
	</table>
	<BR>
	<div align="right"><CFOUTPUT><input type="button" name="cancel" value="Cancel" class="textbutton" onClick="self.location.href='../menu.cfm?lang=#lang#'"></CFOUTPUT></div>
</cfform>

<div align="left" style="padding-left:10px;"><i>*Email notification of profile updates is automatically sent to the user after their password is changed or a company is added to their profile.</i></div>

</div>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">