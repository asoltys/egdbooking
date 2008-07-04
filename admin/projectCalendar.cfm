<cfset language.PageTitle = "Project Calendar View">
<cfset language.ScreenMessage = '<p><b>This calendar contains information for the drydock only.</b> Bookings belonging to your company are <i>italicised</i>.</p>'

& '<p>Printing instructions:</p>'
& '<div class="critical"><p>Before you print, go to <b>Print Preview</b> and make sure that none of your tooltips are so low on the page that they get cut off.</p></div>'
& '<ul>'
& '	<li>Internet Explorer: Go to <b>Tools</b> &gt; <b>Internet Options</b> &gt; <b>Advanced</b>; make sure <i>Print background colors and images</i> under <b>Printing</b> is checked</li>'
& '	<li>Netscape Navigator, Mozilla &amp; Firefox: Go to <b>Page Setup</b>; make sure <i>Print background (colors &amp; images)</i> is checked</li>'
& '</ul>'>
<cfset language.text1 = 'from'>
<cfset language.text2 = 'to'>
<cfset language.text3 = 'docks'>

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
<!-- headER BEGINS | DEBUT DE L'EN-TETE -->
<!-- title BEGINS | DEBUT DU TITRE -->
<title>PWGSC - ESQUIMALT GRAVING DOCK - View Company Details</title>
<!-- title ENDS | FIN DU TITRE -->
<!-- metaDATA BEGINS | DEBUT DES metaDONNEES -->
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="schema.dc" href="http://purl.org/dc/elements/1.1/" />
<link rel="schema.dc" href="http://purl.org/dc/terms/" />
<meta name="dc.title" content="PWGSC - ESQUIMALT GRAVING DOCK - Project Calendar" />
<meta name="dc.subject" scheme="gccore" content="ship, wharf" />
<meta name="dc.language" scheme="ISO639-2/T" content="eng" />
<meta name="dc.creator" content="Government of Canada, Public Works and Government Services Canada" />
<meta name="dc.publisher" content="Government of Canada, Public Works and Government Services Canada" />
<meta name="dc.audience" content=" " />
<meta name="dc.contributor" content=" " />
<meta name="dc.coverage" content=" " />
<meta name="dc.format" content=" " />
<meta name="dc.identifier" content=" " />
<meta name="dc.rights" content="http://www.tpsgc-pwgsc.gc.ca/comm/ai-in-eng.html" />
<meta name="dcterms.issued" scheme="W3CDTF" content="2007-09-20" />
<meta name="dcterms.modified" scheme="W3CDTF" content="<cfoutput query="GetFile">#LSDateFormat(parseDateTime(GetFile.DateLastModified,"mm-dd-yyyy"), "yyyy-mm-dd")#</cfoutput>" />
<meta name="Description" content="Allows user to view bookings in a given range in MS Project style." />
<meta name="Keywords" content="" />
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
<script src="/clf20/scripts/pe-ap.js" type="text/javascript"></script>
<script type="text/javascript">
/* <![CDATA[ */
var params = {
			lng:"eng",
			pngfix:"/clf20/images/inv.gif"
		};
		PE.progress(params);
	/* ]]> */
