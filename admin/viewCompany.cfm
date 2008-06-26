<CFINCLUDE template="#RootDir#includes/companyInfoVariables.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">

<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,"\")>
<cfset PageDir = listDeleteAt(cgi.CF_TEMPLATE_PATH, listLen(cgi.CF_TEMPLATE_PATH,"\"), "\")>
<cfdirectory action="LIST" directory="#PageDir#" name="GetFile" filter="#PageFileName#">
<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,"\")>

<HEAD>
<!-- CLF 2.0 TEMPLATE VERSION 1.04 | VERSION 1.04 DU GABARIT NSI 2.0 -->
<!-- PWGSC TEMPLATE VERSION 1.0 | VERSION 1.0 DU GABARIT TPSGC -->
<!-- HEADER BEGINS | DEBUT DE L'EN-TETE -->
<!-- TITLE BEGINS | DEBUT DU TITRE -->
<title>PWGSC - ESQUIMALT GRAVING DOCK - View Company Details</title>
<!-- TITLE ENDS | FIN DU TITRE -->
<!-- METADATA BEGINS | DEBUT DES METADONNEES -->
<META http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<LINK rel="schema.dc" href="http://purl.org/dc/elements/1.1/" />
<LINK rel="schema.dc" href="http://purl.org/dc/terms/" />
<META name="dc.title" content="PWGSC - ESQUIMALT GRAVING DOCK - View Company Details">
<META name="dc.subject" SCHEME="gccore" content="ship, wharf">
<META name="dc.language" SCHEME="ISO639-2/T" content="eng" />
<META name="dc.creator" content="Government of Canada, Public Works and Government Services Canada" />
<META name="dc.publisher" content="Government of Canada, Public Works and Government Services Canada" />
<META name="dc.audience" content=" " />
<META name="dc.contributor" content=" " />
<META name="dc.coverage" content=" " />
<META name="dc.format" content=" " />
<META name="dc.identifier" content=" " />
<META name="dc.rights" content="http://www.tpsgc-pwgsc.gc.ca/comm/ai-in-eng.html" />
<META name="dcterms.issued" SCHEME="W3CDTF" content="2007-09-20" />
<META name="dcterms.modified" SCHEME="W3CDTF" content="<cfoutput query="GetFile">#LSDateFormat(parseDateTime(GetFile.DateLastModified,"mm-dd-yyyy"), "yyyy-mm-dd")#</cfoutput>" />
<META name="description" content="Allows user to view information on a company.">
<META name="keywords" content="">
<META name="pwgsc.contact.email" content="questions@tpsgc-pwgsc.gc.ca" />
<!-- METADATA ENDS | FIN DES METADONNEES -->
<!-- TEMPLATE SCRIPTS/CSS BEGIN | DEBUT DES SCRIPTS/CSS DU GABARIT -->
<cfoutput>
<LINK href="/clf20/css/base.css" media="screen, print" rel="stylesheet" type="text/css" />
<LINK href="/clf20/css/2col.css" media="screen, print" rel="stylesheet" type="text/css" />
<STYLE type="text/css" media="all">@import url(/clf20/css/base2.css);</STYLE>
</cfoutput>
<!-- TEMPLATE SCRIPTS/CSS END | FIN DES SCRIPTS/CSS DU GABARIT -->
<!-- PROGRESSIVE ENHANCEMENT BEGINS | DEBUT DE L'AMELIORATION PROGRESSIVE -->
<SCRIPT src="/clf20/scripts/pe-ap.js" type="text/javascript"></SCRIPT>
<SCRIPT type="text/javascript">
	/* <![CDATA[ */
		var params = {
			lng:"eng",
			pngfix:"/clf20/images/inv.gif"
		};
		PE.progress(params);
	/* ]]> */
</SCRIPT>
<!-- PROGRESSIVE ENHANCEMENT ENDS | FIN DE L'AMELIORATION PROGRESSIVE -->
<!-- CUSTOM SCRIPTS/CSS BEGIN | DEBUT DES SCRIPTS/CSS PERSONNALISES -->
<cfoutput>
<LINK href="/clf20/css/base-institution.css" media="screen, print" rel="stylesheet" type="text/css" />
<LINK href="/clf20/css/institution.css" media="screen, print" rel="stylesheet" type="text/css" />
<STYLE type="text/css" media="screen,print">@import url(#RootDir#css/advanced.css);</STYLE>
</cfoutput>
<!-- CUSTOM SCRIPTS/CSS END | FIN DES SCRIPTS/CSS PERSONNALISES -->
<!-- TEMPLATE PRINT CSS BEGINS | DEBUT DU CSS DU GABARIT POUR L'IMPRESSION -->
<LINK href="/clf20/css/pf-if.css" rel="stylesheet" type="text/css" />
<!-- TEMPLATE PRINT CSS ENDS | FIN DU CSS DU GABARIT POUR L'IMPRESSION -->
</HEAD>


<!--cfinclude template="#RootDir#includes/header-#lang#.cfm"-->

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

<BODY>

<div style="width:480px; background-color:#FFFFFF;">
	<div class="core">
		<!-- FIP HEADER BEGINS | DEBUT DE L'EN-TETE PCIM --> 
		<div class="fip">
		<a name="tphp" id="tphp"><img src="/egd_internet_clf2/clf20/images/sig-eng.gif" width="364" height="33" alt="Public Works and Government Services Canada" /></a>
		</div>
		<div class="cwm">
			<img src="/egd_internet_clf2/clf20/images/wmms.gif" width="83" height="20" alt="Symbol of the Government of Canada" />
		</div>
		<!-- FIP HEADER ENDS | FIN DE L'EN-TETE PCIM --> 
		
		<div class="center" style="margin-left:-10px;">
				<H1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<CFOUTPUT>#getCompany.Name# <CFIF IsDefined('getCompany.Approved') AND getCompany.Approved neq '' AND getCompany.Approved>(#getCompany.Abbreviation#)</CFIF></CFOUTPUT>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></H1>
<TABLE width="80%" align="center" border="0" cellpadding="0" cellspacing="0">
	<TR>
		<CFOUTPUT><TD id="addy1" width="30%" valign="top">#language.address#:</TD>
		<TD headers="addy1">
			#getCompany.Address1#<CFIF getCompany.Address2 neq ""><br />
			#getCompany.Address2#</CFIF><br />
			#getCompany.City#<br />
			#getCompany.Country#<br />
			#getCompany.zip#
		</TD></CFOUTPUT>
	</TR>
	</TR>
	<TR>
		<CFOUTPUT><TD id="phone" valign="top">#language.phone#:</TD>
		<TD headers="phone">#getCompany.phone#</TD></CFOUTPUT>
	</TR>
	<TR>
		<CFOUTPUT><TD id="status" valign="top">#language.status#:</TD>
		<TD headers="status"><CFIF IsDefined('getCompany.Approved') AND getCompany.Approved neq '' AND getCompany.approved>Approved<CFELSE>Awaiting Approval</CFIF></TD></CFOUTPUT>
	</TR>
	<CFIF IsDefined('getCompany.Approved') AND getCompany.Approved neq '' AND getCompany.approved>
	<TR>
		<TD id="Agents" valign="top">Other Approved Agents:</TD>
		<TD headers="Agents"><CFOUTPUT query="getAgents">#FirstName# #LastName#<br /></CFOUTPUT><CFIF getAgents.recordCount eq 0>None</CFIF></TD>
	</TR>
	</CFIF>
</TABLE>
<br />
<DIV align="center"><A href="javascript: self.close();" class="textbutton">close</A></DIV>

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
				<!-- ====== /clf20/ssi/FOOT-PIED-ENG.HTML ====== -->
				<div class="foot2">
					<a href="#tphp" title="Return to Top of Page"><img class="uparrow" src="/egd_internet_clf2/clf20/images/tphp.gif" width="19" height="12" alt="" /><br />Top of Page</a>
				</div>
				<div class="foot3">
					<a href="http://www.tpsgc-pwgsc.gc.ca/comm/ai-in-eng.html">Important Notices</a>
				</div>
				<!-- ====== /clf20/ssi/FOOT-PIED-ENG.HTML ====== -->
				
			</div>
			<!-- FOOTER ENDS | FIN DU PIED DE LA PAGE -->
		</div>
	</div>
</div>
</body>
</html>
