<cfif isDefined("form.numDays")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfinclude template="#RootDir#includes/bookingInfoVariables.cfm">
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
	<meta name=""dc.title"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.NewBooking#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.NewBooking#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<!--- Query to get Vessel Information --->
<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	VNID, Length, Width, Vessels.Name AS VesselName, Companies.Name AS CompanyName
	FROM 	Vessels, Companies
	WHERE 	VNID = '#Form.bookingByRange_VNID#'
	AND		Companies.CID = Vessels.CID
	AND 	Vessels.Deleted = 0
	AND		Companies.Deleted = 0
</cfquery>

<!--- Error Checks -------------------------------------------------------------------------------->
<cfif IsDefined("Session.Return_Structure")>
	<cfoutput>#StructDelete(Session, "Return_Structure")#</cfoutput>
</cfif>

<cfset Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">
<cfif DateCompare(Form.StartDate,Form.EndDate) EQ 1>
	<cfoutput>#ArrayAppend(Errors, "#language.endBeforeStartError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif DateCompare(PacificNow, Form.StartDate, 'd') NEQ -1>
	<cfoutput>#ArrayAppend(Errors, "#language.futureStartError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif DateDiff("d",Form.StartDate,Form.EndDate) LT Form.NumDays-1>
	<cfoutput>#ArrayAppend(Errors, "#language.bookingTooShortErrorB#")#</cfoutput>
		<cfoutput>#ArrayAppend(Errors, "#language.StartDate#: #LSDateFormat(CreateODBCDate(Form.StartDate), 'mmm d, yyyy')#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif getVessel.RecordCount EQ 0>
	<cfoutput>#ArrayAppend(Errors, "#language.noVesselError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif NOT IsDefined("Form.NumDays")>
	<cfoutput>#ArrayAppend(Errors, "#language.needBookingDaysError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif IsDefined("Form.NumDays") AND Form.NumDays LTE 0>
	<cfoutput>#ArrayAppend(Errors, "#language.bookingTooShortError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif getVessel.Width GT Variables.MaxWidth OR getVessel.Length GT Variables.MaxLength>
	<cfoutput>#ArrayAppend(Errors, "#language.theVessel#, #getVessel.VesselName#, #language.tooLarge#.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<!--- Save the form data in a session structure so it can be sent back to the form page --->
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Errors>
 	<cflocation url="#RootDir#reserve-book/caledemande-dockrequest.cfm?lang=#lang#" addtoken="no">
