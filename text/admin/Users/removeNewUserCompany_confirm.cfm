<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/build_form_struct.cfm">

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

<!---<CFIF not IsDefined('form.userID')>
	<cflocation addtoken="no" url="editUser.cfm?lang=#lang#">
</CFIF>

<cfif NOT IsDefined('form.companyID')>
	<cflocation addtoken="no" url="editUser.cfm?lang=#lang#&userID=#form.userID#">
</cfif>--->

<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Name
	FROM	Companies
	WHERE	CompanyId = #form.CompanyID#
</cfquery>

<!---<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT FirstName + ' ' + LastName AS UserName
	FROM Users
	WHERE UserID = #url.UserID#
</cfquery>--->


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
	<a href="#RootDir#text/admin/users/addUser.cfm?lang=#lang#">Create New User</A> &gt; 
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

<cfform action="removeNewUserCompany_action.cfm?info=#url.info#&amp;companies=#url.companies#" method="post" name="remCompanyConfirmForm">
	<div align="center">Are you sure you want to remove <cfoutput><strong>#getCompany.Name#</strong></cfoutput>?</div>
	
	<p><div align="center">
		<input type="button" value="Remove" onClick="document.remCompanyConfirmForm.submit();" class="textbutton">
		<cfoutput><input type="button" value="Cancel" onClick="self.location.href='addNewUserCompany.cfm?info=#url.info#&amp;companies=#url.companies#'" class="textbutton"></cfoutput>
	<!---<input type="submit" value="Delete" class="button">
	<input type="button" value="Cancel" onClick="javascript:location.href='delVessel.cfm'" class="button">--->
	</div></p>
	
	<cfoutput><input type="hidden" name="CompanyID" value="#form.CompanyID#"></cfoutput>
	<!---<cfoutput><input type="hidden" name="userID" value="#url.userID#"></cfoutput>--->
</cfform>	

</div>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">