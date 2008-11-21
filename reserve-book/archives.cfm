<!---clear form structure--->
<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>


<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	C.Name AS CompanyName
	FROM	Companies C INNER JOIN UserCompanies UC ON C.CompanyID = UC.CompanyID
	WHERE	(C.CompanyID = '#url.companyID#')
		AND	(UC.UserID = '#Session.UserID#')
		AND	UC.Deleted = '0'
</cfquery>

<CFIF getCompany.RecordCount EQ 0>
	<CFLOCATION addtoken="no" url="#RootDir#reserve-book/reserve-booking.cfm?companyID=#url.companyID#">
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
	<meta name=""dc.title"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.archivedBookings#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.archivedBookings#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">


<cfquery name="getDockBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Bookings.*, Vessels.Name, Docks.*, FirstName, LastName, Users.FirstName + ' ' + Users.LastName AS AgentName
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VesselID = Vessels.VesselID INNER JOIN
		Companies ON Vessels.CompanyID = Companies.CompanyID INNER JOIN
		Docks ON Bookings.BookingID = Docks.BookingID INNER JOIN
		Users ON Bookings.UserID = Users.UserID
	WHERE Companies.CompanyID = '#url.companyID#' AND Bookings.Deleted = '0' AND Vessels.Deleted = 0
	ORDER BY startDate, enddate
</cfquery>

<cfquery name="getNorthJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Bookings.*, Vessels.Name, Jetties.*, FirstName, LastName, Users.FirstName + ' ' + Users.LastName AS AgentName
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VesselID = Vessels.VesselID INNER JOIN
		Companies ON Vessels.CompanyID = Companies.CompanyID INNER JOIN
		Jetties ON Bookings.BookingID = Jetties.BookingID INNER JOIN
		Users ON Bookings.UserID = Users.UserID
	WHERE Companies.CompanyID = '#url.companyID#' AND Jetties.NorthJetty = '1' AND Bookings.Deleted = '0' AND Vessels.Deleted = 0
	ORDER BY startDate, enddate
</cfquery>

<cfquery name="getSouthJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Bookings.*, Vessels.Name, Jetties.*, FirstName, LastName, Users.FirstName + ' ' + Users.LastName AS AgentName
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VesselID = Vessels.VesselID INNER JOIN
		Companies ON Vessels.CompanyID = Companies.CompanyID INNER JOIN
		Jetties ON Bookings.BookingID = Jetties.BookingID INNER JOIN
		Users ON Bookings.UserID = Users.UserID AND Jetties.SouthJetty = '1' AND Bookings.Deleted = '0' AND Vessels.Deleted = 0
	WHERE Companies.CompanyID = '#url.companyID#'
	ORDER BY startDate, enddate
