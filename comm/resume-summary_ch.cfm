<cfoutput>
<cfif lang EQ "eng">
	<cfset language.bookingsSummary = "Bookings Summary">
  <cfset language.ScreenMessage = '<p>To start from the first booking record, clear the <em>From Date</em> field.  To end after the last booking record, clear the <em>To Date</em> field.  To see all records, clear both fields.</p>'>
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
	<cfset language.reset = "reset">
	<cfset language.calendar = "calendar">
	<cfset language.clear = "clear">
<cfelse>
	<cfset language.bookingsSummary = "R&eacute;sum&eacute; des r&eacute;servations">
	<cfset language.ScreenMessage = "<p>Pour d&eacute;buter au premier dossier de r&eacute;servation, vider le champ &laquo;&nbsp;Date de d&eacute;but&nbsp;&raquo;. Pour terminer apr&egrave;s le dernier dossier de r&eacute;servation, vider le champ &laquo;&nbsp;Date de fin&nbsp;&raquo;. Pour voir tous les dossiers, vider les deux champs.</p>">
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
	<cfset language.calendar = "calendrier">
	<cfset language.clear = "effacer">

</cfif>
<cfsavecontent variable="js">
	<meta name="dc.title" content="#language.BookingsSummary# - #language.esqGravingDock# - #language.PWGSC#" />
	<meta name="keywords" content="#Language.masterKeywords#" />
	<meta name="description" content="#language.description#" />
	<meta name="dc.subject" scheme="gccore" content="#Language.masterSubjects#" />
	<title>#language.BookingsSummary# - #language.esqGravingDock# - #language.PWGSC#</title>
	<script type="text/javascript">
		/* <![CDATA[ */
		var bookingLength = 0;
		/* ]]> */
	</script>
</cfsavecontent>
<cfhtmlhead text="#js#">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			</CFIF>
			#language.BookingsSummary#
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					#language.bookingsSummary#
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

        <cfparam name="Variables.startDate" default="#PacificNow#">
        <cfparam name="Variables.endDate" default="12/31/2031">

				<cfif IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
					<cfinclude template="#RootDir#includes/admin_menu.cfm">
				<cfelse>
					<cfinclude template="#RootDir#includes/user_menu.cfm">
				</cfif>

        <cfif isDefined("Session.Return_Structure")>
          <cfinclude template="#RootDir#includes/getStructure.cfm">
        </cfif>

        <cfif Variables.startDate neq "" and not isDate(Variables.startDate)>
          <cfset Variables.startDate = "" />
        </cfif>

        <cfif Variables.endDate neq "" and not isDate(Variables.endDate)>
          <cfset Variables.endDate = "" />
        </cfif>

        #Language.ScreenMessage#

				<form action="resume-summary.cfm?lang=#lang#" method="post" id="bookSum">
					<fieldset><legend>#language.bookingsSummary#</legend>
            <div>
              <label for="start">&nbsp; #language.fromDate#<br /><small><abbr title="#language.dateformexplanation#">#language.dateform#</abbr></small></label>
              <input id="start" type="text" name="startDate" class="datepicker startDate" value="#DateFormat(variables.startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" />
            </div>
            
            <div>
              <label for="end">&nbsp; #language.toDate#<br /><small><abbr title="#language.dateformexplanation#">#language.dateform#</abbr></small></label>
              <input type="text" name="endDate" class="datepicker endDate" id="end" value="#DateFormat(variables.endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" /> 
            </div>

            <div>
              <input type="submit" value="#language.submit#" />
            </div>
					</fieldset>
				</form>
				
			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

</cfoutput>
