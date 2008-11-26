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
	<meta name=""dc.title"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.AddVessel#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.AddVessel#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT Name, Companies.companyID
		FROM Companies INNER JOIN UserCompanies ON Companies.CompanyID = UserCompanies.CompanyID
		WHERE UserCompanies.UserID = #session.UserID# AND UserCompanies.Approved = 1
				AND Companies.Deleted = 0 AND UserCompanies.Deleted = 0 AND Companies.Approved = 1
	</cfquery>
</cflock>

<cfparam name="variables.userID" default="">
<cfparam name="variables.companyID" default="">
<cfif isDefined("url.companyID")>
	<cfset variables.companyID = #url.companyID#>
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
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			<CFELSE>
				<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
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

				<cfoutput>
				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">

				<cfinclude template="#RootDir#includes/getStructure.cfm">
				<cfinclude template="#RootDir#includes/restore_params.cfm">
				<cfif isDefined("session.form_structure")>
					<cfset variables.name = form.name>
					<cfset variables.length = form.length>
					<cfset variables.width = form.width>
					<cfset variables.blocksetuptime = form.blocksetuptime>
					<cfset variables.blockteardowntime = form.blockteardowntime>
					<cfset variables.lloydsid = form.lloydsId>
					<cfset variables.tonnage = form.tonnage>
				</cfif>

				<cfform action="#RootDir#reserve-book/navireajout-vesseladd_confirm.cfm?lang=#lang#&amp;CompanyID=#CompanyID#" method="post" id="addVessel">
					<fieldset>
						<label for="companyID">#language.CompanyName#:</label>
						<cfif getCompanies.recordCount GT 1>
							<cfselect name="companyID" id="companyID" query="getCompanies" display="Name" value="companyID" selected="#variables.companyID#" />
						<cfelse>
							<cfoutput>#getCompanies.Name#</cfoutput>
							<cfoutput><input type="hidden" name="companyID" value="#getCompanies.companyID#" /></cfoutput>
						</cfif>
						<br />


						<label for="name">#language.vesselName#:</label>
						<cfinput name="name" id="name" type="text" value="#variables.name#" size="35" maxlength="100" required="yes" message="#language.nameError#" />
						<br />

						<label for="LloydsID" id="lloyds_id">#language.LloydsID#:</label>
						<cfinput name="LloydsID" id="LloydsID" type="text" value="#variables.lloydsid#" size="20" maxlength="20" />
						<br />

						<label for="length">#language.Length#:</label>
						<cfinput name="length" id="length" type="text" value="#variables.length#" size="8" maxlength="8" required="yes" validate="float" message="#language.lengthError#" />  <span class="smallFont red">#language.Max#: #Variables.MaxLength# m</span>
						<br />

						<label for="width">#language.Width#:</label>
						<cfinput name="width" id="width" type="text" value="#variables.width#" size="8" maxlength="8" required="yes" validate="float" message="#language.widthError#" />  <span class="smallFont red">#language.Max#: #Variables.MaxWidth# m</span>
						<br />

						<label for="blocksetuptime" id="block_setup_time">#language.BlockSetup# #language.days#:</label>
						<cfinput name="blocksetuptime" id="blocksetuptime" type="text" value="#variables.blocksetuptime#" size="2" maxlength="2" required="yes" validate="float" message="#language.setupError#" />
						<br />

						<label for="blockteardowntime" id="block_teardown_time">#language.BlockTeardown# #language.days#:</label>
						<cfinput name="blockteardowntime" id="blockteardowntime" type="text" value="#variables.blockteardowntime#" size="2" maxlength="2" required="yes" validate="float" message="#language.teardownError#" />
						<br />

						<label for="tonnage">#language.Tonnage#:</label>
						<cfinput name="tonnage" id="tonnage" type="text" value="#variables.tonnage#" size="8" maxlength="8" required="yes" validate="float" message="#language.tonnageError#" />
						<br />

						<label for="Anonymous">#language.anonymous#:</label>
						<input type="checkbox" id="Anonymous" name="Anonymous" value="Yes" />
					</fieldset>

					<p class="smallFont">*#language.anonymousWarning#</p>

					<div class="buttons">
						<input type="submit" name="submitForm" class="textbutton" value="#language.Submit#" />
						<cfoutput><input type="button" value="#language.Cancel#" onclick="self.location.href='booking.cfm?lang=#lang#&amp;CompanyID=#CompanyID#'" class="textbutton" /></cfoutput>
					</div>
				</cfform>
				</cfoutput>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
