<cfinclude template="#RootDir#includes/companyInfoVariables.cfm">
<cfset language.createComp = "Create New Company">
<cfset language.keywords = "Esquimalt Graving Dock, EGD, Booking Request, Add New Company">
<cfset language.description = "Allows user to create a new company.">

<cfhtmlhead text="
<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Create New Company"">
<meta name=""keywords"" content="""" />
<meta name=""description"" content="""" />
<meta name=""dc.date.published"" content=""2005-07-25"" />
<meta name=""dc.date.published"" content=""2005-07-25"" />
<meta name=""dc.date.reviewed"" content=""2005-07-25"" />
<meta name=""dc.date.modified"" content=""2005-07-25"" />
<meta name=""dc.date.created"" content=""2005-07-25"" />
<title>PWGSC - ESQUIMALT GRAVING DOCK - Create New Company</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">
<CFINCLUDE template="#RootDir#includes/checkFilledIn_js.cfm">

<div class="breadcrumbs">
	<a href="<cfoutput>http://www.pwgsc.gc.ca/home-#lang#.html</cfoutput>">PWGSC</a> &gt;
	Pacific Region &gt;
	<a href="http://www.pwgsc.gc.ca/pacific/egd/index-e.html">Esquimalt Graving Dock</a> &gt;
  <cfoutput>
		<a href="#RootDir#reserve-book-#lang#.cfm">Booking</a> &gt;<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
			<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt;
		<CFELSE>
			 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
		</CFIF>
	<a href="#RootDir#admin/Users/addNewUserCompany.cfm?lang=#lang#&info=#url.info#&companies=#url.companies#">Create New User</a> &gt;
	</cfoutput>
	Create New Company
</div>

<div class="main">
<h1>Create New Company</h1>

<cfparam name="Variables.name" default="">
<cfparam name="Variables.abbrev" default="">
<cfparam name="Variables.address1" default="">
<cfparam name="Variables.address2" default="">
<cfparam name="Variables.city" default="">
<cfparam name="Variables.province" default="">
<cfparam name="Variables.country" default="">
<cfparam name="Variables.zip" default="">
<cfparam name="Variables.phone" default="">
<cfparam name="Variables.fax" default="">

<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
<cfinclude template="#RootDir#includes/getStructure.cfm">

<cfoutput>
<cfform action="addCompany_action.cfm?lang=#lang#&info=#url.info#&companies=#url.companies#" id="addCompanyForm" method="post" onsubmit="if(!checkFilledIn('addCompanyForm')) { return false;
	}">
	<table>
		<tr>
			<td id="companyName"><label for="name">Name:</label></td>
			<td headers="companyName"><cfinput name="name" value="#variables.name#" id="name" type="text" size="40" maxlength="75" required="yes" message="#language.nameError#" /></td>
		</tr>
		<tr>
			<td id="abbr_Header"><label for="abbrev">Abbreviation:</label></td>
			<td headers="abbr_Header"><cfinput name="abbrev" id="abbrev" type="text" size="10" maxlength="3" value="#variables.abbrev#" required="yes" message="#language.abbrevError#" /></td>
		</tr>
		<tr>
			<td id="address1_header"><label for="address1">Address 1:</label></td>
			<td headers="address1_header"><cfinput name="address1" value="#variables.address1#" id="address1" type="text" size="40" maxlength="75" required="yes" message="#language.addressError#" /></td>
		</tr>
		<tr>
			<td id="address2_header"><label for="address2">Address 2 (optional):</label></td>
			<td headers="address2_header"><cfinput name="address2" value="#variables.address2#" id="address2" type="text" size="40" maxlength="75" /></td>
		</tr>
		<tr>
			<td id="city_header"><label for="city">City:</label></td>
			<td headers="city_header"><cfinput name="city" value="#variables.city#" id="city" type="text" size="25" maxlength="40" required="yes" message="#language.cityError#" /></td>
		</tr>
		<tr>
			<td id="province_header"><label for="province">Province:</label></td>
			<td headers="province_header"><cfinput name="province" value="#variables.province#" id="province" type="text" size="25" maxlength="40" required="no" message="#language.provinceError#" /></td>
		</tr>
		<tr>
			<td id="country_header"><label for="country">Country:</label></td>
			<td headers="country_header"><cfinput name="country" value="#variables.country#" id="country" type="text" size="25" maxlength="40" required="yes" message="#language.countryError#" /></td>
		</tr>
		<tr>
			<td id="zip_header"><label for="zip">Postal / Zip Code:</label></td>
			<td headers="zip_header"><cfinput name="zip" value="#variables.zip#" id="zip" type="text" size="12" maxlength="10" required="no" message="#language.zipError#" /></td>
		</tr>
		<tr>
			<td id="phone_header"><label for="phone">Phone:</label></td>
			<td headers="phone_header"><cfinput name="phone" value="#variables.phone#" id="phone" type="text" size="25" maxlength="32" required="yes" message="#language.phoneError#" /></td>
		</tr>
		<tr>
			<td id="fax_header"><label for="fax">Fax (optional):</label></td>
			<td headers="fax_header"><cfinput name="fax" value="#variables.fax#" id="fax" type="text" size="25" maxlength="32" /></td>
		</tr>
		<tr>
			<td colspan="2" align="center" style="padding-top:20px;">
				<input type="submit" name="submitForm" value="submit" class="textbutton" />
				<a href="addNewUserCompany.cfm?lang=#lang#&info=#url.info#&companies=#url.companies#" class="textbutton">Cancel</a>
			</td>
		</tr>
	</table>
</cfform>
</cfoutput>

</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
