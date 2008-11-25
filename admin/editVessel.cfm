<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Vessel"" />
	<meta name=""keywords"" content=""Edit Vessel Profile"" />
	<meta name=""description"" content=""Allows user to edit the details of a vessel."" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Vessel</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfif isDefined("form.companyID")>
	<cfinclude template="#RootDir#includes/build_form_struct.cfm">
</cfif>

<CFIF IsDefined('url.companyID')>
	<CFSET form.companyID = url.companyID>
</CFIF>
<CFIF IsDefined('url.vesselID')>
	<CFSET form.vesselID = url.vesselID>
</CFIF>

<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfif isDefined("form.companyID")>
	<cfset companyDefault = #form.companyID#>
<cfelse>
	<cfset companyDefault = 0>
</cfif>
<cfif isDefined("form.vesselID")>
	<cfset vesselDefault = #form.vesselID#>
<cfelse>
	<cfset vesselDefault = 0>
</cfif>

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
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Edit Vessel
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<cfparam name="form.vesselID" default="">

				<!---<cfquery name="getVessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT 	VesselID, Name
					FROM 	Vessels
					WHERE 	Deleted = 0
					ORDER BY Name
				</cfquery>--->

				<cfquery name="companyVessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT vesselID, vessels.Name AS VesselName, companies.companyID, companies.Name AS CompanyName
					FROM Vessels INNER JOIN Companies ON Vessels.CompanyID = Companies.CompanyID
					WHERE Vessels.Deleted = 0 AND Companies.Deleted = 0 AND Companies.Approved = 1
					ORDER BY Companies.Name, Vessels.Name
				</cfquery>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				<cfinclude template="#RootDir#includes/getStructure.cfm"><br />

				<cfform action="editVessel.cfm?lang=#lang#" method="post" id="chooseVesselForm">
				<table style="width:100%;">
					<!---<cfselect name="vesselID" query="getVessels" display="name" value="vesselID" selected="#form.vesselID#" />--->
					<tr>
						<td valign="baseline">Company:</td>
						<td>
							<CF_TwoSelectsRelated
								QUERY="companyVessels"
								id1="CompanyID"
								id2="VesselID"
								DISPLAY1="CompanyName"
								DISPLAY2="VesselName"
								VALUE1="companyID"
								VALUE2="vesselID"
								SIZE1="1"
								SIZE2="1"
								htmlBETWEEN="</td></tr><tr><td>Vessel:</td><td>"
								AUTOSELECTFIRST="Yes"
								EMPTYTEXT1="(choose a company)"
								EMPTYTEXT2="(choose a vessel)"
								DEFAULT1 ="#companyDefault#"
								DEFAULT2 ="#vesselDefault#"
								FORMNAME="chooseVesselForm">
						</td>
					</tr>
					<tr><td colspan="2" align="right">
						<input type="submit" name="submitForm" class="textbutton" value="Edit" />
						<cfoutput><input type="button" value="Cancel" onclick="self.location.href='menu.cfm?lang=#lang#';" class="textbutton" />
					</td></tr>
				</table>
				</cfform>
				<br />

				<cfif form.vesselID NEQ "">

					<cfquery name="getVesselDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT	Vessels.*, Companies.CompanyID, Companies.Name AS CompanyName
						FROM	Vessels INNER JOIN Companies ON Vessels.CompanyID = Companies.CompanyID
						WHERE	VesselID = '#Form.VesselID#'
							AND	Vessels.Deleted = 0
					</cfquery>

					<cfif isDefined("session.form_structure") AND isDefined("form.name")>
						<!---<cfset variables.EndHighlight = "#form.EndHighlight#">--->
						<cfset variables.name = "#form.name#">
						<cfset variables.LloydsID = "#form.LloydsID#">
						<cfset variables.length = "#form.length#">
						<cfset variables.width = "#form.width#">
						<cfset variables.blocksetuptime = "#form.blocksetuptime#">
						<cfset variables.blockteardowntime = "#form.blockteardowntime#">
						<cfset variables.tonnage = "#form.tonnage#">
						<cfif isDefined("form.Anonymous")><cfset variables.Anonymous = 1><cfelse><cfset variables.Anonymous = 0></cfif>
					<cfelse>
						<!---<cfset variables.EndHighlight = "#getVesselDetail.EndHighlight#">--->
						<cfset variables.name = "#getVesselDetail.name#">
						<cfset variables.LloydsID = "#getVesselDetail.LloydsID#">
						<cfset variables.length = "#getVesselDetail.length#">
						<cfset variables.width = "#getVesselDetail.width#">
						<cfset variables.blocksetuptime = "#getVesselDetail.blocksetuptime#">
						<cfset variables.blockteardowntime = "#getVesselDetail.blockteardowntime#">
						<cfset variables.tonnage = "#getVesselDetail.tonnage#">
						<cfset variables.Anonymous = "#getVesselDetail.Anonymous#">
					</cfif>

					<!--- 	<cfquery name="getVesselDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
							SELECT Vessels.*, Companies.CompanyID, Companies.Name AS CompanyName, Users.FirstName + ' ' + Users.LastName AS UserName, Users.userID
							FROM  Vessels INNER JOIN
								Companies ON Vessels.CompanyID = Companies.CompanyID INNER JOIN
								UserCompanies ON Companies.CompanyID = UserCompanies.CompanyID INNER JOIN
								Users ON UserCompanies.UserID = Users.UserID
							WHERE VesselID = #form.VesselID#
							AND Vessels.Deleted = 0
						</cfquery> --->

					<cfif getVesselDetail.recordCount EQ 0>
						<cflocation addtoken="no" url="menu.cfm?lang=#lang#">
					</cfif>

					<cfform id="editVessel" action="EditVessel_process.cfm?lang=#lang#" method="post">
					<table align="center">
						<tr>
							<td id="Company_Header" style="width:42%;">Company Name:</td>
							<td headers="Company_Header"><cfoutput>#getVesselDetail.companyName#</cfoutput></td>
							<!---<td><cfselect name="companyID" query="getCompanies" display="Name" value="companyID" selected="#getVesselDetail.companyID#" /></td>--->
						</tr>
						<tr>
							<td id="name_Header"><label for="name">Name:</label></td>
							<td headers="name_Header"><cfinput id="name" name="name" type="text" value="#variables.Name#" size="37" maxlength="100" required="yes" message="Please enter the vessel name." /></td>
						</tr>
						<tr>
							<td id="LloydsID_Header"><label for="LloydsID">International Maritime Organization (IMO) Number:</label></td>
							<td headers="LloydsID_Header"><cfinput id="LloydsID" name="LloydsID" type="text" value="#variables.lloydsid#" size="20" maxlength="20" required="no" message="Please enter the International Maritime Organization (I.M.O.) number." /></td>
						</tr>
						<tr>
							<td id="length_Header"><label for="length">Length (m):</label></td>
							<td headers="length_Header"><cfinput id="length" name="length" type="text" value="#variables.length#" size="8" maxlength="8" required="yes" validate="float" message="Please enter the length in metres.">  <span class="smallFont" style="color:red;" />Max: <cfoutput>#Variables.MaxLength#</cfoutput>m</span></td>
						</tr>
						<tr>
							<td id="width_Header"><label for="width">Width (m):</label></td>
							<td headers="width_Header"><cfinput id="width" name="width" type="text" value="#variables.width#" size="8" maxlength="8" required="yes" validate="float" message="Please enter the width in metres.">  <span class="smallFont" style="color:red;" />Max: <cfoutput>#Variables.MaxWidth#</cfoutput>m</span></td>
						</tr>
						<tr>
							<td id="blocksetuptime_Header"><label for="blocksetuptime">Block Setup Time (days):</label></td>
							<td headers="blocksetuptime_Header"><cfinput id="blocksetuptime" name="blocksetuptime" type="text" value="#variables.blocksetuptime#" size="2" maxlength="2" required="yes" validate="float" message="Please enter the block setup time in days." /></td>
						</tr>
						<tr>
							<td id="blockteardowntime_Header"><label for="blockteardowntime">Block Teardown Time (days):</label></td>
							<td headers="blockteardowntime_Header"><cfinput id="blockteardowntime" name="blockteardowntime" type="text" value="#variables.blockteardowntime#" size="2" maxlength="2" required="yes" validate="float" message="Please enter the block teardown time in days." /></td>
						</tr>
						<tr>
							<td id="tonnage_Header"><label for="tonnage">Tonnage:</label></td>
							<td headers="tonnage_Header"><cfinput id="tonnage" name="tonnage" type="text" value="#variables.tonnage#" size="8" maxlength="8" required="yes" validate="float" message="Please enter the tonnage." /></td>
						</tr>
						<tr>
							<td id="Anonymous_Header"><label for="Anonymous">Keep this vessel anonymous:</label></td>
							<td headers="Anonymous_Header"><input id="Anonymous" type="checkbox" name="Anonymous"<cfif variables.Anonymous EQ 1> checked="true"</cfif> value="Yes" />
						</tr><!---
						<tr>
							<td id="Highlight_Header"><label for="Anonymous">Highlight for this many days:</label></td>
							<td headers="Highlight_Header">
							<cfif variables.EndHighlight NEQ "">
							<cfset datediffhighlight = DateDiff("d", PacificNow, variables.EndHighlight)>
							<cfset datediffhighlight = datediffhighlight+"1">
							<cfif datediffhighlight LTE "0"><cfset datediffhighlight = "0"></cfif>
							<cfelse>
							<cfset datediffhighlight = "0">
							</cfif>
							<cfinput id="EndHighlight" name="EndHighlight" type="text" value="#datediffhighlight#" size="8" maxlength="8" required="yes" message="Please enter an End Highlight Date." /></td>
						</tr>--->
						<tr>
							<td colspan="2" align="center" style="padding-top:20px;">
								<!--a href="javascript:document.editVessel.submitForm.click();" class="textbutton">Submit</a>
								<a href="javascript:history.go(-1);" class="textbutton">Cancel</a>
								<br-->
								<input type="hidden" name="vesselID" value="<cfoutput>#form.vesselID#</cfoutput>" />
								<input type="hidden" name="companyID" value="<cfoutput>#form.companyID#</cfoutput>" />
								<input type="submit" value="submit" class="textbutton" />
								<cfoutput><input type="button" value="Cancel" onclick="self.location.href='menu.cfm?lang=#lang#'" class="textbutton" />
							</td>
						</tr>
					</table>
					</cfform>
				</cfif>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
