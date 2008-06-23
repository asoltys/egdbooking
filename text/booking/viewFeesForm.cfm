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
	<meta name=""dc.title"" lang=""eng"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.ViewTariffHeading#"">
	<meta name=""keywords"" lang=""eng"" content=""#language.keywords#"">
	<meta name=""description"" lang=""eng"" content=""#language.description#"">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""#language.subjects#"">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.ViewTariffHeading#</title>">

<cfquery name="getForm" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	*
	FROM	TariffForms
	<cfif isDefined("url.bookingID")>WHERE	BookingID = '#url.BookingID#'</cfif>
</cfquery>

<cfquery name="getDetails" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Vessels.Name AS VesselName, Vessels.CompanyID, Companies.Name AS CompanyName, StartDate, EndDate
	FROM	Bookings INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID
			INNER JOIN Companies ON Vessels.CompanyID = Companies.CompanyID
	<cfif isDefined("url.bookingId")>WHERE	Bookings.BookingID = '#url.BookingID#'</cfif>
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

<cflock timeout="20" scope="session" throwontimeout="no" type="readonly">
	<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Vessels.CompanyID
		FROM	Bookings INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID
				INNER JOIN UserCompanies ON Vessels.CompanyID = UserCompanies.CompanyID
		WHERE	Bookings.Deleted = 0 <cfif isdefined("url.bookingid")>AND Bookings.BookingID = #url.BookingID#</cfif>
				AND UserCompanies.UserID = #session.UserID# AND UserCompanies.Deleted = 0
	</cfquery>
</cflock>

<cfif getCompanies.recordCount EQ 0 OR getDetails.recordCount EQ 0>
	<cfif isDefined("url.bookingID")>
		<cfif isDefined("url.referrer") AND url.referrer eq "archive">
			<cflocation addtoken="no" url="bookingArchives.cfm?lang=#lang#&companyId=#url.companyID#">
		<cfelse>
			<cflocation addtoken="no" url="booking.cfm?lang=#lang#">
		</cfif>
	</cfif>
</cfif>

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">#language.Admin#</A> &gt;
			<CFELSE>
				<a href="#RootDir#text/booking/booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			</CFIF>
			#language.ViewTariffHeading#
			</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<CFOUTPUT>#language.ViewTariffHeading#</CFOUTPUT>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
				
				<cfinclude template="#RootDir#includes/getStructure.cfm">
				
				<cfif isDefined("url.BookingID")><cfoutput><div align="center" style="font-weight:bold;">#getDetails.CompanyName#: #getDetails.VesselName#</div></cfoutput>
				<cfoutput><div align="center" style="font-weight:bold;">#LSDateFormat(getDetails.StartDate, 'mmm d, yyyy')# - #LSDateFormat(getDetails.EndDate, 'mmm d, yyyy')#</div></cfoutput></cfif>
				<br>
				<table border="0" cellpadding="3" cellspacing="0" summary="This table displays the selected services for the booking.">
				<cfoutput>
					<tr>
						<th id="checkHeader" class="feesformheader" width="5%">&nbsp;</th>
						<th id="itemHeader" class="feesformheader" width="4%"><strong>#language.Item#</strong></th>
						<th id="serviceHeader" class="feesformheader"><strong>#language.Services#</strong></th>
						<th id="feeHeader" class="feesformheader" width="19%"><strong>#language.Fees#</strong></th>
					</tr>
				
					<tr>
						<td headers="checkHeader" align="right" valign="top"><input name="other" type="Checkbox" <cfif isDefined("url.bookingID")><cfif getForm.other EQ 1>checked</cfif></cfif> disabled></td>
						<td headers="itemHeader" align="center" valign="top">&nbsp;</td>
						<td headers="serviceHeader" align="left" valign="top">
							<table>
								<tr>
									<td valign="top">#language.Misc#:</td>
									<td><textarea name="otherText" cols="32" rows="3" disabled><cfif isDefined("url.bookingID")><cfif getForm.other EQ 1>#getForm.otherText#</cfif></cfif></textarea></td>
								</tr>
								<tr><td colspan="2">(#language.miscText#)</td></tr>
							</table>
						</td>
						<td headers="feeHeader" align="right" valign="top">&nbsp;</td>
					</tr>
				</cfoutput>
				
				<cfoutput query="getFees">
					<cfif item NEQ "" AND item mod 2>
						<cfset rowClass = "highlight">
					<cfelseif item NEQ "">
						<cfset rowClass = "">
					</cfif>
				
					<tr class="#rowClass#">
						<td headers="checkHeader" align="right" valign="top">
							<cfif fee NEQ "">
								<cfset Variables.Abbr = "getForm." & #abbreviation#>
								<input name="#abbreviation#" id="#abbreviation#" type="Checkbox" <cfif isDefined("url.bookingID")><cfif Evaluate(Variables.Abbr) EQ 1>checked</cfif></cfif> disabled>
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
				<br>
				<div align="right">
					<cfif isDefined("url.referrer") AND url.referrer eq "archive">
						<cfoutput><a href="bookingArchives.cfm?lang=#lang#&amp;CompanyID=#url.CompanyID#" class="textbutton">#language.Back#</a></cfoutput>
					<cfelse>
						<cfoutput><a href="booking.cfm?lang=#lang#&amp;CompanyID=#getDetails.CompanyID#" class="textbutton">#language.Back#</a></cfoutput>
					</cfif>
				</div>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

