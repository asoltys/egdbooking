<cfset language.PageTitle = "Project Calendar View">
<cfset language.ScreenMessage = '<P><b>This calendar contains information for the drydock only.</b> Bookings belonging to your company are <i>italicised</i>.</P>'

& '<P>Printing instructions:</P>'
& '<BLOCKQUOTE>Before you print, go to <b>Print Preview</b> and make sure that none of your tooltips are so low on the page that they get cut off.</BLOCKQUOTE>'
& '<UL>'
& '	<LI>Internet Explorer: Go to <b>Tools</b> &gt; <b>Internet Options</b> &gt; <b>Advanced</b>; make sure <i>Print background colors and images</i> under <b>Printing</b> is checked</LI>'
& '	<LI>Netscape Navigator, Mozilla &amp; Firefox: Go to <b>Page Setup</b>; make sure <i>Print background (colors &amp; images)</i> is checked</LI>'
& '</UL>'>
<cfset language.text1 = 'from'>
<cfset language.text2 = 'to'>
<cfset language.text3 = 'docks'>

<!doctype HTML public "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html lang="en">

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
	<meta name="dc.rights" lang="eng" content="<cfoutput>http://www.pwgsc.gc.ca/text/home-#lang#.html</cfoutput>/text/generic/copyright-e.html">
	<meta name="robots" content="noindex,nofollow">

	<meta name="dc.title" lang="eng" content="PWGSC - ESQUIMALT GRAVING DOCK - Project Calendar">
	<meta name="keywords" lang="eng" content="">
	<meta name="description" lang="eng" content="Allows user to view bookings in a given range in MS Project style.">
	<meta name="dc.subject" scheme="gccore" lang="eng" content="">
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

	<title>PWGSC - ESQUIMALT GRAVING DOCK - Project Calendar</title>

<!--cfinclude template="#RootDir#includes/header-#lang#.cfm"-->

