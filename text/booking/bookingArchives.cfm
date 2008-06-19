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
	<CFLOCATION addtoken="no" url="booking.cfm?companyID=#url.companyID#">
</CFIF>

<cfif lang EQ 'e'>
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
<meta name=""dc.title"" lang=""eng"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.archivedBookings#"">
<meta name=""keywords"" lang=""eng"" content=""#language.keywords#"">
<meta name=""description"" lang=""eng"" content=""#language.description#"">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""#language.subjects#"">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
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



<cfoutput>
<div class="breadcrumbs">
	<a href="http://www.pwgsc.gc.ca/text/home-#lang#.html">#language.PWGSC#</a> &gt;
	#language.PacificRegion# &gt;
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-#lang#.html">#language.EsqGravingDock#</a> &gt;
	<a href="../booking-#lang#.cfm">#language.Booking#</a> &gt;
	<a href="booking.cfm?lang=#lang#&amp;companyID=#url.companyID#">#language.welcomePage#</a> &gt;
	#language.archivedBookings#
</div>
</cfoutput>

<div class="main">
<cfoutput><H1>#getCompany.CompanyName# #language.archivedBookings#</H1></cfoutput>

<div class="content">
<CFINCLUDE template="#RootDir#includes/user_menu.cfm"><br>

<cfset variables.referrer = "Archive">
<cfoutput>
<p>#language.followingbooking#</p>
<!---div class="EventAdd"><a href="bookingRequest.cfm" class="textbutton"><cfoutput>#language.ButtonLabel1#</cfoutput></a></div><br>
<div class="EventAdd"><a href="jettyRequest.cfm" class="textbutton"><cfoutput>#language.ButtonLabel3#</cfoutput></a></div><br>
<A href="bookingRequest_choose.cfm?lang=#lang#&amp;companyID=#url.companyID#" class="textbutton"><cfoutput>#language.requestBooking#</cfoutput></A>&nbsp;
<a href="otherForms.cfm?lang=#lang#" class="textbutton">#language.BookingForms#</a><br><br--->
	<cfset counter = 0>
	&nbsp;&nbsp;&nbsp;<strong>#language.Drydock#</strong>
	<cfif "getDockBookings.recordCount" GE 1>
		<table style="padding-left:20px;font-size:10pt;" width="100%" cellspacing="0">
			<!---<tr>
				<td width="20%"><strong>Start Date</strong></td>
				<td width="20%"><strong>End Date</strong></td>
				<td width="30%"><strong>Vessel</strong></td>
				<td><strong>Status</strong></td>
			</tr>--->

			<cfloop query="getDockBookings">
				<CFIF counter mod 2 eq 1>
					<CFSET rowClass = "altYellow">
				<CFELSE>
					<CFSET rowClass = "">
				</CFIF>
			  	<!---form method="post" action="editFeesForm.cfm?lang=#lang#&amp;BookingID=#BookingID#" name="editForm#bookingID#"></form>
				<form method="post" action="viewFeesForm.cfm?lang=#lang#&amp;BookingID=#BookingID#" name="viewForm#bookingID#"></form--->
				<TR class="#rowClass#" valign="top">
					<td width="60%" valign="top"><a href="#RootDir#text/common/getBookingDetail.cfm?lang=#lang#&amp;bookingid=#BookingId#&amp;referrer=#variables.referrer#&companyID=#url.companyID#">#Name#</a></td>
					<td width="15%" valign="top">
						<cfif status EQ "P"><i>#language.pending#</i>
						<cfelseif status EQ "C"><i>#language.confirmed#</i>
						<cfelseif status EQ "T"><i>#language.tentative#</i></cfif>
					</td>
					<td align="right" width="25%" valign="top">
						<cfif status EQ "P" OR status eq "T"><div style="font-size:8pt;"><a href="editFeesForm.cfm?lang=#lang#&amp;BookingID=#BookingID#&amp;referrer=#variables.referrer#&companyID=#url.companyID#">#language.editTariff#</a></div>
						<cfelse><div style="font-size:8pt;"><a href="viewFeesForm.cfm?lang=#lang#&amp;BookingID=#BookingID#&amp;referrer=#variables.referrer#&companyID=#url.companyID#">#language.viewTariff#</a></div></cfif>
					</td>
				</tr>
				<tr class="#rowClass#"><td colspan="3" valign="top">
					<table>
						<tr>
							<td>&nbsp;</td>
							<td width="50%" valign="top"><div style="font-size:8pt;">#lsdateformat(CreateODBCDate(startDate), 'mmm d, yyyy')# - #lsdateformat(endDate, 'mmm d, yyyy')#</div></td>
							<td align="right" width="10%" valign="top"><div style="font-size:8pt;">#language.Agent#: </div></td>
							<td align="left" width="40%" valign="top"><div style="font-size:8pt;">#AgentName#</div></td>
							<!---<td align="left" width="40%" valign="top"><div style="font-size:8pt;"><cfif ifAdmin.recordCount EQ 0>#AgentName#<cfelse>#language.Administrator#</cfif></div></td>--->
						</tr>
					</table>
				</td></tr>
			<cfset counter = counter + 1>
			</cfloop>
		</table>
	<cfelse>
		<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#language.None#
	</cfif>

	<cfset counter = 0>
	<br><br>&nbsp;&nbsp;&nbsp;<strong>#language.NorthLandingWharf#</strong>
	<cfif getNorthJettyBookings.recordCount GE 1>
		<table style="padding-left:20px;font-size:10pt;" width="100%" cellspacing="0">
			<!---<tr>
				<td width="20%"><strong>Start Date</strong></td>
				<td width="20%"><strong>End Date</strong></td>
				<td width="30%"><strong>Vessel</strong></td>
				<td width="20%"><strong>Jetty</strong></td>
				<td><strong>Status</strong></td>
			</tr>--->
			<cfloop query="getNorthJettyBookings">
				<CFIF counter mod 2 eq 1>
					<CFSET rowClass = "altYellow">
				<CFELSE>
					<CFSET rowClass = "">
				</CFIF>
				<TR class="#rowClass#" valign="top">
					<td width="60%" colspan="2"><a href="#RootDir#text/common/getBookingDetail.cfm?lang=#lang#&amp;bookingid=#BookingId#&amp;referrer=#variables.referrer#&companyID=#url.companyID#">#Name#</a></td>
					<td width="40%" align="left">
						<cfif NOT status eq 'c'><i>#language.pending#</i>
						<cfelse><i>#language.confirmed#</i></cfif>
					</td>
				</tr>

				<!---<cfquery name="ifAdmin" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	Administrators.UserID
					FROM	Administrators INNER JOIN Users ON Administrators.UserID = Users.UserID
					WHERE	Users.FirstName = '#FirstName#' AND Users.LastName = '#LastName#'
				</cfquery>--->
				<tr class="#rowClass#"><td colspan="3" valign="top">
					<table>
						<tr>
							<td>&nbsp;</td>
							<td width="50%" valign="top"><div style="font-size:8pt;">#lsdateformat(startDate, 'mmm d, yyyy')# - #lsdateformat(endDate, 'mmm d, yyyy')#</div></td>
							<td align="right" width="10%" valign="top"><div style="font-size:8pt;">#language.Agent#: </div></td>
							<td align="left" width="40%" valign="top"><div style="font-size:8pt;">#AgentName#</div></td>
							<!---<td align="left" width="40%" valign="top"><div style="font-size:8pt;"><cfif ifAdmin.recordCount EQ 0>#AgentName#<cfelse>#language.Administrator#</cfif></div></td>--->
						</tr>
					</table>
				</td></tr>
			<cfset counter = counter + 1>
			</cfloop>
		</table>
	<cfelse>
		<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#language.None#
	</cfif>

