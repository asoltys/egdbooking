<!---clear form structure--->
<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>


<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	C.Name AS CompanyName
	FROM	Companies C INNER JOIN UserCompanies UC ON C.CID = UC.CID
	WHERE	(C.CID = '#url.CID#')
		AND	(UC.UID = '#Session.UID#')
		AND	UC.Deleted = '0'
</cfquery>

<CFIF getCompany.RecordCount EQ 0>
	<CFLOCATION addtoken="no" url="#RootDir#reserve-book/reserve-booking.cfm?CID=#url.CID#">
</CFIF>

<cfif lang EQ 'eng'>
	<cfset language.keywords = language.masterKeywords & ", Booking Archives">
	<cfset language.description = "Allows users to view all bookings for a company.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.followingbooking = "Your bookings for #getcompany.companyName# are as follows:">
	<cfset language.requestBooking = "Request New Booking">
	<cfset language.bookingForms = "Booking Forms">
	<cfset language.editTariff = "Edit Tariff Form">
	<cfset language.viewTariff = "View Tariff Form">
	<cfset language.agent = "Agent">
	<cfset language.administrator = "Administrator">
	<cfset language.none = "None">
	<cfset language.archivedBookings = "Booking Archive">
	<cfset language.returnTo = "Back to Booking Home">

<cfelse>
	<cfset language.keywords = language.masterKeywords & "">
	<cfset language.description = "Permet aux utilisateurs de voir toutes les r&eacute;servations pour une entreprise.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.followingbooking = "Vos r&eacute;servations au nom de #getcompany.companyName# sont les suivantes :">
	<cfset language.requestBooking = "Demande d'une nouvelle r&eacute;servation">
	<cfset language.bookingForms = "Formulaires de r&eacute;servation">
	<cfset language.editTariff = "Modification du formulaire de tarif">
	<cfset language.viewTariff = "Consulter le formulaire de tarif">
	<cfset language.agent = "Agent">
	<cfset language.administrator = "Administrateur">
	<cfset language.none = "Aucun">
	<cfset language.archivedBookings = "Archives des r&eacute;servations">
	<cfset language.returnTo = "Retour &agrave; Accueil&nbsp;- R&eacute;servation">
</cfif>


<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.archivedBookings# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.archivedBookings# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">


<cfquery name="getDockBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Bookings.*, Vessels.Name, Docks.*, FirstName, LastName, Users.FirstName + ' ' + Users.LastName AS AgentName
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Companies ON Vessels.CID = Companies.CID INNER JOIN
		Docks ON Bookings.BRID = Docks.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID
	WHERE Companies.CID = '#url.CID#' AND Bookings.Deleted = '0' AND Vessels.Deleted = 0
	ORDER BY startDate, enddate
</cfquery>

<cfquery name="getNorthJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Bookings.*, Vessels.Name, Jetties.*, FirstName, LastName, Users.FirstName + ' ' + Users.LastName AS AgentName
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Companies ON Vessels.CID = Companies.CID INNER JOIN
		Jetties ON Bookings.BRID = Jetties.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID
	WHERE Companies.CID = '#url.CID#' AND Jetties.NorthJetty = '1' AND Bookings.Deleted = '0' AND Vessels.Deleted = 0
	ORDER BY startDate, enddate
</cfquery>

<cfquery name="getSouthJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Bookings.*, Vessels.Name, Jetties.*, FirstName, LastName, Users.FirstName + ' ' + Users.LastName AS AgentName
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Companies ON Vessels.CID = Companies.CID INNER JOIN
		Jetties ON Bookings.BRID = Jetties.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID AND Jetties.SouthJetty = '1' AND Bookings.Deleted = '0' AND Vessels.Deleted = 0
	WHERE Companies.CID = '#url.CID#'
	ORDER BY startDate, enddate
