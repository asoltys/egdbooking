<!doctype HTML public "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html lang="en">

<cfif lang EQ "eng">
	<cfset language.calendar = "Calendar">
	<cfset language.description = "A mini calendar that allows user to choose a date interactively.">
	<cfset language.PWGSC = "PWGSC">
	<cfset language.esqGravingDockCaps = "ESQUIMALT GRAVING DOCK">
<cfelse>
	<cfset language.calendar = "Calendrier">
	<cfset language.description = "">
	<cfset language.PWGSC = "TPSGC">
	<cfset language.esqGravingDockCaps = "CALE S&Eacute;CHE D'ESQUIMALT">
</cfif>

<cfoutput>
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
	<meta name="dc.rights" lang="eng" content="http://www.pwgsc.gc.ca/text/generic/copyright-e.html">
	<meta name="robots" content="noindex,nofollow">

	<meta name="dc.title" lang="eng" content="#language.PWGSC# - #language.esqGravingDockCaps# - #language.Calendar#">
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
	
	<LINK type="text/css" rel="stylesheet" href="<CFOUTPUT>#RootDir#</cfoutput>css/default.css">
	<CFOUTPUT><STYLE type="text/css">
		@import url(#RootDir#css/advanced.css);
		@import url(#RootDir#css/events.css);
	</STYLE></CFOUTPUT>
	
	<title>#language.PWGSC# - #language.esqGravingDockCaps# - #language.Calendar#</title>

</head>
</cfoutput>

<body onload="setCalendar()" bgcolor="#F4F6EB" style="background-color: #F4F6EB;">

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
	
	if (fieldName == "end") {
		setEarlierDate('opener', formName, len);
	}

    self.close();
}

//-->
</script>

<table border="0" cellpadding="0" cellspacing="10" width="100%"><tr><td bgcolor="#F4F6EB" colspan="2">

	<table class="calendar" cellpadding="5" cellspacing="0" width="100%">
		<tr>
			<td colspan="7" class="calendar small">
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
				<th class="calendar small">#LSDateFormat(dummydate, 'ddd')#</th>
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
					<td class="calendar small" style="padding: 5px; ">
						<div align="center"><a href="javascript:setDate(#ThisDay#)">#ThisDay#</a></div>
					</td>
					</cfoutput>
					<cfset ThisDay=ThisDay + 1>
				<cfelse>
					<td class="calendar small">&nbsp;</td>
				</cfif>
			</cfloop>
			</tr>
		</cfloop>
	</table>
	</td></tr>
	<tr><td>
	
	<cfform name="selection" action="">
		<table border="0">
			<tr>
				<td>
					<select name="selMonth" onChange="go('calendar')">
						<CFLOOP index="i" from="1" to="12">
							<cfoutput><option value="#i#">#LSDateFormat(CreateDate(1990, i, 1), 'mmmm')#</option></cfoutput>
						</CFLOOP>
					</select>
			   </td>
			   <td>
					<select name="selYear" onChange="go('calendar')">
						<CFLOOP index="i" from="-2" to="2">
							<option><CFOUTPUT>#DateFormat(DateAdd('yyyy', i, PacificNow), 'yyyy')#</CFOUTPUT></option>
						</CFLOOP>
					</select>
				</td>
				<!---  <td>&nbsp;<a href ="javascript:go()"><img src="go.gif" border = "0"></a></td> --->
			</tr>
		</table>
	</cfform>
</td></tr></table>

<CFINCLUDE template="#RootDir#includes/calendar_js.cfm">

</body>
</html>
