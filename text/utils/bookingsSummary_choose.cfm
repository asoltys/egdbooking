<CFINCLUDE template="#RootDir#includes/generalLanguageVariables.cfm">

<cfif lang EQ "e">
	<cfset language.bookingsSummary = "Bookings Summary">
	<cfset language.ScreenMessage = '<p>Please use the pop-up <span class="textbutton">calendar</span> to enter the range of dates you would like to view.  To start from the first booking record, clear the "From Date" field.  To end after the last booking record, clear the "To Date" field.  To see all records, clear both fields.</p>'>
	<cfset language.description = "Allows user to view a summary of all bookings from present onward.">
	<cfset language.vesselCaps = "VESSEL">
	<cfset language.dockingCaps = "DOCKING DATES">
	<cfset language.bookingDateCaps = "BOOKING DATE">
	<cfset language.sectionCaps = "SECTION">
	<cfset language.deepsea = "Deepsea Vessel">
	<cfset language.noBookings = "There are no bookings to view.">
	<cfset language.booked = "Booked">
	<cfset language.printable = "VIEW PRINTABLE VERSION">
	<cfset language.fromDate = "From Date:">
	<cfset language.toDate = "To Date:">
	<cfset language.InvalidFromDate = "Please enter a valid From Date.">
	<cfset language.InvalidToDate = "Please enter a valid To Date.">
	<cfset language.reset = "Reset">
	<cfset language.calendar = "calendar">
	<cfset language.clear = "clear">
<cfelse>
	<cfset language.bookingsSummary = "R&eacute;sum&eacute; des r&eacute;servations">
	<cfset language.ScreenMessage = "Veuillez utiliser le calendrier de type «&nbsp;fen&ecirc;tre flash&nbsp;» pour entrer la p&eacute;riode que vous souhaitez voir. Pour d&eacute;buter au premier dossier de r&eacute;servation, vider le champ «&nbsp;Date de d&eacute;but&nbsp;». Pour terminer apr&egrave;s le dernier dossier de r&eacute;servation, vider le champ «&nbsp;Date de fin&nbsp;». Pour voir tous les dossiers, vider les deux champs.">
	<cfset language.description = "Permet &agrave; l'utilisateur de voir un r&eacute;sum&eacute; de toutes les r&eacute;servations, depuis le moment pr&eacute;sent.">
	<cfset language.vesselCaps = "NAVIRE">
	<cfset language.dockingCaps = "DATES D'AMARRAGE">
	<cfset language.bookingDateCaps = "DATE DE LA R&Eacute;SERVATION">
	<cfset language.sectionCaps = "SECTION">
	<cfset language.deepsea = "Navire oc&eacute;anique">
	<cfset language.noBookings = "Il n'existe aucune r&eacute;servation &agrave; afficher.">
	<cfset language.booked = "R&eacute;serv&eacute;">
	<cfset language.printable = "VOIR LA VERSION IMPRIMABLE">
	<cfset language.fromDate = "Date de d&eacute;but&nbsp;:">
	<cfset language.toDate = "Date de fin&nbsp;:">
	<cfset language.InvalidFromDate = "Veuillez entrer une date de d&eacute;but valide.">
	<cfset language.InvalidToDate = "Veuillez entrer une date de fin valide.">
	<cfset language.reset = "R&eacute;initialiser">
	<cfset language.calendar = "Calendrier">
	<cfset language.clear = "effacer">

</cfif>

<cfoutput>
	<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""#language.PWGSC# - #language.esqGravingDockCaps# - #language.BookingsSummary#"">
	<meta name=""keywords"" lang=""eng"" content="""">
	<meta name=""description"" lang=""eng"" content=""#language.description#"">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>#language.PWGSC# - #language.esqGravingDockCaps# - #language.BookingsSummary#</title>
	<style type=""text/css"" media=""screen,print"">@import url(#RootDir#css/events.css);</style>
	">
</cfoutput>

<cfinclude template="#RootDir#includes/header-#lang#.cfm">

<cfoutput>
<div class="breadcrumbs">
	<a href="http://www.pwgsc.gc.ca/text/home-#lang#.cfm">#language.PWGSC#</a> &gt; 
	Pacific Region &gt; 
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-#lang#.html">#language.esqGravingDock#</a> &gt; 
	<a href="../booking-#lang#.cfm">#language.booking#</a> &gt;
	#language.bookingsSummary#
</div>

<cfparam name="Variables.startDate" default="#Now()#">
<cfparam name="Variables.endDate" default="">

<div class="main">

<h1>#language.bookingsSummary#</h1>

<cfinclude template="#RootDir#includes/getStructure.cfm">

<CFINCLUDE template="#RootDir#includes/calendar_js.cfm">

#Language.ScreenMessage#

<cfform action="bookingsSummary-public.cfm?lang=#lang#" method="POST" enablecab="No" name="bookSum" preservedata="Yes">
	<table width="100%">
		<tr>
			<td id="startCell"><label for="start">&nbsp; #language.fromDate#</label></td>
			<td headers="startCell">
				<!---input type="Text" class="textField" name="startDateShow" value="#DateFormat(startDate, 'mmm d, yyyy')#" size="17" maxlength="12" validate="date" message="Please enter a valid Start Date." disabled--->
				<cfinput id="start" type="text" name="startDate" value="#DateFormat(variables.startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" class="textField" validate="date" message="#language.invalidfromDate#" onChange="setLaterDate('self', 'bookSum', #Variables.bookingLen#)" onFocus="setEarlierDate('self', 'bookSum', #Variables.bookingLen#)"> <font class="light">#Language.dateform#</font>
				<a href="javascript:void(0);" onclick="javascript:getCalendar('bookSum', 'start');" class="textbutton">calendar</a>
				<a href="javascript:document.bookSum.startDate.value=''; void(0);" class="textbutton">clear</a>
			</td>
		</tr>
		<tr>
			<td id="endCell"><label for="end">&nbsp; #language.toDate#</label></td>
			<td headers="endCell">
				<!---input type="Text" class="textField" name="endDateShow" value="#DateFormat(endDate, 'mmm d, yyyy')#" size="17" maxlength="12" validate="date" message="Please enter a valid End Date." disabled--->
				<cfinput id="end" type="text" name="endDate" value="#DateFormat(variables.endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" class="textField" validate="date" message="#language.invalidtoDate#" onChange="setLaterDate('self', 'bookSum', #Variables.bookingLen#)" onFocus="setEarlierDate('self', 'bookSum', #Variables.bookingLen#)"> <font class="light">#Language.dateform#</font>
				<a href="javascript:void(0);" onclick="javascript:getCalendar('bookSum', 'end');" class="textbutton">calendar</a>
				<a href="javascript:document.bookSum.toDate.value=''; void(0);" class="textbutton">clear</a>
			</td>
		</tr>
		<tr><td colspan="2">&nbsp;</td></tr>		
		<tr>
			<td>&nbsp;</td>
			<td>
				<!---a href="javascript:validate('bookSum');" class="textbutton">Submit</a>
				<a href="javascript:document.bookSum.reset();" class="textbutton">Reset</a>
				<a href="javascript:window.close()" class="textbutton">Cancel</a>
				<br--->
				<input type="Submit" value="#language.submit#" class="textbutton">
				<input type="Reset" value="#language.reset#" class="textbutton">
			</td>
		</tr>
	</table>

</cfform>
</div>

</cfoutput>
</body>
</HTML>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">