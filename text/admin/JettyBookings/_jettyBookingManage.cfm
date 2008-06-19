<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Jetty Booking Management"">
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

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFINCLUDE template="#RootDir#includes/calendar_js.cfm">

<div class="breadcrumbs">
	<a href="<cfoutput>http://www.pwgsc.gc.ca/text/home-#lang#.html</cfoutput>">PWGSC</a> &gt; 
	Pacific Region &gt; 
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-e.html">Esquimalt Graving Dock</a> &gt; 
  <CFOUTPUT>
		<a href="#RootDir#text/booking-#lang#.cfm">Booking</A> &gt;<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
			<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
		<CFELSE>
			 <a href="#RootDir#text/booking/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
		</CFIF>
	</CFOUTPUT>
	Jetty Booking Management
</div>

<div class="main">
<H1>Jetty Booking Management</H1>
<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>


<cfif IsDefined("form.startDate")>
	<cfset url.StartDate = "#form.StartDate#">
</cfif>
<cfif IsDefined("form.EndDate")>
	<cfset url.EndDate = "#form.EndDate#">
</cfif>
<!--checking if enddate is defined instead of showConfirmed is not a mistake!-->
<cfif IsDefined("form.EndDate")>
	<cfif IsDefined("form.showConfirmed")>
		<cfset url.showConfirmed = "#form.showConfirmed#">
	<cfelse>
		<cfset url.showConfirmed = "off">
	</cfif>
</cfif>
<cfif IsDefined("form.EndDate")>
	<cfif IsDefined("form.showPending")>
		<cfset url.showPending = "#form.showPending#">
	<cfelse>
		<cfset url.showPending = "off">
	</cfif>
</cfif>


<cfparam name="form.startDate" default="#PacificNow#">
<cfparam name="form.endDate" default="#DateAdd('d', 30, PacificNow)#">
<cfparam name="Variables.startDate" default="#form.startDate#">
<cfparam name="Variables.endDate" default="#form.endDate#">
<cfparam name="url.startDate" default="#Variables.startDate#">
<cfparam name="url.endDate" default="#Variables.endDate#">
<cfparam name="form.showConfirmed" default="off">
<cfparam name="Variables.showConfirmed" default="#form.showConfirmed#">
<cfparam name="url.showConfirmed" default="#Variables.showConfirmed#">
<cfparam name="form.ShowPending" default="off">
<cfparam name="Variables.ShowPending" default="#form.ShowPending#">
<cfparam name="url.ShowPending" default="#Variables.ShowPending#">

<!---<cflock scope="session" timeout="10" type="readonly">
	<cfif IsDefined("Session.Return_Structure")>
		<cfset Form_Array = ArrayNew(1)>
		<cfset Form_Array = StructKeyArray(Session.Return_Structure)>
		
		<cfloop index="i" from="1" to="#ArrayLen(Form_Array)#" step="1">
			<cfif Form_Array[i] NEQ "FIELDNAMES" AND Form_Array[i] NEQ "Errors">
				<cfset Curr_Var = "Variables." & #Form_Array[i]#>
				<cfset Curr_Element = "Session.Return_Structure." & #Form_Array[i]#>
				<cfset "#Curr_Var#" = EVALUATE(Curr_Element)>
			</cfif>
		</cfloop>
	</cfif>
</cflock>


<cfif IsDefined("Session.Return_Structure.Errors") AND ArrayLen(Session.Return_Structure.Errors) GT 0>
<table width="100%" cellspacing="0" cellpadding="1" border="0">
  <tr> 
	<td bgcolor="#8CA2C0"> 
	  <table width="100%" cellspacing="0" cellpadding="10" border="0">
		<tr> 
		  <td bgcolor="#F6F6F6"> 
			<div class="error_message">There was a problem submitting the form.</div>
					
			<cfloop index="i" from="1" to="#ArrayLen(Session.Return_Structure.Errors)#" step="1">
				<cfoutput>#Session.Return_Structure.Errors[i]#<br></cfoutput>
			</cfloop>
			</td>
		</tr>
	  </table>
	</td>
  </tr>
</table>
</cfif>

<cfif IsDefined("Session.Return_Structure")>
	<cfset url.StartDate = "#Variables.StartDate#">
	<cfset url.EndDate = "#Variables.EndDate#">
	<cfset url.ShowConfirmed = "#Variables.ShowConfirmed#">
	<cfset url.ShowPending = "#Variables.ShowPending#">
