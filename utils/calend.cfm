<CFINCLUDE template="#RootDir#includes/GeneralLanguageVariables.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/tr/html4/loose.dtd">

<html lang="en">

<cfif lang EQ "eng">
	<cfset language.calendar = "Calendar">
	<cfset language.description = "A mini calendar that allows user to choose a date interactively.">
	<cfset language.PWGSC = "PWGSC">
	<cfset language.esqGravingDockCaps = "ESQUIMALT GRAVING DOCK">
	<cfset language.close = "close">
<cfelse>
	<cfset language.calendar = "Calendrier">
	<cfset language.description = "Un mini-calendrier qui permet à l'utilisateur de choisir une date interactivement.">
	<cfset language.PWGSC = "TPSGC">
	<cfset language.esqGravingDockCaps = "CALE S&Eacute;CHE D'ESQUIMALT">
	<cfset language.close = "Fermer">
</cfif>
<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,"\")>
<cfset PageDir = listDeleteAt(cgi.CF_TEMPLATE_PATH, listLen(cgi.CF_TEMPLATE_PATH,"\"), "\")>
<cfdirectory action="LIST" directory="#PageDir#" name="GetFile" filter="#PageFileName#">
<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,"\")>

<cfoutput>
<head>
	<!--INTERNET TEMPLATE VERSION 2.1-->
	<!--metaDATA PROFILE START-->
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<CFIF lang eq 'e'>
	<CFSET langVar = "eng">
	<meta name="MSSmartTagsPreventParsing" content="True">
	<link rel="schema.dc" href="http://purl.org/dc/elements/1.1">
	<meta name="dc.language" scheme="IS0639-2" content="eng">
	<meta name="dc.creator" lang="eng" content="Government of Canada, Public Works and Government Services Canada, Esquimalt Graving Dock">
	<meta name="dc.publisher" lang="eng" content="Public Works and Government Services Canada">
	<CFELSE>
	<CFSET langVar = "fre">
	<meta name="MSSmartTagsPreventParsing" content="Vrai">
	<link rel="schema.dc" href="http://purl.org/dc/elements/1.1">
	<meta name="dc.language" scheme="IS0639-2" content="fre">
	<meta name="dc.creator" lang="fre" content="Gouvernement du Canada, Travaux publics et Services gouvernementaux Canada, Cale s&egrave;che d'Esquimalt">
	<meta name="dc.publisher" lang="fre" content="Travaux publics et Services gouvernementaux Canada ">
	</CFIF>
	
	<meta name="pwgsc.contact.email" content="egd@pwgsc.gc.ca">
	<meta name="dc.rights" lang="#langVar#" content="http://www.pwgsc.gc.ca/generic/copyright-e.html">
	<meta name="robots" content="noindex,nofollow">

	<meta name="dc.title" lang="#langVar#" content="#language.PWGSC# - #language.esqGravingDockCaps# - #language.calendar#">
	<meta name="keywords" lang="#langVar#" content="#Language.masterKeywords#">
	<meta name="description" lang="#langVar#" content="#language.description#">
	<meta name="dc.subject" scheme="gccore" lang="#langVar#" content="#Language.masterSubjects#">
	<meta name="dc.date.published" content="2005-07-25">
	<meta name="dc.date.reviewed" content="2005-07-25">
	<meta name="dc.date.modified" content="2005-07-25">
	<meta name="dc.date.created" content="2005-07-25">
	
	<meta name="pwgsc.date.retention" content="">
	
	<!-- leave blank -->
	<meta name="dc.contributor" lang="#langVar#" content="">
	<meta name="dc.identifier" lang="#langVar#" content="">
	<meta name="dc.audience" lang="#langVar#" content="">
	<meta name="dc.type" lang="#langVar#" content="">
	<meta name="dc.format" lang="#langVar#" content="">
	<meta name="dc.coverage" lang="#langVar#" content="">
	<!--metaDATA PROFILE END-->
	
	<link href="/clf20/css/base.css" media="screen, print" rel="stylesheet" type="text/css" />
	<link href="/clf20/css/1col.css" media="screen, print" rel="stylesheet" type="text/css" />
	<link href="/clf20/css/base-institution.css" media="screen, print" rel="stylesheet" type="text/css" />
	<link href="/clf20/css/institution.css" media="screen, print" rel="stylesheet" type="text/css" />
	<cfoutput><style type="text/css">
		@import url(#RootDir#css/advanced.css);
		@import url(#RootDir#css/custom.css);
	</style></cfoutput>
	
	<title>#language.PWGSC# - #language.esqGravingDockCaps# - #language.Calendar#</title>

</head>
</cfoutput>

<body onload="setCalendar()">

<!-- FIP HEADER BEGINS | DEBUT DE L'EN-TETE PCIM -->
<CFIF lang EQ "eng">
<div style="float:right; position:relative; z-index:1; height:33px;">
	<img src="/clf20/images/wmms.gif" width="83" height="20" alt="Symbol of the Government of Canada" />
</div>
<a name="tphp" id="tphp"><img src="/clf20/images/sig-eng.gif" width="364" height="33" alt="Public Works and Government Services Canada" /></a>
<CFELSE>
<div style="float:right; position:relative; z-index:1; height:33px;">
	<img src="/clf20/images/wmms.gif" width="83" height="20" alt="Symbole du gouvernement du Canada" />
</div>
<a name="tphp" id="tphp"><img src="/clf20/images/sig-fra.gif" width="364" height="33" alt="Travaux publics et Services gouvernementaux Canada" /></a>
</CFIF>
<!-- FIP HEADER ENDS | FIN DE L'EN-TETE PCIM -->

<!--- Set the month and year parameters to equal the current values 
  if they do not exist. --->	
<cfparam name="month" default="#DatePart("m", PacificNow)#">
<cfparam name="year" default="#DatePart("yyyy", PacificNow)#">


<!--- Set the requested (or current) month/year date and determine the 
  number of days in the month. --->
<cfset ThisMonthYear = CreateDate(year, month, '1')>
<cfset Days = DaysInMonth(ThisMonthYear)>

<!--- Set the values for the previous and next months for the back/next links. --->
<cfset LastMonthYear = DateAdd("m", -1, ThisMonthYear)>
<cfset LastMonth = DatePart("m", LastMonthYear)>
<cfset LastYear = DatePart("yyyy", LastMonthYear)>

<cfset NextMonthYear = DateAdd("m", 1, ThisMonthYear)>
<cfset NextMonth = DatePart("m", NextMonthYear)>
<cfset NextYear = DatePart("yyyy", NextMonthYear)>

<script language="JavaScript" type="text/javascript">
<!--

/*
 * Sends back date to original form.
 *
 * Changes the other field as well for coolness' sake.  Lois Chan, August 2005.
 */
function setDate(day) {
    //get all data to set the date
	var formName = <cfoutput>"#url.formName#"</cfoutput>;
	var fieldName = <cfoutput>"#url.fieldName#"</cfoutput>;
	<cfif isDefined('url.len')>var len = <cfoutput>"#url.len#"</cfoutput>;
	<cfelse>var len = 1;</cfif>
	
	var formObj = document.selection;
	var yearIndex = formObj.selYear.selectedIndex;
	var monthIndex = formObj.selMonth.selectedIndex;
	var year = formObj.selYear.options[yearIndex].text;
	var month = formObj.selMonth.options[monthIndex].value;
	 
	// set the date in the form 
	// adds a leading zero to make it purdy
	month = month + '';
	day = day + '';
	
	if (month.length == 1) {
		month = '0' + month;
	}
	if (day.length == 1) {
		day = '0' + day;
	}
	
	var theDate = month + "/" + day + "/" + year;
	eval("opener.document." + formName + "." + fieldName + "Date.value=\"" + theDate + "\"");

	// this gets a bit "hack-y", sorry
	if (fieldName == "start") {
		setLaterDate('opener', formName, len);
	}
	
//	if (fieldName == "end") {
//		setEarlierDate('opener', formName, len);
//	}

    self.close();
}

//-->
</script>

<table class="calendar" cellpadding="2" cellspacing="0" width="100%">
	<tr>
		<td colspan="7">
			<div align="center" style="font-weight: bold; font-size: 10pt;">
			<CFSET dummydate = CreateDate(url.year, url.month, 1)>
			<cfoutput>#LSDateFormat(dummydate, 'mmmm yyyy')#</cfoutput>
			</div>
		</td>
	</tr>
	<tr>
		<cfloop index="kounter" from="1" to="7" step="1">
		<cfoutput>
		<!--- I'm using May 2005 because the first day is a sunday--->
		<CFSET dummydate = CreateDate(2005, 5, kounter)>
			<th>#LSDateFormat(dummydate, 'ddd')#</th>
		</cfoutput>
		</cfloop>
	</tr>
	<cfset ThisDay = 0>

	<!--- Loop through until the number of days in the month is reached.  --->
	<cfloop condition="ThisDay LTE Days">
		<tr>
		<!--- Loop through each day of the week. --->
		<cfloop from="1" to="7" index="LoopDay">
			<!--- If ThisDay is still 0, check to see if the current day of the week 
				in the loop matches the day of the week for the first day of the 
				month. --->
			<!--- If the values match, set ThisDay to 1. --->
			<!--- Otherwise, the value will remain 0 until the correct day of 
				the week is found. --->
			<cfif ThisDay IS 0>
				<cfif DayOfWeek(ThisMonthYear) IS LoopDay>
					<cfset ThisDay=1>
				</cfif>
			</cfif>
			<!--- If the ThisDay value is still 0, or it is greater than the number 
				of days in the month, display nothing in the column. --->
			<!--- Otherwise, display the day of the month and increment the value.   --->
			<cfif (ThisDay IS NOT 0) AND (ThisDay LTE Days)>
				<cfoutput>
				<td>
					<div align="center"><a href="javascript:setDate(#ThisDay#)">#ThisDay#</a></div>
				</td>
				</cfoutput>
				<cfset ThisDay=ThisDay + 1>
			<cfelse>
				<td>&nbsp;</td>
			</cfif>
		</cfloop>
		</tr>
	</cfloop>
</table>
	
<div style="float:left;">
	<cfform name="selection" action="">
		<select name="selMonth" onChange="go('calendar')">
			<CFLOOP index="i" from="1" to="12">
				<cfoutput><option value="#i#">#LSDateFormat(CreateDate(1990, i, 1), 'mmmm')#</option></cfoutput>
			</CFLOOP>
		</select>
		<select name="selYear" onChange="go('calendar')">
			<CFLOOP index="i" from="-5" to="25">
				<option><cfoutput>#DateFormat(DateAdd('yyyy', i, PacificNow), 'yyyy')#</cfoutput></option>
			</CFLOOP>
		</select>
		<!--- <a href ="javascript:go()"><img src="go.gif" border = "0"></a> --->
	</cfform>
</div>

<CFINCLUDE template="#RootDir#includes/calendar_js.cfm">

<div style="text-align:right;"><a href="javascript:self.close();" class="textbutton"><cfoutput>#language.close#</cfoutput></a></div>


<!-- FOOTER BEGINS | DEBUT DU PIED DE LA PAGE -->
<div class="footer">
	<HR />
	<div style="float:left; width:50%; text-align:left;">
		<!-- DATE MODIFIED BEGINS | DEBUT DE LA DATE DE MODIFICATION -->
		<CFIF lang EQ 'eng' OR (IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true)>Date Modified:
		<CFELSE>Date de modification&nbsp;:
		</CFIF>
			<span class="date">
			<cfoutput query="GetFile">	#LSDateFormat(parseDateTime(GetFile.DateLastModified,"mm-dd-yyyy"), "yyyy-mm-dd")#</cfoutput>
		</span>
		<!-- DATE MODIFIED ENDS | FIN DE LA DATE DE MODIFICATION -->
	</div>
	<div style="float:left; width:50%; text-align:right">
		<a href="http://www.tpsgc-pwgsc.gc.ca/comm/ai-in-eng.html">Important Notices</a>
	</div>
	<!-- ====== /clf20/ssi/FOOT-PIED-ENG.HTML ====== -->
	
</div>
<!-- FOOTER ENDS | FIN DU PIED DE LA PAGE -->

</body>
</html>
