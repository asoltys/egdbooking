<!---<cfinclude template="#RootDir#includes/restore_params.cfm">--->
<cfinclude template="#RootDir#includes/build_form_struct.cfm">

<CFINCLUDE template="#RootDir#includes/generalLanguageVariables.cfm">
<cfif lang EQ "eng">
	<CFSET langVar = "eng">
	<cfset language.bookingsSummary = "Public Bookings Summary">
	<cfset language.description = "Allows user to view a summary of all bookings from present onward.">
	<cfset language.vesselCaps = "VESSEL">
	<cfset language.dockingCaps = "DOCKING DATES">
	<cfset language.bookingDateCaps = "BOOKING DATE">
	<cfset language.sectionCaps = "SECTION">
	<cfset language.deepsea = "Deepsea Vessel">
	<cfset language.noBookings = "There are no bookings to view.">
	<cfset language.booked = "Booked">
	<cfset language.printable = "VIEW PRINTABLE VERSION">
<cfelse>
	<CFSET langVar = "fre">
	<cfset language.bookingsSummary = "R&eacute;sum&eacute; des r&eacute;servations Publique">
	<cfset language.description = "Permet &agrave; l'utilisateur de voir un sommaire de toutes les r&eacute;servations &agrave; partir de maintenant.">
	<cfset language.vesselCaps = "NAVIRE">
	<cfset language.dockingCaps = "DATES D'AMARRAGE">
	<cfset language.bookingDateCaps = "DATE DE LA R&Eacute;SERVATION">
	<cfset language.sectionCaps = "SECTION">
	<cfset language.deepsea = "Navire oc&eacute;anique">
	<cfset language.noBookings = "Il n'existe aucune r&eacute;servation &agrave; afficher.">
	<cfset language.booked = "R&eacute;serv&eacute;">
	<cfset language.printable = "VOIR LA VERSION IMPRIMABLE">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.bookingsSummary# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.masterKeywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.masterSubjects#"" />
	<title>#language.bookingsSummary# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<!-- Start JavaScript Block -->
<!-- End JavaScript Block -->

<CFIF IsDefined('form.startDate')>
	<CFSET Variables.calStartDate = form.startDate>
</CFIF>

<CFIF IsDefined('form.endDate')>
	<CFSET Variables.calEndDate = form.endDate>
</CFIF>

<cfquery name="getDockBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT	Bookings.VNID,
		Vessels.Name AS VesselName, Anonymous,
		Length AS VesselLength,
		StartDate,
		EndDate,
		Status,
		Section1, Section2, Section3,
		BookingTime, 
		Companies.Abbreviation
FROM	Bookings
	INNER JOIN	Docks ON Bookings.BRID = Docks.BRID
	INNER JOIN	Vessels ON Bookings.VNID = Vessels.VNID
	INNER JOIN	Companies ON Vessels.CID = Companies.CID
WHERE	(Status = 'c' OR Status = 't')
	AND	Bookings.Deleted = '0'
	AND	Vessels.Deleted = '0'
	<!--- Eliminates any Tentative bookings with a start date before today --->
	AND ((Docks.status <> 'T') OR (Docks.status = 'T' AND Bookings.startDate >= <cfqueryparam value="#PacificNow#" cfsqltype="cf_sql_date" />))
	<CFIF IsDefined('Variables.CalStartDate') and Variables.CalStartDate neq ''>AND EndDate >= <cfqueryparam value="#Variables.CalStartDate#" cfsqltype="cf_sql_date" /></CFIF>
	<CFIF IsDefined('Variables.CalEndDate') and Variables.CalEndDate neq ''>AND StartDate <= <cfqueryparam value="#Variables.CalEndDate#" cfsqltype="cf_sql_date" /></CFIF>
	
ORDER BY	StartDate, EndDate, VesselName
</cfquery>

<cfquery name="getJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT	Bookings.VNID,
		Vessels.Name AS VesselName, Anonymous,
		Length AS VesselLength,
		StartDate,
		EndDate,
		Status,
		NorthJetty, SouthJetty,
		BookingTime, 
		Companies.Abbreviation
FROM	Bookings
	INNER JOIN	Jetties ON Bookings.BRID = Jetties.BRID
	INNER JOIN	Vessels ON Bookings.VNID = Vessels.VNID
	INNER JOIN	Companies ON Vessels.CID = Companies.CID

WHERE	Bookings.Deleted = '0'
	AND	Vessels.Deleted = '0'
	AND (Status ='c' OR Status = 't')
	<CFIF IsDefined('Variables.CalStartDate') and Variables.CalStartDate neq ''>AND EndDate >= <cfqueryparam value="#Variables.CalStartDate#" cfsqltype="cf_sql_date" /></CFIF>
	<CFIF IsDefined('Variables.CalEndDate') and Variables.CalEndDate neq ''>AND StartDate <= <cfqueryparam value="#Variables.CalEndDate#" cfsqltype="cf_sql_date" /></CFIF>
	<!--- Eliminates any Tentative bookings with a start date before today --->
	AND ((Jetties.status <> 'T') OR (Jetties.status = 'T' AND Bookings.startDate >= <cfqueryparam value="#PacificNow#" cfsqltype="cf_sql_date" />))

