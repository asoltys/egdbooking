<cfset language.PageTitle = "Project Calendar View">
<cfset language.ScreenMessage = '<p><b>This calendar contains information for the drydock only.</b>  Please use the pop-up <span class="textbutton">calendar</span> to enter the range of dates you would like to view.  To start from the first booking record, clear the "From Date" field.  To end after the last booking record, clear the "To Date" field.  To see all records, clear both fields.</p>'>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">

<CFINCLUDE template="#RootDir#includes/companyInfoVariables.cfm">

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
<META name="dc.title" content="PWGSC - ESQUIMALT GRAVING DOCK - Project Calendar">
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
<META name="description" content="Allows user to view bookings in a given range in MS Project style.">
<META name="keywords" content="">
<META name="pwgsc.contact.email" content="questions@pwgsc.gc.ca" />
<!-- METADATA ENDS | FIN DES METADONNEES -->
<!-- TEMPLATE SCRIPTS/CSS BEGIN | DEBUT DES SCRIPTS/CSS DU GABARIT -->
<cfoutput>
<LINK href="/clf20/css/base.css" media="screen, print" rel="stylesheet" type="text/css" />
<LINK href="/clf20/css/1col.css" media="screen, print" rel="stylesheet" type="text/css" />
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


<BODY>
<div class="page">
	<div class="core">
		<!-- FIP HEADER BEGINS | DEBUT DE L'EN-TETE PCIM -->
		<div class="fip">
		<a name="tphp" id="tphp"><img src="/clf20/images/sig-eng.gif" width="364" height="33" alt="Public Works and Government Services Canada" /></a>
		</div>
		<div class="cwm">
			<img src="/clf20/images/wmms.gif" width="83" height="20" alt="Symbol of the Government of Canada" />
		</div>
		<!-- FIP HEADER ENDS | FIN DE L'EN-TETE PCIM -->

		<div class="center">
			<H1><a name="cont" id="cont">
				<cfoutput>#Language.PageTitle#</cfoutput>
				</a></H1>

			<cfinclude template="#RootDir#includes/getStructure.cfm">
			<cfparam name="Variables.startDate" default="#PacificNow#">
			<cfparam name="Variables.endDate" default="#DateAdd('m', 3, PacificNow)#">
			<cfset Variables.BookingLen = Variables.endDate - Variables.startDate>
		
			<CFINCLUDE template="#RootDir#includes/calendar_js.cfm">

			<cfoutput>#Language.ScreenMessage#</cfoutput>

			<cfform action="projectCalendar.cfm?lang=#lang#" method="POST" enablecab="No" name="procal" preservedata="Yes">
			<cfoutput>
			<TABLE width="60%">
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
				<TR>
					<TD id="From_Header">&nbsp; <LABEL for="From">From Date:</LABEL></TD>
					<TD headers="From_Header">
						<!---input type="Text" class="textField" name="startDateShow" value="#DateFormat(startDate, 'mmm d, yyyy')#" size="17" maxlength="12" validate="date" message="Please enter a valid Start Date." disabled--->
						<cfinput id="Start" type="text" name="startDate" value="#DateFormat(startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" class="textField" validate="date" message="Please enter a valid From Date." onChange="setLaterDate('self', 'procal', #Variables.bookingLen#)" onFocus="setEarlierDate('self', 'procal', #Variables.BookingLen#)"> <FONT class="light">#Language.dateform#</FONT>
						<A href="javascript:void(0);" onClick="getCalendar('procal', 'start');" class="textbutton">calendar</A>
						<A href="javascript:void(0);" onClick="document.procal.startDate.value='';" class="textbutton">clear</A>
					</TD>
				</TR>
				<TR>
					<TD id="To_Header">&nbsp; <LABEL for="To">To Date:</LABEL></TD>
					<TD headers="To_Header">
						<!---input type="Text" class="textField" name="endDateShow" value="#DateFormat(endDate, 'mmm d, yyyy')#" size="17" maxlength="12" validate="date" message="Please enter a valid End Date." disabled--->
						<cfinput id="End" type="text" name="endDate" value="#DateFormat(endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" class="textField" validate="date" message="Please enter a valid From Date." onChange="setEarlierDate('self', 'procal', #Variables.bookingLen#)" onFocus="setLaterDate('self', 'procal', #Variables.BookingLen#)"> <FONT class="light">#Language.dateform#</FONT>
						<A href="javascript:void(0);" onClick="getCalendar('procal', 'end');" class="textbutton">calendar</A>
						<A href="javascript:void(0);" onClick="document.procal.endDate.value='';" class="textbutton">clear</A>
					</TD>
				</TR>
				<TR><TD colspan="2">&nbsp;</TD></TR>		
				<TR>
					<TD>&nbsp;</TD>
					<TD>
						<!---a href="javascript:validate('procal');" class="textbutton">Submit</a>
						<a href="javascript:document.procal.reset();" class="textbutton">Reset</a>
						<a href="javascript:window.close()" class="textbutton">Cancel</a>
						<br--->
						<INPUT type="Submit" value="Submit" class="textbutton">
						<INPUT type="Reset" value="Reset" class="textbutton">
						<INPUT type="button" value="Close This Window" class="textbutton" onClick="javascript:window.close(); void(0);">
					</TD>
				</TR>
			</TABLE>
			</cfoutput>
			</cfform>
		</DIV>

<CFINCLUDE template="#RootDir#includes/foot-pied-eng.cfm">