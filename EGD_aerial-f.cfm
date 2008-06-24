<!doctype HTML public "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html lang="en">

<head>
	<!--INTERNET TEMPLATE VERSION 2.1-->
	<!--METADATA PROFILE START-->
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<meta name="MSSmartTagsPreventParsing" content="Vrai">
	<link rel="schema.dc" href="http://purl.org/dc/elements/1.1">
	<meta name="dc.language" scheme="IS0639-2" content="fre">
	<meta name="dc.creator" lang="fre" content="Gouvernement du Canada, Travaux publics et Services gouvernementaux Canada, Cale s&egrave;che d'Esquimalt">
	<meta name="dc.publisher" lang="fre" content="Travaux publics et Services gouvernementaux Canada ">
	<meta name="pwgsc.contact.email" content="egd@pwgsc.gc.ca">
	<meta name="dc.rights" lang="fre" content="http://www.pwgsc.gc.ca/generic/copyright-f.html">
	<meta name="robots" content="noindex,nofollow">

	<meta name="dc.title" lang="fre" content="TPSGC - CALE S&Egrave;CHE D'ESQUIMALT - french">
	<meta name="keywords" lang="fre" content="#Language.masterKeywords#">
	<meta name="description" lang="fre" content="#language.description#">
	<meta name="dc.subject" scheme="gccore" lang="fre" content="#Language.masterSubjects#">
	<meta name="dc.date.published" content="2005-07-25">
	<meta name="dc.date.reviewed" content="2005-07-25">
	<meta name="dc.date.modified" content="2005-07-25">
	<meta name="dc.date.created" content="2005-07-25">
	
	<meta name="pwgsc.date.retention" content="">
	<!-- leave blank -->
	<meta name="dc.contributor" lang="fre" content="">
	<meta name="dc.identifier" lang="fre" content="">
	<meta name="dc.audience" lang="fre" content="">
	<meta name="dc.type" lang="fre" content="">
	<meta name="dc.format" lang="fre" content="">
	<meta name="dc.coverage" lang="fre" content="">
	<!--METADATA PROFILE END-->
	
	<title>TPSGC - CALE SÈCHE D'ESQUIMALT - Vue aérienne</title>
	<cfoutput>
		<LINK type="text/css" rel="stylesheet" href="#RootDir#css/default.css">
		<style type="text/css" media="screen,print">
			@import url(#RootDir#css/advanced.css);
			@import url(#RootDir#css/events.css);
		</style>
	</cfoutput>


</head>
<body bgcolor="#FFFFFF">

<!--begin clf fip-f.html--> 
<table width="620" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="4"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="1" height="10" alt=""></td>
	</tr>
	<tr> 
		<td><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="10" height="1" alt=""></td>
		<td align="left" valign="top"><img src="<cfoutput>#RootDir#</cfoutput>images/pwgsc-f.gif" width="364" height="33" alt="Travaux publics et Services gouvernementaux Canada" title="Travaux publics et Services gouvernementaux Canada" border="0"></td>
		<td align="right" valign="top"><img src="<cfoutput>#RootDir#</cfoutput>images/wordmark.gif" width="83" height="21" alt="Mot-symbole Canada" title="Mot-symbole Canada" border="0" align="top"></td>
		<td><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="10" height="1" alt=""></td>
	</tr>
</table>
<!--end clf fip-f.html-->

<div class="main" style="width: 620px; ">

<H1 style="padding-left: 10px; ">Vue aérienne de la Cale sèche d'Esquimalt</H1>

<div align="center"><IMG src="<CFOUTPUT>#RootDir#</cfoutput>images/EGD_aerial.jpg" width="587" height="461" border="0"><BR><BR>
<A href="javascript:window.close()" class="textbutton">fermer cette fenêtre</A></div>

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
		<div>Mise &agrave; jour par <a href="<cfoutput>#RootDir#</cfoutput>contact_us-f.cfm">TPSGC</a></div> <!--- This option is recommended. --->
		<div>
			<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,"\")>
			<cfset PageDir = listDeleteAt(cgi.CF_TEMPLATE_PATH, listLen(cgi.CF_TEMPLATE_PATH,"\"), "\")>
			<cfdirectory action="LIST" directory="#PageDir#" name="GetFile" filter="#PageFileName#">
			<cfif #GetFile.recordcount# is 1>Derni&egrave;re mise &agrave; jour&nbsp;:
			<cfoutput query="GetFile">
				#DateFormat(parseDateTime(GetFile.DateLastModified,"mm-dd-yyyy"), "yyyy-mm-dd")# 
				<!---#TimeFormat(parseDateTime(GetFile.DateLastModified, "h:mm tt"))#--->
			</cfoutput>
			</cfif>
		</div>
	</td>
	<td align="right" class="footertext"> 
		<div> 
			<span lang="en"><a href="http://www.pwgsc.gc.ca/generic/copyright-f.html">Avis Importants</a></span>
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
