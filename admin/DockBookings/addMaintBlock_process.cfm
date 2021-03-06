<cfif isDefined("form.startDate")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Add Maintenance Block"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
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
			<a href="bookingManage.cfm?lang=#lang#">Drydock Management</a> &gt;
			Create Maintenance Block
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1 id="wb-cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Create Maintenance Block
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</h1>

			<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
			<!--- ------------------------------------------------------------------------------------------------------------------->
			<cfparam name = "Form.StartDate" default="">
			<cfparam name = "Form.EndDate" default="">
			<cfparam name = "Variables.StartDate" default = "#CreateODBCDate(Form.StartDate)#">
			<cfparam name = "Variables.EndDate" default = "#CreateODBCDate(Form.EndDate)#">
			<cfparam name = "Variables.Section1" default = "0">
			<cfparam name = "Variables.Section2" default = "0">
			<cfparam name = "Variables.Section3" default = "0">

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
				WHERE 	Docks.BRID = Bookings.BRID
				AND		Status = 'M'
				AND		Deleted = '0'
				AND 	(
							(	Bookings.StartDate <= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate )
						OR 	(	Bookings.StartDate <= <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate )
						OR	(	Bookings.StartDate >= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> >= Bookings.EndDate )
						)
				AND		(
							(	Section1 = '1' AND <cfqueryparam value="#Variables.Section1#" cfsqltype="cf_sql_bit" /> = '1')
						OR	( 	Section2 = '1' AND <cfqueryparam value="#Variables.Section2#" cfsqltype="cf_sql_bit" /> = '1')
						OR	( 	Section3 = '1' AND <cfqueryparam value="#Variables.Section3#" cfsqltype="cf_sql_bit" /> = '1')
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
				<cfset Session.Return_Structure.Section1 = Variables.Section1>
				<cfset Session.Return_Structure.Section2 = Variables.Section2>
				<cfset Session.Return_Structure.Section3 = Variables.Section3>

				<cfset Session.Return_Structure.Errors = Errors>

				<cflocation url="addMaintBlock.cfm?#urltoken#" addToken="no">
			</cfif>

			<!-- Gets all Bookings that would be affected by the maintenance block --->
			<cfquery name="checkConflicts" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				SELECT	Section1, Section2, Section3, StartDate, EndDate, V.Name AS VesselName, C.Name AS CompanyName
				FROM	Bookings B INNER JOIN Docks D ON B.BRID = D.BRID
							INNER JOIN Vessels V ON V.VNID = B.VNID
							INNER JOIN Companies C ON C.CID = V.CID
				WHERE	Status = 'c'
					AND	B.Deleted = '0'
					AND	V.Deleted = '0'
					AND	EndDate >= <cfqueryparam value="#CreateODBCDate(Variables.StartDate)#" cfsqltype="cf_sql_date">
					AND StartDate <= <cfqueryparam value="#CreateODBCDate(Variables.EndDate)#" cfsqltype="cf_sql_date">
					AND	(<CFIF Variables.Section1>Section1 = '1'</CFIF>
					<CFIF Variables.Section2><CFIF Variables.Section1>OR	</CFIF>Section2 = '1'</CFIF>
					<CFIF Variables.Section3><CFIF Variables.Section1 OR Variables.Section2>OR	</CFIF>Section3 = '1'</CFIF>)
			</cfquery>


			<cfset Variables.StartDate = #CreateODBCDate(Variables.StartDate)#>
			<cfset Variables.EndDate = #CreateODBCDate(Variables.EndDate)#>

			<CFIF checkConflicts.RecordCount GT 0>

				<p>The requested date range for the maintenance block <strong class="red">conflicts</strong> with the following bookings:</p>

				<table class="basic smallFont">
				<tr valign="top" align="left">
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

				<p>If you would like to go ahead and book the maintenance block, please <strong class="red">confirm</strong> the following information, or <strong class="red">go back</strong> to change the information.</p>

			<CFELSE>
				<p>Please confirm the following maintenance block information.</p>
			</CFIF>

			<cfform action="addMaintBlock_action.cfm?#urltoken#" method="post" id="bookingreq" preservedata="Yes">

			<table style="width:80%;" align="center">
				<tr><td align="left"><div style="font-weight:bold;">Booking:</div></td></tr>
				<tr>
					<td id="Start" align="left" style="width:25%;">Start Date:</td>
					<td headers="Start"><input type="hidden" name="StartDate" value="<cfoutput>#Variables.StartDate#</cfoutput>" /><cfoutput>#DateFormat(Variables.StartDate, 'mmm d, yyyy')#</cfoutput></td>
				</tr>
				<tr>
					<td id="End" align="left">End Date:</td>
					<td headers="End"><input type="hidden" name="EndDate" value="<cfoutput>#Variables.EndDate#</cfoutput>" /><cfoutput>#DateFormat(Variables.EndDate, 'mmm d, yyyy')#</cfoutput></td>
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
						<cfoutput><a href="bookingManage.cfm?#urltoken#" class="textbutton">Cancel</a></cfoutput>
						<br--->
						<input type="submit" value="Confirm" class="textbutton" />
						<cfoutput><a href="addMaintBlock.cfm?#urltoken#" class="textbutton">Back</a></cfoutput>
						<cfoutput><input type="button" value="Cancel" class="textbutton" onclick="self.location.href='bookingManage.cfm?#urltoken#';" /></cfoutput>
						<!---<a href="javascript:formReset('bookingreq');">test reset</a>--->
					</td>
				</tr>
			</table>

			</cfform>


			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
