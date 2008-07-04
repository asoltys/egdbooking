<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfinclude template="#RootDir#includes/vesselInfoVariables.cfm">
<cfif lang EQ "eng">
	<cfset language.editVessel = "Edit Vessel">
	<cfset language.keywords = language.masterKeywords & ", Edit Vessel">
	<cfset language.description = "Allows user to edit the details of a vessel.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.companyName = "Company Name">
	<cfset language.reset = "Reset">
	<cfset language.anonymousWarning = "Anonymous vessels are only anonymous to other companies' users.  The Esquimalt Graving Dock administrators have access to all vessel information regardless of anonymity.">
	<cfset language.notEditVesselDimensions = "You may not edit the vessel dimensions as this vessel currently has confirmed bookings.  To make dimension changes, please contact EGD Administration.">
<cfelse>
	<cfset language.editVessel = "Modifier le navire">
	<cfset language.keywords = language.masterKeywords & ", Modifier le navire">
	<cfset language.description = "Permet &agrave; l'utilisateur de modifier les d&eacute;tails concernant un navire.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.companyName = "Raison sociale">
	<cfset language.reset = "R&eacute;initialiser">
	<cfset language.anonymousWarning = "Les navires anonymes ne sont anonymes qu'aux utilisateurs d'autres entreprises. Les administrateurs de la cale s&egrave;che d'Esquimalt ont acc&egrave;s &agrave; la totalit&eacute; de l'information concernant les navires, peu importe l'anonymat.">
	<cfset language.notEditVesselDimensions = "Vous ne pouvez pas modifier les dimensions du navire, parce que ce dernier fait l'objet de r&eacute;servations confirm&eacute;es. Pour apporter des changements aux dimensions, pri&egrave;re de communiquer avec l'administration de la CSE."> 

