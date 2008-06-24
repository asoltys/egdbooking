<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Delete User"">
	<meta name=""keywords"" lang=""eng"" content="""">
	<meta name=""description"" lang=""eng"" content="""">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Delete User</title>">

<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfquery name="getUserList" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT UserID, LastName + ', ' + FirstName AS UserName
		FROM Users
		WHERE UserID <> #session.userID#
		AND Deleted = 0
		ORDER BY LastName
	</cfquery>
</cflock>

<cfquery name="companyUsers" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT companies.companyID, companies.name AS CompanyName, users.UserID, lastname + ', ' + firstname AS UserName
	FROM Users INNER JOIN UserCompanies ON Users.UserID = UserCompanies.UserID
		 INNER JOIN Companies ON UserCompanies.CompanyID = Companies.CompanyID
	WHERE Users.Deleted = 0 AND Companies.Deleted = 0 AND Companies.Approved = 1 
			AND UserCompanies.Deleted = 0 AND UserCompanies.Approved = 1
	ORDER BY Companies.Name, Users.lastname, Users.firstname
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
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<A href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
			<CFELSE>
				 <a href="#RootDir#reserve-book/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			Delete User</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Delete User
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>
				
				<cfparam name="form.userID" default="">
				<cfinclude template="#RootDir#includes/restore_params.cfm">
				
				<cfif isDefined("form.companyID")>
					<cfset variables.companyID = #form.companyID#>
				<cfelse>
					<cfset variables.companyID = 0>
				</cfif>
				<cfif isDefined("form.userID")>
					<cfset variables.userID = #form.userID#>
				<cfelse>
					<cfset variables.userID = 0>
				</cfif>
				
				<cfif IsDefined("Session.Return_Structure")>
					<!--- Populate the Variables Structure with the Return Structure.
							Also display any errors returned --->
					<cfinclude template="#RootDir#includes/getStructure.cfm">
				</cfif>

				<cfform action="delUser_confirm.cfm?lang=#lang#" method="post" name="delUserForm">
				<table width="100%">
					<tr>
						<td>Company:</td>
						<td>
							<!---<cfform action="delUser_confirm.cfm?lang=#lang#" method="post" name="delUserForm">
							<cfselect name="UserID" query="getUserList" value="UserID" display="UserName" />--->
							<CF_TwoSelectsRelated 
								QUERY="companyUsers" 
								NAME1="CompanyID" 
								NAME2="UserID" 
								DISPLAY1="CompanyName" 
								DISPLAY2="UserName" 
								VALUE1="companyID" 
								VALUE2="userID"
								SIZE1="1" 
								SIZE2="1" 
								HTMLBETWEEN="</td></tr><tr><td valign='baseline'>User:</td><td>" 
								AUTOSELECTFIRST="Yes" 
								EMPTYTEXT1="(choose a company)" 
								EMPTYTEXT2="(choose a user)"
								DEFAULT1 ="#variables.companyID#"
								DEFAULT2 ="#variables.userID#" 
								FORMNAME="delUserForm">
						</td>
					</tr>	
					<!--a href="javascript:EditSubmit('delUserForm');" class="textbutton">Submit</a-->
					<tr><td>&nbsp;</td></tr>
					<tr><td colspan="2" align="center">
						<input type="submit" name="submitForm" value="Delete" class="textbutton">
						<cfoutput><input type="button" value="Cancel" onClick="self.location.href='#RootDir#admin/menu.cfm?lang=#lang#'" class="textbutton"></cfoutput>
					</td></tr>
				</table>
				</cfform>


			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
