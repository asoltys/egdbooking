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

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<A href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
			<CFELSE>
				 <a href="#RootDir#reserve-book/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			Company Approvals
			</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Company Approval
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>
				<cfinclude template="#RootDir#includes/getStructure.cfm">
				
				<cfif GetNewCompanies.RecordCount EQ 0>
					There are no new companies to approve.
				<cfelse>
				
					<!--- Start of Company Listing --->
					<table id="listManage" cellpadding="2" cellspacing="0" width="100%">
						
						<tr align="left">
							<th id="firstname">Name</th>
							<th id="abbrev" width="120">&nbsp;</th>
							<th id="approve" width="60">&nbsp;</th>
							<th id="reject" width="50">&nbsp;</th>
						</tr>
						
						<cfoutput query="GetNewCompanies">
						<cfif CurrentRow mod 2>
							<cfset rowClass = "highlight">
						<cfelse>
							<cfset rowClass = "">
						</cfif>
						<tr class="#rowClass#">
							<td headers="firstname"><A href="javascript:void(0);" onClick="popUp('admin/viewCompany.cfm?lang=#lang#&companyID=#CompanyID#');">#Name#</A></td>
							<td headers="abbrev"><cfform action="companyApprove_confirm.cfm?lang=#lang#" method="post" name="App#CompanyID#" style="margin-top: 0; margin-bottom: 0; "><label for="abbreviation">Abbrev.: </label><cfinput type="text" name="abbrev" id="abbreviation" maxlength="3" size="4" required="yes" message="Please enter the company abbreviation."></td>
							<td headers="approve"><input type="hidden" name="CompanyID" value="#CompanyID#" /><a href="javascript:EditSubmit('App#CompanyID#')" class="textbutton">Approve</a></td></cfform>
							<td headers="reject"><form action="companyReject.cfm?lang=#lang#" method="post" name="Del#CompanyID#" style="margin-top: 0; margin-bottom: 0; "><input type="hidden" name="CompanyID" value="#CompanyID#" /><a href="javascript:EditSubmit('Del#CompanyID#')" class="textbutton">Reject</a></form></td>
						</tr>
						</cfoutput>
					</table>
					<!--- End of Company Listing --->
				</cfif>
				
			</div>
				
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
