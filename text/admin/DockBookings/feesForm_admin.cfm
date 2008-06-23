<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/build_form_struct.cfm">

<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Tariff of Dock Charges"">
<meta name=""keywords"" lang=""eng"" content="""">
<meta name=""description"" lang=""eng"" content="""">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Tariff of Dock Charges</title>">

<CFPARAM name="url.referrer" default="Drydock Booking Management">
<CFIF url.referrer eq "Booking Details">
	<CFSET returnTo = "#RootDir#text/common/getBookingDetail.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#text/admin/DockBookings/bookingManage.cfm">
</CFIF>

<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>

<CFIF IsDefined('form.BookingID')>
	<CFSET Variables.BookingID = form.BookingID>
<CFELSEIF IsDefined('url.BookingID')>
	<CFSET Variables.BookingID = url.BookingID>
<CFELSE>
	<cflocation addtoken="no" url="#RootDir#text/admin/menu.cfm?lang=#lang#">
</CFIF>

<cfquery name="getForm" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	*
	FROM	TariffForms
	WHERE	BookingID = '#Variables.BookingID#'
</cfquery>

<cfquery name="getDetails" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Vessels.Name AS VesselName, Companies.Name AS CompanyName, StartDate, EndDate
	FROM	Bookings INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID 
			INNER JOIN Companies ON Vessels.CompanyID = Companies.CompanyID
	WHERE	Bookings.BookingID = '#Variables.BookingID#'
</cfquery>

<cfquery name="getFees" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	item, serviceE AS service, fee, abbreviation, flex
	FROM	TariffFees
	ORDER BY sequence
</cfquery>

<!-- Start JavaScript Block -->
<script language="JavaScript" type="text/javascript">
	<!--
	function EditSubmit ( selectedform )
	{
	  document.forms[selectedform].submit() ;
	}
	//-->
</script>
<!-- End JavaScript Block -->

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-eng.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
			<CFELSE>
				 <a href="#RootDir#text/booking/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			<A href="bookingmanage.cfm?lang=#lang#">Drydock Management</A> &gt;
			</CFOUTPUT>
			Tariff of Dock Charges
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-eng.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Tariff of Dock Charges
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>
	
				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>
				
				<cfinclude template="#RootDir#includes/getStructure.cfm">
				
				<br>
				<cfoutput><div align="center" style="font-weight:bold;">#getDetails.CompanyName#: #getDetails.VesselName#</div></cfoutput>
				<cfoutput><div align="center" style="font-weight:bold;">#DateFormat(getDetails.StartDate, 'mmm d, yyyy')# - #DateFormat(getDetails.EndDate, 'mmm d, yyyy')#</div></cfoutput>
				<br>
				<cfform name="serviceSelect" action="feesForm_admin_action.cfm?#urltoken#&referrer=#URLEncodedFormat(url.referrer)##variables.dateValue#">
				<table border="0" cellpadding="3" cellspacing="0" summary="This table displays the selected services for the booking and allows the administrator to edit the information.">
					<tr>
						<th id="checkHeader" class="feesformheader" width="5%">&nbsp;</th>
						<th id="itemHeader" class="feesformheader" width="4%"><strong>Item</strong></th>
						<th id="serviceHeader" class="feesformheader"><strong>Services and Facilities</strong></th>
						<th id="feeHeader" class="feesformheader" width="19%"><strong>Fees</strong></th>
					</tr>
					
					<tr>
						<td id="checkHeader" align="right" valign="top"><input name="other" id="otherCheck" type="Checkbox" <cfif getForm.other EQ 1>checked</cfif> onClick="if (this.checked) this.form.otherBox.focus();"></td>
						<td id="itemHeader" align="center" valign="top">&nbsp;</td>
						<td id="serviceHeader" align="left" valign="top">
							<table>
								<tr>
									<td valign="top"><label for="otherBox">Misc:</label></td>
									<td><textarea name="otherText" id="otherBox" cols="40" rows="3" onFocus="this.form.otherCheck.checked = true;"><cfoutput>#getForm.otherText#</cfoutput></textarea></td>
								</tr>
								<tr><td colspan="2">(Please include scope of work and possible services required.)</td></tr>
							</table>
						</td>
						<td id="feeHeader" align="right" valign="top">&nbsp;</td>
					</tr>
					
					<cfoutput query="getFees">
						<cfif item NEQ "" AND item mod 2>
							<cfset rowClass = "highlight">
						<cfelseif item NEQ "">
							<cfset rowClass = "">
						</cfif>
				
						<tr class="#rowClass#">
							<td id="checkHeader" align="right" valign="top">
								<cfif fee NEQ "">
									<cfset Variables.Abbr = "getForm." & #abbreviation#>
									<input name="#abbreviation#" id="#abbreviation#" type="Checkbox" <cfif Evaluate(Variables.Abbr) EQ 1>checked</cfif>>		
								</cfif>
							</td>
							<td id="itemHeader" align="center" valign="top"><strong><label for="#abbreviation#">#item#</label></strong></td>
							<td id="serviceHeader" align="left" valign="top"><label for="#abbreviation#">#service#</label></td>
							<td id="feeHeader" align="right" valign="top"><label for="#abbreviation#"><cfif fee NEQ ""><strong><cfif flex EQ 0>#LSCurrencyFormat(fee)#<cfelse>prices vary</cfif></strong></cfif></label></td>
						</tr>
					</cfoutput>
				</table>
				
				<cfoutput><input type="hidden" name="bookingID" value=#Variables.bookingID#></cfoutput>
				
				<br />
				<div align="right">
					<!--a href="javascript:EditSubmit('serviceSelect');" class="textbutton">Submit</a-->
					<input type="submit" name="submitForm" class="textbutton" value="submit">
					<cfoutput><input type="button" value="Back" onClick="self.location.href='#returnTo#?#urltoken#&bookingID=#variables.bookingID##variables.dateValue###id#variables.bookingid#'" class="textbutton"></cfoutput>
				</div>
								
				</cfform>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
