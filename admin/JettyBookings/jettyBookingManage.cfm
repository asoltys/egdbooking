<!---clear form structure--->
<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""pwgsc - esquimalt graving dock - Jetty Booking Management"">
	<meta name=""keywords"" lang=""eng"" content="""">
	<meta name=""description"" lang=""eng"" content="""">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Jetty Booking Management</title>
	<style type=""text/css"" media=""screen,print"">@import url(#RootDir#css/events.css);</style>
	">

<cfinclude template="#RootDir#includes/calendar_js.cfm">

<!--checking if enddate is defined instead of showConf is not a mistake!-->
<cfif IsDefined("form.EndDate")>
	<cfif IsDefined("form.show")>
		<cfset url.show = #form.show#>
	</cfif>
</cfif>

<cfif IsDefined("url.startDate") and IsDate(URLDecode(url.startDate))>
	<!---CFOUTPUT>#url.startDate#</CFOUTPUT--->
	<cfset form.startDate = url.startDate>
	<cfset Variables.startDate = url.startDate>
</cfif>
<cfif IsDefined("url.endDate") and IsDate(URLDecode(url.endDate))>
	<!---CFOUTPUT>#url.endDate#</CFOUTPUT--->
	<cfset form.endDate = url.endDate>
	<cfset Variables.endDate = url.endDate>
<cfelse>
	<!---added to default to max enddate so all bookings are shown--->
	<cfset form.endDate = "12/31/2031">
</cfif>

<cfparam name="form.startDate" default="#DateFormat(PacificNow, 'mm/dd/yyyy')#">
<cfparam name="form.endDate" default="#DateFormat(DateAdd('d', 30, PacificNow), 'mm/dd/yyyy')#">
<cfparam name="Variables.startDate" default="#form.startDate#">
<cfparam name="Variables.endDate" default="#form.endDate#">
<cfparam name="form.show" default="c,t,p">
<cfparam name="url.show" default="#form.show#">
<cfparam name="Variables.show" default="#url.show#">

<!---North Jetty Status--->
<cfquery name="countPendingNJ" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT count(*) as numPendNJ
		FROM Jetties, Bookings
		WHERE (
				(Bookings.StartDate = '#dateformat(variables.startDate, "mm/dd/yyyy")#' AND Bookings.EndDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#')
				OR	(Bookings.startDate <= '#dateformat(variables.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate >= '#dateformat(variables.endDate, "mm/dd/yyyy")#') 
				OR	(Bookings.startDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#'	AND Bookings.endDate >= '#dateformat(variables.endDate, "mm/dd/yyyy")#') 				
				OR 	(Bookings.endDate >= '#dateformat(variables.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#')	
			)
		AND Jetties.BookingID = Bookings.BookingID AND (Status = 'P' OR Status = 'X' OR Status = 'Y') AND NorthJetty = '1' AND Bookings.Deleted = 0
</cfquery>
<cfquery name="countConfirmedNJ" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT count(*) as numConfNJ
		FROM Jetties, Bookings
		WHERE (
				(Bookings.StartDate = '#dateformat(variables.startDate, "mm/dd/yyyy")#' AND Bookings.EndDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#')
				OR	(Bookings.startDate <= '#dateformat(variables.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate >= '#dateformat(variables.endDate, "mm/dd/yyyy")#') 
				OR	(Bookings.startDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#'	AND Bookings.endDate >= '#dateformat(variables.endDate, "mm/dd/yyyy")#') 				
				OR 	(Bookings.endDate >= '#dateformat(variables.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#')	
			)
		AND Jetties.BookingID = Bookings.BookingID AND Status = 'C' AND NorthJetty = '1' AND Bookings.Deleted = 0
</cfquery>
<cfquery name="countTentativeNJ" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT count(*) as numTentNJ
		FROM Jetties, Bookings
		WHERE (
				(Bookings.StartDate = '#dateformat(variables.startDate, "mm/dd/yyyy")#' AND Bookings.EndDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#')
				OR	(Bookings.startDate <= '#dateformat(variables.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate >= '#dateformat(variables.endDate, "mm/dd/yyyy")#') 
				OR	(Bookings.startDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#'	AND Bookings.endDate >= '#dateformat(variables.endDate, "mm/dd/yyyy")#') 				
				OR 	(Bookings.endDate >= '#dateformat(variables.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#')	
			)
		AND Jetties.BookingID = Bookings.BookingID AND Status = 'T' AND NorthJetty = '1' AND Bookings.Deleted = 0
					<!--- Eliminates any Tentative bookings with a start date before today --->
			AND ((Jetties.status <> 'T') OR (Jetties.status = 'T' AND Bookings.startDate >= #PacificNow#))
</cfquery>
<!---South Jetty Status--->
<cfquery name="countPendingSJ" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT count(*) as numPendSJ
		FROM Jetties, Bookings
		WHERE (
				(Bookings.StartDate = '#dateformat(variables.startDate, "mm/dd/yyyy")#' AND Bookings.EndDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#')
				OR	(Bookings.startDate <= '#dateformat(variables.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate >= '#dateformat(variables.endDate, "mm/dd/yyyy")#') 
				OR	(Bookings.startDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#'	AND Bookings.endDate >= '#dateformat(variables.endDate, "mm/dd/yyyy")#') 				
				OR 	(Bookings.endDate >= '#dateformat(variables.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#')	
			)
		AND Jetties.BookingID = Bookings.BookingID AND (Status = 'P' OR Status = 'X' OR Status = 'Y') AND SouthJetty = '1' AND Bookings.Deleted = 0 
		
</cfquery>
<cfquery name="countConfirmedSJ" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT count(*) as numConfSJ
		FROM Jetties, Bookings
		WHERE (
				(Bookings.StartDate = '#dateformat(variables.startDate, "mm/dd/yyyy")#' AND Bookings.EndDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#')
				OR	(Bookings.startDate <= '#dateformat(variables.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate >= '#dateformat(variables.endDate, "mm/dd/yyyy")#') 
				OR	(Bookings.startDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#'	AND Bookings.endDate >= '#dateformat(variables.endDate, "mm/dd/yyyy")#') 				
				OR 	(Bookings.endDate >= '#dateformat(variables.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#')	
			)
		AND Jetties.BookingID = Bookings.BookingID AND Status = 'C' AND SouthJetty = '1' AND Bookings.Deleted = 0
</cfquery>
<cfquery name="countTentativeSJ" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT count(*) as numTentSJ
		FROM Jetties, Bookings
		WHERE (
				(Bookings.StartDate = '#dateformat(variables.startDate, "mm/dd/yyyy")#' AND Bookings.EndDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#')
				OR	(Bookings.startDate <= '#dateformat(variables.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate >= '#dateformat(variables.endDate, "mm/dd/yyyy")#') 
				OR	(Bookings.startDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#'	AND Bookings.endDate >= '#dateformat(variables.endDate, "mm/dd/yyyy")#') 				
				OR 	(Bookings.endDate >= '#dateformat(variables.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#')	
			)
		AND Jetties.BookingID = Bookings.BookingID AND Status = 'T' AND SouthJetty = '1' AND Bookings.Deleted = 0
					<!--- Eliminates any Tentative bookings with a start date before today --->
			AND ((Jetties.status <> 'T') OR (Jetties.status = 'T' AND Bookings.startDate >= #PacificNow#))
</cfquery>
<cfset showPend = false>
<cfset showTent = false>
<cfset showConf = false>

<cfscript>
	if (REFindNoCase('p', url.show) neq 0) {
		// wants to show pending bookings
		showPend = true;
	}
	if (REFindNoCase('t', url.show) neq 0) {
		// wants to show tentative bookings
		showTent = true;
	}
	if (REFindNoCase('c', url.show) neq 0) {
		// wants to show confirmed bookings
		showConf = true;
	}
</cfscript>

<!-- Start JavaScript Block -->
<script language="JavaScript" type="text/javascript">
	<!--
	function EditSubmit ( selectedform )
	{
	  document.forms[selectedform].submit() ;
	}
	//-->
</script>
<!-- End JavaScript Block -->

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>
			<cfif IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt; 
			<cfelse>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</cfif>
			Jetty Booking Management
			</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Jetty Booking Management
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<cfinclude template="#RootDir#includes/admin_menu.cfm"><br />
				
				<P>Please enter a range of dates for which you would like to see the bookings:</p>
				<form action="jettyBookingManage.cfm?lang=<cfoutput>#lang#</cfoutput>" method="get" name="dateSelect">
					<input type="hidden" name="lang" value="<cfoutput>#lang#</cfoutput>">
					<table align="center" style="width: 100%;">
						<tr>
							<td id="Startdate">
								<label for="start">Start Date:</label>							</td>
							<td headers="Startdate" colspan="2">
								<cfoutput>
								<!---input class="textField" type="Text" name="startDateShow" id="start" disabled value="#DateFormat(startDate, 'mmm d, yyyy')#" size="17"--->
								<input type="text" name="startDate" size="15" maxlength="10" value="#DateFormat(variables.startDate, 'mm/dd/yyyy')#" class="textField" onchange="setLaterDate('self', 'dateSelect', #Variables.bookingLen#)" onfocus="setEarlierDate('self', 'dateSelect', #Variables.bookingLen#)"> <font class="light">#language.dateform#</font></cfoutput>
								<a href="javascript:void(0);" onclick="javascript:getCalendar('dateSelect', 'start')" class="textbutton">calendar</a>
								<!---a href="javascript:void(0);" onClick="javascript:document.dateSelect.startDateShow.value=''; document.dateSelect.startDate.value='';" class="textbutton">clear</a--->							</td>
						</tr>
						<tr>
							<td id="Enddate">
								<label for="end">End Date:</label>							</td>
							<td headers="Enddate" colspan="2">
								<cfoutput>
								<!---input type="text" name="endDateShow" id="end" class="textField" disabled value="#DateFormat(endDate, 'mmm d, yyyy')#" size="17"--->
								<input type="text" name="endDate" size="15" maxlength="10" value="#DateFormat(variables.endDate, 'mm/dd/yyyy')#" class="textField" onchange="setEarlierDate('self', 'dateSelect', #Variables.bookingLen#)" onfocus="setLaterDate('self', 'dateSelect', #Variables.bookingLen#)"> <font class="light">#language.dateform#</font></cfoutput>
								<a href="javascript:void(0);" onclick="javascript:getCalendar('dateSelect', 'end')" class="textbutton">calendar</a>
								<!---a href="javascript:void(0);" onClick="javascript:document.dateSelect.endDateShow.value=''; document.dateSelect.endDate.value='';" class="textbutton">clear</a--->							</td>
						</tr>
						<tr>
							<td>Show only:</td>	
							<td headers="Pending" align="right" width="15%"><input type="checkbox" name="show" value="p" id="showPend"<cfif showPend EQ true> checked="true"</cfif>></td>
							<td id="Pending" align="left"><label for="showPend" class="pending">Pending</label></td>	
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td headers="Tentative" align="right"><input type="checkbox" id="showTent" name="show" value="t"<cfif showTent eq true> checked</cfif>></td>
							<td id="Tentative" align="left"><label for="showTent" class="tentative">Tentative</label></td>
						</tr>
				
						<tr>
							<td>&nbsp;</td>
							<td headers="Confirmed" align="right"><input type="checkbox" name="show" value="c" id="showConf" <cfif showConf EQ true>checked="true"</cfif>></td>
							<td id="Confirmed" align="left"><label for="showConf" class="confirmed">Confirmed</label></td>
						</tr>
						<tr>
							<td colspan="3" align="right"><input type="submit" value="Submit" class="textbutton"></td>
						</tr>
					</table>
					
				</form>
				
				
				<cfif variables.startDate NEQ "" and variables.endDate NEQ "">
					<cfif isDate(form.startDate)>
						<cfset proceed = "yes">
					</cfif>
				</cfif>
				
				<cfif isdefined('proceed') and proceed EQ "yes">
					
					<cfoutput>
						<cfparam name="form.expandAll" default="">
						<form action="jettyBookingManage.cfm?#urltoken#" method="post" name="expandAll">
							<input type="hidden" name="startDate" value="#variables.startDate#">
							<input type="hidden" name="endDate" value="#variables.endDate#">
							<cfif form.expandAll NEQ "yes">
								<input type="hidden" name="expandAll" value="yes">
							<cfelse>
								<input type="hidden" name="expandAll" value="no">
							</cfif>
							<input type="hidden" name="show" value="#url.show#">
						</form>
					</cfoutput>
				
					<br />
					<table width="100%" cellspacing="0" cellpadding="0" style="padding-bottom: 5px; ">
						<tr>
							<cfoutput><td align="left" width="80%"><div style="height:0;">&nbsp;</div><a href="addJettyBooking.cfm?#urltoken#" class="textbutton">Add New South Jetty / North Landing Wharf Booking</a></td></cfoutput>
							<td>&nbsp;</td><td>&nbsp;</td>
							<cfif form.expandAll NEQ "yes">
								<td align="right" width="20%"><div style="height:0;">&nbsp;</div><a href="javascript:EditSubmit('expandAll');">Expand All</a></td>
							<cfelse>
								<td align="right" width="20%"><div style="height:0;">&nbsp;</div><a href="javascript:EditSubmit('expandAll');">Collapse All</a></td>
							</cfif>
						</tr>
					</table>
				
					
				<cfloop index="jetty" from="1" to="2" step="1">	
					<!---<div align="left"><a href="#RootDir#admin/JettyBookings/addJettybooking.cfm?lang=#lang#" class="textbutton">Add New Jetty Booking</a></div>
					<div align="right"><a href="javascript:EditSubmit('expandAll');">Expand All</a></div>--->			
					<cfquery name="getBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT Bookings.*, Vessels.Name AS VesselName, Vessels.EndHighlight AS EndHighlight, Jetties.*
						FROM Jetties INNER JOIN Bookings ON Jetties.BookingID = Bookings.BookingID
								INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID
						WHERE ((Bookings.startDate >= '#dateformat(variables.startDate, "mm/dd/yyyy")#'
								AND Bookings.startDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#') 
							OR (Bookings.startDate <= '#dateformat(variables.startDate, "mm/dd/yyyy")#'
								AND Bookings.endDate >= '#dateformat(variables.endDate, "mm/dd/yyyy")#') 
							OR (Bookings.endDate >= '#dateformat(variables.startDate, "mm/dd/yyyy")#'
								AND Bookings.endDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#')) 
							AND Bookings.Deleted = 0
							<!--- Eliminates any Tentative bookings with a start date before today --->
							AND (((Jetties.status <> 'T') OR (Jetties.status = 'T' AND Bookings.startDate >= #dateformat(PacificNow, "mm/dd/yyyy")#))
							<cfif variables.showPend EQ true AND variables.showTent EQ false AND variables.showConf EQ false>
								AND Jetties.Status = 'P' OR Jetties.Status = 'X' OR Jetties.Status = 'Y'
							</cfif>
							<cfif variables.showTent EQ true AND variables.showPend EQ false AND variables.showConf EQ false>
								AND Jetties.Status = 'T'
							</cfif>
							<cfif variables.showConf EQ true AND variables.showPend EQ false AND variables.showTent EQ false>
								AND Jetties.Status = 'C'
							</cfif>	
							<cfif variables.showPend EQ true AND variables.showTent EQ true AND variables.showConf EQ false>
								AND ((Jetties.Status = 'P' OR Jetties.Status = 'X' OR Jetties.Status = 'Y') OR (Jetties.Status = 'T'))
							</cfif>	
							<cfif variables.showPend EQ true AND variables.showTent EQ false AND variables.showConf EQ true>
								AND ((Jetties.Status = 'C') OR (Jetties.Status = 'P' OR Jetties.Status = 'X' OR Jetties.Status = 'Y'))
							</cfif>	
							<cfif variables.showPend EQ false AND variables.showTent EQ true AND variables.showConf EQ true>
								AND ((Jetties.Status = 'C') OR (Jetties.Status = 'T'))
							</cfif>	
						<cfif jetty EQ 1>
							AND Jetties.NorthJetty = '1'
						<cfelseif jetty EQ 2>
							AND Jetties.SouthJetty = '1'
						</cfif>)
						ORDER BY Bookings.startDate, Bookings.endDate, Vessels.Name
					</cfquery>
					<cfif getBookings.recordCount GT 0>
						<cfoutput query="getBookings">
							<cfset Variables.id = #BookingID#>
							<form name="booking#id#" action="jettyBookingManage.cfm?#urltoken####id#" method="post">
								<input type="hidden" name="startDate" value="#DateFormat(variables.startDate, 'mm/dd/yyyy')#">
								<input type="hidden" name="endDate" value="#DateFormat(variables.endDate, 'mm/dd/yyyy')#">
								<cfif (isDefined("form.ID") AND form.ID EQ #id#) OR (isDefined('url.bookingid') AND url.bookingid EQ id)>
									<input type="hidden" name="ID" value="0">
								<cfelse>
									<input type="hidden" name="ID" value="#id#">
								</cfif>
							</form>
						</cfoutput>
					</cfif>
					
					<cfif jetty EQ 1>
						<H2>North Landing Wharf</H2>
						<P align="center"><b>Total:&nbsp;&nbsp;</b>
							<cfoutput>
							<i class="pending">Pending - #countPendingNJ.numPendNJ#</i>&nbsp;&nbsp;
							<i class="tentative">Tentative - #countTentativeNJ.numTentNJ#</i>&nbsp;&nbsp;
							<i class="confirmed">Confirmed - #countConfirmedNJ.numConfNJ#</i>&nbsp;&nbsp;
							</cfoutput>
						</P>
					<cfelseif jetty EQ 2>
						<HR />
						<H2>South Jetty</H2>
						<P align="center"><b>Total:&nbsp;&nbsp;</b>
							<cfoutput>
							<i class="pending">Pending - #countPendingSJ.numPendSJ#</i>&nbsp;&nbsp;
							<i class="tentative">Tentative - #countTentativeSJ.numTentSJ#</i>&nbsp;&nbsp;
							<i class="confirmed">Confirmed - #countConfirmedSJ.numConfSJ#</i>&nbsp;&nbsp;
							</cfoutput>
						</P>
					</cfif>
										
					<table class="calendar" cellpadding="3" cellspacing="0" width="100%">
						<tr>
							<th id="Start" class="calendar" style="width: 20%; ">Start Date</th>
							<th id="End" class="calendar" style="width: 20%; ">End Date</th>
							<th id="Vessel" class="calendar" style="width: 45%; ">Vessel Name</th>
							<th id="Status" class="calendar" style="width: 15%; ">Status</th>
						</tr>
						
					<cfif getBookings.recordCount GT 0><cfoutput query="getBookings">
						<cfset Variables.id = #BookingID#>
						<tr>
							<td headers="Start" class="calendar" nowrap>#LSdateformat(startDate, 'mmm d, yyyy')#</td>
							<td headers="End" class="calendar" nowrap>#LSdateformat(endDate, 'mmm d, yyyy')#</td>
							<td headers="Vessel" class="calendar"><a href="javascript:EditSubmit('booking#id#');" name="#id#"><cfif #EndHighlight# GTE PacificNow>* </cfif>#VesselName#</a></td>
							<td headers="Status" class="calendar"><cfif getBookings.Status EQ "C"><div class="confirmed">Confirmed</div><cfelseif getBookings.Status EQ "P"><div class="pending">Pending T</div><cfelseif getBookings.Status EQ "Y"><div class="pending">Pending C</div><cfelseif getBookings.Status EQ "X"><div class="pending">Pending X</div><cfelseif getBookings.Status EQ "T"><div class="tentative">Tentative</div></cfif></td>
						</tr>
							
						<cfif (isDefined('form.id') AND form.id EQ id) OR (isDefined('url.bookingid') AND url.bookingid EQ id) OR form.expandAll EQ "yes">
							
							<cfquery name="getData" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
								SELECT 	Bookings.StartDate, Bookings.EndDate, Vessels.Name AS VesselName, Vessels.EndHighlight AS EndHighlight, Vessels.*, 
										Users.LastName + ', ' + Users.FirstName AS UserName, 
										Companies.Name AS CompanyName, Jetties.NorthJetty, Jetties.SouthJetty,
										Jetties.Status, BookingTime, BookingTimeChange, BookingTimeChangeStatus
								FROM 	Bookings, Jetties, Vessels, Users, Companies
								WHERE	Bookings.VesselID = Vessels.VesselID
								AND		Vessels.CompanyID = Companies.CompanyID
								AND		Bookings.UserID = Users.UserID
								AND		Bookings.BookingID = '#ID#'
								AND		Jetties.BookingID = Bookings.BookingID
								AND   Bookings.Deleted = 0
							</cfquery>
								
							<form method="post" action="jettyBookingManage_action.cfm?#urltoken#" name="confBooking#ID#">
								<input type="hidden" name="ID" value="#id#">
								<input type="hidden" name="Status" value="C">
							</form>
							
							<form method="post" action="jettyBookingManage_action.cfm?#urltoken#" name="UnConfBooking#ID#">
								<input type="hidden" name="ID" value="#id#">
								<input type="hidden" name="Status" value="P">
							</form>
							
							<form method="post" action="chgStatus_2c.cfm?#urltoken#" name="chgStatus_2c#ID#">
								<input type="hidden" name="BookingID" value="#id#">
							</form>
								
							<form method="post" action="chgStatus_2p.cfm?#urltoken#" name="chgStatus_2p#ID#">
								<input type="hidden" name="BookingID" value="#id#">
							</form>
							
							<form method="post" action="chgStatus_2t.cfm?#urltoken#" name="chgStatus_2t#ID#">
								<input type="hidden" name="BookingID" value="#id#">
							</form>
							
							<form method="post" action="deny.cfm?#urltoken#" name="deny#ID#">
								<input type="hidden" name="BookingID" value="#id#">
							</form>
							
							<form method="post" action="editJettyBooking.cfm?#urltoken#" name="editBooking#ID#">
								<input type="hidden" name="BookingID" value="#id#">
							</form>
							
							<form method="post" action="deleteJettyBooking_confirm.cfm?#urltoken#" name="delete#ID#">
								<input type="hidden" name="BookingID" value="#id#">
							</form>
								
							<tr><td colspan="5" class="calendar details">
							
								<table class="showDetails" width="70%" border="0" cellpadding="1" cellspacing="0" align="center">
									<tr>
										<td><strong><em>Details</em></strong></td>
										<td align="right"><a href="javascript:EditSubmit('editBooking#ID#');">Edit Booking</a></td>
									</tr>
									<tr>
										<td id="Start" width="25%">Start Date:</td>
										<td headers="Start">#dateformat(getData.startDate, "mmm d, yyyy")#</td>
									</tr>
									<tr>
										<td id="End">End Date:</td>
										<td headers="End">#dateformat(getData.endDate, "mmm d, yyyy")#</td>
									</tr>
									<tr>
										<td id="Days">## of Days:</td>
										<td headers="Days">#datediff('d', getData.startDate, getData.endDate) + 1#</td>
									</tr>
									<tr>
										<td id="Vessel">Vessel:</td>
										<td headers="Vessel"><cfif #EndHighlight# GTE PacificNow>* </cfif>#getData.name#</td>
									</tr>
									<tr>
										<td id="Length">&nbsp;&nbsp;&nbsp;<i>Length:</i></td>
										<td headers="Length"><i>#getData.length# m</i></td>
									</tr>
									<tr>
										<td id="Width">&nbsp;&nbsp;&nbsp;<i>Width:</i></td>
										<td headers="Width"><i>#getData.width# m</i></td>
									</tr>
									<tr>
										<td id="Tonnage">&nbsp;&nbsp;&nbsp;<i>Tonnage:</i></td>
										<td headers="Tonnage"><i>#getData.tonnage#</i></td>
										</tr>
									<tr>
										<td id="Agent">Agent:</td>
										<td headers="Agent">#getData.UserName#</td>
									</tr>
									<tr>
										<td id="Company">Company:</td>
										<td headers="Company">#getData.companyName# <a class="textbutton" href="changeCompany.cfm?BookingIDURL=#BookingID#&CompanyURL=#getData.companyName#&vesselNameURL=#getData.vesselName#&UserNameURL=#getData.UserName#">Change</a></td>
									</tr>
									<tr>
										<td id="Time">Booking Time:</td>
										<td headers="Time">#DateFormat(getData.bookingTime,"mmm d, yyyy")# #TimeFormat(getData.bookingTime,"long")#</td>
									</tr>
									<tr>
										<td id="Time">Last Change:</td>
										<td headers="Time">#getData.bookingTimeChangeStatus#<br />#DateFormat(getData.bookingTimeChange,"mmm d, yyyy")# #TimeFormat(getData.bookingTimeChange,"long")#</td>
									</tr>
									<tr>
										<td>Highlight for:</td>
										<td> 
										<cfform action="highlight_action.cfm?BookingID=#BookingID#" method="post" name="updateHighlight">
										<cfif EndHighlight NEQ "">
										<cfset datediffhighlight = DateDiff("d", PacificNow, EndHighlight)>
										<cfset datediffhighlight = datediffhighlight+"1">
										<cfif datediffhighlight LTE "0"><cfset datediffhighlight = "0"></cfif>
										<cfelse>
										<cfset datediffhighlight = "0">
										</cfif>
										<cfinput id="EndHighlight" name="EndHighlight" type="text" value="#datediffhighlight#" size="3" maxlength="3" required="yes" CLASS="textField" message="Please enter an End Highlight Date."> Days
										<input type="submit" name="submitForm" class="textbutton" value="Update">
										</cfform> 
										</td>
									</tr>
									<tr>
										<td>Highlight Until:</td>
										<td> 
										<cfif datediffhighlight NEQ "0">#DateFormat(EndHighlight, "mmm dd, yyyy")#</cfif><br />
										</td>
									</tr>
									<tr>
										<td>&nbsp;</td><td>&nbsp;</td>
									</tr>
									<tr>
										<td id="Confirmed" valign="top">Status:</td>
										<td headers="Confirmed">
												<cfif getData.Status EQ "C">
												<strong>Confirmed</strong>
												<a href="javascript:EditSubmit('chgStatus_2t#ID#');" class="textbutton">Make Tentative</a>
												<a href="javascript:EditSubmit('chgStatus_2p#ID#');" class="textbutton">Make Pending</a>
											<cfelseif getData.Status EQ "T">
												<a href="javascript:EditSubmit('chgStatus_2c#ID#');" class="textbutton">Make Confirmed</a>
												<strong>Tentative</strong>
												<a href="javascript:EditSubmit('chgStatus_2p#ID#');" class="textbutton">Make Pending</a>
											<cfelse>
												<a href="javascript:EditSubmit('chgStatus_2c#ID#');" class="textbutton">Make Confirmed</a>
												<a href="javascript:EditSubmit('chgStatus_2t#ID#');" class="textbutton">Make Tentative</a>	
												<strong>Pending</strong>
												<cfif getData.Status EQ "Y">
													<a href="javascript:EditSubmit('deny#ID#');" class="textbutton">Deny Request</a>
												</cfif>
											</cfif>
										</td>
									</tr>
									<tr><td colspan="2">&nbsp;</td></tr>
										
									<cfif DateCompare(PacificNow, getData.startDate, 'd') NEQ 1 OR (DateCompare(PacificNow, getData.startDate, 'd') EQ 1 AND DateCompare(PacificNow, getData.endDate, 'd') NEQ 1)>
										<cfset variables.actionCap = "Cancel Booking">
									<cfelse>
										<cfset variables.actionCap = "Delete Booking">
									</cfif>
										
									<tr>
										<td>&nbsp;</td>
										<td><div style="height:0;">&nbsp;</div><a href="javascript:EditSubmit('delete#ID#');" class="textbutton">#variables.actionCap#</a><br /><br />
			
			<a href="javascript:EditSubmit('deny#ID#');" class="textbutton">Deny Request</a><div style="height:20;">&nbsp;</div></td>
									</tr>
								</table>
							
							</td></tr>							
						</cfif></cfoutput>
					
					<cfelse>
						<tr><td colspan="4" class="calendar">There are currently no bookings for this date range.</td></tr>
					</cfif>
					</table>
				
				</cfloop>
				
				<table width="100%" cellspacing="0" cellpadding="0" style="padding-top: 5px; ">
					<tr>
						<cfoutput><td align="left" width="80%"><a href="addJettyBooking.cfm?#urltoken#" class="textbutton">Add New South Jetty / North Landing Wharf Booking</a><div style="height:0;">&nbsp;</div></td></cfoutput>
						<td>&nbsp;</td><td>&nbsp;</td>
						<cfif form.expandAll NEQ "yes">
							<td align="right" width="20%"><a href="javascript:EditSubmit('expandAll');">Expand All</a><div style="height:0;">&nbsp;</div></td>
						<cfelse>
							<td align="right" width="20%"><a href="javascript:EditSubmit('expandAll');">Collapse All</a><div style="height:0;">&nbsp;</div></td>
						</cfif>
					</tr>
				</table>
				</cfif>
				<hr />
				<h2>Maintenance</h2>
				<table width="100%" cellspacing="0" cellpadding="0" style="padding-bottom: 5px; ">
					<tr>
						<cfoutput><td align="left" width="50%"><a href="addJettyMaintBlock.cfm?#urltoken#" class="textbutton">Add New Maintenance Block</a></td></cfoutput>
					</tr>
				</table>
				
					
				<cfquery name="getMaintenance" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT 	Bookings.*, Jetties.NorthJetty, Jetties.SouthJetty
					FROM 	Bookings INNER JOIN Jetties ON Bookings.BookingID = Jetties.BookingID
					WHERE	(
								(Bookings.startDate >= '#dateformat(variables.startDate, "mm/dd/yyyy")#'	AND Bookings.startDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#') 
							OR	(Bookings.startDate <= '#dateformat(variables.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate >= '#dateformat(variables.endDate, "mm/dd/yyyy")#') 
							OR 	(Bookings.endDate >= '#dateformat(variables.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#')
							)		
					AND 	Bookings.Deleted = 0
					AND 	Jetties.Status = 'M'	
					ORDER BY Bookings.startDate, Bookings.endDate	
				</cfquery>
				
				<cfif getMaintenance.RecordCount GT 0>
					<cfoutput query="getMaintenance">
						<cfset Variables.id = #BookingID#>
						<form name="MaintenanceEdit#id#" action="editJettyMaintBlock.cfm?#urltoken#" method="post">
							<input type="hidden" name="BookingID" value="#id#">
						</form>
						<form name="MaintenanceDel#id#" action="deleteJettyMaintBlock_confirm.cfm?#urltoken#" method="post">
							<input type="hidden" name="BookingID" value="#id#">
						</form>
					</cfoutput>
				</cfif>
				<table class="calendar" cellpadding="3" cellspacing="0" width="100%">
						<tr align="center" style="font-weight:bold;background-color:#cccccc;">
							<th id="Start" class="calendar" style="width: 20%;">Start Date</th>
							<th id="End" class="calendar" style="width: 20%;">End Date</th>
							<th id="Section" class="calendar" style="width: 40%;">Section</th>
							<th class="calendar" colspan="2" style="width: 20%;">&nbsp;</th>
						</tr>	
					<cfif getMaintenance.RecordCount GT 0>
						<cfoutput query="getMaintenance">
							<cfif DateCompare(PacificNow, getMaintenance.startDate, 'd') NEQ 1 OR (DateCompare(PacificNow, getMaintenance.startDate, 'd') EQ 1 AND DateCompare(PacificNow, getMaintenance.endDate, 'd') NEQ 1)>
								<cfset variables.actionCap = "Cancel">
							<cfelse>
								<cfset variables.actionCap = "Delete">
							</cfif>
				
							<cfset Variables.id = #BookingID#>
							<tr>
								<td headers="Start" class="calendar" nowrap>#dateformat(startDate, "mmm d, yyyy")#</td>
								<td headers="End" class="calendar" nowrap>#dateformat(endDate, "mmm d, yyyy")#</td>
								<td headers="Section" class="calendar">
									<cfif NorthJetty>North Landing Wharf</cfif>
									<cfif SouthJetty><cfif NorthJetty> &amp; </cfif>South Jetty</cfif>
								</td>
								<td class="calendar"><a href="javascript:EditSubmit('MaintenanceEdit#id#');">Edit</a></td>
								<td class="calendar"><a href="javascript:EditSubmit('MaintenanceDel#id#');">#variables.actionCap#</a></td>
							</tr>
						</cfoutput>
					<cfelse>
						<tr style="font-size:10pt;">
							<td colspan="5" class="calendar">
								There are no maintenance blocks for this date range.
							</td>
						</tr>
					</cfif>
				</table>
				<table width="100%" cellspacing="0" cellpadding="0" style="padding-top: 5px; ">
					<tr>
						<cfoutput><td align="left" width="50%"><a href="addJettyMaintBlock.cfm?#urltoken#" class="textbutton">Add New Maintenance Block</a><div style="height:0;">&nbsp;</div></td></cfoutput>
					</tr>
				</table>
				
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
