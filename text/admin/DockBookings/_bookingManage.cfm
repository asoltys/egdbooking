<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Drydock Booking Management"">
<meta name=""keywords"" lang=""eng"" content="""">
<meta name=""description"" lang=""eng"" content="""">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Drydock Booking Management</title>
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
	Drydock Booking Management
</div>

<div class="main">
<H1>Drydock Booking Management</H1>
<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>

<cfif IsDefined("form.startDate")>
	<cfset url.StartDate = "#form.StartDate#">
</cfif>
<cfif IsDefined("form.EndDate")>
	<cfset url.EndDate = "#form.EndDate#">
</cfif>
<!--checking if enddate is defined instead of showConfirmed is not a mistake!-->
<cfif IsDefined("form.EndDate")>
	<cfif IsDefined("form.showApproved")>
		<cfset url.showApproved = "#form.showApproved#">
	<cfelse>
		<cfset url.showApproved = "off">
	</cfif>
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
<cfparam name="form.showApproved" default="off">
<cfparam name="form.showConfirmed" default="off">
<cfparam name="form.showPending" default="off">
<cfparam name="Variables.showApproved" default="#form.showApproved#">
<cfparam name="Variables.showConfirmed" default="#form.showConfirmed#">
<cfparam name="Variables.showPending" default="#form.showPending#">
<cfparam name="url.showApproved" default="#Variables.showApproved#">
<cfparam name="url.showConfirmed" default="#Variables.showConfirmed#">
<cfparam name="url.showPending" default="#Variables.showPending#">

<!--- <cflock scope="session" timeout="10" type="readonly">
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
	<cfset url.ShowApproved = "#Variables.ShowApproved#">
	<cfset url.ShowConfirmed = "#Variables.ShowConfirmed#">
	<cfset url.ShowPending = "#Variables.ShowPending#">
</cfif>

<cfif IsDefined("Session.Return_Structure")>
	<cfset StructDelete(Session, "Return_Structure")>
</cfif>--->