</cfif>

<cfif IsDefined("Session.Return_Structure")>
	<cfset StructDelete(Session, "Return_Structure")>
</cfif>--->

<cfform action="jettyBookingmanage.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" method="post" name="dateSelect">
	Please enter a range of dates for which you would like to see the bookings:<br>
	<table align="center" style="width: 100%;">
		<tr>
			<td>
				<label for="start">Start Date:</label>
			</td>
			<td colspan="2">
				<CFOUTPUT>
				<!---input class="textField" type="Text" name="startDateShow" id="start" disabled value="#DateFormat(startDate, 'mmm d, yyyy')#" size="17"--->
				<input type="text" name="startDate" size="15" maxlength="10" value="#DateFormat(startDate, 'mm/dd/yyyy')#" class="textField"> <font class="light">#language.dateform#</font></CFOUTPUT>
				<a href="javascript:void(0);" onclick="javascript:getCalendar('dateSelect', 'start')" class="textbutton">calendar</a>
				<!---a href="javascript:void(0);" onClick="javascript:document.dateSelect.startDateShow.value=''; document.dateSelect.startDate.value='';" class="textbutton">clear</a--->
			</td>
		</tr>
		<tr>
			<td>
				<label for="end">End Date:</label>
			</td>
			<td colspan="2">
				<CFOUTPUT>
				<!---input type="text" name="endDateShow" id="end" class="textField" disabled value="#DateFormat(endDate, 'mmm d, yyyy')#" size="17"--->
				<input type="text" name="endDate" size="15" maxlength="10" value="#DateFormat(endDate, 'mm/dd/yyyy')#" class="textField"> <font class="light">#language.dateform#</font></CFOUTPUT>
				<a href="javascript:void(0);" onclick="javascript:getCalendar('dateSelect', 'end')" class="textbutton">calendar</a>
				<!---a href="javascript:void(0);" onClick="javascript:document.dateSelect.endDateShow.value=''; document.dateSelect.endDate.value='';" class="textbutton">clear</a--->
			</td>
		</tr>
		<tr>
			<td>Show only:</td>	
			<td align="right" width="15%"><input type="checkbox" name="showPending" id="showPending"<cfif url.showPending EQ "on"> checked="true"</cfif>></td>
			<td align="left"><label for="showPending">Pending</label></td>	
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td align="right" width="15%"><input type="checkbox" name="showConfirmed" id="showConfirmed" <cfif url.showConfirmed EQ "on">checked="true"</cfif>></td>
			<td align="left"><label for="showConfirmed">Confirmed</label></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td align="right"><!---a href="javascript:validate('dateSelect');" class="textbutton">Submit</a></td---><input type="submit" value="Submit" class="textbutton">
		</tr>
	</table>
	<br>
	<!---<div align="center">
		<!--a href="javascript:document.dateSelect.submitForm.click();" class="textbutton">Submit</a><br-->
		<a href="javascript:validate('dateSelect');" class="textbutton">Submit</a><br>
	</div>--->
	
</cfform>


<cfif url.startDate NEQ "" and url.endDate NEQ "">
	<cfif isDate(form.startDate)>
		<cfset proceed = "yes">
	</cfif>
</cfif>

<cfif isdefined('proceed') and proceed EQ "yes">
	
	<cfoutput>
		<cfparam name="form.expandAll" default="">
		<form action="jettyBookingmanage.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" method="post" name="expandAll">
			<input type="hidden" name="startDate" value="#url.startDate#">
			<input type="hidden" name="endDate" value="#url.endDate#">
			<cfif form.expandAll NEQ "yes">
				<input type="hidden" name="expandAll" value="yes">
			<cfelse>
				<input type="hidden" name="expandAll" value="no">
			</cfif>
			<input type="hidden" name="showConfirmed" value="#url.showConfirmed#">
			<input type="hidden" name="showPending" value="#url.showPending#">
		</form>
	</cfoutput>

	<br>
	<table width="100%" cellspacing="0" cellpadding="0" style="padding-bottom: 5px; ">
		<tr>
			<cfoutput><td align="left" width="80%"><a href="addJettybooking.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" class="textbutton">Add New South Jetty / North Landing Wharf Booking</a></td></cfoutput>
			<td>&nbsp;</td><td>&nbsp;</td>
			<cfif form.expandAll NEQ "yes">
				<td align="right" width="20%"><a href="javascript:EditSubmit('expandAll');">Expand All</a></td>
			<cfelse>
				<td align="right" width="20%"><a href="javascript:EditSubmit('expandAll');">Collapse All</a></td>
			</cfif>
		</tr>
	</table>
	
