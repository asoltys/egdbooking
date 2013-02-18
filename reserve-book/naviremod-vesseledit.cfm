<cfoutput>
<cfinclude template="#RootDir#includes/restore_params.cfm">

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
	<meta name=""dcterms.title"" content=""#language.editVessel# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dcterms.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.editVessel# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			</CFIF>
			#language.editVessel#
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					#language.editVessel#
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFIF NOT IsDefined('url.VNID') AND Not IsNumeric('url.VNID')>
					<cflocation addtoken="no" url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">
				</CFIF>

				<cfquery name="getVesselDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT Vessels.*, Companies.CID, Companies.Name AS CompanyName
					FROM  Vessels INNER JOIN Companies ON Vessels.CID = Companies.CID
					WHERE VNID = <cfqueryparam value="#url.VNID#" cfsqltype="cf_sql_integer" />
					AND Vessels.Deleted = 0
				</cfquery>

				<cfquery name="getVesselDockBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	*
					FROM	Bookings INNER JOIN Vessels ON Vessels.VNID = Bookings.VNID
							INNER JOIN Docks ON Bookings.BRID = Docks.BRID
					WHERE	EndDate >= <cfqueryparam value="#CreateODBCDate(PacificNow)#" cfsqltype="cf_sql_date" /> AND Vessels.VNID = <cfqueryparam value="#url.VNID#" cfsqltype="cf_sql_integer" /> AND Bookings.Deleted = 0
							AND Status = 'c'
				</cfquery>

				<cfquery name="getVesselJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	*
					FROM	Bookings INNER JOIN Vessels ON Vessels.VNID = Bookings.VNID
							INNER JOIN Jetties ON Bookings.BRID = Jetties.BRID
					WHERE	EndDate >= <cfqueryparam value="#CreateODBCDate(PacificNow)#" cfsqltype="cf_sql_date" /> AND Vessels.VNID = <cfqueryparam value="#url.VNID#" cfsqltype="cf_sql_integer" /> AND Bookings.Deleted = 0
							AND Status = 'c'
				</cfquery>

				<cfif getVesselDetail.recordCount EQ 0>
					<cflocation addtoken="no" url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">
				</cfif>


				<cfif isDefined("form.Name")>
					<cfset variables.Name = form.Name>
					<cfset variables.lloydsID = form.lloydsID>
					<cfset variables.length = form.length>
					<cfset variables.width = form.width>
					<cfset variables.blocksetuptime = form.blocksetuptime>
					<cfset variables.blockteardowntime = form.blockteardowntime>
					<cfset variables.tonnage = form.tonnage>
					<cfif isDefined("form.anonymous") AND form.anonymous EQ "yes">
						<cfset variables.anonymous = 1>
					<cfelse>
						<cfset variables.anonymous = 0>
					</cfif>
				<cfelse>
					<cfset variables.Name = getVesselDetail.Name>
					<cfset variables.lloydsID = getVesselDetail.lloydsID>
					<cfset variables.length = getVesselDetail.length>
					<cfset variables.width = getVesselDetail.width>
					<cfset variables.blocksetuptime = getVesselDetail.blocksetuptime>
					<cfset variables.blockteardowntime = getVesselDetail.blockteardowntime>
					<cfset variables.tonnage = getVesselDetail.tonnage>
					<cfset variables.anonymous = getVesselDetail.anonymous>
				</cfif>

				<cfinclude template="#RootDir#includes/user_menu.cfm">

        <cfinclude template="#RootDir#includes/getStructure.cfm">
				<form id="editVessel" action="#RootDir#reserve-book/naviremod-vesseledit_action.cfm?lang=#lang#&amp;CID=#getVesselDetail.CID#&amp;VNID=#VNID#" method="post">
					<cfif getVesselDockBookings.recordCount GT 0 OR getVesselJettyBookings.recordCount GT 0>
					<div id="actionErrors">#language.notEditVesselDimensions#</div>
					</cfif>
					<fieldset>
            <legend>#language.vessel#</legend>
            <p>#language.requiredFields#</p>

            <div>
              <label for="CID">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.CompanyName#:
              </label>
              <input type="text" disabled="disabled" readonly="readonly" id="CID" name="CID" value="#getVesselDetail.CompanyName#" />
            </div>

						<div>
              <label for="name">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.vessel#:
                #error('name')#
              </label>
              <input id="name" name="name" type="text" value="#variables.Name#" size="37" maxlength="100" />
						</div>

						<div>
              <label for="LloydsID">#language.LloydsID#:</label>
              <input id="LloydsID" name="LloydsID" type="text" value="#variables.lloydsid#" size="20" maxlength="20" />
						</div>

						<cfif getVesselDockBookings.recordCount GT 0 OR getVesselJettyBookings.recordCount GT 0>
							<div>
                <label for="length">#language.Length#:</label>
                <p>#variables.length# m</p>
                <input type="hidden" id="length" name="length" value="#variables.length#" />
							</div>

							<div>
                <label for="width">#language.Width#:</label>
                <p>#variables.width# m</p>
                <input type="hidden" id="width" name="width" value="#variables.width#" />
							</div>
						<cfelse>
							<div>
                <label for="length">
                  <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                  #language.Length#:
                  #error('length')#
                </label>
                <input id="length" name="length" type="text" value="#variables.length#" size="8" maxlength="8" />
                #language.Max#: #Variables.MaxLength# m
							</div>

							<div>
                <label for="width">
                  <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                  #language.Width#:
                  #error('width')#
                </label>
                <input id="width" name="width" type="text" value="#variables.width#" size="8" maxlength="8" />
                #language.Max#: #Variables.MaxWidth# m
							</div>
						</cfif>

						<div>
              <label for="blocksetuptime">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.BlockSetup# #language.days#:
                #error('blocksetuptime')#
              </label>
              <input id="blocksetuptime" name="blocksetuptime" type="text" value="#variables.blocksetuptime#" size="2" maxlength="2" />
						</div>

						<div>
              <label for="blockteardowntime"><abbr title="#language.required#" class="required">*</abbr>&nbsp;#language.BlockTeardown# #language.days#:</label>
              <input id="blockteardowntime" name="blockteardowntime" type="text" value="#variables.blockteardowntime#" size="2" maxlength="2" />
						</div>

						<div>
              <label for="tonnage"><abbr title="#language.required#" class="required">*</abbr>&nbsp;#language.Tonnage#:</label>
              <input id="tonnage" name="tonnage" type="text" value="#variables.tonnage#" size="8" maxlength="8" />
						</div>

            <div>
              <label for="Anonymous">#language.anonymous#<sup><a href="##fn" title="#language.footnote#"><span class="navaid">#language.footnote#</span>&dagger;</a></sup>:</label>
              <input id="anonymous" type="checkbox" name="Anonymous" <cfif variables.Anonymous EQ 1>checked="true" </cfif>value="Yes" />
            </div>

            <div>
              <input type="hidden" name="VNID" value="#url.VNID#" />
              <input type="submit" value="#language.Submit#" name="submitForm" class="textbutton" />
            </div>
					</fieldset>
				</form>

        <p>&dagger;&nbsp;#language.anonymousWarning#</p>
				
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
</cfoutput>

