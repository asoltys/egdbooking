<cfset language.PageTitle = "Project Calendar View">
<cfset language.ScreenMessage = '<p><b>This calendar contains information for the drydock only.</b>  Please use the pop-up <span class="textbutton">calendar</span> to enter the range of dates you would like to view.  To start from the first booking record, clear the "From Date" field.  To end after the last booking record, clear the "To Date" field.  To see all records, clear both fields.</p>'>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/tr/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">

<CFINCLUDE template="#RootDir#includes/companyInfoVariables.cfm">

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
<meta name="dc.title" content="PWGSC - ESQUIMALT GRAVING DOCK - Project Calendar">
<meta name="dc.subject" scheme="gccore" content="ship, wharf">
<meta name="dc.language" scheme="ISO639-2/T" content="eng" />
<meta name="dc.creator" content="Government of Canada, Public Works and Government Services Canada" />
<meta name="dc.publisher" content="Government of Canada, Public Works and Government Services Canada" />
<meta name="dc.rights" content="http://www.tpsgc-pwgsc.gc.ca/comm/ai-in-eng.html" />
<meta name="dcterms.issued" scheme="W3CDTF" content="2007-09-20" />
<meta name="dcterms.modified" scheme="W3CDTF" content="<cfoutput query="GetFile">#LSDateFormat(parseDateTime(GetFile.DateLastModified,"mm-dd-yyyy"), "yyyy-mm-dd")#</cfoutput>" />
<meta name="description" content="Allows user to view bookings in a given range in MS Project style." />
<meta name="keywords" content="" />
<meta name="pwgsc.contact.email" content="questions@tpsgc-pwgsc.gc.ca" />
<!-- METADATA ENDS | FIN DES METADONNEES -->
<!-- TEMPLATE SCRIPTS/CSS BEGIN | DEBUT DES SCRIPTS/CSS DU GABARIT -->
<cfoutput>
<link href="#CLF_URL#/clf20/css/base.css" media="screen, print" rel="stylesheet" type="text/css" />
<link href="#CLF_URL#/clf20/css/1col.css" media="screen, print" rel="stylesheet" type="text/css" />
<style type="text/css" media="all">@import url(/clf20/css/base2.css);</style>

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


<body>
<div class="page">
	<div class="core">
		<!-- FIP HEADER BEGINS | DEBUT DE L'EN-TETE PCIM -->
		<div class="fip">

		<a name="tphp" id="tphp"><img src="<cfoutput>#CLF_URL#</cfoutput>/clf20/images/sig-eng.gif" width="364" height="33" alt="Public Works and Government Services Canada" /></a>
		</div>
		<div class="cwm">
			<img src="<cfoutput>#CLF_URL#</cfoutput>/clf20/images/wmms.gif" width="83" height="20" alt="Symbol of the Government of Canada" />
		</div>
		<!-- FIP HEADER ENDS | FIN DE L'EN-TETE PCIM -->

		<div class="center">
			<h1><a name="cont" id="cont">
				<cfoutput>#Language.PageTitle#</cfoutput>
				</a></h1>

			<cfinclude template="#RootDir#includes/getStructure.cfm">
			<cfparam name="Variables.startDate" default="#PacificNow#">
			<cfparam name="Variables.endDate" default="#DateAdd('m', 3, PacificNow)#">
			<cfset Variables.BookingLen = Variables.endDate - Variables.startDate>

			<CFINCLUDE template="#RootDir#includes/calendar_js.cfm">

			<cfoutput>#Language.ScreenMessage#</cfoutput>

			<cfform action="projectCalendar.cfm?lang=#lang#" method="post" enablecab="No" id="procal" preservedata="Yes">
			<cfoutput>
			<table style="width:60%;">
				<tr>
					<td id="From_Header">&nbsp; <LABEL for="From">From Date:</LABEL></td>
					<td headers="From_Header">
						<cfinput id="Start" type="text" name="startDate" value="#DateFormat(startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" validate="date" message="Please enter a valid From Date." onChange="setLaterDate('procal', #Variables.bookingLen#)" onFocus="setEarlierDate('procal', #Variables.BookingLen#)" /> #language.dateform#
						<img src="#RootDir#images/calendar.gif" alt="" class="calendar" />
						<a href="javascript:void(0);" onclick="document.procal.startDate.value='';" class="textbutton">clear</a>
					</td>
				</tr>
				<tr>
					<td id="To_Header">&nbsp; <LABEL for="To">To Date:</LABEL></td>
					<td headers="To_Header">
						<cfinput id="End" type="text" name="endDate" value="#DateFormat(endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" validate="date" message="Please enter a valid From Date." onChange="setEarlierDate('procal', #Variables.bookingLen#)" onFocus="setLaterDate('procal', #Variables.BookingLen#)" /> #language.dateform#
						<img src="#RootDir#images/calendar.gif" alt="" class="calendar" />
						<a href="javascript:void(0);" onclick="document.procal.endDate.value='';" class="textbutton">clear</a>
					</td>
				</tr>
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr>
					<td>&nbsp;</td>
					<td>
						<input type="submit" value="submit" class="textbutton" />
						<input type="reset" value="reset" class="textbutton" />
						<input type="button" value="Close This Window" class="textbutton" onclick="javascript:window.close(); void(0);" />
					</td>
				</tr>
			</table>
			</cfoutput>
			</cfform>
		</div>

<CFINCLUDE template="#RootDir#includes/foot-pied-eng.cfm">
