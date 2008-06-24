<cfif isDefined("form.vesselID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Name, vesselID
	FROM Vessels
	WHERE Name = '#trim(form.Name)#'
	AND Deleted = 0
	AND VesselID != #form.vesselID#
	AND CompanyID = #form.companyID#
</cfquery>

<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif getVessel.recordcount GE 1>
	<cfoutput>#ArrayAppend(Variables.Errors, "A vessel with that name already exists.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="editVessel.cfm?VesselID=#form.VesselID#&CompanyID=#form.CompanyID#" addtoken="no">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Vessel"">
	<meta name=""keywords"" lang=""eng"" content="""">
	<meta name=""description"" lang=""eng"" content=""Allows user to edit the details of a vessel."">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Vessel</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<A href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			Edit Vessel
			</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Edit Vessel
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFQUERY name="getVesselDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT Vessels.*, Companies.CompanyID, Companies.Name AS CompanyName
					FROM  Vessels INNER JOIN Companies ON Vessels.CompanyID = Companies.CompanyID
					WHERE VesselID = #Form.VesselID#
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
				
				<!---
				<cfset Form.EndHighlight = DateAdd("d", Form.EndHighlight, PacificNow) >
				<cfelse>
				<cfset Form.EndHighlight = DateAdd("yyyy", "-100", PacificNow) >
				</cfif>
				<cfset Variables.EndHighlight = Form.EndHighlight>
				--->
				
				<cfparam name="Variables.Anonymous" default="0">
				<cfif IsDefined("Form.Anonymous")>
					<cfset Variables.Anonymous = 1>
				</cfif>

				<cfinclude template="#RootDir#includes/admin_menu.cfm"><br>
				
				<p>Please confirm the following information: </p>
				<cfif Variables.Width GT Variables.MaxWidth OR Variables.Length GT Variables.MaxLength>
					<p><span class="red"><strong>Note: The ship measurements exceed the maximum dimensions of the dock (<cfoutput>#Variables.MaxLength#m x #Variables.MaxWidth#m</cfoutput>).</strong></span></p>
				</cfif>
				<cfoutput>
				<cfform name="editVessel" action="EditVessel_action.cfm?lang=#lang#" method="post">
					<table align="center">
						<tr>
							<td id="Company">Company Name:</td>
							<td headers="Company">#getVesselDetail.CompanyName#</td>
						</tr>
						<tr>
							<td id="Name">Name:</td>
							<td headers="Name"><input type="hidden" name="name" value="#Variables.Name#">#Variables.Name#</td>
						</tr>
						<tr>
							<td id="Lloyds">International Maritime Organization (I.M.O.) number:</td>
							<td headers="Lloyds"><input type="hidden" name="LloydsID" value="#Variables.LloydsID#">#Variables.LloydsID#</td>
						</tr>
						<tr>
							<td id="Length">Length:</td>
							<td headers="Length"><input type="hidden" name="length" value="#Variables.Length#">#Variables.Length#m</span></td>
						</tr>
						<tr>
							<td id="Width">Width:</td>
							<td headers="Width"><input type="hidden" name="width" value="#Variables.Width#">#Variables.Width#m</span></td>
						</tr>
						<tr>
							<td id="Setup">Block Setup Time:</td>
							<td headers="Setup"><input type="hidden" name="blocksetuptime" value="#Variables.Blocksetuptime#">#Variables.Blocksetuptime# days</td>
						</tr>
						<tr>
							<td id="Teardown">Block Teardown Time:</td>
							<td headers="Teardown"><input type="hidden" name="blockteardowntime" value="#Variables.Blockteardowntime#">#Variables.Blockteardowntime# days</td>
						</tr>
						<tr>
							<td id="Tonnage">Tonnage:</td>
							<td headers="Tonnage"><input type="hidden" name="tonnage" value="#Variables.Tonnage#">#Variables.Tonnage#</td>
						</tr>
						<tr>
							<td id="anonymous">Anonymous:</td>
							<td headers="anonymous"><input type="hidden" name="Anonymous" value="#Variables.Anonymous#"><cfif Variables.Anonymous EQ 1>Yes<cfelse>No</cfif></td>
						</tr>
						<!---<tr>
							<td id="EndHighlight">Highlight until:</td>
							<td headers="EndHighlight"><input type="hidden" name="EndHighlight" value="#Variables.EndHighlight#"><cfif Variables.EndHighlight GTE PacificNow>#DateFormat(Variables.EndHighlight, "mmm dd, yyyy")#<cfelse>-</cfif></td>
						</tr>--->
						<tr>
							<td colspan="2" align="center" style="padding-top:20px;">
								<input type="hidden" name="vesselID" value="<cfoutput>#Form.vesselID#</cfoutput>">
								<input type="hidden" name="companyID" value="<cfoutput>#Form.companyID#</cfoutput>">
								<!---a href="javascript:document.editVessel.submitForm.click();" class="textbutton">Submit</a>
								<a href="javascript:history.go(-1);" class="textbutton">Back</a>
								<a href="menu.cfm?lang=#lang#" class="textbutton">Cancel</a>
								<br--->
								<input type="submit" value="Confirm" class="textbutton">
								<INPUT type="button" value="Back" onClick="self.location.href='editVessel.cfm?lang=#lang#'" class="textbutton">
								<INPUT type="button" value="Cancel" onClick="self.location.href='menu.cfm?lang=#lang#'" class="textbutton">
							</td>
						</tr>
					</table>
				</cfform>
				</cfoutput>
				
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
