<cfif lang EQ "eng">
	<cfset language.endBeforeStartError = "End date should be no earlier than start date.">
<cfelse>
	<cfset language.endBeforeStartError = "La date de la fin de la p&eacute;riode ne peut &ecirc;tre ant&eacute;rieure &agrave; la date du d&eacute;but.">
</cfif>

<CFIF IsDefined('Variables.EndDate') AND Variables.EndDate neq "" AND IsDefined('Variables.StartDate') AND Variables.EndDate neq "">
	<CFSET Variables.BookingLen = Variables.EndDate - Variables.StartDate>
</CFIF>

<CFPARAM  name="Variables.BookingLen" default="1">

<cfoutput><script type="text/javascript" src="#RootDir#scripts/Tokenizer.js"></script></cfoutput>
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

// Validates dates inside the form.
function validate(formName) {
	var formObj = eval("document.forms[\'" + formName + "\']");
	if (!checkDate(formName)) {
		alert("<cfoutput>#language.endBeforeStartError#</cfoutput>");
		return false;
	}
	return true;
	}


/*
 * Breaks the date-String down to ints.  Takes an date object and update it with tokens.
 * Below assumption changes?  Have no fear -- just
 * edit it here!
 *
 * ASSUMES that date is in 'mm/dd/yyyy' format.
 *
 * DON'T FORGET the radix of 10 for parseInt() or it could use octal instead of decimal.
 */
function makeDObj(dateString, dObj) {
	var tempTokens = dateString.tokenize("/", " ", true);
	dObj.setFullYear(parseInt(tempTokens[2], 10));  // year
	dObj.setMonth(parseInt(tempTokens[0], 10) - 1);  // month
	dObj.setDate(parseInt(tempTokens[1], 10));  // day
}

/* checks if the start day and end day are logically right:
 * end day is no less than start day
 * return true if dates are right
 */

function checkDate(dObj1, dObj2) {
	var dateValid = true;

	if (dObj1 > dObj2) {
		dateValid = false;
	}
	return dateValid;
	}

/* Makes the endDate always later than the startDate.  Used when endDate is changed,
 * and when startDate is selected.  Since a JS change in the field doesn't trigger the
 * onChange event, it is also called onSelect and in calendar.cfm's setDate(day) function.
 *
 * where		whether it's 'self' or 'opener' since there are two types of forms
 * numLater		the number of days in between the two dates.
 */
function setLaterDate(where, formName, numLater) {
	var formObj = eval(where + ".document.forms[\'" + formName + "\']");

	var startDObj = new Date();
	var endDObj   = new Date();
	makeDObj(formObj.startDate.value, startDObj);
	makeDObj(formObj.endDate.value, endDObj);

	// alert("numLater >> " + numLater);

	if (!checkDate(startDObj, endDObj)) {
		var gar = startDObj.getDate() + parseInt(numLater, 10);
		endDObj = startDObj;
		// alert("endDObj = startDObj >> " + endDObj.toString());
		endDObj.setDate(gar);
		// alert("endDObj.setDate(gar) >> " + endDObj.toString());
		var month = endDObj.getMonth() + 1;
		var day = endDObj.getDate();

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

		var theDate = month + "/" + day + "/" + endDObj.getFullYear();
		// alert(theDate);
		eval(where + ".document." + formName + ".endDate.value=\'" + theDate + "\'");
	}
}


/* Makes the startDate always earlier than the endDate.  Used when endDate is changed,
 * and when startDate is selected.  Since a JS change in the field doesn't trigger the
 * onChange event, it is also called onSelect and in calendar.cfm's setDate(day) function.
 *
 * where		whether it's 'self' or 'opener' since there are two types of forms
 * numLater		the number of days in between the two dates.
 */
function setEarlierDate(where, formName, numEarlier) {
	var formObj = eval(where + ".document.forms[\'" + formName + "\']");

	var startDObj = new Date();
	var endDObj   = new Date();
	makeDObj(formObj.startDate.value, startDObj);
	makeDObj(formObj.endDate.value, endDObj);

	if (!checkDate(startDObj, endDObj)) {
		var gar = endDObj.getDate() - numEarlier;
		startDObj = endDObj;
		startDObj.setDate(gar);
		var month = startDObj.getMonth() + 1;
		var day = startDObj.getDate();

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

		var theDate = month + "/" + day + "/" + startDObj.getFullYear();
		eval(where + ".document." + formName + ".startDate.value=\'" + theDate + "\'");
	}
}


/* Loads the calendar window.
 */
