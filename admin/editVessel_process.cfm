<cfif isDefined("form.VNID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Name, VNID
	FROM Vessels
	WHERE Name = <cfqueryparam value="#trim(form.Name)#" cfsqltype="cf_sql_varchar" />
	AND Deleted = 0
	AND VNID != <cfqueryparam value="#form.VNID#" cfsqltype="cf_sql_integer" />
	AND CID = <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" />
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
	<cflocation url="editVessel.cfm?VNID=#form.VNID#&CID=#form.CID#" addtoken="no">
</cfif>

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Vessel"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content=""Allows user to edit the details of a vessel."" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Vessel</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">
		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt;
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			Edit Vessel
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1 id="wb-cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Edit Vessel
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</h1>

				<cfquery name="getVesselDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT Vessels.*, Companies.CID, Companies.Name AS CompanyName
					FROM  Vessels INNER JOIN Companies ON Vessels.CID = Companies.CID
					WHERE VNID = <cfqueryparam value="#form.VNID#" cfsqltype="cf_sql_integer" />
					AND Vessels.Deleted = 0
				</cfquery>

				<cfif getVesselDetail.recordCount EQ 0>
					<cflocation addtoken="no" url="booking.cfm?lang=#lang#&CID=#url.CID#">
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

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<p>Please confirm the following information: </p>
				<cfif Variables.Width GT Variables.MaxWidth OR Variables.Length GT Variables.MaxLength>
					<div id="actionErrors">Note: The ship measurements exceed the maximum dimensions of the dock (<cfoutput>#Variables.MaxLength#m x #Variables.MaxWidth#m</cfoutput>).</div>
				</cfif>
				<cfoutput>
				<cfform id="editVessel" action="EditVessel_action.cfm?lang=#lang#" method="post">
					<table>
						<tr>
							<td id="Company">Company Name:</td>
							<td headers="Company">#getVesselDetail.CompanyName#</td>
						</tr>
						<tr>
							<td id="Name">Name:</td>
							<td headers="Name"><input type="hidden" name="name" value="#Variables.Name#" />#Variables.Name#</td>
						</tr>
						<tr>
							<td id="Lloyds">International Maritime Organization (I.M.O.) number:</td>
							<td headers="Lloyds"><input type="hidden" name="LloydsID" value="#Variables.LloydsID#" />#Variables.LloydsID#</td>
						</tr>
						<tr>
							<td id="Length">Length:</td>
							<td headers="Length"><input type="hidden" name="length" value="#Variables.Length#" />#Variables.Length#</td>
						</tr>
						<tr>
							<td id="Width">Width:</td>
							<td headers="Width"><input type="hidden" name="width" value="#Variables.Width#" />#Variables.Width#</td>
						</tr>
						<tr>
							<td id="Setup">Block Setup Time:</td>
							<td headers="Setup"><input type="hidden" name="blocksetuptime" value="#Variables.Blocksetuptime#" />#Variables.Blocksetuptime#</td>
						</tr>
						<tr>
							<td id="Teardown">Block Teardown Time:</td>
							<td headers="Teardown"><input type="hidden" name="blockteardowntime" value="#Variables.Blockteardowntime#" />#Variables.Blockteardowntime#</td>
						</tr>
						<tr>
							<td id="Tonnage">Tonnage:</td>
							<td headers="Tonnage"><input type="hidden" name="tonnage" value="#Variables.Tonnage#" />#Variables.Tonnage#</td>
						</tr>
						<tr>
							<td id="anonymous">Anonymous:</td>
							<td headers="anonymous"><input type="hidden" name="Anonymous" value="#Variables.Anonymous#" /><cfif Variables.Anonymous EQ 1>Yes<cfelse>No</cfif></td>
						</tr>
						<tr>
							<td colspan="2" align="center" style="padding-top:20px;">
								<input type="hidden" name="VNID" value="<cfoutput>#Form.VNID#</cfoutput>" />
								<input type="hidden" name="CID" value="<cfoutput>#Form.CID#</cfoutput>" />
								<input type="submit" value="Confirm" class="textbutton" />
								<a href="editVessel.cfm?lang=#lang#" class="textbutton">Back</a>
								<a href="menu.cfm?lang=#lang#" class="textbutton">Cancel</a>
							</td>
						</tr>
					</table>
				</cfform>
				</cfoutput>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
