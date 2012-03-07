<!---clear form structure--->
<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<!--- these language variables have to come before the CFhtmlhead tag --->
<cfif lang EQ 'eng'>
	<cfset language.keywords = language.masterKeywords & ", Booking Request" />
	<cfset language.description = "The Esquimalt Graving Dock booking application homepage." />
	<cfset language.subjects = language.masterSubjects />
<cfelse>
	<cfset language.keywords = language.masterKeywords & ", Demande de r&eacute;servation" />
	<cfset language.description = "Page d'accueil de l'application des r&eacute;servations de la Cale s&eacute;che d'Esquimalt." />
	<cfset language.subjects = language.masterSubjects />
</cfif>

<cfoutput>

<cfsavecontent variable="head">
	<meta name="dc.title" content="#language.Booking# - #language.esqGravingDock# - #language.PWGSC#" />
	<meta name="keywords" content="#language.keywords#" />
	<meta name="description" content="#language.description#" />
	<meta name="dc.subject" scheme="gccore" content="#language.subjects#" />
	<title>#language.Booking# - #language.esqGravingDock# - #language.PWGSC#</title>
</cfsavecontent>
<cfhtmlhead text="#head#" />

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cflock scope="session" throwontimeout="no" timeout="60" type="readonly">
	<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Companies.CID, Name AS CompanyName, UserCompanies.Approved
		FROM	UserCompanies INNER JOIN Companies ON UserCompanies.CID = Companies.CID
		WHERE	UID = <cfqueryparam value="#session.UID#" cfsqltype="cf_sql_integer" /> AND UserCompanies.Deleted = 0 AND UserCompanies.Approved = 1 AND Companies.approved = 1
		ORDER BY Companies.Name
	</cfquery>
</cflock>

