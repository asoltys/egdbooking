<cfinclude template="#RootDir#includes/companyInfoVariables.cfm">
<cfif lang EQ "eng">
	<cfset language.createComp = "Create New Company">
	<cfset language.keywords = "#language.masterKeywords#" & ", Add New Company">
	<cfset language.description = "Allows user to create a new company.">
	<cfset language.subjects = "#language.masterSubjects#">
	<cfset language.createUser = "Create New User">
<cfelse>
	<cfset language.createComp = "Cr&eacute;er une nouvelle entreprise">
	<cfset language.keywords = "#language.masterKeywords#" & ", Ajout d'une entreprise">
	<cfset language.description = "Permet &agrave; l'utilisateur de cr&eacute;er un nouveau compte pour une entreprise.">
	<cfset language.subjects = "#language.masterSubjects#">
	<cfset language.createUser = "Cr&eacute;er un nouvel utilisateur">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.CreateUser# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.masterSubjects#"" />
	<title>#language.CreateUser# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<a href="#RootDir#ols-login/ols-login.cfm?lang=#lang#">#language.login#</a> &gt;
			#language.CreateComp#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
      <div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.CreateComp#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

					<cfoutput>
					<cfparam name="Variables.name" default="">
					<cfparam name="Variables.address1" default="">
					<cfparam name="Variables.address2" default="">
					<cfparam name="Variables.city" default="">
					<cfparam name="Variables.province" default="">
					<cfparam name="Variables.country" default="">
					<cfparam name="Variables.zip" default="">
					<cfparam name="Variables.phone" default="">
					<cfparam name="Variables.fax" default="">

					<cfinclude template="#RootDir#includes/restore_params.cfm">
					<cfif isDefined("session.form_structure") AND isDefined("form.name")>
						<cfset variables.name="#form.name#">
						<cfset variables.address1="#form.address1#">
						<cfset variables.address2="#form.address2#">
						<cfset variables.city="#form.city#">
						<cfset variables.province="#form.province#">
						<cfset variables.country="#form.country#">
						<cfset variables.zip="#form.zip#">
						<cfset variables.phone="#form.phone#">
						<cfset variables.fax="#form.fax#">
					</cfif>

					<cfif isDefined("Session.Return_Structure")>
						<cfinclude template="#RootDir#includes/getStructure.cfm">
					</cfif>

					<form name="addCompanyForm" action="entrpajout-compadd_action.cfm?lang=#lang#&amp;info=#url.info#&amp;companies=#url.companies#" id="addCompanyForm" method="post" onsubmit="if(!checkFilledIn('addCompanyForm')) { return false;
	}">
            <label for="name">#language.companyName#:</label>
            <input name="name" id="name" type="text" size="40" maxlength="75" value="#Variables.name#" />
            <br />
          
            <label for="address1">#language.Address# 1:</label>
            <input name="address1" id="address1" type="text" size="40" maxlength="75" value="#Variables.address1#" />
            <br />
          
            <label for="address2">#language.Address# 2 #language.optional#:</label>
            <input name="address2" id="address2" type="text" size="40" maxlength="75" value="#Variables.address2#" />
            <br />
          
            <label for="city">#language.City#:</label>
            <input name="city" id="city" type="text" size="25" maxlength="40" value="#Variables.city#" />
            <br />
          
            <label for="province">#language.Province#:</label>
            <input name="province" id="province" type="text" size="25" maxlength="40" value="#Variables.province#" />
            <br />
          
            <label for="country">#language.Country#:</label>
            <input name="country" id="country" type="text" size="25" maxlength="40" value="#Variables.country#" />
            <br />
          
            <label for="zip">#language.zip#:</label>
            <input name="zip" id="zip" type="text" size="12" maxlength="10" value="#Variables.zip#" />
            <br />
          
            <label for="phone">#language.Phone#:</label>
            <input name="phone" id="phone" type="text" size="25" maxlength="32" value="#Variables.phone#" />
            <br />
          
            <label for="fax">#language.Fax# #language.optional#:</label>
            <input id="fax" name="fax" type="text" size="10" maxlength="32" />
          
            <fieldset>	
              <input type="submit" name="submitForm" class="textbutton" value="#language.Submit#" />
              <a href="entrpdemande-comprequest.cfm?lang=#lang#&amp;info=#url.info#&amp;companies=#url.companies#" class="textbutton">#language.Cancel#</a>							
            </fieldset>
					</form>
				</cfoutput>
			</div>
      <!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">



