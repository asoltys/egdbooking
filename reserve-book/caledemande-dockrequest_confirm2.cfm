<cfinclude template="#RootDir#includes/restore_params.cfm">
<cfinclude template="#RootDir#includes/errorMessages.cfm">
<cfif lang EQ "eng">
	<cfset language.newBooking = "Submit Drydock Booking Information">
	<cfset language.keywords = language.masterKeywords & ", Drydock Booking Information">
	<cfset language.description = "Allows user to submit a new booking request, drydock section.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.theVessel = "The vessel">
	<cfset language.tooLarge = "is too large for the dry dock">
	<cfset language.requestBooking = "Request Booking">
	<cfset language.bookingFound = "A booking has been found for">
	<cfset language.requestedStatus = "Requested Status">
	<cfset language.tplbookingError = "already has a booking for">
<cfelse>
	<cfset language.newBooking = "Pr&eacute;sentation des renseignements pour la r&eacute;servation de la cale s&egrave;che">
	<cfset language.keywords = language.masterKeywords & ", renseignements pour la r&eacute;servation de la cale s&egrave;che">
	<cfset language.description = "Permet &agrave; l'utilisateur de pr&eacute;senter une nouvelle demande de r&eacute;servation sur le site Web de la cale s&egrave;che d'Esquimalt - section de la cale s&egrave;che.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.theVessel = "Les dimensions du navire">
	<cfset language.tooLarge = "sont sup&eacute;rieures &agrave; celles de la cale s&egrave;che.">
	<cfset language.requestBooking = "Pr&eacute;senter la r&eacute;servation">
	<cfset language.bookingFound = "Une r&eacute;servation a &eacute;t&eacute; trouv&eacute;e pour ">
	<cfset language.requestedStatus = "&Eacute;tat demand&eacute;">
	<cfset language.tplbookingError = "a d&eacute;j&agrave; une r&eacute;servation pour :">
</cfif>

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""#language.NewBooking# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dcterms.subject"" content=""#language.subjects#"" />
	<title>#language.NewBooking# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfset request.title = language.NewBooking />
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfif IsDefined("Session.Return_Structure")>
	<cfoutput>#StructDelete(Session, "Return_Structure")#</cfoutput>
</cfif>

<cfset Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">
<cfif not isDate(form.startdate)>
  <cfset session['errors']['StartDateB'] = language.invalidStartError />
	<cfset Proceed_OK = "No">
<cfelseif not isDate(form.enddate)>
  <cfset session['errors']['EndDateB'] = language.invalidEndError />
	<cfset Proceed_OK = "No">
<cfelseif not isNumeric(form.numDays)>
  <cfset session['errors']['NumDays'] = language.needBookingDaysError />
	<cfset Proceed_OK = "No">
<cfelse>
  <cfif DateCompare(Form.StartDate,Form.EndDate) EQ 1>
      <cfset session['errors']['StartDateB'] = language.endBeforeStartError />
      <cfset session['errors']['EndDateB'] = language.endBeforeStartError />
    <cfset Proceed_OK = "No">
  </cfif>

  <cfif DateCompare(PacificNow, Form.StartDate, 'd') NEQ -1>
    <cfset session['errors']['StartDateB'] = language.futureStartError />
    <cfset Proceed_OK = "No">
  </cfif>

  <cfif DateDiff("d",Form.StartDate,Form.EndDate) LT Form.NumDays-1>
    <cfset session['errors']['NumDays'] = language.bookingTooShortErrorB />
    <cfset Proceed_OK = "No">
  </cfif>
</cfif>

<cfif not isNumeric(form.bookingByRange_VNID)>
  <cfset form.bookingByRange_VNID = 0 />
</cfif>

<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	VNID, Length, Width, Vessels.Name AS VesselName, Companies.Name AS CompanyName
	FROM 	Vessels, Companies
	WHERE 	VNID = <cfqueryparam value="#Form.bookingByRange_VNID#" cfsqltype="cf_sql_integer" />
	AND		Companies.CID = Vessels.CID
	AND 	Vessels.Deleted = 0
	AND		Companies.Deleted = 0
</cfquery>

<cfif getVessel.RecordCount EQ 0>
  <cfset session['errors']['bookingByRange_VNIDB'] = language.noVesselError />
	<cfset Proceed_OK = "No">
</cfif>

<cfif NOT IsDefined("Form.NumDays")>
  <cfset session['errors']['NumDays'] = language.needBookingDaysError />
	<cfset Proceed_OK = "No">
</cfif>

<cfif IsDefined("Form.NumDays") AND Form.NumDays LTE 0>
  <cfset session['errors']['NumDays'] = language.bookingTooShortError />
	<cfset Proceed_OK = "No">
</cfif>

<cfif getVessel.Width GT Variables.MaxWidth>
  <cfset session['errors']['width'] = "#language.theVessel#, #getVessel.VesselName#, #language.tooLarge#." />
	<cfset Proceed_OK = "No">
</cfif>

<cfif getVessel.Length GT Variables.MaxLength>
  <cfset session['errors']['length'] = "#language.theVessel#, #getVessel.VesselName#, #language.tooLarge#." />
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<!--- Save the form data in a session structure so it can be sent back to the form page --->
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Errors>
 	<cflocation url="#RootDir#reserve-book/caledemande-dockrequest.cfm?lang=#lang#" addtoken="no">
