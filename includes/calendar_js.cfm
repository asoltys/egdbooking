<cfif lang EQ "eng">
	<cfset language.endBeforeStartError = "End date should be no earlier than start date.">
<cfelse>
	<cfset language.endBeforeStartError = "La date de la fin de la p&eacute;riode ne peut &ecirc;tre ant&eacute;rieure &agrave; la date du d&eacute;but.">
</cfif>

<CFIF IsDefined('Variables.EndDate') AND Variables.EndDate neq "" AND IsDefined('Variables.StartDate') AND Variables.EndDate neq "">
	<CFSET Variables.BookingLen = Variables.EndDate - Variables.StartDate>
</CFIF>

<CFPARAM  name="Variables.BookingLen" default="1">

<script type="text/javascript">
/* <![CDATA[ */

/**
  *  Heavily edited by Lois Chan, May 2005.  Source unknown.
  *  I'm basing the functionalities on the Translink version because it is my favourite one.
  *  Nyeh.
  *  http://www.translink.bc.ca/hwire
  *
  *  get/set-Calendar functions consolidated into one include file June-July 2005, Lois Chan.
  *
  *  Made tokenizeDate a separate function August 2005, Lois Chan.
  *
  *  The 'hack' to make date fields adjust to each other added August 2005, Lois Chan.
  *
  *  NOTE: JavaScript's months start at 0 for January, so a small conversion must be made
  *  while parsing the literal string.
  */

/*
 * Breaks the date-String down to ints.  Takes an date object and update it with tokens.
 * Below assumption changes?  Have no fear -- just edit it here!
 *
 * ASSUMES that date is in 'mm/dd/yyyy' format.
 *
 * DON'T FORGET the radix of 10 for parseInt() or it could use octal instead of decimal.
 */
function makeDateObj(dateString, dateObj) {
	var tokens = [];
	dateString.scan(/\d+/, function(match) { tokens.push(match[0]); } );
	dateObj.setFullYear(parseInt(tokens[2], 10));  // year
	dateObj.setMonth(parseInt(tokens[0], 10) - 1);  // month
	dateObj.setDate(parseInt(tokens[1], 10));  // day
}

/* checks if the start day and end day are logically right:
 * end day is no less than start day
 * return true if dates are right
 */

function datesAreValid(dateObj1, dateObj2) {
	var dateValid = true;

	if (dateObj1 > dateObj2) {
		dateValid = false;
	}
	return dateValid;
}

function setOtherDate(myDateID, otherDateID, days) {
	var myDate = $(myDateID);
	var otherDate = $(otherDateID);
	var myDateObj = new Date();
	var otherDateObj = new Date();

	makeDateObj($F(myDate), myDateObj);

	otherDateObj.setDate(myDateObj.getDate() + parseInt(days, 10));
	alert("otherDateObj >> " + otherDateObj);

}

/* Makes the endDate always later than the startDate.  Used when endDate is changed,
 * and when startDate is selected.  Since a JS change in the field doesn't trigger the
 * onChange event, it is also called onSelect and in calendar.cfm's setDate(day) function.
 *
 * numLater		the number of days in between the two dates.
 */
function setLaterDate(endDateFieldID, numLater) {
	var formObj = $(formName);

	var startDateObj = new Date();
	var endDateObj   = new Date();
	makeDateObj(formObj.startDate.value, startDateObj);
	makeDateObj(formObj.endDate.value, endDateObj);

	// alert("numLater >> " + numLater);

	if (!datesAreValid(startDateObj, endDateObj)) {
		var gar = startDateObj.getDate() + parseInt(numLater, 10);

		endDateObj.setDate(gar);
		alert("endDateObj.setDate(gar) >> " + endDateObj.toString());
		var month = endDateObj.getMonth() + 1;
		var day = endDateObj.getDate();

		month = fmt00(month);
		day = fmt00(day);

		var theDate = month + "/" + day + "/" + endDateObj.getFullYear();
		// alert(theDate);
		$(formName).endDate.value = theDate;
	}
}


/* Makes the startDate always earlier than the endDate.  Used when endDate is changed,
 * and when startDate is selected.  Since a JS change in the field doesn't trigger the
 * onChange event, it is also called onSelect and in calendar.cfm's setDate(day) function.
 *
 * numLater		the number of days in between the two dates.
 */
function setEarlierDate(formName, numEarlier) {
	var formObj = $(formName);

	var startDateObj = new Date();
	var endDateObj   = new Date();
	makeDateObj(formObj.startDate.value, startDateObj);
	makeDateObj(formObj.endDate.value, endDateObj);

	if (!datesAreValid(startDateObj, endDateObj)) {
		var gar = endDateObj.getDate() - numEarlier;
		startDateObj.setDate(gar);
		var month = startDateObj.getMonth() + 1;
		var day = startDateObj.getDate();

		month = fmt00(month);
		day = fmt00(day);

		var theDate = month + "/" + day + "/" + startDateObj.getFullYear();
		$(formName).startDate.value = theDate;
	}
}

function go(location) {
	formObj = $('selection');
	var yearIndex = formObj.selYear.selectedIndex;
	var monthIndex = formObj.selMonth.selectedIndex;
	var year = formObj.selYear.options[yearIndex].text;
	var month = formObj.selMonth.options[monthIndex].value;
	window.location = location + ".cfm?lang=<cfoutput>#lang#</cfoutput>&month="+ month + "&year=" + year<CFIF IsDefined('url.formName') AND url.formName neq ''> + "&formName=<cfoutput>#URL.formName#</cfoutput>"</CFIF><CFIF IsDefined('url.fieldName') AND url.fieldName neq ''> + "&fieldName=<cfoutput>#URL.fieldName#</cfoutput>"</CFIF><CFIF IsDefined('url.len')> + "&len=" + <cfoutput>#url.len#</cfoutput></CFIF>;
}

/* Sets the calendar selection's default options accordding to the url variable
 */
function setCalendar() {

	var formObj = $('selection');
	//set the month
	for (var j = 0; j < formObj.selMonth.length; j++) {
	   if (formObj.selMonth.options[j].value === <CFIF IsDefined('url.month')><cfoutput>#url.month#</cfoutput><CFELSE>''</CFIF>) {
	       formObj.selMonth.options.selectedIndex = j;
		}
	}
	//set the year
    for (var i = 0; i < formObj.selYear.length; i++) {
	   if (formObj.selYear.options[i].text === <CFIF IsDefined('url.year')><cfoutput>#url.year#</cfoutput><CFELSE>''</CFIF>) {
	         formObj.selYear.options.selectedIndex = i;
		}
	}
}

/* ]]> */
</script>

