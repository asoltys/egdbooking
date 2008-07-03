<cfinclude template="#RootDir#includes/bookingInfoVariables.cfm">
<cfif lang EQ "eng">
	<cfset language.deleteVessel = "Delete Vessel">
	<cfset language.keywords = language.masterKeywords & ", Delete Vessel">
	<cfset language.description = "Allows user to delete a vessel.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.areYouSure = "Are you sure you want to delete">
	<cfset language.delete = "Delete">
	<cfset language.cannotDelete = "cannot be deleted as it is booked for the following dates.  Please cancel all bookings before deleting the vessel.">
	<cfset language.ok = "OK">

<cfelse>
	<cfset language.deleteVessel = "Suppression de navire">
	<cfset language.keywords = language.masterKeywords & ", Suppression de navire">
	<cfset language.description = "Permet &agrave; l'utilisateur de supprimer un navire.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.areYouSure = "&Ecirc;tes-vous certain de vouloir supprimer ">
	<cfset language.delete = "Supprimer">
	<cfset language.cannotDelete = "ne peut pas &ecirc;tre supprim&eacute; puisqu'il fait l'objet d'une r&eacute;servation pour les dates suivantes. Veuillez annuler toutes les r&eacute;servations avant de supprimer le navire.">
	<cfset language.ok = "OK">

</cfif>

	<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.DeleteVessel#"">
	<meta name=""keywords"" lang=""eng"" content=""#language.DeleteVessel#"">
	<meta name=""description"" lang=""eng"" content=""#language.description#"">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""" />
	<meta name=""dc.date.published"" content=""2005-07-25"" />
	<meta name=""dc.date.reviewed"" content=""2005-07-25"" />
	<meta name=""dc.date.modified"" content=""2005-07-25"" />
	<meta name=""dc.date.created"" content=""2005-07-25"" />
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.DeleteVessel#</title>">

<script language="JavaScript" type="text/javascript">
	function SubmitForm(selectedForm) {
		document.forms[selectedForm].submit();
	}
</script>

<cfif NOT IsDefined('url.vesselID') OR NOT IsNumeric(url.vesselID)>
	<cflocation addtoken="no" url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">
</cfif>

<cfquery name="getVesselDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Vessels.VesselID, Vessels.Name, Vessels.CompanyID
	FROM  Vessels
	WHERE VesselID = #url.VesselID#
	AND Vessels.deleted = 0
</cfquery>

<cfquery name="getVesselDockBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	*
	FROM	Bookings INNER JOIN Vessels ON Vessels.VesselID = Bookings.VesselID
			INNER JOIN Docks ON Bookings.BookingID = Docks.BookingID
	WHERE	EndDate >= #CreateODBCDate(PacificNow)# AND Vessels.VesselID = #url.VesselID# AND Bookings.Deleted = 0
</cfquery>

<cfquery name="getVesselJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	*
	FROM	Bookings INNER JOIN Vessels ON Vessels.VesselID = Bookings.VesselID
			INNER JOIN Jetties ON Bookings.BookingID = Jetties.BookingID
	WHERE	EndDate >= #CreateODBCDate(PacificNow)# AND Vessels.VesselID = #url.VesselID# AND Bookings.Deleted = 0
</cfquery>

<cfif getVesselDetail.recordCount EQ 0>
	<cflocation addtoken="no" url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">
</cfif>

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			<CFELSE>
				<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			</CFIF>
			#language.DeleteVessel#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.DeleteVessel#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
				
				<cfif getVesselDockBookings.recordCount EQ 0 AND getVesselJettyBookings.recordCount EQ 0>
						<cfoutput query="getVesselDetail">
							<p align="center">#language.areYouSure# <strong>#name#</strong>?</p>
							<div align="center">
							<form name="DelVessel" action="#RootDir#reserve-book/naviresup-vesseldel_action.cfm?lang=#lang#&CompanyID=#CompanyID#" method="post">
								<input type="hidden" name="VesselID" value="#vesselID#">
								<input type="submit" value="#language.Delete#" class="textbutton">
								<input type="button" value="#language.Cancel#" onClick="history.go(-1);" class="textbutton">
							</form>
							</div>
						</cfoutput>
				<cfelse>
						<p><cfoutput><strong>#getVesselDetail.name#</strong> #language.cannotDelete#</cfoutput></p>
				
						<cfif getVesselDockBookings.recordCount GT 0>
							<cfoutput>
							<table style="padding-left:20px;" width="100%">
								<tr><td><h2>#language.Drydock#</i></strong></h2>
								<tr>
									<td width="25%" id="start"><strong>#language.StartDate#</strong></td>
									<td width="60%" id="end"><strong>#language.EndDate#</strong></td>
									<td width="15%" id="status"><strong>#language.Status#</strong></td>
								</tr>
							</cfoutput>
							<cfoutput query="getVesselDockBookings">
								<tr>
									<td valign="top" headers="start">#LSdateformat(startDate, "mmm d, yyyy")#</td>
									<td valign="top" headers="end">#LSdateformat(endDate, "mmm d, yyyy")#</td>
									<td valign="top" headers="status">
										<cfif status EQ "P"><i>#language.pending#</i>
										<cfelseif status EQ "T"><i>#language.tentative#</i>
										<cfelseif status EQ "C"><i>#language.confirmed#</i></cfif>
									</td>
								</tr>
							</cfoutput>
							</table>
						</cfif>
				
						<cfif getVesselJettyBookings.recordCount GT 0>
							<cfoutput>
							<table style="padding-left:20px;" width="100%">
								<tr><td><h2>#language.Jetty#</i></strong></h2>
								<tr>
									<td width="25%" id="start"><strong>#language.StartDate#</strong></td>
									<td width="25%" id="end"><strong>#language.EndDate#</strong></td>
									<td width="35%" id="jetty"><strong>#language.Jetty#</strong></td>
									<td width="15%" id="status"><strong>#language.Status#</strong></td>
								</tr>
							</cfoutput>
							<cfoutput query="getVesselJettyBookings">
								<tr>
									<td valign="top" headers="start">#LSdateformat(startDate, "mmm d, yyyy")#</td>
									<td valign="top" headers="end">#LSdateformat(endDate, "mmm d, yyyy")#</td>
									<td valign="top" headers="jetty">
										<cfif getVesselJettyBookings.NorthJetty EQ 1>
											#language.NorthLandingWharf#
										<cfelseif getVesselJettyBookings.SouthJetty EQ 1>
											#language.SouthJetty#
										</cfif>
									</td>
									<td valign="top" headers="status">
										<cfif status EQ "P"><i>#language.pending#</i>
										<cfelseif status EQ "C"><i>#language.confirmed#</i></cfif>
									</td>
								</tr>
							</cfoutput>
							</table>
						</cfif>
						<br />
						<cfoutput>
						<div align="center"><a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#&CompanyID=#getVesselDetail.companyID#" class="textbutton">#language.OK#</a></div></cfoutput>
				</cfif>
			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

