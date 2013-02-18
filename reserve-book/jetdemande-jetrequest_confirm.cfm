<cfif not StructKeyExists(Form, 'StartDate')>
  <cflocation url="#RootDir#reserve-book/jetdemande-jetrequest.cfm?lang=#lang#" addtoken="no" />
</cfif>

<cfinclude template="#RootDir#includes/build_form_struct.cfm">
<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/errorMessages.cfm">
<cfif lang EQ "eng">
	<cfset language.submitJettyBooking = "Submit Jetty Booking Information">
	<cfset language.keywords = language.masterKeywords & ", Jetty Booking Information">
	<cfset language.description = "Allows user to submit a new booking request, jetties section.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.newBooking = "Submit New Booking Information">
	<cfset language.dblBookingError = "has already been booked from">
	<cfset language.requestedJetty = "Requested Jetty">
	<cfset language.to = "to">
	<cfset language.bookingAvailable = "Please confirm the following information:">
	<cfset language.northJetty = "North Landing Wharf">
	<cfset language.southJetty = "South Jetty">
	<cfset language.tplbookingError = "already has a booking for">
	<cfset language.requestedStatus = "Requested Status">
<cfelse>
	<cfset language.submitJettyBooking = "Pr&eacute;sentation des renseignements pour la r&eacute;servation de jet&eacute;e">
	<cfset language.keywords = language.masterKeywords & ", renseignements pour la r&eacute;servation de jet&eacute;e">
	<cfset language.description = "Permet &agrave; l'utilisateur de soumettre une nouvelle demande de r&eacute;servation - section de jet&eacute;e">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.newBooking = "Pr&eacute;sentation de nouveaux renseignements pour la r&eacute;servation">
	<cfset language.dblBookingError = "fait d&eacute;j&agrave; l'objet d'une r&eacute;servation du">
	<cfset language.requestedJetty = "Jet&eacute;e demand&eacute;e">
	<cfset language.to = "au">
	<cfset language.bookingAvailable = "Veuillez confirmer l'information suivante&nbsp;.">
	<cfset language.northJetty = "Quai de d&eacute;barquement nord">
	<cfset language.southJetty = "Jet&eacute;e sud">
	<cfset language.tplbookingError = "a d&eacute;j&agrave; une r&eacute;servation pour le">
	<cfset language.requestedStatus = "&Eacute;tat demand&eacute;">
</cfif>


<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""#language.NewBooking# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dcterms.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.NewBooking# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">



<cfif IsDefined("Session.Return_Structure")>
	<cfoutput>#StructDelete(Session, "Return_Structure")#</cfoutput>
</cfif>

<cfset Errors = ArrayNew(1)>
<cfset Success = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif not isNumeric(Form.VNID)>
  <cfset session['errors']['VNID'] = language.noVesselError />
	<cfset Proceed_OK = "No">