</cfquery>


		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#&amp;CompanyID=#url.companyID#">#language.welcomePage#</a> &gt;
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
						<table style="padding-left:20px; width:100%;" cellspacing="0" >
				
							<cfloop query="getDockBookings">
								<CFIF counter mod 2 eq 1>
									<CFSET rowClass = "highlight">
								<CFELSE>
									<CFSET rowClass = "">
								</CFIF>
								<tr class="#rowClass#" valign="top">
									<td style="width:60%;" valign="top"><a href="#RootDir#comm/detail-res-book.cfm?lang=#lang#&bookingid=#BookingId#&referrer=#variables.referrer#&amp;CompanyID=#url.companyID#">#Name#</a></td>
									<td style="width:15%;" valign="top">
										<cfif status EQ "P"><i>#language.pending#</i>
										<cfelseif status EQ "C"><i>#language.confirmed#</i>
										<cfelseif status EQ "T"><i>#language.tentative#</i></cfif>
									</td>
									<td align="right" style="width:25%;" valign="top">
										<cfif status EQ "P" OR status eq "T"><div class="smallFont"><a href="#RootDir#reserve-book/tarifmod-tariffedit.cfm?lang=#lang#&BookingID=#BookingID#&referrer=#variables.referrer#&amp;CompanyID=#url.companyID#">#language.editTariff#</a></div>
										<cfelse><div class="smallFont"><a href="#RootDir#reserve-book/tarifconsult-tariffview.cfm?lang=#lang#&BookingID=#BookingID#&referrer=#variables.referrer#&amp;CompanyID=#url.companyID#">#language.viewTariff#</a></div></cfif>
									</td>
								</tr>
								<tr class="#rowClass#"><td colspan="3" valign="top">
									<table>
										<tr class="#rowClass#">
											<td>&nbsp;</td>
											<td style="width:50%;" valign="top"><div class="smallFont">#lsdateformat(CreateODBCDate(startDate), 'mmm d, yyyy')# - #lsdateformat(endDate, 'mmm d, yyyy')#</div></td>
											<td align="right" style="width:10%;" valign="top"><div class="smallFont">#language.Agent#: </div></td>
											<td align="left" style="width:40%;" valign="top"><div class="smallFont">#AgentName#</div></td>
										</tr>
									</table>
								</td></tr>
							<cfset counter = counter + 1>
							</cfloop>
						</table>
					<cfelse>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#language.None#
					</cfif>
				
					<cfset counter = 0>
					<h2>#language.NorthLandingWharf#</h2>
					<cfif getNorthJettyBookings.recordCount GE 1>
						<table style="padding-left:20px; width:100%;" cellspacing="0" >
							<cfloop query="getNorthJettyBookings">
								<CFIF counter mod 2 eq 1>
									<CFSET rowClass = "highlight">
								<CFELSE>
									<CFSET rowClass = "">
								</CFIF>
								<tr class="#rowClass#" valign="top">
									<td style="width:60%;" colspan="2"><a href="#RootDir#comm/detail-res-book.cfm?lang=#lang#&bookingid=#BookingId#&referrer=#variables.referrer#&&amp;CompanyID#url.companyID#">#Name#</a></td>
									<td style="width:40%;" align="left">
										<cfif NOT status eq 'c'><i>#language.pending#</i>
										<cfelse><i>#language.confirmed#</i></cfif>
									</td>
								</tr>
				
								<tr class="#rowClass#"><td colspan="3" valign="top">
									<table>
										<tr class="#rowClass#">
											<td>&nbsp;</td>
											<td style="width:50%;" valign="top"><div class="smallFont">#lsdateformat(startDate, 'mmm d, yyyy')# - #lsdateformat(endDate, 'mmm d, yyyy')#</div></td>
											<td align="right" style="width:10%;" valign="top"><div class="smallFont">#language.Agent#: </div></td>
											<td align="left" style="width:40%;" valign="top"><div class="smallFont">#AgentName#</div></td>
											
										</tr>
									</table>
								</td></tr>
							<cfset counter = counter + 1>
							</cfloop>
						</table>
					<cfelse>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#language.None#
					</cfif>
				
				<cfset counter = 0>
					<h2>#language.SouthJetty#</h2>
					<cfif getSouthJettyBookings.recordCount GE 1>
						<table style="padding-left:20px; width:100%;" cellspacing="0" >
							<cfloop query="getSouthJettyBookings">
								<CFIF counter mod 2 eq 1>
									<CFSET rowClass = "highlight">
								<CFELSE>
									<CFSET rowClass = "">
								</CFIF>
								<tr class="#rowClass#" valign="top">
									<td style="width:60%;" colspan="2"><a href="#RootDir#comm/detail-res-book.cfm?lang=#lang#&bookingid=#BookingId#&referrer=#variables.referrer#&&amp;CompanyID#url.companyID#">#Name#</a></td>
									<td style="width:40%;" align="left">
										<cfif NOT status eq 'c'><i>#language.pending#</i>
										<cfelse><i>#language.confirmed#</i></cfif>
									</td>
								</tr>
								<tr class="#rowClass#"><td colspan="3" valign="top">
									<table>
										<tr class="#rowClass#">
											<td>&nbsp;</td>
											<td style="width:50%;" valign="top"><div class="smallFont">#lsdateformat(startDate, 'mmm d, yyyy')# - #lsdateformat(endDate, 'mmm d, yyyy')#</div></td>
											<td align="right" style="width:10%;" valign="top"><div class="smallFont">#language.Agent#: </div></td>
											<td align="left" style="width:40%;" valign="top"><div class="smallFont">#AgentName#</div></td>
										</tr>
									</table>
								</td></tr>
							<cfset counter = counter + 1>
							</cfloop>
						</table>
					<cfelse>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#language.None#
					</cfif>
				<br />
				<div style="text-align:center;"><a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#&&amp;CompanyID#url.companyID#" class="textbutton">#language.returnTo#</a></div>
							
				</div>
				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
