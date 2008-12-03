<cfif isDefined("form.startDate")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Maintenance Block"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Maintenance Block</title>">
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
			<a href="bookingManage.cfm?lang=#lang#">Drydock Management</a> &gt;
			Edit Maintenance Block
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>Edit Maintenance Block</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

			<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
			<!--- ---------------------------------------------------------------------------------------------------------------- --->
			<cfparam name = "Form.StartDate" default="">
			<cfparam name = "Form.EndDate" default="">
			<cfparam name = "Variables.StartDate" default = "#CreateODBCDate(Form.StartDate)#">
			<cfparam name = "Variables.EndDate" default = "#CreateODBCDate(Form.EndDate)#">
			<cfparam name = "Variables.Section1" default = "0">
			<cfparam name = "Variables.Section2" default = "0">
			<cfparam name = "Variables.Section3" default = "0">
			<cfparam name = "Variables.BookingID" default = "#Form.BookingID#">

			<cfif IsDefined("Form.Section1")>
				<cfset Variables.Section1 = 1>
			</cfif>
			<cfif IsDefined("Form.Section2")>
				<cfset Variables.Section2 = 1>
			</cfif>
			<cfif IsDefined("Form.Section3")>
				<cfset Variables.Section3 = 1>
			</cfif>

			<cfif Variables.StartDate EQ "">
				<cflocation addtoken="no" url="editBooking.cfm?lang=#lang#">
			</cfif>

			<!--- <cfset Variables.StartDate = CreateODBCDate(#Variables.StartDate#)>
			<cfset Variables.EndDate = CreateODBCDate(#Variables.EndDate#)> --->

			<cfif IsDefined("Session.Return_Structure")>
				<cfoutput>#StructDelete(Session, "Return_Structure")#</cfoutput>
			</cfif>


			<!---Do a check on Double Maintenance Bookings--->
			<cfquery name="checkDblBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				SELECT 	Section1, Section2, Section3, StartDate, EndDate
				FROM 	Bookings, Docks
				WHERE 	Docks.BookingID = Bookings.BookingID
				AND		Bookings.BookingID != '#Form.BookingID#'
				AND		Status = 'M'
				AND		Deleted = '0'
				AND 	(
							(	Bookings.StartDate <= #Variables.StartDate# AND #Variables.StartDate# <= Bookings.EndDate )
						OR 	(	Bookings.StartDate <= #Variables.EndDate# AND #Variables.EndDate# <= Bookings.EndDate )
						OR	(	Bookings.StartDate >= #Variables.StartDate# AND #Variables.EndDate# >= Bookings.EndDate )
						)
				AND		(
							(	Section1 = '1' AND '#Variables.Section1#' = '1')
						OR	( 	Section2 = '1' AND '#Variables.Section2#' = '1')
						OR	( 	Section3 = '1' AND '#Variables.Section3#' = '1')
						)
			</cfquery>


			<cfset Variables.StartDate = DateFormat(Variables.StartDate, 'mm/dd/yyy')>
			<cfset Variables.EndDate = DateFormat(Variables.EndDate, 'mm/dd/yyy')>

			<cfset Errors = ArrayNew(1)>
			<cfset Success = ArrayNew(1)>
			<cfset Proceed_OK = "Yes">

			<!--- Validate the form data --->
			<cfif (NOT isDefined("Form.Section1")) AND (NOT isDefined("Form.Section2")) AND (NOT isDefined("Form.Section3"))>
				<cfoutput>#ArrayAppend(Errors, "You must choose at least one section of the dock for confirmed bookings.")#</cfoutput>
				no sections
				<cfset Proceed_OK = "No">
			</cfif>

			<cfif checkDblBooking.RecordCount GT 0>
				<cfif checkDblBooking.section1 AND checkDblBooking.section2 AND checkDblBooking.section3>
					<cfoutput>#ArrayAppend(Errors, "There is already a maintenance booking for all sections of the dock from #DateFormat(checkDblBooking.startDate, 'mmm d, yyyy')# to #DateFormat(checkDblBooking.endDate, 'mmm d, yyyy')#.")#</cfoutput>
				<cfelseif checkDblBooking.section1 AND checkDblBooking.section2>
					<cfoutput>#ArrayAppend(Errors, "There is already a maintenance booking for sections 1 and 2 of the dock from #DateFormat(checkDblBooking.startDate, 'mmm d, yyyy')# to #DateFormat(checkDblBooking.endDate, 'mmm d, yyyy')#.")#</cfoutput>
				<cfelseif checkDblBooking.section3 AND checkDblBooking.section2>
					<cfoutput>#ArrayAppend(Errors, "There is already a maintenance booking for sections 2 and 3 of the dock from #DateFormat(checkDblBooking.startDate, 'mmm d, yyyy')# to #DateFormat(checkDblBooking.endDate, 'mmm d, yyyy')#.")#</cfoutput>
				<cfelseif checkDblBooking.section3>
					<cfoutput>#ArrayAppend(Errors, "There is already a maintenance booking for section 3 of the dock from #DateFormat(checkDblBooking.startDate, 'mmm d, yyyy')# to #DateFormat(checkDblBooking.endDate, 'mmm d, yyyy')#.")#</cfoutput>
				<cfelseif checkDblBooking.section2>
					<cfoutput>#ArrayAppend(Errors, "There is already a maintenance booking for section 2 of the dock from #DateFormat(checkDblBooking.startDate, 'mmm d, yyyy')# to #DateFormat(checkDblBooking.endDate, 'mmm d, yyyy')#.")#</cfoutput>
				<cfelseif checkDblBooking.section1>
					<cfoutput>#ArrayAppend(Errors, "There is already a maintenance booking for section 1 of the dock from #DateFormat(checkDblBooking.startDate, 'mmm d, yyyy')# to #DateFormat(checkDblBooking.endDate, 'mmm d, yyyy')#.")#</cfoutput>
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

			<cfif DateCompare(PacificNow, Variables.StartDate, 'd') EQ 1 AND DateCompare(PacificNow, Variables.EndDate, 'd') EQ 1>
				<cfoutput>#ArrayAppend(Errors, "This maintenance period has ended. Please create a new block.")#</cfoutput>
				<cfset Proceed_OK = "No">
			<!--- <cfelseif checkDblBooking.RecordCound GT 0>
				<cfoutput>#ArrayAppend(Errors, "There are section already been booked for maintenance during this time.")#</cfoutput>
				<cfset Proceed_OK = "No"> --->
			</cfif>


			<cfif Proceed_OK EQ "No">
				<!--- Save the form data in a session structure so it can be sent back to the form page --->
				<cfset Session.Return_Structure.StartDate = Variables.StartDate>
				<cfset Session.Return_Structure.EndDate = Variables.EndDate>
				<cfset Session.Return_Structure.Section1 = Variables.Section1>
				<cfset Session.Return_Structure.Section2 = Variables.Section2>
				<cfset Session.Return_Structure.Section3 = Variables.Section3>

				<cfset Session.Return_Structure.Errors = Errors>

				<cflocation url="editMaintBlock.cfm?#urltoken#" addToken="no">
			</cfif>

			<!-- Gets all Bookings that would be affected by the maintenance block --->
			<cfquery name="checkConflicts" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				SELECT	Section1, Section2, Section3, StartDate, EndDate, V.Name AS VesselName, C.Name AS CompanyName
				FROM	Bookings B INNER JOIN Docks D ON B.bookingID = D.bookingID
							INNER JOIN Vessels V ON V.vesselID = B.vesselID
							INNER JOIN Companies C ON C.CompanyID = V.CompanyID
				WHERE	Status = 'c'
					AND	B.Deleted = '0'
					AND	V.Deleted = '0'
					AND	EndDate >= <cfqueryparam value="#CreateODBCDate(Variables.StartDate)#" cfsqltype="cf_sql_date">
					AND StartDate <= <cfqueryparam value="#CreateODBCDate(Variables.EndDate)#" cfsqltype="cf_sql_date">
					AND	(<CFIF Variables.Section1>Section1 = '1'</CFIF>
					<CFIF Variables.Section2><CFIF Variables.Section1>OR	</CFIF>Section2 = '1'</CFIF>
					<CFIF Variables.Section3><CFIF Variables.Section1 OR Variables.Section2>OR</CFIF>	Section3 = '1'</CFIF>)
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
					<th style="width:15%;">Sections</th>
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
							<cfif Section1 EQ 1>1 </cfif>
							<cfif Section2 EQ 1>2 </cfif>
							<cfif Section3 EQ 1>3 </cfif>
						</td>
					</tr>
					<cfset counter = counter + 1>
				</cfoutput>
				</table>

				<p>If you would like to go ahead and book the maintenance block, please <b class="red">confirm</b> the following information, or <b class="red">go back</b> to change the information.</p>

			<CFELSE>
				<p>Please confirm the following maintenance block information.</p>
			</CFIF>

			<cfform action="editMaintBlock_action.cfm?#urltoken#" method="post" enablecab="No" id="bookingreq" preservedata="Yes">
			<cfoutput><input type="hidden" name="BookingID" value="#Variables.BookingID#" />

			<table style="width:80%;" align="center">
				<tr><td align="left"><div style="font-weight:bold;">Booking:</div></td></tr>
				<tr>
					<td id="Start" align="left" style="width:25%;">Start Date:</td>
					<td headers="Start"><input type="hidden" name="StartDate" value="<cfoutput>#Variables.StartDate#</cfoutput>)" /><cfoutput>#DateFormat(Variables.StartDate, 'mmm d, yyyy'" />
				</tr>
				<tr>
					<td id="End" align="left">End Date:</td>
					<td headers="End"><input type="hidden" name="EndDate" value="<cfoutput>#Variables.EndDate#</cfoutput>)" /><cfoutput>#DateFormat(Variables.EndDate, 'mmm d, yyyy'" />
				</tr>
				<tr>
					<td id="Sections" align="left">Sections:</td>
					<td headers="Sections">
						<input type="hidden" name="Section1" value="<cfoutput>#Variables.Section1#</cfoutput>" />
						<input type="hidden" name="Section2" value="<cfoutput>#Variables.Section2#</cfoutput>" />
						<input type="hidden" name="Section3" value="<cfoutput>#Variables.Section3#</cfoutput>" />
						<cfif Variables.Section1 EQ 1>
							Section 1
						</cfif>
						<cfif Variables.Section2 EQ 1>
							<cfif Variables.Section1 EQ 1>
								&amp;
							</cfif>
							Section 2
						</cfif>
						<cfif Variables.Section3 EQ 1>
							<cfif Variables.Section1  EQ 1 OR Variables.Section2 EQ 1>
								&amp;
							</cfif>
							Section 3
						</cfif>
					</td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td colspan="2" align="center">
						<!---a href="javascript:EditSubmit('bookingreq');" class="textbutton">Confirm</a>
						<a href="javascript:history.go(-1);" class="textbutton">Back</a>
						<cfoutput><a href="bookingmanage.cfm?#urltoken#" class="textbutton">Cancel</a></cfoutput>
						<br--->
						<input type="submit" value="submit" class="textbutton" />
						<cfoutput><input type="button" value="Back" class="textbutton" onclick="self.location.href='editMaintBlock.cfm?#urltoken#'" /></cfoutput>
						<cfoutput><input type="button" value="Cancel" class="textbutton" onclick="self.location.href='bookingmanage.cfm?#urltoken#';" /></cfoutput>
						<!---<a href="javascript:formReset('bookingreq');">test reset</a>--->
					</td>
				</tr>
			</table>

			</cfform>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
