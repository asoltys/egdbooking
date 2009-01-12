<cfif isDefined("form.UID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Approve User"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Approve User</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFSET This_Page = "../admin/userApprove_confirm.cfm">

<cfquery name="GetUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	UID, FirstName, LastName
	FROM 	Users
	WHERE 	UID = '#Form.UID#'
</cfquery>

<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	CID, Name AS CompanyName
	FROM 	Companies
	WHERE 	CID = '#Form.CID#'
</cfquery>

<!-- Start JavaScript Block -->
<script type="text/javascript">
/* <![CDATA[ */
function EditSubmit ( selectedform )
	{
	  document.forms[selectedform].submit();
	}
/* ]]> */
</script>
		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt;
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			<a href="userApprove.cfm?lang=#lang#">User Approvals</a> &gt;
			Approve User
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Approve User
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<div style="text-align:center;">
					<p>Are you sure you want to approve <cfoutput><strong>#getUser.FirstName# #getUser.LastName#</strong></cfoutput>'s
						request to join <cfoutput><strong>#getCompany.companyName#</strong></cfoutput>?</p>
					<cfoutput>
					<form action="userApprove_action.cfm?lang=#lang#" id="approveUser" method="post">
						<input type="hidden" name="UID" value="#Form.UID#" />
						<input type="hidden" name="CID" value="#Form.CID#" />
						<!---a href="javascript:EditSubmit('rejectUser');" class="textbutton">Submit</a--->
						<input type="submit" class="textbutton" value="Approve" />
						<a href="userApprove.cfm?lang=#lang#" class="textbutton">Cancel</a>
					</form>
					</cfoutput>
				</div>

			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
