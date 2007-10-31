<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Add Maintenance Block"">
<meta name=""keywords"" lang=""eng"" content="""">
<meta name=""description"" lang=""eng"" content="""">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Add Maintenance Block</title>">

<cfinclude template="#RootDir#includes/header-#lang#.cfm">

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
	<A href="bookingmanage.cfm?lang=#lang#">Drydock Management</A> &gt;
	</CFOUTPUT>
	Create Maintenance Block
</div>
							
<div class="main">

<H1>Add Maintenance Block</H1>
<cfinclude template="#RootDir#includes/admin_menu.cfm"><br>

<!--- -------------------------------------------------------------------------------------------- --->
<cfparam name="Variables.BookingID" default="">
<cfparam name="Variables.Section1" default="false">
<cfparam name="Variables.Section2" default="false">
<cfparam name="Variables.Section3" default="false">
<cfparam name="Variables.StartDate" default="#DateAdd('d', 1, Now())#">
<cfparam name="Variables.EndDate" default="#DateAdd('d', 1, Now())#">

<cfif IsDefined("Session.Return_Structure")>
	<cfinclude template="#RootDir#includes/getStructure.cfm">
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
</cfif>
<cfif IsDefined("Session.form_Structure")>
	<cfinclude template="#RootDir#includes/restore_params.cfm">
	<cfif isDefined("form.startDate")>
		<cfset Variables.StartDate = #form.startDate#>
		<cfset Variables.EndDate = #form.endDate#>
		<cfif isDefined("form.section1")><cfset Variables.Section1 = true><!--- <cfoutput>#section1#</cfoutput> ---></cfif>
		<cfif isDefined("form.section2")><cfset Variables.Section2 = true><!--- <cfoutput>#Section2#</cfoutput> ---></cfif>
		<cfif isDefined("form.section3")><cfset Variables.Section3 = true><!--- <cfoutput>#Section3#</cfoutput> ---></cfif>
	</cfif>
</cfif>


<!--- -------------------------------------------------------------------------------------------- --->
<CFINCLUDE template="#RootDir#includes/calendar_js.cfm">

<cfform name="AddMaintBlock" action="addMaintBlock_process.cfm?#urltoken#" method="post">
<cfoutput><input type="hidden" name="BookingID" value="#Variables.BookingID#"></cfoutput>
<table width="100%">
<tr>
	<td id="Start">Start Date:</td>
	<td headers="Start">
		<CFOUTPUT>
		<!---input class="textField" type="Text" name="startDateShow" id="start" disabled value="#DateFormat(startDate, 'mmm d, yyyy')#" size="17"--->
		<cfinput name="startDate" type="text" value="#DateFormat(Variables.startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" required="yes" message="Please enter a start date." validate="date" class="textField" onChange="setLaterDate('self', 'AddMaintBlock', #Variables.bookingLen#)" onFocus="setEarlierDate('self', 'AddMaintBlock', #Variables.bookingLen#)"> <font class="light">#language.dateform#</font></CFOUTPUT>
		<a href="javascript:void(0);" onclick="javascript:getCalendar('AddMaintBlock', 'start')" class="textbutton">calendar</a>
		<!---a href="javascript:void(0);" onClick="javascript:document.AddMaintBlock.startDateShow.value=''; document.AddMaintBlock.startDate.value='';" class="textbutton">clear</a--->
	</td>
</tr>
<tr>
	<td id="End">End Date:</td>
	<td headers="End">
		<CFOUTPUT>
		<!---input type="text" name="endDateShow" id="end" class="textField" disabled value="#DateFormat(endDate, 'mmm d, yyyy')#" size="17"--->
		<cfinput name="endDate" type="text" value="#DateFormat(Variables.endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" required="yes" message="Please enter an end date." validate="date" class="textField" onChange="setEarlierDate('self', 'AddMaintBlock', #Variables.bookingLen#)" onFocus="setLaterDate('self', 'AddMaintBlock', #Variables.bookingLen#)"> <font class="light">#language.dateform#</font></CFOUTPUT>
		<a href="javascript:void(0);" onclick="javascript:getCalendar('AddMaintBlock', 'end')" class="textbutton">calendar</a>
		<!---a href="javascript:void(0);" onClick="javascript:document.AddMaintBlock.endDateShow.value=''; document.AddMaintBlock.endDate.value='';" class="textbutton">clear</a--->
	</td>
</tr>
<tr><td colspan="2">Please choose the sections of the dock that you wish to book for maintenance.</td></tr>
<tr>
	<td id="header1"><label for="Section1">Section 1</label></td>
	<td headers="header1"><cfinput type="Checkbox" id="Section1" name="Section1" checked="#Variables.Section1#"></td></tr>
<tr>
	<td id="header2"><label for="Section2">Section 2</label></td>
	<td headers="header2"><cfinput type="Checkbox" id="Section2" name="Section2" checked="#Variables.Section2#"></td>
</tr>
<tr>
	<td id="header3"><label for="Section3">Section 3</label></td>
	<td headers="header3"><cfinput type="Checkbox" id="Section3" name="Section3" checked="#Variables.Section3#"></td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td colspan="2" align="center">
		<input type="submit" name="submitForm" class="textbutton" value="submit">
		<cfoutput><input type="button" value="Cancel" class="textbutton" onClick="self.location.href='bookingmanage.cfm?#urltoken#';"></cfoutput>
	</td>
</tr>
</table>
</cfform>

</div>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">
