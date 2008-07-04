<cfinclude template="#RootDir#includes/bookingInfoVariables.cfm">
<cfinclude template="#RootDir#includes/errorMessages.cfm">
<cfif lang EQ "eng">
	<cfset language.submitJettyBooking = "Submit Jetty Booking Request">
	<cfset language.keywords = language.masterKeywords & ", Jetty Booking Request">
	<cfset language.description = "Allows user to submit a new booking request, jetties section.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.reset = "reset">
	<cfset language.requestedJetty = "Requested Jetty">
	<cfset language.Company = "Company">
	<cfset language.warning = "*Once this booking is confirmed, your company will be subject to a booking fee should the specified vessel not arrive for the requested time.">
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
	<cfset language.warning = "*Une fois la r&eacute;servation confirm&eacute;e, votre entreprise devra payer des frais de r&eacute;servation si le navire indiqu&eacute; n'arrive pas au moment pr&eacute;vu.">
	<cfset language.chooseCompany = "s&eacute;lectionner une entreprise">
	<cfset language.requestedStatus = "&Eacute;tat demand&eacute;">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.submitJettyBooking#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.submitJettyBooking#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfquery name="companyVessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	vesselID, vessels.Name AS VesselName, companies.companyID, companies.Name AS CompanyName
		FROM 	Vessels INNER JOIN Companies ON Vessels.CompanyID = Companies.CompanyID
				INNER JOIN UserCompanies ON Companies.CompanyID = UserCompanies.CompanyID
				INNER JOIN Users ON UserCompanies.UserID = Users.UserID
		WHERE 	Users.UserID = #session.UserID#
		AND		UserCompanies.Approved = 1
		AND		UserCompanies.Deleted = 0
		AND		Companies.Deleted = '0'
		AND		Companies.Approved = 1
		AND		Vessels.Deleted = '0'
		ORDER BY Companies.Name, Vessels.Name
	</cfquery>
</cflock>


<cfparam name="Variables.companyID" default="">
<cfparam name="Variables.vesselID" default="">
<cfparam name="Variables.startDate" default="#DateAdd('d', 1, PacificNow)#">
<cfparam name="Variables.endDate" default="#DateAdd('d', 1, PacificNow)#">
<cfparam name="Variables.Jetty" default="north">
<cfparam name="Variables.Status" default="tentative">

<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfif IsDefined("URL.VesselID")>
		<cfset Variables.VesselID = URL.VesselID>
		<cfquery name="GetCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT	CompanyID
			FROM	Vessels
			WHERE	Vessels.VesselID = '#Variables.VesselID#'
		</cfquery>
		<cfset Variables.CompanyID = GetCompany.CompanyID>
	<cfelseif IsDefined("URL.CompanyID")>
		<cfset Variables.CompanyID = URL.CompanyID>
		<cfset Variables.VesselID = "">
	</cfif>
	<cfif IsDefined("URL.Date")>
		<cfset Variables.StartDate = URL.Date>
		<cfset Variables.EndDate = URL.Date>
	</cfif>
