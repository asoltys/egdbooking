<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Email List"">
	<meta name=""keywords"" lang=""eng"" content="""">
	<meta name=""description"" lang=""eng"" content="""">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Email List</title>">

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
<script language="JavaScript" type="text/javascript">
	<!--
	function EditSubmit ( selectedform )
	{
	  document.forms[selectedform].submit() ;
	}
	//-->
</script>

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-eng.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
			<CFELSE>
				 <a href="#RootDir#text/booking/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			Edit Email List
			</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-eng.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Edit Email List
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>
		
				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>
				<cfinclude template="#RootDir#includes/getStructure.cfm">
				
				<cfoutput>
				<cfform name="emailForm" action="editAdminDetails_action.cfm?lang=#lang#">
				<p>Select any of the following administrators to receive email notification about user activities:</p>
				<table align="center" width="85%">
					<cfloop query="getAdministrators">
					<cfif ListContains(getEmails.email, "#email#") NEQ 0>
						<cfset variables.checked = "yes">
					<cfelse>
						<cfset variables.checked = "no">
					</cfif>
						<tr>
							<td>#AdminName#</td><td>#email#</td><td><cfinput type="checkbox" name="Email#userID#" value="#userID#" checked="#variables.checked#"></td>
						</tr>
					</cfloop>
				</table>
				
				<br><div align="right"><input type="submit" value="submit" class="textbutton">
				<input type="button" onClick="javascript:self.location.href='menu.cfm?lang=#lang#'" value="Cancel" class="textbutton"></div>
				</cfform>
				
				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
