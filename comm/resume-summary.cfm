<cfoutput>

<cfif isDefined("form.todate")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfif lang EQ "eng">
	<cfset language.bookingsSummary = "Bookings Summary">
	<cfset language.description = "Allows user to view a summary of all bookings from present onward.">
	<cfset language.vesselCaps = "VESSEL">
	<cfset language.dockingCaps = "DOCKING DATES">
	<cfset language.bookingDateCaps = "BOOKING DATE">
	<cfset language.sectionCaps = "SECTION">
	<cfset language.deepsea = "Deepsea Vessel">
	<cfset language.noBookings = "There are no bookings to view.">
	<cfset language.booked = "Booked">
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
</cfif>


<cfsavecontent variable="head">
	<meta name="dc.title" content="#language.BookingsSummary# - #language.esqGravingDock# - #language.PWGSC#" />
	<meta name="keywords" content="#Language.masterKeywords#" />
	<meta name="description" content="#language.description#" />
	<meta name="dc.subject" scheme="gccore" content="#Language.masterSubjects#" />
	<title>#language.BookingsSummary# - #language.esqGravingDock# - #language.PWGSC#</title>
  <style>
   
  </style>
</cfsavecontent>
<cfhtmlhead text="#head#" />
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

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

<cfparam name="CalStartDate" default="">
<cfparam name="CalEndDate" default="">

<cfquery name="getDockBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT	Bookings.EndHighlight,
		Bookings.VNID,
		Vessels.Name AS VesselName, Anonymous,
		Length AS VesselLength,
		Abbreviation, Companies.Name AS CompanyName, Companies.CID,
		StartDate, EndDate,
		Status,
		Section1, Section2, Section3,
		BookingTime
FROM	Bookings
	INNER JOIN	Docks ON Bookings.BRID = Docks.BRID
	INNER JOIN	Vessels ON Bookings.VNID = Vessels.VNID
	INNER JOIN	Companies ON Vessels.CID = Companies.CID
WHERE	<!--- (Status = 'c' OR Status = 't')
	AND --->	Bookings.Deleted = '0'
	AND	Vessels.Deleted = '0'
	<cfif IsDefined('CalStartDate') and CalStartDate neq ''>AND EndDate >= <cfqueryparam value="#CalStartDate#" cfsqltype="cf_sql_date" /></CFIF>
	<cfif IsDefined('CalEndDate') and CalEndDate neq ''>AND StartDate <= <cfqueryparam value="#CalEndDate#" cfsqltype="cf_sql_date" /></CFIF>

ORDER BY	StartDate, VesselName
</cfquery>

<cfquery name="getJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT	Bookings.EndHighlight,
		Bookings.VNID,
		Vessels.Name AS VesselName, Anonymous,
		Length AS VesselLength,
		Abbreviation, Companies.Name AS CompanyName, Companies.CID,
		StartDate, EndDate,
		Status,
		NorthJetty, SouthJetty,
		BookingTime
FROM	Bookings
	INNER JOIN	Jetties ON Bookings.BRID = Jetties.BRID
		INNER JOIN	Vessels ON Bookings.VNID = Vessels.VNID
		INNER JOIN	Companies ON Vessels.CID = Companies.CID

