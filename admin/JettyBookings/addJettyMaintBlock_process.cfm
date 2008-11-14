<cfif isDefined("form.startDate")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Add Maintenance Block"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Add Maintenance Block</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

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
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt; 
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			<a href="jettyBookingManage.cfm?lang=#lang#">Jetty Management</a> &gt;
			Add Maintenance Block
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Add Maintenance Block
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				<!--- ---------------------------------------------------------------------------------------------------------------- --->
				<cfparam name = "Form.StartDate" default="">
				<cfparam name = "Form.EndDate" default="">
				<cfparam name = "Variables.StartDate" default = "#CreateODBCDate(Form.StartDate)#">
				<cfparam name = "Variables.EndDate" default = "#CreateODBCDate(Form.EndDate)#">
				<cfparam name = "Variables.NorthJetty" default = "0">
				<cfparam name = "Variables.SouthJetty" default = "0">
				
				<cfif IsDefined("Form.NorthJetty")>
					<cfset Variables.NorthJetty = 1>
				</cfif>
				<cfif IsDefined("Form.SouthJetty")>
					<cfset Variables.SouthJetty = 1>
				</cfif>
				
				<!--- <cfset Variables.StartDate = CreateODBCDate(#Variables.StartDate#)>
				<cfset Variables.EndDate = CreateODBCDate(#Variables.EndDate#)> --->
				
				<cfif IsDefined("Session.Return_Structure")>
					<cfoutput>#StructDelete(Session, "Return_Structure")#</cfoutput>
				</cfif>
				
				
				<cfquery name="checkDblBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT 	NorthJetty, SouthJetty, StartDate, EndDate
					FROM 	Bookings, Jetties
					WHERE 	Jetties.BookingID = Bookings.BookingID
					AND		Status = 'M'
					AND		Deleted = '0'
					AND 	(
								(	Bookings.StartDate <= #Variables.StartDate# AND #Variables.StartDate# <= Bookings.EndDate )
							OR 	(	Bookings.StartDate <= #Variables.EndDate# AND #Variables.EndDate# <= Bookings.EndDate )
							OR	(	Bookings.StartDate >= #Variables.StartDate# AND #Variables.EndDate# >= Bookings.EndDate )
							)
					AND		(	
								(	NorthJetty = '1' AND '#Variables.NorthJetty#' = '1')
							OR	( 	SouthJetty = '1' AND '#Variables.SouthJetty#' = '1')
							)
				</cfquery>
				
				<cfset Variables.StartDate = DateFormat(Variables.StartDate, 'mm/dd/yyy')>
				<cfset Variables.EndDate = DateFormat(Variables.EndDate, 'mm/dd/yyy')>
				
				<cfset Errors = ArrayNew(1)>
				<cfset Success = ArrayNew(1)>
				<cfset Proceed_OK = "Yes">
				
				<!--- Validate the form data --->
				<cfif (NOT isDefined("Form.NorthJetty")) AND (NOT isDefined("Form.SouthJetty"))>
					<cfoutput>#ArrayAppend(Errors, "You must choose at least one of the jetties for maintenance bookings.")#</cfoutput>
					no sections
					<cfset Proceed_OK = "No">
				</cfif>
				
				<cfif checkDblBooking.RecordCount GT 0>
					<cfif checkDblBooking.NorthJetty AND checkDblBooking.SouthJetty>
						<cfoutput>#ArrayAppend(Errors, "There is already a maintenance booking for both jetties from #DateFormat(checkDblBooking.startDate, 'mmm d, yyyy')# to #DateFormat(checkDblBooking.endDate, 'mmm d, yyyy')#.")#</cfoutput>
					<cfelseif checkDblBooking.NorthJetty>
						<cfoutput>#ArrayAppend(Errors, "There is already a maintenance booking for the North Landing Wharf from #DateFormat(checkDblBooking.startDate, 'mmm d, yyyy')# to #DateFormat(checkDblBooking.endDate, 'mmm d, yyyy')#.")#</cfoutput>
					<cfelse>
						<cfoutput>#ArrayAppend(Errors, "There is already a maintenance booking for the South Jetty from #DateFormat(checkDblBooking.startDate, 'mmm d, yyyy')# to #DateFormat(checkDblBooking.endDate, 'mmm d, yyyy')#.")#</cfoutput>
					</cfif>
					<cfset Proceed_OK = "No">
				</cfif>
				
				<cfif Variables.StartDate GT Variables.EndDate>
					<cfoutput>#ArrayAppend(Errors, "The Start Date must be before the End Date.")#</cfoutput>
					<cfset Proceed_OK = "No">
				</cfif>
				
				<cfif DateDiff("d",Variables.StartDate,Variables.EndDate) LT 0>
					<cfoutput>#ArrayAppend(Errors, "The minimum booking time is 1 day.")#</cfoutput>
					<cfset Proceed_OK = "No">
				</cfif>
				
				<cfif DateCompare(PacificNow, Variables.StartDate, 'd') EQ 1>
					<cfoutput>#ArrayAppend(Errors, "The Start Date can not be in the past.")#</cfoutput>
					<cfset Proceed_OK = "No">
				<!--- <cfelseif checkDblBooking.RecordCound GT 0>
					<cfoutput>#ArrayAppend(Errors, "There are section already been booked for maintenance during this time.")#</cfoutput>
					<cfset Proceed_OK = "No"> --->
				</cfif>
				
				
				<cfif Proceed_OK EQ "No">
					<!--- Save the form data in a session structure so it can be sent back to the form page --->
					<cfset Session.Return_Structure.StartDate = Variables.StartDate>
					<cfset Session.Return_Structure.EndDate = Variables.EndDate>
					<cfset Session.Return_Structure.NorthJetty = Variables.NorthJetty>
					<cfset Session.Return_Structure.SouthJetty = Variables.SouthJetty>
							
					<cfset Session.Return_Structure.Errors = Errors>
					
					<cflocation url="addJettyMaintBlock.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" addToken="no"> 
				</cfif>
					
				
				<!-- Gets all Bookings that would be affected by the maintenance block --->
				<cfquery name="checkConflicts" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	NorthJetty, SouthJetty, StartDate, EndDate, V.Name AS VesselName, C.Name AS CompanyName
					FROM	Bookings B INNER JOIN Jetties J ON B.bookingID = J.bookingID
								INNER JOIN Vessels V ON V.vesselID = B.vesselID
								INNER JOIN Companies C ON C.CompanyID = V.CompanyID
					WHERE	B.Deleted = '0'
						AND	V.Deleted = '0'
						AND	EndDate >= <cfqueryparam value="#CreateODBCDate(Variables.StartDate)#" cfsqltype="cf_sql_date">
						AND StartDate <= <cfqueryparam value="#CreateODBCDate(Variables.EndDate)#" cfsqltype="cf_sql_date">
						AND	(<CFIF Variables.NorthJetty>NorthJetty = '1'</CFIF>
						<CFIF Variables.SouthJetty><CFIF Variables.NorthJetty>OR	</CFIF>SouthJetty = '1'</CFIF>)
				</cfquery>
				
				<cfset Variables.StartDate = #CreateODBCDate(Variables.StartDate)#>
				<cfset Variables.EndDate = #CreateODBCDate(Variables.EndDate)#>
				
				<CFIF checkConflicts.RecordCount GT 0>
				
					<p>The requested date range for the maintenance block <b class="red">conflicts</b> with the following bookings:</p>
				
					<table class="basic smallFont">
					<tr align="left" valign="top">
						<th>Period</th>
						<th>Vessel</th>
						<th>Company</th>
						<th style="width:30%;">Sections</th>
					</tr>
					
					<cfset counter = 0>
					<cfoutput query="checkConflicts">
						<CFIF counter mod 2 eq 1>
							<CFSET rowClass = "highlight">
						<CFELSE>
							<CFSET rowClass = "">
						</CFIF>
						<tr class="#rowClass#" valign="top">
							<td>#LSdateformat(startDate, 'mmm d')#<CFIF Year(StartDate) neq Year(EndDate)>, #DateFormat(startDate, 'yyyy')#</CFIF> - #LSdateformat(endDate, 'mmm d, yyyy')#</td>
							<td>#VesselName#</td>
							<td>#CompanyName#</td>
							<td align="center">
								<cfif NorthJetty EQ 1>North Landing Wharf </cfif>
								<cfif SouthJetty EQ 1>South Jetty </cfif>
							</td>
						</tr>
						<cfset counter = counter + 1>
					</cfoutput>
					</table>
					
					<p>If you would like to go ahead and book the maintenance block, please <b class="red">confirm</b> the following information, or <b class="red">go back</b> to change the information.</p>
				
				<CFELSE>
					<p>Please confirm the following maintenance block information.</p>
				</CFIF>
				
				<cfform action="addJettyMaintBlock_action.cfm?startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" method="post" enablecab="No" name="bookingreq" preservedata="Yes">
				<div style="font-weight:bold;padding-left:85px">Booking:</div>
				<table style="width:100%; padding-left:100px;" align="center" >	
					<tr>
						<td align="left" style="width:20%;">Start Date:</td>
						<td><input type="hidden" name="StartDate" value="<cfoutput>#Variables.StartDate#</cfoutput>)" /><cfoutput>#DateFormat(Variables.StartDate, 'mmm d, yyyy'" />
					</tr>
					<tr>
						<td align="left">End Date:</td>
						<td><input type="hidden" name="EndDate" value="<cfoutput>#Variables.EndDate#</cfoutput>)" /><cfoutput>#DateFormat(Variables.EndDate, 'mmm d, yyyy'" />
					</tr>
					<tr>
						<td align="left">Sections:</td>
						<td>
							<input type="hidden" name="NorthJetty" value="<cfoutput>#Variables.NorthJetty#</cfoutput>" />
							<input type="hidden" name="SouthJetty" value="<cfoutput>#Variables.SouthJetty#</cfoutput>" />
							<cfif Variables.NorthJetty EQ 1>
								North Landing Wharf
							</cfif>
							<cfif Variables.SouthJetty EQ 1>
								<cfif Variables.NorthJetty EQ 1> 
									&amp; 
								</cfif>
								South Jetty
							</cfif>
						</td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
						<td colspan="2" align="center">
							<!---a href="javascript:EditSubmit('bookingreq');" class="textbutton">Confirm</a>
							<a href="javascript:history.go(-1);" class="textbutton">Back</a>
							<cfoutput><a href="bookingmanage.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#" class="textbutton">Cancel</a></cfoutput>
							<br--->
							<input type="submit" value="submit" class="textbutton" />
							<cfoutput><input type="button" value="Back" class="textbutton" onclick="self.location.href='addJettyMaintBlock.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#'" />
							<cfoutput><input type="button" value="Cancel" class="textbutton" onclick="self.location.href='jettybookingmanage.cfm?lang=#lang#&startdate=#DateFormat(url.startdate, 'mm/dd/yyyy')#&enddate=#DateFormat(url.enddate, 'mm/dd/yyyy')#&show=#url.show#';" />
						</td>
					</tr>
				</table>
				
				</cfform>
			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
