<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/build_form_struct.cfm">

<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Reject Company"">
<meta name=""keywords"" lang=""eng"" content="""">
<meta name=""description"" lang=""eng"" content="""">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Reject Company</title>">

<cfinclude template="#RootDir#includes/header-#lang#.cfm">

<CFSET This_Page = "../admin/userReject.cfm">

<cfquery name="GetNewCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	CompanyID, Name
	FROM	Companies
	WHERE	CompanyID = '#Form.CompanyID#'
</cfquery>
<!---<cfquery name="GetUsers" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	FirstName, LastName, Email
	FROM	Users INNER JOIN UserCompanies ON Users.UserID = UserCompanies.UserID
	WHERE	Users.Deleted = '0' AND UserCompanies.Deleted = '0'
	AND		CompanyID = '#Form.CompanyID#'
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
	<A href="companyApprove.cfm?lang=#lang#">Company Approvals</A> &gt;
	</CFOUTPUT>
	Reject Company
</div>

<div class="main">
<H1>Reject Company</H1>
<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>

<div class="content" align="center">
	<p>Are you sure you want to reject <cfoutput><strong>#GetNewCompanies.Name#</strong></cfoutput>?<br>Rejecting this company will delete it from the system.</p><!---, along with the following users:</p>
	<p>
	<cfoutput query="GetUsers">
		#FirstName# #LastName# - #Email#<br>
	</cfoutput>
	</p>
	<p>Please confirm that this is the user you wish to delete.</p>--->
	<p>
	<cfoutput>
	<form action="companyReject_action.cfm?lang=#lang#" method="post">
		<input type="hidden" name="CompanyID" value="#Form.CompanyID#">
		<input type="Submit" value="Reject" class="textbutton">
		<input type="button" value="Cancel" class="textbutton" onClick="javascript:location.href='companyApprove.cfm?lang=#lang#'">
	</form>
	</cfoutput>
	</p>
</div>

</div>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">