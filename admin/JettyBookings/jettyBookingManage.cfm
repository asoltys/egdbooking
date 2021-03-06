<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">
<!---clear form structure--->
<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<cfsavecontent variable="js">
	<cfoutput>
	<meta name="dcterms.title" content="pwgsc - esquimalt graving dock - Jetty Booking Management">
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta name="dcterms.description" content="" />
	<meta name="dcterms.subject" title="gccore" content="" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Jetty Booking Management</title>
	<script type="text/javascript">
		/* <![CDATA[ */
		var bookingLength = 0;
		/* ]]> */
	</script>
	<script type="text/javascript" src="#RootDir#scripts/tandemDateFixer.js"></script>
	</cfoutput>
</cfsavecontent>
<cfhtmlhead text="#js#">

<!--checking if enddate is defined instead of showConf is not a mistake!-->
<cfif IsDefined("form.EndDate")>
	<cfif IsDefined("form.show")>
		<cfset url.show = #form.show#>
	</cfif>
</cfif>

<cfif IsDefined("url.startDate") and IsDate(URLDecode(url.startDate))>
	<!---cfoutput>#url.startDate#</cfoutput--->
	<cfset form.startDate = url.startDate>
	<cfset Variables.startDate = url.startDate>
</cfif>
<cfif IsDefined("url.endDate") and IsDate(URLDecode(url.endDate))>
	<!---cfoutput>#url.endDate#</cfoutput--->
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
				(Bookings.StartDate = <cfqueryparam value="#dateformat(variables.startDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" /> AND Bookings.EndDate <= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
				OR	(Bookings.startDate <= <cfqueryparam value="#dateformat(variables.startDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />	AND Bookings.endDate >= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
				OR	(Bookings.startDate <= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />	AND Bookings.endDate >= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
				OR 	(Bookings.endDate >= <cfqueryparam value="#dateformat(variables.startDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />	AND Bookings.endDate <= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
			)
		AND Jetties.BRID = Bookings.BRID AND (Status = 'PC' OR Status = 'PX' OR Status = 'PT') AND NorthJetty = '1' AND Bookings.Deleted = 0
</cfquery>
<cfquery name="countConfirmedNJ" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT count(*) as numConfNJ
		FROM Jetties, Bookings
		WHERE (
				(Bookings.StartDate = <cfqueryparam value="#dateformat(variables.startDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" /> AND Bookings.EndDate <= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
				OR	(Bookings.startDate <= <cfqueryparam value="#dateformat(variables.startDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />	AND Bookings.endDate >= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
				OR	(Bookings.startDate <= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />	AND Bookings.endDate >= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
				OR 	(Bookings.endDate >= <cfqueryparam value="#dateformat(variables.startDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />	AND Bookings.endDate <= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
			)
		AND Jetties.BRID = Bookings.BRID AND Status = 'C' AND NorthJetty = '1' AND Bookings.Deleted = 0
</cfquery>
<cfquery name="countTentativeNJ" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT count(*) as numTentNJ
		FROM Jetties, Bookings
		WHERE (
				(Bookings.StartDate = <cfqueryparam value="#dateformat(variables.startDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" /> AND Bookings.EndDate <= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
				OR	(Bookings.startDate <= <cfqueryparam value="#dateformat(variables.startDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />	AND Bookings.endDate >= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
				OR	(Bookings.startDate <= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />	AND Bookings.endDate >= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
				OR 	(Bookings.endDate >= <cfqueryparam value="#dateformat(variables.startDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />	AND Bookings.endDate <= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
			)
		AND Jetties.BRID = Bookings.BRID AND Status = 'T' AND NorthJetty = '1' AND Bookings.Deleted = 0
					<!--- Eliminates any Tentative bookings with a start date before today --->
			AND ((Jetties.status <> 'T') OR (Jetties.status = 'T' AND Bookings.startDate >= <cfqueryparam value="#PacificNow#" cfsqltype="cf_sql_date" />))
</cfquery>
<!---South Jetty Status--->
<cfquery name="countPendingSJ" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT count(*) as numPendSJ
		FROM Jetties, Bookings
		WHERE (
				(Bookings.StartDate = <cfqueryparam value="#dateformat(variables.startDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" /> AND Bookings.EndDate <= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
				OR	(Bookings.startDate <= <cfqueryparam value="#dateformat(variables.startDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />	AND Bookings.endDate >= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
				OR	(Bookings.startDate <= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />	AND Bookings.endDate >= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
				OR 	(Bookings.endDate >= <cfqueryparam value="#dateformat(variables.startDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />	AND Bookings.endDate <= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
			)
		AND Jetties.BRID = Bookings.BRID AND (Status = 'PC' OR Status = 'PX' OR Status = 'PT') AND SouthJetty = '1' AND Bookings.Deleted = 0

</cfquery>
<cfquery name="countConfirmedSJ" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT count(*) as numConfSJ
		FROM Jetties, Bookings
		WHERE (
				(Bookings.StartDate = <cfqueryparam value="#dateformat(variables.startDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" /> AND Bookings.EndDate <= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
				OR	(Bookings.startDate <= <cfqueryparam value="#dateformat(variables.startDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />	AND Bookings.endDate >= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
				OR	(Bookings.startDate <= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />	AND Bookings.endDate >= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
				OR 	(Bookings.endDate >= <cfqueryparam value="#dateformat(variables.startDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />	AND Bookings.endDate <= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
			)
		AND Jetties.BRID = Bookings.BRID AND Status = 'C' AND SouthJetty = '1' AND Bookings.Deleted = 0
</cfquery>
<cfquery name="countTentativeSJ" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT count(*) as numTentSJ
		FROM Jetties, Bookings
		WHERE (
				(Bookings.StartDate = <cfqueryparam value="#dateformat(variables.startDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" /> AND Bookings.EndDate <= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
				OR	(Bookings.startDate <= <cfqueryparam value="#dateformat(variables.startDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />	AND Bookings.endDate >= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
				OR	(Bookings.startDate <= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />	AND Bookings.endDate >= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
				OR 	(Bookings.endDate >= <cfqueryparam value="#dateformat(variables.startDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />	AND Bookings.endDate <= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
			)
		AND Jetties.BRID = Bookings.BRID AND Status = 'T' AND SouthJetty = '1' AND Bookings.Deleted = 0
					<!--- Eliminates any Tentative bookings with a start date before today --->
			AND ((Jetties.status <> 'T') OR (Jetties.status = 'T' AND Bookings.startDate >= <cfqueryparam value="#PacificNow#" cfsqltype="cf_sql_date" />))
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
<script type="text/javascript">
/* <![CDATA[ */
function EditSubmit ( selectedform )
	{
	  document.forms[selectedform].submit();
	}
/* ]]> */
</script>
<!-- End JavaScript Block -->

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<cfif IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt;
			<cfelse>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</cfif>
			Jetty Booking Management
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1 id="wb-cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Jetty Booking Management
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<p>Please enter a range of dates for which you would like to see the bookings:</p>
				<form action="jettyBookingManage.cfm?lang=<cfoutput>#lang#</cfoutput>" method="get" name="dateSelect">
					<input type="hidden" name="lang" value="<cfoutput>#lang#</cfoutput>" />
					<table style="width: 100%;">
						<tr>
							<td id="Startdate">
								<label for="start">Start Date:</label>							</td>
							<td headers="Startdate" colspan="2">
								<cfoutput>
								<input name="startDate" type="text" class="datepicker startDate" value="#DateFormat(variables.startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" />
                </cfoutput>
							</td>
						</tr>
						<tr>
							<td id="Enddate">
								<label for="end">End Date:</label>							</td>
							<td headers="Enddate" colspan="2">
								<cfoutput>
								<input name="endDate" type="text" class="datepicker endDate" value="#DateFormat(variables.endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" />
                </cfoutput>
							</td>
						</tr>
						<tr>
							<td>Show only:</td>
							<td headers="Pending" align="right" style="width:15%;"><input type="checkbox" name="show" value="p" id="showPend"<cfif showPend EQ true> checked="true"</cfif> /></td>
							<td id="Pending" align="left"><label for="showPend" class="pending">Pending</label></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td headers="Tentative" align="right"><input type="checkbox" id="showTent" name="show" value="t"<cfif showTent eq true> checked="true"</cfif> /></td>
							<td id="Tentative" align="left"><label for="showTent" class="tentative">Tentative</label></td>
						</tr>

						<tr>
							<td>&nbsp;</td>
							<td headers="Confirmed" align="right"><input type="checkbox" name="show" value="c" id="showConf" <cfif showConf EQ true>checked="true"</cfif> /></td>
							<td id="Confirmed" align="left"><label for="showConf" class="confirmed">Confirmed</label></td>
						</tr>
						<tr>
							<td colspan="3" align="right"><input type="submit" value="submit" class="textbutton" />
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
					<form action="jettyBookingManage.cfm?#urltoken#" method="post" id="expandAll">
						<input type="hidden" name="startDate" value="#variables.startDate#" />
						<input type="hidden" name="endDate" value="#variables.endDate#" />
						<cfif form.expandAll NEQ "yes">
							<input type="hidden" name="expandAll" value="yes" />
						<cfelse>
							<input type="hidden" name="expandAll" value="no" />
						</cfif>
						<input type="hidden" name="show" value="#url.show#" />
					</form>

					<div style="float:left;"><a href="addJettyBooking.cfm?#urltoken#" class="textbutton">Add New South Jetty / North Landing Wharf Booking</a></div>
					<div style="text-align:right;">
						<cfif form.expandAll NEQ "yes">
							<a href="javascript:EditSubmit('expandAll');">Expand All</a>
						<cfelse>
							<a href="javascript:EditSubmit('expandAll');">Collapse All</a>
						</cfif>
					</div>
					</cfoutput>
				<cfloop index="jetty" from="1" to="2" step="1">
					<cfquery name="getBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT Bookings.*, Vessels.Name AS VesselName, Vessels.EndHighlight AS EndHighlight, Jetties.*
						FROM Jetties INNER JOIN Bookings ON Jetties.BRID = Bookings.BRID
								INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
						WHERE ((Bookings.startDate >= <cfqueryparam value="#dateformat(variables.startDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />
								AND Bookings.startDate <= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
							OR (Bookings.startDate <= <cfqueryparam value="#dateformat(variables.startDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />
								AND Bookings.endDate >= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
							OR (Bookings.endDate >= <cfqueryparam value="#dateformat(variables.startDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />
								AND Bookings.endDate <= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />))
							AND Bookings.Deleted = 0
							<!--- Eliminates any Tentative bookings with a start date before today --->
							AND (((Jetties.status <> 'T') OR (Jetties.status = 'T' AND Bookings.startDate >= <cfqueryparam value="#dateformat(PacificNow, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />))
							<cfif variables.showPend EQ true AND variables.showTent EQ false AND variables.showConf EQ false>
								AND Jetties.Status = 'PC' OR Jetties.Status = 'PX' OR Jetties.Status = 'PT'
							</cfif>
							<cfif variables.showTent EQ true AND variables.showPend EQ false AND variables.showConf EQ false>
								AND Jetties.Status = 'T'
							</cfif>
							<cfif variables.showConf EQ true AND variables.showPend EQ false AND variables.showTent EQ false>
								AND Jetties.Status = 'C'
							</cfif>
							<cfif variables.showPend EQ true AND variables.showTent EQ true AND variables.showConf EQ false>
								AND ((Jetties.Status = 'PC' OR Jetties.Status = 'PX' OR Jetties.Status = 'PT') OR (Jetties.Status = 'T'))
							</cfif>
							<cfif variables.showPend EQ true AND variables.showTent EQ false AND variables.showConf EQ true>
								AND ((Jetties.Status = 'C') OR (Jetties.Status = 'PT' OR Jetties.Status = 'PX' OR Jetties.Status = 'PC'))
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
							<cfset Variables.id = #BRID#>
							<form name="booking#id#" action="jettyBookingManage.cfm?#urltoken####id#" method="post" class="hidden">
								<input type="hidden" name="startDate" value="#DateFormat(variables.startDate, 'mm/dd/yyyy')#" />
								<input type="hidden" name="endDate" value="#DateFormat(variables.endDate, 'mm/dd/yyyy')#" />
								<cfif (isDefined("form.ID") AND form.ID EQ #id#) OR (isDefined('url.BRID') AND url.BRID EQ id)>
									<input type="hidden" name="ID" value="0" />
								<cfelse>
									<input type="hidden" name="ID" value="#id#" />
								</cfif>
							</form>
						</cfoutput>
					</cfif>

					<cfif jetty EQ 1>
						<h2>North Landing Wharf</h2>
						<p align="center"><strong>Total:&nbsp;&nbsp;</strong>
							<cfoutput>
							<i class="pending">Pending - #countPendingNJ.numPendNJ#</i>&nbsp;&nbsp;
							<i class="tentative">Tentative - #countTentativeNJ.numTentNJ#</i>&nbsp;&nbsp;
							<i class="confirmed">Confirmed - #countConfirmedNJ.numConfNJ#</i>&nbsp;&nbsp;
							</cfoutput>
						</p>
					<cfelseif jetty EQ 2>
						<hr />
						<h2>South Jetty</h2>
						<p align="center"><strong>Total:&nbsp;&nbsp;</strong>
							<cfoutput>
							<i class="pending">Pending - #countPendingSJ.numPendSJ#</i>&nbsp;&nbsp;
							<i class="tentative">Tentative - #countTentativeSJ.numTentSJ#</i>&nbsp;&nbsp;
							<i class="confirmed">Confirmed - #countConfirmedSJ.numConfSJ#</i>&nbsp;&nbsp;
							</cfoutput>
						</p>
					</cfif>

					<table class="basic">
						<tr>
							<th id="Start" style="width: 20%; ">Start Date</th>
							<th id="End" style="width: 20%; ">End Date</th>
							<th id="Vessel" style="width: 45%; ">Vessel Name</th>
							<th id="Status" style="width: 15%; ">Status</th>
						</tr>

					<cfif getBookings.recordCount GT 0><cfoutput query="getBookings">
						<cfset Variables.id = #BRID#>
						<tr>
							<td headers="Start" nowrap>#LSdateformat(startDate, 'mmm d, yyyy')#</td>
							<td headers="End" nowrap>#LSdateformat(endDate, 'mmm d, yyyy')#</td>
							<td headers="Vessel"><a href="javascript:EditSubmit('booking#id#');" name="#id#"><cfif #EndHighlight# GTE PacificNow>* </cfif>#VesselName#</a></td>
							<td headers="Status"><cfif getBookings.Status EQ "C"><div class="confirmed">Confirmed</div><cfelseif getBookings.Status EQ "PT" OR getBookings.Status EQ "P"><div class="pending">Pending T</div><cfelseif getBookings.Status EQ "PC"><div class="pending">Pending C</div><cfelseif getBookings.Status EQ "PX"><div class="pending">Pending X</div><cfelseif getBookings.Status EQ "T"><div class="tentative">Tentative</div></cfif></td>
						</tr>

						<cfif (isDefined('form.id') AND form.id EQ id) OR (isDefined('url.BRID') AND url.BRID EQ id) OR form.expandAll EQ "yes">

							<cfquery name="getData" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
								SELECT 	Bookings.StartDate, Bookings.EndDate, Vessels.Name AS VesselName, Vessels.EndHighlight AS EndHighlight, Vessels.*,
										Users.LastName + ', ' + Users.FirstName AS UserName,
										Companies.Name AS CompanyName, Jetties.NorthJetty, Jetties.SouthJetty,
										Jetties.Status, BookingTime, BookingTimeChange, BookingTimeChangeStatus
								FROM 	Bookings, Jetties, Vessels, Users, Companies
								WHERE	Bookings.VNID = Vessels.VNID
								AND		Vessels.CID = Companies.CID
								AND		Bookings.UID = Users.UID
								AND		Bookings.BRID = <cfqueryparam value="#ID#" cfsqltype="cf_sql_integer" />
								AND		Jetties.BRID = Bookings.BRID
								AND   Bookings.Deleted = 0
							</cfquery>

							<form method="post" action="jettyBookingManage_action.cfm?#urltoken#" name="confBooking#ID#">
								<input type="hidden" name="ID" value="#id#" />
								<input type="hidden" name="Status" value="C" />
							</form>

							<form method="post" action="jettyBookingManage_action.cfm?#urltoken#" name="UnConfBooking#ID#">
								<input type="hidden" name="ID" value="#id#" />
								<input type="hidden" name="Status" value="PT" />
							</form>

							<form method="post" action="chgStatus_2c.cfm?#urltoken#" name="chgStatus_2c#ID#">
								<input type="hidden" name="BRID" value="#id#" />
							</form>

							<form method="post" action="chgStatus_2p.cfm?#urltoken#" name="chgStatus_2p#ID#">
								<input type="hidden" name="BRID" value="#id#" />
							</form>

							<form method="post" action="chgStatus_2t.cfm?#urltoken#" name="chgStatus_2t#ID#">
								<input type="hidden" name="BRID" value="#id#" />
							</form>

							<form method="post" action="deny.cfm?#urltoken#" name="deny#ID#">
								<input type="hidden" name="BRID" value="#id#" />
							</form>

							<form method="post" action="editJettyBooking.cfm?#urltoken#" name="editBooking#ID#">
								<input type="hidden" name="BRID" value="#id#" />
							</form>

							<form method="post" action="deleteJettyBooking_confirm.cfm?#urltoken#" name="delete#ID#">
								<input type="hidden" name="BRID" value="#id#" />
							</form>

							<tr><td colspan="5">

								<div style="text-align:center;">
									<div style="width:70%">
										<div style="text-align:right;"><a href="javascript:EditSubmit('editBooking#ID#');">Edit Booking</a></div>
										<table style="width:100%;" class="bookingDetails">
											<tr>
												<td id="Start" style="width:25%;">Start Date:</td>
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
												<td headers="Vessel"><strong><cfif #EndHighlight# GTE PacificNow>* </cfif>#getData.name#</strong></td>
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
											<tr class="containsbutton">
												<td id="Company">Company:</td>
												<td headers="Company">#getData.companyName# <a class="textbutton" href="changeCompany.cfm?BRIDURL=#BRID#&CompanyURL=#getData.companyName#&vesselNameURL=#getData.vesselName#&UserNameURL=#getData.UserName#">Change</a></td>
											</tr>
											<tr>
												<td id="Time">Booking Time:</td>
												<td headers="Time">#DateFormat(getData.bookingTime,"mmm d, yyyy")# #TimeFormat(getData.bookingTime,"long")#</td>
											</tr>
											<tr>
												<td id="Time">Last Change:</td>
												<td headers="Time">#getData.bookingTimeChangeStatus#<br />#DateFormat(getData.bookingTimeChange,"mmm d, yyyy")# #TimeFormat(getData.bookingTimeChange,"long")#</td>
											</tr>
											<tr class="containsbutton">
												<td>Highlight for:</td>
												<td>
												<cfform action="highlight_action.cfm?BRID=#BRID#" method="post" id="updateHighlight">
												<cfif EndHighlight NEQ "">
												<cfset datediffhighlight = DateDiff("d", PacificNow, EndHighlight)>
												<cfset datediffhighlight = datediffhighlight+"1">
												<cfif datediffhighlight LTE "0"><cfset datediffhighlight = "0"></cfif>
												<cfelse>
												<cfset datediffhighlight = "0">
												</cfif>
												<cfinput id="EndHighlight" name="EndHighlight" type="text" value="#datediffhighlight#" size="3" maxlength="3" required="yes" message="Please enter an End Highlight Date." /> Days
												<input type="submit" name="submitForm" class="textbutton" value="Update" />
												</cfform>
												</td>
											</tr>
											<tr>
												<td>Highlight Until:</td>
												<td>
												<cfif datediffhighlight NEQ "0">#DateFormat(EndHighlight, "mmm dd, yyyy")#</cfif><br />
												</td>
											</tr>
											<tr class="containsbutton">
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
														<a href="javascript:EditSubmit('chgStatus_2p#ID#');" class="textbutton">Make Pending</a>
														<cfif getData.Status EQ "PC">
															<a href="javascript:EditSubmit('deny#ID#');" class="textbutton">Deny Request</a>
														</cfif>
													</cfif>
												</td>
											</tr>
											<cfif DateCompare(PacificNow, getData.startDate, 'd') NEQ 1 OR (DateCompare(PacificNow, getData.startDate, 'd') EQ 1 AND DateCompare(PacificNow, getData.endDate, 'd') NEQ 1)>
												<cfset variables.actionCap = "Cancel Booking">
											<cfelse>
												<cfset variables.actionCap = "Delete Booking">
											</cfif>

											<tr class="containsbutton">
												<td colspan="2" style="text-align:center;">
												<a href="javascript:EditSubmit('delete#ID#');" class="textbutton">#variables.actionCap#</a>
												<a href="javascript:EditSubmit('deny#ID#');" class="textbutton">Deny Request</a>
												</td>
											</tr>
										</table>
									</div>
								</div>
							</td></tr>
						</cfif></cfoutput>

					<cfelse>
						<tr><td colspan="4">There are currently no bookings for this date range.</td></tr>
					</cfif>
					</table>

				</cfloop>

				<cfoutput><div style="float:left;"><a href="addJettyBooking.cfm?#urltoken#" class="textbutton">Add New South Jetty / North Landing Wharf Booking</a></div></cfoutput>
				<div style="text-align:right;">
					<cfif form.expandAll NEQ "yes">
						<a href="javascript:EditSubmit('expandAll');">Expand All</a>
					<cfelse>
						<a href="javascript:EditSubmit('expandAll');">Collapse All</a>
					</cfif>
				</div>
				</cfif>
				<hr />
				<h2>Maintenance</h2>
				<cfoutput><a href="addJettyMaintBlock.cfm?#urltoken#" class="textbutton">Add New Maintenance Block</a></cfoutput>

				<cfquery name="getMaintenance" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT 	Bookings.*, Jetties.NorthJetty, Jetties.SouthJetty
					FROM 	Bookings INNER JOIN Jetties ON Bookings.BRID = Jetties.BRID
					WHERE	(
								(Bookings.startDate >= <cfqueryparam value="#dateformat(variables.startDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />	AND Bookings.startDate <= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
							OR	(Bookings.startDate <= <cfqueryparam value="#dateformat(variables.startDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />	AND Bookings.endDate >= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
							OR 	(Bookings.endDate >= <cfqueryparam value="#dateformat(variables.startDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />	AND Bookings.endDate <= <cfqueryparam value="#dateformat(variables.endDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" />)
							)
					AND 	Bookings.Deleted = 0
					AND 	Jetties.Status = 'M'
					ORDER BY Bookings.startDate, Bookings.endDate
				</cfquery>

				<table class="basic" style="width:100%;">
						<tr align="center">
							<th id="Start" style="width: 20%;">Start Date</th>
							<th id="End" style="width: 20%;">End Date</th>
							<th id="Section" style="width: 40%;">Section</th>
							<th colspan="2" style="width: 20%;">&nbsp;</th>
						</tr>
					<cfif getMaintenance.RecordCount GT 0>
						<cfoutput query="getMaintenance">
							<cfif DateCompare(PacificNow, getMaintenance.startDate, 'd') NEQ 1 OR (DateCompare(PacificNow, getMaintenance.startDate, 'd') EQ 1 AND DateCompare(PacificNow, getMaintenance.endDate, 'd') NEQ 1)>
								<cfset variables.actionCap = "Cancel">
							<cfelse>
								<cfset variables.actionCap = "Delete">
							</cfif>

							<cfset Variables.id = #BRID#>
							<tr>
								<td headers="Start" nowrap>#dateformat(startDate, "mmm d, yyyy")#</td>
								<td headers="End" nowrap>#dateformat(endDate, "mmm d, yyyy")#</td>
								<td headers="Section">
									<cfif NorthJetty>North Landing Wharf</cfif>
									<cfif SouthJetty><cfif NorthJetty> &amp; </cfif>South Jetty</cfif>
								</td>
								<td><a href="#RootDir#admin/JettyBookings/editJettyMaintBlock.cfm?BRID=#getMaintenance.BRID#">Edit</a></td>
								<td><a href="#RootDir#admin/JettyBookings/deleteJettyMaintBlock_confirm.cfm?BRID=#getMaintenance.BRID#">#variables.actionCap#</a></td>
							</tr>
						</cfoutput>
					<cfelse>
						<tr>
							<td colspan="5">
								There are no maintenance blocks for this date range.
							</td>
						</tr>
					</cfif>
				</table>
				<cfoutput><a href="addJettyMaintBlock.cfm?#urltoken#" class="textbutton">Add New Maintenance Block</a></cfoutput>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
