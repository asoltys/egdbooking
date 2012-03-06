<cfinclude template="#RootDir#includes/errorMessages.cfm">
<cfif lang EQ "eng">
	<cfset language.drydockRequest = "Submit Drydock Booking Request">
	<cfset language.keywords = language.masterKeywords & ", Drydock Booking Request">
	<cfset language.description = "Allows user to submit a new booking request, drydock section.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.daysToBook = "Enter the number of days the vessel needs to be booked for.  The system will locate the first available date period.">
	<cfset language.numDays = "Number of days">
	<cfset language.reset = "reset">
	<cfset language.or = "or">
	<cfset language.numDaysError = "Please enter the desired number of days.">
	<cfset language.dateRange = "Date Range">
	<cfset language.requestedStatus = "Requested Status">

<cfelse>
	<cfset language.drydockRequest = "Pr&eacute;sentation d'une demande de r&eacute;servation de la cale s&egrave;che">
	<cfset language.keywords = language.masterKeywords & ", demanmde de r&eacute;servatino de la cale s&egrave;che">
	<cfset language.description = "Permet &agrave; l'utilisateur de pr&eacute;senter une nouvelle demande de r&eacute;servation sur le site Web de la cale s&egrave;che d'Esquimalt - section de la cale s&egrave;che.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.daysToBook = "Veuillez entrer le nombre de jours de r&eacute;servation requis pour le navire. Le syst&egrave;me trouvera la prochaine p&eacute;riode libre.">
	<cfset language.numDays = "Nombre de jours">
	<cfset language.reset = "R&eacute;initialiser">
	<cfset language.or = "ou">
	<cfset language.numDaysError = "Veuillez entrer le nombre de jours voulus.">
	<cfset language.dateRange = "P&eacute;riode&nbsp;">
	<cfset language.requestedStatus = "&Eacute;tat demand&eacute;">
</cfif>

<cfoutput>

<cfsavecontent variable="js">
	<meta name="dc.title" content="#language.drydockRequest# - #language.esqGravingDock# - #language.PWGSC#" />
	<meta name="keywords" content="#language.keywords#" />
	<meta name="description" content="#language.description#" />
	<meta name="dc.subject" scheme="gccore" content="#language.subjects#" />
	<title>#language.drydockRequest# - #language.esqGravingDock# - #language.PWGSC#</title>
</cfsavecontent>
<cfhtmlhead text="#js#">

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfquery name="companyVessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	VNID, vessels.Name AS VesselName, companies.CID, companies.Name AS CompanyName
		FROM 	Vessels INNER JOIN Companies ON Vessels.CID = Companies.CID
				INNER JOIN UserCompanies ON Companies.CID = UserCompanies.CID
				INNER JOIN Users ON UserCompanies.UID = Users.UID
		WHERE 	Users.UID = <cfqueryparam value="#session.UID#" cfsqltype="cf_sql_integer" />
		AND		UserCompanies.Approved = 1
		AND		UserCompanies.Deleted = 0
		AND		Companies.Deleted = '0'
		AND		Companies.Approved = 1
		AND		Vessels.Deleted = '0'
		ORDER BY Companies.Name, Vessels.Name
	</cfquery>
</cflock>

<cfparam name="Variables.CID" default="">
<cfparam name="Variables.VNID" default="">
<cfparam name="Variables.startDate" default="#DateAdd('d', 1, PacificNow)#">
<cfparam name="Variables.endDate" default="#DateAdd('d', 3, PacificNow)#">
<cfparam name="Variables.numDays" default="">
<cfparam name="Variables.status" default="">

<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfif IsDefined("URL.VNID")>
		<cfset Variables.VNID = URL.VNID>
		<cfquery name="GetCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT	CID
			FROM	Vessels
			WHERE	Vessels.VNID = <cfqueryparam value="#Variables.VNID#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfset Variables.CID = GetCompany.CID>
	<cfelseif IsDefined("URL.CID")>
		<cfset Variables.CID = URL.CID>
		<cfset Variables.VNID = "">
	</cfif>
	<cfif IsDefined("URL.Date")>
		<cfset Variables.StartDate = URL.Date>
		<cfset Variables.EndDate = DateAdd('d', 3, Variables.StartDate)>
	</cfif>
