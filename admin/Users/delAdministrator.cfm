<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Delete Administrator"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Delete Administrator</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfquery name="getAdminList" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT Users.UserID, LastName + ', ' + FirstName AS UserName
		FROM Users, Administrators
		WHERE Users.UserID <> #session.userID# AND Users.UserID = Administrators.UserID
				AND Deleted = 0
		ORDER BY LastName
	</cfquery>
</cflock>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt;
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			Remove Administrator
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Remove Administrator
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

<cfif IsDefined("Session.Return_Structure")>
	<!--- Populate the Variables Structure with the Return Structure.
			Also display any errors returned --->
	<cfinclude template="#RootDir#includes/getStructure.cfm">
</cfif>

<cfparam name="variables.userID" default="0">
<cfif IsDefined("Session.form_Structure")>
	<cfinclude template="#RootDir#includes/restore_params.cfm">
	<cfif isDefined("form.userID")>
		<cfset Variables.userID = #form.userID#>
	</cfif>
</cfif>

<div style="text-align:center;">
	<cfform action="delAdministrator_confirm.cfm?lang=#lang#" method="post" id="delAdministratorForm">
		<cfselect name="UserID" query="getAdminList" value="UserID" display="UserName" selected="#variables.userID#" />
		<input type="submit" value="Remove" class="textbutton" />
		<cfoutput><input type="button" value="Cancel" onclick="self.location.href='../menu.cfm?lang=#lang#'" class="textbutton" />
	</cfform>
</div>
</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