<cfoutput>
	<LINK rel="stylesheet" href="#RootDir#css/default.css">
	<style type="text/css" media="screen, print">
		@import url(#RootDir#css/advanced.css);
		@import url(#RootDir#css/events.css);
		@import url(#RootDir#css/projectcalendar.css);
	</style>
</cfoutput>

<!-- Start JavaScript Block -->
<!--SCRIPT type="text/javascript" language="javascript" src="#RootDir#scripts/domLib.js"></script>
<SCRIPT type="text/javascript" language="javascript" src="#RootDir#scripts/domTT.js"></script>
<SCRIPT type="text/javascript" language="javascript" src="#RootDir#scripts/domTT_drag.js"></script>

<SCRIPT type="text/javascript" language="javascript">
var domTT_styleClass = 'domTTOverlib';

function foo(e, msg, title) {

	if (!e) var e = window.event;

	// next 5 lines taken from http://www.quirksmode.org
	var targ;
	if (e.target) targ = e.target;
	else if (e.srcElement) targ = e.srcElement;
	if (targ.nodeType == 3) // defeat Safari bug
		targ = targ.parentNode;

	//alert(e.type);

	switch(e.type) {
		case 'mouseover':
			domTT_activate(targ, e, 'trail', false, 'content', msg);
			break;
		case 'mouseout':
			domTT_mouseout(targ, e);
			break;
		case 'click':
			domTT_activate(targ, e, 'caption', title, 'content', msg, 'type', 'sticky', 'draggable', true);
			break;
	}
}

</SCRIPT-->

</HEAD>

<!--- If the FROM and TO dates are set, use them; otherwise the megaquery grabs all bookings. --->
<CFIF IsDefined("Form.startDate") AND Form.startDate neq "">
	<CFSET "CalStartDate" = Form.startDate>
</CFIF>

<CFIF IsDefined("Form.endDate") AND Form.endDate neq "">
	<CFSET "CalEndDate" = Form.endDate>
</CFIF>

<!--- Goes through the db once and gets all the bookings that fall between the dates wanted. --->
<CFQUERY name="megaquery" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Status,
			Section1, Section2, Section3,
			StartDate, EndDate,
			Bookings.VesselID,
			Vessels.Name AS VesselName, Vessels.Anonymous,
			Vessels.CompanyID,
			Bookings.EndHighlight
	FROM	Bookings
		INNER JOIN	Vessels ON Bookings.VesselID = Vessels.VesselID
		INNER JOIN	Docks ON Bookings.BookingID = Docks.BookingID
		<!---INNER JOIN	Users ON Vessels.UserID = Users.UserID--->
		INNER JOIN	Companies ON Vessels.CompanyID = Companies.CompanyID
	WHERE	Bookings.Deleted = '0'
		<CFIF isDefined("CalStartDate") AND CalStartDate neq "">AND	EndDate >= <CFQUERYPARAM value="#CalStartDate#" cfsqltype="cf_sql_date"></CFIF>
		<CFIF isDefined("CalEndDate") AND CalEndDate neq "">AND	StartDate <= <CFQUERYPARAM value="#CalEndDate#" cfsqltype="cf_sql_date"></CFIF>
	
	UNION

	SELECT 	Status,
			Section1, Section2, Section3,
			StartDate, EndDate,
			Bookings.VesselID,
			'lol' as dummy1, '0' as dummy2,
			'0' as dummy3,
			Bookings.EndHighlight
	FROM	Bookings
		INNER JOIN	Docks ON Bookings.BookingID = Docks.BookingID
		<!---INNER JOIN	Users ON Vessels.UserID = Users.UserID--->
	WHERE	Bookings.Deleted = '0'
		<CFIF isDefined("CalStartDate") AND CalStartDate neq "">AND	EndDate >= <CFQUERYPARAM value="#CalStartDate#" cfsqltype="cf_sql_date"></CFIF>
		<CFIF isDefined("CalEndDate") AND CalEndDate neq "">AND	StartDate <= <CFQUERYPARAM value="#CalEndDate#" cfsqltype="cf_sql_date"></CFIF>
		AND Status = 'm'
	ORDER BY	StartDate

</CFQUERY>

<CFQUERY name="hablah" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	CompanyID
	FROM	UserCompanies
	WHERE	UserID = #session.userID#
</CFQUERY>

<!--- Create an array-like struct for each part of the dock: docks 1, 2, 3, tentative, pending. --->
<CFSET megaStruct[1] = structnew()>
<CFSET megaStruct[2] = structnew()>
<CFSET megaStruct[3] = structnew()>
<CFSET megaStruct[4] = structnew()>
<CFSET megaStruct[5] = structnew()>

<!--- Create an array of acceptable colours for use in the calendar blocks --->
<!--- scheme 1
<CFSET accColour[1] = "7F9900">  <!--- olive green --->
<CFSET accColour[2] = "C28E00">  <!--- neutral orange --->
<CFSET accColour[3] = "026999">  <!--- neutral blue --->
<CFSET accColour[4] = "993600">  <!--- brick red --->
<CFSET accColour[5] = "1C8999">  <!--- rainy-sky blue --->
<CFSET accColour[6] = "994570">  <!--- deep pink --->
<CFSET accColour[7] = "7C1999">  <!--- normal purple --->
<CFSET accColour[8] = "CDCC93">  <!--- chalky yellow --->
<CFSET accColour[9] = "EFB60C">  <!--- solid orange --->
<CFSET accColour[10] = "E19928">  <!--- deep but bright orange --->
<CFSET accColour[11] = "C491EF">  <!--- lilac --->
<CFSET accColour[12] = "009936">  <!--- deep blue-green --->
<CFSET accColour[13] = "996060">  <!--- mauve --->
<CFSET accColour[14] = "3E3299">  <!--- navy blue --->
<CFSET accColour[15] = "00571F">  <!--- deep forest --->
<CFSET accColour[16] = "998200">  <!--- dark mustard --->
--->
<!--- scheme 2: using colour wheel, with additions from favourites of scheme 1! --->
<CFSET accColour[1] = "E6AC73">  <!--- browns --->
<CFSET accColour[2] = "886644">
<CFSET accColour[3] = "E19928">
<CFSET accColour[4] = "BF7830">
<CFSET accColour[5] = "507EA1">  <!--- blues --->
<CFSET accColour[6] = "446688">
<CFSET accColour[7] = "7EA4E6">
<CFSET accColour[8] = "3082BF">
<CFSET accColour[9] = "82458A">  <!--- purples --->
<CFSET accColour[10] = "774488">
<CFSET accColour[11] = "E68AD6">
<CFSET accColour[12] = "AE30BF">
<CFSET accColour[13] = "D7E673">  <!--- greens --->
<CFSET accColour[14] = "778844">
<CFSET accColour[15] = "3F4D22">
<CFSET accColour[16] = "ADBF30">
<CFSET accColour[99] = "000000">  <!--- maintenance colour --->


<CFOUTPUT query="megaquery" maxrows="1">
	<CFIF NOT IsDefined("CalStartDate") OR CalStartDate eq ""><CFSET CalStartDate = "#StartDate#"></CFIF>
	<CFIF NOT IsDefined("CalEndDate") OR CalEndDate eq ""><CFSET CalEndDate = "#EndDate#"></CFIF>
	<CFSCRIPT>
		// Creates a string to be printed.  This function is used to avoid a lengthy if/else block inside the CFSET for the string "snowflakes."
		function foo() {	
			var bar = '';
			if (Section1)
				bar = bar & ' 1 ';
			if (Section2)
				bar = bar & ' 2 ';
			if (Section3)
				bar = bar & ' 3 ';
			
			if (bar eq '' OR (Status neq 'c' AND Status neq 'm'))
				bar = 'unassigned';
 
			return bar;
		}
		
		function heffalump(n, firstdock, lastdock) {
			var boatCount = 1;  // number of boats in a given day
			var lol = 1;  // number of boats in a given startday
			
			// create a set of dynamic key names, to be set below using lol as the dynamic part.  These are useful when there are more than one booking on a day.
			var vn = "";  // vesselname
			var iy = "";  // isYours
			var sd = "";  // startdate
			var ed = "";  // enddate
			var as = "";  // allsections
			var hl = "";
			// var bl = "";  // bookinglength -- not used
			
			// more key names.  most are deprecated.
			var fda = "";  // firstday
			var lda = "";  // lastday
			var fdo = "";  // first dock
			var ldo = "";  // last dock
			
			
			var cc = "";  // colourCode; used to use boatCount as dynamic part
			
			if (StructKeyExists(n, "boatCount")) {
				// then this is not the first entry
				boatCount = StructFind(n, "boatCount") + 1;  // increment boatcount
			}
			StructInsert(n, "boatCount", boatCount, true);
			
			// give these dynamic keys some meaning
			fda = "firstday";
			lda = "lastday";
			fdo = "firstdock";
			ldo = "lastdock";
			

			cc = "colourCode";
			if (Status eq 'm') {
				StructInsert(n, Evaluate("cc"), 99, true);
			} else {
				StructInsert(n, Evaluate("cc"), Right(Hash(VesselName), 1), true);
			}

			if (i eq f or i eq 1) {
				if (StructKeyExists(n, "lol")) {
					// if this is the first day of the booking
					lol = StructFind(n, "lol") + 1;  // increment startday boatcount
				}
				
				StructInsert(n, "lol", lol, true);
				
				// more dynamic keys
				vn = "vesselName" & lol;
				iy = "isYours" & lol;
				sd = "startDate" & lol;
				ed = "endDate" & lol;
				as = "allSections" & lol;
				hl = "h" & lol;
				// bl = "bookingLength" & #boatCount#;

				StructInsert(n, Evaluate("fda"), true, true);
				
				if (Status eq 'm') {
					StructInsert(n, Evaluate("vn"), "Maintenance Block", false);
				} else {
					StructInsert(n, Evaluate("vn"), VesselName, false);
				}
				
				StructInsert(n, evaluate("hl"), endhighlight, false);
				StructInsert(n, Evaluate("sd"), StartDate, false);
				StructInsert(n, Evaluate("ed"), EndDate, false);
				StructInsert(n, Evaluate("as"), foo(), false);
				// StructInsert(n, Evaluate("bl"), t - f + 1, true);

				if (CompanyID eq hablah.CompanyID)
					// mark the entry as belonging to the user
					StructInsert(n, Evaluate("iy"), true, true);
				else
					StructInsert(n, Evaluate("iy"), false, true);
			} else {
				StructInsert(n, Evaluate("fda"), false, true);
			}
			
			if (i eq #t#) {
				// i is the last day of the booking
				StructInsert(n, Evaluate("lda"), true, true);
			} else {
				StructInsert(n, Evaluate("lda"), false, true);
			}
				
			// first dock in the booking
			StructInsert(n, Evaluate("fdo"), firstdock, true);
			// last dock in the booking
			StructInsert(n, Evaluate("ldo"), lastdock, true);
		}
		
		function getColour(num) {
			// var num = Left(Hash(name), 1);
			switch(num) {
				case 'A':
					num = 10;
					break;
				case 'B':
					num = 11;
					break;
				case 'C':
					num = 12;
					break;
				case 'D':
					num = 13;
					break;
				case 'E':
					num = 14;
					break;
				case 'F':
					num = 15;
					break;
				case '0':
					num = 16;
					break;
				default:
					break;
			}
			return accColour[num];
		}
	</CFSCRIPT>
</CFOUTPUT>

<!--- Populate the structs.  If toDate is not given, then keep increasing the size of the calendar to contain all bookings. --->
<CFOUTPUT query="megaquery">
	<CFIF (NOT IsDefined("CalEndDate") OR CalEndDate eq "") AND (#EndDate# GT #CalEndDate#)>
		<CFSET CalEndDate = '#EndDate#'>
	</CFIF>
	
	<CFSET f = StartDate - CalStartDate + 1>
	<CFSET t = EndDate - CalStartDate + 1>
	<!---#StartDate#, #EndDate#, #VesselName#, offset: #f#, #Section1# #Section2# #Section3# <BR>--->
	
	<CFIF Status eq 'c' OR Status eq 'm'>  <!--- confirmed or maintenance --->
		<CFIF Section1>
			<CFSET d = 1>
			<CFSET fdo = true>
			<CFIF Section2><CFSET ldo = false><CFELSE><CFSET ldo = true></CFIF>
			<CFLOOP index="i" from="#f#" to="#t#">
				<!--- I KNEW making it a giant struct would become useful! --->
				<CFIF NOT StructKeyExists(megaStruct[d], i)>
					<CFSET megaStruct[d][i] = StructNew()>
				</CFIF>
				<CFSET nevermore = megaStruct[d][i]>
				<CFSET heffalump(nevermore, fdo, ldo)>
			</CFLOOP>
		</CFIF>
		
		<CFIF Section2>
			<CFSET d = 2>
			<CFIF Section1><CFSET fdo = false><CFELSE><CFSET fdo = true></CFIF>
			<CFIF Section3><CFSET ldo = false><CFELSE><CFSET ldo = true></CFIF>
			<CFLOOP index="i" from="#f#" to="#t#">
				<CFIF NOT StructKeyExists(megaStruct[d], i)>
					<CFSET megaStruct[d][i] = StructNew()>
				</CFIF>
				<CFSET nevermore = megaStruct[d][i]>
				<CFSET heffalump(nevermore, fdo, ldo)>
			</CFLOOP>		
		</CFIF>
		
		<CFIF Section3>
			<CFIF Section2><CFSET fdo = false><CFELSE><CFSET fdo = true></CFIF>
			<CFSET ldo = true>
			<CFSET d = 3>
			<CFLOOP index="i" from="#f#" to="#t#">
				<CFIF NOT StructKeyExists(megaStruct[d], i)>
					<CFSET megaStruct[d][i] = StructNew()>
				</CFIF>
				<CFSET nevermore = megaStruct[d][i]>
				<CFSET heffalump(nevermore, fdo, ldo)>
			</CFLOOP>
		</CFIF>

	<CFELSEIF Status eq 't'>  <!--- tentative --->
		<CFSET d = 4>
		<CFLOOP index="i" from="#f#" to="#t#">
			<CFIF NOT StructKeyExists(megaStruct[d], i)>
				<CFSET megaStruct[d][i] = StructNew()>
			</CFIF>
			<CFSET nevermore = megaStruct[d][i]>
			<CFSET heffalump(nevermore, true, true)>
		</CFLOOP>

	<CFELSEIF Status eq 'p'>  <!--- pending --->
		<CFSET d = 5>
		<CFLOOP index="i" from="#f#" to="#t#">
			<CFIF NOT StructKeyExists(megaStruct[d], i)>
				<CFSET megaStruct[d][i] = StructNew()>
			</CFIF>
			<CFSET nevermore = megaStruct[d][i]>
			<CFSET heffalump(nevermore, true, true)>
		</CFLOOP>

	<CFELSE>  <!--- unknown character --->
		
	</CFIF>
</CFOUTPUT>

<!--- These variables should be set by now.  If not, some code above this line has gone bad 
	and ColdFusion will throw an exception. --->
<CFPARAM name="CalStartDate" type="date">
<CFPARAM name="CalEndDate" type="date">

<CFSET #CalSize# = #CalEndDate# - #CalStartDate# + 1>

<BODY bgcolor="#FFFFFF">

<!---CFDUMP var="#megastruct#"--->

<!--begin clf fip-e.html--> 
<table width="700" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="4"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="1" height="10" alt=""></td>
	</tr>
	<tr> 
		<td><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="10" height="1" alt=""></td>
		<td align="left" valign="top"><img src="<cfoutput>#RootDir#</cfoutput>images/pwgsc-e.gif" width="364" height="33" alt="Public Works and Government Services Canada" title="Public Works and Government Services Canada" border="0"></td>
		<td align="right" valign="top"><img src="<cfoutput>#RootDir#</cfoutput>images/wordmark.gif" width="83" height="21" alt="Canada wordmark" border="0" align="top"></td>
		<td><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="10" height="1" alt=""></td>
	</tr>
</table>
<!--end clf fip-e.html-->

<H1 style="padding-left: 10px; "><cfoutput>#Language.PageTitle#</cfoutput></H1>

<DIV class="screenonly" style="width: 700px; padding-left: 10px; ">
	<CFOUTPUT>#Language.ScreenMessage#</CFOUTPUT>
	<p align="center"><A href="javascript:history.go(-1);" class="textbutton">Back to Date Selection</A> &nbsp;
	<A href="javascript:self.close();" class="textbutton">Close this Window</A></p>
</DIV>



<CFOUTPUT>

<TABLE cellpadding="0" cellspacing="0" width="700" style="font-size: 10pt; ">
	<THEAD><TR style="border-bottom: 1px solid ##888888; ">
		<TH style="background: White; border-right: 1px solid ##888888" colspan="2">&nbsp;</TH>
		<TH id="1_header" axis="assignment_axis" class="sec1 confirmed" width="120" align="center">DRYDOCK 1</TH>
		<TH id="2_header" axis="assignment_axis" class="sec2 confirmed" width="120" align="center">DRYDOCK 2</TH>
		<TH id="3_header" axis="assignment_axis" class="sec3 confirmed" width="120" align="center">DRYDOCK 3</TH>
		<TH id="4_header" axis="assignment_axis" class="tentative" width="120">TENTATIVE</TH>
		<TH id="5_header" axis="assignment_axis" class="pending" width="120">PENDING</TH>
	</TR></THEAD>
	
	<TBODY>
	<!--- This loops through every day of the calendar requested and creates a new row for each one.  --->
	<CFLOOP index="offset" from="1" to="#CalSize#">
	<CFSET taday = DateAdd('d', offset - 1, CalStartDate)>
	<TR style="text-align: left;">
		<TD class="<CFIF Day(taday) eq 1>firstday</CFIF>" style="border-right: 1px solid ##888888; text-align: right;">
			<CFIF Day(taday) eq 1 OR offset eq 1>
				#DateFormat(taday, "mmm")# '#DateFormat(taday, "yy")# &nbsp;
			<CFELSE>
				&nbsp;
			</CFIF>
		</TD>
		<TD id="date#offset#_header" axis="date" class="day<CFIF DayofWeek(taday) eq 7> sat<CFELSEIF DayofWeek(taday) eq 1> sun</CFIF><CFIF Day(taday) eq 1> firstday</CFIF>" style="border-right: 1px solid ##888888; text-align: center;">
			<A href="javascript:window.opener.location.href='#RootDir#text/common/getDetail.cfm?lang=#lang#&date=#DateFormat(taday, 'm/d/yyyy')#'; void(0);">#DateFormat(taday, "d")#</A>
		</TD>

		<!--- This part loops over the five columns of the calendar: dock 1, 2, 3, tentative, and pending.  --->
		<CFLOOP index="d" from="1" to="5">
			<CFTRY>
				<!--- If this day&section of the megaStruct exists... --->
				<CFSET nevermore = megaStruct[d][offset]>
				<CFSET tadaysDate = "#DateFormat(taday, 'yyyy')#" & "/" & "#DateFormat(taday, 'm')#" & "/" & "#DateFormat(taday, 'd')#">
				<CFSET snowflakes = ''>
				<CFSET boatCount = StructFind(nevermore, 'boatCount')>
				<CFIF StructFind(nevermore, 'firstday') eq true>
					<CFSET boatCountToday = StructFind(nevermore, 'lol')>
					<CFLOOP index="ok" from="1" to="#boatCountToday#" step="1">
						<CFIF ok neq 1>
							<CFSET snowflakes = snowflakes & '<BR>'>
						</CFIF>
						<CFIF StructFind(nevermore, "isYours" & ok) eq true>
							<CFSET snowflakes = snowflakes & '<i>'>
						</CFIF>
						<cfif structfind(nevermore, "h" & ok) GTE PacificNow>
							<cfset snowflakes = snowflakes & '<b>*</b>'>
						</cfif> 
						<CFSET snowflakes = snowflakes & '<b>#StructFind(nevermore, "vesselName" & ok)#</b> <BR>'>
						<CFSET snowflakes = snowflakes & '#language.text1#: #DateFormat(StructFind(nevermore, "startDate" & ok), "mm/dd/yyyy")# <BR>'
							& '#language.text2#: #DateFormat(StructFind(nevermore, "endDate" & ok), "mm/dd/yyyy")# <BR>'
							& '#language.text3#: #StructFind(nevermore, "allSections" & ok)# <BR>'>
						<CFIF StructFind(nevermore, "isYours" & ok) eq true>
							<CFSET snowflakes = snowflakes & '</i>'>
						</CFIF>
					</CFLOOP>
				</CFIF>
				<TD headers="#d#_header month#offset#_header" class="day<CFIF DayofWeek(taday) eq 7> sat<CFELSEIF DayofWeek(taday) eq 1> sun</CFIF>
								<CFIF Day(taday) eq 1> firstday</CFIF>"
						style="background: ###getColour(StructFind(nevermore, 'colourCode'))#; ">
					<CFIF StructFind(nevermore, "firstday") AND StructFind(nevermore, "firstdock") eq true>
						<!--- The first day of the booking can have custom text --->
						<!---A href="javascript:void(0)" onClick="foo(event, '#snowflakes#', '#StructFind(nevermore, "boatCount")# booking(s)');" onMouseOver="foo(event, '#StructFind(nevermore, "boatCount")# booking(s)');" onMouseOut="foo(event);">
							<DIV class="text">#Left(StructFind(nevermore, "vesselName" & StructFind(nevermore, "boatCount")), 10)#...</DIV>
						</A--->
						<DIV class="text">#snowflakes#</DIV>
					<CFELSE>
						<!---A href="javascript:void(0)" onClick="foo(event, '#snowflakes#', '#StructFind(nevermore, "boatCount")# booking(s)');" onMouseOver="foo(event, '#StructFind(nevermore, "boatCount")# booking(s)');" onMouseOut="foo(event);"--->
							<DIV class="text">&nbsp;<BR>&nbsp;<BR>&nbsp;<BR>&nbsp;<!---CFIF StructFind(nevermore, "yours") eq true>?<CFELSE>#StructFind(nevermore, "boatCount")#</CFIF---></DIV>
						<!---/A--->
					</CFIF>
				</TD>
			<CFCATCH type="coldfusion.runtime.UndefinedElementException">
				<!--- If this day&section of the megaStruct DOESN'T exist, it throws this exception... --->
				<TD headers="#d#_header month#offset#_header" class="day<CFIF DayofWeek(taday) eq 7> sat<CFELSEIF DayofWeek(taday) eq 1> sun</CFIF><CFIF Day(taday) eq 1> firstday</CFIF>">
					<DIV class="text">&nbsp;<BR>&nbsp;<BR>&nbsp;<BR>&nbsp;</DIV>
			</CFCATCH>
			</CFTRY>
		</CFLOOP>

	</TR>

	</CFLOOP></TBODY>
</TABLE>

</CFOUTPUT>

<BR><BR>

<!--BEGIN FOOTER-->
<table width="700" border="0" cellspacing="0" cellpadding="0">
<TR>
	<TD width="10"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="10" height="1" alt=""></TD>
	<TD colspan="2" width="680"><hr noshade size="1" width="100%"></TD>
	<TD width="10"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="10" height="1" alt=""></TD>	
</TR>
<tr>
	<td>&nbsp;</td>
	<td align="left" class="footertext" colspan="2">
		Maintained by <a href="<cfoutput>#RootDir#</cfoutput>text/contact_us-e.cfm">PWGSC</a></div> <!--- This option is recommended. --->
	</td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td align="left" class="footertext">
		<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,"\")>
		<cfset PageDir = listDeleteAt(cgi.CF_TEMPLATE_PATH, listLen(cgi.CF_TEMPLATE_PATH,"\"), "\")>
		<cfdirectory action="LIST" directory="#PageDir#" name="GetFile" filter="#PageFileName#">
		<cfif #GetFile.recordcount# is 1>Last Updated:
		<cfoutput query="GetFile">
			#LSDateFormat(parseDateTime(GetFile.DateLastModified,"mm-dd-yyyy"), "yyyy-mm-dd")# 
			<!---#TimeFormat(parseDateTime(GetFile.DateLastModified, "h:mm tt"))#--->
		</cfoutput>
		</cfif>
	</td>
	<td align="right" class="footertext">
		<cfoutput>
		<span lang="en"><a href="http://www.pwgsc.gc.ca/text/generic/copyright-e.html">Important Notices</a></span>
		</cfoutput>
	</td>
	<td><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="10" height="1" alt=""></td>
</tr>
<tr>
	<td colspan="4"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="1" height="10" alt=""></td>
</tr>
</table>
<!--END FOOTER-->

</BODY>
</HTML>