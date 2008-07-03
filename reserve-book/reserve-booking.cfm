<!---clear form structure--->
<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<!--- these language variables have to come before the CFHTMLhead tag --->
<cfif lang EQ 'eng'>
	<cfset language.keywords = language.masterKeywords & ", Booking Request">
	<cfset language.description = "The Esquimalt Graving Dock booking application homepage.">
	<cfset language.subjects = language.masterSubjects & "">
<cfelse>
	<cfset language.keywords = language.masterKeywords & ", Demande de r&eacute;servation">
	<cfset language.description = "Page d'accueil de l'application des rservations de la Cale s che d'Esquimalt.">
	<cfset language.subjects = language.masterSubjects & "">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.Booking#"">
	<meta name=""keywords"" lang=""eng"" content=""#language.keywords#"">
	<meta name=""description"" lang=""eng"" content=""#language.description#"">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""#language.subjects#"">
	<meta name=""dc.date.published"" content=""2005-07-25"" />
	<meta name=""dc.date.reviewed"" content=""2005-07-25"" />
	<meta name=""dc.date.modified"" content=""2005-07-25"" />
	<meta name=""dc.date.created"" content=""2005-07-25"" />
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.Booking#</title>">

<cflock scope="session" throwontimeout="no" timeout="60" type="readonly">
	<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Companies.CompanyID, Name AS CompanyName, UserCompanies.Approved
		FROM	UserCompanies INNER JOIN Companies ON UserCompanies.CompanyID = Companies.CompanyID
		WHERE	UserID = #session.UserID# AND UserCompanies.Deleted = 0 AND UserCompanies.Approved = 1 AND Companies.approved = 1
		ORDER BY Companies.Name
	</cfquery>
</cflock>

