<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm Remove Company"">
<meta name=""keywords"" lang=""eng"" content="""">
<meta name=""description"" lang=""eng"" content="""">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm Remove Company</title>">

<cfinclude template="#RootDir#includes/header-#lang#.cfm">

<cfif isDefined("form.userID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Name
	FROM	Companies
	WHERE	CompanyId = #form.CompanyID#
</cfquery>

<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT FirstName + ' ' + LastName AS UserName
	FROM Users
	WHERE UserID = #form.UserID#
</cfquery>

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
		<a href="#RootDir#text/booking-#lang#.cfm">Booking</A> &gt;<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
			<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
		<CFELSE>
			 <a href="#RootDir#text/booking/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
		</CFIF>
	<a href="#RootDir#text/admin/users/editUser.cfm?lang=#lang#&userID=#form.userID#">Edit User Profile</A> &gt; 
	</CFOUTPUT>
	Confirm Remove Company
</div>

<div class="main">
<H1>Confirm Remove Company</H1>
<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>

<cfif IsDefined("Session.Return_Structure")>
	<!--- Populate the Variables Structure with the Return Structure.
			Also display any errors returned --->
	<cfinclude template="#RootDir#includes/getStructure.cfm">
</cfif>

<cfoutput>
<cfform action="removeUserCompany_action.cfm?lang=#lang#&amp;userID=#form.userID#" method="post" name="remCompanyConfirmForm">
	<div align="center">Are you sure you want to remove <STRONG>#getUser.UserName#</STRONG> from <strong>#getCompany.Name#</strong>?</div>
	
	<p><div align="center">
		<!--a href="javascript:EditSubmit('remCompanyConfirmForm');" class="textbutton">Submit</a>
		<a href="editUser.cfm?userID=#form.userID#" class="textbutton">Cancel</a-->
		<input type="submit" name="submitForm" value="Remove" class="textbutton">
		<input type="button" name="cancel" value="Cancel" class="textbutton" onClick="self.location.href='editUser.cfm?lang=#lang#&userID=#form.userID#'">
	</div></p>
	
	<input type="hidden" name="CompanyID" value="#form.CompanyID#">
	<input type="hidden" name="userID" value="#form.userID#">
</cfform>	
</cfoutput>

</div>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">