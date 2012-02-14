<cfoutput>
<cfinclude template="#RootDir#includes/vesselInfoVariables.cfm">

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
	<meta name=""dc.title"" content=""#language.AddVessel# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.AddVessel# - #language.esqGravingDock# - #language.PWGSC#</title>">
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


		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			</CFIF>
			#language.AddVessel#
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					#language.AddVessel#
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">

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

				<form action="#RootDir#reserve-book/navireajout-vesseladd_confirm.cfm?lang=#lang#&amp;CID=#CID#" method="post" id="addVessel">
					<fieldset>
						<legend>#language.addVessel#</legend>

						<div>
              <cfif getCompanies.recordCount GT 1>
                <label for="CID"><span title="#language.required#" class="required">*</span>#language.CompanyName#:</label>
                <select name="CID" id="CID" query="getCompanies" display="Name" value="CID" selected="#variables.CID#" />
              <cfelse>
                <label for="CID">#language.CompanyName#:</label>
                <input type="text" readonly="readonly" id="CID" name="CID" value="#getCompanies.Name#" />
              </cfif>
            </div>

            <div>
              <label for="name"><span title="#language.required#" class="required">*</span>&nbsp;#language.vesselName#:</label>
              <input name="name" id="name" type="text" value="#variables.name#" size="35" maxlength="100" />
            </div>

						<div>
              <label for="LloydsID" id="lloyds_id">#language.LloydsID#:</label>
              <input name="LloydsID" id="LloydsID" type="text" value="#variables.lloydsid#" size="20" maxlength="20" />
						</div>

						<div>
              <label for="length">#language.Length#:</label>
              <input name="length" id="length" type="text" value="#variables.length#" size="8" maxlength="8" />#language.Max#: #Variables.MaxLength#
						</div>

						<div>
              <label for="width">#language.Width#:</label>
              <input name="width" id="width" type="text" value="#variables.width#" size="8" maxlength="8" />#language.Max#: #Variables.MaxWidth#
						</div>

						<div>
              <label for="blocksetuptime" id="block_setup_time">#language.BlockSetup# #language.days#:</label>
              <input name="blocksetuptime" id="blocksetuptime" type="text" value="#variables.blocksetuptime#" size="2" maxlength="2" />
						</div>

						<div>
              <label for="blockteardowntime" id="block_teardown_time">#language.BlockTeardown# #language.days#:</label>
              <input name="blockteardowntime" id="blockteardowntime" type="text" value="#variables.blockteardowntime#" size="2" maxlength="2" />
						</div>

						<div>
              <label for="tonnage"><span title="#language.required#" class="required">*</span>&nbsp;#language.Tonnage#:</label>
              <input name="tonnage" id="tonnage" type="text" value="#variables.tonnage#" size="8" maxlength="8" />
						</div>

            <div>
              <label for="Anonymous">#language.anonymous#<sup>&dagger;</sup>:</label>
              <input type="checkbox" id="Anonymous" name="Anonymous" value="Yes" />
            </div>

            <div>
              <input type="submit" name="submitForm" value="#language.Submit#" />
            </div>
					</fieldset>
				</form>

        <p>&dagger;&nbsp;#language.anonymousWarning#</p>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
</cfoutput>
