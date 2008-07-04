<cfinclude template="#RootDir#includes/companyInfoVariables.cfm">
<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Create New Company"" />
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Create New Company</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">
<cfinclude template="#RootDir#includes/checkFilledIn_js.cfm">

<cfparam name="variables.name" default="">
<cfparam name="Variables.abbrev" default="">
<cfparam name="variables.address1" default="">
<cfparam name="variables.address2" default="">
<cfparam name="variables.city" default="">
<cfparam name="variables.province" default="">
<cfparam name="variables.country" default="">
<cfparam name="variables.zip" default="">
<cfparam name="variables.phone" default="">
<cfparam name="variables.fax" default="">


<cfif NOT IsDefined("Session.form_Structure") OR NOT IsDefined("form.name")>
	<cfinclude template="#RootDir#includes/build_form_struct.cfm">
	<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfelse>
	<cfinclude template="#RootDir#includes/restore_params.cfm">
		<cfif isDefined("form.companyID")>
		<cfset variables.name="#form.name#">
		<cfset Variables.abbrev="#form.abbrev#">
		<cfset variables.address1="#form.address1#">
		<cfset variables.address2="#form.address2#">
		<cfset variables.city="#form.city#">
		<cfset variables.province="#form.province#">
		<cfset variables.country="#form.country#">
		<cfset variables.zip="#form.zip#">
		<cfset variables.phone="#form.phone#">
		<cfset variables.fax="#form.fax#">
	</cfif>
</cfif>

<!--- <cfinclude template="#RootDir#includes/restore_params.cfm">
<cfif isDefined("session.form_structure")>
	<cfset variables.name="#form.name#">
	<cfset Variables.abbrev="#form.abbrev#">
	<cfset variables.address1="#form.address1#">
	<cfset variables.address2="#form.address2#">
	<cfset variables.city="#form.city#">
	<cfset variables.province="#form.province#">
	<cfset variables.country="#form.country#">
	<cfset variables.zip="#form.zip#">
	<cfset variables.phone="#form.phone#">
	<cfset variables.fax="#form.fax#">
</cfif> --->

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt; 
			<CFELSE>
				<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			Create New Company
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Create New Company
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				
				<cfif IsDefined("Session.Return_Structure")>
					<!--- Populate the Variables Structure with the Return Structure.
							Also display any errors returned --->
					<cfinclude template="#RootDir#includes/getStructure.cfm">
				</cfif>
				
				<cfoutput>
				<cfform action="addCompany_action.cfm?lang=#lang#" name="addCompanyForm" id="addCompanyForm" method="post" onsubmit="if(!checkFilledIn('addCompanyForm')) { return false;
	}">
					<table align="center">
						<tr>
							<td id="name_Header"><label for="name">Company Name:</label></td>
							<td headers="name_Header"><cfinput name="name" id="name" type="text" size="40" maxlength="75" value="#variables.name#" required="yes" CLASS="textField" message="Please enter the company name." /></td>
						</tr>
						<tr>
							<td id="abbr_Header"><label for="abbrev">Abbreviation:</label></td>
							<td headers="abbr_Header"><cfinput name="abbrev" id="abbrev" type="text" size="5" maxlength="3" value="#variables.abbrev#" required="yes" CLASS="textField" message="Please enter the company abbreviation." /></td>
						</tr>
						<tr>
							<td id="address1_Header"><label for="address1">Address 1:</label></td>
							<td headers="address1_Header"><cfinput name="address1" id="address1" type="text" size="40" maxlength="75" value="#variables.address1#" required="yes" CLASS="textField" message="Please enter the address." /></td>
						</tr>
						<tr>
							<td id="address2_Header"><label for="address2">Address 2 (optional):</label></td>
							<td headers="address2_Header"><cfinput name="address2" id="address2" type="text" size="40" maxlength="75" value="#variables.address2#" CLASS="textField" /></td>
						</tr>
						<tr>
							<td id="city_Header"><label for="city">City:</label></td>
							<td headers="city_Header"><cfinput name="city" id="city" type="text" size="25" maxlength="40" value="#variables.city#" required="yes" CLASS="textField" message="Please enter the city." /></td>
						</tr>
						<tr>
							<td id="province_Header"><label for="province">Province / State:</label></td>
							<td headers="province_Header"><cfinput name="province" id="province" type="text" size="25" maxlength="40" value="#variables.province#" required="no" CLASS="textField" message="Please enter the province or state." /></td>
						</tr>
						<tr>
							<td id="country_Header"><label for="country">Country:</label></td>
							<td headers="country_Header"><cfinput name="country" id="country" type="text" size="25" maxlength="40" value="#variables.country#" required="yes" CLASS="textField" message="Please enter the country." /></td>
						</tr>
						<tr>
							<td id="zip_Header"><label for="zip">Postal / Zip Code:</label></td>
							<td headers="zip_Header"><cfinput name="zip" id="zip" type="text" size="12" maxlength="10" value="#variables.zip#" required="no" CLASS="textField" message="Please enter the postal code or zip code." /></td>
						</tr>
						<tr>
							<td id="phone_Header"><label for="phone">Phone:</label></td>
							<td headers="phone_Header"><cfinput name="phone" id="phone" type="text" size="25" maxlength="32" value="#variables.phone#" required="yes" CLASS="textField" message="Please check that the phone number is valid." /></td>
						</tr>
						<tr>
							<td id="fax_Header"><label for="fax">Fax (optional):</label></td>
							<td headers="fax_Header"><cfinput name="fax" id="fax" type="text" size="25" maxlength="32" value="#variables.fax#" CLASS="textField" /></td>
						</tr>
						<tr>
							<td colspan="2" align="center" style="padding-top:20px;">
								<input type="submit" name="submitForm" class="textbutton" value="submit" />
								<input type="button" value="Cancel" class="textbutton" onClick="self.location.href='menu.cfm?lang=#lang#'" />
							</td>
						</tr>
					</table>
				</cfform>
				</cfoutput>

			</div>
			
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