</script>
<!-- PROGRESSIVE ENHANCEMENT ENDS | FIN DE L'AMELIORATION PROGRESSIVE -->
<!-- CUSTOM SCRIPTS/CSS BEGIN | DEBUT DES SCRIPTS/CSS PERSONNALISES -->
<cfoutput>
<link href="/clf20/css/base-institution.css" media="screen, print" rel="stylesheet" type="text/css" />
<link href="/clf20/css/institution.css" media="screen, print" rel="stylesheet" type="text/css" />
<style type="text/css" media="screen,print">@import url(#RootDir#css/advanced.css);</style>
<style type="text/css" media="screen,print">@import url(#RootDir#css/projectcalendar.css);</style>
</cfoutput>
<!-- CUSTOM SCRIPTS/CSS END | FIN DES SCRIPTS/CSS PERSONNALISES -->
<!-- TEMPLATE PRINT CSS BEGINS | DEBUT DU CSS DU GABARIT POUR L'IMPRESSION -->
<link href="/clf20/css/pf-if.css" rel="stylesheet" type="text/css" />
<!-- TEMPLATE PRINT CSS ENDS | FIN DU CSS DU GABARIT POUR L'IMPRESSION -->
</head>


<!--- If the FROM and TO dates are set, use them; otherwise the megaquery grabs all bookings. --->
<CFIF IsDefined("Form.startDate") AND Form.startDate neq "">
	<CFSET "CalStartDate" = Form.startDate>
</CFIF>

<CFIF IsDefined("Form.endDate") AND Form.endDate neq "">
	<CFSET "CalEndDate" = Form.endDate>
</CFIF>

<!--- Goes through the db once and gets all the bookings that fall between the dates wanted. Second query finds all maintenance blocks and labels them with the 'lol' identifier, because when a booking overlaps with a maintenance block, it is very lol. Wouldn't you agree? --->
<cfquery name="megaquery" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
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
		<CFIF isDefined("CalStartDate") AND CalStartDate neq "">AND	EndDate &gt;= <cfqueryPARAM value="#CalStartDate#" cfsqltype="cf_sql_date"></CFIF>
		<CFIF isDefined("CalEndDate") AND CalEndDate neq "">AND	StartDate &lt;= <cfqueryPARAM value="#CalEndDate#" cfsqltype="cf_sql_date"></CFIF>
	
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
		<CFIF isDefined("CalStartDate") AND CalStartDate neq "">AND	EndDate &gt;= <cfqueryPARAM value="#CalStartDate#" cfsqltype="cf_sql_date"></CFIF>
		<CFIF isDefined("CalEndDate") AND CalEndDate neq "">AND	StartDate &lt;= <cfqueryPARAM value="#CalEndDate#" cfsqltype="cf_sql_date"></CFIF>
		AND Status = 'm'
	ORDER BY	StartDate

</cfquery>

<cfquery name="hablah" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	CompanyID
	FROM	UserCompanies
	WHERE	UserID = #session.userID#
</cfquery>

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
---&gt;
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


<cfoutput query="megaquery" maxrows="1">
	<!---CFIF NOT IsDefined("CalStartDate") OR CalStartDate eq ""><CFSET CalStartDate = "#StartDate#"></CFIF>
	<CFIF NOT IsDefined("CalEndDate") OR CalEndDate eq ""><CFSET CalEndDate = "#EndDate#"></CFIF--->
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
				StructInsert(n, Evaluate("cc"), 99, true); // maintenance blocks are black
			} else {
				StructInsert(n, Evaluate("cc"), Right(Hash(VesselName), 1), true); // other blocks are coloured by the hashed names
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
</cfoutput>

<!--- Populate the structs.  If toDate is not given, then keep increasing the size of the calendar to contain all bookings. --->
<cfoutput query="megaquery">
	<CFIF (NOT IsDefined("CalEndDate") OR CalEndDate eq "")<!--- AND (#EndDate# GT #CalEndDate#) wtf is this doing here--->&gt;
		<CFSET CalEndDate = '#EndDate#'>
	</CFIF>
	
	<CFSET f = StartDate - CalStartDate + 1>
	<CFSET t = EndDate - CalStartDate + 1>
	<!---#StartDate#, #EndDate#, #VesselName#, offset: #f#, #Section1# #Section2# #Section3# <br />--->
	
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
</cfoutput>

<!--- These variables should be set by now.  If not, some code above this line has gone bad 
	and ColdFusion will throw an exception. --->
<CFPARAM name="CalStartDate" type="date">
<CFPARAM name="CalEndDate" type="date">


<CFSET #CalSize# = #CalEndDate# - #CalStartDate# + 1>

<body>
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

			<div class="screenonly">
				<cfoutput>#Language.ScreenMessage#</cfoutput>
				<div align="center"><a href="javascript:history.go(-1);" class="textbutton">Back to Date Selection</a> &nbsp;
				<a href="javascript:self.close();" class="textbutton">Close this Window</a></div>
				<br />
			</div>
	
			<cfoutput>
			
			<table cellpadding="0" cellspacing="0" width="700">
				<thead>
					<tr style="border-bottom: 1px solid ##888888; ">
					<th style="background: White; border-right: 1px solid ##888888" colspan="2">&nbsp;</th>
					<th id="1_header" axis="assignment_axis" class="sec1 confirmed" width="120" align="center">DRYDOCK 1</th>
					<th id="2_header" axis="assignment_axis" class="sec2 confirmed" width="120" align="center">DRYDOCK 2</th>
					<th id="3_header" axis="assignment_axis" class="sec3 confirmed" width="120" align="center">DRYDOCK 3</th>
					<th id="4_header" axis="assignment_axis" class="tentative" width="120">TENTATIVE</th>
					<th id="5_header" axis="assignment_axis" class="pending" width="120">PENDING</th>
				</tr></thead>
				
				<tbody>
				<!--- This loops through every day of the calendar requested and creates a new row for each one.  --->
				<CFLOOP index="offset" from="1" to="#CalSize#">
				<CFSET taday = DateAdd('d', offset - 1, CalStartDate)>
				<tr style="text-align: left;">
					<td class="<CFIF Day(taday) eq 1>firstday</CFIF>" style="border-right: 1px solid ##888888; text-align: right;">
						<CFIF Day(taday) eq 1 OR offset eq 1>
							#DateFormat(taday, "mmm")# '#DateFormat(taday, "yy")# &nbsp;
						<CFELSE>
							&nbsp;
						</CFIF>					</td>
					<td id="date#offset#_header" axis="date" class="day<CFIF DayofWeek(taday) eq 7> sat<CFELSEIF DayofWeek(taday) eq 1> sun</CFIF><CFIF Day(taday) eq 1> firstday</CFIF>" style="border-right: 1px solid ##888888; text-align: center;">
						<a href="javascript:window.opener.location.href='#RootDir#comm/detail.cfm?lang=#lang#&amp;date=#DateFormat(taday, 'm/d/yyyy')#'; void(0);">#DateFormat(taday, "d")#</a>
					</td>
			
					<!--- This part loops over the five columns of the calendar: dock 1, 2, 3, tentative, and pending.  --->
					<CFLOOP index="d" from="1" to="5">
						<CFtrY>
							<!--- If this day&section of the megaStruct exists... --->
							<CFSET nevermore = megaStruct[d][offset]>
							<CFSET tadaysDate = "#DateFormat(taday, 'yyyy')#" & "/" & "#DateFormat(taday, 'm')#" & "/" & "#DateFormat(taday, 'd')#">
							<CFSET snowflakes = ''>
							<CFSET boatCount = StructFind(nevermore, 'boatCount')>
							<CFIF StructFind(nevermore, 'firstday') eq true>
								<CFSET boatCountToday = StructFind(nevermore, 'lol')>
								<CFLOOP index="ok" from="1" to="#boatCountToday#" step="1">
									<CFIF ok neq 1>
										<CFSET snowflakes = snowflakes & '<br />'>
									</CFIF>
									<CFIF StructFind(nevermore, "isYours" & ok) eq true>
										<CFSET snowflakes = snowflakes & '<i>'>
									</CFIF>
									<cfif structfind(nevermore, "h" & ok) GTE PacificNow>
										<cfset snowflakes = snowflakes & '<b>*</b>'>
									</cfif> 
									<CFSET snowflakes = snowflakes & '<b>#StructFind(nevermore, "vesselName" & ok)#</b> <br />'>
									<CFSET snowflakes = snowflakes & '#language.text1#: #DateFormat(StructFind(nevermore, "startDate" & ok), "mm/dd/yyyy")# <br />'
										& '#language.text2#: #DateFormat(StructFind(nevermore, "endDate" & ok), "mm/dd/yyyy")# <br />'
										& '#language.text3#: #StructFind(nevermore, "allSections" & ok)# <br />'>
									<CFIF StructFind(nevermore, "isYours" & ok) eq true>
										<CFSET snowflakes = snowflakes & '</i>'>
									</CFIF>
								</CFLOOP>
							</CFIF>
							<td headers="#d#_header month#offset#_header" class="day<CFIF DayofWeek(taday) eq 7> sat<CFELSEIF DayofWeek(taday) eq 1> sun</CFIF>
											<CFIF Day(taday) eq 1> firstday</CFIF>"
									style="background: ###getColour(StructFind(nevermore, 'colourCode'))#; ">
								<CFIF StructFind(nevermore, "firstday") AND StructFind(nevermore, "firstdock") eq true>
									<!--- The first day of the booking can have custom text --->
									<!---A href="javascript:void(0)" onClick="foo(event, '#snowflakes#', '#StructFind(nevermore, "boatCount")# booking(s)');" onMouseOver="foo(event, '#StructFind(nevermore, "boatCount")# booking(s)');" onMouseOut="foo(event);">
										<div class="text">#Left(StructFind(nevermore, "vesselName" & StructFind(nevermore, "boatCount")), 10)#...</div>
									</a--->
									<div class="text">#snowflakes#</div>
								<CFELSE>
									<!---A href="javascript:void(0)" onClick="foo(event, '#snowflakes#', '#StructFind(nevermore, "boatCount")# booking(s)');" onMouseOver="foo(event, '#StructFind(nevermore, "boatCount")# booking(s)');" onMouseOut="foo(event);"--->
										<div class="text">&nbsp;<br />
										&nbsp;<br />&nbsp;<br />&nbsp;<!---CFIF StructFind(nevermore, "yours") eq true>?<CFELSE>#StructFind(nevermore, "boatCount")#</CFIF---></div>
									<!---/A--->
								</CFIF>							</td>
						<CFCATCH type="coldfusion.runtime.UndefinedElementException">
							<!--- If this day&section of the megaStruct DOESN'T exist, it throws this exception... --->
							<td headers="#d#_header month#offset#_header" class="day<CFIF DayofWeek(taday) eq 7> sat<CFELSEIF DayofWeek(taday) eq 1> sun</CFIF><CFIF Day(taday) eq 1> firstday</CFIF>">
								<div class="text">&nbsp;<br />
									&nbsp;<br />&nbsp;<br />&nbsp;</div>
						</td>
						</CFCATCH>
						</CFtrY>
					</CFLOOP>
				</tr>
			
				</CFLOOP></tbody>
			</table>
			</cfoutput>
		</div>

<CFINCLUDE template="#RootDir#includes/foot-pied-eng.cfm">
</body>
</html>