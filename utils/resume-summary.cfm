<cfinclude template="#RootDir#includes/build_form_struct.cfm">

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
	<meta name=""dcterms.title"" content=""#language.bookingsSummary# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.masterKeywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dcterms.subject"" scheme=""gccore"" content=""#language.masterSubjects#"" />
	<title>#language.bookingsSummary# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfparam name="Variables.CalStartDate" default="" />
<cfparam name="Variables.CalEndDate" default="" />

<cfif IsDefined('form.startDate')>
	<cfset Variables.CalStartDate = form.startDate>
</cfif>

<cfif IsDefined('form.endDate')>
	<cfset Variables.CalEndDate = form.endDate>
</cfif>

<cfif not isDate(Variables.CalStartDate) and Variables.CalStartDate neq "">
  <cfset ArrayAppend(Variables.Errors, language.invalidStartError) />
	<cfset Proceed_OK = "No">
</cfif>

<cfif not isDate(Variables.CalEndDate) and Variables.CalEndDate neq "">
  <cfset ArrayAppend(Variables.Errors, language.invalidEndError) />
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation addtoken="no" url="resume-summary_ch.cfm?lang=#lang#" />
</cfif>

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
	<cfif IsDefined('Variables.CalStartDate') and Variables.CalStartDate neq ''>AND EndDate >= <cfqueryparam value="#Variables.CalStartDate#" cfsqltype="cf_sql_date" /></cfif>
	<cfif IsDefined('Variables.CalEndDate') and Variables.CalEndDate neq ''>AND StartDate <= <cfqueryparam value="#Variables.CalEndDate#" cfsqltype="cf_sql_date" /></cfif>
	
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
	<cfif IsDefined('Variables.CalStartDate') and Variables.CalStartDate neq ''>AND EndDate >= <cfqueryparam value="#Variables.CalStartDate#" cfsqltype="cf_sql_date" /></cfif>
	<cfif IsDefined('Variables.CalEndDate') and Variables.CalEndDate neq ''>AND StartDate <= <cfqueryparam value="#Variables.CalEndDate#" cfsqltype="cf_sql_date" /></cfif>
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
        <cfif getDockBookings.RecordCount neq 0>
          <table class="basic mediumFont">
            <thead>
              <tr>
                <th id="section" style="width: 20%;">#language.SECTIONCaps#</th>
                <th id="docking" style="width: 40%;">#language.DOCKINGCaps#</th>
                <th id="booking" style="width: 30%;">#language.BOOKINGDATECaps#</th>
              </tr>
            </thead>
            <tbody>
              <cfloop query="getDockBookings">
              <tr <cfif Status eq 'c'>class="confirmed"</cfif>>
                <td headers="section" style="text-align:center;"><cfif Status eq 'c'>
                            <cfif Section1 eq true>1</cfif>
                            <cfif Section2 eq true>
                              <cfif Section1> &amp; </cfif>
                            2</cfif>
                            <cfif Section3 eq true>
                              <cfif Section1 OR Section2> &amp; </cfif>
                            3</cfif>
                          <cfelse>#language.tentative#
                          </cfif></td>
                <td headers="docking">#myDateFormat(StartDate, request.datemask)# - #myDateFormat(EndDate, request.datemask)#</td>
                <td headers="booking">#myDateFormat(BookingTime, request.datemask)#</td>
              </tr>
              </cfloop>
            </tbody>
          </table>
				<cfelse>
          <p>
            #language.noBookings#
          </p>
				</cfif>
				
				<h2>#language.northLandingWharf#</h2>
        <cfif getNJBookings.RecordCount neq 0>
          <table class="basic mediumFont">
            <thead>
              <tr>
                <th id="section2" style="width: 20%;">#language.SECTIONCaps#</th>
                <th id="docking2" style="width: 40%;">#language.DOCKINGCaps#</th>
                <th id="booking2" style="width: 30%;">#language.BOOKINGDATECaps#</th>
              </tr>
            </thead>
            <tbody>
              <cfloop query="getNJBookings">
                <tr <cfif Status eq 'c'>class="confirmed"</cfif>>
                  <td headers="section2"><div style="text-align:center;"><cfif Status eq 'c'>#language.booked#
                                <cfelseif Status eq 't'>#language.tentative#
                                </cfif></div></td>
                  <td headers="docking2">#myDateFormat(StartDate, "mmm d")#<cfif Year(StartDate) neq Year(EndDate)>#myDateFormat(StartDate, ", yyyy")#</cfif> - #myDateFormat(EndDate, request.datemask)#</td>
                  <td headers="booking2">#myDateFormat(BookingTime, request.datemask)#<!---@#LSTimeFormat(BookingTime, 'HH:mm')#---></td>
                </tr>
                </cfloop>
            </tbody>
					</table>
				<cfelse>
          <p>
            #language.noBookings#
          </p>
				</cfif>
				
				<h2>#language.southJetty#</h2>
        <cfif getSJBookings.RecordCount neq 0>
          <table class="basic mediumFont">
            <thead>
              <tr>
                <th id="section3" style="width: 20%;">#language.SECTIONCaps#</th>
                <th id="docking3" style="width: 40%;">#language.DOCKINGCaps#</th>
                <th id="booking3" style="width: 30%;">#language.BOOKINGDATECaps#</th>
              </tr>
            </thead>
						<cfloop query="getSJBookings">
						<tr <cfif Status eq 'c'>class="confirmed"</cfif>>
							<td headers="section3"><div style="text-align:center;"><cfif Status eq 'c'>#language.booked#
														<cfelseif Status eq 't'>#language.tentative#
														<cfelse>#language.pending#
														</cfif></div></td>
							<td headers="docking3">#myDateFormat(StartDate, request.datemask)# - #myDateFormat(EndDate, request.datemask)#</td>
							<td headers="booking3">#myDateFormat(BookingTime, request.datemask)#</td>
						</tr>
						</cfloop>
					</table>
				<cfelse>
          <p>
            #language.noBookings#
          </p>
				</cfif>
								
			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
</cfoutput>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
