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
  dateObj.setFullYear(parseInt(tokens[2], 10));
  dateObj.setMonth(parseInt(tokens[0], 10) - 1);
  dateObj.setDate(parseInt(tokens[1], 10));
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

/* Makes the endDate always later than the startDate.  Used when endDate is changed,
 * and when startDate is selected.  Since a JS change in the field doesn't trigger the
 * onChange event, it is also called onSelect and in calendar.cfm's setDate(day) function.
 *
 * numLater   the number of days in between the two dates.
 */
function setLaterDate(formObj, numLater) {
  var startDateObj = new Date();
  var endDateObj   = new Date();
  makeDateObj($F(formObj.down('input,startDate')), startDateObj);
  makeDateObj($F(formObj.down('input.endDate')), endDateObj);

  if (!datesAreValid(startDateObj, endDateObj)) {
    var gar = startDateObj.getDate() + parseInt(numLater, 10);

    endDateObj.setDate(gar);
    var month = endDateObj.getMonth() + 1;
    var day = endDateObj.getDate();

    month = fmt00(month);
    day = fmt00(day);

    var theDate = month + "/" + day + "/" + endDateObj.getFullYear();
    formObj.down('input.endDate').value = theDate;
  }
}


/* Makes the startDate always earlier than the endDate.  Used when endDate is changed,
 * and when startDate is selected.  Since a JS change in the field doesn't trigger the
 * onChange event, it is also called onSelect and in calendar.cfm's setDate(day) function.
 *
 * numLater   the number of days in between the two dates.
 */
function setEarlierDate(formObj, numEarlier) {
  var startDateObj = new Date();
  var endDateObj   = new Date();
  makeDateObj($F(formObj.down('input.startDate')), startDateObj);
  makeDateObj($F(formObj.down('input.endDate')), endDateObj);

  if (!datesAreValid(startDateObj, endDateObj)) {
    var gar = endDateObj.getDate() - parseInt(numEarlier,10);

    startDateObj.setDate(gar);
    var month = startDateObj.getMonth() + 1;
    var day = startDateObj.getDate();

    month = fmt00(month);
    day = fmt00(day);

    var theDate = month + "/" + day + "/" + startDateObj.getFullYear();
    formObj.down('input.startDate').value = theDate;
  }
}

/* ]]> */