</cfif>

<cfinclude template="#RootDir#reserve-book/includes/towerCheck.cfm">
<cfset count = 0>
<cfset found = false>
<cfset finish = false>
<cfset Variables.StartDate = "">
<cfset Variables.EndDate = "">
<cfset Variables.FoundStartDate = "">
<cfset Variables.FoundEndDate = "">
<cfset Variables.VNID = Form.bookingByRange_VNID>  

<cfloop condition="finish EQ false AND found EQ false">

	<cfset Variables.StartDate = CreateODBCDate(DateAdd('d', count, Form.StartDate))>
	<cfset Variables.EndDate = CreateODBCDate(DateAdd('d', count + Form.NumDays - 1, Form.StartDate))>
	<cfset count = count + 1>

	<!---Check to see that vessel hasn't already been booked during this time--->
	<!--- 25 October 2005: This query now only looks at the drydock bookings --->
	<cfquery name="checkDblBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT 	Bookings.VNID, Vessels.Name, Bookings.StartDate, Bookings.EndDate
		FROM 	Bookings
					INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
					INNER JOIN Docks ON Bookings.BRID = Docks.BRID
		WHERE 	Bookings.VNID = <cfqueryparam value="#Variables.VNID#" cfsqltype="cf_sql_integer" />
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
	</cfquery>

	<!--- 25 October 2005: The next two queries have been modified to only get results from the drydock bookings --->
	<cfquery name="getNumStartDateBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Bookings.BRID, Vessels.Name, Bookings.StartDate
		FROM	Bookings
					INNER JOIN Docks ON Bookings.BRID = Docks.BRID
					INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
		WHERE	StartDate = <cfqueryparam value="#Variables.StartDate#" cfsqltype="cf_sql_date" />
					AND Bookings.VNID = <cfqueryparam value="#Variables.VNID#" cfsqltype="cf_sql_integer" />
					AND Bookings.Deleted = 0
	</cfquery>

	<cfquery name="getNumEndDateBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Bookings.BRID, Vessels.Name, Bookings.EndDate
		FROM	Bookings
					INNER JOIN Docks ON Bookings.BRID = Docks.BRID
					INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
		WHERE	EndDate = <cfqueryparam value="#Variables.EndDate#" cfsqltype="cf_sql_date" />
					AND Bookings.VNID = <cfqueryparam value="#Variables.VNID#" cfsqltype="cf_sql_integer" />
					AND Bookings.Deleted = 0
	</cfquery>

	<cfif checkDblBooking.RecordCount EQ 0 AND getNumStartDateBookings.recordCount LTE 1 AND getNumEndDateBookings.recordCount LTE 1>
		<cfif findSpace(-1, #Variables.StartDate#, #Variables.EndDate#, #getVessel.Length#, #getVessel.Width#)>
			<cfset Variables.FoundStartDate = Variables.StartDate>
			<cfset Variables.FoundEndDate = Variables.EndDate>
			<cfset found = true>
		</cfif>
	</cfif>

	<cfif DateCompare(Variables.EndDate, Form.EndDate, "d") EQ 0>
		<cfset finish = true>
	</cfif>
</cfloop>
<cfif NOT found>
	<cfoutput>#ArrayAppend(Errors, "There were no slots found for that time period.")#</cfoutput>
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Errors>

 	<cflocation url="#RootDir#reserve-book/caledemande-dockrequest.cfm?lang=#lang#" addtoken="no">
</cfif>

				<h1 id="wb-cont"><cfoutput>#language.NewBooking#</cfoutput></h1>

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">

				<cfoutput>
				<cfform action="#RootDir#reserve-book/caledemande-dockrequest_action2.cfm?lang=#lang#" method="post" id="bookingreq" preservedata="Yes">
					<p>#language.bookingFound# #myDateFormat(Variables.FoundStartDate, request.datemask)# - #myDateFormat(Variables.FoundEndDate, request.datemask)#.</p>

					<label for="VNID">#language.vessel#:</label>
					<input type="hidden" id="VNID"  name="VNID" value="#Form.bookingByRange_VNID#" />
					<p class="color-accent">#getVessel.VesselName#</p>

					<label for="startDate">#language.StartDate#:</label>
					<input type="hidden" id="startDate" name="startDate" value="#Variables.FoundStartDate#" />
					<p class="color-accent">#myDateFormat(CreateODBCDate(Variables.StartDate), request.datemask)#</p>

					<label for="EndDate">#language.EndDate#:</label>
					<input type="hidden" id="EndDate" name="EndDate" value="#Variables.FoundEndDate#" />
					<p class="color-accent">#myDateFormat(Variables.EndDate, request.datemask)#</p>

					<label for="Status">#language.requestedStatus#:</label>
					<input type="hidden" id="Status" name="Status" value="<cfoutput>#Form.Status#</cfoutput>">
					<p class="color-accent"><cfif form.status eq "tentative">#language.tentative#<cfelse>#language.confirmed#</cfif></p>

					<div class="buttons">
						<input type="submit" value="#language.requestBooking#" class="button button-accent"/>
					</div>

				</cfform>
				</cfoutput>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

