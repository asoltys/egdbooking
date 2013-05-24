<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/build_form_struct.cfm">

<cfif lang EQ "eng">
	<cfset language.cancelBooking = "Confirm Cancel Booking">
	<cfset language.keywords = language.masterKeywords & ", Cancel Booking">
	<cfset language.description = "Allows user to cancel a booking.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.areYouSure = "Are you sure you want to cancel your booking for">
	<cfset language.from = "from">
	<cfset language.to = "to">
	<cfset language.continue = "Continue">

<cfelse>
	<cfset language.cancelBooking = "Confirmation de l'annulation de la r&eacute;servation">
	<cfset language.keywords = language.masterKeywords & ", Annulation de la r&eacute;servation">
	<cfset language.description = "Permet &agrave; l'utilisateur d'annuler une r&eacute;servation.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.areYouSure = "&Ecirc;tes-vous certain de vouloir annuler votre r&eacute;servation pour ">
	<cfset language.from = "du">
	<cfset language.to = "au">
	<cfset language.continue = "Continuer">

</cfif>
<cfset request.title = language.cancelBooking />
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFPARAM name="url.referrer" default="#language.bookingHome#">
<CFIF url.referrer eq "Details For">
	<CFSET returnTo = "#RootDir#comm/detail.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#reserve-book/reserve-booking.cfm">
</CFIF>

<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&amp;date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>

<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Bookings.BRID,
			StartDate, EndDate,
			Docks.Status AS DStatus, Jetties.Status AS JStatus,
			Vessels.Name AS VesselName,
			Vessels.CID,
			Companies.Name AS CompanyName
	FROM	Bookings
			LEFT JOIN	Docks ON Bookings.BRID = Docks.BRID
			LEFT JOIN	Jetties ON Bookings.BRID = Jetties.BRID
			INNER JOIN	Vessels ON Bookings.VNID = Vessels.VNID
			INNER JOIN	Companies ON Vessels.CID = Companies.CID
	WHERE	Bookings.BRID = <cfqueryparam value="#url.BRID#" cfsqltype="cf_sql_integer" />
			AND Bookings.Deleted = '0'
			AND Vessels.Deleted = '0'
</cfquery>

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""#language.CancelBooking# ###BRID# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dcterms.subject"" content=""#language.subjects#"" />
	<title>#language.CancelBooking# ###BRID# - #language.esqGravingDock# - #language.PWGSC#</title>
">

				<h1 id="wb-cont"><cfoutput>#language.CancelBooking#</cfoutput></h1>

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">

				<cfoutput>
				<form action="#RootDir#reserve-book/resannul-bookcancel_action.cfm?lang=#lang#&amp;CID=#getBooking.CID#" id="cancelBooking" method="post">
          <fieldset>
            <legend>#language.confirm#</legend>
            <p>#language.areYouSure# <strong>#getBooking.VesselName#</strong> #language.from# #myDateFormat(getBooking.StartDate, request.datemask)# #language.to# #myDateFormat(getBooking.endDate, request.datemask)#?</p>
            <input type="hidden" name="BRID" value="#url.BRID#" />
            <input type="hidden" name="jetty" value="#url.jetty#" />
            <input type="submit" value="#language.Confirm#" class="textbutton" />
          </fieldset>
				</form>

				</cfoutput>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
