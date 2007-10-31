<CFINCLUDE template="#RootDir#includes/companyInfoVariables.cfm">

<!doctype HTML public "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html lang="en">

<head>
<!--- 	<meta name="dc.title" lang="eng" content="PWGSC - ESQUIMALT GRAVING DOCK - Welcome">
	<meta name="keywords" lang="eng" content="Ship Repair, Boats, Ship Maintenance, Dry dock, drydock, marine, iso14001, iso-14001">
	<meta name="description" lang="eng" content="The Esquimalt Graving Dock, or EGD, is proud to be federally owned, operated, and maintained. EGD is the largest solid-bottom commercial drydock on the West Coast of the Americas. We are located in an ice free harbour on Vancouver Island near gateways to Alaska and the Pacific Rim.">
	<meta name="dc.subject" scheme="gccore" lang="eng" content="Ship; Wharf; Dock; Boat">
	<meta name="dc.date.created" lang="eng" content="2002-11-29">
	<meta name="dc.date.modified" content="<!--#config timefmt='%Y-%m-%d'--><!--#echo var='LAST_MODIFIED'-->">
	<meta name="dc.date.published" content="2002-12-30">
	<meta name="dc.date.reviewed" content="2004-07-27">
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Booking</title> --->
	<!--INTERNET TEMPLATE VERSION 2.1-->
	
	<!--METADATA PROFILE START-->
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<meta name="MSSmartTagsPreventParsing" content="True">
	<link rel="schema.dc" href="http://purl.org/dc/elements/1.1">
	<meta name="dc.language" scheme="IS0639-2" content="eng">
	<meta name="dc.creator" lang="eng" content="Government of Canada, Public Works and Government Services Canada, Esquimalt Graving Dock">
	<meta name="dc.publisher" lang="eng" content="Public Works and Government Services Canada">
	<meta name="pwgsc.contact.email" content="egd@pwgsc.gc.ca">
	<meta name="dc.rights" lang="eng" content="<cfoutput>http://www.pwgsc.gc.ca/text/home-#lang#.html</cfoutput>/text/generic/copyright-e.html">
	<meta name="robots" content="noindex,nofollow">

	<meta name="dc.title" lang="eng" content="PWGSC - ESQUIMALT GRAVING DOCK - View Company Details">
	<meta name="keywords" lang="eng" content="">
	<meta name="description" lang="eng" content="Allows user to view information on a company.">
	<meta name="dc.subject" scheme="gccore" lang="eng" content="">
	<meta name="dc.date.published" content="2005-07-25">
	<meta name="dc.date.reviewed" content="2005-07-25">
	<meta name="dc.date.modified" content="2005-07-25">
	<meta name="dc.date.created" content="2005-07-25">

	<meta name="pwgsc.date.retention" content="">
	<!-- leave blank -->
	<meta name="dc.contributor" lang="eng" content="">
	<meta name="dc.identifier" lang="eng" content="">
	<meta name="dc.audience" lang="eng" content="">
	<meta name="dc.type" lang="eng" content="">
	<meta name="dc.format" lang="eng" content="">
	<meta name="dc.coverage" lang="eng" content="">
	<!--METADATA PROFILE END-->

	<title>PWGSC - ESQUIMALT GRAVING DOCK - View Company Details</title>

<!--cfinclude template="#RootDir#includes/header-#lang#.cfm"-->