</cflock>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<a href="#RootDir#reserve-book/resdemande-bookrequest.cfm?lang=#lang#">#language.bookingRequest#</a> &gt;
			#language.drydockRequest#
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					#language.drydockRequest#
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">

				<cfinclude template="#RootDir#includes/getStructure.cfm">
				<cfinclude template="#RootDir#includes/restore_params.cfm">
				<cfif isDefined("session.form_structure")>
          <cfif isDate(form.startDate) and isDate(form.endDate)>
            <cfset Variables.startDate = form.startDate>
            <cfset Variables.endDate = form.endDate>
          </cfif>
					<cfset Variables.status = form.status>
          <cfif structKeyExists(session.form_structure, 'bookingByRange_CID')>
            <cfset variables.CID = form.bookingByRange_CID />
            <cfset variables.VNID = form.bookingByRange_VNID />
          </cfif>
				</cfif>

				<p>#language.enterInfo#  #language.dateInclusive#</p>
				<form action="#RootDir#reserve-book/caledemande-dockrequest_confirm.cfm?lang=#lang#" method="post" id="booking">
					<fieldset>
            <legend>#language.booking#</legend>
            <p>#language.requiredFields#</p>

            <div>
              <label for="booking_CID">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.Company#:
              </label>
              <CF_TwoSelectsRelated
                query="companyVessels"
                id1="booking_CID"
                id2="booking_VNID"
                DISPLAY1="CompanyName"
                DISPLAY2="VesselName"
                VALUE1="CID"
                VALUE2="VNID"
                DEFAULT1="#Variables.CID#"
                DEFAULT2="#Variables.VNID#"
                htmlBETWEEN="</div><div><label for=""booking_VNID""><span title=""#language.required#"" class=""required"">*</span>&nbsp;#language.vessel#:</label>"
                AUTOSELECTFIRST="Yes"
                EMPTYTEXT1="(#language.chooseCompany#)"
                EMPTYTEXT2="(#language.chooseVessel#)"
                FORMNAME="bookingreq">
            </div>

						<div>
              <label for="startDateA">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;#language.StartDate#:<br />
                <small><abbr title="#language.dateformexplanation#">#language.dateform#</abbr></small></label>
              <input id="startDateA" name="startDate" class="datepicker startDate" type="text" size="15" maxlength="10"  /> 
						</div>

						<div>
             <label for="endDateA"><abbr title="#language.required#" class="required">*</abbr>&nbsp;#language.EndDate#:<br /><small><abbr title="#language.dateformexplanation#">#language.dateform#</abbr></small></label>
              <input id="endDateA" name="endDate" class="datepicker endDate" type="text" size="15" maxlength="10" value="#DateFormat(endDate, 'mm/dd/yyyy')#"  />
						</div>

						<div>
              <label for="status">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.requestedStatus#:
              </label>
              <select id="status" name="status" >
                <option value="tentative" <cfif isDefined("form.status") AND form.status EQ "tentative">selected="selected"</cfif>>#language.tentative#</option>
                <option value="confirmed" <cfif isDefined("form.status") AND form.status EQ "confirmed">selected="selected"</cfif>>#language.confirmed#</option>
              </select>
						</div>

            <div>
              <input type="submit" value="#language.Submit#" class="textbutton" />
            </div>
					</fieldset>
        </form>

				<p style="text-align: center"><strong>#language.or#</strong></p>
				<p>#language.daysToBook#  #language.dateInclusive#</p>

				<form action="#RootDir#reserve-book/caledemande-dockrequest_confirm2.cfm?lang=#lang#" method="post" id="bookingByRange">
					<fieldset>
            <legend>#language.booking#</legend>
            <p>#language.requiredFields#</p>

            <div>
              <label for="bookingByRange_CID">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.Company#:
              </label>
              <CF_TwoSelectsRelated
                QUERY="companyVessels"
                id1="bookingByRange_CID"
                id2="bookingByRange_VNID"
                DISPLAY1="CompanyName"
                DISPLAY2="VesselName"
                VALUE1="CID"
                VALUE2="VNID"
                DEFAULT1="#Variables.CID#"
                DEFAULT2="#Variables.VNID#"
                htmlBETWEEN="</div><div><label for=""bookingByRange_VNID""><span title=""#language.required#"" class=""required"">*</span>&nbsp;#language.vessel#:</label>"
                AUTOSELECTFIRST="Yes"
                EMPTYTEXT1="(#language.chooseCompany#)"
                EMPTYTEXT2="(#language.chooseVessel#)"
                FORMNAME="bookingreqB">
              <br />
            </div>

            <div>
							<label for="StartDateB">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.StartDate#:
                <br /><small><abbr title="#language.dateformexplanation#">#language.dateform#</abbr></small></label>
							<input id="StartDateB" name="startDate" type="text" class="datepicker startDate" value="#DateFormat(startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" />
            </div>

            <div>
              <label for="EndDateB">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.EndDate#:
                <br />
                <small><abbr title="#language.dateformexplanation#">#language.dateform#</abbr></small>
              </label>
              <input id="EndDateB" name="endDate" type="text" class="datepicker endDate" value="#DateFormat(endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" />
            </div>

            <div>
              <label for="NumDays">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.NumDays#:
              </label>
              <input id="NumDays" type="text" name="numDays" value="#Variables.numDays#"  />
            </div>

						<div>
              <label for="statusB">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.requestedStatus#:
              </label>
              <select id="statusB" name="status" >
                <option value="tentative" <cfif isDefined("form.status") AND form.status EQ "tentative">selected="selected"</cfif>>#language.tentative#</option>
                <option value="confirmed" <cfif isDefined("form.status") AND form.status EQ "confirmed">selected="selected"</cfif>>#language.confirmed#</option>
              </select>
						</div>

            <input type="submit" value="#language.Submit#" />
					</fieldset>
				</form>
			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
</cfoutput>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

