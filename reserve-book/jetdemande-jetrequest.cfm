<cfinclude template="#RootDir#includes/errorMessages.cfm">
<cfif lang EQ "eng">
	<cfset language.submitJettyBooking = "Submit Jetty Booking Request">
	<cfset language.keywords = language.masterKeywords & ", Jetty Booking Request">
	<cfset language.description = "Allows user to submit a new booking request, jetties section.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.reset = "reset">
	<cfset language.requestedJetty = "Requested Jetty">
	<cfset language.Company = "Company">
	<cfset language.warning = "Once this booking is confirmed, your company will be subject to a booking fee should the specified vessel not arrive for the requested time.">
	<cfset language.chooseCompany = "choose a company">
	<cfset language.requestedStatus = "Requested Status">
<cfelse>
	<cfset language.submitJettyBooking = "Pr&eacute;sentation d'une demande de r&eacute;servation de jet&eacute;e">
	<cfset language.keywords = language.masterKeywords & ", Demande de r&eacute;servation de jet&eacute;e">
	<cfset language.description = "Permet &agrave; l'utilisateur de pr&eacute;senter une nouvelle demande de r&eacute;servation - section des jet&eacute;es.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.reset = "R&eacute;initialiser">
	<cfset language.requestedJetty = "Jet&eacute;e demand&eacute;e">
	<cfset language.Company = "Entreprise">
	<cfset language.warning = "Une fois la r&eacute;servation confirm&eacute;e, votre entreprise devra payer des frais de r&eacute;servation si le navire indiqu&eacute; n'arrive pas au moment pr&eacute;vu.">
	<cfset language.chooseCompany = "s&eacute;lectionner une entreprise">
	<cfset language.requestedStatus = "&Eacute;tat demand&eacute;">
</cfif>

<cfsavecontent variable="js">
	<cfoutput>
	<meta name="dcterms.title" content="#language.submitJettyBooking# - #language.esqGravingDock# - #language.PWGSC#" />
	<meta name="keywords" content="#language.keywords#" />
	<meta name="description" content="#language.description#" />
	<meta name="dcterms.subject" scheme="gccore" content="#language.subjects#" />
	<title>#language.submitJettyBooking# - #language.esqGravingDock# - #language.PWGSC#</title>
	</cfoutput>
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


<cfparam name="Variables.VNID" default="">
<cfparam name="Variables.startDate" default="#DateAdd('d', 1, PacificNow)#">
<cfparam name="Variables.endDate" default="#DateAdd('d', 1, PacificNow)#">
<cfparam name="Variables.Jetty" default="north">
<cfparam name="Variables.Status" default="tentative">

<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfif IsDefined("URL.Date")>
		<cfset Variables.StartDate = URL.Date>
		<cfset Variables.EndDate = URL.Date>
	</cfif>
</cflock>

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

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">

				<cfinclude template="#RootDir#includes/getStructure.cfm">
				<cfinclude template="#RootDir#includes/restore_params.cfm">
				<cfif isDefined("session.form_structure") and structKeyExists(form, 'VNID')>
					<cfset Variables.VNID = #form.VNID#>
					<cfset Variables.startDate = #form.startDate#>
					<cfset Variables.endDate = #form.endDate#>
					<cfset Variables.Jetty = #form.jetty#>
					<cfset Variables.Status = #form.status#>
				</cfif>

        <cfif not isDate(Variables.startDate)>
          <cfset Variables.startDate = "" />
        </cfif>

        <cfif not isDate(Variables.endDate)>
          <cfset Variables.endDate = "" />
        </cfif>

				<cfoutput>
				<p>#language.enterInfo#  #language.dateInclusive#</p>

				<form action="#RootDir#reserve-book/jetdemande-jetrequest_confirm.cfm?lang=#lang#" method="post" id="bookingreq">
					<fieldset>
            <legend>#language.booking#</legend>
            <p>#language.requiredFields#</p>

            <div>
              <label for="VNID">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;#language.vessel#:
                #error('VNID')#
              </label>
              <select id="VNID" name="VNID">
                <option value="">(#language.chooseVessel#)</option>
                <cfloop query="companyVessels">
                  <cfset selected = "" />
                  <cfif companyVessels.VNID eq variables.VNID>
                    <cfset selected = "selected=""selected""" />
                  </cfif>
                  <option value="#companyVessels.VNID#" #selected#>#companyVessels.VesselName#</option>
                </cfloop>
              </select>
            </div>

            <div>
              <label for="StartDate">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.StartDate#:
                <br /><small><abbr title="#language.dateformexplanation#">#language.dateform#</abbr></small>
                #error('StartDate')#
              </label>
              <input id="StartDate" name="startDate" type="text" class="datepicker startDate" value="#DateFormat(variables.startDate, 'mm/dd/yyyy')#" size="15" maxlength="10"  /> 
            </div>

						<div>
              <label for="EndDate">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.EndDate#:
                <br /><small><abbr title="#language.dateformexplanation#">#language.dateform#</abbr></small>
                #error('EndDate')#
              </label>
              <input id="EndDate" name="endDate" type="text" class="datepicker endDate" value="#DateFormat(variables.endDate, 'mm/dd/yyyy')#" size="15" maxlength="10"  /> 
						</div>

						<div>
              <label for="status">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.requestedStatus#:
              </label>
              <select id="status" name="status" >
                <option value="tentative" <cfif Variables.Status EQ "tentative">selected="selected"</cfif>>#language.tentative#</option>
                <option value="confirmed" <cfif Variables.Status EQ "confirmed">selected="selected"</cfif>>#language.confirmed#</option>
              </select>
						</div>

            <div>
              <label for="jetty">
                <abbr title="#language.required#" class="required">*</abbr>&nbsp;
                #language.RequestedJetty#:
              </label>
              <select name="jetty" id="jetty">
                <option value="north"<cfif Variables.Jetty EQ "north"> selected="selected"</cfif>>#language.NorthLandingWharf#</option>
                <option value="south"<cfif Variables.Jetty EQ "south"> selected="selected"</cfif>>#language.SouthJetty#</option>
              </select>
            </div>

            <div>
              <input type="submit" value="#language.Submit#" />
            </div>
					</fieldset>
				</form>
				<p>#language.warning#</p>
				</cfoutput>
			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

