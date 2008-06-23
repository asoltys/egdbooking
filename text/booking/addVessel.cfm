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
	<meta name=""dc.title"" lang=""eng"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.AddVessel#"">
	<meta name=""keywords"" lang=""eng"" content=""#language.keywords#"">
	<meta name=""description"" lang=""eng"" content=""#language.description#"">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""#language.subjects#"">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.AddVessel#</title>">

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


<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-eng.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">#language.Admin#</A> &gt;
			<CFELSE>
				<a href="#RootDir#text/booking/booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			</CFIF>
			#language.AddVessel#
			</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-eng.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<CFOUTPUT>#language.AddVessel#</CFOUTPUT>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<cfoutput>
				<cfinclude template="#RootDir#includes/user_menu.cfm"><br>
			
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
			
				<cfform action="addVessel_process.cfm?lang=#lang#&amp;CompanyID=#CompanyID#" method="post" name="addVessel">
				<table align="center">
				<tr>
					<td id="CompanyName" width="40%"><label for="companyID">#language.CompanyName#:</label></td>
					<td headers="CompanyName">
						<cfif getCompanies.recordCount GT 1>
							<cfselect name="companyID" id="companyID" query="getCompanies" display="Name" value="companyID" selected="#variables.companyID#" />
						<cfelse>
							<cfoutput>#getCompanies.Name#</cfoutput>
							<cfoutput><input type="hidden" name="companyID" value="#getCompanies.companyID#"></cfoutput>
						</cfif>
						<!---<cfoutput>#getCompany.Name#</cfoutput>--->
					</td>
				</tr>
				<tr>
					<td id="vesselName"><label for="name">#language.vesselName#:</label></td>
					<td headers="vesselName"><cfinput name="name" id="name" type="text" value="#variables.name#" size="35" maxlength="100" required="yes" CLASS="textField" message="#language.nameError#"></td>
				</tr>
				<tr>
					<td id="LloydsID_header"><label for="LloydsID">#language.LloydsID#:</label></td>
					<td headers="LloydsID_header"><cfinput name="LloydsID" id="LloydsID" type="text" value="#variables.lloydsid#" size="20" maxlength="20" CLASS="textField" ></td>
				</tr>
				<tr>
					<td id="length_header"><label for="length">#language.Length#:</label></td>
					<td headers="length_header"><cfinput name="length" id="length" type="text" value="#variables.length#" size="8" maxlength="8" required="yes" validate="float" CLASS="textField" message="#language.lengthError#">  <span style="font-size: 9pt; color: red">#language.Max#: #Variables.MaxLength# m</span></td>
				</tr>
				<tr>
					<td id="width_header"><label for="width">#language.Width#:</label></td>
					<td headers="width_header"><cfinput name="width" id="width" type="text" value="#variables.width#" size="8" maxlength="8" required="yes" validate="float" CLASS="textField" message="#language.widthError#">  <span style="font-size: 9pt; color: red">#language.Max#: #Variables.MaxWidth# m</span></td>
				</tr>
				<tr>
					<td id="blocksetuptime_header"><label for="blocksetuptime">#language.BlockSetup# #language.days#:</label></td>
					<td headers="blocksetuptime_header"><cfinput name="blocksetuptime" id="blocksetuptime" type="text" value="#variables.blocksetuptime#" size="2" maxlength="2" required="yes" validate="float" CLASS="textField" message="#language.setupError#"></td>
				</tr>
				<tr>
					<td id="blockteardowntime_header"><label for="blockteardowntime">#language.BlockTeardown# #language.days#:</label></td>
					<td headers="blockteardowntime_header"><cfinput name="blockteardowntime" id="blockteardowntime" type="text" value="#variables.blockteardowntime#" size="2" maxlength="2" required="yes" validate="float" CLASS="textField" message="#language.teardownError#"></td>
				</tr>
				<tr>
					<td id="Tonnage_header"><label for="tonnage">#language.Tonnage#:</label></td>
					<td headers="Tonnage_header"><cfinput name="tonnage" id="tonnage" type="text" value="#variables.tonnage#" size="8" maxlength="8" required="yes" validate="float" CLASS="textField" message="#language.tonnageError#"></td>
				</tr>
				<tr>
					<td id="Anonymous_header"><label for="Anonymous">#language.anonymous#:</label></td>
					<td headers="Anonymous_header"><input type="checkbox" id="Anonymous" name="Anonymous" value="Yes"></td>
				</tr>
				<tr><td colspan="2"><P class="smallFont">*#language.anonymousWarning#</P></td></tr>
				<tr>
					<td colspan="2" align="center" style="padding-top:20px;">
						<!---a href="javascript:document.addVessel.submitForm.click();" class="textbutton">#language.Submit#</a--->
						<input type="submit" name="submitForm" class="textbutton" value="#language.Submit#">
						<cfoutput><input type="button" value="#language.Cancel#" onClick="self.location.href='booking.cfm?lang=#lang#&amp;CompanyID=#CompanyID#'" class="textbutton"></cfoutput>
						<br>
					</td>
				</tr>
				</table>
				</cfform>
				</CFOUTPUT>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