<cfparam name="variables.companyID" default="#getCompanies.CompanyID#">
<cfif trim(#variables.companyID#) EQ ""><cflocation url="#RootDir#ols-login/fls-logout.cfm?lang=#lang#"></cfif>

<cflock timeout="60" throwontimeout="No" type="exclusive" scope="session">
	<cfif isDefined("URL.CompanyID")>
		<cfoutput query="getCompanies">
			<cfif URL.CompanyID eq CompanyID><cfset Variables.CompanyID = #URL.CompanyID#></cfif>
		</cfoutput>
	<cfelseif IsDefined("Session.LastChoice.CompanyID")>
		<cflocation url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#&CompanyID=#Session.LastChoice.CompanyID#" addtoken="no">
	<cfelse>
		<cflocation url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#&CompanyID=#Variables.CompanyID#" addtoken="no">
	</cfif>
	<cfset Session.LastChoice.CompanyID = Variables.CompanyID>
	<cfset Session.Flow.CompanyID = Variables.CompanyID>
</cflock>


<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Name AS CompanyName
	FROM	Companies
	WHERE	CompanyID = '#variables.companyID#'
</cfquery>

<cfquery name="getVessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT VesselID, Name
	FROM Vessels
	WHERE CompanyID = '#Variables.CompanyID#'
	AND Deleted = 0
	ORDER BY Name
</cfquery>


<cfset variables.today = CreateODBCDate(PacificNow)>
<cfquery name="getDockBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Bookings.*, Vessels.Name, Docks.*, FirstName, LastName, Users.FirstName + ' ' + Users.LastName AS AgentName
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VesselID = Vessels.VesselID INNER JOIN
		Companies ON Vessels.CompanyID = Companies.CompanyID INNER JOIN
		Docks ON Bookings.BookingID = Docks.BookingID INNER JOIN
		Users ON Bookings.UserID = Users.UserID
	WHERE Companies.CompanyID = '#Variables.companyID#' AND Bookings.Deleted = '0' AND Vessels.Deleted = 0 AND endDate >= #variables.today#
	ORDER BY startDate, enddate
</cfquery>

<cfquery name="getNorthJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Bookings.*, Vessels.Name, Jetties.*, FirstName, LastName, Users.FirstName + ' ' + Users.LastName AS AgentName
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VesselID = Vessels.VesselID INNER JOIN
		Companies ON Vessels.CompanyID = Companies.CompanyID INNER JOIN
		Jetties ON Bookings.BookingID = Jetties.BookingID INNER JOIN
		Users ON Bookings.UserID = Users.UserID
	WHERE Companies.CompanyID = '#Variables.companyID#' AND Jetties.NorthJetty = '1' AND Bookings.Deleted = '0' AND Vessels.Deleted = 0 AND endDate >= #variables.today#
	ORDER BY startDate, enddate
</cfquery>

<cfquery name="getSouthJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Bookings.*, Vessels.Name, Jetties.*, FirstName, LastName, Users.FirstName + ' ' + Users.LastName AS AgentName
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VesselID = Vessels.VesselID INNER JOIN
		Companies ON Vessels.CompanyID = Companies.CompanyID INNER JOIN
		Jetties ON Bookings.BookingID = Jetties.BookingID INNER JOIN
		Users ON Bookings.UserID = Users.UserID AND Jetties.SouthJetty = '1' AND Bookings.Deleted = '0' AND Vessels.Deleted = 0 AND endDate >= #variables.today#
	WHERE Companies.CompanyID = '#Variables.companyID#'
	ORDER BY startDate, enddate
</cfquery>

<cfquery name="currentCompany" dbtype="query">
	SELECT	CompanyName
	FROM	getCompanies
	WHERE	 getCompanies.CompanyID = #variables.companyID#
</cfquery>

<cfquery name="unapprovedCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Name AS CompanyName
		FROM	UserCompanies INNER JOIN Companies ON UserCompanies.CompanyID = Companies.CompanyID
		WHERE	 UserID = #session.UserID# AND UserCompanies.Deleted = 0 AND (UserCompanies.Approved = 0 OR Companies.approved = 0)
		ORDER  BY Companies.Name
</cfquery>

<!---Drydock Status--->
<cfquery name="countPending" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT count(*) as numPend
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VesselID = Vessels.VesselID INNER JOIN
		Companies ON Vessels.CompanyID = Companies.CompanyID INNER JOIN
		Docks ON Bookings.BookingID = Docks.BookingID INNER JOIN
		Users ON Bookings.UserID = Users.UserID
	WHERE Companies.CompanyID = '#Variables.companyID#' AND Bookings.Deleted = '0' AND Vessels.Deleted = 0 AND endDate >= #variables.today# AND (Status ='P' OR Status = 'Y' OR Status = 'Z')
	</cfquery>
<cfquery name="countTentative" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT count(*) as numTent
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VesselID = Vessels.VesselID INNER JOIN
		Companies ON Vessels.CompanyID = Companies.CompanyID INNER JOIN
		Docks ON Bookings.BookingID = Docks.BookingID INNER JOIN
		Users ON Bookings.UserID = Users.UserID
	WHERE Companies.CompanyID = '#Variables.companyID#' AND Bookings.Deleted = '0' AND Vessels.Deleted = 0 AND endDate >= #variables.today# AND Status ='T'
</cfquery>
<cfquery name="countConfirmed" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT count(*) as numConf
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VesselID = Vessels.VesselID INNER JOIN
		Companies ON Vessels.CompanyID = Companies.CompanyID INNER JOIN
		Docks ON Bookings.BookingID = Docks.BookingID INNER JOIN
		Users ON Bookings.UserID = Users.UserID
	WHERE Companies.CompanyID = '#Variables.companyID#' AND Bookings.Deleted = '0' AND Vessels.Deleted = 0 AND endDate >= #variables.today# AND Status ='C'
</cfquery>
<cfquery name="countCancelled" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT count(*) as numCanc
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VesselID = Vessels.VesselID INNER JOIN
		Companies ON Vessels.CompanyID = Companies.CompanyID INNER JOIN
		Docks ON Bookings.BookingID = Docks.BookingID INNER JOIN
		Users ON Bookings.UserID = Users.UserID
	WHERE Companies.CompanyID = '#Variables.companyID#' AND Bookings.Deleted = '0' AND Vessels.Deleted = 0 AND endDate >= #variables.today# AND Status ='X'
</cfquery>
<!---North Jetty Status--->
<cfquery name="countPendingNJ" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT count(*) as numPendNJ
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VesselID = Vessels.VesselID INNER JOIN
		Companies ON Vessels.CompanyID = Companies.CompanyID INNER JOIN
		Jetties ON Bookings.BookingID = Jetties.BookingID INNER JOIN
		Users ON Bookings.UserID = Users.UserID
	WHERE Companies.CompanyID = '#Variables.companyID#' AND Jetties.NorthJetty = '1' AND Bookings.Deleted = '0' AND Vessels.Deleted = 0 AND endDate >= #variables.today# AND (Status ='P' or Status ='Z' or Status='Y')
</cfquery>
<cfquery name="countConfirmedNJ" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT count(*) as numConfNJ
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VesselID = Vessels.VesselID INNER JOIN
		Companies ON Vessels.CompanyID = Companies.CompanyID INNER JOIN
		Jetties ON Bookings.BookingID = Jetties.BookingID INNER JOIN
		Users ON Bookings.UserID = Users.UserID
	WHERE Companies.CompanyID = '#Variables.companyID#' AND Jetties.NorthJetty = '1' AND Bookings.Deleted = '0' AND Vessels.Deleted = 0 AND endDate >= #variables.today# AND Status ='C'
</cfquery>
<cfquery name="countCancelledNJ" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT count(*) as numCancNJ
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VesselID = Vessels.VesselID INNER JOIN
		Companies ON Vessels.CompanyID = Companies.CompanyID INNER JOIN
		Jetties ON Bookings.BookingID = Jetties.BookingID INNER JOIN
		Users ON Bookings.UserID = Users.UserID
	WHERE Companies.CompanyID = '#Variables.companyID#' AND Jetties.NorthJetty = '1' AND Bookings.Deleted = '0' AND Vessels.Deleted = 0 AND endDate >= #variables.today# AND Status ='X'
</cfquery>
<!---South Jetty Status--->
<cfquery name="countPendingSJ" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT count(*) as numPendSJ
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VesselID = Vessels.VesselID INNER JOIN
		Companies ON Vessels.CompanyID = Companies.CompanyID INNER JOIN
		Jetties ON Bookings.BookingID = Jetties.BookingID INNER JOIN
		Users ON Bookings.UserID = Users.UserID AND Jetties.SouthJetty = '1' AND Bookings.Deleted = '0' AND Vessels.Deleted = 0 AND endDate >= #variables.today# AND Status ='P'
	WHERE Companies.CompanyID = '#Variables.companyID#'
</cfquery>
<cfquery name="countConfirmedSJ" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT count(*) as numConfSJ
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VesselID = Vessels.VesselID INNER JOIN
		Companies ON Vessels.CompanyID = Companies.CompanyID INNER JOIN
		Jetties ON Bookings.BookingID = Jetties.BookingID INNER JOIN
		Users ON Bookings.UserID = Users.UserID AND Jetties.SouthJetty = '1' AND Bookings.Deleted = '0' AND Vessels.Deleted = 0 AND endDate >= #variables.today# AND Status ='C'
	WHERE Companies.CompanyID = '#Variables.companyID#'
</cfquery>
<cfquery name="countCancelledSJ" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT count(*) as numCancSJ
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VesselID = Vessels.VesselID INNER JOIN
		Companies ON Vessels.CompanyID = Companies.CompanyID INNER JOIN
		Jetties ON Bookings.BookingID = Jetties.BookingID INNER JOIN
		Users ON Bookings.UserID = Users.UserID AND Jetties.SouthJetty = '1' AND Bookings.Deleted = '0' AND Vessels.Deleted = 0 AND endDate >= #variables.today# AND Status ='X'
	WHERE Companies.CompanyID = '#Variables.companyID#'
</cfquery>
<cfquery name="readonlycheck" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT ReadOnly
	FROM Users
	WHERE UserID = #Session.UserID#
</cfquery>
<cfoutput query="readonlycheck">	
	<cfset Session.ReadOnly = #ReadOnly#>
</cfoutput>
<cfif lang EQ 'eng'>
	<cfset language.currentCompany = "You are currently looking at details for: ">
	<cfset language.otherCompanies = "Other companies:">
	<cfset language.awaitingApproval = "Awaiting approval:">
	<cfset language.followingbooking = "Your current bookings for <strong>#getCompany.companyName#</strong> are as follows:">
	<cfset language.addVessel = "Add Vessel">
	<cfset language.requestBooking = "Request Booking">
	<cfset language.bookingForms = "Booking Forms">
	<cfset language.editTariff = "Edit Tariff Form">
	<cfset language.viewTariff = "View Tariff Form">
	<cfset language.agent = "Agent">
	<cfset language.administrator = "Administrator">
	<cfset language.welcome = "Welcome">
	<cfset language.none = "None">
	<cfset language.allBookings = "All Bookings">
	<cfset language.cancelling = "cancelling">
	<cfset language.confirming = "confirming">

<cfelse>
	<cfset language.currentCompany = "Vous regardez les renseignements portant sur :">
	<cfset language.otherCompanies = "Autres entreprises">
	<cfset language.awaitingApproval = "En attente d'approbation&nbsp;:">
	<cfset language.followingbooking = "Vos rservations actuelles sont les suivantes : <strong>#getCompany.companyName#</strong>">
	<cfset language.addVessel = "Ajout d'un navire">
	<cfset language.requestBooking = "Pr&eacute;sentater une r&eacute;servation">
	<cfset language.bookingForms = "Formulaires de r&eacute;servation">
	<cfset language.editTariff = "Modification du formulaire de tarif">
	<cfset language.viewTariff = "Consulter le formulaire de tarif">
	<cfset language.agent = "Agent">
	<cfset language.administrator = "Administrateur">
	<cfset language.welcome = "Bienvenue">
	<cfset language.none = "Aucun">
	<cfset language.allBookings = "Toutes les r servations">
	<cfset language.cancelling = "annulation">
	<cfset language.confirming = "confirmation ">
</cfif>


<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>#language.welcomePage#</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#getCompany.CompanyName# #language.Booking#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>
					
				<div class="content">
				<cfoutput>
				<p>#language.Welcome#, #Session.Firstname# #Session.LastName#!</p>
				</cfoutput>
				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
				
				<cfif getCompanies.recordCount GT 1>
					<div align="center">
						<cfoutput>
							<p>#language.currentcompany#<br />
							<b class="h1Size">#currentCompany.companyName#</b></p>
							<cfif getCompanies.RecordCount GT 1><p>#language.otherCompanies#<br /></cfif>
						</cfoutput>
						<cfoutput query="getCompanies">
							<cfif getCompanies.CompanyID NEQ #variables.CompanyID# AND approved eq 1><span style="white-space: nowrap; "><a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#&CompanyID=#CompanyID#">#CompanyName#</a></span>&nbsp;&nbsp;</cfif>
						</cfoutput></p>
						<cfoutput><cfif unapprovedCompany.RecordCount GTE 1><p>#language.awaitingApproval#<br /></cfif></cfoutput>
						<cfoutput query="unapprovedCompany">
							<span style="white-space: nowrap;">#CompanyName#</span>&nbsp;&nbsp;
						</cfoutput>
						</p>
					</div>
				</cfif>
							
				<cfoutput>
				
				<h2>#language.Vessel#(s):</h2>
					<table style="padding-left:20px;" width="100%">
						<cfif "getVessels.recordCount" EQ 0>
							<tr><td width="33%" align="left">#language.None#</td></tr>
						<cfelse>
							<cfloop query="getVessels">
								<tr><td width="33%" align="left"><a href="#RootDir#reserve-book/detail-navire-vessel.cfm?lang=#lang#&VesselID=#VesselID#">#Name#</a></td></tr>
							</cfloop>
						</cfif>
						<cfif #Session.ReadOnly# EQ "1"><cfelse>
						<tr><td><div style="min-height:20px;">&nbsp;</div><cfoutput><a href="#RootDir#reserve-book/navireajout-vesseladd.cfm?lang=#lang#&CompanyID=#CompanyID#" class="textbutton">#Language.addVessel#</a></cfoutput></td></tr>
						</cfif>
					</table>
				
				
				
				<p>#language.followingbooking#</p>
				<cfif #Session.ReadOnly# EQ "1"><cfelse>
				<a href="#RootDir#reserve-book/resdemande-bookrequest.cfm?lang=#lang#&companyID=#variables.companyID#" class="textbutton"><cfoutput>#language.requestBooking#</cfoutput></a>&nbsp;
				</cfif>
				<a href="#RootDir#reserve-book/formulaires-forms.cfm?lang=#lang#" class="textbutton">#language.BookingForms#</a>&nbsp;
				<a href="#RootDir#reserve-book/archives.cfm?lang=#lang#&companyID=#variables.companyID#" class="textbutton">#language.allBookings#</a><br /><br />
				
					<cfset counter = 0>
					<h2>#language.Drydock#</h2>
					<cfif getDockBookings.recordCount GE 1> 
					
						<table width="100%" cellspacing="0">
							<!---<tr>
								<td width="20%"><strong>Start Date</strong></td>
								<td width="20%"><strong>End Date</strong></td>
								<td width="30%"><strong>Vessel</strong></td>
								<td><strong>Status</strong></td>
							</tr>--->
				
							<cfloop query="getDockBookings">
								<cfif counter mod 2 eq 0>
									<cfset rowClass = "highlight">
								<cfelse>
									<cfset rowClass = "">
								</cfif>
								<!---form method="post" action="tarifmod-tariffedit.cfm?lang=#lang#&BookingID=#BookingID#" name="editForm#bookingID#"></form>
								<form method="post" action="tarifconsult-tariffview.cfm?lang=#lang#&BookingID=#BookingID#" name="viewForm#bookingID#"></form--->
								<tr class="#rowClass#" valign="top">
									<td width="60%" valign="top"><a href="#RootDir#comm/detail-res-book.cfm?lang=#lang#&bookingid=#BookingId#"><cfif #EndHighlight# GTE PacificNow>* </cfif>#Name#</a></td>
									<td width="15%" valign="top">
										<cfif status EQ "P"><i class="pending">#language.pending#</i>
										<cfelseif status EQ "C"><i class="confirmed">#language.confirmed#</i>
										<cfelseif status EQ "T"><i class="tentative">#language.tentative#</i>
										<cfelseif status EQ "Y"><i class="pending">#language.confirming#</i>
										<cfelseif status EQ "Z"><i class="pending">#language.confirming#</i>
										<cfelseif status EQ "X"><i class="cancelled">#language.cancelling#</i>
										</cfif>
									</td>
									<td align="right" width="25%" valign="top">
										<cfif status EQ "P" OR status eq "T"><div class="smallFont"><a href="#RootDir#reserve-book/tarifmod-tariffedit.cfm?lang=#lang#&BookingID=#BookingID#">#language.editTariff#</a></div>
										<cfelse><div class="smallFont"><a href="#RootDir#reserve-book/tarifconsult-tariffview.cfm?lang=#lang#&BookingID=#BookingID#">#language.viewTariff#</a></div></cfif>
									</td>
								</tr>
								<tr class="#rowClass#"><td colspan="3" valign="top">
									<table>
										<tr class="#rowClass#">
											<td>&nbsp;</td>
											<td width="50%" valign="top"><div class="smallFont">#lsdateformat(CreateODBCDate(startDate), 'mmm d, yyyy')# - #lsdateformat(endDate, 'mmm d, yyyy')#</div></td>
											<td align="right" width="10%" valign="top"><div class="smallFont">#language.Agent#: </div></td>
											<td align="left" width="40%" valign="top"><div class="smallFont">#AgentName#</div></td>
											<!---<td align="left" width="40%" valign="top"><div class="smallFont"><cfif ifAdmin.recordCount EQ 0>#AgentName#<cfelse>#language.Administrator#</cfif></div></td>--->
										</tr>
									</table>
								</td></tr>
							<cfset counter = counter + 1>
							</cfloop>
						</table>
						
						<table width="100%" cellspacing="0">
							<tr>
								<td align="center"><b>Total:&nbsp;&nbsp;</b>
								<cfoutput>
								<i class="pending">#language.pending# - #countPending.numPend#</i>&nbsp;&nbsp;
								<i class="tentative">#language.tentative# - #countTentative.numTent#</i>&nbsp;&nbsp;
								<i class="confirmed">#language.confirmed# - #countConfirmed.numConf#</i>&nbsp;&nbsp;
								<i class="cancelled">#language.cancelling# - #countCancelled.numCanc#</i>
								</cfoutput>
								</td>
							</tr>
						</table>
					<cfelse>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#language.None#
					</cfif>
				
					<cfset counter = 0>
					<h2>#language.NorthLandingWharf#</h2>
					<cfif getNorthJettyBookings.recordCount GE 1>
						<table style="padding-left:20px;" width="100%" cellspacing="0">
							<!---<tr>
								<td width="20%"><strong>Start Date</strong></td>
								<td width="20%"><strong>End Date</strong></td>
								<td width="30%"><strong>Vessel</strong></td>
								<td width="20%"><strong>Jetty</strong></td>
								<td><strong>Status</strong></td>
							</tr>--->
							<cfloop query="getNorthJettyBookings">
								<cfif counter mod 2 eq 0>
									<cfset rowClass = "highlight">
								<cfelse>
									<cfset rowClass = "">
								</cfif>
								<tr class="#rowClass#" valign="top">
									<td width="60%" colspan="2"><a href="#RootDir#comm/detail-res-book.cfm?lang=#lang#&bookingid=#BookingId#"><cfif #EndHighlight# GTE PacificNow>* </cfif>#Name#</a></td>
									<td width="40%" align="left">
										<!---
										<cfif NOT status eq 'C'><i class="pending">#language.pending#</i>
										<cfelseif status eq 'X'><i class="cancelled">#language.cancelling#</i>
										<cfelse><i class="confirmed">#language.confirmed#</i></cfif>
										--->
										
										<cfif status EQ "P"><i class="pending">#language.pending#</i>
										<cfelseif status EQ "C"><i class="confirmed">#language.confirmed#</i>
										<cfelseif status EQ "T"><i class="tentative">#language.tentative#</i>
										<cfelseif status EQ "Y"><i class="pending">#language.confirming#</i>
										<cfelseif status EQ "Z"><i class="pending">#language.confirming#</i>
										<cfelseif status EQ "X"><i class="cancelled">#language.cancelling#</i>
										</cfif>
									</td>
								</tr>
				
								<!---<cfquery name="ifAdmin" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
									SELECT	Administrators.UserID
									FROM	Administrators INNER JOIN Users ON Administrators.UserID = Users.UserID
									WHERE	Users.FirstName = '#FirstName#' AND Users.LastName = '#LastName#'
								</cfquery>--->
								<tr class="#rowClass#"><td colspan="3" valign="top">
									<table>
										<tr class="#rowClass#">
											<td>&nbsp;</td>
											<td width="50%" valign="top"><div class="smallFont">#lsdateformat(startDate, 'mmm d, yyyy')# - #lsdateformat(endDate, 'mmm d, yyyy')#</div></td>
											<td align="right" width="10%" valign="top"><div class="smallFont">#language.Agent#: </div></td>
											<td align="left" width="40%" valign="top"><div class="smallFont">#AgentName#</div></td>
											<!---<td align="left" width="40%" valign="top"><div class="smallFont"><cfif ifAdmin.recordCount EQ 0>#AgentName#<cfelse>#language.Administrator#</cfif></div></td>--->
										</tr>
									</table>
								</td></tr>
							<cfset counter = counter + 1>
							</cfloop>
						</table>
						<table width="100%" cellspacing="0">
							<tr>
								<td align="center"><b>Total:&nbsp;&nbsp;</b>
								<cfoutput>
								<i class="pending">#language.pending# - #countPendingNJ.numPendNJ#</i>&nbsp;&nbsp;
								<i class="confirmed">#language.confirmed# - #countConfirmedNJ.numConfNJ#</i>&nbsp;&nbsp;
								<i class="cancelled">#language.cancelling# - #countCancelledNJ.numCancNJ#</i>
								</cfoutput>
								</td>
							</tr>
						</table>
					<cfelse>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#language.None#
					</cfif>
				
				<cfset counter = 0>
					<h2>#language.SouthJetty#</h2>
					<cfif getSouthJettyBookings.recordCount GE 1>
						<table width="100%" cellspacing="0">
							<!---<tr>
								<td width="20%"><strong>Start Date</strong></td>
								<td width="20%"><strong>End Date</strong></td>
								<td width="30%"><strong>Vessel</strong></td>
								<td width="20%"><strong>Jetty</strong></td>
								<td><strong>Status</strong></td>
							</tr>--->
							<cfloop query="getSouthJettyBookings">
								<cfif counter mod 2 eq 0>
									<cfset rowClass = "highlight">
								<cfelse>
									<cfset rowClass = "">
								</cfif>
								<tr class="#rowClass#" valign="top">
									<td width="60%" colspan="2"><a href="#RootDir#comm/detail-res-book.cfm?lang=#lang#&bookingid=#BookingId#"><cfif #EndHighlight# GTE PacificNow>* </cfif>#Name#</a></td>					<td width="40%" align="left">
										<!---
										<cfif NOT status eq 'C'><i class="pending">#language.pending#</i>
										<cfelseif status eq 'X'><i class="cancelled">#language.cancelling#</i>
										<cfelse><i class="confirmed">#language.confirmed#</i></cfif>
										--->
										
										<cfif status EQ "P"><i class="pending">#language.pending#</i>
										<cfelseif status EQ "C"><i class="confirmed">#language.confirmed#</i>
										<cfelseif status EQ "T"><i class="tentative">#language.tentative#</i>
										<cfelseif status EQ "Y"><i class="pending">#language.confirming#</i>
										<cfelseif status EQ "Z"><i class="pending">#language.confirming#</i>
										<cfelseif status EQ "X"><i class="cancelled">#language.cancelling#</i>
										</cfif>
									</td>
								</tr>
				
								<!---<cfquery name="ifAdmin" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
									SELECT	Administrators.UserID
									FROM	Administrators INNER JOIN Users ON Administrators.UserID = Users.UserID
									WHERE	Users.FirstName = '#FirstName#' AND Users.LastName = '#LastName#'
								</cfquery>--->
								<tr class="#rowClass#"><td colspan="3" valign="top">
									<table>
										<tr class="#rowClass#">
											<td>&nbsp;</td>
											<td width="50%" valign="top"><div class="smallFont">#lsdateformat(startDate, 'mmm d, yyyy')# - #lsdateformat(endDate, 'mmm d, yyyy')#</div></td>
											<td align="right" width="10%" valign="top"><div class="smallFont">#language.Agent#: </div></td>
											<!---<td align="left" width="40%" valign="top"><div class="smallFont"><cfif ifAdmin.recordCount EQ 0>#AgentName#<cfelse>#language.Administrator#</cfif></div></td>--->
											<td align="left" width="40%" valign="top"><div class="smallFont">#AgentName#</div></td>
										</tr>
									</table>
								</td></tr>
							<cfset counter = counter + 1>
							</cfloop>
						</table>
						<table width="100%" cellspacing="0">
							<tr>
								<td align="center"><b>Total:&nbsp;&nbsp;</b>
								<cfoutput>
								<i class="pending">#language.pending# - #countPendingSJ.numPendSJ#</i>&nbsp;&nbsp;
								<i class="confirmed">#language.confirmed# - #countConfirmedSJ.numConfSJ#</i>&nbsp;&nbsp;
								<i class="cancelled">#language.cancelling# - #countCancelledSJ.numCancSJ#</i>
								</cfoutput>
							</tr>
						</table>
					<cfelse>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#language.None#<br />
					</cfif>
				<br />
				<cfif #Session.ReadOnly# EQ "1"><cfelse>
				<a href="#RootDir#reserve-book/resdemande-bookrequest.cfm?lang=#lang#&companyID=#variables.companyID#" class="textbutton"><cfoutput>#language.requestBooking#</cfoutput></a>&nbsp;
				</cfif>
				<a href="#RootDir#reserve-book/formulaires-forms.cfm?lang=#lang#" class="textbutton">#language.BookingForms#</a>&nbsp;
				<a href="#RootDir#reserve-book/archives.cfm?lang=#lang#&companyID=#variables.companyID#" class="textbutton">#language.allBookings#</a>
							
				</div>
				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
