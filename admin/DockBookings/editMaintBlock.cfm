<cfif structKeyExists(URL, 'BRID')>
  <cfset Form.BRID = URL.BRID />
</cfif>

<cfsavecontent variable="js">
	<cfoutput>
	<meta name="dcterms.title" content="PWGSC - ESQUIMALT GRAVING DOCK - Edit Maintenance Block">
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta name="dcterms.description" content="" />
	<meta name="dcterms.subject" title="gccore" content="" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Maintenance Block</title>
	<script type="text/javascript">
		/* <![CDATA[ */
		function EditSubmit ( selectedform )
			{
			  document.forms[selectedform].submit();
			}
		var bookingLength = 0;
		/* ]]> */
	</script>
	<script type="text/javascript" src="#RootDir#scripts/tandemDateFixer.js"></script>
	</cfoutput>
</cfsavecontent>
<cfhtmlhead text="#js#">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">


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
				<h1 id="wb-cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>Edit Maintenance Block</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</h1>

			<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

			<!--- -------------------------------------------------------------------------------------------- --->
			<cfparam name="Variables.BRID" default="">
			<cfparam name="Variables.Section1" default="false">
			<cfparam name="Variables.Section2" default="false">
			<cfparam name="Variables.Section3" default="false">

			<cfif NOT IsDefined("Session.form_Structure")>
				<cfinclude template="#RootDir#includes/build_form_struct.cfm">
				<cfinclude template="#RootDir#includes/restore_params.cfm">
			<cfelse>
				<cfinclude template="#RootDir#includes/restore_params.cfm">
				<cfif isDefined("form.BRID")>
					<cfset Variables.BRID = #form.BRID#>
				</cfif>
			</cfif>

			<cfif IsDefined("Session.Return_Structure")>
				<cfinclude template="#RootDir#includes/getStructure.cfm">
			<cfelseif IsDefined("Form.BRID")>
				<cfquery name="GetBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	Bookings.StartDate, Bookings.EndDate, Bookings.BRID, Docks.Section1, Docks.Section2, Docks.Section3
					FROM	Bookings, Docks
					WHERE	Bookings.BRID = Docks.BRID
					AND		Deleted = '0'
					AND		Status = 'M'
					AND		Bookings.BRID = <cfqueryparam value="#Form.BRID#" cfsqltype="cf_sql_integer" />
				</cfquery>

				<cfset Variables.StartDate = getBooking.StartDate>
				<cfset Variables.EndDate = getBooking.EndDate>
				<cfset Variables.Section1 = getBooking.Section1>
				<cfset Variables.Section2 = getBooking.Section2>
				<cfset Variables.Section3 = getBooking.Section3>
				<cfset Variables.BRID = getBooking.BRID>

			</cfif>
			<cfif Variables.Section1 EQ 1>
				<cfset Variables.Section1 = true>
			<cfelse>
				<cfset Variables.Section1 = false>
			</cfif>
			<cfif Variables.Section2 EQ 1>
				<cfset Variables.Section2 = true>
			<cfelse>
				<cfset Variables.Section2 = false>
			</cfif>
			<cfif Variables.Section3 EQ 1>
				<cfset Variables.Section3 = true>
			<cfelse>
				<cfset Variables.Section3 = false>
			</cfif>

			<cfif IsDefined("Session.form_Structure")>
				<cfif isDefined("form.startDate")>
					<cfset Variables.StartDate = #form.startDate#>
					<cfset Variables.EndDate = #form.endDate#>
					<cfif isDefined("form.section1")><cfset Variables.Section1 = true><cfelse><cfset Variables.Section1 = false></cfif>
					<cfif isDefined("form.section2")><cfset Variables.Section2 = true><cfelse><cfset Variables.Section2 = false></cfif>
					<cfif isDefined("form.section3")><cfset Variables.Section3 = true><cfelse><cfset Variables.Section3 = false></cfif>
				</cfif>
			</cfif>
			<!--- -------------------------------------------------------------------------------------------- --->

      <cfoutput>
			<form id="EditMaintBlock" action="editMaintBlock_process.cfm?#urltoken#" method="post">
			<input type="hidden" name="BRID" value="#Variables.BRID#" />
			<table style="width:100%;">
			<tr>
				<td id="Start"><label for="startDate">Start Date:<br /><small>#language.dateform#</small></label></td>
				<td headers="Start">
					<input type="text" id="startDate" name="startDate" class="datepicker startDate" value="#DateFormat(startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" /> 
				</td>
			</tr>
			<tr>
				<td id="End"><label for="endDate">End Date:<br /><small>#language.dateform#</small></label></td>
				<td headers="End">
					<input type="text" id="endDate" name="endDate" class="datepicker endDate" value="#DateFormat(endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" /> 
				</td>
			</tr>
			<tr><td colspan="2">Please choose the sections of the dock that you wish to book for maintenance.</td></tr>
			<tr>
				<td id="Section1_header"><label for="Section1">Section 1</label></td>
				<td headers="Section1_header"><input type="checkbox" id="Section1" name="Section1" checked="#Variables.Section1#" /></td></tr>
			<tr>
				<td id="Section2_header"><label for="Section2">Section 2</label></td>
				<td headers="Section2_header"><input type="checkbox" id="Section2" name="Section2" checked="#Variables.Section2#" /></td>
			</tr>
			<tr>
				<td id="Section3_header"><label for="Section3">Section 3</label></td>
				<td headers="Section3_header"><input type="checkbox" id="Section3" name="Section3" checked="#Variables.Section3#" /></td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td colspan="2" align="center">
					<!--a href="javascript:EditSubmit('EditMaintBlock');" class="textbutton">Submit</a-->
					<input type="submit" name="submitForm" class="textbutton" value="submit" />
					<a href="bookingManage.cfm?#urltoken#" class="textbutton">Cancel</a>
				</td>
			</tr>
			</table>
			</form>
      </cfoutput>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