</cfif>
<!------------------------------------------------------------------------------------------------->
<cfinclude template="#RootDir#reserve-book/includes/towerCheck.cfm">
<cfset count = 0>
<cfset found = false>
<cfset finish = false>
<cfset Variables.StartDate = "">
<cfset Variables.EndDate = "">
<cfset Variables.FoundStartDate = "">
<cfset Variables.FoundEndDate = "">
<cfset Variables.VNID = Form.bookingByRange_VNID>  <!--- Added 25/01/2006 DS to fix CF error in bookings --->

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
		WHERE 	Bookings.VNID = '#Variables.VNID#'
		AND
		<!---Explanation of hellishly long condition statement: The client wants to be able to overlap the start and end dates
			of bookings, so if a booking ends on May 6, another one can start on May 6.  This created problems with single day
			bookings, so if you are changing this query...watch out for them.  The first 3 lines check for any bookings longer than
			a day that overlaps with the new booking if it is more than a day.  The next 4 lines check for single day bookings that
			fall within a booking that is more than one day.--->
				(
					(	Bookings.StartDate <= #Variables.StartDate# AND #Variables.StartDate# < Bookings.EndDate AND #Variables.StartDate# <> #Variables.EndDate# AND Bookings.StartDate <> Bookings.EndDate)
				OR 	(	Bookings.StartDate < #Variables.EndDate# AND #Variables.EndDate# <= Bookings.EndDate AND #Variables.StartDate# <> #Variables.EndDate# AND Bookings.StartDate <> Bookings.EndDate)
				OR	(	Bookings.StartDate >= #Variables.StartDate# AND #Variables.EndDate# >= Bookings.EndDate AND #Variables.StartDate# <> #Variables.EndDate# AND Bookings.StartDate <> Bookings.EndDate)
				OR  (	(Bookings.StartDate = Bookings.EndDate OR #Variables.StartDate# = #Variables.EndDate#) AND Bookings.StartDate <> #Variables.StartDate# AND Bookings.EndDate <> #Variables.EndDate# AND
							((	Bookings.StartDate <= #Variables.StartDate# AND #Variables.StartDate# < Bookings.EndDate)
						OR 	(	Bookings.StartDate < #Variables.EndDate# AND #Variables.EndDate# <= Bookings.EndDate)
						OR	(	Bookings.StartDate >= #Variables.StartDate# AND #Variables.EndDate# >= Bookings.EndDate)))
				)
	AND		Bookings.Deleted = 0
	</cfquery>

	<!--- 25 October 2005: The next two queries have been modified to only get results from the drydock bookings --->
	<cfquery name="getNumStartDateBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Bookings.BRID, Vessels.Name, Bookings.StartDate
		FROM	Bookings
					INNER JOIN Docks ON Bookings.BRID = Docks.BRID
					INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
		WHERE	StartDate = #Variables.StartDate#
					AND Bookings.VNID = '#Variables.VNID#'
					AND Bookings.Deleted = 0
	</cfquery>

	<cfquery name="getNumEndDateBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Bookings.BRID, Vessels.Name, Bookings.EndDate
		FROM	Bookings
					INNER JOIN Docks ON Bookings.BRID = Docks.BRID
					INNER JOIN Vessels ON Bookings.VNID = Vessels.VNID
		WHERE	EndDate = #Variables.EndDate#
					AND Bookings.VNID = '#Variables.VNID#'
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

<!--- Gets all Bookings that would be affected by the requested booking --->

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<a href="#RootDir#reserve-book/resdemande-bookrequest.cfm?lang=#lang#">#language.bookingRequest#</a> &gt;
			#language.NewBooking#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.NewBooking#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">

				<cfoutput>
				<cfform action="#RootDir#reserve-book/caledemande-dockrequest_action2.cfm?lang=#lang#" method="post" id="bookingreq" preservedata="Yes">
					<p>#language.bookingFound# #LSDateFormat(Variables.FoundStartDate, 'mmm d, yyyy')# - #LSDateFormat(Variables.FoundEndDate, 'mmm d, yyyy')#.</p>
					<label>#language.Agent#:</label>
					<p>
						<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
							#session.lastName#, #session.firstName#
						</cflock>
					</p>

					<label>#language.vessel#:</label>
					<input type="hidden" name="VNID" value="#Form.bookingByRange_VNID#" />
					<p>#getVessel.VesselName#</p>

					<label>#language.Company#:</label>
					<p>#getVessel.CompanyName#</p>

					<label>#language.StartDate#:</label>
					<input type="hidden" name="startDate" value="#Variables.FoundStartDate#" />
					<p>#LSDateFormat(CreateODBCDate(Variables.StartDate), 'mmm d, yyyy')#</p>

					<label>#language.EndDate#:</label>
					<input type="hidden" name="EndDate" value="#Variables.FoundEndDate#" />
					<p>#LSDateFormat(Variables.EndDate, 'mmm d, yyyy')#</p>

					<label>#language.requestedStatus#:</label>
					<input type="hidden" name="Status" value="<cfoutput>#Form.Status#</cfoutput>">
					<p><cfif form.status eq "tentative">#language.tentative#<cfelse>#language.confirmed#</cfif></p>

					<div class="buttons">
						<input type="submit" value="#language.requestBooking#" class="textbutton" />
						<input type="button" value="#language.Back#" class="textbutton" onclick="history.go(-1);" />
						<input type="button" value="#language.Cancel#" class="textbutton" onclick="self.location.href='reserve-booking.cfm?lang=<cfoutput>#lang#</cfoutput>';" />
					</div>

				</cfform>
				</cfoutput>
			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

