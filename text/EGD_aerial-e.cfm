<!doctype HTML public "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html lang="en">

<head>
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

	<meta name="dc.title" lang="eng" content="PWGSC - ESQUIMALT GRAVING DOCK - Aerial View">
	<meta name="keywords" lang="eng" content="#Language.masterKeywords#">
	<meta name="description" lang="eng" content="#language.description#">
	<meta name="dc.subject" scheme="gccore" lang="eng" content="#Language.masterSubjects#">
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
	
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Aerial View</title>
	<cfoutput>
		<LINK type="text/css" rel="stylesheet" href="#RootDir#css/default.css">
		<style type="text/css" media="screen,print">
			@import url(#RootDir#css/advanced.css);
			@import url(#RootDir#css/events.css);
		</style>
	</cfoutput>


</head>
<body bgcolor="#FFFFFF">

<!--begin clf fip-e.html--> 
<table width="620" border="0" cellpadding="0" cellspacing="0">
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

<div class="main" style="width: 620px; ">

<H1 style="padding-left: 10px; ">Aerial view of the Esquimalt Graving Dock</H1>

<div align="center"><IMG src="<CFOUTPUT>#RootDir#</cfoutput>images/EGD_aerial.jpg" width="587" height="461" border="0"><BR><BR>
<A href="javascript:window.close()" class="textbutton">close this window</A></div>

</div>

<!--BEGIN FOOTER-->
<table width="620" border="0" cellspacing="0" cellpadding="0">
<TR>
	<TD width="10"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="10" height="1" alt=""></TD>
	<TD colspan="2" width="630"><hr noshade size="1" width="100%"></TD>
	<TD width="10"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="10" height="1" alt=""></TD>	
</TR>
<tr>
	<td><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="10" height="1" alt=""></td>
	<td align="left" class="footertext"> 
		<div>Maintained by <a href="<cfoutput>#RootDir#</cfoutput>text/contact_us-e.cfm">PWGSC</a></div> <!--- This option is recommended. --->
		<div>
			<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,"\")>
			<cfset PageDir = listDeleteAt(cgi.CF_TEMPLATE_PATH, listLen(cgi.CF_TEMPLATE_PATH,"\"), "\")>
			<cfdirectory action="LIST" directory="#PageDir#" name="GetFile" filter="#PageFileName#">
			<cfif #GetFile.recordcount# is 1>Last Updated:
			<cfoutput query="GetFile">
				#LSDateFormat(parseDateTime(GetFile.DateLastModified,"mm-dd-yyyy"), "yyyy-mm-dd")# 
				<!---#TimeFormat(parseDateTime(GetFile.DateLastModified, "h:mm tt"))#--->
			</cfoutput>
			</cfif>
		</div>
	</td>
	<td align="right" class="footertext"> 
		<div> 
			<cfoutput>
			<span lang="en"><a href="http://www.pwgsc.gc.ca/text/generic/copyright-e.html">Important Notices</a></span>
			</cfoutput>
		</div>
	</td>
	<td><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="10" height="1" alt=""></td>
</tr>
<tr>
	<td colspan="4"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="1" height="10" alt=""></td>
</tr>
</table>
<!--END FOOTER-->

</body>
</HTML>
