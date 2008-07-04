<cfinclude template="#RootDir#includes/companyInfoVariables.cfm">

<cfif lang EQ "eng">
	<cfset language.createComp = "Create New Company">
	<cfset language.keywords = language.masterKeywords & ", Add New Company">
	<cfset language.description = "Allows user to create a new account for a company.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.editProfile = "Edit Profile">

<cfelse>
	<cfset language.createComp = "cr&eacute;er une nouvelle entreprise">
	<cfset language.keywords = language.masterKeywords & ", Ajout d'une nouvelle entreprise">
	<cfset language.description = "Permet &agrave; l'utilisateur de cr&eacute;er un nouveau compte pour une entreprise.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.editProfile = "Modifier le profil">

</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.CreateComp#"">
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<meta name=""dc.date.published"" content=""2005-07-25"" />
	<meta name=""dc.date.reviewed"" content=""2005-07-25"" />
	<meta name=""dc.date.modified"" content=""2005-07-25"" />
	<meta name=""dc.date.created"" content=""2005-07-25"" />
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.CreateComp#</title>">

<cfinclude template="#RootDir#includes/checkFilledIn_js.cfm">

<cfparam name="variables.name" default="">
<cfparam name="variables.address1" default="">
<cfparam name="variables.address2" default="">
<cfparam name="variables.city" default="">
<cfparam name="variables.province" default="">
<cfparam name="variables.country" default="">
<cfparam name="variables.zip" default="">
<cfparam name="variables.phone" default="">
<cfparam name="variables.fax" default="">

<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfif isDefined("session.form_structure")>
	<cfset variables.name="#form.name#">
	<cfset variables.address1="#form.address1#">
	<cfset variables.address2="#form.address2#">
	<cfset variables.city="#form.city#">
	<cfset variables.province="#form.province#">
	<cfset variables.country="#form.country#">
	<cfset variables.zip="#form.zip#">
	<cfset variables.phone="#form.phone#">
	<cfset variables.fax="#form.fax#">
</cfif>

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			<CFELSE>
				<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			</CFIF>
			<a href="#RootDir#reserve-book/profilmod-profileedit.cfm?lang=#lang#">#language.editProfile#</a> &gt;
			#language.CreateComp#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.CreateComp#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
					<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				<CFELSE>
					<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
				</CFIF>
			
				<cfinclude template="#RootDir#includes/getStructure.cfm">

				<cfoutput>
				<cfform action="#RootDir#reserve-book/entrpajout-compadd_action.cfm?lang=#lang#" name="addCompanyForm" method="post" onSubmit="if(!checkFilledIn('addCompanyForm')) { return false;
	}">
					<table align="center">
						<tr>
							<td id="companyName_header"><label for="name">#language.companyName#:</label></td>
							<td headers="companyName_header"><cfinput id="name" name="name" value="#variables.name#" type="text" size="40" maxlength="75" required="yes" CLASS="textField" message="#language.nameError#"></td>
						</tr>
						<tr>
							<td id="Address1_header"><label for="address1">#language.Address# 1:</label></td>
							<td headers="Address1_header"><cfinput id="address1" name="address1" value="#variables.address1#" type="text" size="40" maxlength="75" required="yes" CLASS="textField" message="#language.addressError#"></td>
						</tr>
						<tr>
							<td id="Address2_header"><label for="address2">#language.Address# 2 #language.optional#:</label></td>
							<td headers="Address2_header"><cfinput id="address2" name="address2" value="#variables.address2#" type="text" size="40" maxlength="75" CLASS="textField"></td>
						</tr>
						<tr>
							<td id="City_header"><label for="city">#language.City#:</label></td>
							<td headers="City_header"><cfinput id="city" name="city" type="text" value="#variables.city#" size="25" maxlength="40" required="yes" CLASS="textField" message="#language.cityError#"></td>
						</tr>
						<tr>
							<td id="Province_header"><label for="province">#language.Province#:</label></td>
							<td headers="Province_header"><cfinput id="province" name="province" value="#variables.province#" type="text" size="25" maxlength="40" required="no" CLASS="textField" message="#language.provinceError#"></td>
						</tr>
						<tr>
							<td id="Country_header"><label for="country">#language.Country#:</label></td>
							<td headers="Country_header"><cfinput id="country" name="country" value="#variables.country#" type="text" size="25" maxlength="40" required="yes" CLASS="textField" message="#language.countryError#"></td>
						</tr>
						<tr>
							<td id="zip_header"><label for="zip">#language.zip#:</label></td>
							<td headers="zip_header"><cfinput id="zip" name="zip" value="#variables.zip#" type="text" size="10" maxlength="10" required="no" CLASS="textField" message="#language.zipError#"></td>
						</tr>
						<tr>
							<td id="Phone_header"><label for="phone">#language.Phone#:</label></td>
							<td headers="Phone_header"><cfinput id="phone" name="phone" value="#variables.phone#" type="text" size="10" maxlength="32" required="yes" CLASS="textField" message="#language.phoneError#"></td>
						</tr>
						<tr>
							<td id="fax_header"><label for="fax">#language.Fax# #language.optional#:</label></td>
							<td headers="fax_header"><cfinput id="fax" name="fax" value="#variables.fax#" type="text" size="10" maxlength="32" CLASS="textField"></td>
						</tr>
						<tr>
							<td colspan="2" align="center" style="padding-top:20px;">
								<input type="Submit" name="submitForm" class="textbutton" value="#language.Submit#">
								<input type="button" value="#language.Cancel#" onClick="self.location.href='editUser.cfm?lang=#lang#'" class="textbutton">
							</td>
						</tr>
					</table>
				</cfform>
				</cfoutput>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
