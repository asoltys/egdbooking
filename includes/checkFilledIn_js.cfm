<!-- JavaScript Block Begins -->
<script type="text/javascript">
/* <![CDATA[ */
<!--
function checkFilledIn(formName) {
	var formObj = document.forms[formName];
	var blank = new Array();  // form won't have more than 20 fields... right?
	var i = 0;
	var blankAsString = '';

	if (formObj.province.value == '') {
		blank.push('<cfoutput>#JSStringFormat(language.province)#</cfoutput>');
		i++;
	}

	if (formObj.zip.value == '') {
		blank.push('<cfoutput>#JSStringFormat(language.zip)#</cfoutput>');
		i++;
	}

	if (blank.length < 1)
		return true;

	blankAsString += "\"" + blank[0] + "\"";

	// for (var j = 1; j < blank.length; j++) {
		// blankAsString += ", \"" + blank.pop() + "\"";
	// }

	var blankAsString = blank.join(', ');

	var dream = confirm('<cfoutput>#JSStringFormat(language.blankWarning)#</cfoutput> ' + blankAsString + '.  <cfoutput>#JSStringFormat(language.continueWarning)#</cfoutput>');

	if (!dream) {
		//formObj.blank[0].focus();
		return false;
	}

	return true;
	}
/* ]]> */
</script>
<!-- JavaScript Block Ends -->

