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
	<meta name=""dc.title"" lang=""eng"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.tariffHeading#"">
	<meta name=""keywords"" lang=""eng"" content=""#language.keywords#"">
	<meta name=""description"" lang=""eng"" content=""#language.description#"">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""#language.subjects#"">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.tariffHeading#</title>">

<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/build_form_struct.cfm">

<cfquery name="getDetails" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Vessels.Name AS VesselName, Companies.Name AS CompanyName, StartDate, EndDate
	FROM	Bookings INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID
			INNER JOIN Companies ON Vessels.CompanyID = Companies.CompanyID
			INNER JOIN UserCompanies ON UserCompanies.CompanyID = Vessels.CompanyID
	WHERE	Bookings.BookingID = '#URL.BookingID#'
		AND	UserCompanies.UserID = '#session.UserID#'
</cfquery>

<cfif lang EQ 'e'>
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

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">#language.Admin#</A> &gt;
			<CFELSE>
				<a href="#RootDir#text/reserve-book/booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			</CFIF>
			<A href="#RootDir#text/reserve-book/bookingRequest_choose.cfm?lang=<cfoutput>#lang#</cfoutput>">#language.bookingRequest#</A> &gt;
			#language.tariffHeading#
			</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<CFOUTPUT>#language.tariffHeading#</CFOUTPUT>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
				
				<cfinclude template="#RootDir#includes/getStructure.cfm">
				
				<cfoutput>
				<p align="center" style="font-weight:bold;">#getDetails.CompanyName#: #getDetails.VesselName#<br />
				#DateFormat(getDetails.StartDate, 'mmm d, yyyy')# - #DateFormat(getDetails.EndDate, 'mmm d, yyyy')#</p>
					<p align="left">#language.optional#</p>
					<div align="center">
						<input type="button" value="#language.later#" class="textbutton" onClick="javascript:self.location.href='otherForms.cfm?lang=#lang#';">
					</div>
				</cfoutput>
				<br>
				<cfform name="serviceSelect" action="#RootDir#text/reserve-book/feesForm_action.cfm?lang=#lang#&BookingID=#url.BookingID#">
				<table border="0" cellpadding="3" cellspacing="0" summary="This table displays the available services for a booking and allows the user to select the desired services.">
				<cfoutput>
					<tr>
						<th id="checkHeader" class="feesformheader" width="5%">&nbsp;</th>
						<th id="itemHeader" class="feesformheader" width="4%"><strong>#language.Item#</strong></th>
						<th id="serviceHeader" class="feesformheader"><strong>#language.Services#</strong></th>
						<th id="feeHeader" class="feesformheader" width="19%"><strong>#language.Fees#</strong></th>
					</tr>
				
					<tr>
						<td id="checkHeader" align="right" valign="top"><input name="other" id="otherCheck" type="Checkbox" onClick="if (this.checked) this.form.otherBox.focus();"></td>
						<td id="itemHeader" align="center" valign="top">&nbsp;</td>
						<td id="serviceHeader" align="left" valign="top">
							<table>
								<tr>
									<td valign="top"><label for="otherBox">#language.Misc#:</label></td>
									<td><textarea name="otherText" id="otherBox" cols="32" rows="3" onFocus="this.form.otherCheck.checked = true;"></textarea></td>
								</tr>
								<tr><td colspan="2">#language.miscText2#<br /><br />(#language.miscText#)</td></tr>
							</table>
						</td>
						<td id="feeHeader" align="right" valign="top">&nbsp;</td>
					</tr>
				</cfoutput>
				
				<cfoutput query="getFees">
					<cfif item NEQ "" AND item mod 2>
						<cfset rowClass = "highlight">
					<cfelseif item NEQ "">
						<cfset rowClass = "">
					</cfif>
			
					<tr class="#rowClass#">
						<td id="checkHeader" align="right" valign="top">
							<cfif fee NEQ "">
								<input name="#abbreviation#" id="#abbreviation#" type="Checkbox">
							</cfif>
						</td>
						<td headers="itemHeader" align="center" valign="top">
							<strong>
								<cfif fee NEQ "">
									<label for="#abbreviation#">#item#</label>
								<cfelse>
									#item#
								</cfif>
							</strong>
						</td>
						<td headers="serviceHeader" align="left" valign="top">
							<cfif fee NEQ "">
								<label for="#abbreviation#">#service#</label>
							<cfelse>
								#service#
							</cfif>
						</td>
						<cfif fee NEQ "">
							<cfif flex EQ 0>
						<td headers="feeHeader" align="right" valign="top" nowrap><label for="#abbreviation#"><STRONG>#LSCurrencyFormat(fee)#</STRONG></label></td>
							<cfelse>
						<td headers="feeHeader" align="right" valign="top"><label for="#abbreviation#"><STRONG>#language.pricesVary#</STRONG></label></td>
							</cfif>
						<cfelse>
						<td headers="feeHeader">&nbsp;</td>
						</cfif>
					</tr>
				</cfoutput>
				</table>
				
				<cfoutput>
				<input type="hidden" name="bookingID" value="#url.bookingID#">
				<p><div align="right">
					<input type="submit" value="#language.Submit#" class="textbutton">
					<!---<input type="button" onClick="javascript:self.location.href='javascript:history.go(-1);'" value="#language.Back#" class="textbutton">--->
				</div></p>
				</cfoutput>
				</cfform>
			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
