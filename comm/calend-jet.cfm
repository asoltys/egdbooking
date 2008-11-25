<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>
<cfif IsDefined('form.month')>
	<cfset url.month = form.month />
</cfif>
<cfif IsDefined('form.year')>
	<cfset url.year = form.year />
</cfif>
<cfif lang EQ "eng">
	<cfset language.ScreenMessage = "There are no events available for display">
	<cfset language.jettyCalendar = "North Landing Wharf/South Jetty Calendar">
	<cfset language.description = "Allows user to view all bookings in the jetties in a given month.">
	<cfset language.keywords = "Calendar, one month view, 1 month view, drydock side">
	<cfset language.go = "Go">
	<cfset language.viewInfo = "Click on a date to view booking information.">
	<cfset language.key = "Colour Key">
	<cfset language.bookingtype = "Booking Type">
	<cfset language.sec = "Dock Section">
	<cfset language.pendBook = "Pending Booking">
	<cfset language.tentBook = "Tentative Booking">
	<cfset language.confBook = "Confirmed Booking">
	<cfset language.prev = "previous">
	<cfset language.next = "next">
<cfelse>
	<cfset language.ScreenMessage = "Il n'existe aucune activit&eacute; &agrave; afficher.">
	<cfset language.jettyCalendar = "Calendrier de la Quai de d&eacute;barquement nord et la jet&eacute;e sud">
	<cfset language.description = "Permet &agrave; l'utilisateur de voir toutes les r&eacute;servations concernant les jet&eacute;es pour un mois donn&eacute;.">
	<cfset language.keywords = "Calendrier,  visualisation d'un mois, visualisation de 3 mois, secteur de la jet&eacute;e">
	<cfset language.go = "Afficher">
	<cfset language.viewInfo = "Cliquez sur une date pour voir les renseignements sur la r&eacute;servation.">
	<cfset language.key = "L&eacute;gende des couleurs">
	<cfset language.bookingtype = "Type de r&eacute;servation">
	<cfset language.sec = "Section de la cale s&egrave;che">
	<cfset language.pendBook = "R&eacute;servation en traitement">
	<cfset language.tentBook = "R&eacute;servation provisoire">
	<cfset language.confBook = "R&eacute;servation confirm&eacute;e">
	<cfset language.prev = "pr&eacute;c&eacute;dent">
	<cfset language.next = "suivant">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.PWGSC# - #language.esqGravingDockCaps# - #language.jettyCalendar#"" />
	<meta name=""keywords"" content=""#Language.masterKeywords#, #language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#Language.masterSubjects#"" />
	<title>#language.PWGSC# - #language.esqGravingDockCaps# - #language.jettyCalendar#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			<CFELSE>
				<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			</CFIF>
			#language.jettyCalendar#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.jettyCalendar#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
					<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				<CFELSE>
					<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
				</CFIF>

				<CFINCLUDE template="#RootDir#includes/jetty_calendar_menu.cfm">


				<CFINCLUDE template="includes/calendar_variables.cfm">
				<cfset firstdayofbunch = CreateDate(url.year, url.month, 1)>
				<cfset lastdayofbunch = CreateDate(url.year, url.month, DaysInMonth(firstdayofbunch))>
				<cfquery name="GetEvents" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT 	Status,
						StartDate, EndDate,
						NorthJetty AS Section1, SouthJetty AS Section2, '0' AS Section3,
						Vessels.Name AS VesselName, Vessels.VesselID,
						Vessels.Anonymous
					FROM	Bookings
						INNER JOIN	Jetties ON Bookings.BookingID = Jetties.BookingID
						INNER JOIN	Vessels ON Bookings.VesselID = Vessels.VesselID
					WHERE	StartDate <= #lastdayofbunch#
						AND EndDate >= #firstdayofbunch#
						AND	Bookings.Deleted = '0'
						AND	Vessels.Deleted = '0'

					UNION

					SELECT	Status,
						StartDate, EndDate,
						NorthJetty AS Section1, SouthJetty AS Section2, '0' AS Section3,
						'o' AS dummy1, '0' AS dummy2,
						'0' AS dummy3
					FROM	Bookings
						INNER JOIN	Jetties ON Bookings.BookingID = Jetties.BookingID
					WHERE	StartDate <= #lastdayofbunch#
						AND EndDate >= #firstdayofbunch#
						AND	Bookings.Deleted = '0'
						AND	Status = 'm'
				</cfquery>

				<p><cfoutput>#Language.viewInfo#</cfoutput></p>
				<CFSET pos="top">
				<CFINCLUDE template="includes/jetty_key.cfm">

				<CFIF url.month eq 1>
					<CFSET prevmonth = 12>
					<CFSET prevyear = url.year - 1>
				<CFELSE>
					<CFSET prevmonth = url.month - 1>
					<CFSET prevyear = url.year>
				</CFIF>

				<CFIF url.month eq 12>
					<CFSET nextmonth = 1>
					<CFSET nextyear = url.year + 1>
				<CFELSE>
					<CFSET nextmonth = url.month + 1>
					<CFSET nextyear = url.year>
				</CFIF>

				<cfoutput>
				<div style="float:left;"><a href="calend-jet.cfm?lang=#lang#&month=#prevmonth#&year=#prevyear#">#language.prev#</a></div>
				<div style="float:right;"><a href="calend-jet.cfm?lang=#lang#&month=#nextmonth#&year=#nextyear#">#language.next#</a></div>
				<div style="width:100%; text-align:center;">
					<form id="dateSelect" action="calend-cale-dock-3m.cfm?lang=#lang#" method="post" style="margin: 0; padding:0; ">
						<select name="month" id="month">
							<CFLOOP index="i" from="1" to="12">
								<option value="#i#" <cfif i eq url.month>selected="selected"</cfif>>#LSDateFormat(CreateDate(2005, i, 1), 'mmmm')#</option>
								</CFLOOP>
							</select>
						<select name="year" id="year">
							<CFLOOP index="i" from="-5" to="25">
								<cfset year = #DateFormat(DateAdd('yyyy', i, PacificNow), 'yyyy')# />
								<option <cfif year eq url.year>selected="selecetd"</cfif>>#year#</option>
								</CFLOOP>
							</select>
						<input type="submit" value="Go" />
					</form>
				</div>
				<CFINCLUDE template="#RootDir#includes/calendar_js.cfm">
				</cfoutput>

				<!--- THE MEAT OF THE CALENDAR HAS BEEN MOVED --->
				<CFINCLUDE template="includes/calendar_core.cfm">


				<cfoutput>
				<div style="float:left;"><a href="calend-jet.cfm?lang=#lang#&month=#prevmonth#&year=#prevyear#">#language.prev#</a></div>
				<div style="text-align:right;"><a href="calend-jet.cfm?lang=#lang#&month=#nextmonth#&year=#nextyear#">#language.next#</a></div>
				</cfoutput>

				<CFSET pos="bottom">
				<CFINCLUDE template="includes/jetty_key.cfm">

			</div>
			<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
