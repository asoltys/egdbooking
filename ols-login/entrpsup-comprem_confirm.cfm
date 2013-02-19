<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/build_form_struct.cfm">

<cfif lang EQ "eng">
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
	<cfset language.areYouSure = "&Ecirc;tes-vous certain de vouloir vous retirer de l'&eacute;l&eacute;ment suivant">
	<cfset language.remove = "Supprimer">
	<cfset language.createUser = "Cr&eacute;er un nouvel utilisateur">
</cfif>

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""#language.confirmRem# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dcterms.subject"" content=""#language.masterSubjects#"" />
	<title>#language.confirmRem# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfif NOT IsDefined('form.CID')>
	<cflocation addtoken="no" url="entrpdemande-comprequest.cfm?lang=#lang#&info=#url.info#">
</cfif>

<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Name
	FROM	Companies
	WHERE	CID = <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" />
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
<!-- End JavaScript Block -->


				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.confirmRem#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

			<cfoutput>
				<cfif IsDefined("Session.Return_Structure")>
					<!--- Populate the Variables Structure with the Return Structure.
							Also display any errors returned --->
					<cfinclude template="#RootDir#includes/getStructure.cfm">
				</cfif>

				<cfform action="entrpsup-comprem_action.cfm?lang=#lang#&companies=#companies#&info=#url.info#" method="post" id="remCompanyConfirmForm">
					<div>#language.areYouSure# <cfoutput><strong>#getCompany.Name#</strong></cfoutput>?</div>
						<input type="submit" value="#language.Remove#" class="textbutton" />
					</p>

					<input type="hidden" name="CID" value="#form.CID#" />
				</cfform>
				</cfoutput>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

