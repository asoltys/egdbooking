<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Maintenance Block"">
	<meta name=""keywords"" lang=""eng"" content="""">
	<meta name=""description"" lang=""eng"" content="""">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Maintenance Block</title>">


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
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
			<CFELSE>
				 <a href="#RootDir#text/reserve-book/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			<A href="bookingManage.cfm?lang=#lang#">Drydock Management</A> &gt;
			Edit Maintenance Block
			</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<CFOUTPUT>Edit Maintenance Block</CFOUTPUT>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

			<cfinclude template="#RootDir#includes/admin_menu.cfm"><br>
			
			<!--- -------------------------------------------------------------------------------------------- --->
			<cfparam name="Variables.BookingID" default="">
			<cfparam name="Variables.Section1" default="false">
			<cfparam name="Variables.Section2" default="false">
			<cfparam name="Variables.Section3" default="false">
			
			<cfif NOT IsDefined("Session.form_Structure")>
				<cfinclude template="#RootDir#includes/build_form_struct.cfm">
				<cfinclude template="#RootDir#includes/restore_params.cfm">
			<cfelse>
				<cfinclude template="#RootDir#includes/restore_params.cfm">
				<cfif isDefined("form.bookingID")>
					<cfset Variables.bookingID = #form.bookingID#>
				</cfif>
			</cfif>
			
			<cfif IsDefined("Session.Return_Structure")>
				<cfinclude template="#RootDir#includes/getStructure.cfm">
			<cfelseif IsDefined("Form.BookingID")>
				<cfquery name="GetBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	Bookings.StartDate, Bookings.EndDate, Bookings.BookingID, Docks.Section1, Docks.Section2, Docks.Section3
					FROM	Bookings, Docks
					WHERE	Bookings.BookingID = Docks.BookingID
					AND		Deleted = '0'
					AND		Status = 'M'
					AND		Bookings.BookingID = '#Form.BookingID#'
				</cfquery>
				
				<cfset Variables.StartDate = getBooking.StartDate>
				<cfset Variables.EndDate = getBooking.EndDate>
				<cfset Variables.Section1 = getBooking.Section1>
				<cfset Variables.Section2 = getBooking.Section2>
				<cfset Variables.Section3 = getBooking.Section3>
				<cfset Variables.BookingID = getBooking.BookingID>
				
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
			<CFINCLUDE template="#RootDir#includes/calendar_js.cfm">
			
			<cfform name="EditMaintBlock" action="editMaintBlock_process.cfm?#urltoken#" method="post">
			<cfoutput><input type="hidden" name="BookingID" value="#Variables.BookingID#"></cfoutput>
			<table width="100%">
			<tr>
				<td id="Start">Start Date:</td>
				<td headers="Start">
					<CFOUTPUT>
					<!---input class="textField" type="Text" name="startDateShow" id="start" disabled value="#DateFormat(startDate, 'mmm d, yyyy')#" size="17"--->
					<cfinput name="startDate" type="text" value="#DateFormat(startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" required="yes" message="Please enter a start date." validate="date" class="textField" onChange="setLaterDate('self', 'editMaintBlock', #Variables.bookingLen#)" onFocus="setEarlierDate('self', 'editMaintBlock', #Variables.bookingLen#)"> <font class="light">#language.dateform#</font></CFOUTPUT>
					<a href="javascript:void(0);" onclick="javascript:getCalendar('EditMaintBlock', 'start')" class="textbutton">calendar</a>
					<!---a href="javascript:void(0);" onClick="javascript:document.EditMaintBlock.startDateShow.value=''; document.EditMaintBlock.startDate.value='';" class="textbutton">clear</a--->
				</td>
			</tr>
			<tr>
				<td id="End">End Date:</td>
				<td headers="End">
					<CFOUTPUT>
					<!---input type="text" name="endDateShow" id="end" class="textField" disabled value="#DateFormat(endDate, 'mmm d, yyyy')#" size="17"--->
					<cfinput name="endDate" type="text" value="#DateFormat(endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" required="yes" message="Please enter an end date." validate="date" class="textField" onChange="setEarlierDate('self', 'editMaintBlock', #Variables.bookingLen#)" onFocus="setLaterDate('self', 'editMaintBlock', #Variables.bookingLen#)"> <font class="light">#language.dateform#</font></CFOUTPUT>
					<a href="javascript:void(0);" onclick="javascript:getCalendar('EditMaintBlock', 'end')" class="textbutton">calendar</a>
					<!---a href="javascript:void(0);" onClick="javascript:document.EditMaintBlock.endDateShow.value=''; document.EditMaintBlock.endDate.value='';" class="textbutton">clear</a--->
				</td>
			</tr>
			<tr><td colspan="2">Please choose the sections of the dock that you wish to book for maintenance.</td></tr>
			<tr>
				<td id="Section1_header"><label for="Section1">Section 1</label></td>
				<td headers="Section1_header"><cfinput type="Checkbox" id="Section1" name="Section1" checked="#Variables.Section1#"></td></tr>
			<tr>
				<td id="Section2_header"><label for="Section2">Section 2</label></td>
				<td headers="Section2_header"><cfinput type="Checkbox" id="Section2" name="Section2" checked="#Variables.Section2#"></td>
			</tr>
			<tr>
				<td id="Section3_header"><label for="Section3">Section 3</label></td>
				<td headers="Section3_header"><cfinput type="Checkbox" id="Section3" name="Section3" checked="#Variables.Section3#"></td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td colspan="2" align="center">
					<!--a href="javascript:EditSubmit('EditMaintBlock');" class="textbutton">Submit</a-->
					<input type="submit" name="submitForm" class="textbutton" value="submit">
					<cfoutput><input type="button" value="Cancel" onClick="self.location.href='bookingmanage.cfm?#urltoken#'" class="textbutton"></cfoutput>
				</td>
			</tr>
			</table>
			</cfform>
			
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
