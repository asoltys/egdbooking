<cfsavecontent variable="js">
	<cfoutput>
	<meta name="dc.title" content="pwgsc - esquimalt graving dock - Drydock Booking Management">
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta name="dc.subject" scheme="gccore" content="" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Drydock Booking Management</title>
	<script type="text/javascript">
		/* <![CDATA[ */
		var bookingLength = 2;
		/* ]]> */
	</script>
	<script type="text/javascript" src="#RootDir#scripts/tandemDateFixer.js"></script>
	</cfoutput>
</cfsavecontent>
<cfhtmlhead text="#js#">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<!---clear form structure--->
<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<!--checking if enddate is defined instead of show is not a mistake!-->
<cfif IsDefined("form.EndDate") AND IsDate("form.EndDate")>
	<cfif IsDefined("form.show")>
		<cfset url.show = #form.show#>
	</cfif>
</cfif>

<!--- Want URL variables to take precedence over form variables for proper linking purposes --->
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


<!---Drydock Status--->
<cfquery name="countPending" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT count(*) as numPend
		FROM Docks, Bookings
		WHERE (
				(Bookings.StartDate = '#dateformat(variables.startDate, "mm/dd/yyyy")#' AND Bookings.EndDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#')
				OR	(Bookings.startDate <= '#dateformat(variables.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate >= '#dateformat(variables.endDate, "mm/dd/yyyy")#')
				OR	(Bookings.startDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#'	AND Bookings.endDate >= '#dateformat(variables.endDate, "mm/dd/yyyy")#')
				OR 	(Bookings.endDate >= '#dateformat(variables.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#')
			)
		AND Docks.BookingID = Bookings.BookingID AND (Status = 'P' OR Status = 'X' OR Status = 'Y' OR Status = 'Z') AND Bookings.Deleted = '0'
</cfquery>
<cfquery name="countTentative" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT count(*) as numTent
		FROM Docks, Bookings
		WHERE (
				(Bookings.StartDate = '#dateformat(variables.startDate, "mm/dd/yyyy")#' AND Bookings.EndDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#')
				OR	(Bookings.startDate <= '#dateformat(variables.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate >= '#dateformat(variables.endDate, "mm/dd/yyyy")#')
				OR	(Bookings.startDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#'	AND Bookings.endDate >= '#dateformat(variables.endDate, "mm/dd/yyyy")#')
				OR 	(Bookings.endDate >= '#dateformat(variables.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#')
			)
		AND Docks.BookingID = Bookings.BookingID AND Status = 'T' AND Bookings.Deleted = '0'
		<!--- Eliminates any Tentative bookings with a start date before today --->
		AND ((Docks.status <> 'T') OR (Docks.status = 'T' AND Bookings.startDate >= #PacificNow#))
</cfquery>
<cfquery name="countConfirmed" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT count(*) as numConf
		FROM Docks, Bookings
		WHERE (
				(Bookings.StartDate = '#dateformat(variables.startDate, "mm/dd/yyyy")#' AND Bookings.EndDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#')
				OR	(Bookings.startDate <= '#dateformat(variables.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate >= '#dateformat(variables.endDate, "mm/dd/yyyy")#')
				OR	(Bookings.startDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#'	AND Bookings.endDate >= '#dateformat(variables.endDate, "mm/dd/yyyy")#')
				OR 	(Bookings.endDate >= '#dateformat(variables.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#')
			)
		AND Docks.BookingID = Bookings.BookingID AND Status = 'C' AND Bookings.Deleted = '0'
</cfquery>

<cfparam name="form.show" default="c,t,p">
<cfparam name="url.show" default="#form.show#">
<cfparam name="Variables.show" default="#url.show#">

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
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm"> &gt;
			<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt;
			Drydock Booking Management
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Drydock Booking Management
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<p>Please enter a range of dates for which you would like to see the bookings:</p>
				<form action="bookingManage.cfm?lang=#lang#" method="get" id="dateSelect">
					<input type="hidden" name="lang" value="<cfoutput>#lang#</cfoutput>" />
					<table style="width: 100%;" >
						<tr>
							<td id="Startdate">
								<label for="start">Start Date:</label>
							</td>
							<td headers="" colspan="2">
								<cfoutput>
									<input name="startDate" type="text" class="startDate" value="#DateFormat(variables.startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" /> #language.dateform#
								</cfoutput>
								<img src="#RootDir#images/calendar.gif" alt="" class="calendar" />
							</td>
						</tr>
						<tr>
							<td id="Enddate">
								<label for="end">End Date:</label>
							</td>
							<td headers="" colspan="2">
								<cfoutput>
									<input name="endDate" type="text" class="endDate" value="#DateFormat(variables.endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" /> #language.dateform#
								</cfoutput>
								<img src="#RootDir#images/calendar.gif" alt="" class="calendar" />
							</td>
						</tr>
						<tr>
							<td>Show only:</td>
							<td headers="Pending" align="right" style="width:15%;"><input type="checkbox" id="showPend" name="show" value="p"<cfif showPend eq true> checked="true"</cfif> /></td>
							<td id="Pending" align="left"><label for="showPend" class="pending">Pending</label></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td headers="Tentative" align="right"><input type="checkbox" id="showTent" name="show" value="t"<cfif showTent eq true> checked="true"</cfif> /></td>
							<td id="Tentative" align="left"><label for="showTent" class="tentative">Tentative</label></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td headers="Confirmed" align="right"><input type="checkbox" id="showConf" name="show" value="c"<cfif showConf eq true> checked="true"</cfif> /></td>
							<td id="Confirmed" align="left"><label for="showConf" class="confirmed">Confirmed</label></td>
						</tr>
						<tr>
							<td colspan="3" align="right"><input type="submit" class="textbutton" value="submit" />
						</tr>
					</table>
				</form>

				<cfif form.startDate NEQ "" and form.endDate NEQ "">
					<cfif isDate(form.startDate)>
						<cfset proceed = "yes">
					</cfif>
				</cfif>

				<cfif isdefined('proceed') and proceed EQ "yes">
					<cfoutput>
					<cfparam name="form.expandAll" default="">
					<form action="bookingManage.cfm?#urltoken#" method="post" id="expandAll">
						<input type="hidden" name="startDate" value="#variables.startdate#" />
						<input type="hidden" name="endDate" value="#variables.endDate#" />
						<cfif form.expandAll NEQ "yes">
							<input type="hidden" name="expandAll" value="yes" />
						<cfelse>
							<input type="hidden" name="expandAll" value="no" />
						</cfif>
						<input type="hidden" name="show" value="#url.show#" />
					</form>

					<h2>Drydock <cfif #countPending.numPend# NEQ 0>(#countPending.numPend# #language.pending#)</cfif></h2>

					<div style="float:left;"><a href="addBooking.cfm?#urltoken#" class="textbutton">Add New Drydock Booking</a></div>
					<div style="text-align:right;">
						<cfif form.expandAll NEQ "yes">
							<a href="javascript:EditSubmit('expandAll');">Expand All</a>
						<cfelse>
							<a href="javascript:EditSubmit('expandAll');">Collapse All</a>
						</cfif>
					</div>

					<p align="center">Total:&nbsp;&nbsp;
						<i class="pending">Pending - #countPending.numPend#</i>&nbsp;&nbsp;
						<i class="tentative">Tentative - #countTentative.numTent#</i>&nbsp;&nbsp;
						<i class="confirmed">Confirmed - #countConfirmed.numConf#</i>
					</p>

					</cfoutput>

					<cfquery name="getBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT 	Bookings.EndHighlight AS EndHighlight, Bookings.*, Vessels.Name AS VesselName, Docks.Status
						FROM 	Bookings INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID
									INNER JOIN Docks ON Bookings.BookingID = Docks.BookingID
						WHERE  ((Bookings.startDate >= '#dateformat(variables.startDate, "mm/dd/yyyy")#'
								AND Bookings.startDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#')
							OR (Bookings.startDate <= '#dateformat(variables.startDate, "mm/dd/yyyy")#'
								AND Bookings.endDate >= '#dateformat(variables.endDate, "mm/dd/yyyy")#')
							OR (Bookings.endDate >= '#dateformat(variables.startDate, "mm/dd/yyyy")#'
								AND Bookings.endDate <= '#dateformat(variables.endDate, "mm/dd/yyyy")#'))
							AND Bookings.Deleted = 0
							AND Vessels.Deleted = 0
							<!--- Eliminates any Tentative bookings with a start date before today --->
							AND ((Docks.status <> 'T') OR (Docks.status = 'T' AND Bookings.startDate >= #PacificNow#))

						<cfif variables.showPend EQ true AND variables.showTent EQ false AND variables.showConf EQ false>
							AND (Docks.Status = 'P' OR Docks.Status = 'Y' OR Docks.Status = 'X' OR Docks.Status = 'Z')
						</cfif>
						<cfif variables.showTent EQ true AND variables.showPend EQ false AND variables.showConf EQ false>
							AND Docks.Status = 'T'
						</cfif>
						<cfif variables.showConf EQ true AND variables.showPend EQ false AND variables.showTent EQ false>
							AND Docks.Status = 'C'
						</cfif>
						<cfif variables.showPend EQ true AND variables.showTent EQ true AND variables.showConf EQ false>
							AND ((Docks.Status = 'P' OR Docks.Status = 'Y' OR Docks.Status = 'X' OR Docks.Status = 'Z') OR (Docks.Status = 'T'))
						</cfif>
						<cfif variables.showPend EQ true AND variables.showTent EQ false AND variables.showConf EQ true>
							AND ((Docks.Status = 'C') OR (Docks.Status = 'P' OR Docks.Status = 'Y' OR Docks.Status = 'X' OR Docks.Status = 'Z'))
						</cfif>
						<cfif variables.showPend EQ false AND variables.showTent EQ true AND variables.showConf EQ true>
							AND ((Docks.Status = 'C') OR (Docks.Status = 'T'))
						</cfif>
						ORDER BY Bookings.startDate, Bookings.endDate, Vessels.Name
					</cfquery>

					<cfif getBookings.RecordCount GT 0>
						<cfoutput query="getBookings">
						<cfset Variables.id = #BookingID#>
							<form name="booking#id#" action="bookingManage.cfm?#urltoken###id#id#" method="post" class="hidden">
								<input type="hidden" name="startDate" value="#form.startDate#" />
								<input type="hidden" name="endDate" value="#form.endDate#" />
								<cfif (isDefined("form.ID") AND form.ID EQ #id#) OR (isDefined('url.bookingid') AND url.bookingid EQ id)>
									<input type="hidden" name="ID" value="0" />
								<cfelse>
									<input type="hidden" name="ID" value="#id#" />
								</cfif>
								<input type="hidden" name="show" value="#variables.show#" />
							</form>
						</cfoutput>
					</cfif>
					<table class="basic">
						<tr>
							<th id="Start" style="width: 20%;">Start Date</th>
							<th id="End" style="width: 20%;">End Date</th>
							<th id="Vessel" style="width: 45%;">Vessel Name</th>
							<th id="Status" style="width: 15%;">Status</th>
						</tr>
						<cfif getBookings.RecordCount GT 0>
							<cfoutput query="getBookings">
								<cfset Variables.id = #BookingID#>

								<form method="post" action="deleteBooking_confirm.cfm?#urltoken#" name="delete#ID#">
									<input type="hidden" name="BookingID" value="#id#" />
								</form>
								<form method="post" action="chgStatus_2c.cfm?#urltoken#" name="chgStatus_2c#ID#">
									<input type="hidden" name="BookingID" value="#id#" />
								</form>

								<form method="post" action="chgStatus_2p.cfm?#urltoken#" name="chgStatus_2p#ID#">
									<input type="hidden" name="BookingID" value="#id#" />
								</form>

								<form method="post" action="chgStatus_2t.cfm?#urltoken#" name="chgStatus_2t#ID#">
									<input type="hidden" name="BookingID" value="#id#" />
								</form>

								<form method="post" action="deny.cfm?#urltoken#" name="deny#ID#">
									<input type="hidden" name="BookingID" value="#id#" />
								</form>

								<form method="post" action="editBooking.cfm?#urltoken#" name="editBooking#ID#">
									<input type="hidden" name="BookingID" value="#id#" />
								</form>

								<form method="post" action="feesForm_admin.cfm?#urltoken#" name="viewForm#ID#">
									<input type="hidden" name="BookingID" value="#id#" />
								</form>

						<tr>
							<td headers="start" nowrap>#LSdateformat(startDate, "mmm d, yyyy")#</td>
							<td headers="end" nowrap>#LSdateformat(endDate, "mmm d, yyyy")#</td>
							<td headers="vessel"><a href="javascript:EditSubmit('booking#id#');" name="id#id#" id="id#id#"><cfif #EndHighlight# GTE PacificNow>* </cfif>#VesselName#</a></td>
							<td headers="status"><cfif status EQ "C"><div class="confirmed">Confirmed</div><cfelseif status EQ "T"><div class="tentative">Tentative</div><cfelseif status EQ "P"><div class="pending">Pending T</div><cfelseif status EQ "Y" OR status EQ "Z"><div class="pending">Pending C</div><cfelseif status EQ "X"><a href="javascript:EditSubmit('delete#ID#');"><div class="pending">Pending X</div></a></cfif></td>
						</tr>

						<cfif (isDefined('form.id') AND form.id EQ id) OR (isDefined('url.bookingid') AND url.bookingid EQ id) OR form.expandAll EQ "yes">
							<cfquery name="getData" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
								SELECT 	Bookings.EndHighlight AS EndHighlight, Bookings.StartDate, Bookings.EndDate, Vessels.Name AS VesselName, Vessels.*,
										Users.LastName + ', ' + Users.FirstName AS UserName,
										Companies.Name AS CompanyName, Docks.Section1, Docks.Section2, Docks.Section3,
										Docks.Status, BookingTime, BookingTimeChange, BookingTimeChangeStatus
								FROM 	Bookings, Docks, Vessels, Users, Companies
								WHERE	Bookings.VesselID = Vessels.VesselID
								AND		Vessels.CompanyID = Companies.CompanyID

								AND		Bookings.UserID = Users.UserID
								AND		Bookings.BookingID = '#ID#'
								AND		Docks.BookingID = Bookings.BookingID
							</cfquery>

							<tr><td colspan="5">
								<div style="text-align:center;">
									<div style="width:70%">
										<div style="text-align:right;"><a href="javascript:EditSubmit('editBooking#ID#');">Edit Booking</a></div>
										<table style="width:100%;" class="bookingDetails">
											<tr>
												<td id="Start" style="width:30%;">Start Date:</td>
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
												<td headers="Vessel"><strong><cfif #EndHighlight# GTE PacificNow>* </cfif>#getData.vesselName#</strong></td>
											</tr>
											<tr>
												<td id="">&nbsp;&nbsp;&nbsp;<i>Length:</i></td>
												<td headers=""><i>#getData.length# m</i></td>
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
												<td headers="Company">#getData.companyName# <a class="textbutton" href="changeCompany.cfm?BookingIDURL=#BookingID#&CompanyURL=#getData.companyName#&vesselNameURL=#getData.vesselName#&amp;UserNameURL=#getData.UserName#">Change</a></td>
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
												<td id="Section">Section(s):</td>
												<td headers="Section">
													<cfif getData.Section1>Section 1</cfif>
													<cfif getData.Section2><cfif getData.Section1> &amp; </cfif>Section 2</cfif>
													<cfif getData.Section3><cfif getData.Section1 OR getData.Section2> &amp; </cfif>Section 3</cfif>
													<cfif NOT getData.Section1 AND NOT getData.Section2 AND NOT getData.Section3>Unassigned</cfif>
												</td>
											</tr>
											<tr class="containsbutton">
												<td><label for="EndHighlight">Highlight for:</label></td>
												<td>
												<cfform action="highlight_action.cfm?BookingID=#BookingID#" method="post" id="updateHighlight">
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
												<cfif datediffhighlight NEQ "0">#DateFormat(EndHighlight, "mmm dd, yyyy")#</cfif>&nbsp;
												</td>
											</tr>
											<tr class="containsbutton">
												<td id="Status" valign="top">Status:</td>
												<td headers="Status">

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
													</div>
												</td>
											</tr>

											<cfif DateCompare(PacificNow, getData.startDate, 'd') NEQ 1 OR (DateCompare(PacificNow, getData.startDate, 'd') EQ 1 AND DateCompare(PacificNow, getData.endDate, 'd') NEQ 1)>
												<cfset variables.actionCap = "Cancel Booking">
											<cfelse>
												<cfset variables.actionCap = "Delete Booking">
											</cfif>

											<tr class="containsbutton">
												<td colspan="2" style="text-align:center;">
												<a href="javascript:EditSubmit('viewForm#ID#');" class="textbutton">View / Edit Tariff Form</a>
												<a href="javascript:EditSubmit('delete#ID#');" class="textbutton">#variables.actionCap#</a>
												<a href="javascript:EditSubmit('deny#ID#');" class="textbutton">Deny Request</a>
												</td>
											</tr>
										</table>
									</div>
								</div>
							</td></tr>
								</cfif>
							</cfoutput>

						<cfelse>
							<tr>
								<td colspan="4">
									There are no bookings for this date range.
								</td>
							</tr>
						</cfif>

					</table>
					<div style="float:left;"><a href="addBooking.cfm?#urltoken#" class="textbutton">Add New Drydock Booking</a></div>
					<div style="text-align:right;">
						<cfif form.expandAll NEQ "yes">
							<a href="javascript:EditSubmit('expandAll');">Expand All</a>
						<cfelse>
							<a href="javascript:EditSubmit('expandAll');">Collapse All</a>
						</cfif>
					</div>

					<hr />
					<h2>Maintenance</h2>
					<cfoutput><a href="addMaintBlock.cfm?#urltoken#" class="textbutton">Add New Maintenance Block</a></cfoutput>

					<cfquery name="getMaintenance" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT  Bookings.*, Docks.Section1, Docks.Section2, Docks.Section3
						FROM 	Bookings INNER JOIN Docks ON Bookings.BookingID = Docks.BookingID
						WHERE	(
									(Bookings.startDate >= '#dateformat(form.startDate, "mm/dd/yyyy")#'	AND Bookings.startDate <= '#dateformat(form.endDate, "mm/dd/yyyy")#')
								OR	(Bookings.startDate <= '#dateformat(form.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate >= '#dateformat(form.endDate, "mm/dd/yyyy")#')
								OR 	(Bookings.endDate >= '#dateformat(form.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate <= '#dateformat(form.endDate, "mm/dd/yyyy")#')
								)
						AND 	Bookings.Deleted = 0
						AND 	Docks.Status = 'M'
						ORDER BY Bookings.startDate, Bookings.endDate
					</cfquery>

					<cfif getMaintenance.RecordCount GT 0>
						<cfoutput query="getMaintenance">
							<cfset Variables.id = #BookingID#>
							<form name="MaintenanceEdit#id#" action="editMaintBlock.cfm?#urltoken#" method="post">
								<input type="hidden" name="BookingID" value="#id#" />
							</form>
							<form name="MaintenanceDel#id#" action="deleteMaintBlock_confirm.cfm?#urltoken#" method="post">
								<input type="hidden" name="BookingID" value="#id#" />
							</form>
						</cfoutput>
					</cfif>
					<table class="basic">
						<tr>
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

								<cfset Variables.id = #BookingID#>
								<tr>
									<td headers="Start" nowrap>#dateformat(startDate, "mmm d, yyyy")#</td>
									<td headers="End" nowrap>#dateformat(endDate, "mmm d, yyyy")#</td>
									<td headers="Section">
										<cfif getMaintenance.Section1 AND getMaintenance.Section2 AND getMaintenance.Section3>
											All Sections
										<cfelse>
											<cfif getMaintenance.Section1>Section 1</cfif>
											<cfif getMaintenance.Section2><cfif getMaintenance.Section1> &amp; </cfif>Section 2</cfif>
											<cfif getMaintenance.Section3><cfif getMaintenance.Section1 OR getMaintenance.Section2> &amp; </cfif>Section 3</cfif>
										</cfif>
									</td>
									<td><a href="javascript:EditSubmit('MaintenanceEdit#id#');">Edit</a></td>
									<td><a href="javascript:EditSubmit('MaintenanceDel#id#');">#variables.actionCap#</a></td>
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

					<cfoutput><a href="addMaintBlock.cfm?#urltoken#" class="textbutton">Add New Maintenance Block</a></cfoutput>

				</cfif>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
