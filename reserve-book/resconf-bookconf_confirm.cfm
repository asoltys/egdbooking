<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/build_form_struct.cfm">

<cfif lang EQ "eng">
	<cfset language.confirmBooking = "Confirm Booking">
	<cfset language.keywords = language.masterKeywords & ", Confirm Booking">
	<cfset language.description = "Allows user to confirm a tentative booking.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.areYouSure = "Are you sure you want to confirm your booking for">
	<cfset language.from = "from">
	<cfset language.to = "to">
	<cfset language.continue = "Continue">

<cfelse>
	<cfset language.confirmBooking = "Votre demande de confirmation de la r&eacute;servation">
	<cfset language.keywords = language.masterKeywords & ", Annulation de la r&eacute;servation">
	<cfset language.description = "Permet &agrave; l'utilisateur d'annuler une r&eacute;servation.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.areYouSure = "&Ecirc;tes-vous certain de confirmation de votre r&eacute;servation pour ">
	<cfset language.from = "du">
	<cfset language.to = "au">
	<cfset language.continue = "Continuer">

</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.ConfirmBooking#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.ConfirmBooking#</title>
	<link rel=""styleSHEET"" type=""text/css"" href=""#RootDir#css/booking.css"">
">

<CFPARAM name="url.referrer" default="Booking Home">
<CFIF url.referrer eq "Details For">
	<CFSET returnTo = "#RootDir#comm/detail.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#reserve-book/reserve-booking.cfm">
</CFIF>

<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>

<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Bookings.BookingID,
			StartDate, EndDate,
			Docks.Status AS DStatus, Jetties.Status AS JStatus,
			Vessels.Name AS VesselName,
			Vessels.CompanyID,
			Companies.Name AS CompanyName
	FROM	Bookings
			LEFT JOIN	Docks ON Bookings.BookingID = Docks.BookingID
			LEFT JOIN	Jetties ON Bookings.BookingID = Jetties.BookingID
			INNER JOIN	Vessels ON Bookings.VesselID = Vessels.vesselID
			INNER JOIN	Companies ON Vessels.CompanyID = Companies.CompanyID
	WHERE	Bookings.BookingID = #url.bookingid#
			AND Bookings.Deleted = '0'
			AND Vessels.Deleted = '0'
</cfquery>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			<CFELSE>
				<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			</CFIF>
			#language.ConfirmBooking#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.ConfirmBooking#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
				<cfoutput>
				<p align="center">#language.areYouSure# <strong>#getBooking.VesselName#</strong> #language.from# #LSDateFormat(getBooking.StartDate, 'mmm d, yyyy')# #language.to# #LSDateFormat(getBooking.endDate, 'mmm d, yyyy')#?</p>
				<div align="center">
					<CFFORM action="#RootDir#reserve-book/resconf-bookconf_action.cfm?lang=#lang#&CompanyID=#getBooking.CompanyID#&referrer=#URLEncodedFormat(url.referrer)##variables.dateValue#&jetty=#URL.jetty#" name="ConfirmBooking">
						<input type="hidden" name="BookingID" value="#url.bookingID#">
						<input type="submit" value="#language.Continue#" class="textbutton">
						<input type="button" onClick="self.location.href='#RootDir#comm/detail-res-book.cfm?lang=#lang#&bookingID=#url.bookingID#&referrer=#URLEncodedFormat(url.referrer)##variables.dateValue#';" class="textbutton" value="#language.Back#">
					</CFFORM>
				</div>
				</cfoutput>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

