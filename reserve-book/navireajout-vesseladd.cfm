<cfoutput>

<cfif lang EQ "eng">
	<cfset language.addVessel = "Add New Vessel">
	<cfset language.keywords = language.masterKeywords & ", Add New Vessel">
	<cfset language.description = "Allows user to create a new vessel.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.companyName = "Company Name">
	<cfset language.anonymousWarning = "Anonymous vessels are only anonymous to other companies' users.  The Esquimalt Graving Dock administrators have access to all vessel information regardless of anonymity.">
<cfelse>
	<cfset language.addVessel = "Ajout d'un nouveau navire">
	<cfset language.keywords = language.masterKeywords & ", Ajout d'un nouveau navire">
	<cfset language.description = "Permet &agrave; l'utilisateur de cr&eacute;er un nouveau navire.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.companyName = "Raison sociale">
	<cfset language.anonymousWarning = "Les navires anonymes ne sont anonymes qu'aux utilisateurs d'autres entreprises. Les administrateurs de la cale s&egrave;che d'Esquimalt ont acc&egrave;s &agrave; la totalit&eacute; de l'information concernant les navires, peu importe l'anonymat.">
</cfif>

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""#language.AddVessel# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dcterms.subject"" content=""#language.subjects#"" />
	<title>#language.AddVessel# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfset request.title = language.addVessel />
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT Name, Companies.CID
		FROM Companies INNER JOIN UserCompanies ON Companies.CID = UserCompanies.CID
		WHERE UserCompanies.UID = <cfqueryparam value="#session.UID#" cfsqltype="cf_sql_integer" /> AND UserCompanies.Approved = 1
				AND Companies.Deleted = 0 AND UserCompanies.Deleted = 0 AND Companies.Approved = 1
	</cfquery>
</cflock>

<cfparam name="variables.UID" default="">
<cfparam name="variables.CID" default="">
<cfif isDefined("url.CID")>
	<cfset variables.CID = #url.CID#>
</cfif>
<cfparam name="variables.name" default="">
<cfparam name="variables.length" default="">
<cfparam name="variables.width" default="">
<cfparam name="variables.blocksetuptime" default="">
<cfparam name="variables.blockteardowntime" default="">
<cfparam name="variables.lloydsid" default="">
<cfparam name="variables.tonnage" default="">
<cfparam name="err_name" default="">
<cfparam name="err_lgt" default="">
<cfparam name="err_wdt" default="">
<cfparam name="err_bst" default="">
<cfparam name="err_btt" default="">
<cfparam name="err_ton" default="">


				<h1 id="wb-cont">#language.AddVessel#</h1>

				<cfinclude template="#RootDir#includes/user_menu.cfm">

				<cfinclude template="#RootDir#includes/getStructure.cfm">
				<cfinclude template="#RootDir#includes/restore_params.cfm">
				<cfif structKeyExists(session, 'form_structure') and structKeyExists(form, 'name')>
					<cfset variables.name = form.name>
					<cfset variables.length = form.length>
					<cfset variables.width = form.width>
					<cfset variables.blocksetuptime = form.blocksetuptime>
					<cfset variables.blockteardowntime = form.blockteardowntime>
					<cfset variables.lloydsid = form.lloydsId>
					<cfset variables.tonnage = form.tonnage>
				</cfif>

        <cfif not #error("name")# EQ "">
              <cfset err_name = "form-attention" />
        </cfif>
        <cfif not #error("length")# EQ "">
              <cfset err_lgt = "form-attention" />
        </cfif>
        <cfif not #error("width")# EQ "">
              <cfset err_wdt = "form-attention" />
        </cfif>
        <cfif not #error("blocksetuptime")# EQ "">
              <cfset err_bst = "form-attention" />
        </cfif>
        <cfif not #error("blockteardowntime")# EQ "">
              <cfset err_btt = "form-attention" />
        </cfif>
        <cfif not #error("tonnage")# EQ "">
              <cfset err_ton = "form-attention" />
        </cfif>

				<form action="#RootDir#reserve-book/navireajout-vesseladd_confirm.cfm?lang=#lang#&amp;CID=#CID#" method="post" id="addVessel">
					<fieldset>
						<legend>#language.addVessel#</legend>
            <p>#language.requiredFields#</p>

						<div>
              <cfif getCompanies.recordCount GT 1>
                <label for="CID">
                  <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                  #language.CompanyName#:
                </label>
                <select name="CID" id="CID" query="getCompanies" display="Name" value="CID" selected="#variables.CID#" />
              <cfelse>
                <label for="CID">#language.CompanyName#:</label>
                <input type="text" disabled="disabled" readonly="readonly" value="#getCompanies.Name#" />
                <input type="hidden" id="CID" name="CID" value="#getCompanies.CID#" />
              </cfif>
            </div>

            <div>
              <label for="name">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.vesselName#:
              </label>
            </div>
            <div class="#err_name#">
              <input name="name" id="name" type="text" value="#variables.name#" size="35" maxlength="100" />
              <span class="form-text-inline">#error("name")#</span>
            </div>
            
						<div>
              <label for="LloydsID" id="lloyds_id">#language.LloydsID#:</label>
              <input name="LloydsID" id="LloydsID" type="text" value="#variables.lloydsid#" size="20" maxlength="20" />
						</div>

						<div>
              <label for="length">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.Length#:
              </label>
            </div>
            <div class="#err_lgt#">
              <input name="length" id="length" type="text" value="#variables.length#" size="8" maxlength="8"/>
              <span class="color-medium">(#language.Max#: #Variables.MaxLength#)</span>
              <span class="form-text-inline">#error("length")#</span>
						</div>
            
						<div>
              <label for="width">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.Width#:
              </label>
            </div>
            <div class="#err_wdt#">
              <input name="width" id="width" type="text" value="#variables.width#" size="8" maxlength="8" />
              <span class="color-medium">(#language.Max#: #Variables.MaxWidth#)</span>
              <span class="form-text-inline">#error("width")#</span>
						</div>
            
						<div>
              <label for="blocksetuptime" id="block_setup_time">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.BlockSetup# #language.days#:
              </label>
            </div>
            <div class="#err_bst#">
              <input name="blocksetuptime" id="blocksetuptime" type="text" value="#variables.blocksetuptime#" size="2" maxlength="2" />
              <span class="form-text-inline">#error("blocksetuptime")#</span>
						</div>
            
						<div>
              <label for="blockteardowntime" id="block_teardown_time">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.BlockTeardown# #language.days#:
              </label>
            </div>
            <div class="#err_btt#">
              <input name="blockteardowntime" id="blockteardowntime" type="text" value="#variables.blockteardowntime#" size="2" maxlength="2" />
              <span class="form-text-inline">#error("blockteardowntime")#</span>
						</div>
            
						<div>
              <label for="tonnage">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.Tonnage#:
              </label>
            </div>
            <div class="#err_ton#">
              <input name="tonnage" id="tonnage" type="text" value="#variables.tonnage#" size="8" maxlength="8" />
              <span class="form-text-inline">#error("tonnage")#</span>
						</div>
            
            <div>
              <label for="Anonymous">#language.anonymous#<sup><a href="##fn" title="#language.footnote#"><span class="navaid">#language.footnote#</span>&dagger;</a></sup>:</label>
              <input type="checkbox" id="Anonymous" name="Anonymous" value="Yes" />
            </div>

            <div>
              <input type="submit" class="button button-accent" name="submitForm" value="#language.Submit#" />
            </div>
					</fieldset>
				</form>

        <p id="fn">&dagger;&nbsp;#language.anonymousWarning#</p>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
</cfoutput>
