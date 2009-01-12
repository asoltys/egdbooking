<cfif structKeyExists(form, 'm-m')>
	<cfset url['m-m'] = form['m-m'] />
</cfif>
<cfif structKeyExists(form, 'a-y')>
	<cfset url['a-y'] = form['a-y'] />
</cfif>
<cfif lang EQ "eng">
	<cfset language.ScreenMessage = "There are no events available for display">
	<cfset language.drydockCalendar = "Drydock Calendar">
	<cfset language.description = "Allows user to view all bookings in the drydock in a given three-month period.">
	<cfset language.keywords = "Calendar, three month view, 3 month view, drydock side">
	<cfset language.go = "Go">
	<cfset language.viewInfo = "Click on a date to view booking information.">
	<cfset language.key = "Key">
	<cfset language.bookingtype = "Booking Type">
	<cfset language.sec = "Dock Section">
	<cfset language.tentBook = "Tentative Booking">
	<cfset language.pendBook = "Pending Booking">
	<cfset language.confBook = "Confirmed Booking">
	<cfset language.sec1 = "Confirmed in Section 1 of Drydock">
	<cfset language.sec2 = "Confirmed in Section 2 of Drydock">
	<cfset language.sec3 = "Confirmed in Section 3 of Drydock">
	<cfset language.prev = "previous">
	<cfset language.next = "next">
<cfelse>
	<cfset language.ScreenMessage = "Il n'existe aucune activit&eacute; &agrave; afficher.">
	<cfset language.drydockCalendar = "Calendrier de la cale s&egrave;che">
	<cfset language.description = "Permet &agrave; l'utilisateur de voir toutes les r&eacute;servations concernant la cale s&egrave;che pour une p&eacute;riode donn&eacute;e de trois mois.">
	<cfset language.keywords = "Calendrier, visualisation de trois mois, visualisation de 3 mois, secteur de la cale s&egrave;che">
	<cfset language.go = "Afficher">
	<cfset language.viewInfo = "Cliquez sur une date pour voir les renseignements sur la r&eacute;servation.">
	<cfset language.key = "L&eacute;gende">
	<cfset language.bookingtype = "Type de r&eacute;servation">
	<cfset language.sec = "Section de la cale s&egrave;che">
	<cfset language.tentBook = "R&eacute;servation provisoire">
	<cfset language.pendBook = "R&eacute;servation en traitement">
	<cfset language.confBook = "R&eacute;servation confirm&eacute;e">
	<cfset language.sec1 = "Section 1 de la cale s&egrave;che confirm&eacute;e">
	<cfset language.sec2 = "Section 2 de la cale s&egrave;che confirm&eacute;e">
	<cfset language.sec3 = "Section 3 de la cale s&egrave;che confirm&eacute;e">
	<cfset language.prev = "pr&eacute;c&eacute;dent">
	<cfset language.next = "suivant">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.drydockCalendar# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#Language.masterKeywords#, #language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#Language.masterSubjects#"" />
	<title>#language.drydockCalendar# - #language.esqGravingDock# - #language.PWGSC#</title>">
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
			#language.drydockCalendar#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.drydockCalendar#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
					<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				<CFELSE>
					<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
				</CFIF>

				<CFINCLUDE template="#RootDir#includes/dock_calendar_menu.cfm">


				<CFINCLUDE template="includes/calendar_variables.cfm">
				<cfset firstdayofbunch = CreateDate(url['a-y'], url['m-m'], 1)>
				<cfset ahead3months= DateAdd('m', 3, firstdayofbunch)>
				<cfset lastdayofbunch = CreateDate(year(ahead3months), month(ahead3months), daysinmonth(ahead3months))>
				<cfquery name="GetEvents" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT 	Status,
						StartDate, EndDate,
						Section1, Section2, Section3,
						Vessels.Name AS VesselName, Vessels.VNID,
						Vessels.Anonymous
					FROM	Bookings
						INNER JOIN	Docks ON Bookings.BRID = Docks.BRID
						INNER JOIN	Vessels ON Bookings.VNID = Vessels.VNID
					WHERE	StartDate <= #lastdayofbunch#
						AND EndDate >= #firstdayofbunch#
						AND	Bookings.Deleted = '0'
						AND	Vessels.Deleted = '0'

					UNION

					SELECT	Status,
						StartDate, EndDate,
						Section1, Section2, Section3,
						'o' AS dummy1, '0' AS dummy2,
						'0' AS dummy3
					FROM	Bookings
						INNER JOIN	Docks ON Bookings.BRID = Docks.BRID
					WHERE	StartDate <= #lastdayofbunch#
						AND EndDate >= #firstdayofbunch#
						AND	Bookings.Deleted = '0'
						AND	Status = 'm'
				</cfquery>

				<p><cfoutput>#language.viewInfo#</cfoutput></p>

				<CFSET pos="top">

				<CFIF url['m-m'] eq 1>
					<CFSET prevmonth = 12>
					<CFSET prevyear = url['a-y'] - 1>
					<CFELSE>
					<CFSET prevmonth = url['m-m'] - 1>
					<CFSET prevyear = url['a-y']>
				</CFIF>

				<CFIF url['m-m'] eq 12>
					<CFSET nextmonth = 1>
					<CFSET nextyear = url['a-y'] + 1>
					<CFELSE>
					<CFSET nextmonth = url['m-m'] + 1>
					<CFSET nextyear = url['a-y']>
				</CFIF>


				<cfoutput>
				<div class="selector">
					<a href="calend-cale-dock-3m.cfm?lang=#lang#&amp;m-m=#prevmonth#&amp;a-y=#prevyear#" class="previousLink">#language.prev#</a>
					<a href="calend-cale-dock-3m.cfm?lang=#lang#&amp;m-m=#nextmonth#&amp;a-y=#nextyear#" class="nextLink">#language.next#</a>

					<form id="dateSelect" class="noBorder" action="calend-cale-dock-3m.cfm?lang=#lang#" method="post">
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
									<option <cfif year eq url['a-y']>selected="selected"</cfif>>#year#</option>
									</CFLOOP>
							</select>
							<input type="submit" value="Go" />
						</fieldset>
					</form>
				</div>
				</cfoutput>

				<!--- MEGA table BEGINS HERE --->

				<cfloop from="0" to="2" index="i">
					<cfif i neq 0>
						<cfif url['m-m'] neq 12>
							<cfset url['m-m'] = url['m-m']+1>
							<cfelse>
							<cfset url['m-m'] = 1>
							<cfset url['a-y'] = url['a-y']+1>
							</cfif>
						</cfif>

					<cfinclude template="includes/calendar_core.cfm">
				</cfloop>

				<cfoutput>
				<div class="selector">
					<a href="calend-cale-dock-3m.cfm?lang=#lang#&amp;m-m=#prevmonth#&amp;a-y=#prevyear#" class="previousLink">#language.prev#</a>
					<a href="calend-cale-dock-3m.cfm?lang=#lang#&amp;m-m=#nextmonth#&amp;a-y=#nextyear#" class="nextLink">#language.next#</a>
				</div>
				</cfoutput>

				<CFSET pos="bottom">
        <br />
				<CFINCLUDE template="includes/dock_key.cfm">

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
