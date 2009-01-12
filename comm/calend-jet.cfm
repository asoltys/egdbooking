<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>
<cfif structKeyExists(form, 'm-m')>
	<cfset url['m-m'] = form['m-m'] />
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
	<cfset language.key = "Key">
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
	<cfset language.key = "L&eacute;gende">
	<cfset language.bookingtype = "Type de r&eacute;servation">
	<cfset language.sec = "Section de la cale s&egrave;che">
	<cfset language.pendBook = "R&eacute;servation en traitement">
	<cfset language.tentBook = "R&eacute;servation provisoire">
	<cfset language.confBook = "R&eacute;servation confirm&eacute;e">
	<cfset language.prev = "pr&eacute;c&eacute;dent">
	<cfset language.next = "suivant">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.jettyCalendar# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#Language.masterKeywords#, #language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#Language.masterSubjects#"" />
	<title>#language.jettyCalendar# - #language.esqGravingDock# - #language.PWGSC#</title>">
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
				<cfset firstdayofbunch = CreateDate(url.year, url['m-m'], 1)>
				<cfset lastdayofbunch = CreateDate(url.year, url['m-m'], DaysInMonth(firstdayofbunch))>
				<cfquery name="GetEvents" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT 	Status,
						StartDate, EndDate,
						NorthJetty AS Section1, SouthJetty AS Section2, '0' AS Section3,
						Vessels.Name AS VesselName, Vessels.VNID,
						Vessels.Anonymous
					FROM	Bookings
						INNER JOIN	Jetties ON Bookings.BRID = Jetties.BRID
						INNER JOIN	Vessels ON Bookings.VNID = Vessels.VNID
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
						INNER JOIN	Jetties ON Bookings.BRID = Jetties.BRID
					WHERE	StartDate <= #lastdayofbunch#
						AND EndDate >= #firstdayofbunch#
						AND	Bookings.Deleted = '0'
						AND	Status = 'm'
				</cfquery>

				<p><cfoutput>#Language.viewInfo#</cfoutput></p>

				<CFIF url['m-m'] eq 1>
					<CFSET prevmonth = 12>
					<CFSET prevyear = url.year - 1>
				<CFELSE>
					<CFSET prevmonth = url['m-m'] - 1>
					<CFSET prevyear = url.year>
				</CFIF>

				<CFIF url['m-m'] eq 12>
					<CFSET nextmonth = 1>
					<CFSET nextyear = url.year + 1>
				<CFELSE>
					<CFSET nextmonth = url['m-m'] + 1>
					<CFSET nextyear = url.year>
				</CFIF>

				<cfoutput>
				<div class="selector">
					<a href="calend-jet.cfm?lang=#lang#&amp;m-m=#prevmonth#&amp;year=#prevyear#" class="previousLink">#language.prev#</a>
					<a href="calend-jet.cfm?lang=#lang#&amp;m-m=#nextmonth#&amp;year=#nextyear#" class="nextLink">#language.next#</a>
					<form id="dateSelect" class="noBorder" action="calend-jet.cfm?lang=#lang#" method="post">
						<fieldset>
							<label for="month">Month</label>
							<select name="m-m" id="month">
								<CFLOOP index="i" from="1" to="12">
									<option value="#i#" <cfif i eq url['m-m']>selected="selected"</cfif>>#LSDateFormat(CreateDate(2005, i, 1), 'mmmm')#</option>
									</CFLOOP>
								</select>
							<label for="year">Year</label>
							<select name="year" id="year">
								<CFLOOP index="i" from="-5" to="25">
									<cfset year = #DateFormat(DateAdd('yyyy', i, PacificNow), 'yyyy')# />
									<option <cfif year eq url.year>selected="selected"</cfif>>#year#</option>
									</CFLOOP>
							</select>
							<input type="submit" value="Go" />
						</fieldset>
					</form>
				</div>

				</cfoutput>

				<!--- THE MEAT OF THE CALENDAR HAS BEEN MOVED --->
				<CFINCLUDE template="includes/calendar_core.cfm">

				<cfoutput>
				<div class="selector">
					<a href="calend-jet.cfm?lang=#lang#&amp;m-m=#prevmonth#&amp;year=#prevyear#" class="previousLink">#language.prev#</a>
					<a href="calend-jet.cfm?lang=#lang#&amp;m-m=#nextmonth#&amp;year=#nextyear#" class="nextLink">#language.next#</a>
				</div>
				</cfoutput>

				<CFINCLUDE template="includes/jetty_key.cfm">

			</div>
			<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