</cfquery>


		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#&amp;CID=#url.CID#">#language.welcomePage#</a> &gt;
			#language.archivedBookings#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#getCompany.CompanyName# #language.archivedBookings#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">

				<cfset variables.referrer = "Archive">
				<cfoutput>
				<p>#language.followingbooking#</p>
					<cfset counter = 0>
					<h2>#language.Drydock#</h2>
					<cfif "getDockBookings.recordCount" GE 1>
						<table cellspacing="0" >

							<cfloop query="getDockBookings">
								<CFIF counter mod 2 eq 1>
									<CFSET rowClass = "highlight">
								<CFELSE>
									<CFSET rowClass = "">
								</CFIF>
								<tr class="#rowClass#">
									<td><a href="#RootDir#comm/detail-res-book.cfm?lang=#lang#&amp;BRID=#BRID#&amp;referrer=#variables.referrer#&amp;CID=#url.CID#">#Name#</a></td>
									<td>
										<cfif status EQ "P"><i>#language.pending#</i>
										<cfelseif status EQ "C"><i>#language.confirmed#</i>
										<cfelseif status EQ "T"><i>#language.tentative#</i></cfif>
									</td>
									<td>
										<cfif status EQ "P" OR status eq "T"><div class="smallFont"><a href="#RootDir#reserve-book/tarifmod-tariffedit.cfm?lang=#lang#&amp;BRID=#BRID#&amp;referrer=#variables.referrer#&amp;CID=#url.CID#" title="#language.editTariff#">#language.editTariff#</a></div>
										<cfelse><div class="smallFont"><a href="#RootDir#reserve-book/tarifconsult-tariffview.cfm?lang=#lang#&amp;BRID=#BRID#&amp;referrer=#variables.referrer#&amp;CID=#url.CID#" title="#language.viewTariff#">#language.viewTariff#</a></div></cfif>
									</td>
								</tr>
								<tr class="#rowClass#"><td colspan="3">
									<table>
										<tr class="#rowClass#">
											<td>&nbsp;</td>
											<td><div class="smallFont">#lsdateformat(CreateODBCDate(startDate), 'mmm d, yyyy')# - #lsdateformat(endDate, 'mmm d, yyyy')#</div></td>
											<td><div class="smallFont">#language.Agent#: </div></td>
											<td><div class="smallFont">#AgentName#</div></td>
										</tr>
									</table>
								</td></tr>
							<cfset counter = counter + 1>
							</cfloop>
						</table>
					<cfelse>
						<p>#language.None#.</p>
					</cfif>

					<cfset counter = 0>
					<h2>#language.NorthLandingWharf#</h2>
					<cfif getNorthJettyBookings.recordCount GE 1>
						<table cellspacing="0" >
							<cfloop query="getNorthJettyBookings">
								<CFIF counter mod 2 eq 1>
									<CFSET rowClass = "highlight">
								<CFELSE>
									<CFSET rowClass = "">
								</CFIF>
								<tr class="#rowClass#">
									<td colspan="2"><a href="#RootDir#comm/detail-res-book.cfm?lang=#lang#&amp;BRID=#BRID#&amp;referrer=#variables.referrer#&amp;CID#url.CID#">#Name#</a></td>
									<td>
										<cfif NOT status eq 'c'><i>#language.pending#</i>
										<cfelse><i>#language.confirmed#</i></cfif>
									</td>
								</tr>

								<tr class="#rowClass#"><td colspan="3">
									<table>
										<tr class="#rowClass#">
											<td>&nbsp;</td>
											<td><div class="smallFont">#lsdateformat(startDate, 'mmm d, yyyy')# - #lsdateformat(endDate, 'mmm d, yyyy')#</div></td>
											<td><div class="smallFont">#language.Agent#: </div></td>
											<td><div class="smallFont">#AgentName#</div></td>

										</tr>
									</table>
								</td></tr>
							<cfset counter = counter + 1>
							</cfloop>
						</table>
					<cfelse>
						<p>#language.None#.</p>
					</cfif>

				<cfset counter = 0>
					<h2>#language.SouthJetty#</h2>
					<cfif getSouthJettyBookings.recordCount GE 1>
						<table cellspacing="0" >
							<cfloop query="getSouthJettyBookings">
								<CFIF counter mod 2 eq 1>
									<CFSET rowClass = "highlight">
								<CFELSE>
									<CFSET rowClass = "">
								</CFIF>
								<tr class="#rowClass#">
									<td colspan="2"><a href="#RootDir#comm/detail-res-book.cfm?lang=#lang#&amp;BRID=#BRID#&amp;referrer=#variables.referrer#&amp;CID#url.CID#">#Name#</a></td>
									<td>
										<cfif NOT status eq 'c'><i>#language.pending#</i>
										<cfelse><i>#language.confirmed#</i></cfif>
									</td>
								</tr>
								<tr class="#rowClass#"><td colspan="3">
									<table>
										<tr class="#rowClass#">
											<td>&nbsp;</td>
											<td><div class="smallFont">#lsdateformat(startDate, 'mmm d, yyyy')# - #lsdateformat(endDate, 'mmm d, yyyy')#</div></td>
											<td><div class="smallFont">#language.Agent#: </div></td>
											<td><div class="smallFont">#AgentName#</div></td>
										</tr>
									</table>
								</td></tr>
							<cfset counter = counter + 1>
							</cfloop>
						</table>
					<cfelse>
						<p>#language.None#.</p>
					</cfif>
				<br />
				<div class="buttons"><a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#&amp;CID#url.CID#" class="textbutton">#language.returnTo#</a></div>

				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