<cfloop index="jetty" from="1" to="2" step="1">	
	<!---<div align="left"><a href="#RootDir#text/admin/JettyBookings/addJettybooking.cfm?lang=#lang#" class="textbutton">Add New Jetty Booking</a></div>
	<div align="right"><a href="javascript:EditSubmit('expandAll');">Expand All</a></div>--->
	<cfquery name="getBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT Bookings.*, Vessels.Name AS VesselName, Jetties.*
		FROM Jetties INNER JOIN Bookings ON Jetties.BookingID = Bookings.BookingID
				INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID
		WHERE ((Bookings.startDate >= '#dateformat(url.startDate, "mm/dd/yyyy")#'
				AND Bookings.startDate <= '#dateformat(url.endDate, "mm/dd/yyyy")#') 
			OR (Bookings.startDate <= '#dateformat(url.startDate, "mm/dd/yyyy")#'
				AND Bookings.endDate >= '#dateformat(url.endDate, "mm/dd/yyyy")#') 
			OR (Bookings.endDate >= '#dateformat(url.startDate, "mm/dd/yyyy")#'
				AND Bookings.endDate <= '#dateformat(url.endDate, "mm/dd/yyyy")#')) 
			AND Bookings.Deleted = '0'
		<cfif url.ShowConfirmed EQ "on" AND url.ShowPending EQ "off">
			AND Jetties.Status = 'C' 
		</cfif>
		<cfif url.ShowPending EQ "on" AND url.ShowConfirmed EQ "off">
			AND Jetties.Status = 'P' 
		</cfif>
		<cfif jetty EQ 1>
			AND Jetties.NorthJetty = '1'
		<cfelseif jetty EQ 2>
			AND Jetties.SouthJetty = '1'
		</cfif>
		ORDER BY Bookings.startDate, Bookings.endDate
	</cfquery>
	
	<DIV style="font-weight: bold; font-style: italic; min-height:20px; ">
		<cfif jetty EQ 1>North Landing Wharf
		<cfelseif jetty EQ 2>South Jetty
		</cfif>
	</DIV>
	
	<table class="calendar" cellpadding="3" cellspacing="0" width="100%">
		<tr>
			<th class="calendar" style="width: 20%; ">Start Date</th>
			<th class="calendar" style="width: 20%; ">End Date</th>
			<th class="calendar" style="width: 50%; ">Vessel Name</th>
			<th class="calendar" style="width: 10%; ">Status</th>
		</tr>
		
	<cfif getBookings.recordCount GT 0>
		<cfoutput query="getBookings">
			<cfset Variables.id = #BookingID#>
			
			<form name="booking#id#" action="jettyBookingmanage.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show####id#" method="post">
				<input type="hidden" name="startDate" value="#DateFormat(url.startDate, 'mm/dd/yyyy')#">
				<input type="hidden" name="endDate" value="#DateFormat(url.endDate, 'mm/dd/yyyy')#">
				<cfif isDefined("form.ID") AND form.ID EQ #id#>
					<input type="hidden" name="ID" value="0">
				<cfelse>
					<input type="hidden" name="ID" value="#id#">
				</cfif>
				<!---<input type="hidden" name="showConfirmed" value="#url.showConfirmed#">
				<input type="hidden" name="showPending" value="#url.showPending#">--->
			</form>
			
			<tr>
				<td class="calendar">#LSdateformat(startDate, 'mmm d, yyyy')#</td>
				<td class="calendar">#LSdateformat(endDate, 'mmm d, yyyy')#</td>
				<td class="calendar"><a href="javascript:EditSubmit('booking#id#');" name="#id#">#VesselName#</a></td>
				<td class="calendar"><cfif getBookings.Status EQ "C">Confirmed<cfelseif getBookings.Status EQ "P">Pending</cfif></td>
			</tr>
			
			<cfif (isDefined('form.id') AND form.id EQ id) OR form.expandAll EQ "yes">
			
				<cfquery name="getData" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT Bookings.*, Vessels.*, Users.LastName + ', ' + Users.FirstName AS UserName, 
							Companies.Name AS CompanyName, Jetties.*
					FROM Bookings INNER JOIN
						Vessels ON Bookings.VesselID = Vessels.VesselID INNER JOIN
						Companies ON Vessels.companyID = Companies.companyID INNER JOIN 
						UserCompanies ON Vessels.CompanyID = UserCompanies.CompanyID INNER JOIN 
						Users ON UserCompanies.UserID = Users.UserID INNER JOIN 
						Jetties ON Bookings.BookingID = Jetties.BookingID
					WHERE Bookings.BookingID = #ID#
				</cfquery>
				
				<form method="post" action="jettyBookingManage_action.cfm?startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" name="confBooking#ID#">
					<input type="hidden" name="ID" value="#id#">
					<input type="hidden" name="Status" value="C">
					<!--- <input type="hidden" name="startDate" value="#DateFormat(url.startDate, 'mm/dd/yyyy')#">
					<input type="hidden" name="endDate" value="#DateFormat(url.endDate, 'mm/dd/yyyy')#">
					<input type="hidden" name="showConfirmed" value="#url.showConfirmed#">
					<input type="hidden" name="showPending" value="#url.showPending#"> --->
				</form>
				
				<form method="post" action="jettyBookingManage_action.cfm?startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" name="UnConfBooking#ID#">
					<input type="hidden" name="ID" value="#id#">
					<input type="hidden" name="Status" value="P">
					<!--- <input type="hidden" name="startDate" value="#DateFormat(url.startDate, 'mm/dd/yyyy')#">
					<input type="hidden" name="endDate" value="#DateFormat(url.endDate, 'mm/dd/yyyy')#">
					<input type="hidden" name="showConfirmed" value="#url.showConfirmed#">
					<input type="hidden" name="showPending" value="#url.showPending#"> --->
				</form>
				
				<form method="post" action="editJettybooking.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" name="editBooking#ID#">
					<input type="hidden" name="ID" value="#id#">
				</form>
				
				<form method="post" action="deleteJettyBooking_confirm.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" name="delete#ID#">
					<input type="hidden" name="BookingID" value="#id#">
				</form>
				
				<tr><td colspan="5" class="calendar">
				
					<table class="showDetails" width="70%" border="0" cellpadding="1" cellspacing="0" align="center">
						<tr>
							<td><strong><em>Details</em></strong></td>
							<td align="right"><a href="javascript:EditSubmit('editBooking#ID#');">Edit Booking</a></td>
						</tr>
						<tr>
							<td width="25%">Start Date:</td>
							<td>#dateformat(getData.startDate, "mmm d, yyyy")#</td>
						</tr>
						<tr>
							<td>End Date:</td>
							<td>#dateformat(getData.endDate, "mmm d, yyyy")#</td>
						</tr>
						<tr>
							<td>## of Days:</td>
							<td>#datediff('d', getData.startDate, getData.endDate) + 1#</td>
						</tr>
						<tr>
							<td>Vessel:</td>
							<td>#getData.name#</td>
						</tr>
							<tr>
								<td>&nbsp;&nbsp;&nbsp;<i>Length:</i></td>
								<td><i>#getData.length# m</i></td>
							</tr>
							<tr>
								<td>&nbsp;&nbsp;&nbsp;<i>Width:</i></td>
								<td><i>#getData.width# m</i></td>
							</tr>
							<tr>
								<td>&nbsp;&nbsp;&nbsp;<i>Tonnage:</i></td>
								<td><i>#getData.tonnage#</i></td>
							</tr>
						<tr>
							<td>Agent:</td>
							<td>#getData.UserName#</td>
						</tr>
						<tr>
							<td>Company:</td>
							<td>#getData.companyName#</td>
						</tr>
						<tr>
							<td valign="top">North Jetty:</td>
							<td>
								<cfif getData.NorthJetty EQ 1>Yes<cfelse>No</cfif>
							</td>
						</tr>
						<tr>
							<td valign="top">South Jetty:</td>
							<td>
								<cfif getData.SouthJetty EQ 1>Yes<cfelse>No</cfif>
							</td>
						</tr>
						<tr>
							<td valign="top">Confirmed:</td>
							<td>
								<cfif getData.Status EQ "C">
									Yes&nbsp;&nbsp;&nbsp;
									<a href="javascript:EditSubmit('UnConfBooking#ID#');" class="textbutton">Remove Confirmation</a>
								<cfelseif getData.Status EQ "P">
									No&nbsp;&nbsp;&nbsp;
									<a href="javascript:EditSubmit('confBooking#ID#');" class="textbutton">Confirm</a>
								</cfif>
							</td>
						</tr>
						<tr>
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td><a href="javascript:EditSubmit('delete#ID#');" class="textbutton">Delete Booking</a></td>
						</tr>
						<tr>
							<td colspan="2">&nbsp;</td>
						</tr>
					</table>
				
				</td></tr>
	
			</cfif>
			
		</cfoutput>
	
	<cfelse>
		<tr><td colspan="4" class="calendar">There are currently no bookings for this date range.</td></tr>
	</cfif>
	</table>
	<cfif jetty EQ 1><br></cfif>

