<cfif isDefined("form.name")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfif lang EQ "eng">
	<cfset language.keywords = language.masterKeywords & ", Add New Vessel">
	<cfset language.description = "Allows user to create a new vessel.">
	<cfset language.subjects = language.masterSubjects & "">
<cfelse>
	<cfset language.keywords = language.masterKeywords & ", Ajout d'un nouveau navire">
	<cfset language.description = "Permet &agrave; l'utilisateur de cr&eacute;er un nouveau navire.">
	<cfset language.subjects = language.masterSubjects & "">
</cfif>

<cfset return_url = "#RootDir#reserve-book/navireajout-vesseladd.cfm?lang=#lang#" />
<cfinclude template="#RootDir#reserve-book/includes/vesselValidation.cfm" />

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""#language.AddVessel# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dcterms.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.AddVessel# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">



<cfif isDefined("form.CID")>
	<cfset url.CID = #form.CID#>
<cfelse>
	<cflocation addtoken="no" url="#RootDir#reserve-book/navireajout-vesseladd.cfm?lang=#lang#">
</cfif>

<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Companies.CID, Companies.Name AS CompanyName
	FROM  	Companies
	WHERE 	CID = <cfqueryparam value="#url.CID#" cfsqltype="cf_sql_integer" />
	AND		Deleted = '0'
</cfquery>

<cfif getCompany.recordCount EQ 0>
	<cflocation addtoken="no" url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#&CID=#url.CID#">
</cfif>

<cfset Variables.CID = getCompany.CID>
<cfset Variables.CompanyName = getCompany.CompanyName>
<cfset Variables.Name = Form.Name>
<cfset Variables.Length = Form.Length>
<cfset Variables.Width = Form.Width>
<cfset Variables.BlockSetupTime = Form.BlockSetupTime>
<cfset Variables.BlockTearDownTime = Form.BlockTearDownTime>
<cfset Variables.LloydsID = Form.LloydsID>
<cfset Variables.Tonnage = Form.Tonnage>
<cfparam name="Variables.Anonymous" default="0">
<cfif IsDefined("Form.Anonymous")>
	<cfset Variables.Anonymous = 1>
</cfif>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			</CFIF>
			#language.AddVessel#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.AddVessel#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
				<cfoutput>
				<p>#language.confirmInfo#</p>
				<cfif Variables.Width GT Variables.MaxWidth OR Variables.Length GT Variables.MaxLength>
					<div id="actionErrors">#language.boatTooBig# (#Variables.MaxLength#m x #Variables.MaxWidth#m).</div>
				</cfif>

				<form id="addVessel" action="#RootDir#reserve-book/navireajout-vesseladd_action.cfm?lang=#lang#&amp;CID=#url.CID#" method="post">
					<fieldset>
					<legend>#language.addVessel#</legend>
						<div>
              <label for="CID">#language.CompanyName#:</label>
              <input type="hidden" id="CID" name="CID" value="#Variables.CID#" />
              <p>#variables.CompanyName#</p>
						</div>

						<div>
              <label for="Anonymous">#language.vesselName#:</label>
              <input type="hidden" id="name" name="name" value="#Variables.Name#" />
              <p>#variables.Name#</p>
						</div>

						<div>
              <label for="length">#language.Length#:</label>
              <input type="hidden" id="length" name="length" value="#Variables.Length#" />
              <p>#variables.Length#</p>
						</div>

						<div>
              <label for="width">#language.Width#:</label>
              <input type="hidden" id="width" name="width" value="#Variables.Width#" />
              <p>#variables.Width#</p>
						</div>

						<div>
              <label for="blocksetuptime">#language.BlockSetup# #language.days#:</label>
              <input type="hidden" id="blocksetuptime" name="blocksetuptime" value="#Variables.BlockSetuptime#" />
              <p id="block_setuptime">#variables.BlockSetuptime#</p>
						</div>

						<div>
              <label for="blockteardowntime">#language.BlockTeardown# #language.days#:</label>
              <input type="hidden" id="blockteardowntime" name="blockteardowntime" value="#Variables.Blockteardowntime#" />
              <p id="block_teardown_time">#variables.Blockteardowntime#</p>
						</div>

						<div>
              <label for="LloydsID">#language.LloydsID#:</label>
              <input type="hidden" id="LloydsID" name="LloydsID" value="#Variables.LloydsID#" />
              <p id="lloyds_id">#variables.LloydsID#</p>
						</div>

						<div>
              <label for="tonnage">#language.Tonnage#:</label>
              <input type="hidden" id="tonnage" name="tonnage" value="#Variables.Tonnage#" />
              <p>#variables.Tonnage#</p>
						</div>

						<div>
              <label for="Anonymous">#language.anonymous#:</label>
              <input type="hidden" id="Anonymous" name="Anonymous" value="#Variables.Anonymous#" />
              <p>#variables.Anonymous#</p>
						</div>
					</fieldset>

					<div class="buttons">
						<input type="submit" name="submitForm" value="#language.Submit#" class="textbutton" />
					</div>

				</form>
				</cfoutput>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
