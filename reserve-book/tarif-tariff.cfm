<cfoutput>

<cfif lang EQ "eng">
	<cfset language.tariffHeading = "Tariff of Dock Charges">
	<cfset language.keywords = language.masterKeywords & ", Tariff of Dock Charges">
	<cfset language.description = "Allows user to provide information on services requested for a booking and the fees associated with them.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.item = "Item">
	<cfset language.services = "Services and Facilities">
	<cfset language.fees = "Fees">
	<cfset language.tableSummary = "This table displays the selected services for the booking.">
	<cfset language.misc = "Misc">
	<cfset language.miscText = "Please include scope of work and possible services required.">
	<cfset language.miscText2 = "All services including the Booking Fee will be charged and additional 6% for Goods & Services Tax (GST).">
	<cfset language.pricesVary = "prices vary">
	<cfset language.later = "specify services later">
	<cfset language.optional = "This is an optional form.  Specifying your required services and facilities helps the Esquimalt Graving Dock serve you better.  However, it is not a required part of the booking process.">
	<cfset language.bookingRequest = "Booking Request">
<cfelse>
	<cfset language.tariffHeading = "Tarif des droits de cale s&egrave;che">
	<cfset language.keywords = language.masterKeywords & ", Tarif des droit de cale s&egrave;che">
	<cfset language.description = "Permet &agrave; l'utilisateur de fournir de l'information sur les services demand&eacute;s pour une r&eacute;servation et de voir les frais qui y sont associ&eacute;s.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.item = "Article">
	<cfset language.services = "Services et installations">
	<cfset language.fees = "frais">
	<cfset language.tableSummary = "Ce tableau affiche les services choisis pour la r&eacute;servation.">
	<cfset language.misc = "Divers">
	<cfset language.miscText = "Veuillez inclure l'&eacute;tendue des travaux et les services qui seront peut-&ecirc;tre requis.">
	<cfset language.miscText2 = "Tous les services, y  compris les frais de r&eacute;servation, feront l&rsquo;objet d&rsquo;une taxe sur les produits et  services&nbsp;(TPS) de 6&nbsp;%.">
	<cfset language.pricesVary = "les prix varient">
	<cfset language.later = "pr&eacute;ciser les services plus tard">
	<cfset language.optional = "Il s'agit d'un formulaire facultatif. La communication des services et des installations dont vous avez besoin aide le personnel de la cale s&egrave;che d'Esquimalt &agrave; mieux vous servir. Cependant, il ne s'agit pas d'une &eacute;tape obligatoire du processus de r&eacute;servation.">
	<cfset language.bookingRequest = "Demande de r&eacute;servation">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.tariffHeading# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.tariffHeading# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/build_form_struct.cfm">

<cfquery name="getDetails" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Vessels.Name AS VesselName, Companies.Name AS CompanyName, StartDate, EndDate
	FROM	Bookings INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
			INNER JOIN Companies ON Vessels.CID = Companies.CID
			INNER JOIN UserCompanies ON UserCompanies.CID = Vessels.CID
	WHERE	Bookings.BRID = <cfqueryparam value="#URL.BRID#" cfsqltype="cf_sql_integer" />
		AND	UserCompanies.UID = <cfqueryparam value="#session.UID#" cfsqltype="cf_sql_integer" />
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

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			<CFELSE>
				<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			</CFIF>
			<a href="#RootDir#reserve-book/resdemande-bookrequest.cfm?lang=#lang#">#language.bookingRequest#</a> &gt;
			#language.tariffHeading#
			
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					#language.tariffHeading#
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">

				<cfinclude template="#RootDir#includes/getStructure.cfm">

				<p style="font-weight:bold;">#getDetails.CompanyName#: #getDetails.VesselName#<br />
				#DateFormat(getDetails.StartDate, 'mmm d, yyyy')# - #DateFormat(getDetails.EndDate, 'mmm d, yyyy')#</p>
					<p>#language.optional#</p>
					<div style="text-align:center;">
						<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#" class="textbutton">#language.later#</a>
					</div>
				<br />

				<form id="serviceSelect" action="#RootDir#reserve-book/tarif-tariff_action.cfm?lang=#lang#&amp;BRID=#url.BRID#" method="post">
				<table summary="This table displays the available services for a booking and allows the user to select the desired services.">
					<tr>
						<th></th>
						<th>#language.Services#</th>
						<th>#language.Fees#</th>
					</tr>

					<tr>
						<td id="checkHeader"><input name="other" id="otherCheck" type="checkbox" /></td>
						<td id="serviceHeader">
              Misc:<br />
							<textarea name="otherText" id="otherBox" rows="3" cols="32"></textarea>
              <br />
							(#language.miscText#)
						</td>
						<td id="feeHeader">&nbsp;</td>
					</tr>

				<cfloop query="getFees">
					<cfif item NEQ "" AND item mod 2>
						<cfset rowClass = "highlight">
					<cfelseif item NEQ "">
						<cfset rowClass = "">
					</cfif>

					<tr class="#rowClass#">
						<td>
							<cfif fee NEQ "">
								<input name="#abbreviation#" id="#abbreviation#" type="checkbox" />
							</cfif>
						</td>
						<td>
							<cfif fee NEQ "">
								<label for="#abbreviation#">#XmlFormat(service)#</label>
							<cfelse>
								#XmlFormat(service)#
							</cfif>
						</td>
						<cfif fee NEQ "">
							<cfif flex EQ 0>
						<td><label for="#abbreviation#"><strong>#LSCurrencyFormat(fee)#</strong></label></td>
							<cfelse>
						<td><label for="#abbreviation#"><strong>#language.pricesVary#</strong></label></td>
							</cfif>
						<cfelse>
						<td>&nbsp;</td>
						</cfif>
					</tr>
				</cfloop>
				</table>

				<p>
          <input type="hidden" name="BRID" value="#url.BRID#" />
					<input type="submit" value="#language.Submit#" class="textbutton" />
				</p>
				
				</form>
			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

</cfoutput>
