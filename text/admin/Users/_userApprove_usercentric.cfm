<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Reject User"">
<meta name=""keywords"" lang=""eng"" content="""">
<meta name=""description"" lang=""eng"" content="""">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Approve User</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFSET This_Page = "../admin/userApprove.cfm">

<!---<cfquery name="GetNewUsers" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Users.UserID, FirstName, LastName, Email, Companies.Name AS Company, Companies.CompanyId
	FROM 	Users, UserCompanies, Companies
	WHERE 	Users.Deleted = '0'
	AND		UserCompanies.Deleted = '0'
	AND		UserCompanies.Approved = '0'
	AND		Companies.CompanyID = UserCompanies.CompanyID
	AND		Users.UserID = UserCompanies.UserID
	ORDER BY LastName, FirstName, Email
</cfquery>

<cfquery name="GetUsersNonApprovedCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Users.UserID, FirstName, LastName, Email
	FROM 	Users, Companies, UserCompanies
	WHERE 	Users.Deleted = '0'
	AND		UserCompanies.Deleted = '0'
	AND		UserCompanies.Approved = '0'
	AND		Companies.Deleted = '0'
	AND		Companies.Approved = '0'
	AND		Companies.CompanyID = UserCompanies.CompanyID
	AND		Users.UserID = UserCompanies.UserID
</cfquery>--->

<cfquery name="getUserCompRequests" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT  Users.UserID, Users.FirstName, Users.LastName, Users.Email, Companies.Name AS CompanyName, 
			Companies.CompanyID, UserCompanies.Approved AS UCApproved, Companies.Approved AS CompApproved
	FROM    Companies, Users, UserCompanies
	WHERE	Users.UserID = UserCompanies.UserID
	AND		Companies.CompanyID = UserCompanies.CompanyID
	AND 	Companies.Deleted = '0'
	AND 	Users.Deleted = '0'
	AND 	UserCompanies.Deleted = '0'
	AND 	UserCompanies.Approved = '0'
	ORDER BY Users.LastName, Users.FirstName, Users.UserID, Companies.Name
</cfquery>

<!-- Start JavaScript Block -->
<script language="JavaScript" type="text/javascript">
<!--
function EditSubmit ( selectedform )
{
  document.forms[selectedform].submit() ;
}

function popUp(pageID) {
	var Cuilfhionn = window.open("<CFOUTPUT>#RootDir#</CFOUTPUT>" + pageID, "", "width=300, height=300, resizable=yes, menubar=no, scrollbars=yes, toolbar=no");
}
//-->
</script>
<!-- End JavaScript Block -->

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
	</CFOUTPUT>
	User Approvals
</div>

<div class="main">
<H1>User Approval</H1>
<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>
<div class="content">
	
<cfif getUserCompRequests.RecordCount EQ 0>
	There are no new user company requests to approve.
<cfelse>
		The following user(s) have requested booking access for the specified companies.  Whether 
		they are approved or rejected, email notification will be sent to the user regarding the 
		standing of their request.  <i>Those listings without an 'Approve' button must have 
		the company approved first.</i><br><br>
		<!--- Start of Administrators Listing --->
		<table id="listManage" cellpadding="2" cellspacing="0" width="100%">
		
		<tr>
			<th id="name">Name</th>
			<th id="emailANDcompanies">E-Mail</th>
			<th id="edit" width="60">&nbsp;</th>
			<th id="delete" width="50">&nbsp;</th>
		</tr>

		<cfset prevID = 0>
		<cfset BackColour = "##FFFFFF">
		<cfoutput query="getUserCompRequests">
		
		<cfif prevID NEQ "#getUserCompRequests.UserID#">
			<cfif BackColour EQ "##FFFFFF">
				<cfset BackColour = "##FFF8DC">
			<cfelse>
				<cfset BackColour = "##FFFFFF">
			</cfif>
		</cfif>
		<cfif prevID NEQ "#getUserCompRequests.UserID#">
			<tr bgcolor="#BackColour#">
				<td headers="name" valign="top" width="27%">#LastName#, #FirstName#</td>
				<td headers="emailANDcompanies" valign="top">#Email#</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</cfif>
		<tr bgcolor="#BackColour#">
			<td>&nbsp;</td>
			<td headers="emailANDcompanies" valign="top"><i><A href="javascript:popUp('text/admin/viewCompany.cfm?lang=#lang#&companyID=#CompanyID#');">#CompanyName#</A></i></td>
			<cfif CompApproved EQ 1>
				<td headers="edit" valign="top">
					<form action="userApprove_confirm.cfm?lang=#lang#" method="post" name="App#UserID##CompanyID#" style="margin-top: 0; margin-bottom: 0; ">
						<input type="hidden" name="UserID" value="#UserID#">
						<input type="hidden" name="CompanyID" value="#CompanyID#">
						<a href="javascript:EditSubmit('App#UserID##CompanyId#')" class="textbutton">Approve</a>
					</form>
				</td>
			<cfelse>
				<td valign="top">&nbsp;</td>
			</cfif>
				<td headers="delete" valign="top">
					<form action="userReject.cfm?lang=#lang#" method="post" name="Del#UserID##CompanyId#" style="margin-top: 0; margin-bottom: 0; ">
						<input type="hidden" name="UserID" value="#UserID#">
						<input type="hidden" name="CompanyID" value="#CompanyID#">
						<a href="javascript:EditSubmit('Del#UserID##CompanyId#')" class="textbutton">Reject</a>
					</form>
				</td>
		</tr>
		<cfset prevID = #getUserCompRequests.UserID#>
		</cfoutput>
		</table>
		<!--- End of Administrators Listing --->
</cfif>


</div>

</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">