<cfoutput>

<cfinclude template="#RootDir#includes/generalLanguageVariables.cfm">
<cfif lang EQ "eng">
	<cfset language.viewTariffHeading = "View Tariff of Dock Charges">
	<cfset language.keywords = language.masterKeywords & ", View of Tariff od Dock Charges">
	<cfset language.description = "Allows user to view information on services requested for a booking and the fees associated with them.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.item = "Item">
	<cfset language.services = "Services and Facilities">
	<cfset language.fees = "Fees">
	<cfset language.tableSummary = "This table displays the selected services for the booking.">
	<cfset language.misc = "Misc">
	<cfset language.miscText = "Please include scope of work and possible services required.">
	<cfset language.pricesVary = "prices vary">
<cfelse>
	<cfset language.viewTariffHeading = "Consulter le formulaire de tarif des droits de la cale s&egrave;che">
	<cfset language.keywords = language.masterKeywords & ", Consulter le formulaire de tarif des droits de la cale s&egrave;che">
	<cfset language.description = "Permet &agrave; l'utilisateur de voir l'information sur les services demand&eacute;s et les frais qui y sont associ&eacute;s.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.item = "Article">
	<cfset language.services = "Services et installations">
	<cfset language.fees = "frais">
	<cfset language.tableSummary = "">
	<cfset language.misc = "Divers&nbsp;">
	<cfset language.miscText = "Veuillez inclure l'&eacute;tendue des travaux et les services qui seront peut-&ecirc;tre requis.">
	<cfset language.pricesVary = "les prix varient">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.ViewTariffHeading# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.ViewTariffHeading# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfquery name="getDetails" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Vessels.Name AS VesselName, Vessels.CID, Companies.Name AS CompanyName, StartDate, EndDate
	FROM	Bookings INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
			INNER JOIN Companies ON Vessels.CID = Companies.CID
	<cfif isDefined("url.BRID")>WHERE	Bookings.BRID = <cfqueryparam value="#url.BRID#" cfsqltype="cf_sql_integer" /></cfif>
</cfquery>

<cfif lang EQ 'eng'>
	<cfquery name="getFees" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	item, serviceE AS service, fee, abbreviation, flex
		FROM	TariffFees
		ORDER BY sequence
	</cfquery>
<cfelse>
	<cfquery name="getFees" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	item, serviceF AS service, fee, abbreviation, flex
		FROM	TariffFees
		ORDER BY sequence
	</cfquery>
</cfif>

<cflock timeout="20" scope="session" throwontimeout="no" type="readonly">
	<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Vessels.CID
		FROM	Bookings INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
				INNER JOIN UserCompanies ON Vessels.CID = UserCompanies.CID
		WHERE	Bookings.Deleted = 0 <cfif isdefined("url.BRID")>AND Bookings.BRID = <cfqueryparam value="#url.BRID#" cfsqltype="cf_sql_integer" /></cfif>
				AND UserCompanies.UID = <cfqueryparam value="#session.UID#" cfsqltype="cf_sql_integer" /> AND UserCompanies.Deleted = 0
	</cfquery>
</cflock>

<cfif getCompanies.recordCount EQ 0 OR getDetails.recordCount EQ 0>
	<cfif isDefined("url.BRID")>
		<cfif isDefined("url.referrer") AND url.referrer eq "archive">
			<cflocation addtoken="no" url="#RootDir#reserve-book/archives.cfm?lang=#lang#&CID=#url.CID#">
		<cfelse>
			<cflocation addtoken="no" url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">
		</cfif>
	</cfif>