<cfform action="_bookingmanage.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yy')#&showconfirmed=#url.showconfirmed#&showpending=#url.showpending#&showapproved=#url.showapproved#" method="post" name="dateSelect">
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
			<td align="right" width="15%"><input type="checkbox" id="showPending" name="showPending" value="yes" <cfif url.showPending EQ "yes">checked</cfif>></td>
			<td align="left"><label for="showPending">Pending</label></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td align="right" width="15%"><input type="checkbox" id="showApproved" name="showApproved" value="yes" <cfif url.showApproved EQ "yes">checked</cfif>></td>
			<td align="left"><label for="showApproved">Tentative</label></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td align="right" width="15%"><input type="checkbox" id="showConfirmed" name="showConfirmed" value="yes" <cfif url.showConfirmed EQ "yes">checked</cfif>></td>
			<td align="left"><label for="showConfirmed">Confirmed</label></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td align="right"><!--a href="javascript:validate('dateSelect');" class="textbutton">Submit</a--><input type="submit" name="submitForm" class="textbutton" value="submit"></td>
		</tr>
	</table>

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
	
	<cfparam name="form.expandAll" default="">
	<cfoutput><form action="_bookingmanage.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&showconfirmed=#url.showconfirmed#&showpending=#url.showpending#&showapproved=#url.showapproved#" method="post" name="expandAll"></cfoutput>
		<input type="hidden" name="startDate" value="<cfoutput>#url.startdate#</cfoutput>">
		<input type="hidden" name="endDate" value="<cfoutput>#url.endDate#</cfoutput>">
		<cfif form.expandAll NEQ "yes">
			<input type="hidden" name="expandAll" value="yes">
		<cfelse>
			<input type="hidden" name="expandAll" value="no">
		</cfif>
		<input type="hidden" name="showApproved" value="<cfoutput>#url.showApproved#</cfoutput>">
		<input type="hidden" name="showConfirmed" value="<cfoutput>#url.showConfirmed#</cfoutput>">
		<input type="hidden" name="showPending" value="<cfoutput>#url.showPending#</cfoutput>">
	</form>
	
	<!---<div align="right"><a href="javascript:EditSubmit('expandAll');">Expand All</a></div>--->
	<DIV style="font-weight: bold; font-style: italic; min-height:20px; ">Drydock</DIV>
	
	<table width="100%" cellspacing="0" cellpadding="0" style="padding-bottom: 5px; ">
		<tr>
			<cfoutput><td align="left" width="50%"><a href="addbooking.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&showconfirmed=#url.showconfirmed#&showpending=#url.showpending#&showapproved=#url.showapproved#" class="textbutton">Add New Drydock Booking</a></td></cfoutput>
			<td>&nbsp;</td><td>&nbsp;</td>
			<cfif form.expandAll NEQ "yes">
				<td align="right" width="50%"><a href="javascript:EditSubmit('expandAll');">Expand All</a></td>
			<cfelse>
				<td align="right" width="50%"><a href="javascript:EditSubmit('expandAll');">Collapse All</a></td>
			</cfif>
		</tr>
	</table>
	
	<table class="calendar" cellpadding="3" cellspacing="0" width="100%">
		<tr align="center" style="font-weight:bold;background-color:#cccccc;">
			<th class="calendar" style="width: 20%;">Start Date</th>
			<th class="calendar" style="width: 20%;">End Date</th>
			<th class="calendar" style="width: 50%;">Vessel Name</th>
			<th class="calendar" style="width: 10%;">Status</th>
		</tr>
		
		
		<cfquery name="getBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT 	Bookings.*, Vessels.Name AS VesselName, Docks.Status
			FROM 	Bookings INNER JOIN Vessels ON Bookings.VesselID = Vessels.VesselID
						INNER JOIN Docks ON Bookings.BookingID = Docks.BookingID
			WHERE  ((Bookings.startDate >= '#dateformat(url.startDate, "mm/dd/yyyy")#'
					AND Bookings.startDate <= '#dateformat(url.endDate, "mm/dd/yyyy")#') 
				OR (Bookings.startDate <= '#dateformat(url.startDate, "mm/dd/yyyy")#'
					AND Bookings.endDate >= '#dateformat(url.endDate, "mm/dd/yyyy")#') 
				OR (Bookings.endDate >= '#dateformat(url.startDate, "mm/dd/yyyy")#'
					AND Bookings.endDate <= '#dateformat(url.endDate, "mm/dd/yyyy")#'))		
				AND Bookings.Deleted = 0
			<cfif url.ShowPending EQ "yes" AND url.ShowApproved EQ "off" AND url.ShowConfirmed EQ "off">
				AND Docks.Status = 'P'
			</cfif>
			<cfif url.ShowApproved EQ "yes" AND url.ShowPending EQ "off" AND url.ShowConfirmed EQ "off">
				AND Docks.Status = 'T'
			</cfif>
			<cfif url.ShowConfirmed EQ "yes" AND url.ShowPending EQ "off" AND url.ShowApproved EQ "off">
				AND Docks.Status = 'C'
			</cfif>	
			<cfif url.ShowPending EQ "yes" AND url.ShowApproved EQ "yes" AND url.ShowConfirmed EQ "off">
				AND (Docks.Status = 'C')
			</cfif>	
			<cfif url.ShowPending EQ "yes" AND url.ShowApproved EQ "off" AND url.ShowConfirmed EQ "yes">
				AND ((Docks.Status = 'C') OR (Docks.Status = 'P'))
			</cfif>	
			<cfif url.ShowPending EQ "off" AND url.ShowApproved EQ "yes" AND url.ShowConfirmed EQ "yes">
				AND ((Docks.Status = 'C') OR (Docks.Status = 'T'))
			</cfif>	
			ORDER BY Bookings.startDate, Bookings.endDate	
		</cfquery>
		
		<cfif getBookings.RecordCount GT 0>
			<cfoutput query="getBookings">
				<cfset Variables.id = #BookingID#>
	
				<form name="booking#id#" action="_bookingmanage.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&showconfirmed=#url.showconfirmed#&showpending=#url.showpending#&showapproved=#url.showapproved####id#" method="post">
					<input type="hidden" name="startDate" value="#url.startDate#">
					<input type="hidden" name="endDate" value="#url.endDate#">
					<cfif isDefined("form.ID") AND form.ID EQ #id#>
						<input type="hidden" name="ID" value="0">
					<cfelse>
						<input type="hidden" name="ID" value="#id#">
					</cfif>
					<input type="hidden" name="showApproved" value="#url.showApproved#">
					<input type="hidden" name="showConfirmed" value="#url.showConfirmed#">
					<input type="hidden" name="showPending" value="#url.showPending#">
				</form>
				
				<tr>
					<td class="calendar">#LSdateformat(startDate, "mmm d, yyyy")#</td>
					<td class="calendar">#LSdateformat(endDate, "mmm d, yyyy")#</td>
					<td class="calendar"><a href="javascript:EditSubmit('booking#id#');" name="#id#">#VesselName#</a></td>
					<td class="calendar"><cfif status EQ "C">Confirmed<cfelseif status EQ "T">Tentative<cfelseif status EQ "P">Pending</cfif></td>
				</tr>
				
				<cfif (isDefined('form.id') AND form.id EQ id) OR form.expandAll EQ "yes">
				
					<cfquery name="getData" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
						SELECT 	Bookings.StartDate, Bookings.EndDate, Vessels.Name AS VesselName, Vessels.*, 
								Users.LastName + ', ' + Users.FirstName AS UserName, 
								Companies.Name AS CompanyName, Docks.Section1, Docks.Section2, Docks.Section3,
								Docks.Status, BookingTime
						FROM 	Bookings, Docks, Vessels, Users, Companies, UserCompanies
						WHERE	Bookings.VesselID = Vessels.VesselID
						AND		Vessels.CompanyID = Companies.CompanyID
						AND		Companies.CompanyID = UserCompanies.CompanyID 
						AND		UserCompanies.UserID = Users.UserID
						AND		Bookings.BookingID = '#ID#'
						AND		Docks.BookingID = Bookings.BookingID
					</cfquery>
					
					<form method="post" action="chgStatus_2c.cfm?startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&showconfirmed=#url.showconfirmed#&showpending=#url.showpending#&showapproved=#url.showapproved#" name="chgStatus_2c#ID#">
						<input type="hidden" name="BookingID" value="#id#">
					</form>
					
					<form method="post" action="chgStatus_2p.cfm?startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&showconfirmed=#url.showconfirmed#&showpending=#url.showpending#&showapproved=#url.showapproved#" name="chgStatus_2p#ID#">
						<input type="hidden" name="BookingID" value="#id#">
					</form>
					
					<form method="post" action="chgStatus_2t.cfm?startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&showconfirmed=#url.showconfirmed#&showpending=#url.showpending#&showapproved=#url.showapproved#" name="chgStatus_2t#ID#">
						<input type="hidden" name="BookingID" value="#id#">
					</form>
	
					<form method="post" action="editbooking.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&showconfirmed=#url.showconfirmed#&showpending=#url.showpending#&showapproved=#url.showapproved#" name="editBooking#ID#">
						<input type="hidden" name="BookingID" value="#id#">
					</form>
					
					<form method="post" action="feesForm_admin.cfm?startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&showconfirmed=#url.showconfirmed#&showpending=#url.showpending#&showapproved=#url.showapproved#" name="viewForm#ID#">
						<input type="hidden" name="BookingID" value="#id#">
					</form>
					
					<form method="post" action="deleteBooking_confirm.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&showconfirmed=#url.showconfirmed#&showpending=#url.showpending#&showapproved=#url.showapproved#" name="delete#ID#">
						<input type="hidden" name="BookingID" value="#id#">
					</form>
					
					<tr><td colspan="5" class="calendar">
					
						<table class="showDetails" width="70%" border="0" cellpadding="1" cellspacing="0" align="center">
							<tr>
								<td><strong><em>Details</em></strong></td>
								<td align="right"><a href="javascript:EditSubmit('editBooking#ID#');">Edit Booking</a></td>
							</tr>
							<tr>
								<td width="30%">Start Date:</td>
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
								<td>#getData.vesselName#</td>
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
								<td>Booking Time:</td>
								<td>#DateFormat(getData.bookingTime,"mmm d, yyyy")# #TimeFormat(getData.bookingTime,"long")#</td>
							</tr>
							<tr>
								<td>Section(s):</td>
								<td>
									<!--- <CFIF getData.Section1>Drydock 1</CFIF>
									<CFIF getData.Section2><CFIF getData.Section1> &amp; </CFIF>Drydock 2</CFIF>
									<CFIF getData.Section3><CFIF getData.Section1 OR getData.Section2> &amp; </CFIF>Drydock 3</CFIF> --->
									<CFIF getData.Section1>1</CFIF>
									<CFIF getData.Section2>2</CFIF>
									<CFIF getData.Section3>3</CFIF>
									<CFIF NOT getData.Section1 AND NOT getData.Section2 AND NOT getData.Section3>Unassigned</CFIF>
								</td>
							</tr>
							<tr>
								<td valign="top">Status:</td>
								<td>
									<cfif getData.Status EQ "C">
										Confirmed
										&nbsp;&nbsp;&nbsp;<a href="javascript:EditSubmit('chgStatus_2p#ID#');" class="textbutton">Make Pending</a>
										<DIV style="height: 5px; ">&nbsp;</DIV>
										<div style="padding-left:74px;"><a href="javascript:EditSubmit('chgStatus_2t#ID#');" class="textbutton">Make Tentative</a></div>
									<cfelseif getData.Status EQ "T">
										Tentative
										&nbsp;&nbsp;&nbsp;<a href="javascript:EditSubmit('chgStatus_2p#ID#');" class="textbutton">Make Pending</a>
										<DIV style="height: 5px; ">&nbsp;</DIV>
										<div style="padding-left:67px;"><a href="javascript:EditSubmit('chgStatus_2c#ID#');" class="textbutton">Make Confirmed</a></div>
									<cfelse>
										Pending
										&nbsp;&nbsp;&nbsp;<a href="javascript:EditSubmit('chgStatus_2t#ID#');" class="textbutton">Make Tentative</a>
										<DIV style="height: 5px; ">&nbsp;</DIV>
										<div style="padding-left:63px;"><a href="javascript:EditSubmit('chgStatus_2c#ID#');" class="textbutton">Make Confirmed</a></div>
									</cfif>
								</td>
							</tr>
							<tr>
								<td colspan="2">&nbsp;</td>
							</tr>
							<tr>
								<td align="center" colspan="2"><a href="javascript:EditSubmit('viewForm#ID#');" class="textbutton">View / Edit Tariff Form</a>
								<a href="javascript:EditSubmit('delete#ID#');" class="textbutton">Delete Booking</a></td>
							</tr>
							<tr>
								<td colspan="2">&nbsp;
									
									
									
								</td>
							</tr>
						</table>
					
					</td></tr>
				</cfif>
			</cfoutput>
			
		<cfelse>
			<tr style="font-size:10pt;">
				<td colspan="4" class="calendar">
					There are no bookings for this date range.
				</td>
			</tr>
		</cfif>
		
	</table>
	<table width="100%" cellspacing="0" cellpadding="0" style="padding-top: 5px; ">
		<tr>
			<cfoutput><td align="left" width="50%"><a href="addbooking.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&showconfirmed=#url.showconfirmed#&showpending=#url.showpending#&showapproved=#url.showapproved#" class="textbutton">Add New Drydock Booking</a></td></cfoutput>
			<td>&nbsp;</td><td>&nbsp;</td>
			<cfif form.expandAll NEQ "yes">
				<td align="right" width="50%"><a href="javascript:EditSubmit('expandAll');">Expand All</a></td>
			<cfelse>
				<td align="right" width="50%"><a href="javascript:EditSubmit('expandAll');">Collapse All</a></td>
			</cfif>
		</tr>
	</table>
	<br>
	<DIV style="font-weight: bold; font-style: italic; min-height:20px; ">Maintenance</DIV>

	<table width="100%" cellspacing="0" cellpadding="0" style="padding-bottom: 5px; ">
		<tr>
			<cfoutput><td align="left" width="50%"><a href="addMaintBlock.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&showconfirmed=#url.showconfirmed#&showpending=#url.showpending#&showapproved=#url.showapproved#" class="textbutton">Add New Maintenance Block</a></td></cfoutput>
		</tr>
	</table>
	
	<table class="calendar" cellpadding="3" cellspacing="0" width="100%">
		<tr style="font-weight:bold;background-color:#cccccc;">
			<th class="calendar" style="width: 20%;">Start Date</th>
			<th class="calendar" style="width: 20%;">End Date</th>
			<th class="calendar" style="width: 40%;">Section</th>
			<th class="calendar" colspan="2" style="width: 20%;">&nbsp;</th>
		</tr>
		
		
		<cfquery name="getMaintenance" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT 	Bookings.*, Docks.Section1, Docks.Section2, Docks.Section3
			FROM 	Bookings INNER JOIN Docks ON Bookings.BookingID = Docks.BookingID
			WHERE	(
						(Bookings.startDate >= '#dateformat(url.startDate, "mm/dd/yyyy")#'	AND Bookings.startDate <= '#dateformat(url.endDate, "mm/dd/yyyy")#') 
					OR	(Bookings.startDate <= '#dateformat(url.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate >= '#dateformat(url.endDate, "mm/dd/yyyy")#') 
					OR 	(Bookings.endDate >= '#dateformat(url.startDate, "mm/dd/yyyy")#'	AND Bookings.endDate <= '#dateformat(url.endDate, "mm/dd/yyyy")#')
					)		
			AND 	Bookings.Deleted = 0
			AND 	Docks.Status = 'M'	
			ORDER BY Bookings.startDate, Bookings.endDate	
		</cfquery>
		<cfif getMaintenance.RecordCount GT 0>
			<cfoutput query="getMaintenance">
				<cfset Variables.id = #BookingID#>
	
				<form name="MaintenanceEdit#id#" action="editMaintBlock.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&showconfirmed=#url.showconfirmed#&showpending=#url.showpending#&showapproved=#url.showapproved#" method="post">
					<input type="hidden" name="BookingID" value="#id#">
				</form>
				<form name="MaintenanceDel#id#" action="deleteMaintBlock_confirm.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&showconfirmed=#url.showconfirmed#&showpending=#url.showpending#&showapproved=#url.showapproved#" method="post">
					<input type="hidden" name="BookingID" value="#id#">
				</form>
				<tr style="font-size:10pt;">
					<td class="calendar">#dateformat(startDate, "mmm d, yyyy")#</td>
					<td class="calendar">#dateformat(endDate, "mmm d, yyyy")#</td>
					<td class="calendar">
						<CFIF getMaintenance.Section1>1</CFIF>
						<CFIF getMaintenance.Section2>2</CFIF>
						<CFIF getMaintenance.Section3>3</CFIF>
					</td>
					<td class="calendar"><a href="javascript:EditSubmit('MaintenanceEdit#id#');">Edit</a></td>
					<td class="calendar"><a href="javascript:EditSubmit('MaintenanceDel#id#');">Del</a></td>
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
			<cfoutput><td align="left" width="50%"><a href="addMaintBlock.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&showconfirmed=#url.showconfirmed#&showpending=#url.showpending#&showapproved=#url.showapproved#" class="textbutton">Add New Maintenance Block</a></td></cfoutput>
		</tr>
	</table>
	
</cfif>

<br>

</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">