<cfif isDefined("form.name")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfinclude template="#RootDir#includes/vesselInfoVariables.cfm">
<cfif lang EQ "eng">
	<cfset language.addVessel = "Add New Vessel">
	<cfset language.keywords = language.masterKeywords & ", Add New Vessel">
	<cfset language.description = "Allows user to create a new vessel.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.companyName = "Company Name">
	<cfset language.confirmInfo = "Please confirm the following information:">
	<cfset language.boatTooBig = "Note: The ship measurements exceed the maximum dimensions of the dock">
	<cfset language.yes = "Yes">
	<cfset language.no = "No">
	<cfset language.nameError = "Please enter the vessel name.">
<cfelse>
	<cfset language.addVessel = "Ajout d'un nouveau navire">
	<cfset language.keywords = language.masterKeywords & ", Ajout d'un nouveau navire">
	<cfset language.description = "Permet &agrave; l'utilisateur de cr&eacute;er un nouveau navire.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.companyName = "Raison sociale">
	<cfset language.confirmInfo = "Veuillez confirmer l'information suivante&nbsp;: ">
	<cfset language.boatTooBig = "Note&nbsp;: Les dimensions du navire d&eacute;passent celles de la cale s&egrave;che">
	<cfset language.yes = "Oui">
	<cfset language.no = "Non">
	<cfset language.nameError = "Veuillez entrer le nom du navire.">
</cfif>

<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif trim(form.name) EQ "">
	<cfoutput>#ArrayAppend(Variables.Errors, "#language.nameError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="#RootDir#reserve-book/navireajout-vesseladd.cfm?lang=#lang#&CompanyID=#CompanyID#" addtoken="no">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.AddVessel#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.AddVessel#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">



<cfif isDefined("form.companyID")>
	<cfset url.companyID = #form.companyID#>
<cfelse>
	<cflocation addtoken="no" url="#RootDir#reserve-book/navireajout-vesseladd.cfm?lang=#lang#">
</cfif>

<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Companies.CompanyID, Companies.Name AS CompanyName
	FROM  	Companies
	WHERE 	CompanyID = '#url.CompanyID#'
	AND		Deleted = '0'
</cfquery>

<cfif getCompany.recordCount EQ 0>
	<cflocation addtoken="no" url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#&CompanyID=#url.companyID#">
</cfif>

<cfset Variables.CompanyID = getCompany.CompanyID>
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
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
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

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
				<cfoutput>
				<p>#language.confirmInfo#</p>
				<cfif Variables.Width GT Variables.MaxWidth OR Variables.Length GT Variables.MaxLength>
					<div id="actionErrors">#language.boatTooBig# (#Variables.MaxLength#m x #Variables.MaxWidth#m).</div>
				</cfif>
				
				<cfform name="addVessel" action="#RootDir#reserve-book/navireajout-vesseladd_action.cfm?lang=#lang#&CompanyID=#url.companyID#" method="post">
			
				<table align="center">
					<tr>
						<td id="CompanyName">#language.CompanyName#:</td>
						<td headers="CompanyName"><input type="hidden" name="CompanyID" value="#Variables.CompanyID#" />
					</tr>
					<tr>
						<td id="vesselName">#language.vesselName#:</td>
						<td headers="vesselName"><input type="hidden" name="name" value="#Variables.Name#" />
					</tr>
					<tr>
						<td id="Length">#language.Length#:</td>
						<td headers="Length"><input type="hidden" name="length" value="#Variables.Length#" />
					</tr>
					<tr>
						<td id="Width">#language.Width#:</td>
						<td headers="Width"><input type="hidden" name="width" value="#Variables.Width#" />
					</tr>
					<tr>
						<td id="BlockSetup">#language.BlockSetup# #language.days#:</td>
						<td headers="BlockSetup"><input type="hidden" name="blocksetuptime" value="#Variables.BlockSetuptime#" />
					</tr>
					<tr>
						<td id="BlockTeardown">#language.BlockTeardown# #language.days#:</td>
						<td headers="BlockTeardown"><input type="hidden" name="blockteardowntime" value="#Variables.Blockteardowntime#" />
					</tr>
					<tr>
						<td id="LloydsID">#language.LloydsID#:</td>
						<td headers="LloydsID"><input type="hidden" name="LloydsID" value="#Variables.LloydsID#" />
					</tr>
					<tr>
						<td id="Tonnage">#language.Tonnage#:</td>
						<td headers="Tonnage"><input type="hidden" name="tonnage" value="#Variables.Tonnage#" />
					</tr>
					<tr>
						<td id="anonymous">#language.anonymous#:</td>
						<td headers="anonymous"><input type="hidden" name="Anonymous" value="#Variables.Anonymous#" />
					</tr>
					<tr>
						<td colspan="2" align="center" style="padding-top:20px;">
							<!---a href="javascript:document.addVessel.submitForm.click();" class="textbutton">#language.Submit#</a>
							<a href="javascript:history.go(-1);" class="textbutton">#language.Back#</a>
							<a href="reserve-booking.cfm?lang=#lang#&CompanyID=#CompanyID#" class="textbutton">#language.Cancel#</a>
							<br--->
							<input type="submit" name="submitForm" value="#language.Submit#" class="textbutton" />
							<input type="button" name="back" value="#language.Back#" onclick="self.location.href='addVessel.cfm?lang=#lang#&CompanyID=#CompanyID#'" class="textbutton" />
							<input type="button" name="cancel" value="#language.Cancel#" onclick="self.location.href='booking.cfm?lang=#lang#&CompanyID=#CompanyID#'" class="textbutton" />
						</td>
					</tr>
				</table>
				</cfform>
				</cfoutput>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