<cfoutput>
	<LINK rel="stylesheet" href="#RootDir#css/default.css">
	<style type="text/css" media="screen, print">
		@import url(#RootDir#css/advanced.css);
		@import url(#RootDir#css/events.css);
	</style>
</cfoutput>

<cfset language.PageTitle = "View Company">
<cfset language.ScreenMessage = ''>

<CFIF IsDefined('url.companyID')>
	<!---CFSET Variables.companyID = url.companyID--->
	<CFQUERY name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	*
		FROM	Companies
		WHERE	Companies.CompanyID = '#url.CompanyID#'
			AND	Deleted = '0'
		ORDER BY	Name
	</CFQUERY>
	
	<CFQUERY name="getAgents" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	FirstName, LastName
		FROM	Users	INNER JOIN	UserCompanies ON Users.UserID = UserCompanies.UserID
		WHERE	UserCompanies.CompanyID = '#url.companyID#'
			AND Users.Deleted = '0'
			AND UserCompanies.Approved = '1'
			AND	UserCompanies.Deleted = '0'
		ORDER BY	LastName, FirstName
	</CFQUERY>
	
<CFELSE>
	<CFSET ScreenMessage = "There is no such company.">
</CFIF>


</HEAD>

<BODY bgcolor="#FFFFFF">

<!--begin clf fip-e.html--> 
<table width="480" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="4"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="1" height="10" alt=""></td>
	</tr>
	<tr> 
		<td><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="10" height="1" alt=""></td>
		<td align="left" valign="top"><img src="<cfoutput>#RootDir#</cfoutput>images/pwgsc-e.gif" width="364" height="33" alt="Public Works and Government Services Canada" title="Public Works and Government Services Canada" border="0"></td>
		<td align="right" valign="top"><img src="<cfoutput>#RootDir#</cfoutput>images/wordmark.gif" width="83" height="21" alt="Canada wordmark" border="0" align="top"></td>
		<td><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="10" height="1" alt=""></td>
	</tr>
</table>
<!--end clf fip-e.html-->

<h2 style="padding-left: 10px; "><CFOUTPUT>#getCompany.Name# <CFIF IsDefined('getCompany.Approved') AND getCompany.Approved neq '' AND getCompany.Approved>(#getCompany.Abbreviation#)</CFIF></CFOUTPUT></h2>
<TABLE width="80%" class="calendar" align="center" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<CFOUTPUT><TD id="addy1" class="calendar" width="30%" valign="top">#language.address#:</TD>
		<TD headers="addy1" class="calendar">
			#getCompany.Address1#<CFIF getCompany.Address2 neq ""><BR>
			#getCompany.Address2#</CFIF><BR>
			#getCompany.City#<BR>
			#getCompany.Country#<BR>
			#getCompany.zip#
		</TD></CFOUTPUT>
	</TR>
	</TR>
	<TR>
		<CFOUTPUT><TD id="phone" class="calendar" valign="top">#language.phone#:</TD>
		<TD headers="phone" class="calendar">#getCompany.phone#</TD></CFOUTPUT>
	</TR>
	<TR>
		<CFOUTPUT><TD id="status" class="calendar" valign="top">#language.status#:</TD>
		<TD headers="status" class="calendar"><CFIF IsDefined('getCompany.Approved') AND getCompany.Approved neq '' AND getCompany.approved>Approved<CFELSE>Awaiting Approval</CFIF></TD></CFOUTPUT>
	</TR>
	<CFIF IsDefined('getCompany.Approved') AND getCompany.Approved neq '' AND getCompany.approved>
	<TR>
		<TD id="Agents" class="calendar" valign="top">Other Approved Agents:</TD>
		<TD headers="Agents" class="calendar"><CFOUTPUT query="getAgents">#FirstName# #LastName#<BR></CFOUTPUT><CFIF getAgents.recordCount eq 0>None</CFIF></TD>
	</TR>
	</CFIF>
</TABLE>
<BR>
<div align="center"><A href="javascript: self.close();" class="textbutton">close</A></div>

<BR>
<!--BEGIN FOOTER-->
<table width="480" border="0" cellspacing="0" cellpadding="0">
<TR>
	<TD width="10"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="10" height="1" alt=""></TD>
	<TD colspan="2" width="460"><hr noshade size="1" width="100%"></TD>
	<TD width="10"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="10" height="1" alt=""></TD>	
</TR>
<tr>
	<td>&nbsp;</td>
	<td align="left" class="footertext" colspan="2">
		Maintained by <a href="<cfoutput>#RootDir#</cfoutput>text/contact_us-e.cfm">PWGSC</a></div> <!--- This option is recommended. --->
	</td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td align="left" class="footertext">
		<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,"\")>
		<cfset PageDir = listDeleteAt(cgi.CF_TEMPLATE_PATH, listLen(cgi.CF_TEMPLATE_PATH,"\"), "\")>
		<cfdirectory action="LIST" directory="#PageDir#" name="GetFile" filter="#PageFileName#">
		<cfif #GetFile.recordcount# is 1>Last Updated:
		<cfoutput query="GetFile">
			#LSDateFormat(parseDateTime(GetFile.DateLastModified,"mm-dd-yyyy"), "yyyy-mm-dd")# 
			<!---#TimeFormat(parseDateTime(GetFile.DateLastModified, "h:mm tt"))#--->
		</cfoutput>
		</cfif>
	</td>
	<td align="right" class="footertext">
		<cfoutput>
		<span lang="en"><a href="http://www.pwgsc.gc.ca/text/generic/copyright-e.html">Important Notices</a></span>
		</cfoutput>
	</td>
	<td><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="10" height="1" alt=""></td>
</tr>

<tr>
	<td colspan="4"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="1" height="10" alt=""></td>
</tr>
</table>
<!--END FOOTER-->

</BODY>
</HTML>