</cfif>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			<CFELSE>
				<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			</CFIF>
			#language.ViewTariffHeading#
			
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					#language.ViewTariffHeading#
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">

				<cfinclude template="#RootDir#includes/getStructure.cfm">

				<cfif isDefined("url.BRID")>
				
					<h2>#getDetails.CompanyName#: #getDetails.VesselName#</h2>
					<h3>#LSDateFormat(getDetails.StartDate, 'mmm d, yyyy')# - #LSDateFormat(getDetails.EndDate, 'mmm d, yyyy')#</h3>
				</cfif>

				<table summary="#language.<cfquery name="submitTariffForm" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE TariffForms
	SET		<cfif isDefined("Form.BookFee") AND Form.BookFee EQ "on">
					BookFee = '1',
				<cfelse>
					BookFee = '0', 
				</cfif>
				<cfif isDefined("Form.FullDrain") AND Form.FullDrain EQ "on">
					FullDrain = '1', 
				<cfelse>
					FullDrain = '0',
				</cfif>
				<cfif isDefined("Form.VesselDockage") AND Form.VesselDockage EQ "on">
					VesselDockage = '1', 
				<cfelse>
					VesselDockage = '0', 
				</cfif>
				<cfif isDefined("Form.CargoDockage") AND Form.CargoDockage EQ "on">
					CargoDockage = '1', 
				<cfelse>
					CargoDockage = '0', 
				</cfif>
				<cfif isDefined("Form.WorkVesselBerthNorth") AND Form.WorkVesselBerthNorth EQ "on">
					WorkVesselBerthNorth = '1', 
				<cfelse>
					WorkVesselBerthNorth = '0',  
				</cfif>
				<cfif isDefined("Form.NonworkVesselBerthNorth") AND Form.NonworkVesselBerthNorth EQ "on">
					NonworkVesselBerthNorth = '1', 
				<cfelse>
					NonworkVesselBerthNorth = '0', 
				</cfif>
				<cfif isDefined("Form.VesselBerthSouth") AND Form.VesselBerthSouth EQ "on">
					VesselBerthSouth = '1', 
				<cfelse>
					VesselBerthSouth = '0', 
				</cfif>
				<cfif isDefined("Form.CargoStore") AND Form.CargoStore EQ "on">
					CargoStore = '1', 
				<cfelse>
					CargoStore = '0', 
				</cfif>
				<cfif isDefined("Form.TopWharfage") AND Form.TopWharfage EQ "on">
					TopWharfage = '1', 
				<cfelse>
					TopWharfage = '0', 
				</cfif>
				<cfif isDefined("Form.CraneLightHook") AND Form.CraneLightHook EQ "on">
					CraneLightHook = '1', 
				<cfelse>
					CraneLightHook = '0', 
				</cfif>
				<cfif isDefined("Form.CraneMedHook") AND Form.CraneMedHook EQ "on">
					CraneMedHook = '1', 
				<cfelse>
					CraneMedHook = '0', 
				</cfif>
				<cfif isDefined("Form.CraneBigHook") AND Form.CraneBigHook EQ "on">
					CraneBigHook = '1', 
				<cfelse>
					CraneBigHook = '0', 
				</cfif>
				<cfif isDefined("Form.CraneHyster") AND Form.CraneHyster EQ "on">
					CraneHyster = '1', 
				<cfelse>
					CraneHyster = '0', 
				</cfif>
				<cfif isDefined("Form.CraneGrove") AND Form.CraneGrove EQ "on">
					CraneGrove = '1', 
				<cfelse>
					CraneGrove = '0', 
				</cfif>
				<cfif isDefined("Form.Forklift") AND Form.Forklift EQ "on">
					Forklift = '1', 
				<cfelse>
					Forklift = '0', 
				</cfif>
				<cfif isDefined("Form.CompressPrimary") AND Form.CompressPrimary EQ "on">
					CompressPrimary = '1', 
				<cfelse>
					CompressPrimary = '0', 
				</cfif>
				<cfif isDefined("Form.CompressSecondary") AND Form.CompressSecondary EQ "on">
					CompressSecondary = '1', 
				<cfelse>
					CompressSecondary = '0', 
				</cfif>
				<cfif isDefined("Form.CompressPortable") AND Form.CompressPortable EQ "on">
					CompressPortable = '1', 
				<cfelse>
					CompressPortable = '0', 
				</cfif>
				<cfif isDefined("Form.Tug") AND Form.Tug EQ "on">
					Tug = '1', 
				<cfelse>
					Tug = '0', 
				</cfif>
				<cfif isDefined("Form.FreshH2O") AND Form.FreshH2O EQ "on">
					FreshH2O = '1', 
				<cfelse>
					FreshH2O = '0', 
				</cfif>
				<cfif isDefined("Form.Electric") AND Form.Electric EQ "on">
					Electric = '1', 
				<cfelse>
					Electric = '0',  
				</cfif>
				<cfif isDefined("Form.TieUp") AND Form.TieUp EQ "on">
					TieUp = '1', 
				<cfelse>
					TieUp = '0', 
				</cfif>
				<cfif isDefined("Form.Commissionaire") AND Form.Commissionaire EQ "on">
					Commissionaire = '1', 
				<cfelse>
					Commissionaire = '0',  
				</cfif>
				<cfif isDefined("Form.OvertimeLabour") AND Form.OvertimeLabour EQ "on">
					OvertimeLabour = '1', 
				<cfelse>
					OvertimeLabour = '0', 
				</cfif>
				<cfif isDefined("Form.LightsStandard") AND Form.LightsStandard EQ "on">
					LightsStandard = '1', 
				<cfelse>
					LightsStandard = '0', 
				</cfif>
				<cfif isDefined("Form.LightsCaisson") AND Form.LightsCaisson EQ "on">
					LightsCaisson = '1',
				<cfelse>
					LightsCaisson = '0',
				</cfif>
				<cfif isDefined("Form.Other") AND Form.Other EQ "on" AND trIM(Form.otherText) NEQ "">
					otherText = <cfqueryparam value="#Form.otherText#" cfsqltype="cf_sql_varchar" />,
					Other = '1'
				<cfelse>
					otherText = '',
					Other = '0'
				</cfif>
				WHERE BRID = <cfqueryparam value="#form.BRID#" cfsqltype="cf_sql_integer" />
