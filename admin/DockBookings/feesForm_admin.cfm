<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/build_form_struct.cfm">

<cfhtmlhead text="
<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Tariff of Dock Charges"">
<meta name=""keywords"" content="""" />
<meta name=""description"" content="""" />
<meta name=""dc.date.published"" content=""2005-07-25"" />
<meta name=""dc.date.published"" content=""2005-07-25"" />
<meta name=""dc.date.reviewed"" content=""2005-07-25"" />
<meta name=""dc.date.modified"" content=""2005-07-25"" />
<meta name=""dc.date.created"" content=""2005-07-25"" />
<title>PWGSC - ESQUIMALT GRAVING DOCK - Tariff of Dock Charges</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFPARAM name="url.referrer" default="Drydock Booking Management">
<CFIF url.referrer eq "Booking Details">
	<CFSET returnTo = "#RootDir#comm/detail-res-book.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#admin/DockBookings/bookingManage.cfm">
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
	<cflocation addtoken="no" url="#RootDir#admin/menu.cfm?lang=#lang#">
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
<script type="text/javascript">
/* <![CDATA[ */
function EditSubmit ( selectedform )
	{
	  document.forms[selectedform].submit();
	}
/* ]]> */
</script>
<!-- End JavaScript Block -->

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt; 
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			<a href="bookingManage.cfm?lang=#lang#">Drydock Management</a> &gt;
			</cfoutput>
			Tariff of Dock Charges
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Tariff of Dock Charges
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>
	
				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				
				<cfinclude template="#RootDir#includes/getStructure.cfm">
				
				<br />
				<cfoutput><div style="text-align:center;" style="font-weight:bold;">#getDetails.CompanyName#: #getDetails.VesselName#</div></cfoutput>
				<cfoutput><div style="text-align:center;" style="font-weight:bold;">#DateFormat(getDetails.StartDate, 'mmm d, yyyy')# - #DateFormat(getDetails.EndDate, 'mmm d, yyyy')#</div></cfoutput>
				<br />
				<cfform name="serviceSelect" action="feesForm_admin_action.cfm?#urltoken#$amp;referrer=#URLEncodedFormat(url.referrer)##variables.dateValue#">
				<table border="0" cellpadding="3" cellspacing="0" summary="This table displays the selected services for the booking and allows the administrator to edit the information.">
					<tr>
						<th class="feesformheader" id="checkHeader" style="width:5%;">&nbsp;</th>
						<th class="feesformheader" id="itemHeader" style="width:4%;"><strong>Item</strong></th>
						<th id="serviceHeader" class="feesformheader"><strong>Services and Facilities</strong></th>
						<th class="feesformheader" id="feeHeader" style="width:19%;"><strong>Fees</strong></th>
					</tr>
					
					<tr>
						<td id="checkHeader" align="right" valign="top"><input name="other" id="otherCheck" type="checkbox" <cfif getForm.other EQ 1>checked="true"</cfif> onclick="if (this.checked) this.form.otherBox.focus();" />
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
									<input name="#abbreviation#" id="#abbreviation#" type="checkbox" <cfif Evaluate(Variables.Abbr) EQ 1>checked="true"</cfif> />
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
				<div style="text-align:right;">
					<!--a href="javascript:EditSubmit('serviceSelect');" class="textbutton">Submit</a-->
					<input type="submit" name="submitForm" class="textbutton" value="submit" />
					<cfoutput><input type="button" value="Back" onclick="self.location.href='#returnTo#?#urltoken#$amp;bookingID=#variables.bookingID##variables.dateValue###id#variables.bookingid#'" class="textbutton" />
				</div>
								
				</cfform>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