<cfset counter = 0>
	<br><br>&nbsp;&nbsp;&nbsp;<strong>#language.SouthJetty#</strong>
	<cfif getSouthJettyBookings.recordCount GE 1>
		<table style="padding-left:20px;font-size:10pt;" width="100%" cellspacing="0">
			<!---<tr>
				<td width="20%"><strong>Start Date</strong></td>
				<td width="20%"><strong>End Date</strong></td>
				<td width="30%"><strong>Vessel</strong></td>
				<td width="20%"><strong>Jetty</strong></td>
				<td><strong>Status</strong></td>
			</tr>--->
			<cfloop query="getSouthJettyBookings">
				<CFIF counter mod 2 eq 1>
					<CFSET rowClass = "altYellow">
				<CFELSE>
					<CFSET rowClass = "">
				</CFIF>
				<TR class="#rowClass#" valign="top">
					<td width="60%" colspan="2"><a href="#RootDir#text/common/getBookingDetail.cfm?lang=#lang#&amp;bookingid=#BookingId#&amp;referrer=#variables.referrer#&companyID=#url.companyID#">#Name#</a></td>					<td width="40%" align="left">
						<cfif NOT status eq 'c'><i>#language.pending#</i>
						<cfelse><i>#language.confirmed#</i></cfif>
					</td>
				</tr>

				<!---<cfquery name="ifAdmin" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	Administrators.UserID
					FROM	Administrators INNER JOIN Users ON Administrators.UserID = Users.UserID
					WHERE	Users.FirstName = '#FirstName#' AND Users.LastName = '#LastName#'
				</cfquery>--->
				<tr class="#rowClass#"><td colspan="3" valign="top">
					<table>
						<tr>
							<td>&nbsp;</td>
							<td width="50%" valign="top"><div style="font-size:8pt;">#lsdateformat(startDate, 'mmm d, yyyy')# - #lsdateformat(endDate, 'mmm d, yyyy')#</div></td>
							<td align="right" width="10%" valign="top"><div style="font-size:8pt;">#language.Agent#: </div></td>
							<!---<td align="left" width="40%" valign="top"><div style="font-size:8pt;"><cfif ifAdmin.recordCount EQ 0>#AgentName#<cfelse>#language.Administrator#</cfif></div></td>--->
							<td align="left" width="40%" valign="top"><div style="font-size:8pt;">#AgentName#</div></td>
						</tr>
					</table>
				</td></tr>
			<cfset counter = counter + 1>
			</cfloop>
		</table>
	<cfelse>
		<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#language.None#
	</cfif>
<br>
<!---A href="bookingRequest_choose.cfm?lang=#lang#&amp;companyID=#url.companyID#" class="textbutton"><cfoutput>#language.requestBooking#</cfoutput></A>&nbsp;
<a href="otherForms.cfm?lang=#lang#" class="textbutton">#language.BookingForms#</a--->
<div align="center"><a href="booking.cfm?lang=#lang#&amp;companyID=#url.companyID#" class="textbutton">#language.returnTo#</a></div>
<br><br>

</div>
</div>
</cfoutput>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