WHERE	Bookings.Deleted = '0'
	AND	Vessels.Deleted = '0'
	<cfif IsDefined('CalStartDate') and CalStartDate neq ''>AND EndDate >= <cfqueryparam value="#CalStartDate#" cfsqltype="cf_sql_date" /></CFIF>
	<cfif IsDefined('CalEndDate') and CalEndDate neq ''>AND StartDate <= <cfqueryparam value="#CalEndDate#" cfsqltype="cf_sql_date" /></CFIF>

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

  <!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
  <p class="breadcrumb">
    <cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
    <cfif IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
    <a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
    </cfif>
    #language.BookingsSummary#
  </p>
  <!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
  <div class="colLayout">
  <cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
    <!-- CONTENT BEGINS | DEBUT DU CONTENU -->
    <div class="center">
      <h1><a name="cont" id="cont">
        <!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
        #language.BookingsSummary#
        <!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
        </a></h1>

      <cfif IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
        <cfinclude template="#RootDir#includes/admin_menu.cfm">
      <cfelse>
        <cfinclude template="#RootDir#includes/user_menu.cfm">
      </cfif>

      <h2>#language.Drydock#</h2>

      <cfif getDockBookings.RecordCount neq 0>
        <table class="basic mediumFont" summary="#language.DrydockTableSummary#">
          <thead>
            <tr>
              <th id="vessel" class="vessel">#language.VESSELCaps#</th>
              <th id="section" class="section">#language.SECTIONCaps#</th>
              <th id="docking" class="docking">#language.DOCKINGCaps#</th>
              <th id="booking" class="booking">#language.BOOKINGDATECaps#</th>
            </tr>
          </thead>
          <cfloop query="getDockBookings">
            <!---check if ship belongs to user's company--->
            <cflock timeout="20" throwontimeout="no" type="READONLY" scope="SESSION">
              <cfquery name="userVessel#VNID#" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
                SELECT	Vessels.VNID
                FROM	Users INNER JOIN UserCompanies ON Users.UID = UserCompanies.UID
                    INNER JOIN Vessels ON UserCompanies.CID = Vessels.CID
                WHERE	Users.UID = <cfqueryparam value="#Session.UID#" cfsqltype="cf_sql_integer" /> AND VNID = <cfqueryparam value="#VNID#" cfsqltype="cf_sql_integer" />
                  AND UserCompanies.Approved = 1 AND Users.Deleted = 0 AND UserCompanies.Deleted = 0
              </cfquery>
            </cflock>

            <cfset blah = Evaluate("userVessel" & #VNID#)>

            <cfset Variables.countQName = "userVessel" & #VNID# & ".recordCount">
            <cfset Variables.count = EVALUATE(countQName)>

          <tr <cfif getDockBookings.Status EQ 'c'>class="confirmed"</cfif>>
            <td headers="vessel"><cfif #EndHighlight# GTE PacificNow>* </cfif><abbr title="#CompanyName#">#Abbreviation#</abbr> #VesselLength#M
              <cfif Anonymous
                AND (NOT IsDefined('Session.AdminLoggedIn') OR NOT Session.AdminLoggedIn)
                AND Variables.count eq 0
                AND Status neq 'c'>#language.deepsea#<CFELSE>#VesselName#</CFIF></td>
            <td headers="section">
              <cfif Status eq 'c'>
                <cfif Section1 eq true>1</cfif>
                <cfif Section2 eq true><cfif Section1> &amp; </cfif>2</cfif>
                <cfif Section3 eq true><cfif Section1 OR Section2> &amp; </cfif>3
              </cfif>
              <cfelse>
                <cfif Status eq 't'>#language.Tentative#
                <cfelse> #language.Pending#
                </cfif>
              </cfif></td>
            <td headers="docking">#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</CFIF> - #LSDateFormat(EndDate, "mmm d, yyyy")#</td>
            <td headers="booking">#LSDateFormat(BookingTime, 'mmm d, yyyy')#@#LSTimeFormat(BookingTime, 'HH:mm')#</td>
          </tr>
          </cfloop>
        </table>
      <cfelse>
        <p>
          #language.noBookings#
        </p>
      </cfif>

      <h2>#language.NorthLandingWharf#</h2>

        <cfif getNJBookings.RecordCount neq 0>
        <table class="basic mediumFont" summary="#language.NLWTableSummary#">
          <thead>
            <tr>
              <th id="vessel2" class="vessel">#language.VESSELCaps#</th>
              <th id="section2" class="section">#language.SECTIONCaps#</th>
              <th id="docking2" class="docking">#language.DOCKINGCaps#</th>
              <th id="booking2">#language.BOOKINGDATECaps#</th>
            </tr>
          </thead>
          <tbody>
            <cfloop query="getNJBookings">
              <!---check if ship belongs to user's company--->
              <cflock timeout="20" throwontimeout="no" type="READONLY" scope="SESSION">
                <cfquery name="userVessel#VNID#" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
                  SELECT	Vessels.VNID
                  FROM	Users INNER JOIN UserCompanies ON Users.UID = UserCompanies.UID
                      INNER JOIN Vessels ON UserCompanies.CID = Vessels.CID
                  WHERE	Users.UID = <cfqueryparam value="#Session.UID#" cfsqltype="cf_sql_integer" /> AND VNID = <cfqueryparam value="#VNID#" cfsqltype="cf_sql_integer" />										AND UserCompanies.Approved = 1 AND Users.Deleted = 0 AND UserCompanies.Deleted = 0
                </cfquery>
              </cflock>

              <cfset blah = Evaluate("userVessel" & #VNID#)>

              <cfset Variables.countQName = "userVessel" & #VNID# & ".recordCount">
              <cfset Variables.count = EVALUATE(countQName)>

            <tr <cfif getNJBookings.Status EQ 'c'>class="confirmed"</cfif>>
              <td headers="vessel2"><cfif #EndHighlight# GTE PacificNow>* </cfif><abbr title="#CompanyName#">#Abbreviation#</abbr> #VesselLength#M
                <cfif Anonymous
                  AND (NOT IsDefined('Session.AdminLoggedIn') OR NOT Session.AdminLoggedIn)
                  AND Variables.count eq 0
                  AND Status neq 'c'>#language.deepsea#<cfelse>#VesselName#</cfif></td>
              <td headers="section2"><CFIF Status eq 'c'>#language.Booked#
                            <cfelseif Status eq 't'>#language.Tentative#
                            <cfelse>#language.Pending#
                            </cfif></td>
              <td headers="docking2">#LSDateFormat(StartDate, "mmm d")#<cfif Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</cfif> - #LSDateFormat(EndDate, "mmm d, yyyy")#</td>
              <td headers="booking2">#LSDateFormat(BookingTime, 'mmm d, yyyy')#@#LSTimeFormat(BookingTime, 'HH:mm')#</td>
            </tr>
            </cfloop>
          </tbody>
        </table>
      <cfelse>
        <p>
          #language.noBookings#
        </p>
      </cfif>

      <h2>#language.SouthJetty#</h2>
      <cfif getSJBookings.RecordCount neq 0>
        <table class="basic mediumFont" summary="#language.SJTableSummary#">
          <thead>
            <tr>
              <th id="vessel3" class="vessel">#language.VESSELCaps#</th>
              <th id="section3" class="section">#language.SECTIONCaps#</th>
              <th id="docking3" class="docking">#language.DOCKINGCaps#</th>
              <th id="booking3" class="booking">#language.BOOKINGDATECaps#</th>
            </tr>
          </thead>
          <tbody>
            <cfloop query="getSJBookings">
              <cflock timeout="20" throwontimeout="no" type="READONLY" scope="SESSION">
                <cfquery name="userVessel#VNID#" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
                  SELECT	Vessels.VNID
                  FROM	Users INNER JOIN UserCompanies ON Users.UID = UserCompanies.UID
                      INNER JOIN Vessels ON UserCompanies.CID = Vessels.CID
                  WHERE	Users.UID = <cfqueryparam value="#Session.UID#" cfsqltype="cf_sql_integer" /> AND VNID = <cfqueryparam value="#VNID#" cfsqltype="cf_sql_integer" />
                    AND UserCompanies.Approved = 1 AND Users.Deleted = 0 AND UserCompanies.Deleted = 0
                </cfquery>
              </cflock>

              <cfset blah = Evaluate("userVessel" & #VNID#)>

              <cfset Variables.countQName = "userVessel" & #VNID# & ".recordCount">
              <cfset Variables.count = EVALUATE(countQName)>

            <tr <cfif getSJBookings.Status EQ 'c'>class="confirmed"</cfif>>
              <td headers="vessel3"><cfif #EndHighlight# GTE PacificNow>* </cfif><abbr title="#CompanyName#">#Abbreviation#</abbr> #VesselLength#M
                <cfif Anonymous
                  AND (NOT IsDefined('Session.AdminLoggedIn') OR NOT Session.AdminLoggedIn)
                  AND Variables.count eq 0
                  AND Status neq 'c'>#language.deepsea#<cfelse>#VesselName#</cfif></td>
              <td headers="section3"><CFIF Status eq 'c'>#language.Booked#
                            <cfelseif Status eq 't'>#language.tentative#
                            <cfelse>#language.Pending#
                            </cfif></td>
              <td headers="docking3">#LSDateFormat(StartDate, "mmm d")#<cfif Year(StartDate) neq Year(EndDate)>#LSDateFormat(StartDate, ", yyyy")#</cfif> - #LSDateFormat(EndDate, "mmm d, yyyy")#</td>
              <td headers="booking3">#LSDateFormat(BookingTime, 'mmm d, yyyy')#@#LSTimeFormat(BookingTime, 'HH:mm')#</td>
            </tr>
            </cfloop>
          </tbody>
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
