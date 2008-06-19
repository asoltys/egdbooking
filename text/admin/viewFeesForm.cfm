<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - View Tariff Form of Dock Charges"">
<meta name=""keywords"" lang=""eng"" content=""View Tariff Form of Dock Charges"">
<meta name=""description"" lang=""eng"" content=""Allows user to view information on services requested for a booking and the fees associated with them."">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - View Tariff Form of Dock Charges</title>">

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">


<cfquery name="getFees" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	item, serviceE AS service, fee, abbreviation, flex
	FROM	TariffFees
	ORDER BY sequence
</cfquery>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-eng.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm"> &gt; <CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
			<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
		<CFELSE>
			 <a href="#RootDir#text/booking/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
		</CFIF>
		View Tariff Form of Dock Charges</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-eng.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
						<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
						View Tariff Form of Dock Charges
						<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
						</a></h1>

			<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
			
			<cfinclude template="#RootDir#includes/getStructure.cfm">
			
			<br><br>
			<cfoutput>
			<table border="0" cellpadding="3" cellspacing="0" summary="This table displays the selected services for the booking.">
				<tr>
					<th id="checkHeader" class="feesformheader" width="5%">&nbsp;</th>
					<th id="itemHeader" class="feesformheader" width="4%"><strong>Item</strong></th>
					<th id="serviceHeader" class="feesformheader"><strong>Services and Facilities</strong></th>
					<th id="feeHeader" class="feesformheader" width="19%"><strong>Fees</strong></th>
				</tr>
				
				<tr>
					<td headers="checkHeader" align="right" valign="top"><input name="other" type="Checkbox" disabled></td>
					<td headers="itemHeader" align="center" valign="top">&nbsp;</td>
					<td headers="serviceHeader" align="left" valign="top">
						<table>
							<tr>
								<td valign="top">Misc:</td>
								<td><textarea name="otherText" cols="37" rows="1" disabled></textarea></td>
							</tr>
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
							<input name="#abbreviation#" id="#abbreviation#" type="Checkbox" disabled>		
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
					<td headers="feeHeader" align="right" valign="top">
						<cfif fee NEQ "">
							<label for="#abbreviation#">
								<strong>
								<cfif flex EQ 0>#LSCurrencyFormat(fee)#<cfelse>prices vary</cfif>
								</strong>
							</label>
						<cfelse>
							&nbsp;
						</cfif>
					</td>
				</tr>
			</cfoutput>
			</table>
			<br>
			<div align="right">
				<a class="textbutton" href="<cfoutput>updateFees.cfm?lang=#lang#</cfoutput>">update fees</a>
				<a href="otherForms.cfm?lang=#lang#" class="textbutton">Back</a>
			</div>
			
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
		<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
