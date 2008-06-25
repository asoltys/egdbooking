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

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<A href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			<A href="companyApprove.cfm?lang=#lang#">Company Approvals</A> &gt;
			Reject Company
			</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Reject Company
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>
					
				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br />
				
				<div class="content" align="center">
					<p>Are you sure you want to reject <cfoutput><strong>#GetNewCompanies.Name#</strong></cfoutput>?<br />Rejecting this company will delete it from the system.</p><!---, along with the following users:</p>
					<p>
					<cfoutput query="GetUsers">
						#FirstName# #LastName# - #Email#<br />
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
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