<cfparam name="variables.CID" default="#getCompanies.CID#">
<cfif trim(#variables.CID#) EQ ""><cflocation url="#RootDir#ols-login/fls-logout.cfm?lang=#lang#"></cfif>

<cflock timeout="60" throwontimeout="No" type="exclusive" scope="session">
	<cfif isDefined("URL.CID")>
		<cfloop query="getCompanies">
			<cfif URL.CID eq CID><cfset Variables.CID = #URL.CID#></cfif>
		</cfloop>
	<cfelseif IsDefined("Session.LastChoice.CID")>
		<cflocation url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#&CID=#Session.LastChoice.CID#" addtoken="no">
	<cfelse>
		<cflocation url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#&CID=#Variables.CID#" addtoken="no">
	</cfif>
	<cfset Session.LastChoice.CID = Variables.CID>
	<cfset Session.Flow.CID = Variables.CID>
</cflock>


<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Name AS CompanyName
	FROM	Companies
	WHERE	CID = <cfqueryparam value="#variables.CID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfquery name="getVessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT VNID, Name
	FROM Vessels
	WHERE CID = <cfqueryparam value="#variables.CID#" cfsqltype="cf_sql_integer" />
	AND Deleted = 0
	ORDER BY Name
</cfquery>


<cfset variables.today = CreateODBCDate(PacificNow)>
<cfquery name="getDockBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Bookings.*, Vessels.Name, Docks.*, FirstName, LastName, Users.FirstName + ' ' + Users.LastName AS AgentName
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Companies ON Vessels.CID = Companies.CID INNER JOIN
		Docks ON Bookings.BRID = Docks.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID
	WHERE Companies.CID = <cfqueryparam value="#variables.CID#" cfsqltype="cf_sql_integer" /> 
  AND Bookings.Deleted = '0' 
  AND Vessels.Deleted = 0 
  AND endDate >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_date" />
	ORDER BY startDate, enddate
</cfquery>

<cfquery name="getNorthJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Bookings.*, Vessels.Name, Jetties.*, FirstName, LastName, Users.FirstName + ' ' + Users.LastName AS AgentName
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Companies ON Vessels.CID = Companies.CID INNER JOIN
		Jetties ON Bookings.BRID = Jetties.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID
	WHERE Companies.CID = <cfqueryparam value="#variables.CID#" cfsqltype="cf_sql_integer" /> 
  AND Jetties.NorthJetty = '1' 
  AND Bookings.Deleted = '0' 
  AND Vessels.Deleted = 0 
  AND endDate >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_date" />
	ORDER BY startDate, enddate
</cfquery>

<cfquery name="getSouthJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Bookings.*, Vessels.Name, Jetties.*, FirstName, LastName, Users.FirstName + ' ' + Users.LastName AS AgentName
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Companies ON Vessels.CID = Companies.CID INNER JOIN
		Jetties ON Bookings.BRID = Jetties.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID 
    AND Jetties.SouthJetty = '1' 
    AND Bookings.Deleted = '0' 
    AND Vessels.Deleted = 0 
    AND endDate >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_date" />
	WHERE Companies.CID = <cfqueryparam value="#variables.CID#" cfsqltype="cf_sql_integer" />
	ORDER BY startDate, enddate
</cfquery>

<cfquery name="currentCompany" dbtype="query">
	SELECT	CompanyName
	FROM	getCompanies
	WHERE	 getCompanies.CID = <cfqueryparam value="#variables.CID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfquery name="unapprovedCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Name AS CompanyName
		FROM	UserCompanies INNER JOIN Companies ON UserCompanies.CID = Companies.CID
		WHERE	 UID = <cfqueryparam value="#session.UID#" cfsqltype="cf_sql_integer" /> 
    AND UserCompanies.Deleted = 0 
    AND (UserCompanies.Approved = 0 OR Companies.approved = 0)
		ORDER  BY Companies.Name
</cfquery>

<!---Drydock Status--->
<cfquery name="countPending" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT count(*) as numPend
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Companies ON Vessels.CID = Companies.CID INNER JOIN
		Docks ON Bookings.BRID = Docks.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID
	WHERE Companies.CID = <cfqueryparam value="#variables.CID#" cfsqltype="cf_sql_integer" /> 
  AND Bookings.Deleted = '0' 
  AND Vessels.Deleted = 0 
  AND endDate >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_date" /> 
  AND (Status = 'P' OR Status ='PT' OR Status = 'PC')
</cfquery>
<cfquery name="countTentative" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT count(*) as numTent
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Companies ON Vessels.CID = Companies.CID INNER JOIN
		Docks ON Bookings.BRID = Docks.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID
	WHERE Companies.CID = <cfqueryparam value="#variables.CID#" cfsqltype="cf_sql_integer" /> 
  AND Bookings.Deleted = '0' 
  AND Vessels.Deleted = 0 
  AND endDate >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_date" /> 
  AND Status ='T'
</cfquery>
<cfquery name="countConfirmed" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT count(*) as numConf
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Companies ON Vessels.CID = Companies.CID INNER JOIN
		Docks ON Bookings.BRID = Docks.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID
	WHERE Companies.CID = <cfqueryparam value="#variables.CID#" cfsqltype="cf_sql_integer" /> 
  AND Bookings.Deleted = '0' 
  AND Vessels.Deleted = 0 
  AND endDate >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_date" /> 
  AND Status ='C'
</cfquery>
<cfquery name="countCancelled" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT count(*) as numCanc
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Companies ON Vessels.CID = Companies.CID INNER JOIN
		Docks ON Bookings.BRID = Docks.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID
	WHERE Companies.CID = <cfqueryparam value="#variables.CID#" cfsqltype="cf_sql_integer" /> 
  AND Bookings.Deleted = '0' 
  AND Vessels.Deleted = 0 
  AND endDate >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_date" /> 
  AND Status ='PX'
</cfquery>
<!---North Jetty Status--->
<cfquery name="countPendingNJ" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT count(*) as numPendNJ
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Companies ON Vessels.CID = Companies.CID INNER JOIN
		Jetties ON Bookings.BRID = Jetties.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID
	WHERE Companies.CID = <cfqueryparam value="#variables.CID#" cfsqltype="cf_sql_integer" /> 
  AND Jetties.NorthJetty = '1' 
  AND Bookings.Deleted = '0' 
  AND Vessels.Deleted = 0 
  AND endDate >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_date" /> 
  AND (Status = 'P' OR Status ='PT' or Status ='PX' or Status='PC')
</cfquery>
<cfquery name="countTentativeNJ" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT count(*) as numTentNJ
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Companies ON Vessels.CID = Companies.CID INNER JOIN
		Jetties ON Bookings.BRID = Jetties.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID
	WHERE Companies.CID = <cfqueryparam value="#variables.CID#" cfsqltype="cf_sql_integer" /> 
  AND Jetties.NorthJetty = '1' 
  AND Bookings.Deleted = '0' 
  AND Vessels.Deleted = 0 
  AND endDate >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_date" /> 
  AND Status ='T'
</cfquery>
<cfquery name="countConfirmedNJ" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT count(*) as numConfNJ
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Companies ON Vessels.CID = Companies.CID INNER JOIN
		Jetties ON Bookings.BRID = Jetties.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID
	WHERE Companies.CID = <cfqueryparam value="#variables.CID#" cfsqltype="cf_sql_integer" /> 
  AND Jetties.NorthJetty = '1' 
  AND Bookings.Deleted = '0' 
  AND Vessels.Deleted = 0 
  AND endDate >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_date" /> 
  AND Status ='C'
</cfquery>
<cfquery name="countCancelledNJ" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT count(*) as numCancNJ
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Companies ON Vessels.CID = Companies.CID INNER JOIN
		Jetties ON Bookings.BRID = Jetties.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID
	WHERE Companies.CID = <cfqueryparam value="#variables.CID#" cfsqltype="cf_sql_integer" /> 
  AND Jetties.NorthJetty = '1' 
  AND Bookings.Deleted = '0' 
  AND Vessels.Deleted = 0 
  AND endDate >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_date" /> 
  AND Status ='PX'
</cfquery>
<!---South Jetty Status--->
<cfquery name="countPendingSJ" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT count(*) as numPendSJ
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Companies ON Vessels.CID = Companies.CID INNER JOIN
		Jetties ON Bookings.BRID = Jetties.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID 
    AND Jetties.SouthJetty = '1' 
    AND Bookings.Deleted = '0' 
    AND Vessels.Deleted = 0 
    AND endDate >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_date" /> 
    AND (Status = 'P' OR Status ='PT' or Status ='PX' or Status='PC')
	WHERE Companies.CID = <cfqueryparam value="#variables.CID#" cfsqltype="cf_sql_integer" />
</cfquery>
<cfquery name="countTentativeSJ" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT count(*) as numTentSJ
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Companies ON Vessels.CID = Companies.CID INNER JOIN
		Jetties ON Bookings.BRID = Jetties.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID 
    AND Jetties.SouthJetty = '1' 
    AND Bookings.Deleted = '0' 
    AND Vessels.Deleted = 0 
    AND endDate >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_date" /> 
    AND Status ='T'
	WHERE Companies.CID = <cfqueryparam value="#variables.CID#" cfsqltype="cf_sql_integer" />
</cfquery>
<cfquery name="countConfirmedSJ" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT count(*) as numConfSJ
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Companies ON Vessels.CID = Companies.CID INNER JOIN
		Jetties ON Bookings.BRID = Jetties.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID 
    AND Jetties.SouthJetty = '1' 
    AND Bookings.Deleted = '0' 
    AND Vessels.Deleted = 0 
    AND endDate >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_date" /> 
    AND Status ='C'
	WHERE Companies.CID = <cfqueryparam value="#variables.CID#" cfsqltype="cf_sql_integer" />
</cfquery>
<cfquery name="countCancelledSJ" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT count(*) as numCancSJ
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Companies ON Vessels.CID = Companies.CID INNER JOIN
		Jetties ON Bookings.BRID = Jetties.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID 
    AND Jetties.SouthJetty = '1' 
    AND Bookings.Deleted = '0' 
    AND Vessels.Deleted = 0 
    AND endDate >= <cfqueryparam value="#variables.today#" cfsqltype="cf_sql_date" /> 
    AND Status ='PX'
	WHERE Companies.CID = <cfqueryparam value="#variables.CID#" cfsqltype="cf_sql_integer" />
</cfquery>
<cfquery name="readonlycheck" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT ReadOnly
	FROM Users
	WHERE UID = <cfqueryparam value="#Session.UID#" cfsqltype="cf_sql_integer" />
</cfquery>
<cfloop query="readonlycheck">
	<cfset Session.ReadOnly = #ReadOnly#>
</cfloop>

<cfif lang EQ 'eng'>
	<cfset language.followingbooking = "Your current bookings for <strong>#getCompany.companyName#</strong> are as follows:">
<cfelse>
	<cfset language.followingbooking = "Vos rservations actuelles sont les suivantes : <strong>#getCompany.companyName#</strong>">
</cfif>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm"> &gt; #language.bookingHome#
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					#language.bookingHome#
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<div class="content">
					<p>#language.Welcome#, #Session.Firstname# #Session.LastName#!</p>
          <cfinclude template="#RootDir#includes/notice.cfm" />
          <cfinclude template="#RootDir#includes/user_menu.cfm">

				<cfif getCompanies.recordCount GT 1>
					<div style="text-align:center;">
							<p>#language.currentcompany#<br />
							<strong class="h1Size">#currentCompany.companyName#</strong></p>
							<p>#language.otherCompanies#<br />
						<cfloop query="getCompanies">
							<cfif getCompanies.CID NEQ #variables.CID# AND approved eq 1><span style="white-space: nowrap; "><a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#&amp;CID=#CID#">#CompanyName#</a></span>&nbsp;&nbsp;</cfif>
						</cfloop>
						</p>

						<cfif unapprovedCompany.RecordCount GTE 1>
							<p>#language.awaitingApproval#<br />
							<cfloop query="unapprovedCompany">
								<span style="white-space: nowrap;">#CompanyName#</span>&nbsp;&nbsp;
							</cfloop>
							</p>
						</cfif>
					</div>
				</cfif>

        #GetLocaleDisplayName()#

        <h2>#language.Vessel#(s)</h2>
          <cfif getVessels.recordCount EQ 0>
            <p>#language.None#</p>
          <cfelse>
            <ul>
              <cfloop query="getVessels">
                <li><a href="#RootDir#reserve-book/detail-navire-vessel.cfm?lang=#lang#&amp;VNID=#VNID#" title="#Name# #VNID#">#Name#</a></li>
              </cfloop>
            </ul>
          </cfif>

					<h2>#language.bookings#</h2>

					<p>#language.followingbooking#</p>

					<cfset counter = 0>
					<h3>#language.Drydock#</h3>
					<cfif getDockBookings.recordCount GE 1>

						<table class="basic">
              <thead>
								<tr>
									<th scope="col">#language.booking#</th>
									<th scope="col">#language.startdate#</th>
									<th scope="col">#language.enddate#</th>
									<th scope="col">#language.status#</th>
								</tr>
              </thead>
              <tbody>
                <cfloop query="getDockBookings">
                  <tr>
                    <td>
                      <a href="#RootDir#comm/detail-res-book.cfm?lang=#lang#&amp;BRID=#BRID#" title="#language.booking# ###BRID#">
                        <span class="navaid">#language.booking# ###BRID#:</span>
                        <cfif #EndHighlight# GTE PacificNow>*</cfif>
                        #Name#
                      </a>
                    </td>
                    <td>#myDateFormat(CreateODBCDate(startDate), request.datemask)#</td>
                    <td>#myDateFormat(endDate, request.datemask)#</td>
                    <td>
                      <cfif status EQ "P" or status EQ "PT"><span class="pending">#language.pending#</span>
                      <cfelseif status EQ "C"><span class="confirmed">#language.confirmed#</span>
                      <cfelseif status EQ "T"><span class="tentative">#language.tentative#</span>
                      <cfelseif status EQ "PC"><span class="pending">#language.confirming#</span>
                      <cfelseif status EQ "PX"><span class="cancelled">#language.pending_cancelling#</span>
                      </cfif>
                    </td>
                  </tr>
                  <cfset counter = counter + 1>
                </cfloop>
              </tbody>
						</table>
						<p class="total">
							Total:&nbsp;&nbsp;
              <span class="pending">#language.pending# - #countPending.numPend#</span>
              <span class="tentative">#language.tentative# - #countTentative.numTent#</span>
              <span class="confirmed">#language.confirmed# - #countConfirmed.numConf#</span>
              <span class="cancelled">#language.pending_cancelling# - #countCancelled.numCanc#</span>
						</p>
					<cfelse>
						#language.None#.
					</cfif>

					<cfset counter = 0>
					<h3>#language.NorthLandingWharf#</h3>
					<cfif getNorthJettyBookings.recordCount GE 1>
						<table class="basic">
              <thead>
								<tr>
									<th scope="col">#language.booking#</th>
									<th scope="col">#language.startdate#</th>
									<th scope="col">#language.enddate#</th>
									<th scope="col">#language.status#</th>
								</tr>
              </thead>
              <tbody>
                <cfloop query="getNorthJettyBookings">
                  <tr>
                    <td>
                      <a href="#RootDir#comm/detail-res-book.cfm?lang=#lang#&amp;BRID=#BRID#" title="#language.booking# ###BRID#">
                        <span class="navaid">#language.booking# ###BRID#:</span>
                        <cfif #EndHighlight# GTE PacificNow>*</cfif>
                        #Name#
                      </a>
                    </td>
                    <td>#myDateFormat(CreateODBCDate(startDate), request.datemask)#</td>
                    <td>#myDateFormat(endDate, request.datemask)#</td>
                    <td>
                      <cfif status EQ "P" or status EQ "PT"><span class="pending">#language.pending#</span>
                      <cfelseif status EQ "C"><span class="confirmed">#language.confirmed#</span>
                      <cfelseif status EQ "T"><span class="tentative">#language.tentative#</span>
                      <cfelseif status EQ "PC"><span class="pending">#language.confirming#</span>
                      <cfelseif status EQ "X"><span class="cancelled">#language.pending_cancelling#</span>
                      </cfif>
                    </td>
                  </tr>
                  <cfset counter = counter + 1>
                </cfloop>
              </tbody>
						</table>
            <p class="total">
              Total:&nbsp;&nbsp;
              <span class="pending">#language.pending# - #countPendingNJ.numPendNJ#</span>
              <span class="tentative">#language.tentative# - #countTentativeNJ.numTentNJ#</span>
              <span class="confirmed">#language.confirmed# - #countConfirmedNJ.numConfNJ#</span>
              <span class="cancelled">#language.pending_cancelling# - #countCancelledNJ.numCancNJ#</span>
            </p>
					<cfelse>
						<p>#language.None#.</p>
					</cfif>

					<h3>#language.SouthJetty#</h3>
					<cfif getSouthJettyBookings.recordCount GE 1>
						<table class="basic">
              <thead>
								<tr>
									<th scope="col">#language.booking#</th>
									<th scope="col">#language.startdate#</th>
									<th scope="col">#language.enddate#</th>
									<th scope="col">#language.status#</th>
								</tr>
              </thead>
              <tbody>
                <cfset counter = 0>
                <cfloop query="getSouthJettyBookings">
                  <tr>
                    <td>
                      <a href="#RootDir#comm/detail-res-book.cfm?lang=#lang#&amp;BRID=#BRID#" title="#language.booking# ###BRID#">
                        <span class="navaid">#language.booking# ###BRID#:</span>
                        <cfif #EndHighlight# GTE PacificNow>*</cfif>
                        #Name#
                      </a>
                    </td>
                    <td>#myDateFormat(CreateODBCDate(startDate), request.datemask)#</td>
                    <td>#myDateFormat(endDate, request.datemask)#</td>
                    <td>
                      <cfif status EQ "P" or status EQ "PT"><span class="pending">#language.pending#</span>
                      <cfelseif status EQ "C"><span class="confirmed">#language.confirmed#</span>
                      <cfelseif status EQ "T"><span class="tentative">#language.tentative#</span>
                      <cfelseif status EQ "PC"><span class="pending">#language.confirming#</span>
                      <cfelseif status EQ "PX"><span class="cancelled">#language.pending_cancelling#</span>
                      </cfif>
                    </td>
                  </tr>
                  <cfset counter = counter + 1>
                </cfloop>
            </tbody>
						</table>
            <p class="total">
              Total:&nbsp;&nbsp;
              <span class="pending">#language.pending# - #countPendingSJ.numPendSJ#</span>
              <span class="tentative">#language.tentative# - #countTentativeSJ.numTentSJ#</span>
              <span class="confirmed">#language.confirmed# - #countConfirmedSJ.numConfSJ#</span>
              <span class="cancelled">#language.pending_cancelling# - #countCancelledSJ.numCancSJ#</span>
            </p>
					<cfelse>
						<p>#language.None#.</p>
					</cfif>
					</div>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

</cfoutput>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
