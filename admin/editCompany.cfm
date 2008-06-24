<cfinclude template="#RootDir#includes/companyInfoVariables.cfm">

<cfif isDefined("form.companyID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">


<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Company"">
	<meta name=""keywords"" lang=""eng"" content="""">
	<meta name=""description"" lang=""eng"" content="""">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Company</title>">

<cfquery name="getCompanyList" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT CompanyID, Name
	FROM Companies
	WHERE Approved = 1 AND Deleted = 0
	ORDER BY Name
</cfquery>

<cfparam name="form.companyID" default="">

<CFIF IsDefined('url.companyID')>
	<CFSET form.companyID = url.companyID>
</CFIF>
<!---<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	
	<cfparam name="form.companyID" default="#session.companyID#">
	
	<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT *
		FROM Companies
		WHERE companyID = #form.companyID#
	</cfquery>
	
</cflock>--->

<cfparam name="variables.name" default="">
<cfparam name="variables.address1" default="">
<cfparam name="variables.address2" default="">
<cfparam name="variables.city" default="">
<cfparam name="variables.province" default="">
<cfparam name="variables.country" default="">
<cfparam name="variables.zip" default="">
<cfparam name="variables.phone" default="">
<cfparam name="variables.fax" default="">
<cfparam name="variables.abbr" default="">

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
<CFINCLUDE template="#RootDir#includes/checkFilledIn_js.cfm">

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<A href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
			<CFELSE>
				 <a href="#RootDir#reserve-book/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			Edit Company
			</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Edit Company
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>
				
				<cfif IsDefined("Session.Return_Structure")>
					<!--- Populate the Variables Structure with the Return Structure.
							Also display any errors returned --->
					<cfinclude template="#RootDir#includes/getStructure.cfm">
				</cfif>
				
				<cfform action="editCompany.cfm?lang=#lang#" method="post" name="chooseCompanyForm">
					<cfselect name="companyID" query="getCompanyList" value="companyID" display="Name" selected="#form.companyID#" />
					<!---a href="javascript:EditSubmit('chooseCompanyForm');" class="textbutton">View</a--->
					<input type="submit" value="View" class="textbutton">
					<CFOUTPUT><input type="button" value="Cancel" class="textbutton" onClick="self.location.href='menu.cfm?lang=#lang#'"></CFOUTPUT>
				</cfform>
				
				<cfif form.CompanyID NEQ "">
					<CFQUERY name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT	*
						FROM	Companies
						WHERE	Companies.CompanyID = #form.CompanyID#
							AND	Deleted = '0'
							AND	Approved = '1'
						ORDER BY	Name
					</CFQUERY>
				
					<CFIF getCompany.RecordCount eq 0>
						<CFLOCATION addtoken="no" url="editCompany.cfm">
					</CFIF>
					
					<cfif NOT isDefined("url.companyID")>
						<CFOUTPUT query="getCompany">
							<CFSET "Variables.name" = Name>
							<CFSET "Variables.address1" = Address1>
							<CFSET "Variables.address2" = Address2>
							<CFSET "Variables.city" = City>
							<CFSET "Variables.province" = Province>
							<CFSET "Variables.country" = Country>
							<CFSET "Variables.zip" = Zip>
							<CFSET "Variables.phone" = Phone>
							<CFSET "Variables.fax" = Fax>
							<CFSET "Variables.abbr" = Abbreviation>
						</CFOUTPUT>
					</cfif>
					
					<CFOUTPUT>
					<cfform action="editCompany_action.cfm?lang=#lang#" method="post" name="editCompanyForm" onSubmit="if(!checkFilledIn('editCompanyForm')) { return false; }">
					<table align="center">
						<tr>
							<td id="companyName_Header"><label for="name">Company Name:</label></td>
							<td headers="companyName_Header"><cfinput name="name" id="name" type="text" size="40" maxlength="75" required="yes" value="#Variables.name#" CLASS="textField" message="Please enter the company name."></td>
						</tr>
						<tr>
							<td id="abbrev_Header"><label for="abbr">Abbreviation:</label></td>
							<td headers="abbrev_Header"><cfinput name="abbr" id="abbr" type="text" size="5" maxlength="3" value="#Variables.abbr#" required="yes" CLASS="textField" message="Please enter the company abbreviation."></td>
						</tr>
						<tr>
							<td id="address1_Header"><label for="address1">Address 1:</label></td>
							<td headers="address1_Header"><cfinput name="address1" id="address1" type="text" size="40" maxlength="75" required="yes" value="#Variables.address1#" CLASS="textField" message="Please enter the address."></td>
						</tr>
						<tr>
							<td id="address2_Header"><label for="address2">Address 2 (optional):</label></td>
							<td headers="address2_Header"><cfinput name="address2" id="address2" type="text" size="40" maxlength="75" value="#Variables.address2#" CLASS="textField"></td>
						</tr>
						<tr>
							<td id="city_Header"><label for="city">City:</label></td>
							<td headers="city_Header"><cfinput name="city" id="city" type="text" size="25" maxlength="40" required="yes" value="#Variables.city#" CLASS="textField" message="Please enter the city."></td>
						</tr>
						<tr>
							<td id="province_Header"><label for="province">Province:</label></td>
							<td headers="province_Header"><cfinput name="province" id="province" type="text" size="25" maxlength="40" required="no" value="#Variables.province#" CLASS="textField" message="Please enter the province/state."></td>
						</tr>
						<tr>
							<td id="country_Header"><label for="country">Country:</label></td>
							<td headers="country_Header"><cfinput name="country" id="country" type="text" size="25" maxlength="40" required="yes" value="#Variables.country#" CLASS="textField" message="Please enter the country."></td>
						</tr>
						<tr>
							<td id="zip_Header"><label for="zip">Postal / Zip Code:</label></td>
							<td headers="zip_Header"><cfinput name="zip" id="zip" type="text" size="12" maxlength="10" required="no" value="#Variables.zip#" CLASS="textField" message="Please enter the postal code or zip code."></td>
						</tr>
						<tr>
							<td id="phone_Header"><label for="phone">Phone:</label></td>
							<td headers="phone_Header"><cfinput name="phone" id="phone" type="text" size="25" maxlength="32" required="yes" value="#Variables.phone#" CLASS="textField" message="Please check that the phone number is valid."></td>
						</tr>
						<tr>
							<td id="fax_Header"><label for="fax">Fax (optional):</label></td>
							<td headers="fax_Header"><cfinput name="fax" id="fax" type="text" size="25" maxlength="32" value="#variables.fax#" CLASS="textField"></td>
						</tr>
						<tr>
							<td id="" colspan="2" align="center" style="padding-top:20px;">
								<INPUT type="hidden" name="companyID" value="#form.companyID#">
								<input type="Submit" class="textbutton" value="Submit">
								<input type="button" value="Cancel" onClick="self.location.href='#RootDir#admin/menu.cfm?lang=#lang#'" class="textbutton">
							</td>
						</tr>
					</table>
				
					</cfform>
					</CFOUTPUT>
				</CFIF>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
