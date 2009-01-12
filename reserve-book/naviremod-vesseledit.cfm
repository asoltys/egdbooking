<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfinclude template="#RootDir#includes/vesselInfoVariables.cfm">
<cfif lang EQ "eng">
	<cfset language.editVessel = "Edit Vessel">
	<cfset language.keywords = language.masterKeywords & ", Edit Vessel">
	<cfset language.description = "Allows user to edit the details of a vessel.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.companyName = "Company Name">
	<cfset language.reset = "reset">
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
	<meta name=""dc.title"" content=""#language.editVessel# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.editVessel# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
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

				<CFIF NOT IsDefined('url.VNID') AND Not IsNumeric('url.VNID')>
					<cflocation addtoken="no" url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">
				</CFIF>

				<cfquery name="getVesselDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT Vessels.*, Companies.CID, Companies.Name AS CompanyName
					FROM  Vessels INNER JOIN Companies ON Vessels.CID = Companies.CID
					WHERE VNID = #url.VNID#
					AND Vessels.Deleted = 0
				</cfquery>

				<cfquery name="getVesselDockBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	*
					FROM	Bookings INNER JOIN Vessels ON Vessels.VNID = Bookings.VNID
							INNER JOIN Docks ON Bookings.BRID = Docks.BRID
					WHERE	EndDate >= #CreateODBCDate(PacificNow)# AND Vessels.VNID = #url.VNID# AND Bookings.Deleted = 0
							AND Status = 'c'
				</cfquery>

				<cfquery name="getVesselJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	*
					FROM	Bookings INNER JOIN Vessels ON Vessels.VNID = Bookings.VNID
							INNER JOIN Jetties ON Bookings.BRID = Jetties.BRID
					WHERE	EndDate >= #CreateODBCDate(PacificNow)# AND Vessels.VNID = #url.VNID# AND Bookings.Deleted = 0
							AND Status = 'c'
				</cfquery>

				<cfif getVesselDetail.recordCount EQ 0>
					<cflocation addtoken="no" url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">
				</cfif>

				<cfif isDefined("form.Name")>
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

				<cfform id="editVessel" action="#RootDir#reserve-book/naviremod-vesseledit_action.cfm?lang=#lang#&amp;CID=#getVesselDetail.CID#&amp;VNID=#VNID#" method="post">
					<cfif getVesselDockBookings.recordCount GT 0 OR getVesselJettyBookings.recordCount GT 0>
					<div id="actionErrors">#language.notEditVesselDimensions#</div>
					</cfif>
					<fieldset>
						<label>#language.CompanyName#:</label>
						<p>#getVesselDetail.CompanyName#</p>

						<label for="name">#language.vessel#:</label>
						<cfinput id="name" name="name" type="text" value="#variables.Name#" size="37" maxlength="100" required="yes" message="#language.nameError#" />
						<br />

						<label for="LloydsID">#language.LloydsID#:</label>
						<cfinput id="LloydsID" name="LloydsID" type="text" value="#variables.lloydsid#" size="20" maxlength="20" >
						<br />

						<cfif getVesselDockBookings.recordCount GT 0 OR getVesselJettyBookings.recordCount GT 0>

							<label for="length">#language.Length#:</label>
							<p>#variables.length# m</p>
							<input type="hidden" name="length" value="#variables.length#">&nbsp;&nbsp;&nbsp;<span class="smallFont" style="color:red;" />


							<label for="width">#language.Width#:</label>
							<p>#variables.width# m</p>
							<input type="hidden" name="width" value="#variables.width#">&nbsp;&nbsp;&nbsp;<span class="smallFont" style="color:red;" />

						<cfelse>

							<label for="length">#language.Length#:</label>
							<cfinput id="length" name="length" type="text" value="#variables.length#" size="8" maxlength="8" required="yes" validate="float" message="#language.lengthError#">  <span class="smallFont red">#language.Max#: #Variables.MaxLength# m</span>
							<br />


							<label for="width">#language.Width#:</label>
							<cfinput id="width" name="width" type="text" value="#variables.width#" size="8" maxlength="8" required="yes" validate="float" message="#language.widthError#">  <span class="smallFont red">#language.Max#: #Variables.MaxWidth# m</span>
							<br />

						</cfif>

						<label for="blocksetuptime">#language.BlockSetup# #language.days#:</label>
						<cfinput id="blocksetuptime" name="blocksetuptime" type="text" value="#variables.blocksetuptime#" size="2" maxlength="2" required="yes" validate="float" message="#language.setupError#" />
						<br />


						<label for="blockteardowntime">#language.BlockTeardown# #language.days#:</label>
						<cfinput id="blockteardowntime" name="blockteardowntime" type="text" value="#variables.blockteardowntime#" size="2" maxlength="2" required="yes" validate="float" message="#language.teardownError#" />
						<br />


						<label for="tonnage">#language.Tonnage#:</label>
						<cfinput id="tonnage" name="tonnage" type="text" value="#variables.tonnage#" size="8" maxlength="8" required="yes" validate="float" message="#language.tonnageError#" />
						<br />

						<label for="anonymous">#language.anonymous#:</label>
						<input id="anonymous" type="checkbox" name="Anonymous" <cfif variables.Anonymous EQ 1>checked="true" </cfif>value="Yes" />
					</fieldset>

					<p class="smallFont">*#language.anonymousWarning#</p>

					<div class="buttons">
						<input type="hidden" name="VNID" value="<cfoutput>#url.VNID#</cfoutput>" />
						<input type="submit" value="#language.Submit#" name="submitForm" class="textbutton" />
						<input type="reset" value="#language.Reset#" name="resetForm" class="textbutton" />
						<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#&amp;CID=#GetVesselDetail.CID#" class="textbutton">#language.Cancel#" name="cancel</a>
					</div>
				</cfform>
				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
