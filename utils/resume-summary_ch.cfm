<CFINCLUDE template="#RootDir#includes/generalLanguageVariables.cfm">

<cfif lang EQ "eng">
	<cfset language.bookingsSummary = "Bookings Summary">
	<cfset language.ScreenMessage = '<p>Please use the pop-up <span class="textbutton">calendar</span> to enter the range of dates you would like to view.  To start from the first booking record, clear the "From Date" field.  To end after the last booking record, clear the "To Date" field.  To see all records, clear both fields.</p>'>
	<cfset language.description = "Allows user to view a summary of all bookings from present onward.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.vesselCaps = "VESSEL">
	<cfset language.dockingCaps = "DOCKING DATES">
	<cfset language.bookingDateCaps = "BOOKING DATE">
	<cfset language.sectionCaps = "SECTION">
	<cfset language.deepsea = "Deepsea Vessel">
	<cfset language.noBookings = "There are no bookings to view.">
	<cfset language.booked = "Booked">
	<cfset language.printable = "VIEW PRINtable VERSION">
	<cfset language.fromDate = "From Date:">
	<cfset language.toDate = "To Date:">
	<cfset language.InvalidFromDate = "Please enter a valid From Date.">
	<cfset language.InvalidToDate = "Please enter a valid To Date.">
	<cfset language.reset = "reset">
	<cfset language.calendar = "calendar">
	<cfset language.clear = "clear">
<cfelse>
	<cfset language.bookingsSummary = "R&eacute;sum&eacute; des r&eacute;servations">
	<cfset language.ScreenMessage = "Veuillez utiliser le calendrier de type &laquo;&nbsp;fen&ecirc;tre flash&nbsp;&raquo; pour entrer la p&eacute;riode que vous souhaitez voir. Pour d&eacute;buter au premier dossier de r&eacute;servation, vider le champ &laquo;&nbsp;Date de d&eacute;but&nbsp;&raquo;. Pour terminer apr&egrave;s le dernier dossier de r&eacute;servation, vider le champ &laquo;&nbsp;Date de fin&nbsp;&raquo;. Pour voir tous les dossiers, vider les deux champs.">
	<cfset language.description = "Permet &agrave; l'utilisateur de voir un r&eacute;sum&eacute; de toutes les r&eacute;servations, depuis le moment pr&eacute;sent.">
	<cfset language.subjects = language.masterSubjects & "">
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
<cfsavecontent variable="js">
	<cfoutput>
	<meta name="dc.title" content="#language.BookingsSummary# - #language.esqGravingDock# - #language.PWGSC#" />
	<meta name="keywords" content="#language.masterKeywords#" />
	<meta name="description" content="#language.description#" />
	<meta name="dc.subject" scheme="gccore" content="#language.subjects#" />
	<title>#language.BookingsSummary# - #language.esqGravingDock# - #language.PWGSC#</title>
	<script type="text/javascript">
		/* <![CDATA[ */
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
			<a href="#RootDir#reserve-book-#lang#.cfm">#language.booking#</a> &gt;
			#language.bookingsSummary#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.bookingsSummary#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<cfparam name="Variables.startDate" default="#PacificNow#">
				<cfparam name="Variables.endDate" default="">

				<cfinclude template="#RootDir#includes/getStructure.cfm">
				<cfoutput>
				#Language.ScreenMessage#

				<form action="resume-summary.cfm?lang=#lang#" method="post" id="bookSum">
					<table style="width:100%;">
						<tr>
							<td id="startCell"><label for="start">&nbsp; #language.fromDate#</label></td>
							<td headers="startCell">
								<input type="text" name="startDate" class="startDate" id="start" value="#DateFormat(variables.startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" /> #language.dateform#
								<img src="#RootDir#images/calendar.gif" alt="Calendar" class="calendar" width="25px" height="17px" />
							</td>
						</tr>
						<tr>
						<td id="endCell"><label for="end">&nbsp; #language.toDate#</label></td>
							<td headers="endCell">
								<input type="text" name="endDate" class="endDate" id="end" value="#DateFormat(variables.endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" /> #language.dateform#
								<img src="#RootDir#images/calendar.gif" alt="Calendar" class="calendar" width="25px" height="17px" />
							</td>
						</tr>
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr>
							<td>&nbsp;</td>
							<td>
								<input type="submit" value="#language.submit#" class="textbutton" />
								<input type="reset" value="#language.reset#" class="textbutton" />
							</td>
						</tr>
					</table>

				</form>
				</cfoutput>
			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
