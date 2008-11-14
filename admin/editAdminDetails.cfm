<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Email List"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Email List</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfquery name="getAdministrators" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Email, firstname + ' ' + lastname AS AdminName, Administrators.UserID
	FROM 	Administrators INNER JOIN Users on Administrators.userID = Users.userID
	WHERE 	users.deleted = 0
	ORDER BY lastname, firstname
</cfquery>

<cfquery name="getEmails" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Email
	FROM	Configuration
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
			Edit Email List
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Edit Email List
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>
		
				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				<cfinclude template="#RootDir#includes/getStructure.cfm">
				
				<cfoutput>
				<cfform name="emailForm" action="editAdminDetails_action.cfm?lang=#lang#">
				<p>Select any of the following administrators to receive email notification about user activities:</p>
				<table align="center" style="width:85%;">
					<cfloop query="getAdministrators">
					<cfif ListContains(getEmails.email, "#email#") NEQ 0>
						<cfset variables.checked = "yes">
					<cfelse>
						<cfset variables.checked = "no">
					</cfif>
						<tr>
							<td>#AdminName#</td><td>#email#</td><td><cfinput type="checkbox" name="Email#userID#" value="#userID#" checked="#variables.checked#" /></td>
						</tr>
					</cfloop>
				</table>
				
				<br />
				<div style="text-align:right;"><input type="submit" value="submit" class="textbutton" />
				<input type="button" onclick="javascript:self.location.href='menu.cfm?lang=#lang#'" value="Cancel" class="textbutton" />
				</cfform>
				
				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