ORDER BY	StartDate, EndDate, VesselName
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

<script type="text/javascript">
/* <![CDATA[ */
function popUp(pageID) {
	window.open(pageID + "-e.cfm", pageID, "width=800, height=400, resizable=yes, menubar=no, scrollbars=yes, toolbar=no");
	}
/* ]]> */
</script>
<cfoutput>
		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
      #language.bookingsSummary#
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					#language.bookingsSummary#
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<h2>#language.Drydock#</h2>
				<!-- Begin Dry Docks table -->
				<table class="basic mediumFont">
          <thead>
            <tr>
              <th id="section" style="width: 20%;">#language.SECTIONCaps#</th>
              <th id="docking" style="width: 40%;">#language.DOCKINGCaps#</th>
              <th id="booking" style="width: 30%;">#language.BOOKINGDATECaps#</th>
            </tr>
          </thead>
					<CFIF getDockBookings.RecordCount neq 0>
          <tbody>
						<cfloop query="getDockBookings">
						<tr <CFIF Status eq 'c'>class="confirmed"</CFIF>>
							<td headers="section" style="text-align:center;"><CFIF Status eq 'c'>
													<CFIF Section1 eq true>1</CFIF>
													<CFIF Section2 eq true>
														<CFIF Section1> &amp; </CFIF>
													2</CFIF>
													<CFIF Section3 eq true>
														<CFIF Section1 OR Section2> &amp; </CFIF>
													3</CFIF>
												<CFELSE>#language.tentative#
												</CFIF></td>
							<td headers="docking">#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</CFIF> - #LSDateFormat(EndDate, "mmm d, yyyy")#</td>
							<td headers="booking">#LSDateFormat(BookingTime, 'mmm d, yyyy')#</td>
						</tr>
						</cfloop>
          </tbody>
        </table>
				<CFELSE>
				</table>
				<!-- End Dry Docks table -->
				#language.noBookings#
				</CFIF>
				
				<h2>#language.northLandingWharf#</h2>
				<!-- Begin North Jetty table -->
				<table class="basic mediumFont">
          <thead>
            <tr>
              <th id="section2" style="width: 20%;">#language.SECTIONCaps#</th>
              <th id="docking2" style="width: 40%;">#language.DOCKINGCaps#</th>
              <th id="booking2" style="width: 30%;">#language.BOOKINGDATECaps#</th>
            </tr>
          </thead>
					<CFIF getNJBookings.RecordCount neq 0>
          <tbody>
						<cfloop query="getNJBookings">
              <tr <CFIF Status eq 'c'>class="confirmed"</CFIF>>
                <td headers="section2"><div style="text-align:center;"><CFIF Status eq 'c'>#language.booked#
                              <CFELSEIF Status eq 't'>#language.tentative#
                              </CFIF></div></td>
                <td headers="docking2">#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</CFIF> - #LSDateFormat(EndDate, "mmm d, yyyy")#</td>
                <td headers="booking2">#LSDateFormat(BookingTime, 'mmm d, yyyy')#<!---@#LSTimeFormat(BookingTime, 'HH:mm')#---></td>
              </tr>
              </cfloop>
          </tbody>
					</table>
				<CFELSE>
				</table>
				<!-- End North Jetty table -->
				#language.noBookings#
				</CFIF>
				
				<h2>#language.southJetty#</h2>
				<!-- Begin South Jetty table -->
				<table class="basic mediumFont">
          <thead>
            <tr>
              <th id="section3" style="width: 20%;">#language.SECTIONCaps#</th>
              <th id="docking3" style="width: 40%;">#language.DOCKINGCaps#</th>
              <th id="booking3" style="width: 30%;">#language.BOOKINGDATECaps#</th>
            </tr>
          </thead>
					<CFIF getSJBookings.RecordCount neq 0>
						<cfloop query="getSJBookings">
						<tr <CFIF Status eq 'c'>class="confirmed"</CFIF>>
							<td headers="section3"><div style="text-align:center;"><CFIF Status eq 'c'>#language.booked#
														<CFELSEIF Status eq 't'>#language.tentative#
														<CFELSE>#language.pending#
														</CFIF></div></td>
							<td headers="docking3">#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</CFIF> - #LSDateFormat(EndDate, "mmm d, yyyy")#</td>
							<td headers="booking3">#LSDateFormat(BookingTime, 'mmm d, yyyy')#</td>
						</tr>
						</cfloop>
					</table>
				<!-- End South Jetty table -->
				<CFELSE>
				</table>
				#language.noBookings#
				</CFIF>
								
			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
</cfoutput>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
