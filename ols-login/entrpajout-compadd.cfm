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
	<meta name=""dcterms.title"" content=""#language.CreateUser# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dcterms.subject"" content=""#language.masterSubjects#"" />
	<title>#language.CreateUser# - #language.esqGravingDock# - #language.PWGSC#</title>">
	<cfset request.title = language.createComp />
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

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
					<cfparam name="err_compname" default="">
					<cfparam name="err_phone" default="">
					<cfparam name="err_address1" default="">
					<cfparam name="err_city" default="">
					<cfparam name="err_province" default="">
					<cfparam name="err_country" default="">
					<cfparam name="err_zip" default="">

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

					<cfif not error("name") EQ "">
  						<cfset err_compname = "form-attention" />
					</cfif>
					<cfif not error("phone") EQ "">
  						<cfset err_phone = "form-attention" />
					</cfif>
					<cfif not error("address1") EQ "">
  						<cfset err_address1 = "form-attention" />
					</cfif>
					<cfif not error("city") EQ "">
  						<cfset err_city = "form-attention" />
					</cfif>
					<cfif not error("province") EQ "">
  						<cfset err_province = "form-attention" />
					</cfif>
					<cfif not error("country") EQ "">
  						<cfset err_country = "form-attention" />
					</cfif>
					<cfif not error("zip") EQ "">
  						<cfset err_zip = "form-attention" />
					</cfif>

					<cfif IsDefined("Session.Return_Structure")>
					<!--- Populate the Variables Structure with the Return Structure.
							Also display any errors returned --->
					<cfinclude template="#RootDir#includes/getStructure.cfm">
					</cfif>

					<form name="addCompanyForm" action="entrpajout-compadd_action.cfm?lang=#lang#&amp;info=#url.info#&amp;companies=#url.companies#" id="addCompanyForm" method="post">
            <fieldset>	
              <div class="#err_compname#">
                <label for="name"><abbr title="#language.required#" class="required">*</abbr>#language.companyName#:</label>
                <input name="name" id="name" type="text" size="40" maxlength="75" value="#Variables.name#" />
                <span class="form-text-inline">#error('name')#</span>
              </div>
            
              <div class="#err_address1#">
                <label for="address1"><abbr title="#language.required#" class="required">*</abbr>#language.Address# 1:</label>
                <input name="address1" id="address1" type="text" size="40" maxlength="75" value="#Variables.address1#" />
                <span class="form-text-inline">#error('address1')#</span>
              </div>
            
              <div>
                <label for="address2">#language.Address# 2 #language.optional#:</label>
                <input name="address2" id="address2" type="text" size="40" maxlength="75" value="#Variables.address2#" />
              </div>
            
              <div class="#err_city#">
                <label for="city"><abbr title="#language.required#" class="required">*</abbr>#language.City#:</label>
                <input name="city" id="city" type="text" size="25" maxlength="40" value="#Variables.city#" />
                <span class="form-text-inline">#error('city')#</span>
              </div>
            
              <div class="#err_province#">
                <label for="province"><abbr title="#language.required#" class="required">*</abbr>#language.Province#:</label>
                <input name="province" id="province" type="text" size="25" maxlength="40" value="#Variables.province#" />
                <span class="form-text-inline">#error('province')#</span>
              </div>
            
              <div class="#err_country#">
                <label for="country"><abbr title="#language.required#" class="required">*</abbr>#language.Country#:</label>
                <input name="country" id="country" type="text" size="25" maxlength="40" value="#Variables.country#" />
                <span class="form-text-inline">#error('country')#</span>
              </div>
            
              <div class="#err_zip#">
                <label for="zip"><abbr title="#language.required#" class="required">*</abbr>#language.zip#:</label>
                <input name="zip" id="zip" type="text" size="12" maxlength="10" value="#Variables.zip#" />
                <span class="form-text-inline">#error('zip')#</span>
              </div>

              <div class="#err_phone#">
                <label for="phone"><abbr title="#language.required#" class="required">*</abbr>#language.Phone#:</label>
                <input name="phone" id="phone" type="text" size="25" maxlength="32" value="#Variables.phone#" />
                <span class="form-text-inline">#error('phone')#</span>
              </div>
            
              <div>
                <label for="fax">#language.Fax# #language.optional#:</label>
                <input id="fax" name="fax" type="text" size="10" maxlength="32" />
              </div>
            
              <input type="submit" name="submitForm" class="button button-accent" value="#language.Submit#" />
            </fieldset>
					</form>
				</cfoutput>
			</div>
      <!-- CONTENT ENDS | FIN DU CONTENU -->
		
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">