</cfquery>
tablesummary#">
					<tr>
						<th>#language.Services#</th>
						<th>#language.Fees#</th>
					</tr>
				

				<cfloop query="getFees">
					<cfif item NEQ "" AND item mod 2>
						<cfset rowClass = "highlight">
					<cfelseif item NEQ "">
						<cfset rowClass = "">
					</cfif>

					<tr class="#rowClass#">
						<td headers="serviceHeader">
							<cfif fee NEQ "">
								<span>#service#</span>
							<cfelse>
								#service#
							</cfif>
						</td>
						<cfif fee NEQ "">
							<cfif flex EQ 0>
                <td headers="feeHeader"><strong>#LSCurrencyFormat(fee)#</strong></td>
							<cfelse>
                <td headers="feeHeader"><strong>#language.pricesVary#</strong></td>
							</cfif>
						<cfelse>
              <td headers="feeHeader">&nbsp;</td>
						</cfif>
					</tr>
        </cfloop>
				
				</table><cfquery name="submitTariffForm" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE TariffForms
	SET		<cfif isDefined("Form.BookFee") AND Form.BookFee EQ "on">
					BookFee = '1',
				<cfelse>
					BookFee = '0', 
				</cfif>
				<cfif isDefined("Form.FullDrain") AND Form.FullDrain EQ "on">
					FullDrain = '1', 
				<cfelse>
					FullDrain = '0',
				</cfif>
				<cfif isDefined("Form.VesselDockage") AND Form.VesselDockage EQ "on">
					VesselDockage = '1', 
				<cfelse>
					VesselDockage = '0', 
				</cfif>
				<cfif isDefined("Form.CargoDockage") AND Form.CargoDockage EQ "on">
					CargoDockage = '1', 
				<cfelse>
					CargoDockage = '0', 
				</cfif>
				<cfif isDefined("Form.WorkVesselBerthNorth") AND Form.WorkVesselBerthNorth EQ "on">
					WorkVesselBerthNorth = '1', 
				<cfelse>
					WorkVesselBerthNorth = '0',  
				</cfif>
				<cfif isDefined("Form.NonworkVesselBerthNorth") AND Form.NonworkVesselBerthNorth EQ "on">
					NonworkVesselBerthNorth = '1', 
				<cfelse>
					NonworkVesselBerthNorth = '0', 
				</cfif>
				<cfif isDefined("Form.VesselBerthSouth") AND Form.VesselBerthSouth EQ "on">
					VesselBerthSouth = '1', 
				<cfelse>
					VesselBerthSouth = '0', 
				</cfif>
				<cfif isDefined("Form.CargoStore") AND Form.CargoStore EQ "on">
					CargoStore = '1', 
				<cfelse>
					CargoStore = '0', 
				</cfif>
				<cfif isDefined("Form.TopWharfage") AND Form.TopWharfage EQ "on">
					TopWharfage = '1', 
				<cfelse>
					TopWharfage = '0', 
				</cfif>
				<cfif isDefined("Form.CraneLightHook") AND Form.CraneLightHook EQ "on">
					CraneLightHook = '1', 
				<cfelse>
					CraneLightHook = '0', 
				</cfif>
				<cfif isDefined("Form.CraneMedHook") AND Form.CraneMedHook EQ "on">
					CraneMedHook = '1', 
				<cfelse>
					CraneMedHook = '0', 
				</cfif>
				<cfif isDefined("Form.CraneBigHook") AND Form.CraneBigHook EQ "on">
					CraneBigHook = '1', 
				<cfelse>
					CraneBigHook = '0', 
				</cfif>
				<cfif isDefined("Form.CraneHyster") AND Form.CraneHyster EQ "on">
					CraneHyster = '1', 
				<cfelse>
					CraneHyster = '0', 
				</cfif>
				<cfif isDefined("Form.CraneGrove") AND Form.CraneGrove EQ "on">
					CraneGrove = '1', 
				<cfelse>
					CraneGrove = '0', 
				</cfif>
				<cfif isDefined("Form.Forklift") AND Form.Forklift EQ "on">
					Forklift = '1', 
				<cfelse>
					Forklift = '0', 
				</cfif>
				<cfif isDefined("Form.CompressPrimary") AND Form.CompressPrimary EQ "on">
					CompressPrimary = '1', 
				<cfelse>
					CompressPrimary = '0', 
				</cfif>
				<cfif isDefined("Form.CompressSecondary") AND Form.CompressSecondary EQ "on">
					CompressSecondary = '1', 
				<cfelse>
					CompressSecondary = '0', 
				</cfif>
				<cfif isDefined("Form.CompressPortable") AND Form.CompressPortable EQ "on">
					CompressPortable = '1', 
				<cfelse>
					CompressPortable = '0', 
				</cfif>
				<cfif isDefined("Form.Tug") AND Form.Tug EQ "on">
					Tug = '1', 
				<cfelse>
					Tug = '0', 
				</cfif>
				<cfif isDefined("Form.FreshH2O") AND Form.FreshH2O EQ "on">
					FreshH2O = '1', 
				<cfelse>
					FreshH2O = '0', 
				</cfif>
				<cfif isDefined("Form.Electric") AND Form.Electric EQ "on">
					Electric = '1', 
				<cfelse>
					Electric = '0',  
				</cfif>
				<cfif isDefined("Form.TieUp") AND Form.TieUp EQ "on">
					TieUp = '1', 
				<cfelse>
					TieUp = '0', 
				</cfif>
				<cfif isDefined("Form.Commissionaire") AND Form.Commissionaire EQ "on">
					Commissionaire = '1', 
				<cfelse>
					Commissionaire = '0',  
				</cfif>
				<cfif isDefined("Form.OvertimeLabour") AND Form.OvertimeLabour EQ "on">
					OvertimeLabour = '1', 
				<cfelse>
					OvertimeLabour = '0', 
				</cfif>
				<cfif isDefined("Form.LightsStandard") AND Form.LightsStandard EQ "on">
					LightsStandard = '1', 
				<cfelse>
					LightsStandard = '0', 
				</cfif>
				<cfif isDefined("Form.LightsCaisson") AND Form.LightsCaisson EQ "on">
					LightsCaisson = '1',
				<cfelse>
					LightsCaisson = '0',
				</cfif>
				<cfif isDefined("Form.Other") AND Form.Other EQ "on" AND trIM(Form.otherText) NEQ "">
					otherText = <cfqueryparam value="#Form.otherText#" cfsqltype="cf_sql_varchar" />,
					Other = '1'
				<cfelse>
					otherText = '',
					Other = '0'
				</cfif>
				WHERE BRID = <cfqueryparam value="#form.BRID#" cfsqltype="cf_sql_integer" />
</cfquery>

				<div class="buttons">
					<cfif isDefined("url.referrer") AND url.referrer eq "archive">
						<a href="#RootDir#reserve-book/archives.cfm?lang=#lang#&amp;CID=#url.CID#" class="textbutton">#language.Back#</a>
					<cfelse>
						<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#&amp;CID=#getDetails.CID#" class="textbutton">#language.Back#</a>
					</cfif>
				</div>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

</cfoutput>
