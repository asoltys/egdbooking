<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Create New User"">
<meta name=""keywords"" lang=""eng"" content="""">
<meta name=""description"" lang=""eng"" content="""">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Create New User</title>">

<cfinclude template="#RootDir#includes/header-#lang#.cfm">

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
	Create New User
</div>

<div class="main">
<H1>Create New User</H1>
<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>

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
			<td headers="First"><cfinput name="firstName" id="firstName" type="text" value="#variables.firstName#" size="25" maxlength="40" required="yes" CLASS="textField" message="Please enter a first name."></td>
		</tr>
		<tr>
			<td id="Last"><label for="lastname">Last Name:</label></td>
			<td headers="Last"><cfinput name="lastname" id="lastname" type="text" value="#variables.lastName#" size="25" maxlength="40" required="yes" CLASS="textField" message="Please enter a last name."></td>
		</tr>
		<!---<tr>
			<td>Login Name:</td>
			<td><cfinput type="text" name="loginID" required="yes" size="25" maxlength="40" value="#variables.loginID#"></td>
		</tr>--->
		<tr>
			<td id="Passworda"><label for="password1">Password:</label></td>
			<td headers="Passworda"><cfinput id="password1" type="password" name="password1" required="yes" size="25" maxlength="10" class="textField" message="Please enter a password."><span style="font-size: 9pt;">(*6 - 10 characters)</span></td>
		</tr>
		<tr>
			<td id="Passwordb"><label for="password2">Repeat Password:</label></td>
			<td headers="Passwordb"><cfinput id="password2" type="password" name="password2" required="yes" size="25" maxlength="10" class="textField" message="Please repeat the password for verification."></td>
		</tr>
		<tr>
			<td id="mail"><label for="email">Email:</label></td>
			<td headers="mail"><cfinput name="email" id="email" type="text" value="#variables.email#" size="40" maxlength="100" required="yes" CLASS="textField" message="Please enter an email address."></td>
		</tr>
		<tr>
			<td colspan="2" align="center" style="padding-top:20px;">
				<!--a href="javascript:document.addUserForm.submitForm.click();" class="textbutton">Submit</a-->
				<input type="submit" name="submitForm" value="Continue" class="textbutton">
				<CFOUTPUT><input type="button" name="submitForm" value="Cancel" class="textbutton" onClick="self.location.href='../menu.cfm?lang=#lang#'"></CFOUTPUT>
			</td>
		</tr>
	</table>
</cfform>

</div>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">