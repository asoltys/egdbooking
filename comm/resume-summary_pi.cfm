<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/tr/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">

<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,"\")>
<cfset PageDir = listDeleteAt(cgi.CF_TEMPLATE_PATH, listLen(cgi.CF_TEMPLATE_PATH,"\"), "\")>
<cfdirectory action="LIST" directory="#PageDir#" name="GetFile" filter="#PageFileName#">
<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,"\")>


<cfif lang eq "eng" OR (IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true)>
	<cfset language.bookingsSummary = "Bookings Summary">
	<cfset language.description = "Allows user to view a summary of all bookings from present onward.">
	<cfset language.vesselCaps = "VESSEL">
	<cfset language.dockingCaps = "DOCKING DATES">
	<cfset language.bookingDateCaps = "BOOKING DATE">
	<cfset language.sectionCaps = "SECTION">
	<cfset language.deepsea = "Deepsea Vessel">
	<cfset language.noBookings = "There are no bookings to view.">
	<cfset language.booked = "Booked">
	<cfset language.closeme = "close this window">
	<cfset language.legend = "Legend">
<cfelse>
	<cfset language.bookingsSummary = "R&eacute;sum&eacute; des r&eacute;servations">
	<cfset language.description = "Permet &agrave; l'utilisateur de voir un r&eacute;sum&eacute; de toutes les r&eacute;servations, depuis le moment pr&eacute;sent.">
	<cfset language.vesselCaps = "NAVIRE">
	<cfset language.dockingCaps = "DATES D'AMARRAGE">
	<cfset language.bookingDateCaps = "DATE DE LA R&Eacute;SERVATION">
	<cfset language.sectionCaps = "SECTION">
	<cfset language.deepsea = "Navire oc&eacute;anique">
	<cfset language.noBookings = "Il n'existe aucune r&eacute;servation &agrave; afficher.">
	<cfset language.booked = "R&eacute;serv&eacute;">
	<cfset language.closeme = "Fermer cette fenêtre">
	<cfset language.legend = "Légende">
</cfif>

<head>
	<!--INTERNET TEMPLATE VERSION 2.1-->
	<!--metaDATA PROFILE START-->
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<link rel="schema.dc" href="http://purl.org/dc/elements/1.1" />
	
	<CFIF lang eq 'eng'>
	<meta name="MSSmartTagsPreventParsing" content="True" />
	<meta name="dc.language" scheme="IS0639-2" content="eng" />
	<meta name="dc.creator" lang="eng" content="Government of Canada, Public Works and Government Services Canada, Esquimalt Graving Dock" />
	<meta name="dc.publisher" lang="eng" content="Public Works and Government Services Canada" />
	<CFELSE>
	<meta name="MSSmartTagsPreventParsing" content="Vrai" />
	<link rel="schema.dc" href="http://purl.org/dc/elements/1.1" />
	<meta name="dc.language" scheme="IS0639-2" content="fre" />
	<meta name="dc.creator" content="Gouvernement du Canada, Travaux publics et Services gouvernementaux Canada, Cale s&egrave;che d'Esquimalt" />
	<meta name="dc.publisher" content="Travaux publics et Services gouvernementaux Canada" />
	</CFIF>
	
<cfoutput>
	<meta name="pwgsc.contact.email" content="questions@tpsgc.gc.ca" />
	<meta name="dc.rights" lang="#langVar#" content="http://www.tpsgc-pwgsc.gc.ca/comm/ai-in-fra.html" />
	<meta name="robots" content="noindex,nofollow" />

	<meta name="dc.title" lang="#langVar#" content="#language.PWGSC# - #language.esqGravingDockCaps# - #language.BookingsSummary#" />
	<meta name="keywords" lang="#langVar#" content="#Language.masterKeywords#" />
	<meta name="description" lang="#langVar#" content="#language.description#" />
	<meta name="dc.subject" scheme="gccore" lang="#langVar#" content="#Language.masterSubjects#" />
	<meta name="dc.date.published" content="2005-07-25" />
	<meta name="dc.date.reviewed" content="2005-07-25" />
	<meta name="dc.date.modified" content="2005-07-25" />
	<meta name="dc.date.created" content="2005-07-25"  />
	
	<meta name="pwgsc.date.retention" content="" />
	
	<!-- leave blank -->
	<meta name="dc.contributor" lang="#langVar#" content="">
	<meta name="dc.identifier" lang="#langVar#" content="">
	<meta name="dc.audience" lang="#langVar#" content="">
	<meta name="dc.type" lang="#langVar#" content="">
	<meta name="dc.format" lang="#langVar#" content="">
	<meta name="dc.coverage" lang="#langVar#" content="">
	<!--metaDATA PROFILE END-->
	
	<title>#language.PWGSC# - #language.esqGravingDockCaps# - #language.BookingsSummary#</title>
	
	<!-- CSS needed for correct printout of table headers in IE 6.0 -->
	<style type='text/css'>
        thead{display:table-header-group}
	</style>
</cfoutput> 
</head>
<body>

<CFIF IsDefined('form.fromDate')>
	<CFSET Variables.fromDate = form.fromdate>
<CFELSEIF IsDefined('url.fromDate')>
	<CFSET Variables.fromDate = url.fromdate>
</CFIF>

<CFIF IsDefined('form.toDate')>
	<CFSET Variables.toDate = form.todate>
<CFELSEIF IsDefined('url.toDate')>
	<CFSET Variables.toDate = url.todate>
</CFIF>

<CFPARAM name="Variables.fromDate" default="">
<CFPARAM name="Variables.toDate" default="">

<cfquery name="getDockBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT	Bookings.VesselID,
		Vessels.Name AS VesselName, Anonymous,
		Length AS VesselLength,
		Abbreviation, Companies.Name AS CompanyName,
		StartDate,
		EndDate,
		Status,
		Section1, Section2, Section3,
		BookingTime
FROM	Bookings
	INNER JOIN	Docks ON Bookings.BookingID = Docks.BookingID
	INNER JOIN	Vessels ON Bookings.VesselID = Vessels.VesselID
	INNER JOIN	Companies ON Vessels.CompanyID = Companies.CompanyID
WHERE	<!--- (Status = 'c' OR Status = 't')
	AND --->	Bookings.Deleted = '0'
	AND	Vessels.Deleted = '0'
	<CFIF IsDefined('Variables.fromDate') and Variables.fromDate neq ''>AND EndDate >= '#Variables.fromDate#'</CFIF>
	<CFIF IsDefined('Variables.toDate') and Variables.toDate neq ''>AND StartDate <= '#Variables.toDate#'</CFIF>
	
ORDER BY	StartDate, VesselName
</cfquery>

<cfquery name="getJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT	Bookings.VesselID,
		Vessels.Name AS VesselName, Anonymous,
		Length AS VesselLength,
		Abbreviation, Companies.Name AS CompanyName,
		StartDate,
		EndDate,
		Status,
		NorthJetty, SouthJetty,
		BookingTime
FROM	Bookings
	INNER JOIN	Jetties ON Bookings.BookingID = Jetties.BookingID
	INNER JOIN	Vessels ON Bookings.VesselID = Vessels.VesselID
	INNER JOIN	Companies ON Vessels.CompanyID = Companies.CompanyID

WHERE	Bookings.Deleted = '0'
	AND	Vessels.Deleted = '0'
	<CFIF IsDefined('Variables.fromDate') and Variables.fromDate neq ''>AND EndDate >= '#Variables.fromDate#'</CFIF>
	<CFIF IsDefined('Variables.toDate') and Variables.toDate neq ''>AND StartDate <= '#Variables.toDate#'</CFIF>

ORDER BY	StartDate, VesselName
</cfquery>

<cfquery name="getNJBookings" dbtype="query">
SELECT	* 
FROM	getJettyBookings
WHERE	NorthJetty = 1
</cfquery>

<cfquery name="getSJBookings" dbtype="query">
SELECT	* 
FROM	getJettyBookings
WHERE	SouthJetty = 1
</cfquery>

<cfquery name="getCompanies" dbtype="query">
	SELECT Abbreviation, CompanyName
	FROM getDockBookings
	UNION
	SELECT Abbreviation, CompanyName
	FROM getJettyBookings
	
	ORDER BY CompanyName
</cfquery>

<cfoutput>

<!-- FIP headER BEGINS | DEBUT DE L'EN-TETE PCIM -->
<CFIF lang EQ "eng">
<div style="float:right; position:relative; z-index:1; height:33px;">
	<img src="/clf20/images/wmms.gif" width="83" height="20" alt="Symbol of the Government of Canada" />
</div>
<a name="tphp" id="tphp"><img src="/clf20/images/sig-eng.gif" width="364" height="33" alt="Public Works and Government Services Canada" /></a>
<CFELSE>
<div style="float:right; position:relative; z-index:1; height:33px;">
	<img src="/clf20/images/wmms.gif" width="83" height="20" alt="Symbole du gouvernement du Canada" />
</div>
<a name="tphp" id="tphp"><img src="/clf20/images/sig-fra.gif" width="364" height="33" alt="Travaux publics et Services gouvernementaux Canada" /></a>
</CFIF>
<!-- FIP headER ENDS | FIN DE L'EN-TETE PCIM -->

<h1>#language.EsqGravingDock# #language.BookingsSummary#</h1>

<p class="screenonly"><a href="javascript:self.close()">#language.closeme#</a></p>

<h2>#language.Drydock#</h2>
</cfoutput>
<!--- Begin Dry Dock table --->
<table width="90%" border="1" cellpadding="2">
	<cfoutput>
	<thead>
	<tr bgcolor="##EEEEEE">
		<th id="vessel" style="width: 40%;">#language.VESSELCaps#</th>
		<th id="section" style="width: 10%;">#language.SECTIONCaps#</th>
		<th id="docking" style="width: 25%;">#language.DOCKINGCaps#</th>
		<th id="booking" style="width: 25%;">#language.BOOKINGDATECaps#</th>
	</tr>
	</thead>
	</cfoutput>
	<CFIF getDockBookings.RecordCount neq 0>
		<cfoutput query="getDockBookings">
			<!---check if ship belongs to user's company--->
			<cflock timeout="20" throwontimeout="no" type="READONLY" scope="SESSION">
				<cfquery name="userVessel#vesselID#" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	Vessels.VesselID
					FROM	Users INNER JOIN UserCompanies ON Users.UserID = UserCompanies.UserID
							INNER JOIN Vessels ON UserCompanies.CompanyID = Vessels.CompanyID
					WHERE	Users.UserID = #Session.UserID# AND VesselID = #VesselID#
						AND UserCompanies.Approved = 1 AND Users.Deleted = 0 AND UserCompanies.Deleted = 0
				</cfquery>
			</cflock>
			
			<cfset blah = Evaluate("userVessel" & #vesselID#)>
			
			<cfset Variables.countQName = "userVessel" & #vesselID# & ".recordCount">
			<cfset Variables.count = EVALUATE(countQName)>

		<tr style="<CFIF Status eq 'c'>text-transform: uppercase; font-weight: bold; <CFELSE> font-style: italic;</CFIF>">
			<td headers="vessel"><aBBR title="#CompanyName#">#Abbreviation#</aBBR> #VesselLength#M 
				<CFIF Anonymous 
					AND (NOT IsDefined('Session.AdminLoggedIn') OR NOT Session.AdminLoggedIn) 
					AND Variables.count eq 0 
					AND Status neq 'c'>#language.deepsea#<CFELSE>#VesselName#</CFIF></td>
			<td headers="section"><div align="center"><CFIF Status eq 'c'>
									<CFIF Section1 eq true>1</CFIF>
									<CFIF Section2 eq true>
										<CFIF Section1> &amp; </CFIF>
									2</CFIF>
									<CFIF Section3 eq true>
										<CFIF Section1 OR Section2> &amp; </CFIF>
									3</CFIF>
								<CFELSE>
									<CFIF Status eq 't'>
										#language.Tentative#
									<CFELSE> #language.Pending#
									</CFIF>								
								</CFIF>
								</div></td>
			<td headers="docking">#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)></CFIF> - #LSDateFormat(EndDate, "mmm d, yyyy")#</td>
			<td headers="booking">#LSDateFormat(BookingTime, 'mmm d, yyyy')#@#LSTimeFormat(BookingTime, 'HH:mm')#</td>
		</tr>
		</cfoutput>
</table>
<CFELSE>
</table>
<cfoutput>#language.noBookings#</cfoutput>
</CFIF>

<h2><cfoutput>#language.NorthLandingWharf#</cfoutput></h2>
<!-- Begin North Jetty table -->
<table width="90%" border="1" cellpadding="2">
	<cfoutput>
	<thead>
	<tr bgcolor="##EEEEEE">
		<th id="vessel2" style="width: 40%;">#language.VESSELCaps#</th>
		<th id="section2" style="width: 10%;">#language.SECTIONCaps#</th>
		<th id="docking2" style="width: 25%;">#language.DOCKINGCaps#</th>
		<th id="booking2" style="width: 25%;">#language.BOOKINGDATECaps#</th>
	</tr>
	</thead>
	</cfoutput>
	<CFIF getNJBookings.RecordCount neq 0>
		<cfoutput query="getNJBookings">
			<!---check if ship belongs to user's company--->
			<cflock timeout="20" throwontimeout="no" type="READONLY" scope="SESSION">
				<cfquery name="userVessel#vesselID#" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	Vessels.VesselID
					FROM	Users INNER JOIN UserCompanies ON Users.UserID = UserCompanies.UserID
							INNER JOIN Vessels ON UserCompanies.CompanyID = Vessels.CompanyID
					WHERE	Users.UserID = #Session.UserID# AND VesselID = #VesselID#
						AND UserCompanies.Approved = 1 AND Users.Deleted = 0 AND UserCompanies.Deleted = 0
				</cfquery>
			</cflock>
			
			<cfset blah = Evaluate("userVessel" & #vesselID#)>
			
			<cfset Variables.countQName = "userVessel" & #vesselID# & ".recordCount">
			<cfset Variables.count = EVALUATE(countQName)>

		<tr style="<CFIF Status eq 'c'>text-transform: uppercase; font-weight: bold; <CFELSE> font-style: italic;</CFIF>">
			<td headers="vessel2"><aBBR title="#CompanyName#">#Abbreviation#</aBBR> #VesselLength#M 
				<CFIF Anonymous 
					AND (NOT IsDefined('Session.AdminLoggedIn') OR NOT Session.AdminLoggedIn) 
					AND Variables.count eq 0 
					AND Status neq 'c'>#language.deepsea#<CFELSE>#VesselName#</CFIF></td>
			<td headers="section2"><div align="center"><CFIF Status eq 'c'>#language.Booked#
										<CFELSEIF Status eq 't'>#language.tentative#
										<CFELSE>#language.Pending#
										</CFIF></div></td>
			<td headers="docking2">#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)></CFIF> - #LSDateFormat(EndDate, "mmm d, yyyy")#</td>
			<td headers="booking2">#LSDateFormat(BookingTime, 'mmm d, yyyy')#@#LSTimeFormat(BookingTime, 'HH:mm')#</td>
		</tr>
		</cfoutput>
	</table>
<CFELSE>
</table>
<!-- End North Jetty table -->
<cfoutput>#language.noBookings#</cfoutput>
</CFIF>

<h2><cfoutput>#language.SouthJetty#</cfoutput></h2>
<!-- Begin South Jetty table -->
<table width="90%" border="1" cellpadding="2">
	<cfoutput>
	<thead>
	<tr bgcolor="##EEEEEE">
		<th id="vessel3" style="width: 40%;">#language.VESSELCaps#</th>
		<th id="section3" style="width: 10%;">#language.SECTIONCaps#</th>
		<th id="docking3" style="width: 25%;">#language.DOCKINGCaps#</th>
		<th id="booking3" style="width: 25%;">#language.BOOKINGDATECaps#</th>
	</tr>
	</thead>	
	</cfoutput>
	<CFIF getSJBookings.RecordCount neq 0>
		<cfoutput query="getSJBookings">
			<!---check if ship belongs to user's company--->
			<cflock timeout="20" throwontimeout="no" type="READONLY" scope="SESSION">
				<cfquery name="userVessel#vesselID#" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
					SELECT	Vessels.VesselID
					FROM	Users INNER JOIN UserCompanies ON Users.UserID = UserCompanies.UserID
							INNER JOIN Vessels ON UserCompanies.CompanyID = Vessels.CompanyID
					WHERE	Users.UserID = #Session.UserID# AND VesselID = #VesselID#
						AND UserCompanies.Approved = 1 AND Users.Deleted = 0 AND UserCompanies.Deleted = 0
				</cfquery>
			</cflock>
			
			<cfset blah = Evaluate("userVessel" & #vesselID#)>
			
			<cfset Variables.countQName = "userVessel" & #vesselID# & ".recordCount">
			<cfset Variables.count = EVALUATE(countQName)>

		<tr style="<CFIF Status eq 'c'>text-transform: uppercase; font-weight: bold; <CFELSE> font-style: italic;</CFIF>">
			<td headers="vessel3"><aBBR title="#CompanyName#">#Abbreviation#</aBBR> #VesselLength#M 
				<CFIF Anonymous 
					AND (NOT IsDefined('Session.AdminLoggedIn') OR NOT Session.AdminLoggedIn) 
					AND Variables.count eq 0 
					AND Status neq 'c'>#language.deepsea#<CFELSE>#VesselName#</CFIF></td>
			<td headers="section3"><div align="center"><CFIF Status eq 'c'>#language.Booked#
										<CFELSEIF Status eq 't'>#language.tentative#
										<CFELSE>#language.Pending#
										</CFIF></div></td>
			<td headers="docking3">#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)></CFIF> - #LSDateFormat(EndDate, "mmm d, yyyy")#</td>
			<td headers="booking3">#LSDateFormat(BookingTime, 'mmm d, yyyy')#@#LSTimeFormat(BookingTime, 'HH:mm')#</td>
		</tr>
		</cfoutput>
	</table>
<!-- End South Jetty table -->
<CFELSE>
</table>
<cfoutput>#language.noBookings#</cfoutput>
</CFIF>

<br /><br />

<!--- Legend of company abbreviations --->
<table border="1" cellpadding="2" width="60%">
<CAPTION><cfoutput><strong>#language.legend#:</strong></cfoutput></CAPTION>
	<tr>
<cfoutput query="getCompanies">
		<td width="30%">#Abbreviation# - #CompanyName#</td>
	<CFIF CurrentRow mod 3 eq 0>
	</tr>
	<tr>
	<CFELSEIF CurrentRow eq RecordCount>
	<!--- finish off the row so the table doesn't look broken --->
	<CFLOOP index="allegro" from="1" to="#3 - (RecordCount MOD 3)#">
		<td>&nbsp;</td>
	</CFLOOP>
	</tr>
	</CFIF>
</cfoutput>
</table>

<p class="screenonly"><a href="javascript:self.close()"><cfoutput>#language.closeme#</cfoutput></a></p>

			<!-- FOOTER BEGINS | DEBUT DU PIED DE LA PAGE -->
			<div class="footer">
				<hr />
				<div style="float:left; width:33.25%; text-align:left;">
					<!-- DATE MODIFIED BEGINS | DEBUT DE LA DATE DE MODIFICATION -->
					<CFIF lang EQ 'eng' OR (IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true)>Date Modified:
					<CFELSE>Date de modification&nbsp;:
					</CFIF>
						<span class="date">
						<cfoutput query="GetFile">	#LSDateFormat(parseDateTime(GetFile.DateLastModified,"mm-dd-yyyy"), "yyyy-mm-dd")#</cfoutput>
					</span>
					<!-- DATE MODIFIED ENDS | FIN DE LA DATE DE MODIFICATION -->
				</div>
				<!-- ====== /clf20/ssi/FOOT-PIED-ENG.html ====== -->
				<div class="screenonly" style="float:left; width:33.25%; text-align:center">
					<a href="#tphp" title="Return to Top of Page"><img class="uparrow" src="/egd_internet_clf2/clf20/images/tphp.gif" width="19" height="12" alt="" /><br />Top of Page</a>
				</div>
				<div style="float:left; width:33.25%; text-align:right">
					<a href="http://www.tpsgc-pwgsc.gc.ca/comm/ai-in-eng.html">Important Notices</a>
				</div>
				<!-- ====== /clf20/ssi/FOOT-PIED-ENG.html ====== -->
				
			</div>
			<!-- FOOTER ENDS | FIN DU PIED DE LA PAGE -->

</body>
</html>
