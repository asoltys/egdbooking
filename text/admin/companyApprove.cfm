<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Company Approval"">
<meta name=""keywords"" lang=""eng"" content="""">
<meta name=""description"" lang=""eng"" content="""">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Company Approval</title>">
<cfinclude template="#RootDir#includes/header-#lang#.cfm">

<CFSET This_Page = "../admin/companyApprove.cfm">

<cfquery name="GetNewCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	CompanyID, Name
	FROM 	Companies
	WHERE 	Deleted = '0'
	AND		Approved = '0'
	ORDER BY Name
</cfquery>

<!-- Start JavaScript Block -->
<script language="JavaScript" type="text/javascript">
<!--
function EditSubmit ( selectedform )
{
  document.forms[selectedform].submit() ;
}

function popUp(pageID) {
	var Cuilfhionn = window.open("<CFOUTPUT>#RootDir#</CFOUTPUT>" + pageID, "viewCompany", "width=500, height=300, top=20, left=20, resizable=yes, menubar=no, scrollbars=yes, toolbar=no");
	if (window.focus) {
		Cuilfhionn.focus();
	}
	
	return false;
}

//-->
</script>
<!-- End JavaScript Block -->

<cfoutput>
<div class="breadcrumbs">
	<a href="http://www.pwgsc.gc.ca/text/home-#lang#.html">PWGSC</a> &gt; 
	Pacific Region &gt; 
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-e.html">Esquimalt Graving Dock</a> &gt; 
	<a href="#RootDir#text/booking-#lang#.cfm">Booking</A> &gt;
<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
	<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
<CFELSE>
	 <a href="#RootDir#text/booking/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
</CFIF>
	Company Approvals
</div>

</cfoutput>
<div class="main">
<H1>Company Approval</H1>
<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>
<cfinclude template="#RootDir#includes/getStructure.cfm">


<cfif GetNewCompanies.RecordCount EQ 0>
	There are no new companies to approve.
<cfelse>

		<!--- Start of Administrators Listing --->
		<table id="listManage" cellpadding="2" cellspacing="0" width="100%">
		
		<tr align="left">
			<th class="listmanage" id="firstname">Name</th>
			<th class="listmanage" id="abbrev" width="120">&nbsp;</th>
			<th class="listmanage" id="approve" width="60">&nbsp;</th>
			<th class="listmanage" id="reject" width="50">&nbsp;</th>
		</tr>
		
		<cfoutput query="GetNewCompanies">
		<cfif CurrentRow mod 2>
			<cfset BackColour = "##FFF8DC">
		<cfelse>
			<cfset BackColour = "White">
		</cfif>
		<tr bgcolor="#BackColour#">
			<td headers="firstname"><A href="javascript:void(0);" onClick="popUp('text/admin/viewCompany.cfm?lang=#lang#&companyID=#CompanyID#');">#Name#</A></td>
			<td headers="abbrev"><cfform action="companyApprove_confirm.cfm?lang=#lang#" method="post" name="App#CompanyID#" style="margin-top: 0; margin-bottom: 0; "><label for="abbreviation">Abbrev.: </label><cfinput type="text" name="abbrev" id="abbreviation" maxlength="3" size="4" required="yes" message="Please enter the company abbreviation."></td>
			<td headers="approve"><input type="hidden" name="CompanyID" value="#CompanyID#" /><a href="javascript:EditSubmit('App#CompanyID#')" class="textbutton">Approve</a></td></cfform>
			<td headers="reject"><form action="companyReject.cfm?lang=#lang#" method="post" name="Del#CompanyID#" style="margin-top: 0; margin-bottom: 0; "><input type="hidden" name="CompanyID" value="#CompanyID#" /><a href="javascript:EditSubmit('Del#CompanyID#')" class="textbutton">Reject</a></form></td>
		</tr>
		</cfoutput>
		</table>
		<!--- End of Administrators Listing --->
</cfif>

</div>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">