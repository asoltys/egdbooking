<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Delete Company"">
	<meta name=""keywords"" lang=""eng"" content="""">
	<meta name=""description"" lang=""eng"" content="""">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Delete Company</title>">

<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfquery name="getCompanyList" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT CompanyID, Name
	FROM Companies
	WHERE Approved = 1 AND Deleted = 0
	ORDER BY Name
	</cfquery>
</cflock>

<!---
<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfquery name="getCompanyList" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT CompanyID, Name
		FROM Companies
		WHERE NOT EXISTS (SELECT CompanyID
							FROM UserCompanies
							WHERE UserCompanies.CompanyID = Companies.CompanyID
							AND UserCompanies.Deleted = 0 AND UserCompanies.Approved = 1
							AND UserCompanies.UserID = #session.UserID#)
		AND Companies.Deleted = 0
		ORDER BY Name
	</cfquery>
</cflock>
--->

<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfif isDefined("form.companyID")>
	<cfset variables.companyID = #form.companyID#>
<cfelse>
	<cfset variables.companyID = 0>
</cfif>

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
			<CFELSE>
				 <a href="#RootDir#text/booking/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			Delete Company
			</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Delete Company
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>
				
				<cfif IsDefined("Session.Return_Structure")>
					<!--- Populate the Variables Structure with the Return Structure.
							Also display any errors returned --->
					<cfinclude template="#RootDir#includes/getStructure.cfm">
				</cfif>
				
				<DIV align="center">
					<cfform action="delCompany_confirm.cfm?lang=#lang#" method="post" name="delCompanyForm">
						<cfselect name="companyID" query="getcompanyList" value="companyID" display="name" selected="#variables.companyID#"/>
						<input type="submit" name="submitForm" class="textbutton" value="Delete">
						<CFOUTPUT><input type="button" value="Cancel" onClick="self.location.href='#RootDir#text/admin/menu.cfm?lang=#lang#'" class="textbutton"></CFOUTPUT>
					</cfform>
				</DIV>


			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
