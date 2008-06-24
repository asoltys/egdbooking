<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Create New Company"">
<meta name=""keywords"" lang=""eng"" content="""">
<meta name=""description"" lang=""eng"" content="""">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Create New Company</title>">

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFIF NOT IsDefined('url.userID')>
	<cflocation addtoken="no" url="#RootDir#admin/menu.cfm?lang=#lang#">
</CFIF>

<div class="breadcrumbs">
	<a href="<cfoutput>http://www.pwgsc.gc.ca/home-#lang#.html</cfoutput>">PWGSC</a> &gt; 
	Pacific Region &gt; 
	<a href="http://www.pwgsc.gc.ca/pacific/egd/index-e.html">Esquimalt Graving Dock</a> &gt; 
  <CFOUTPUT>
		<a href="#RootDir#reserve-book-#lang#.cfm">Booking</A> &gt;<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
			<A href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
		<CFELSE>
			 <a href="#RootDir#reserve-book/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
		</CFIF>
	<a href="#RootDir#admin/Users/editUser.cfm?lang=#lang#&userID=#url.userID#">Edit User Profile</A> &gt; 
	</CFOUTPUT>
	Create New Company
</div>

<div class="main">
<H1>Create New Company</H1>

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

<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>
<cfinclude template="#RootDir#includes/getStructure.cfm">
<cfset Variables.onLoad = "javascript:document.addCompanyForm.name.focus();">

<CFOUTPUT>
<cfform action="editUser_addCompany_action.cfm?lang=#lang#&userID=#url.userID#" name="addCompanyForm" method="post">
	<table align="center">
		<tr>
			<td id="companyName"><label for="name">Company Name:</label></td>
			<td headers="companyName"><cfinput name="name" value="#variables.name#" id="name" type="text" size="40" maxlength="75" required="yes" CLASS="textField" message="Please enter the company name."></td>
		</tr>
		<tr>
			<td id="abbr_Header"><label for="abbrev">Abbreviation:</label></td>
			<td headers="abbr_Header"><cfinput name="abbrev" id="abbrev" type="text" size="5" maxlength="3" value="#variables.abbrev#" required="yes" CLASS="textField" message="Please enter the company abbreviation."></td>
		</tr>
		<tr>
			<td id="address1_header"><label for="address1">Address 1:</label></td>
			<td headers="address1_header"><cfinput name="address1" value="#variables.address1#" id="address1" type="text" size="40" maxlength="75" required="yes" CLASS="textField" message="Please enter the address."></td>
		</tr>
		<tr>
			<td id="address2_header"><label for="address2">Address 2 (optional):</label></td>
			<td headers="address2_header"><cfinput name="address2" value="#variables.address2#" id="address2" type="text" size="40" maxlength="75" CLASS="textField"></td>
		</tr>
		<tr>
			<td id="city_header"><label for="city">City:</label></td>
			<td headers="city_header"><cfinput name="city" value="#variables.city#" id="city" type="text" size="25" maxlength="40" required="yes" CLASS="textField" message="Please enter the city."></td>
		</tr>
		<tr>
			<td id="province_header"><label for="province">Province / State:</label></td>
			<td headers="province_header"><cfinput name="province" value="#variables.province#" id="province" type="text" size="25" maxlength="40" required="no" CLASS="textField" message="Please enter the province."></td>
		</tr>
		<tr>
			<td id="country_header"><label for="country">Country:</label></td>
			<td headers="country_header"><cfinput name="country" value="#variables.country#" id="country" type="text" size="25" maxlength="40" required="yes" CLASS="textField" message="Please enter the country."></td>
		</tr>
		<tr>
			<td id="zip_header"><label for="zip">Postal / Zip Code:</label></td>
			<td headers="zip_header"><cfinput name="zip" value="#variables.zip#" id="zip" type="text" size="12" maxlength="10" required="no" CLASS="textField" message="Please enter the postal code or zip code."></td>
		</tr>
		<tr>
			<td id="Phone_header"><label for="phone">Phone:</label></td>
			<td headers="Phone_header"><cfinput name="phone" value="#variables.phone#" id="phone" type="text" size="25" maxlength="32" required="yes" CLASS="textField" message="Please check that the phone number is valid."></td>
		</tr>
		<tr>
			<td id="fax_header"><label for="fax">Fax (optional):</label></td>
			<td headers="fax_header"><cfinput name="fax" value="#variables.fax#" id="fax" type="text" size="25" maxlength="32" CLASS="textField"></td>
		</tr>
		<tr>
			<td colspan="2" align="center" style="padding-top:20px;">
				<input type="submit" class="textbutton" value="Submit">
				<input type="button" value="Cancel" onClick="self.location.href='editUser.cfm?lang=#lang#&userID=#url.userID#'" class="textbutton">
			</td>
		</tr>
	</table>
</cfform>
</CFOUTPUT>

</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">