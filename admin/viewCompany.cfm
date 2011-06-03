<CFINCLUDE template="#RootDir#includes/companyInfoVariables.cfm">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/tr/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">

<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,"\")>
<cfset PageDir = listDeleteAt(cgi.CF_TEMPLATE_PATH, listLen(cgi.CF_TEMPLATE_PATH,"\"), "\")>
<cfdirectory action="LIST" directory="#PageDir#" name="GetFile" filter="#PageFileName#">
<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,"\")>

<head>
<!-- CLF 2.0 TEMPLATE VERSION 1.04 | VERSION 1.04 DU GABARIT NSI 2.0 -->
<!-- PWGSC TEMPLATE VERSION 1.0 | VERSION 1.0 DU GABARIT TPSGC -->
<!-- HEADER BEGINS | DEBUT DE L'EN-TETE -->
<!-- title BEGINS | DEBUT DU TITRE -->
<title>PWGSC - ESQUIMALT GRAVING DOCK - View Company Details</title>
<!-- title ENDS | FIN DU TITRE -->
<!-- METADATA BEGINS | DEBUT DES METADONNEES -->
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="schema.dc" href="http://purl.org/dc/elements/1.1/" />
<link rel="schema.dc" href="http://purl.org/dc/terms/" />
<meta name="dc.title" content="PWGSC - ESQUIMALT GRAVING DOCK - View Company Details">
<meta name="dc.subject" scheme="gccore" content="ship, wharf">
<meta name="dc.language" scheme="ISO639-2/T" content="eng" />
<meta name="dc.creator" content="Government of Canada, Public Works and Government Services Canada" />
<meta name="dc.publisher" content="Government of Canada, Public Works and Government Services Canada" />
<meta name="dc.rights" content="http://www.tpsgc-pwgsc.gc.ca/comm/ai-in-eng.html" />
<meta name="dcterms.issued" scheme="W3CDTF" content="2007-09-20" />
<meta name="dcterms.modified" scheme="W3CDTF" content="<cfoutput query="GetFile">#LSDateFormat(parseDateTime(GetFile.DateLastModified,"mm-dd-yyyy"), "yyyy-mm-dd")#</cfoutput>" />
<meta name="description" content="Allows user to view information on a company.">
<meta name="keywords" content="" />
<meta name="pwgsc.contact.email" content="questions@tpsgc-pwgsc.gc.ca" />
<!-- METADATA ENDS | FIN DES METADONNEES -->
<!-- TEMPLATE SCRIPTS/CSS BEGIN | DEBUT DES SCRIPTS/CSS DU GABARIT -->
<cfoutput>
<link href="#CLF_URL#/clf20/css/base.css" media="screen, print" rel="stylesheet" type="text/css" />
<link href="#CLF_URL#/clf20/css/2col.css" media="screen, print" rel="stylesheet" type="text/css" />
<style type="text/css" media="all">@import url(#CLF_URL#/clf20/css/base2.css);</style>

<!-- TEMPLATE SCRIPTS/CSS END | FIN DES SCRIPTS/CSS DU GABARIT -->
<!-- PROGRESSIVE ENHANCEMENT BEGINS | DEBUT DE L'AMELIORATION PROGRESSIVE -->
<script src="#CLF_URL#/clf20/scripts/pe-ap.js" type="text/javascript"></script>
<script type="text/javascript">
/* <![CDATA[ */
var params = {
			lng:"eng",
			pngfix:"#CLF_URL#/clf20/images/inv.gif"
		};
		PE.progress(params);
	/* ]]> */
</script>

<!-- PROGRESSIVE ENHANCEMENT ENDS | FIN DE L'AMELIORATION PROGRESSIVE -->
<!-- CUSTOM SCRIPTS/CSS BEGIN | DEBUT DES SCRIPTS/CSS PERSONNALISES -->

<link href="#CLF_URL#/clf20/css/base-institution.css" media="screen, print" rel="stylesheet" type="text/css" />
<link href="#CLF_URL#/clf20/css/institution.css" media="screen, print" rel="stylesheet" type="text/css" />
<style type="text/css" media="screen,print">@import url(#RootDir#css/advanced.css);</style>

<!-- CUSTOM SCRIPTS/CSS END | FIN DES SCRIPTS/CSS PERSONNALISES -->
<!-- TEMPLATE PRINT CSS BEGINS | DEBUT DU CSS DU GABARIT POUR L'IMPRESSION -->
<link href="#CLF_URL#/clf20/css/pf-if.css" rel="stylesheet" type="text/css" />
</cfoutput>
<!-- TEMPLATE PRINT CSS ENDS | FIN DU CSS DU GABARIT POUR L'IMPRESSION -->
</head>


<!--cfinclude template="#RootDir#includes/header-#lang#.cfm"-->

<cfset language.PageTitle = "View Company">
<cfset language.ScreenMessage = ''>

<CFIF IsDefined('url.CID')>
	<!---CFSET Variables.CID = url.CID--->
	<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	*
		FROM	Companies
		WHERE	Companies.CID = <cfqueryparam value="#url.CID#" cfsqltype="cf_sql_integer" />
			AND	Deleted = '0'
		ORDER BY	Name
	</cfquery>

	<cfquery name="getAgents" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	FirstName, LastName
		FROM	Users	INNER JOIN	UserCompanies ON Users.UID = UserCompanies.UID
		WHERE	UserCompanies.CID = <cfqueryparam value="#url.CID#" cfsqltype="cf_sql_integer" />
			AND Users.Deleted = '0'
			AND UserCompanies.Approved = '1'
			AND	UserCompanies.Deleted = '0'
		ORDER BY	LastName, FirstName
	</cfquery>

<CFELSE>
	<CFSET ScreenMessage = "There is no such company.">
</CFIF>


</head>

<body>

<div style="width:480px; background-color:#FFFFFF;">
	<div class="core">
		<!-- FIP HEADER BEGINS | DEBUT DE L'EN-TETE PCIM -->
		<div class="fip">
		<a name="tphp" id="tphp"><img src="<cfoutput>#CLF_URL#</cfoutput>/clf20/images/sig-eng.gif" width="364" height="33" alt="Public Works and Government Services Canada" /></a>
		</div>
		<div class="cwm">
			<img src="<cfoutput>#CLF_URL#</cfoutput>/clf20/images/wmms.gif" width="83" height="20" alt="Symbol of the Government of Canada" />
		</div>
		<!-- FIP HEADER ENDS | FIN DE L'EN-TETE PCIM -->

		<div class="center" style="margin-left:-10px;">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#getCompany.Name# <CFIF IsDefined('getCompany.Approved') AND getCompany.Approved neq '' AND getCompany.Approved>(#getCompany.Abbreviation#)</CFIF></cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>
<table style="width:80%;" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<cfoutput><td id="addy1" style="width:30%;" valign="top">#language.address#:</td>
		<td headers="addy1">
			#getCompany.Address1#<CFIF getCompany.Address2 neq ""><br />
			#getCompany.Address2#</CFIF><br />
			#getCompany.City#<br />
			#getCompany.Country#<br />
			#getCompany.zip#
		</td></cfoutput>
	</tr>
	</tr>
	<tr>
		<cfoutput><td id="phone" valign="top">#language.phone#:</td>
		<td headers="phone">#getCompany.phone#</td></cfoutput>
	</tr>
	<tr>
		<cfoutput><td id="status" valign="top">#language.status#:</td>
		<td headers="status"><CFIF IsDefined('getCompany.Approved') AND getCompany.Approved neq '' AND getCompany.approved>Approved<CFELSE>Awaiting Approval</CFIF></td></cfoutput>
	</tr>
	<CFIF IsDefined('getCompany.Approved') AND getCompany.Approved neq '' AND getCompany.approved>
	<tr>
		<td id="Agents" valign="top">Other Approved Agents:</td>
		<td headers="Agents"><cfoutput query="getAgents">#FirstName# #LastName#<br /></cfoutput><CFIF getAgents.recordCount eq 0>None</CFIF></td>
	</tr>
	</CFIF>
</table>
<br />
<div style="text-align:center;"><a href="javascript: self.close();" class="textbutton">close</a></div>

<br />
			<!-- FOOTER BEGINS | DEBUT DU PIED DE LA PAGE -->
			<div class="footer">
				<div class="footerline"></div>
				<div class="foot1">
					<!-- DATE MODIFIED BEGINS | DEBUT DE LA DATE DE MODIFICATION -->
					Date Modified: <span class="date">
						<!--- the query is set up in tete-header --->
						<cfoutput query="GetFile">	#LSDateFormat(parseDateTime(GetFile.DateLastModified,"mm-dd-yyyy"), "yyyy-mm-dd")#</cfoutput>
					</span>
					<!-- DATE MODIFIED ENDS | FIN DE LA DATE DE MODIFICATION -->
				</div>
				<!-- ====== /clf20/ssi/FOOT-PIED-ENG.html ====== -->
				<div class="foot2">
					<a href="#tphp" title="Return to Top of Page"><img class="uparrow" src="<cfoutput>#CLF_URL#</cfoutput>/clf20/images/tphp.gif" width="19" height="12" alt="" /><br />Top of Page</a>
				</div>
				<div class="foot3">
					<a href="http://www.tpsgc-pwgsc.gc.ca/comm/ai-in-eng.html">Important Notices</a>
				</div>
				<!-- ====== /clf20/ssi/FOOT-PIED-ENG.html ====== -->

			</div>
			<!-- FOOTER ENDS | FIN DU PIED DE LA PAGE -->
		</div>
	</div>
</div>
</body>
</html>
