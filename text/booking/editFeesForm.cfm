<cfif lang EQ "e">
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
	<cfset language.tableSummary = "Ce tableau affiche les services choisis pour la réservation et permet à l'utilisateur de modifier l'information.">
	<cfset language.misc = "Divers">
	<cfset language.miscText = "Veuillez inclure l'&eacute;tendue des travaux et les services qui seront peut-être requis.">
	<cfset language.pricesVary = "les prix varient">
</cfif>

<cfoutput>
	<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.editTariffHeading#"">
	<meta name=""keywords"" lang=""eng"" content=""#language.keywords#"">
	<meta name=""description"" lang=""eng"" content=""#language.description#"">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""#language.subjects#"">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.editTariffHeading#</title>">
</cfoutput>

<cfinclude template="#RootDir#includes/header-#lang#.cfm">

<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/build_form_struct.cfm">


<CFPARAM name="url.referrer" default="Booking Home">
<CFIF url.referrer eq "Archive">
	<CFSET returnTo = "#RootDir#text/booking/bookingArchives.cfm">
	<CFSET referrer = "Archive">
<CFELSE>
	<CFSET returnTo = "#RootDir#text/booking/booking.cfm">
</CFIF>


<cfquery name="getForm" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	*
	FROM	TariffForms
	WHERE	BookingID = '#url.BookingID#'
</cfquery>

<cfquery name="getDetails" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Vessels.Name AS VesselName, Vessels.CompanyID, Companies.Name AS CompanyName, StartDate, EndDate
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

<cflock timeout="20" scope="session" throwontimeout="no" type="readonly">
	<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Vessels.CompanyID
		FROM	Bookings INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID
				INNER JOIN UserCompanies ON Vessels.CompanyID = UserCompanies.CompanyID
		WHERE	Bookings.Deleted = 0 AND Bookings.BookingID = #url.BookingID#
				AND UserCompanies.UserID = #session.UserID# AND UserCompanies.Deleted = 0
	</cfquery>
</cflock>

<cfif getCompanies.recordCount EQ 0 OR getDetails.recordCount EQ 0>
	<cfif url.referrer eq "archive">
		<cflocation addtoken="no" url="#returnTo#?lang=#lang#&companyID=#url.companyID#">
	<cfelse>
		<cflocation addtoken="no" url="#returnTo#?lang=#lang#">
	</cfif>
</cfif>

<!-- Start JavaScript Block -->
<script language="JavaScript" type="text/javascript">
<!--
function EditSubmit ( selectedform )
{
  document.forms[selectedform].submit() ;
}
//-->
</script>


<CFOUTPUT>
	<div class="breadcrumbs">
		<a href="http://www.pwgsc.gc.ca/text/home-#lang#.html">#language.PWGSC#</a> &gt;
		#language.PacificRegion# &gt;
		<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-#lang#.html">#language.EsqGravingDock#</a> &gt;
		<a href="#RootDir#text/booking-#lang#.cfm">#language.Booking#</A> &gt;
		<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
		<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">#language.Admin#</A> &gt;
	<CFELSE>
		<a href="#RootDir#text/booking/booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
	</CFIF>
		#language.editTariffHeading#
	</div>

	<div class="main">
	<H1>#language.editTariffHeading#</H1>
</cfoutput>
<CFINCLUDE template="#RootDir#includes/user_menu.cfm"><br>

<cfinclude template="#RootDir#includes/getStructure.cfm">

<br>
<cfoutput><div align="center" style="font-weight:bold;">#getDetails.CompanyName#: #getDetails.VesselName#</div></cfoutput>
<cfoutput><div align="center" style="font-weight:bold;">#LSDateFormat(getDetails.StartDate, 'mmm d, yyyy')# - #LSDateFormat(getDetails.EndDate, 'mmm d, yyyy')#</div></cfoutput>
<br>
<cfform name="serviceSelect" action="editFeesForm_action.cfm?lang=#lang#&amp;BookingID=#url.BookingID#&referrer=#url.referrer#">
<cfoutput>
<table border="0" cellpadding="3" cellspacing="0" summary="#language.tableSummary#">
	<tr>
		<th id="checkHeader" class="feesformheader" width="5%">&nbsp;</th>
		<th id="itemHeader" class="feesformheader" width="4%"><strong>#language.Item#</strong></th>
		<th id="serviceHeader" class="feesformheader"><strong>#language.Services#</strong></th>
		<th id="feeHeader" class="feesformheader" width="19%"><strong>#language.Fees#</strong></th>
	</tr>

	<tr>
		<td headers="checkHeader" align="right" valign="top"><input name="other" id="otherCheck" type="Checkbox" <cfif getForm.other EQ 1>checked</cfif> onClick="if (this.checked) this.form.otherBox.focus();"></td>
		<td headers="itemHeader" align="center" valign="top">&nbsp;</td>
		<td headers="serviceHeader" align="left" valign="top">
			<table>
				<tr>
					<td valign="top"><label for="otherBox">#language.Misc#:</label></td>
					<td><textarea name="otherText" id="otherBox" cols="35" rows="3" onFocus="this.form.otherCheck.checked = true;">#getForm.otherText#</textarea></td>
				</tr>
				<tr><td colspan="2">(#language.miscText#)</td></tr>
			</table>
		</td>
		<td headers="feeHeader" align="right" valign="top">&nbsp;</td>
	</tr>
</cfoutput>

	<cfoutput query="getFees">
		<cfif item NEQ "" AND item mod 2>
			<cfset backColor = "##FFF8DC">
		<cfelseif item NEQ "">
			<cfset backColor = "##FFFFFF">
		</cfif>

		<tr bgcolor="#backColor#">
		<td headers="checkHeader" align="right" valign="top">
			<cfif fee NEQ "">
				<cfset Variables.Abbr = "getForm." & #abbreviation#>
				<input name="#abbreviation#" id="#abbreviation#" type="Checkbox"<cfif Evaluate(Variables.Abbr) EQ 1> checked</cfif>>
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
	<cfoutput>
		<!---a href="javascript:EditSubmit('serviceSelect');" class="textbutton">#language.Submit#</a>
		<a href="booking.cfm?lang=#lang#&amp;CompanyID=#url.CompanyID#" class="textbutton">#language.Back#</a--->
		<input type="hidden" name="CompanyID" value="#getDetails.CompanyID#" class="textField">
		<input type="submit" value="#language.Submit#" class="textbutton">
		<input type="button" value="#language.Back#" onClick="self.location.href='#returnTo#?lang=#lang#&amp;CompanyID=#getDetails.CompanyID#'" class="textbutton">
	</cfoutput>
</div>
</cfform>

</div>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">