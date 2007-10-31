<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/build_form_struct.cfm">

<cfif lang EQ "e">
	<cfset language.confirmRem = "Confirm Remove Company">
	<cfset language.keywords = "#language.masterKeywords#" & " Remove Company User Represent">
	<cfset language.description = "Confirms that user no longer represents a company.">
	<cfset language.areYouSure = "Are you sure you want to remove yourself from">
	<cfset language.remove = "Remove">
	<cfset language.createUser = "Create New User">
<cfelse>
	<cfset language.confirmRem = "Confirmation de la suppression d'une entreprise">
	<cfset language.keywords = "#language.masterKeywords#" & " Suppression de l'utilisateur-repr&eacute;sentant de l'entreprise">
	<cfset language.description = "Confirme que l'utilisateur ne repr&eacute;sente plus une entreprise.">
	<cfset language.areYouSure = "Êtes-vous certain de vouloir vous retirer de l'&eacute;l&eacute;ment suivant">
	<cfset language.remove = "Supprimer">
	<cfset language.createUser = "Cr&eacute;er un nouvel utilisateur">
</cfif>

<cfoutput>
	<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.confirmRem#"">
	<meta name=""keywords"" lang=""eng"" content=""#language.keywords#"">
	<meta name=""description"" lang=""eng"" content=""#language.description#"">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""#language.masterSubjects#"">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.confirmRem#</title>">
</cfoutput>

<cfinclude template="#RootDir#includes/header-#lang#.cfm">

<cfif NOT IsDefined('form.companyID')>
	<cflocation addtoken="no" url="addUserCompanies.cfm?lang=#lang#&amp;info=#url.info#">
</cfif>

<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Name
	FROM	Companies
	WHERE	CompanyId = #form.CompanyID#
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
<!-- End JavaScript Block -->


<cfoutput>
<div class="breadcrumbs">
	<a href="http://www.pwgsc.gc.ca/text/home-#lang#.html">#language.PWGSC#</a> &gt;
	#language.PacificRegion# &gt;
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-#lang#.html">#language.EsqGravingDock#</a> &gt; 
	<a href="#RootDir#text/booking-#lang#.cfm">#language.Booking#</A> &gt; 
	<a href="#RootDir#text/login/login.cfm?lang=#lang#">#language.login#</a> &gt; 
	<a href="#RootDir#text/login/addUserCompanies.cfm?lang=#lang#&amp;info=#url.info#&amp;companies=#url.companies#">#language.createUser#</a> &gt; 
	#language.confirmRem#
</div>

<div class="main">
<H1>#language.confirmRem#</H1>


<cfif IsDefined("Session.Return_Structure")>
	<!--- Populate the Variables Structure with the Return Structure.
			Also display any errors returned --->
	<cfinclude template="#RootDir#includes/getStructure.cfm">
</cfif>

<cfform action="removeUserCompany_action.cfm?lang=#lang#&amp;companies=#companies#&amp;info=#url.info#" method="post" name="remCompanyConfirmForm">
	<div align="center">#language.areYouSure# <cfoutput><strong>#getCompany.Name#</strong></cfoutput>?</div>

	<p><div align="center">
		<!---a href="javascript:EditSubmit('remCompanyConfirmForm');" class="textbutton">#language.Remove#</a>
		<a href="addUserCompanies.cfm?lang=#lang#&amp;companies=#companies#&amp;info=#url.info#" class="textbutton">#language.Cancel#</a--->
		<input type="submit" value="#language.Remove#" class="textbutton">
		<input type="button" value="#language.Cancel#" onClick="javascript:self.location.href='addUserCompanies.cfm?lang=#lang#&amp;companies=#companies#&amp;info=#url.info#'" class="textbutton">
	</div></p>

	<input type="hidden" name="CompanyID" value="#form.CompanyID#">
</cfform>

</div>
</cfoutput>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">