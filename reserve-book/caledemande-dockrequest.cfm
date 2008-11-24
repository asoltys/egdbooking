<cfinclude template="#RootDir#includes/bookingInfoVariables.cfm">
<cfinclude template="#RootDir#includes/errorMessages.cfm">
<cfif lang EQ "eng">
	<cfset language.drydockRequest = "Submit Drydock Booking Request">
	<cfset language.keywords = language.masterKeywords & ", Drydock Booking Request">
	<cfset language.description = "Allows user to submit a new booking request, drydock section.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.daysToBook = "Please enter in the number of days the vessel needs to be booked for.  The system will locate the first available date period.">
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

<cfsavecontent variable="js">
	<cfoutput>
	<meta name="dc.title" content="#language.PWGSC# - #language.EsqGravingDockCaps# - #language.drydockRequest#" />
	<meta name="keywords" content="#language.keywords#" />
	<meta name="description" content="#language.description#" />
	<meta name="dc.subject" scheme="gccore" content="#language.subjects#" />
	<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.drydockRequest#</title>
	</cfoutput>
</cfsavecontent>
<cfhtmlhead text="#js#">

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

<cfparam name="Variables.CompanyID" default="">
<cfparam name="Variables.VesselID" default="">
<cfparam name="Variables.startDate" default="#DateAdd('d', 1, PacificNow)#">
<cfparam name="Variables.endDate" default="#DateAdd('d', 3, PacificNow)#">
<cfparam name="Variables.numDays" default="">
<cfparam name="Variables.status" default="">

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
		<cfset Variables.EndDate = DateAdd('d', 3, Variables.StartDate)>
	</cfif>
