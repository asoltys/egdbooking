<cfset language.PageTitle = "Project Calendar View">
<cfset language.ScreenMessage = '<p><b>This calendar contains information for the drydock only.</b>  Please use the pop-up <span class="textbutton">calendar</span> to enter the range of dates you would like to view.  To start from the first booking record, clear the "From Date" field.  To end after the last booking record, clear the "To Date" field.  To see all records, clear both fields.</p>'>

<!doctype HTML public "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html lang="en">

<head>
<!--- 	<meta name="dc.title" lang="eng" content="PWGSC - ESQUIMALT GRAVING DOCK - Welcome">
	<meta name="keywords" lang="eng" content="Ship Repair, Boats, Ship Maintenance, Dry dock, drydock, marine, iso14001, iso-14001">
	<meta name="description" lang="eng" content="The Esquimalt Graving Dock, or EGD, is proud to be federally owned, operated, and maintained. EGD is the largest solid-bottom commercial drydock on the West Coast of the Americas. We are located in an ice free harbour on Vancouver Island near gateways to Alaska and the Pacific Rim.">
	<meta name="dc.subject" scheme="gccore" lang="eng" content="Ship; Wharf; Dock; Boat">
	<meta name="dc.date.created" lang="eng" content="2002-11-29">
	<meta name="dc.date.modified" content="<!--#config timefmt='%Y-%m-%d'--><!--#echo var='LAST_MODIFIED'-->">
	<meta name="dc.date.published" content="2002-12-30">
	<meta name="dc.date.reviewed" content="2004-07-27">
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Booking</title> --->
	<!--INTERNET TEMPLATE VERSION 2.1-->
	
	<!--METADATA PROFILE START-->
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<meta name="MSSmartTagsPreventParsing" content="True">
	<link rel="schema.dc" href="http://purl.org/dc/elements/1.1">
	<meta name="dc.language" scheme="IS0639-2" content="eng">
	<meta name="dc.creator" lang="eng" content="Government of Canada, Public Works and Government Services Canada, Esquimalt Graving Dock">
	<meta name="dc.publisher" lang="eng" content="Public Works and Government Services Canada">
	<meta name="pwgsc.contact.email" content="egd@pwgsc.gc.ca">
	<meta name="dc.rights" lang="eng" content="<cfoutput>http://www.pwgsc.gc.ca/text/home-#lang#.html</cfoutput>/text/generic/copyright-e.html">
	<meta name="robots" content="noindex,nofollow">

	<meta name="dc.title" lang="eng" content="PWGSC - ESQUIMALT GRAVING DOCK - Project Calendar">
	<meta name="keywords" lang="eng" content="">
	<meta name="description" lang="eng" content="Allows user to view bookings in a given range in MS Project style.">
	<meta name="dc.subject" scheme="gccore" lang="eng" content="">
	<meta name="dc.date.published" content="2005-07-25">
	<meta name="dc.date.reviewed" content="2005-07-25">
	<meta name="dc.date.modified" content="2005-07-25">
	<meta name="dc.date.created" content="2005-07-25">

	<meta name="pwgsc.date.retention" content="">
	<!-- leave blank -->
	<meta name="dc.contributor" lang="eng" content="">
	<meta name="dc.identifier" lang="eng" content="">
	<meta name="dc.audience" lang="eng" content="">
	<meta name="dc.type" lang="eng" content="">
	<meta name="dc.format" lang="eng" content="">
	<meta name="dc.coverage" lang="eng" content="">
	<!--METADATA PROFILE END-->
	
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Project Calendar</title>
	<cfoutput>
		<LINK type="text/css" rel="stylesheet" href="#RootDir#css/default.css">
		<style type="text/css" media="screen,print">
			@import url(#RootDir#css/advanced.css);
			@import url(#RootDir#css/events.css);
		</style>
	</cfoutput>

<!---cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfquery name="getVessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Vessels.VesselID, Vessels.Name
		FROM 	Vessels, Users, Companies
		WHERE 	Vessels.CompanyID = #session.CompanyID#
			AND	Users.CompanyID = Companies.CompanyID
			AND	Companies.CompanyID = Vessels.CompanyID
			AND	Users.Deleted = '0'
			AND	Companies.Deleted = '0'
			AND	Vessels.Deleted = '0'
	</cfquery>
</cflock--->

<!---cfparam name="Variables.VesselID" default=""--->
	<cfparam name="Variables.startDate" default="#PacificNow#">
	<cfparam name="Variables.endDate" default="#DateAdd('m', 3, PacificNow)#">
	<cfset Variables.BookingLen = Variables.endDate - Variables.startDate>

	<CFINCLUDE template="#RootDir#includes/calendar_js.cfm">

</head>
<body bgcolor="#FFFFFF">

<!--begin clf fip-e.html--> 
<table width="700" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="4"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="1" height="10" alt=""></td>
	</tr>
	<tr> 
		<td><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="10" height="1" alt=""></td>
		<td align="left" valign="top"><img src="<cfoutput>#RootDir#</cfoutput>images/pwgsc-e.gif" width="364" height="33" alt="Public Works and Government Services Canada" title="Public Works and Government Services Canada" border="0"></td>
		<td align="right" valign="top"><img src="<cfoutput>#RootDir#</cfoutput>images/wordmark.gif" width="83" height="21" alt="Canada wordmark" border="0" align="top"></td>
		<td><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="10" height="1" alt=""></td>
	</tr>
</table>
<!--end clf fip-e.html-->

<div class="main">

<H1 style="padding-left: 10px; "><cfoutput>#Language.PageTitle#</cfoutput></H1>

<cfinclude template="#RootDir#includes/getStructure.cfm">

<DIV style="width: 700px; padding-left: 10px; "><cfoutput>#Language.ScreenMessage#</cfoutput></DIV>

<cfform action="projectCalendar.cfm?lang=#lang#" method="POST" enablecab="No" name="procal" preservedata="Yes">
<cfoutput>
<table width="60%">
	<!---tr>
		<td width="30%">Name:</td>
		<td width="70%">
			<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
				#session.lastName#, #session.firstName#
			</cflock>
		</td>
	</tr>
	<tr>
		<td>Vessel:</td>
		<td><cfselect name="vesselID" query="getVessels" display="Name" value="VesselID" selected="#vesselID#" /></td>
	</tr--->
	<tr>
		<td id="From_Header">&nbsp; <label for="From">From Date:</label></td>
		<td headers="From_Header">
			<!---input type="Text" class="textField" name="startDateShow" value="#DateFormat(startDate, 'mmm d, yyyy')#" size="17" maxlength="12" validate="date" message="Please enter a valid Start Date." disabled--->
			<cfinput id="Start" type="text" name="startDate" value="#DateFormat(startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" class="textField" validate="date" message="Please enter a valid From Date." onChange="setLaterDate('self', 'procal', #Variables.bookingLen#)" onFocus="setEarlierDate('self', 'procal', #Variables.BookingLen#)"> <font class="light">#Language.dateform#</font>
			<a href="javascript:void(0);" onclick="getCalendar('procal', 'start');" class="textbutton">calendar</a>
			<a href="javascript:void(0);" onClick="document.procal.startDate.value='';" class="textbutton">clear</a>
		</td>
	</tr>
	<tr>
		<td id="To_Header">&nbsp; <label for="To">To Date:</label></td>
		<td headers="To_Header">
			<!---input type="Text" class="textField" name="endDateShow" value="#DateFormat(endDate, 'mmm d, yyyy')#" size="17" maxlength="12" validate="date" message="Please enter a valid End Date." disabled--->
			<cfinput id="End" type="text" name="endDate" value="#DateFormat(endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" class="textField" validate="date" message="Please enter a valid From Date." onChange="setEarlierDate('self', 'procal', #Variables.bookingLen#)" onFocus="setLaterDate('self', 'procal', #Variables.BookingLen#)"> <font class="light">#Language.dateform#</font>
			<a href="javascript:void(0);" onclick="getCalendar('procal', 'end');" class="textbutton">calendar</a>
			<a href="javascript:void(0);" onClick="document.procal.endDate.value='';" class="textbutton">clear</a>
		</td>
	</tr>
	<tr><td colspan="2">&nbsp;</td></tr>		
	<tr>
		<td>&nbsp;</td>
		<td>
			<!---a href="javascript:validate('procal');" class="textbutton">Submit</a>
			<a href="javascript:document.procal.reset();" class="textbutton">Reset</a>
			<a href="javascript:window.close()" class="textbutton">Cancel</a>
			<br--->
			<input type="Submit" value="Submit" class="textbutton">
			<input type="Reset" value="Reset" class="textbutton">
			<input type="button" value="Close This Window" class="textbutton" onClick="javascript:window.close(); void(0);">
		</td>
	</tr>
</table>
</cfoutput>
</cfform>
</div>

<!--BEGIN FOOTER-->
<table width="700" border="0" cellspacing="0" cellpadding="0">
<TR>
	<TD width="10"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="10" height="1" alt=""></TD>
	<TD colspan="2" width="680"><hr noshade size="1" width="100%"></TD>
	<TD width="10"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="10" height="1" alt=""></TD>	
</TR>
<tr>
	<td>&nbsp;</td>
	<td align="left" class="footertext" colspan="2">
		Maintained by <a href="<cfoutput>#RootDir#</cfoutput>text/contact_us-e.cfm">PWGSC</a></div> <!--- This option is recommended. --->
	</td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td align="left" class="footertext">
		<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,"\")>
		<cfset PageDir = listDeleteAt(cgi.CF_TEMPLATE_PATH, listLen(cgi.CF_TEMPLATE_PATH,"\"), "\")>
		<cfdirectory action="LIST" directory="#PageDir#" name="GetFile" filter="#PageFileName#">
		<cfif #GetFile.recordcount# is 1>Last Updated:
		<cfoutput query="GetFile">
			#LSDateFormat(parseDateTime(GetFile.DateLastModified,"mm-dd-yyyy"), "yyyy-mm-dd")# 
			<!---#TimeFormat(parseDateTime(GetFile.DateLastModified, "h:mm tt"))#--->
		</cfoutput>
		</cfif>
	</td>
	<td align="right" class="footertext">
		<cfoutput>
		<span lang="en"><a href="http://www.pwgsc.gc.ca/text/generic/copyright-e.html">Important Notices</a></span>
		</cfoutput>
	</td>
	<td><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="10" height="1" alt=""></td>
</tr>
<tr>
	<td colspan="4"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="1" height="10" alt=""></td>
</tr>
</table>
<!--END FOOTER-->

</body>
</HTML>
