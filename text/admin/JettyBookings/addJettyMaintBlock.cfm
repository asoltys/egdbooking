<!---cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/build_form_struct.cfm"--->

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
		<A href="jettyBookingmanage.cfm?lang=#lang#">Jetty Management</A> &gt;
	</CFOUTPUT>
	Add Maintenance Block
</div>
							
<div class="main">

<H1>Add Maintenance Block</H1>
<cfinclude template="#RootDir#includes/admin_menu.cfm"><br>

<!--- -------------------------------------------------------------------------------------------- --->
<cfparam name="Variables.BookingID" default="">
<cfparam name="Variables.SouthJetty" default="false">
<cfparam name="Variables.NorthJetty" default="false">
<cfparam name="Variables.StartDate" default="#DateAdd('d', 1, Now())#">
<cfparam name="Variables.EndDate" default="#DateAdd('d', 1, Now())#">

<cfif IsDefined("Session.Return_Structure")>
	<cfinclude template="#RootDir#includes/getStructure.cfm">
	<cfif Variables.SouthJetty EQ 1>
		<cfset Variables.SouthJetty = true>
	<cfelse>
		<cfset Variables.SouthJetty = false>
	</cfif>
	<cfif Variables.NorthJetty EQ 1>
		<cfset Variables.NorthJetty = true>
	<cfelse>
		<cfset Variables.NorthJetty = false>
	</cfif>
<!---cfelseif IsDefined("Session.Form_Structure")>
	<cfif isDefined("form.SouthJetty")>
		<cfset Variables.SouthJetty = true>
	<cfelse>
		<cfset Variables.SouthJetty = false>
	</cfif>
	<cfif isDefined("form.NorthhJetty")>
		<cfset Variables.NorthJetty = true>
	<cfelse>
		<cfset Variables.NorthJetty = false>
	</cfif--->
</cfif>
<cfif NOT IsDefined("Session.form_Structure")>
	<cfinclude template="#RootDir#includes/build_form_struct.cfm">
	<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfelse>
	<cfinclude template="#RootDir#includes/restore_params.cfm">
	<cfif isDefined("form.StartDate")>
		<cfset Variables.StartDate = #form.startDate#>
		<cfset Variables.EndDate = #form.endDate#>
		<cfif isDefined("form.NorthJetty")>
			<cfset Variables.NorthJetty = true>
		<cfelse>
			<cfset Variables.NorthJetty = false>		
		</cfif>
		<cfif isDefined("form.SouthJetty")>
			<cfset Variables.SouthJetty = true>
		<cfelse>
			<cfset Variables.SouthJetty = false>	
		</cfif>
	</cfif>
</cfif>


<!--- -------------------------------------------------------------------------------------------- --->
<CFINCLUDE template="#RootDir#includes/calendar_js.cfm">

<cfform name="AddJettyMaintBlock" action="addJettyMaintBlock_process.cfm?#urltoken#" method="post">
<cfoutput><input type="hidden" name="BookingID" value="#Variables.BookingID#"></cfoutput>
<table width="100%">
<tr>
	<td id="Start">Start Date:</td>
	<td headers="Start">
		<CFOUTPUT>
		<!---input class="textField" type="Text" name="startDateShow" id="start" disabled value="#DateFormat(startDate, 'mmm d, yyyy')#" size="17"--->
		<cfinput name="startDate" type="text" value="#DateFormat(startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" required="yes" message="Please enter a start date." validate="date" class="textField" onChange="setLaterDate('self', 'AddJettyMaintBlock', #Variables.bookingLen#)" onFocus="setEarlierDate('self', 'AddJettyMaintBlock', #Variables.bookingLen#)"> <font class="light">#language.dateform#</font></CFOUTPUT>
		<a href="javascript:void(0);" onclick="javascript:getCalendar('AddJettyMaintBlock', 'start')" class="textbutton">calendar</a>
		<!---a href="javascript:void(0);" onClick="javascript:document.AddJettyMaintBlock.startDateShow.value=''; document.AddMaintBlock.startDate.value='';" class="textbutton">clear</a--->
	</td>
</tr>
<tr>
	<td id="End">End Date:</td>
	<td headers="End">
		<CFOUTPUT>
		<!---input type="text" name="endDateShow" id="end" class="textField" disabled value="#DateFormat(endDate, 'mmm d, yyyy')#" size="17"--->
		<cfinput name="endDate" type="text" value="#DateFormat(endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" required="yes" message="Please enter an end date." validate="date" class="textField" onChange="setEarlierDate('self', 'AddJettyMaintBlock', #Variables.bookingLen#)" onFocus="setLaterDate('self', 'AddJettyMaintBlock', #Variables.bookingLen#)"> <font class="light">#language.dateform#</font></CFOUTPUT>
		<a href="javascript:void(0);" onclick="javascript:getCalendar('AddJettyMaintBlock', 'end')" class="textbutton">calendar</a>
		<!---a href="javascript:void(0);" onClick="javascript:document.AddJettyMaintBlock.endDateShow.value=''; document.AddMaintBlock.endDate.value='';" class="textbutton">clear</a--->
	</td>
</tr>
<tr>
	<td colspan="2">Please select the jetty/jetties that you wish to book for maintenance:</td>
</tr>
<tr>
	<td id="nj">&nbsp;&nbsp;&nbsp;<label for="northJetty">North Landing Wharf</label></td>
	<td headers="nj"><cfinput type="Checkbox" name="NorthJetty" id="northJetty" checked="#Variables.NorthJetty#"></td>
</tr>
<tr>
	<td id="sj">&nbsp;&nbsp;&nbsp;<label for="southJetty">South Jetty</label></td>
	<td headers="sj"><cfinput type="Checkbox" name="SouthJetty" id="southJetty" checked="#Variables.SouthJetty#"></td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td colspan="2" align="center">
		<!---a href="javascript:EditSubmit('AddJettyMaintBlock');" class="textbutton">Submit</a>
		<cfoutput><a href="jettybookingmanage.cfm?#urltoken#&show=#url.show#" class="textbutton">Cancel</a></cfoutput>
		<br--->
		<input type="Submit" value="Submit" class="textbutton">
		<cfoutput><input type="button" value="Cancel" class="textbutton" onClick="self.location.href='jettybookingmanage.cfm?#urltoken#';"></cfoutput>
	</td>
</tr>
</table>
</cfform>


</div>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">