<cfelse>
  <cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
    SELECT 	VNID, Length, Width, Vessels.Name AS VesselName, Companies.Name AS CompanyName
    FROM 	Vessels, Companies
    WHERE 	VNID = <cfqueryparam value="#Form.VNID#" cfsqltype="cf_sql_integer" />
    AND		Companies.CID = Vessels.CID
    AND 	Vessels.Deleted = 0
    AND		Companies.Deleted = 0
  </cfquery>

  <cfif getVessel.RecordCount EQ 0>
    <cfset session['errors']['VNID'] = language.noVesselError />
    <cfset Proceed_OK = "No" />
  </cfif>
  
  <cfif not isDate(Form.StartDate)>
    <cfset session['errors']['StartDate'] = language.invalidStartError />
    <cfset Proceed_OK = "No" />
  </cfif>

  <cfif not isDate(Form.EndDate)>
    <cfset session['errors']['EndDate'] = language.invalidEndError />
    <cfset Proceed_OK = "No" />
  </cfif>

  <cfif Proceed_OK>
    <cfset Variables.StartDate = CreateODBCDate(Form.StartDate)>
    <cfset Variables.EndDate = CreateODBCDate(Form.EndDate)>
    <cfset Variables.VNID = Form.VNID>

    <cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
      SELECT 	VNID, Length, Width, Vessels.Name AS VesselName, Companies.Name AS CompanyName
      FROM 	Vessels, Companies
      WHERE 	VNID = <cfqueryparam value="#Form.VNID#" cfsqltype="cf_sql_integer" />
      AND		Companies.CID = Vessels.CID
      AND 	Vessels.Deleted = 0
      AND		Companies.Deleted = 0
    </cfquery>

    <cfif getVessel.RecordCount EQ 0>
      <cfset session['errors']['VNID'] = language.noVesselError />
      <cfset Proceed_OK = "No">
    </cfif>

    <!---Check to see that vessel hasn't already been booked during this time--->
    <!--- 25 October 2005: This query now only looks at the jetties bookings --->
    <cfquery name="checkDblBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
      SELECT 	Bookings.VNID, Bookings.BRID, Name, Bookings.StartDate, Bookings.EndDate
      FROM 	Bookings
            INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
            INNER JOIN Jetties ON Bookings.BRID = Jetties.BRID
      WHERE 	Bookings.VNID = <cfqueryparam value="#Form.VNID#" cfsqltype="cf_sql_integer" />
      AND
      <!---Explanation of hellishly long condition statement: The client wants to be able to overlap the start and end dates
        of bookings, so if a booking ends on May 6, another one can start on May 6.  This created problems with single day
        bookings, so if you are changing this query...watch out for them.  The first 3 lines check for any bookings longer than
        a day that overlaps with the new booking if it is more than a day.  The next 4 lines check for single day bookings that
        fall within a booking that is more than one day.--->
          (
            (	Bookings.StartDate <= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> < Bookings.EndDate AND <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> <> <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND Bookings.StartDate <> Bookings.EndDate)
          OR 	(	Bookings.StartDate < <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate AND <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> <> <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND Bookings.StartDate <> Bookings.EndDate)
          OR	(	Bookings.StartDate >= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> >= Bookings.EndDate AND <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> <> <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND Bookings.StartDate <> Bookings.EndDate)
          OR  (	(Bookings.StartDate = Bookings.EndDate OR <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> = <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" />) AND Bookings.StartDate <> <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND Bookings.EndDate <> <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND
                ((	Bookings.StartDate <= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> < Bookings.EndDate)
              OR 	(	Bookings.StartDate < <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> <= Bookings.EndDate)
              OR	(	Bookings.StartDate >= <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" /> AND <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" /> >= Bookings.EndDate)))
          )
      AND		Bookings.Deleted = 0
      <cfif IsDefined("Form.Jetty") AND form.Jetty EQ "north">
        AND Jetties.NorthJetty = 1
      <cfelse>
        AND Jetties.SouthJetty = 1
      </cfif>
    </cfquery>

    <!--- 25 October 2005: The next two queries have been modified to only get results from the jetties bookings --->
    <cfquery name="getNumStartDateBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
      SELECT	Bookings.BRID, Vessels.Name, Bookings.StartDate
      FROM	Bookings
            INNER JOIN Jetties ON Bookings.BRID = Jetties.BRID
            INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
      WHERE	StartDate = <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" />
            AND Bookings.VNID = <cfqueryparam value="#Form.VNID#" cfsqltype="cf_sql_integer" />
            AND Bookings.Deleted = 0
          <cfif IsDefined("Form.Jetty") AND form.Jetty EQ "north">
            AND Jetties.NorthJetty = 1
          <cfelse>
            AND Jetties.SouthJetty = 1
          </cfif>
    </cfquery>

    <cfquery name="getNumEndDateBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
      SELECT	Bookings.BRID, Vessels.Name, Bookings.EndDate
      FROM	Bookings
            INNER JOIN Jetties ON Bookings.BRID = Jetties.BRID
            INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
      WHERE	EndDate = <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" />
              AND Bookings.VNID = <cfqueryparam value="#Form.VNID#" cfsqltype="cf_sql_integer" />
              AND Bookings.Deleted = 0
            <cfif IsDefined("Form.Jetty") AND form.Jetty EQ "north">
              AND Jetties.NorthJetty = 1
            <cfelse>
              AND Jetties.SouthJetty = 1
            </cfif>
    </cfquery>

    <!--- Validate the form data --->
    <cfif DateCompare(DateAdd('d', 1, PacificNow), Form.StartDate, 'd') EQ 1>
      <cfset session['errors']['StartDate'] = language.futureStartError />
      <cfset Proceed_OK = "No">

    <cfelseif isDefined("checkDblBooking.VNID") AND checkDblBooking.VNID NEQ "">
      <cfset session['errors']['StartDate'] = "#checkDblBooking.Name# #language.dblBookingError# #myDateFormat(checkDblBooking.StartDate, 'mm/dd/yyy')# #language.to# #myDateFormat(checkDblBooking.EndDate, 'mm/dd/yyy')#." />
      <cfset session['errors']['EndDate'] = "#checkDblBooking.Name# #language.dblBookingError# #myDateFormat(checkDblBooking.StartDate, 'mm/dd/yyy')# #language.to# #myDateFormat(checkDblBooking.EndDate, 'mm/dd/yyy')#." />
      <cfset Proceed_OK = "No">
    <cfelseif getNumStartDateBookings.recordCount GTE 1>
      <cfset session['errors']['StartDate'] = "#getNumStartDateBookings.Name# #language.tplBookingError# #myDateFormat(getNumStartDateBookings.StartDate, 'mm/dd/yyy')#." />
      <cfset Proceed_OK = "No">
    <cfelseif getNumEndDateBookings.recordCount GTE 1>
      <cfset session['errors']['EndDate'] = "#getNumEndDateBookings.Name# #language.tplBookingError# #myDateFormat(getNumEndDateBookings.EndDate, 'mm/dd/yyy')#." />
      <cfset Proceed_OK = "No">
    </cfif>

    <cfif Form.StartDate GT Form.EndDate>
      <cfset session['errors']['StartDate'] = language.endBeforeStartError />
      <cfset session['errors']['EndDate'] = language.endBeforeStartError />
      <cfset Proceed_OK = "No">
    <cfelseif DateDiff("d",Form.StartDate,Form.EndDate) LT 0>
      <cfset session['errors']['StartDate'] = language.bookingTooShortError />
      <cfset session['errors']['EndDate'] = language.bookingTooShortError />
      <cfset Proceed_OK = "No">
    </cfif>
  </cfif>
</cfif>

 <!--- Save the form data in a session structure so it can be sent back to the form page --->
<cfif Proceed_OK EQ "No">
	<cfset Session.Return_Structure.Jetty = Form.Jetty>
	<cfset Session.Return_Structure.StartDate = Form.StartDate>
	<cfset Session.Return_Structure.EndDate = Form.EndDate>
	<cfset Session.Return_Structure.VNID = Form.VNID>
	<cfset Session.Return_Structure.Errors = Errors>
 	<cflocation url="#RootDir#reserve-book/jetdemande-jetrequest.cfm?lang=#lang#">
</cfif>

<cfquery name="getInfo" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Companies.Name AS CompanyName, Companies.CID, Vessels.Name AS VesselName, Vessels.VNID
	FROM 	Vessels, Companies
	WHERE 	VNID = <cfqueryparam value="#Form.VNID#" cfsqltype="cf_sql_integer" />
	AND		Companies.CID = Vessels.CID
	AND 	Companies.Deleted = 0
	AND		Vessels.Deleted = 0
</cfquery>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<a href="#RootDir#reserve-book/resdemande-bookrequest.cfm?lang=#lang#">#language.bookingRequest#</a> &gt;
			#language.submitJettyBooking#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.submitJettyBooking#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<cfoutput>

				<p>#language.bookingAvailable#</p>

				<cfform action="#RootDir#reserve-book/jetdemande-jetrequest_action.cfm?lang=#lang#" method="post" id="bookingreq" preservedata="Yes">
					<fieldset>
            <legend>#language.booking#</legend>

						<label for="CID">#language.Company#:</label>
						<input type="hidden" id="CID" name="CID" value="#getInfo.CID#" />
						<p>#getInfo.CompanyName#</p>


						<label for="VNID">#language.vessel#:</label>
						<input type="hidden" id="VNID" name="VNID" value="#getInfo.VNID#" />
						<p>#getInfo.VesselName#</p>


						<label for="startDate">#language.StartDate#:</label>
						<input type="hidden" id="startDate" name="startDate" value="#CreateODBCDate(startDate)#" />
						<p>#myDateFormat(CreateODBCDate(startDate), request.datemask)#</p>


						<label for="endDate">#language.EndDate#:</label>
						<input type="hidden" id="endDate" name="endDate" value="#CreateODBCDate(endDate)#" />
						<p>#myDateFormat(CreateODBCDate(endDate), request.datemask)#</p>


						<label for="Status">#language.requestedStatus#:</label>
						<input type="hidden" id="Status" name="Status" value="#Form.Status#" />
						<p><cfif form.status eq "tentative">#language.tentative#<cfelse>#language.confirmed#</cfif></p>


						<label for="jetty">#language.RequestedJetty#:</label>
						<input id="jettySelect" id="jetty" type="hidden" name="jetty" value="#Form.Jetty#" />
						<p>
							<cfif Form.Jetty EQ "north">
								#language.northJetty#
							<cfelse>
								#language.southJetty#
							</cfif>
						</p>
					</fieldset>

					<div class="buttons">
						<input type="submit" value="#language.confirm#" class="textbutton" />
					</div>

				</cfform>
				</cfoutput>

			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

