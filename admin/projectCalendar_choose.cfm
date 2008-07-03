<cfset language.PageTitle = "Project Calendar View">
<cfset language.ScreenMessage = '<p><b>This calendar contains information for the drydock only.</b>  Please use the pop-up <span class="textbutton">calendar</span> to enter the range of dates you would like to view.  To start from the first booking record, clear the "From Date" field.  To end after the last booking record, clear the "To Date" field.  To see all records, clear both fields.</p>'>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/tr/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">

<CFINCLUDE template="#RootDir#includes/companyInfoVariables.cfm">

<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,"\")>
<cfset PageDir = listDeleteAt(cgi.CF_TEMPLATE_PATH, listLen(cgi.CF_TEMPLATE_PATH,"\"), "\")>
<cfdirectory action="LIST" directory="#PageDir#" name="GetFile" filter="#PageFileName#">
<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,"\")>

<head>
<!-- CLF 2.0 TEMPLATE VERSION 1.04 | VERSION 1.04 DU GABARIT NSI 2.0 -->
<!-- PWGSC TEMPLATE VERSION 1.0 | VERSION 1.0 DU GABARIT TPSGC -->
<!-- headER BEGINS | DEBUT DE L'EN-TETE -->
<!-- title BEGINS | DEBUT DU TITRE -->
<title>PWGSC - ESQUIMALT GRAVING DOCK - View Company Details</title>
<!-- title ENDS | FIN DU TITRE -->
<!-- metaDATA BEGINS | DEBUT DES metaDONNEES -->
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="schema.dc" href="http://purl.org/dc/elements/1.1/" />
<link rel="schema.dc" href="http://purl.org/dc/terms/" />
<meta name="dc.title" content="PWGSC - ESQUIMALT GRAVING DOCK - Project Calendar">
<meta name="dc.subject" SCHEME="gccore" content="ship, wharf">
<meta name="dc.language" SCHEME="ISO639-2/T" content="eng" />
<meta name="dc.creator" content="Government of Canada, Public Works and Government Services Canada" />
<meta name="dc.publisher" content="Government of Canada, Public Works and Government Services Canada" />
<meta name="dc.audience" content=" " />
<meta name="dc.contributor" content=" " />
<meta name="dc.coverage" content=" " />
<meta name="dc.format" content=" " />
<meta name="dc.identifier" content=" " />
<meta name="dc.rights" content="http://www.tpsgc-pwgsc.gc.ca/comm/ai-in-eng.html" />
<meta name="dcterms.issued" SCHEME="W3CDTF" content="2007-09-20" />
<meta name="dcterms.modified" SCHEME="W3CDTF" content="<cfoutput query="GetFile">#LSDateFormat(parseDateTime(GetFile.DateLastModified,"mm-dd-yyyy"), "yyyy-mm-dd")#</cfoutput>" />
<meta name="description" content="Allows user to view bookings in a given range in MS Project style.">
<meta name="keywords" content="">
<meta name="pwgsc.contact.email" content="questions@tpsgc-pwgsc.gc.ca" />
<!-- metaDATA ENDS | FIN DES metaDONNEES -->
<!-- TEMPLATE SCRIPTS/CSS BEGIN | DEBUT DES SCRIPTS/CSS DU GABARIT -->
<cfoutput>
<link href="/clf20/css/base.css" media="screen, print" rel="stylesheet" type="text/css" />
<link href="/clf20/css/1col.css" media="screen, print" rel="stylesheet" type="text/css" />
<style type="text/css" media="all">@import url(/clf20/css/base2.css);</style>
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
<link href="/clf20/css/base-institution.css" media="screen, print" rel="stylesheet" type="text/css" />
<link href="/clf20/css/institution.css" media="screen, print" rel="stylesheet" type="text/css" />
<style type="text/css" media="screen,print">@import url(#RootDir#css/advanced.css);</style>
</cfoutput>
<!-- CUSTOM SCRIPTS/CSS END | FIN DES SCRIPTS/CSS PERSONNALISES -->
<!-- TEMPLATE PRINT CSS BEGINS | DEBUT DU CSS DU GABARIT POUR L'IMPRESSION -->
<link href="/clf20/css/pf-if.css" rel="stylesheet" type="text/css" />
<!-- TEMPLATE PRINT CSS ENDS | FIN DU CSS DU GABARIT POUR L'IMPRESSION -->
</head>


<BODY>
<div class="page">
	<div class="core">
		<!-- FIP headER BEGINS | DEBUT DE L'EN-TETE PCIM -->
		<div class="fip">
		<a name="tphp" id="tphp"><img src="/clf20/images/sig-eng.gif" width="364" height="33" alt="Public Works and Government Services Canada" /></a>
		</div>
		<div class="cwm">
			<img src="/clf20/images/wmms.gif" width="83" height="20" alt="Symbol of the Government of Canada" />
		</div>
		<!-- FIP headER ENDS | FIN DE L'EN-TETE PCIM -->

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

			<cfform action="projectCalendar.cfm?lang=#lang#" method="POST" enablecab="No" name="procal" preservedata="Yes">
			<cfoutput>
			<table width="60%">
				<!---tr>
					<td width="30%">Name:</td>
					<td width="70%">
						<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
							#session.lastName#, #session.firstName#
						</cflock>
					</td>
				</tr>
				<tr>
					<td>Vessel:</td>
					<td><cfselect name="vesselID" query="getVessels" display="Name" value="VesselID" selected="#vesselID#" /></td>
				</tr--->
				<tr>
					<td id="From_Header">&nbsp; <LABEL for="From">From Date:</LABEL></td>
					<td headers="From_Header">
						<!---input type="Text" class="textField" name="startDateShow" value="#DateFormat(startDate, 'mmm d, yyyy')#" size="17" maxlength="12" validate="date" message="Please enter a valid Start Date." disabled--->
						<cfinput id="Start" type="text" name="startDate" value="#DateFormat(startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" class="textField" validate="date" message="Please enter a valid From Date." onChange="setLaterDate('self', 'procal', #Variables.bookingLen#)" onFocus="setEarlierDate('self', 'procal', #Variables.BookingLen#)"> #language.dateform#
						<a href="javascript:void(0);" onClick="getCalendar('procal', 'start');" class="textbutton">calendar</a>
						<a href="javascript:void(0);" onClick="document.procal.startDate.value='';" class="textbutton">clear</a>
					</td>
				</tr>
				<tr>
					<td id="To_Header">&nbsp; <LABEL for="To">To Date:</LABEL></td>
					<td headers="To_Header">
						<!---input type="Text" class="textField" name="endDateShow" value="#DateFormat(endDate, 'mmm d, yyyy')#" size="17" maxlength="12" validate="date" message="Please enter a valid End Date." disabled--->
						<cfinput id="End" type="text" name="endDate" value="#DateFormat(endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" class="textField" validate="date" message="Please enter a valid From Date." onChange="setEarlierDate('self', 'procal', #Variables.bookingLen#)" onFocus="setLaterDate('self', 'procal', #Variables.BookingLen#)"> #language.dateform#
						<a href="javascript:void(0);" onClick="getCalendar('procal', 'end');" class="textbutton">calendar</a>
						<a href="javascript:void(0);" onClick="document.procal.endDate.value='';" class="textbutton">clear</a>
					</td>
				</tr>
				<tr><td colspan="2">&nbsp;</td></tr>		
				<tr>
					<td>&nbsp;</td>
					<td>
						<!---a href="javascript:validate('procal');" class="textbutton">Submit</a>
						<a href="javascript:document.procal.reset();" class="textbutton">Reset</a>
						<a href="javascript:window.close()" class="textbutton">Cancel</a>
						<br--->
						<input type="Submit" value="Submit" class="textbutton">
						<input type="Reset" value="Reset" class="textbutton">
						<input type="button" value="Close This Window" class="textbutton" onClick="javascript:window.close(); void(0);">
					</td>
				</tr>
			</table>
			</cfoutput>
			</cfform>
		</div>

<CFINCLUDE template="#RootDir#includes/foot-pied-eng.cfm">
