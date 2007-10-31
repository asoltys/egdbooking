<cfif isDefined("form.name")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">


<cfinclude template="#RootDir#includes/vesselInfoVariables.cfm">
<cfif lang EQ "e">
	<cfset language.editVessel = "Edit Vessel">
	<cfset language.keywords = language.masterKeywords & ", Edit Vessel">
	<cfset language.description = "Allows user to edit the details of a vessel.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.companyName = "Company Name">
	<cfset language.reset = "Reset">
	<cfset language.confirmInfo = "Please confirm the following information:">
	<cfset language.note = "Note: The ship measurements exceed the maximum dimensions of the dock">
	<cfset language.nameError = "Please enter the vessel name.">
	<cfset language.days = "days">
	<cfset language.yes = "Yes">
	<cfset language.no = "No">
	<cfset language.anon = "Anonymous">
<cfelse>
	<cfset language.editVessel = "Modifier le navire">
	<cfset language.keywords = language.masterKeywords & ", Modifier le navire">
	<cfset language.description = "Permet &agrave; l'utilisateur de modifier les d&eacute;tails concernant un navire.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.companyName = "Raison sociale">
	<cfset language.reset = "R&eacute;initialiser">
	<cfset language.confirmInfo = "Veuillez confirmer l'information suivante&nbsp;: ">
	<cfset language.note = "Nota : les dimensions du navire dépassent la capacité maximale du navire">
	<cfset language.nameError = "Veuillez entrer le nom du navire.">
	<cfset language.days = "jours">
	<cfset language.yes = "Oui">
	<cfset language.no = "Non">
	<cfset language.anon = "Anonyme">
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
	<meta name=""dc.title"" lang=""eng"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.EditVessel#"">
	<meta name=""keywords"" lang=""eng"" content=""#language.keywords#"">
	<meta name=""description"" lang=""eng"" content=""#language.description#"">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""#language.subjects#"">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.EditVessel#</title>">

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
		#language.EditVessel#
	</div>
</cfoutput>

<CFQUERY name="getVesselDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Vessels.*, Companies.CompanyID, Companies.Name AS CompanyName
	FROM  Vessels INNER JOIN Companies ON Vessels.CompanyID = Companies.CompanyID
	WHERE VesselID = #url.VesselID#
	AND Vessels.Deleted = 0
</CFQUERY>

<cfif getVesselDetail.recordCount EQ 0>
	<cflocation addtoken="no" url="booking.cfm?lang=#lang#&CompanyID=#url.companyID#">
</cfif>

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
	<H1>#language.EditVessel#</H1>
	<cfinclude template="#RootDir#includes/user_menu.cfm"><br>

	<p>#language.confirmInfo#</p>
	<cfif Variables.Width GT Variables.MaxWidth OR Variables.Length GT Variables.MaxLength>
		<p><span class="red"><strong>#language.Note# (<cfoutput>#Variables.MaxLength#m x #Variables.MaxWidth#m</cfoutput>).</strong></span></p>
	</cfif>
</cfoutput>
<cfform name="editVessel" action="EditVessel_action.cfm?lang=#lang#&CompanyID=#url.companyID#" method="post">
<cfoutput>
	<table align="center">
		<tr>
			<td id="CompanyName">#language.CompanyName#:</td>
			<td headers="CompanyName">#getVesselDetail.CompanyName#</td>
		</tr>
		<tr>
			<td id="vessel">#language.vessel#:</td>
			<td headers="vessel"><input type="hidden" name="name" value="#Variables.Name#">#Variables.Name#</td>
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
			<td id="BlockSetup">#language.BlockSetup#:</td>
			<td headers="BlockSetup"><input type="hidden" name="blocksetuptime" value="#Variables.Blocksetuptime#">#Variables.Blocksetuptime# #language.days#</td>
		</tr>
		<tr>
			<td id="BlockTeardown">#language.BlockTeardown#:</td>
			<td headers="BlockTeardown"><input type="hidden" name="blockteardowntime" value="#Variables.Blockteardowntime#">#Variables.Blockteardowntime# #language.days#</td>
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
			<td id="anonymous">#language.anon#:</td>
			<td headers="anonymous"><input type="hidden" name="Anonymous" value="#Variables.Anonymous#"><cfif Variables.Anonymous EQ 1>#language.yes#<cfelse>#language.no#</cfif></td>
		</tr>
		<tr>
			<td colspan="2" align="center" style="padding-top:20px;">
				<input type="submit" value="#language.Submit#" class="textbutton">
				<input type="button" onClick="javascript:self.location.href='editVessel.cfm?lang=#lang#&CompanyID=#url.companyID#&vesselID=#url.vesselID#'" value="#language.Back#" class="textbutton">
				<input type="button" onClick="javascript:self.location.href='booking.cfm?lang=#lang#&CompanyID=#CompanyID#'" value="#language.Cancel#" class="textbutton">
				<br>
				<input type="submit" name="submitForm" style="visibility:hidden;">
				<input type="hidden" name="vesselID" value="#url.vesselID#">
			</td>
		</tr>
	</table>
</cfoutput>
</cfform>

</div>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">