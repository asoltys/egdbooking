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

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.CancelBooking# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.CancelBooking# - #language.esqGravingDock# - #language.PWGSC#</title>
">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFPARAM name="url.referrer" default="Booking Home">
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

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			<CFELSE>
				<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			</CFIF>
			#language.CancelBooking#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.CancelBooking#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">

				<cfoutput>
				<CFFORM action="#RootDir#reserve-book/resannul-bookcancel_action.cfm?lang=#lang#&amp;CID=#getBooking.CID#&amp;referrer=#URLEncodedFormat(url.referrer)##variables.dateValue#&amp;jetty=#url.jetty#" id="cancelBooking">
					<p>#language.areYouSure# <strong>#getBooking.VesselName#</strong> #language.from# #LSDateFormat(getBooking.StartDate, 'mmm d, yyyy')# #language.to# #LSDateFormat(getBooking.endDate, 'mmm d, yyyy')#?</p>
					<div class="buttons">
						<input type="hidden" name="BRID" value="#url.BRID#" />
						<input type="submit" value="#language.Continue#" class="textbutton" />
						<input type="button" onclick="self.location.href='#RootDir#comm/detail-res-book.cfm?lang=#lang#&amp;BRID=#url.BRID#&amp;referrer=#URLEncodedFormat(url.referrer)##variables.dateValue#';" class="textbutton" value="#language.Back#" />
					</div>
				</CFFORM>

				</cfoutput>
			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