</cflock>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
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
				<cfif isDefined("session.form_structure")>
					<cfset Variables.companyID = #form.companyID#>
					<cfset Variables.vesselID = #form.vesselID#>
					<cfset Variables.startDate = #form.startDate#>
					<cfset Variables.endDate = #form.endDate#>
					<cfset Variables.Jetty = #form.jetty#>
					<cfset Variables.Status = #form.status#>
				</cfif>
				
				<CFINCLUDE template="#RootDir#includes/calendar_js.cfm">
				
				<cfoutput>
				<p>#language.enterInfo#  #language.dateInclusive#</p>
				
				<cfform action="#RootDir#reserve-book/jetdemande-jetrequest_confirm.cfm?lang=#lang#&companyID=#variables.companyID#" method="post" enablecab="No" name="bookingreq" preservedata="Yes">
				<table style="width:100%; padding-left:10px;" >
					<tr>
						<td style="width:30%;" id="Agent">
							#language.Agent#:
						</td>
						<td style="width:70%;" headers="Agent">
							<!---<cfinput class="textField" type="Text" name="Name" value="#Variables.Name#" message="Name is a mandatory field" required="Yes" size="65" />--->
							<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
								#session.lastName#, #session.firstName#
							</cflock>
						</td>
					</tr>
					<tr>
						<td id="Company">
							#language.Company#:
						</td>
						<td headers="Company">
							<CF_TwoSelectsRelated
								QUERY="companyVessels"
								NAME1="CompanyID"
								NAME2="VesselID"
								DISPLAY1="CompanyName"
								DISPLAY2="VesselName"
								VALUE1="CompanyID"
								VALUE2="VesselID"
								DEFAULT1="#Variables.CompanyID#"
								DEFAULT2="#Variables.VesselID#"
								htmlBETWEEN="</td></tr><tr><td id='vessel'>#language.vessel#:</td><td headers='vessel'>"
								AUTOSELECTFIRST="Yes"
								EMPTYTEXT1="(#language.chooseCompany#)"
								EMPTYTEXT2="(#language.chooseVessel#)"
								FORMNAME="bookingreq">
						</td>
					</tr>
					<tr>
						<td id="StartDate">
							<label for="start">#language.StartDate#:</label>
						</td>
						<td headers="StartDate">
							<!---input class="textField" type="Text" name="startDateShow" id="start" disabled value="#DateFormat(startDate, 'mmm d, yyyy')#" size="17"--->
							<cfinput id="start" name="startDate" type="text" value="#DateFormat(variables.startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" required="yes" message="#language.InvalidStartError#" validate="date" class="textField" onChange="setLaterDate('self', 'bookingreq', #Variables.bookingLen#)" onFocus="setEarlierDate('self', 'bookingreq', #Variables.bookingLen#)" /> #language.dateform#
							<a href="javascript:void(0)" onclick = "javascript:getCalendar('bookingreq', 'start')" class="textbutton">#language.calendar#</a>
							<!---a href="javascript:void(0);" onClick="javascript:document.bookingreq.startDateShow.value=''; document.bookingreq.startDateHidden.value='';" class="textbutton">clear</a--->
						</td>
					</tr>
					<tr>
						<td id="EndDate"><label for="end">#language.EndDate#:</label></td>
						<td headers="EndDate">
							<!---input type="text" name="endDateShow" id="end" class="textField" disabled value="#DateFormat(endDate, 'mmm d, yyyy')#" size="17"--->
							<cfinput id="end" name="endDate" type="text" value="#DateFormat(variables.endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" required="yes" message="#language.InvalidEndError#" validate="date" class="textField" onChange="setLaterDate('self', 'bookingreq', #Variables.bookingLen#)" onFocus="setEarlierDate('self', 'bookingreq', #Variables.bookingLen#)" /> #language.dateform#
							<a href="javascript:void(0)" onclick = "javascript:getCalendar('bookingreq', 'end')" class="textbutton">#language.calendar#</a>
							<!---a href="javascript:void(0);" onClick="javascript:document.bookingreq.startDateShow.value=''; document.bookingreq.startDateHidden.value='';" class="textbutton">clear</a--->
						</td>
					</tr>
					<tr>
						<td id="ReqStatus"><label for="status">#language.requestedStatus#:</label></td>
						<td headers="ReqStatus"><cfselect id="status" name="status" required="yes">
								<option value="tentative" <cfif Variables.Status EQ "tentative">selected</cfif>>#language.tentative#</option>
								<option value="confirmed" <cfif Variables.Status EQ "confirmed">selected</cfif>>#language.confirmed#</option>
							</cfselect>
						</td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
						<td id="jheader">
							<label for="jettySelect">#language.RequestedJetty#:</label>
						</td>
						<td headers="jheader">
							<cfselect name="jetty" required="yes" id="jettySelect">
								<option value="north" <cfif Variables.Jetty EQ "north">selected</cfif>>#language.NorthLandingWharf#
								<option value="south" <cfif Variables.Jetty EQ "south">selected</cfif>>#language.SouthJetty#
							</cfselect>
						</td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
						<td colspan="2" align="center">
							<input type="submit" value="#language.Submit#" class="textbutton" />
							<input type="reset" value="#language.Reset#" class="textbutton" />
							<input type="button" value="#language.Cancel#" class="textbutton" onClick="javascript:self.location.href='bookingRequest_choose.cfm?lang=#lang#';" />
						</td>
					</tr>
				</table>
				</cfform>
				<p>#language.warning#</p>
				</cfoutput>
			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