function getCalendar(formName, fieldName) {
	var formObj = eval("document.forms[\'" + formName + "\']");

	var startDObj = new Date();
	var endDObj = new Date();
	var genDObj = new Date();
	makeDObj(formObj.startDate.value, startDObj);
	makeDObj(formObj.endDate.value, endDObj);
	if (fieldName == "booking")	makeDObj(formObj.bookingDate.value, genDObj);

	var startYear  = startDObj.getFullYear();
	var startMonth = startDObj.getMonth() + 1;
	var startDay   = startDObj.getDate();

	var endYear  = endDObj.getFullYear();
	var endMonth = endDObj.getMonth() + 1;
	var endDay   = endDObj.getDate();

	var genDate = new Array(genDObj.getFullYear(), genDObj.getMonth()+1, genDObj.getDate());

	var yearValue;
	var monthValue;
	var flag = true;
	var miniCal = '';

	//get start date
	if (fieldName == "start") {
		//check start year is valid
		// if (!isNaN(startYear)) {
			if (startMonth >= 1 && startMonth <=12) {
				yearValue = startYear;
				monthValue = startMonth;
	} else {
				yearValue = <cfoutput>#DatePart("yyyy", PacificNow)#</cfoutput>;
				monthValue = <cfoutput>#DatePart("m", PacificNow)#</cfoutput>
			}
		//} else {
			//alert ("please specify a year first");
			//flag = false;
		//}
	}

	if (fieldName == "end") {
		//if (!isNaN(endYear)) {
			if (endMonth >= 1 && endMonth <=12) {
				yearValue = endYear;
				monthValue = endMonth;
	} else {
				yearValue = <cfoutput>#DatePart("yyyy", PacificNow)#</cfoutput>;
				monthValue = <cfoutput>#DatePart("m", PacificNow)#</cfoutput>;
	}
		//} else {
			//alert ("please specify a year first");
			//flag = false;
		//}

	}

	if (fieldName == "booking") {
		if (genDate[1] >= 1 && genDate[1] <= 12) {
			yearValue = genDate[0];
			monthValue = genDate[1];
	} else {
			yearValue = <cfoutput>#DatePart("yyyy",PacificNow)#</cfoutput>;
			monthValue = <cfoutput>#DatePart("m", PacificNow)#</cfoutput>;
	}
	}

	if (flag) {
		miniCal = window.open("<cfoutput>#RootDir#</cfoutput>utils/calend.cfm?lang=<cfoutput>#lang#</cfoutput>&formName=" + formName + "&year=" + yearValue + "&month=" + monthValue + "&fieldName=" + fieldName<CFIF IsDefined('Variables.BookingLen')> + "&len=" + <cfoutput>#Variables.BookingLen#</cfoutput></CFIF>, "CalendarWindow", "left=30,top=30,width=450,height=250,resizable=yes,scrollbars=no");

		if (window.focus) {
			miniCal.focus();
	}

		return false;
	}

}



function go(location) {
	formObj = document.forms['selection'];
	var yearIndex = formObj.selYear.selectedIndex;
	var monthIndex = formObj.selMonth.selectedIndex;
	var year = formObj.selYear.options[yearIndex].text;
	var month = formObj.selMonth.options[monthIndex].value;
	window.location = location + ".cfm?lang=<cfoutput>#lang#</cfoutput>&month="+ month + "&year=" + year<CFIF IsDefined('url.formName') AND url.formName neq ''> + "&formName=<cfoutput>#URL.formName#</cfoutput>"</CFIF><CFIF IsDefined('url.fieldName') AND url.fieldName neq ''> + "&fieldName=<cfoutput>#URL.fieldName#</cfoutput>"</CFIF><CFIF IsDefined('url.len')> + "&len=" + <cfoutput>#url.len#</cfoutput></CFIF>;
	}

/* Sets the calendar selection's default options accordding to the url variable
 */
function setCalendar() {

	var formObj = document.forms['selection'];
	//set the month
	for (var j = 0; j < formObj.selMonth.length; j++) {
	   if (formObj.selMonth.options[j].value == <CFIF IsDefined('url.month')><cfoutput>#url.month#</cfoutput><CFELSE>''</CFIF>) {
	       formObj.selMonth.options.selectedIndex = j;
	}
	}
	//set the year
    for (var i = 0; i < formObj.selYear.length; i++) {
	   if (formObj.selYear.options[i].text == <CFIF IsDefined('url.year')><cfoutput>#url.year#</cfoutput><CFELSE>''</CFIF>) {
	         formObj.selYear.options.selectedIndex = i;
	}
	}
}

/* ]]> */
</script>

