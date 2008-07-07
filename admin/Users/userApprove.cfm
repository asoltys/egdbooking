<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - User Approval"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - User Approval</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFSET This_Page = "../admin/Users/userApprove.cfm">

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
	ORDER BY Companies.Name, Users.LastName, Users.FirstName, Users.UserID
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
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
		<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
			<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt; 
		<CFELSE>
			<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
		</CFIF>
			User Approvals
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					User Approval
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
					
				<cfif getUserCompRequests.RecordCount EQ 0>
					There are no new user company requests to approve.
				<cfelse>
					The following user(s) have requested booking access for the specified companies.  Whether 
					they are approved or rejected, email notification will be sent to the user regarding the 
					standing of their request.  <b><i>Those listings without an 'Approve' button must have 
					the company approved first.</i></b>
					<br /><br />
					<!--- Start of Users Listing --->
					
					<CFSET prevID = 0>
					<CFSET curr_row = 0>
					<CFSET BackColour = "##FFFFFF">
					<cfoutput query="getUserCompRequests">
						<CFIF prevID neq CompanyID>
							<CFSET curr_row = 0>
							<CFIF prevID neq '0'>
							</table>
							<br />
							</CFIF>
							<table id="listManage" border="0" cellspacing="0" cellpadding="2" style="width:100%;">
								<tr bgcolor="##FFFFFF">
									<td colspan="3" style="width:50%;"><i><a href="javascript:void(0);" onclick="popUp('admin/viewCompany.cfm?lang=#lang#$amp;companyID=#CompanyID#');">#CompanyName#</a></i></td>
									<td colspan="3" align="right" style="width:50%;"><CFIF CompApproved eq 0><i><a href="../CompanyApprove.cfm?lang=#lang#">awaiting company approval</a></i><CFELSE>&nbsp;</CFIF></td>
								</tr>
				
						</CFIF>
								<CFSET curr_row = curr_row + 1>
								<CFIF curr_row mod 2 eq 1>
									<CFSET rowClass = "highlight">
								<CFELSE>
									<CFSET rowClass = "">
								</CFIF>
								<tr class="#rowClass#">
									<td style="width:2%;" bgcolor="##FFFFFF">&nbsp;</td>
									<td valign="top" style="width:25%;">#LastName#, #FirstName#</td>
									<td valign="top" style="width:55%;" colspan="2">#Email#</td>
									<td valign="top" style="width:10%;" align="center">
									<cfif CompApproved EQ 1>
										<form action="userApprove_confirm.cfm?lang=#lang#" method="post" name="App#UserID##CompanyID#" style="margin-top: 0; margin-bottom: 0; ">
											<input type="hidden" name="UserID" value="#UserID#" />
											<input type="hidden" name="CompanyID" value="#CompanyID#" />
											<a href="javascript:EditSubmit('App#UserID##CompanyId#')" class="textbutton">Approve</a>
										</form>
									<cfelse>
										&nbsp;
									</cfif>
									</td>
									<td valign="top" style="width:10%;" align="center">
										<form action="userReject.cfm?lang=#lang#" method="post" name="Del#UserID##CompanyId#" style="margin-top: 0; margin-bottom: 0; ">
											<input type="hidden" name="UserID" value="#UserID#" />
											<input type="hidden" name="CompanyID" value="#CompanyID#" />
											<a href="javascript:EditSubmit('Del#UserID##CompanyId#')" class="textbutton">Reject</a>
										</form>
									</td>		
								</tr>

						<CFSET prevID = CompanyID>
					</cfoutput>
							</table>

					<!--- End of Users Listing --->
				</cfif>
								
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
