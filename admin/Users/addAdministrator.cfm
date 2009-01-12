<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Jetty Booking Management"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Add Administrator</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfquery name="getUserList" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT UID, LastName + ', ' + FirstName AS UserName
	FROM Users
	WHERE Deleted = 0
	AND NOT EXISTS (SELECT	UID
					FROM	Administrators
					WHERE	Users.UID = Administrators.UID)
	AND EXISTS (SELECT	*
				FROM	UserCompanies
				WHERE	UserCompanies.UID = Users.UID AND Approved = 1)
	ORDER BY LastName, Firstname
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
			Add Administrator
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Add Administrator
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

			<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

			<cfif IsDefined("Session.Return_Structure")>
				<!--- Populate the Variables Structure with the Return Structure.
						Also display any errors returned --->
				<cfinclude template="#RootDir#includes/getStructure.cfm">
			</cfif>

			<!---<div style="text-align:left;">
				<cfform action="addAdministrator_action.cfm?lang=#lang#" id="chooseUserForm" method="post">
					<cfselect name="UID" query="getUserList" value="UID" display="UserName" />
					<a href="javascript:EditSubmit('chooseUserForm');">Add</a>
				</cfform>
			</div>--->

			<cfform action="addAdministrator_action.cfm?lang=#lang#" id="addAdministratorForm" method="post">
				Select User: <cfselect name="UID" query="getUserList" value="UID" display="UserName" />
				&nbsp;&nbsp;&nbsp;
				<!--a href="javascript:EditSubmit('addAdministratorForm');" class="textbutton">Submit</a-->
				<input type="submit" name="submitForm" value="submit" class="textbutton" />
				<cfoutput><a href="../menu.cfm?lang=#lang#" class="textbutton">Cancel</a></cfoutput>
			</cfform>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
