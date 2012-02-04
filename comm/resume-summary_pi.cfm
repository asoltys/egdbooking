<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<cfif lang eq "fra">
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr" xml:lang="fr">
<cfelse>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
</cfif>

<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,slash)>
<cfset PageDir = listDeleteAt(cgi.CF_TEMPLATE_PATH, listLen(cgi.CF_TEMPLATE_PATH,slash), slash)>
<cfdirectory action="LIST" directory="#PageDir#" name="GetFile" filter="#PageFileName#">
<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,slash)>

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
	<!-- CLF 2.0 TEMPLATE VERSION 1.04 | VERSION 1.04 DU GABARIT NSI 2.0 -->
	<!-- PWGSC TEMPLATE VERSION 1.0 | VERSION 1.0 DU GABARIT TPSGC -->
	<!-- HEADER BEGINS | DEBUT DE L'EN-TETE -->
	<!-- METADATA BEGINS | DEBUT DES METADONNEES -->
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<link rel="schema.dc" href="http://purl.org/dc/elements/1.1/" />
	<link rel="schema.dc" href="http://purl.org/dc/terms/" />
	
	<cfif lang eq "eng">
	<meta name="dc.language" scheme="ISO639-2/T" content="eng" />
	<meta name="dc.creator" content="Government of Canada, Public Works and Government Services Canada" />
	<meta name="dc.publisher" content="Government of Canada, Public Works and Government Services Canada" />
	<meta name="dc.rights" content="http://www.tpsgc-pwgsc.gc.ca/comm/ai-in-eng.html" />
	<meta name="pwgsc.contact.email" content="egd-cse@pwgsc-tpsgc.gc.ca" />
	<cfelse>
	<meta name="dc.language" scheme="ISO639-2/T" content="fra" />
	<meta name="dc.creator" content="Gouvernement du Canada, Travaux publics et Services gouvernementaux Canada" />
	<meta name="dc.publisher" content="Gouvernement du Canada, Travaux publics et Services gouvernementaux Canada" />
	<meta name="dc.rights" content="http://www.tpsgc-pwgsc.gc.ca/comm/ai-in-fra.html" />
	<meta name="pwgsc.contact.email" content="egd-cse@pwgsc-tpsgc.gc.ca" />
	</cfif>

	<meta name="dc.audience" content=" " />
	<meta name="dc.contributor" content=" " />
	<meta name="dc.coverage" content=" " />
	<meta name="dc.date.created" content="2008-06-13" />
	<meta name="dc.date.modified" content="2008-11-12" />
	<meta name="dc.format" content=" " />
	<meta name="dc.identifier" content=" " />
	<meta name="dc.type" content="" />
		
	<meta name="dc.title" content="#language.bookingsSummary# - #language.esqGravingDock# - #language.PWGSC#" />
	<meta name="keywords" content="#language.masterKeywords# #language.bookingsSummary#" />
	<meta name="description" content="#language.bookingsSummary#" />
	<meta name="dc.subject" scheme="gccore" content="#language.masterSubjects#" />

	<meta name="dcterms.issued" scheme="W3CDTF" content="2007-09-20" />
	<meta name="dcterms.modified" scheme="W3CDTF" content="#LSDateFormat(parseDateTime(GetFile.DateLastModified,"mm-dd-yyyy"), "yyyy-mm-dd")#" />
	
  <title>#language.BookingsSummary# - #language.esqGravingDock# - #language.PWGSC#</title>
  <link href="#RootDir#css/custom.css" media="print, screen" rel="stylesheet" type="text/css" />
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
SELECT	Bookings.VNID,
		Vessels.Name AS VesselName, Anonymous,
		Length AS VesselLength,
		Abbreviation, Companies.Name AS CompanyName,
		StartDate,
		EndDate,
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
	<CFIF IsDefined('Variables.fromDate') and Variables.fromDate neq ''>AND EndDate >= <cfqueryparam value="#Variables.fromDate#" cfsqltype="cf_sql_date" /></CFIF>
	<CFIF IsDefined('Variables.toDate') and Variables.toDate neq ''>AND StartDate <= <cfqueryparam value="#Variables.toDate#" cfsqltype="cf_sql_date" /></CFIF>
	
ORDER BY	StartDate, VesselName
</cfquery>

<cfquery name="getJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT	Bookings.VNID,
		Vessels.Name AS VesselName, Anonymous,
		Length AS VesselLength,
		Abbreviation, Companies.Name AS CompanyName,
		StartDate,
		EndDate,
		Status,
		NorthJetty, SouthJetty,
		BookingTime
FROM	Bookings
	INNER JOIN	Jetties ON Bookings.BRID = Jetties.BRID
	INNER JOIN	Vessels ON Bookings.VNID = Vessels.VNID
	INNER JOIN	Companies ON Vessels.CID = Companies.CID

