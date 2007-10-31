<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Delete Vessel"">
<meta name=""keywords"" lang=""eng"" content="""">
<meta name=""description"" lang=""eng"" content="""">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Delete Vessel</title>">

<cfinclude template="#RootDir#includes/header-#lang#.cfm">


<cfquery name="getVessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT vesselID, vessels.Name AS VesselName
	FROM Vessels
	WHERE Vessels.Deleted = 0
	ORDER BY Vessels.Name
</cfquery>

<cfquery name="companyVessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT vesselID, vessels.Name AS VesselName, companies.companyID, companies.Name AS CompanyName
	FROM Vessels INNER JOIN Companies ON Vessels.CompanyID = Companies.CompanyID
	WHERE Vessels.Deleted = 0 AND Companies.Deleted = 0 AND Companies.Approved = 1
	ORDER BY Companies.Name, Vessels.Name
</cfquery>


<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfif isDefined("form.companyID")>
	<cfset variables.companyID = #form.companyID#>
<cfelse>
	<cfset variables.companyID = 0>
</cfif>
<cfif isDefined("form.vesselID")>
	<cfset variables.vesselID = #form.vesselID#>
<cfelse>
	<cfset variables.vesselID = 0>
</cfif>


<div class="breadcrumbs">
	<a href="<cfoutput>http://www.pwgsc.gc.ca/text/home-#lang#.html</cfoutput>">PWGSC</a> &gt; 
	Pacific Region &gt; 
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-e.html">Esquimalt Graving Dock</a> &gt; 
	<CFOUTPUT>
		<a href="#RootDir#text/booking-#lang#.cfm">Booking</A> &gt;<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
			<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
		<CFELSE>
			 <a href="#RootDir#text/booking/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
		</CFIF>
	</CFOUTPUT>
	Delete Vessel
</div>

<div class="main">
<H1>Delete Vessel</H1>
<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>

<cfif IsDefined("Session.Return_Structure")>
	<!--- Populate the Variables Structure with the Return Structure.
			Also display any errors returned --->
	<cfinclude template="#RootDir#includes/getStructure.cfm">
</cfif>

<cfform action="delVessel_confirm.cfm?lang=#lang#" method="post" name="delVesselForm">
<table width="100%">
	<tr>
		<td>Company:</td>
		<td>
			<CF_TwoSelectsRelated 
				QUERY="companyVessels" 
				NAME1="CompanyID" 
				NAME2="VesselID" 
				DISPLAY1="CompanyName" 
				DISPLAY2="VesselName" 
				VALUE1="companyID" 
				VALUE2="vesselID" 
				SIZE1="1" 
				SIZE2="1" 
				HTMLBETWEEN="</td></tr><tr><td>Vessel:</td><td>" 
				AUTOSELECTFIRST="Yes" 
				EMPTYTEXT1="(choose a company)" 
				EMPTYTEXT2="(choose a vessel)" 
				DEFAULT1 ="#variables.companyID#"
				DEFAULT2 ="#variables.vesselID#"
				FORMNAME="delVesselForm">
		</td>
	</tr>
		<!---<cfselect name="vesselID" query="getVessels" value="vesselID" display="Name" />--->
	<tr><td>&nbsp;</td></tr>
	<tr><td colspan="2" align="center">
		<input type="submit" name="submitForm" class="textbutton" value="Delete">
		<CFOUTPUT><input type="button" value="Cancel" onClick="self.location.href='#RootDir#text/admin/menu.cfm?lang=#lang#';" class="textbutton"></CFOUTPUT></td>
	</tr>
</table>
</cfform>


</div>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">