<cfif lang EQ "eng">
	<cfset language.removeComp = "Confirm Remove Company">
	<cfset language.keywords = language.masterKeywords & ", Remove company">
	<cfset language.description = "Allows user to remove oneself from representing a company.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.areYouSure = "Are you sure you want to remove yourself from">
	<cfset language.remove = "Remove">
	<cfset language.editProfile = "Edit Profile">
<cfelse>
	<cfset language.removeComp = "Confirmation de la suppression d'une entreprise">
	<cfset language.keywords = language.masterKeywords & ", Suppression d'une entreprise">
	<cfset language.description = "Permet &agrave; l'utilisateur de supprimer son titre de repr&eacute;sentant d'une entreprise.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.areYouSure = "&Ecirc;tes-vous certain de vouloir vous retirer de l'&eacute;l&eacute;ment suivant">
	<cfset language.remove = "Supprimer">
	<cfset language.editProfile = "Modifier le profil">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.PWGSC# - #language.esqGravingDockCaps# - #language.RemoveComp#"">
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<meta name=""dc.date.published"" content=""2005-07-25"" />
	<meta name=""dc.date.reviewed"" content=""2005-07-25"" />
	<meta name=""dc.date.modified"" content=""2005-07-25"" />
	<meta name=""dc.date.created"" content=""2005-07-25"" />
	<title>#language.PWGSC# - #language.esqGravingDockCaps# - #language.RemoveComp#</title>">

<cfif isDefined("form.companyID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfif NOT IsDefined('form.companyID')>
	<cflocation addtoken="no" url="#RootDir#reserve-book/profilmod-profileedit.cfm?lang=#lang#">
</cfif>

<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Name
	FROM	Companies
	WHERE	CompanyId = #form.CompanyID#
</cfquery>

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			<CFELSE>
				<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			</CFIF>
			<a href="#RootDir#reserve-book/profilmod-profileedit.cfm?lang=#lang#">#language.editProfile#</a>
			#language.RemoveComp#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.RemoveComp#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>


				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
				
				<cfif IsDefined("Session.Return_Structure")>
					<!--- Populate the Variables Structure with the Return Structure.
							Also display any errors returned --->
					<cfinclude template="#RootDir#includes/getStructure.cfm">
				</cfif>
				
				<cfoutput>
				<cfform action="#RootDir#reserve-book/entrpsup-comprem_action.cfm?lang=#lang#" method="post" name="remCompanyConfirmForm">
					<div align="center">#language.AreYouSure# <cfoutput><strong>#getCompany.Name#</strong></cfoutput>?</div>
				
					<p><div align="center">
						<!--a href="javascript:document.remCompanyConfirmForm.submit();" class="textbutton">Submit</a>
						<a href="profilmod-profileedit.cfm" class="textbutton">Cancel</a-->
					<input type="submit" value="#language.Remove#" class="textbutton">
					<input type="button" value="#language.Cancel#" onClick="javascript:location.href='editUser.cfm?lang=#lang#&clrfs=true'" class="textbutton">
					</div></p>
				
					<cfoutput><input type="hidden" name="CompanyID" value="#form.CompanyID#"></cfoutput>
				</cfform>
				
				</cfoutput>
			</div>
				
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