WHERE	Bookings.Deleted = '0'
	AND	Vessels.Deleted = '0'
	<CFIF IsDefined('Variables.fromDate') and Variables.fromDate neq ''>AND EndDate >= <cfqueryparam value="#Variables.fromDate#" cfsqltype="cf_sql_date" /></CFIF>
	<CFIF IsDefined('Variables.toDate') and Variables.toDate neq ''>AND StartDate <= <cfqueryparam value="#Variables.toDate#" cfsqltype="cf_sql_date" /></CFIF>

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


<h1>#language.EsqGravingDock# #language.BookingsSummary#</h1>
<h2>#language.Drydock#</h2>

<div id="print_summary">
  <!--- Begin Dry Dock table --->
  <CFIF getDockBookings.RecordCount neq 0>
  <table>
    <thead>
      <tr>
        <th id="vessel">#language.VESSELCaps#</th>
        <th id="section">#language.SECTIONCaps#</th>
        <th id="docking">#language.DOCKINGCaps#</th>
        <th id="booking">#language.BOOKINGDATECaps#</th>
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
        <td headers="vessel"><abbr title="#CompanyName#">#Abbreviation#</abbr> #VesselLength#M 
          <CFIF Anonymous 
            AND (NOT IsDefined('Session.AdminLoggedIn') OR NOT Session.AdminLoggedIn) 
            AND Variables.count eq 0 
            AND Status neq 'c'>#language.deepsea#<CFELSE>#VesselName#</CFIF></td>
        <td headers="section"><div><CFIF Status eq 'c'>
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
      </cfloop>
  </table>
  <CFELSE>
  <p>#language.noBookings#</p>
  </CFIF>

  <h2>#language.NorthLandingWharf#</h2>

  <CFIF getNJBookings.RecordCount neq 0>
  <!-- Begin North Jetty table -->
  <table>
    <thead>
      <tr>
        <th id="vessel2">#language.VESSELCaps#</th>
        <th id="section2">#language.SECTIONCaps#</th>
        <th id="docking2">#language.DOCKINGCaps#</th>
        <th id="booking2">#language.BOOKINGDATECaps#</th>
      </tr>
    </thead>
      <cfloop query="getNJBookings">
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

      <tr <cfif getNJBookings.Status EQ 'c'>class="confirmed"</cfif>>
        <td headers="vessel2"><abbr title="#CompanyName#">#Abbreviation#</abbr> #VesselLength#M 
          <CFIF Anonymous 
            AND (NOT IsDefined('Session.AdminLoggedIn') OR NOT Session.AdminLoggedIn) 
            AND Variables.count eq 0 
            AND Status neq 'c'>#language.deepsea#<CFELSE>#VesselName#</CFIF></td>
        <td headers="section2"><div><CFIF Status eq 'c'>#language.Booked#
                      <CFELSEIF Status eq 't'>#language.tentative#
                      <CFELSE>#language.Pending#
                      </CFIF></div></td>
        <td headers="docking2">#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)></CFIF> - #LSDateFormat(EndDate, "mmm d, yyyy")#</td>
        <td headers="booking2">#LSDateFormat(BookingTime, 'mmm d, yyyy')#@#LSTimeFormat(BookingTime, 'HH:mm')#</td>
      </tr>
      </cfloop >
    </table>
  <CFELSE>
  <p>#language.noBookings#</p>
  </CFIF>

  <h2>#language.SouthJetty#</h2>
  <!-- Begin South Jetty table -->
  <CFIF getSJBookings.RecordCount neq 0>
    <table>
      <thead>
        <tr>
          <th id="vessel3">#language.VESSELCaps#</th>
          <th id="section3">#language.SECTIONCaps#</th>
          <th id="docking3">#language.DOCKINGCaps#</th>
          <th id="booking3">#language.BOOKINGDATECaps#</th>
        </tr>
      </thead>	
      <tbody>
        <cfloop query="getSJBookings">
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

          <tr <cfif getSJBookings.Status EQ 'c'>class="confirmed"</cfif>>
            <td headers="vessel3"><abbr title="#CompanyName#">#Abbreviation#</abbr> #VesselLength#M 
              <CFIF Anonymous 
                AND (NOT IsDefined('Session.AdminLoggedIn') OR NOT Session.AdminLoggedIn) 
                AND Variables.count eq 0 
                AND Status neq 'c'>#language.deepsea#<CFELSE>#VesselName#</CFIF></td>
            <td headers="section3"><div><CFIF Status eq 'c'>#language.Booked#
                          <CFELSEIF Status eq 't'>#language.tentative#
                          <CFELSE>#language.Pending#
                          </CFIF></div></td>
            <td headers="docking3">#LSDateFormat(StartDate, "mmm d")#<CFIF Year(StartDate) neq Year(EndDate)></CFIF> - #LSDateFormat(EndDate, "mmm d, yyyy")#</td>
            <td headers="booking3">#LSDateFormat(BookingTime, 'mmm d, yyyy')#@#LSTimeFormat(BookingTime, 'HH:mm')#</td>
          </tr>
        </cfloop>
      </tbody>
    </table>
  <CFELSE>
    <p>#language.noBookings#</p>
  </CFIF>
</div>

</body>
</html>
</cfoutput>