</cfloop>

<table width="100%" cellspacing="0" cellpadding="0" style="padding-top: 5px; ">
	<tr>
		<cfoutput><td align="left" width="80%"><a href="addJettybooking.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" class="textbutton">Add New South Jetty / North Landing Wharf Booking</a></td></cfoutput>
		<td>&nbsp;</td><td>&nbsp;</td>
		<cfif form.expandAll NEQ "yes">
			<td align="right" width="20%"><a href="javascript:EditSubmit('expandAll');">Expand All</a></td>
		<cfelse>
			<td align="right" width="20%"><a href="javascript:EditSubmit('expandAll');">Collapse All</a></td>
		</cfif>
	</tr>
</table>
</cfif>
<br>
<DIV style="font-style: italic; font-weight: bold; min-height: 20px; ">Maintenance</DIV>
<table width="100%" cellspacing="0" cellpadding="0" style="padding-bottom: 5px; ">
	<tr>
		<cfoutput><td align="left" width="50%"><a href="addJettyMaintBlock.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" class="textbutton">Add New Maintenance Block</a></td></cfoutput>
	</tr>
</table>
<table class="calendar" cellpadding="3" cellspacing="0" width="100%">
		<tr align="center" style="font-weight:bold;background-color:#cccccc;">
			<th class="calendar" style="width: 20%;">Start Date</th>
			<th class="calendar" style="width: 20%;">End Date</th>
			<th class="calendar" style="width: 40%;">Section</th>
			<th class="calendar" colspan="2" style="width: 20%;">&nbsp;</th>
		</tr>	
	
	<cfquery name="getMaintenance" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT 	Bookings.*, Jetties.NorthJetty, Jetties.SouthJetty
		FROM 	Bookings INNER JOIN Jetties ON Bookings.BookingID = Jetties.BookingID
		WHERE	(
					(Bookings.startDate >= '#dateformat(url.startDate, "mm/dd/yyyy")#'	AND Bookings.startDate <= '#dateformat(url.endDate, "mm/dd/yyyy")#') 
				OR	(Bookings.startDate <= '#dateformat(url.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate >= '#dateformat(url.endDate, "mm/dd/yyyy")#') 
				OR 	(Bookings.endDate >= '#dateformat(url.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate <= '#dateformat(url.endDate, "mm/dd/yyyy")#')
				)		
		AND 	Bookings.Deleted = 0
		AND 	Jetties.Status = 'M'	
		ORDER BY Bookings.startDate, Bookings.endDate	
	</cfquery>
	<cfif getMaintenance.RecordCount GT 0>
		<cfoutput query="getMaintenance">
			<cfset Variables.id = #BookingID#>

			<form name="MaintenanceEdit#id#" action="editJettyMaintBlock.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" method="post">
				<input type="hidden" name="BookingID" value="#id#">
			</form>
			<form name="MaintenanceDel#id#" action="deleteJettyMaintBlock_confirm.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" method="post">
				<input type="hidden" name="BookingID" value="#id#">
			</form>
			<tr>
				<td class="calendar">#dateformat(startDate, "mmm d, yyyy")#</td>
				<td class="calendar">#dateformat(endDate, "mmm d, yyyy")#</td>
				<td class="calendar">
					<CFIF NorthJetty>North Jetty</CFIF>
					<CFIF SouthJetty><CFIF NorthJetty> &amp; </CFIF>South Jetty</CFIF>
				</td>
				<td class="calendar"><a href="javascript:EditSubmit('MaintenanceEdit#id#');">Edit</a></td>
				<td class="calendar"><a href="javascript:EditSubmit('MaintenanceDel#id#');">Del.</a></td>
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
		<cfoutput><td align="left" width="50%"><a href="addJettyMaintBlock.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" class="textbutton">Add New Maintenance Block</a></td></cfoutput>
	</tr>
</table>
<br>

</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">