</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.editVessel#"">
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<meta name=""dc.date.published"" content=""2005-07-25"" />
	<meta name=""dc.date.reviewed"" content=""2005-07-25"" />
	<meta name=""dc.date.modified"" content=""2005-07-25"" />
	<meta name=""dc.date.created"" content=""2005-07-25"" />
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.editVessel#</title>">

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			<CFELSE>
				<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			</CFIF>
			#language.editVessel#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.editVessel#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFIF NOT IsDefined('url.VesselID') AND Not IsNumeric('url.VesselID')>
					<cflocation addtoken="no" url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">
				</CFIF>
				
				<cfquery name="getVesselDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT Vessels.*, Companies.CompanyID, Companies.Name AS CompanyName
					FROM  Vessels INNER JOIN Companies ON Vessels.CompanyID = Companies.CompanyID
					WHERE VesselID = #url.VesselID#
					AND Vessels.Deleted = 0
				</cfquery>
				
				<cfquery name="getVesselDockBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	*
					FROM	Bookings INNER JOIN Vessels ON Vessels.VesselID = Bookings.VesselID
							INNER JOIN Docks ON Bookings.BookingID = Docks.BookingID
					WHERE	EndDate >= #CreateODBCDate(PacificNow)# AND Vessels.VesselID = #url.VesselID# AND Bookings.Deleted = 0
							AND Status = 'c'
				</cfquery>
				
				<cfquery name="getVesselJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	*
					FROM	Bookings INNER JOIN Vessels ON Vessels.VesselID = Bookings.VesselID
							INNER JOIN Jetties ON Bookings.BookingID = Jetties.BookingID
					WHERE	EndDate >= #CreateODBCDate(PacificNow)# AND Vessels.VesselID = #url.VesselID# AND Bookings.Deleted = 0
							AND Status = 'c'
				</cfquery>
				
				<cfif getVesselDetail.recordCount EQ 0>
					<cflocation addtoken="no" url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">
				</cfif>
				
				<cfif isDefined("form.Name")>
					<cfset variables.companyName = #form.companyName#>
					<cfset variables.Name = #form.Name#>
					<cfset variables.lloydsID = #form.lloydsID#>
					<cfset variables.length = #form.length#>
					<cfset variables.width = #form.width#>
					<cfset variables.blocksetuptime = #form.blocksetuptime#>
					<cfset variables.blockteardowntime = #form.blockteardowntime#>
					<cfset variables.tonnage = #form.tonnage#>
					<cfif isDefined("form.anonymous") AND form.anonymous EQ "yes">
						<cfset variables.anonymous = 1>
					<cfelse>
						<cfset variables.anonymous = 0>
					</cfif>
				<cfelse>
					<cfset variables.companyName = #getVesselDetail.companyName#>
					<cfset variables.Name = #getVesselDetail.Name#>
					<cfset variables.lloydsID = #getVesselDetail.lloydsID#>
					<cfset variables.length = #getVesselDetail.length#>
					<cfset variables.width = #getVesselDetail.width#>
					<cfset variables.blocksetuptime = #getVesselDetail.blocksetuptime#>
					<cfset variables.blockteardowntime = #getVesselDetail.blockteardowntime#>
					<cfset variables.tonnage = #getVesselDetail.tonnage#>
					<cfset variables.anonymous = #getVesselDetail.anonymous#>
				</cfif>
				
				<cfoutput>
				
				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
				
				<cfform name="editVessel" action="#RootDir#reserve-book/naviremod-vesseledit_confirm.cfm?lang=#lang#&CompanyID=#getVesselDetail.companyID#&VesselID=#VesselID#" method="post">
					<cfif getVesselDockBookings.recordCount GT 0 OR getVesselJettyBookings.recordCount GT 0>
					<div id="actionErrors">#language.notEditVesselDimensions#</div>
					</cfif>
					<table align="center">
						<tr>
							<td width="42%" id="CompanyName">#language.CompanyName#:</td>
							<td headers="CompanyName"><input type="hidden" value="#getVesselDetail.CompanyName#" name="companyName">#variables.CompanyName#</td>
						</tr>
						<tr>
							<td id="vessel"><label for="name">#language.vessel#:</label></td>
							<td headers="vessel"><cfinput id="name" name="name" type="text" value="#variables.Name#" size="37" maxlength="100" required="yes" CLASS="textField" message="#language.nameError#"></td>
						</tr>
						<tr>
							<td id="lloyds"><label for="LloydsID">#language.LloydsID#:</label></td>
							<td headers="lloyds"><cfinput id="LloydsID" name="LloydsID" type="text" value="#variables.lloydsid#" size="20" maxlength="20" CLASS="textField" ></td>
						</tr>
						<cfif getVesselDockBookings.recordCount GT 0 OR getVesselJettyBookings.recordCount GT 0>
						<tr>
							<td id="len"><label for="length">#language.Length#:</label></td>
							<td headers="len">#variables.length# m<input type="hidden" name="length" value="#variables.length#">&nbsp;&nbsp;&nbsp;<span class="smallFont" style="color:red;">#language.Max#: #Variables.MaxLength# m</span></td>
						</tr>
						<tr>
							<td id="wid"><label for="width">#language.Width#:</label></td>
							<td headers="wid">#variables.width# m<input type="hidden" name="width" value="#variables.width#">&nbsp;&nbsp;&nbsp;<span class="smallFont" style="color:red;">#language.Max#: #Variables.MaxWidth# m</span></td>
						</tr>
						<cfelse>
						<tr>
							<td id="len"><label for="length">#language.Length#:</label></td>
							<td headers="len"><cfinput id="length" name="length" type="text" value="#variables.length#" size="8" maxlength="8" required="yes" validate="float" CLASS="textField" message="#language.lengthError#">  <span class="smallFont" style="color:red;">#language.Max#: #Variables.MaxLength# m</span></td>
						</tr>
						<tr>
							<td id="wid"><label for="width">#language.Width#:</label></td>
							<td headers="wid"><cfinput id="width" name="width" type="text" value="#variables.width#" size="8" maxlength="8" required="yes" validate="float" CLASS="textField" message="#language.widthError#">  <span class="smallFont" style="color:red;">#language.Max#: #Variables.MaxWidth# m</span></td>
						</tr>
						</cfif>
						<tr>
							<td id="setup"><label for="blocksetuptime">#language.BlockSetup# #language.days#:</label></td>
							<td headers="setup"><cfinput id="blocksetuptime" name="blocksetuptime" type="text" value="#variables.blocksetuptime#" size="2" maxlength="2" required="yes" validate="float" CLASS="textField" message="#language.setupError#"></td>
						</tr>
						<tr>
							<td id="teardown"><label for="blockteardowntime">#language.BlockTeardown# #language.days#:</label></td>
							<td headers="teardown"><cfinput id="blockteardowntime" name="blockteardowntime" type="text" value="#variables.blockteardowntime#" size="2" maxlength="2" required="yes" validate="float" CLASS="textField" message="#language.teardownError#"></td>
						</tr>
						<tr>
							<td id="ton"><label for="tonnage">#language.Tonnage#:</label></td>
							<td headers="ton"><cfinput id="tonnage" name="tonnage" type="text" value="#variables.tonnage#" size="8" maxlength="8" required="yes" validate="float" CLASS="textField" message="#language.tonnageError#"></td>
						</tr>
						<!---<tr>
							<td>Fuel Type:</td>
							<td><cfinput type="text" name="fueltype" required="no" size="8" maxlength="8" validate="float" value="">
								<select name="fueltype_select" onChange="javascript:(document.editVessel.fueltype.value = document.editVessel.fueltype_select.options[document.editVessel.fueltype_select.selectedIndex].value)">
									<option>diesel</option>
									<option>fart</option>
									<option>alcohol</option>
								</select></td>
						</tr>--->
						<tr>
							<td id="anon"><label for="anonymous">#language.anonymous#:</label></td>
							<td headers="anon"><input id="anonymous" type="checkbox" name="Anonymous" <cfif variables.Anonymous EQ 1>checked </cfif>value="Yes"></td>
						</tr>
						<tr><td colspan="2"><P class="smallFont">*#language.anonymousWarning#</p></td></tr>
						<tr>
							<td colspan="2" align="center" style="padding-top:20px;">
								<input type="hidden" name="vesselID" value="<cfoutput>#url.vesselID#</cfoutput>">
								<!--a href="javascript:document.editVessel.submitForm.click();" class="textbutton">Submit</a>
								<a href="javascript:history.go(-1);" class="textbutton">Cancel</a>
								<br-->
								<input type="submit" value="#language.Submit#" name="submitForm" class="textbutton">
								<input type="reset" value="#language.Reset#" name="resetForm" class="textbutton">
								<input type="button" value="#language.Cancel#" name="cancel" class="textbutton" onClick="self.location.href='#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#&CompanyID=#GetVesselDetail.companyID#'">
							</td>
						</tr>
					</table>
				</cfform>
				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