</cflock>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			<a href="#RootDir#reserve-book/resdemande-bookrequest.cfm?lang=#lang#">#language.bookingRequest#</a> &gt;
			#language.drydockRequest#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.drydockRequest#</cfoutput>
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
					<cfset Variables.status = #form.status#>
				</cfif>

				<CFINCLUDE template="#RootDir#includes/calendar_js.cfm">

				<cfoutput>
				<p>#language.enterInfo#  #language.dateInclusive#</p>
				<cfform action="#RootDir#reserve-book/caledemande-dockrequest_confirm.cfm?lang=#lang#" method="post" enablecab="No" id="bookingreq" preservedata="Yes">

				<table style="width:100%; padding-left:10px;" >
					<tr>
						<td style="width:30%;" id="agent_header">#language.Agent#:</td>
						<td style="width:70%;">
							<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
								#session.lastName#, #session.firstName#
							</cflock>
						</td>
					</tr>
					<tr>
						<td>
							#language.Company#:
						</td>
						<td>
							<CF_TwoSelectsRelated
								query="companyVessels"
								id1="CompanyID"
								id2="VesselID"
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
					<tr>
						<td><label for="startDateA">#language.StartDate#:</label></td>
						<td>
							<cfinput id="startDateA" name="startDate" type="text" value="#DateFormat(startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" required="yes" message="#language.InvalidStartError#" validate="date" class="textField" onChange="setLaterDate('bookingreq', #Variables.bookingLen#)" onFocus="setEarlierDate('bookingreq', #Variables.bookingLen#)" /> #language.dateform#
							<img src="#RootDir#images/calendar.gif" alt="" class="calendar" />
						</td>
					</tr>
					<tr>
						<td><label for="endDateA">#language.EndDate#:</label></td>
						<td>
							<cfinput id="endDateA" type="text" name="endDate" size="15" maxlength="10" value="#DateFormat(endDate, 'mm/dd/yyyy')#" class="textField" required="yes" message="#language.InvalidEndError#" validate="date" onChange="setLaterDate('bookingreq', #Variables.bookingLen#)" onFocus="setEarlierDate('bookingreq', #Variables.bookingLen#)" /> #language.dateform#
							<img src="#RootDir#images/calendar.gif" alt="" class="calendar" />
						</td>
					</tr>
					<tr>
						<td><label for="status">#language.requestedStatus#:</label></td>
						<td><cfselect id="status" name="status" required="yes">
								<option value="tentative" <cfif isDefined("form.status") AND form.status EQ "tentative">selected</cfif>>#language.tentative#</option>
								<option value="confirmed" <cfif isDefined("form.status") AND form.status EQ "confirmed">selected</cfif>>#language.confirmed#</option>
							</cfselect>
						</td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
						<td colspan="2" align="center">
							<input type="submit" value="#language.Submit#" class="textbutton" />
							<input type="reset" value="#language.Reset#" class="textbutton" />
							<input type="button" value="#language.Cancel#" class="textbutton" onclick="javascript:self.location.href='reserve-booking.cfm?lang=#lang#';" />
						</td>
					</tr>
				</table>
				</cfform>
				</cfoutput>

				<hr width="50%">
				<div style="text-align:center;" class="red" style="font-weight: bold; text-transform: uppercase; "><cfoutput>#language.or#</cfoutput></div>
				<hr width="50%">

				<cfoutput>
				<p>#language.daysToBook#  #language.dateInclusive#</p>
				<cfform action="#RootDir#reserve-book/caledemande-dockrequest_confirm2.cfm?lang=#lang#" method="post" enablecab="No" id="bookingreqB" preservedata="Yes">
				<table style="width:100%; padding-left:10px;" >
					<tr>
						<td>
							#language.Company#:
						</td>
						<td>
							<CF_TwoSelectsRelated
								QUERY="companyVessels"
								id1="CompanyID"
								id2="VesselID"
								DISPLAY1="CompanyName"
								DISPLAY2="VesselName"
								VALUE1="companyID"
								VALUE2="vesselID"
								DEFAULT1="#Variables.CompanyID#"
								DEFAULT2="#Variables.VesselID#"
								htmlBETWEEN="</td></tr><tr><td id='vessel'>#language.vessel#:</td><td headers='vessel'>"
								AUTOSELECTFIRST="Yes"
								EMPTYTEXT1="(#language.chooseCompany#)"
								EMPTYTEXT2="(#language.chooseVessel#)"
								FORMNAME="bookingreqB">
						</td>
					</tr>
					<tr><td>#language.DateRange#</td></tr>
					<tr>
						<td><label for="StartDateB">#language.StartDate#:</label></td>
						<td>
							<cfinput id="StartDateB" name="startDate" type="text" value="#DateFormat(startDate, 'mm/dd/yyyy')#" size="15" maxlength="10" required="yes" message="#language.InvalidStartError#" validate="date" class="textField" onChange="setLaterDate('bookingreqB', #Variables.bookingLen#)" onFocus="setEarlierDate('bookingreqB', #Variables.bookingLen#)" /> #language.dateform#
							<img src="#RootDir#images/calendar.gif" alt="" class="calendar" />
						</td>
					</tr>
					<tr>
						<td><label for="EndDateB">#language.EndDate#:</label></td>
						<td>
							<cfinput id="EndDateB" name="endDate" type="text" value="#DateFormat(endDate, 'mm/dd/yyyy')#" size="15" maxlength="10" required="yes" message="#language.InvalidEndError#" validate="date" class="textField" onChange="setLaterDate('bookingreqB', #Variables.bookingLen#)" onFocus="setEarlierDate('bookingreqB', #Variables.bookingLen#)" /> #language.dateform#
							<img src="#RootDir#images/calendar.gif" alt="" class="calendar" />
						</td>
					</tr>
					<tr>
						<td><label for="NumDays">#language.NumDays#:</label></td>
						<td>
							<cfinput id="NumDays" class="textField" type="Text" name="numDays" value="#Variables.numDays#" required="yes" size="15" maxlength="10" validate="integer" message="#language.numDaysError#" />
						</td>
					</tr>
					<tr>
						<td><label for="statusB">#language.requestedStatus#:</label></td>
						<td><cfselect id="statusB" name="status" required="yes">
								<option value="tentative" <cfif isDefined("form.status") AND form.status EQ "tentative">selected</cfif>>#language.tentative#</option>
								<option value="confirmed" <cfif isDefined("form.status") AND form.status EQ "confirmed">selected</cfif>>#language.confirmed#</option>
							</cfselect>
						</td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
						<td colspan="2" align="center">
							<input type="submit" value="#language.Submit#" class="textbutton" />
							<input type="reset" value="#language.Reset#" class="textbutton" />
							<input type="button" value="#language.Cancel#" class="textbutton" onclick="javascript:self.location.href='reserve-booking.cfm?lang=#lang#';" />
						</td>
					</tr>
				</table>
				</cfform>
				</cfoutput>
			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
