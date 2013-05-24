<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Company Approval"" />
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Company Approval</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFSET This_Page = "../admin/companyApprove.cfm">

<cfquery name="GetNewCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	CID, Name
	FROM 	Companies
	WHERE 	Deleted = '0'
	AND		Approved = '0'
	ORDER BY Name
</cfquery>

<!-- Start JavaScript Block -->
<script type="text/javascript">
/* <![CDATA[ */
function EditSubmit ( selectedform )
	{
	  document.forms[selectedform].submit();
	}
	
	function popUp(pageID) {
		var Cuilfhionn = window.open("<cfoutput>#RootDir#</cfoutput>" + pageID, "viewCompany", "width=500, height=300, top=20, left=20, resizable=yes, menubar=no, scrollbars=yes, toolbar=no");
		if (window.focus) {
			Cuilfhionn.focus();
	}
		
		return false;
	}
/* ]]> */
</script>
<!-- End JavaScript Block -->

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt; 
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			Company Approvals
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1 id="wb-cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Company Approval
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				<cfinclude template="#RootDir#includes/getStructure.cfm">
				
				<cfif GetNewCompanies.RecordCount EQ 0>
					There are no new companies to approve.
				<cfelse>
				
					<!--- Start of Company Listing --->
					<table id="listManage" cellpadding="2" cellspacing="0" style="width:100%;">
						
						<tr align="left">
							<th id="firstname">Name</th>
							<th id="abbrev" style="width:120px;">&nbsp;</th>
							<th id="approve" style="width:60px;">&nbsp;</th>
							<th id="reject" style="width:50px;">&nbsp;</th>
						</tr>
						
						<cfoutput query="GetNewCompanies">
						<cfif CurrentRow mod 2>
							<cfset rowClass = "highlight">
						<cfelse>
							<cfset rowClass = "">
						</cfif>
						<tr class="#rowClass#">
							<td headers="firstname"><a href="javascript:void(0);" onclick="popUp('admin/viewCompany.cfm?lang=#lang#&amp;CID=#CID#');">#Name#</a></td>
							<td headers="abbrev"><form action="companyApprove_confirm.cfm?lang=#lang#" method="post" name="App#CID#" style="margin-top: 0; margin-bottom: 0;" id="App#CID#"><label for="abbreviation">Abbrev.: </label><input type="text" name="abbrev" id="abbreviation" maxlength="3" size="4" /><input type="hidden" name="CID" value="#CID#" /></form></td>
							<td headers="approve"><a href="javascript:EditSubmit('App#CID#')" class="textbutton">Approve</a>
							<td headers="reject"><form action="companyReject.cfm?lang=#lang#" method="post" name="Del#CID#" style="margin-top: 0; margin-bottom: 0; "><input type="hidden" name="CID" value="#CID#" /><a href="javascript:EditSubmit('Del#CID#')" class="textbutton">Reject</a>
						</tr>
						</cfoutput>
					</table>
					<!--- End of Company Listing --->
				</cfif>
				
			</div>
				
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
