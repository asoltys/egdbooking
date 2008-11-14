<cfif isDefined("form.name")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Name
	FROM Vessels
	WHERE Name = '#trim(form.Name)#'
	AND Deleted = 0
	AND CompanyId = #form.companyID#
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
	<cflocation url="addVessel.cfm?CompanyID=#form.CompanyID#" addtoken="no">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Add Vessel"" />
	<meta name=""keywords"" content=""Add Vessel"" />
	<meta name=""description"" content=""Allows user to create a new vessel in the Esquimalt Graving Dock booking website."" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Add Vessel</title>">
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
			Add New Vessel
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Add New Vessel
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT 	Companies.CompanyID, Companies.Name AS CompanyName
					FROM  	Companies
					WHERE 	CompanyID = '#Form.CompanyID#'
					AND		Deleted = '0'
				</cfquery>

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

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<p>Please confirm the following information: </p>
				<cfif Variables.Width GT Variables.MaxWidth OR Variables.Length GT Variables.MaxLength>
					<div id="actionErrors">Note: The ship measurements exceed the maximum dimensions of the dock (<cfoutput>#Variables.MaxLength#m x #Variables.MaxWidth#m</cfoutput>).</div>
				</cfif>
				<cfoutput>
				<cfform name="addVessel" action="addVessel_action.cfm?lang=#lang#" method="post">
					<table align="center">
						<tr>
							<td id="CompanyID">Company Name:</td>
							<td headers="CompanyID"><input type="hidden" name="CompanyID" value="#Variables.CompanyID#" />
						</tr>
						<tr>
							<td id="name">Name:</td>
							<td headers="name"><input type="hidden" name="name" value="#Variables.Name#" />
						</tr>
						<tr>
							<td id="LloydsID">Lloyds ID:</td>
							<td headers="LloydsID"><input type="hidden" name="LloydsID" value="#Variables.LloydsID#" />
						</tr>
						<tr>
							<td id="length">Length:</td>
							<td headers="length"><input type="hidden" name="length" value="#Variables.Length#" />
						</tr>
						<tr>
							<td id="width">Width:</td>
							<td headers="width"><input type="hidden" name="width" value="#Variables.Width#" />
						</tr>
						<tr>
							<td id="blocksetuptime">Block Setup Time:</td>
							<td headers="blocksetuptime"><input type="hidden" name="blocksetuptime" value="#Variables.BlockSetuptime#" />
						</tr>
						<tr>
							<td id="blockteardowntime">Block Teardown Time:</td>
							<td headers="blockteardowntime"><input type="hidden" name="blockteardowntime" value="#Variables.Blockteardowntime#" />
						</tr>
						<tr>
							<td id="tonnage">Tonnage:</td>
							<td headers="tonnage"><input type="hidden" name="tonnage" value="#Variables.Tonnage#" />
						</tr>
						<tr>
							<td id="Anonymous">Anonymous:</td>
							<td headers="Anonymous"><input type="hidden" name="Anonymous" value="#Variables.Anonymous#" />
						</tr>
						<tr>
							<td colspan="2" align="center" style="padding-top:20px;">
								<input type="submit" value="submit" class="textbutton" />
								<input type="button" onclick="javascript:self.location.href='addVessel.cfm?lang=#lang#'" value="Back" class="textbutton" />
								<input type="button" onclick="javascript:self.location.href='menu.cfm?lang=#lang#'" value="Cancel" class="textbutton" />
							</td>
						</tr>
					</table>
				</cfform>
				</cfoutput>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
