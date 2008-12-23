<cfif lang EQ "eng">
	<cfset language.editTariffHeading = "Edit Tariff of Dock Charges">
	<cfset language.keywords = language.masterKeywords & ", Edit Tariff of Dock Charges">
	<cfset language.description = "Allows user to change the services requested for a booking and see the fees associated with them.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.item = "Item">
	<cfset language.services = "Services and Facilities">
	<cfset language.fees = "Fees">
	<cfset language.tableSummary = "This table displays the selected services for the booking and allows the user to edit the information.">
	<cfset language.misc = "Misc">
	<cfset language.miscText = "Please include scope of work and possible services required.">
	<cfset language.pricesVary = "prices vary">
<cfelse>
	<cfset language.editTariffHeading = "Modification du formulaire de tarif des droits de cale s&egrave;che">
	<cfset language.keywords = language.masterKeywords & ", Modification du formulaire de tarif des droits de cale s&egrave;che">
	<cfset language.description = "Permet &agrave; l'utilisateur de changer les services demrand&eacute;s pour une r&eacute;servation et de voir les frais qui y sont associ&eacute;s.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.item = "Article">
	<cfset language.services = "Services et installations">
	<cfset language.fees = "frais">
	<cfset language.tableSummary = "Ce tableau affiche les services choisis pour la r&eacute;servation et permet &agrave; l'utilisateur de modifier l'information.">
	<cfset language.misc = "Divers">
	<cfset language.miscText = "Veuillez inclure l'&eacute;tendue des travaux et les services qui seront peut-&ecirc;tre requis.">
	<cfset language.pricesVary = "les prix varient">
</cfif>

<cfsavecontent variable="js">
	<cfoutput>
	<meta name="dc.title" content="#language.PWGSC# - #language.EsqGravingDockCaps# - #language.editTariffHeading#" />
	<meta name="keywords" content="#language.keywords#" />
	<meta name="description" content="#language.description#" />
	<meta name="dc.subject" scheme="gccore" content="#language.subjects#" />
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.editTariffHeading#</title>
	<script type="text/javascript">
		/* <![CDATA[ */
		Event.observe(window, 'load', function() {
			$('otherBox').observe('focus', function() {
				$('otherCheck').checked = true;
			});
		});

		/* ! ]]> */
	</script>
	</cfoutput>
</cfsavecontent>
<cfhtmlhead text="#js#">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/build_form_struct.cfm">


<CFPARAM name="url.referrer" default="Booking Home">
<CFIF url.referrer eq "Archive">
	<CFSET returnTo = "#RootDir#reserve-book/archives.cfm">
	<CFSET referrer = "Archive">
<CFELSE>
	<CFSET returnTo = "#RootDir#reserve-book/reserve-booking.cfm">
</CFIF>


<cfquery name="getForm" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	*
	FROM	TariffForms
	WHERE	BRID = '#url.BRID#'
</cfquery>

<cfquery name="getDetails" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Vessels.Name AS VesselName, Vessels.CID, Companies.Name AS CompanyName, StartDate, EndDate
	FROM	Bookings INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
			INNER JOIN Companies ON Vessels.CID = Companies.CID
			INNER JOIN UserCompanies ON UserCompanies.CID = Vessels.CID
	WHERE	Bookings.BRID = '#URL.BRID#'
		AND	UserCompanies.UID = '#session.UID#'
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
		WHERE	Bookings.Deleted = 0 AND Bookings.BRID = #url.BRID#
				AND UserCompanies.UID = #session.UID# AND UserCompanies.Deleted = 0
	</cfquery>
</cflock>

<cfif getCompanies.recordCount EQ 0 OR getDetails.recordCount EQ 0>
	<cfif url.referrer eq "archive">
		<cflocation addtoken="no" url="#returnTo#?lang=#lang#&CID=#url.CID#">
	<cfelse>
		<cflocation addtoken="no" url="#returnTo#?lang=#lang#">
	</cfif>
</cfif>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			<CFELSE>
				<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			</CFIF>
			#language.editTariffHeading#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.editTariffHeading#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">

				<cfinclude template="#RootDir#includes/getStructure.cfm">

				<cfoutput>
					<h2>#getDetails.CompanyName#: #getDetails.VesselName#</h2>
					<h3>#LSDateFormat(getDetails.StartDate, 'mmm d, yyyy')# - #LSDateFormat(getDetails.EndDate, 'mmm d, yyyy')#</h3>
				</cfoutput>

				<cfform id="serviceSelect" action="#RootDir#reserve-book/tarifmod-tariffedit_action.cfm?lang=#lang#&amp;BRID=#url.BRID#&amp;referrer=#url.referrer#">
				<cfoutput>
				<table class="basic" id="tariffs" summary="#language.tableSummary#">
					<tr>
						<th id="checkHeader"><label for="otherCheck">&nbsp;</label></th>
						<th id="itemHeader">#language.Item#</th>
						<th id="serviceHeader">#language.Services#</th>
						<th id="feeHeader">#language.Fees#</th>
					</tr>

					<tr>
						<td headers="checkHeader"><input name="other" id="otherCheck" type="checkbox" <cfif getForm.other EQ 1>checked="true"</cfif> /></td>
						<td headers="itemHeader">&nbsp;</td>
						<td headers="serviceHeader">
							<label for="otherBox">#language.Misc#:</label>
							<textarea name="otherText" id="otherBox" cols="35" rows="3">#getForm.otherText#</textarea>
							(#language.miscText#)
						</td>
						<td headers="feeHeader">&nbsp;</td>
					</tr>
				</cfoutput>

				<cfoutput query="getFees">
					<cfif item NEQ "" AND item mod 2>
						<cfset rowClass = "highlight">
					<cfelseif item NEQ "">
						<cfset rowClass = "">
					</cfif>

					<tr class="#rowClass#">

						<td headers="checkHeader">
							<cfif fee NEQ "">
								<cfset Variables.Abbr = "getForm." & #abbreviation#>
								<input name="#abbreviation#" id="#abbreviation#" type="checkbox"<cfif Evaluate(Variables.Abbr) EQ 1> checked="true"</cfif> />
							</cfif>
						</td>

						<td headers="itemHeader">
							<cfif fee NEQ "">
								<label for="#abbreviation#">#item#</label>
							<cfelse>
								#item#
							</cfif>
						</td>

						<td headers="serviceHeader">
							<cfif fee NEQ "">
								<label for="#abbreviation#">#service#</label>
							<cfelse>
								#service#
							</cfif>
						</td>

						<cfif fee NEQ "">
							<cfif flex EQ 0>
								<td headers="feeHeader"><label for="#abbreviation#"><strong>#LSCurrencyFormat(fee)#</strong></label></td>
							<cfelse>
								<td headers="feeHeader"><label for="#abbreviation#"><strong>#language.pricesVary#</strong></label></td>
							</cfif>
						<cfelse>
							<td headers="feeHeader">&nbsp;</td>
						</cfif>

					</tr>
				</cfoutput>
				</table>

				<div class="buttons">
				<cfoutput>
					<input type="hidden" name="CID" value="#getDetails.CID#" />
					<input type="submit" value="#language.Submit#" class="textbutton" />
					<input type="button" value="#language.Back#" onclick="self.location.href='#returnTo#?lang=#lang#&amp;CID=#getDetails.CID#'" class="textbutton" />
				</cfoutput>
				</div>
				</cfform>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

