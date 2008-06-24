<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - User Approval"">
	<meta name=""keywords"" lang=""eng"" content="""">
	<meta name=""description"" lang=""eng"" content="""">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>PWGSC - ESQUIMALT GRAVING DOCK - User Approval</title>">

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
		<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
			<A href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
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

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>
					
				<cfif getUserCompRequests.RecordCount EQ 0>
					There are no new user company requests to approve.
				<cfelse>
					The following user(s) have requested booking access for the specified companies.  Whether 
					they are approved or rejected, email notification will be sent to the user regarding the 
					standing of their request.  <b><i>Those listings without an 'Approve' button must have 
					the company approved first.</i></b>
					<br><br>
					<!--- Start of Users Listing --->
					
					<CFSET prevID = 0>
					<CFSET curr_row = 0>
					<CFSET BackColour = "##FFFFFF">
					<CFOUTPUT query="getUserCompRequests">
						<CFIF prevID neq CompanyID>
							<CFSET curr_row = 0>
							<CFIF prevID neq '0'>
							</TABLE>
							<BR>
							</CFIF>
							<TABLE id="listManage" border="0" cellspacing="0" cellpadding="2" width="100%">
								<TR bgcolor="##FFFFFF">
									<TD colspan="3" width="50%"><i><A href="javascript:void(0);" onClick="popUp('admin/viewCompany.cfm?lang=#lang#&companyID=#CompanyID#');">#CompanyName#</A></i></TD>
									<TD colspan="3" align="right" width="50%"><CFIF CompApproved eq 0><i><A href="../CompanyApprove.cfm?lang=#lang#">awaiting company approval</A></i><CFELSE>&nbsp;</CFIF></TD>
								</TR>
				
						</CFIF>
								<CFSET curr_row = curr_row + 1>
								<CFIF curr_row mod 2 eq 1>
									<CFSET rowClass = "highlight">
								<CFELSE>
									<CFSET rowClass = "">
								</CFIF>
								<TR class="#rowClass#">
									<TD width="2%" bgcolor="##FFFFFF">&nbsp;</TD>
									<TD valign="top" width="25%">#LastName#, #FirstName#</TD>
									<TD valign="top" width="55%" colspan="2">#Email#</TD>
									<TD valign="top" width="10%" align="center">
									<cfif CompApproved EQ 1>
										<form action="userApprove_confirm.cfm?lang=#lang#" method="post" name="App#UserID##CompanyID#" style="margin-top: 0; margin-bottom: 0; ">
											<input type="hidden" name="UserID" value="#UserID#">
											<input type="hidden" name="CompanyID" value="#CompanyID#">
											<a href="javascript:EditSubmit('App#UserID##CompanyId#')" class="textbutton">Approve</a>
										</form>
									<cfelse>
										&nbsp;
									</cfif>
									</TD>
									<TD valign="top" width="10%" align="center">
										<form action="userReject.cfm?lang=#lang#" method="post" name="Del#UserID##CompanyId#" style="margin-top: 0; margin-bottom: 0; ">
											<input type="hidden" name="UserID" value="#UserID#">
											<input type="hidden" name="CompanyID" value="#CompanyID#">
											<a href="javascript:EditSubmit('Del#UserID##CompanyId#')" class="textbutton">Reject</a>
										</form>
									</TD>		
								</TR>

						<CFSET prevID = CompanyID>
					</CFOUTPUT>
							</TABLE>

					<!--- End of Users Listing --->
				</cfif>
								
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
