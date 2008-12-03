<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/build_form_struct.cfm">

<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm Remove Company"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm Remove Company</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<!---<CFIF not IsDefined('form.userID')>
	<cflocation addtoken="no" url="editUser.cfm?lang=#lang#">
</CFIF>

<cfif NOT IsDefined('form.companyID')>
	<cflocation addtoken="no" url="editUser.cfm?lang=#lang#&userID=#form.userID#">
</cfif>--->

<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Name
	FROM	Companies
	WHERE	CompanyId = #form.CompanyID#
</cfquery>

<!---<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT FirstName + ' ' + LastName AS UserName
	FROM Users
	WHERE UserID = #url.UserID#
</cfquery>--->

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt;
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			<a href="#RootDir#admin/Users/addUser.cfm?lang=#lang#">Create New User</a> &gt;
			Confirm Remove Company
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Confirm Remove Company
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<cfif IsDefined("Session.Return_Structure")>
					<!--- Populate the Variables Structure with the Return Structure.
							Also display any errors returned --->
					<cfinclude template="#RootDir#includes/getStructure.cfm">
				</cfif>

				<cfform action="removeNewUserCompany_action.cfm?info=#url.info#&companies=#url.companies#" method="post" id="remCompanyConfirmForm">
					<div style="text-align:center;">Are you sure you want to remove <cfoutput><strong>#getCompany.Name#</strong></cfoutput>?</div>

					<p><div style="text-align:center;">
						<input type="button" value="Remove" onclick="document.remCompanyConfirmForm.submit();" class="textbutton" />
						<cfoutput><input type="button" value="Cancel" onclick="self.location.href='addNewUserCompany.cfm?info=#url.info#&companies=#url.companies#'" class="textbutton" /></cfoutput>
					<!---<input type="submit" value="Delete" class="button" />
					<input type="button" value="Cancel" onclick="javascript:location.href='delVessel.cfm'" class="button" />
					</div></p>

					<cfoutput><input type="hidden" name="CompanyID" value="#form.CompanyID#" />
					<!---<cfoutput><input type="hidden" name="userID" value="#url.userID#" />
				</cfform>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
