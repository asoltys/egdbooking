<cfif isDefined("form.name")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfinclude template="#RootDir#includes/vesselInfoVariables.cfm">
<cfif lang EQ "e">
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
	<cflocation url="addVessel.cfm?lang=#lang#&CompanyID=#CompanyID#" addtoken="no">
</cfif>

<cfoutput>
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


	<cfinclude template="#RootDir#includes/header-#lang#.cfm">

	<div class="breadcrumbs">
		<a href="http://www.pwgsc.gc.ca/text/home-#lang#.html">#language.PWGSC#</a> &gt;
		#language.PacificRegion# &gt;
		<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-#lang#.html">#language.EsqGravingDock#</a> &gt;
		<a href="#RootDir#text/booking-#lang#.cfm">#language.Booking#</A> &gt;
		<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
		<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">#language.Admin#</A> &gt;
	<CFELSE>
		<a href="#RootDir#text/booking/booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
	</CFIF>
		#language.AddVessel#
	</div>
</cfoutput>

<cfif isDefined("form.companyID")>
	<cfset url.companyID = #form.companyID#>
<cfelse>
	<cflocation addtoken="no" url="addVessel.cfm?lang=#lang#">
</cfif>

<CFQUERY name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Companies.CompanyID, Companies.Name AS CompanyName
	FROM  	Companies
	WHERE 	CompanyID = '#url.CompanyID#'
	AND		Deleted = '0'
</CFQUERY>

<cfif getCompany.recordCount EQ 0>
	<cflocation addtoken="no" url="booking.cfm?lang=#lang#&CompanyID=#url.companyID#">
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

<cfoutput>
	<div class="main">
	<H1>#language.AddVessel#</H1>
	<cfinclude template="#RootDir#includes/user_menu.cfm"><br>

	<p>#language.confirmInfo#</p>
	<cfif Variables.Width GT Variables.MaxWidth OR Variables.Length GT Variables.MaxLength>
		<p><span class="red"><strong>#language.boatTooBig# (<cfoutput>#Variables.MaxLength#m x #Variables.MaxWidth#m</cfoutput>).</strong></span></p>
	</cfif>
	<cfform name="addVessel" action="addVessel_action.cfm?lang=#lang#&CompanyID=#url.companyID#" method="post">

		<table align="center">
			<tr>
			<td id="CompanyName">#language.CompanyName#:</td>
			<td headers="CompanyName"><input type="hidden" name="CompanyID" value="#Variables.CompanyID#">#Variables.CompanyName#</td>
		</tr>
		<tr>
			<td id="vesselName">#language.vesselName#:</td>
			<td headers="vesselName"><input type="hidden" name="name" value="#Variables.Name#">#Variables.Name#</td>
		</tr>
		<tr>
			<td id="Length">#language.Length#:</td>
			<td headers="Length"><input type="hidden" name="length" value="#Variables.Length#">#Variables.Length# m</td>
		</tr>
		<tr>
			<td id="Width">#language.Width#:</td>
			<td headers="Width"><input type="hidden" name="width" value="#Variables.Width#">#Variables.Width# m</td>
		</tr>
		<tr>
			<td id="BlockSetup">#language.BlockSetup# #language.days#:</td>
			<td headers="BlockSetup"><input type="hidden" name="blocksetuptime" value="#Variables.BlockSetuptime#">#Variables.Blocksetuptime#</td>
		</tr>
		<tr>
			<td id="BlockTeardown">#language.BlockTeardown# #language.days#:</td>
			<td headers="BlockTeardown"><input type="hidden" name="blockteardowntime" value="#Variables.Blockteardowntime#">#Variables.Blockteardowntime#</td>
		</tr>
		<tr>
			<td id="LloydsID">#language.LloydsID#:</td>
			<td headers="LloydsID"><input type="hidden" name="LloydsID" value="#Variables.LloydsID#">#Variables.LloydsID#</td>
		</tr>
		<tr>
			<td id="Tonnage">#language.Tonnage#:</td>
			<td headers="Tonnage"><input type="hidden" name="tonnage" value="#Variables.Tonnage#">#Variables.Tonnage#</td>
		</tr>
		<tr>
			<td id="anonymous">#language.anonymous#:</td>
			<td headers="anonymous"><input type="hidden" name="Anonymous" value="#Variables.Anonymous#"><cfif Variables.Anonymous EQ 1>#language.Yes#<cfelse>#language.No#</cfif></td>
		</tr>
		<tr>
			<td colspan="2" align="center" style="padding-top:20px;">
				<!---a href="javascript:document.addVessel.submitForm.click();" class="textbutton">#language.Submit#</a>
				<a href="javascript:history.go(-1);" class="textbutton">#language.Back#</a>
				<a href="booking.cfm?lang=#lang#&CompanyID=#CompanyID#" class="textbutton">#language.Cancel#</a>
				<br--->
				<input type="submit" name="submitForm" value="#language.Submit#" class="textbutton">
				<input type="button" name="back" value="#language.Back#" onClick="self.location.href='addVessel.cfm?lang=#lang#&CompanyID=#CompanyID#'" class="textbutton">
				<input type="button" name="cancel" value="#language.Cancel#" onClick="self.location.href='booking.cfm?lang=#lang#&CompanyID=#CompanyID#'" class="textbutton">
			</td>
		</tr>
	</table>
</cfform>
</cfoutput>

</div>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">