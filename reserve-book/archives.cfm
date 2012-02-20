<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	C.Name AS CompanyName
	FROM	Companies C INNER JOIN UserCompanies UC ON C.CID = UC.CID
	WHERE	
		UC.UID = <cfqueryparam value="#Session.UID#" cfsqltype="cf_sql_integer" />
		AND	UC.Deleted = '0'
</cfquery>

<cfif lang EQ 'eng'>
	<cfset language.keywords = language.masterKeywords & ", Booking Archives">
	<cfset language.description = "Allows users to view all bookings for a company.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.followingbooking = "Your bookings are as follows:">
<cfelse>
	<cfset language.keywords = language.masterKeywords & "">
	<cfset language.description = "Permet aux utilisateurs de voir toutes les r&eacute;servations pour une entreprise.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.followingbooking = "Vos r&eacute;servations sont les suivantes :">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.archivedBookings# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.archivedBookings# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">


<cfquery name="getDockBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Bookings.*, Vessels.Name, Docks.*, FirstName, LastName, Users.FirstName + ' ' + Users.LastName AS AgentName
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Companies ON Vessels.CID = Companies.CID INNER JOIN
		Docks ON Bookings.BRID = Docks.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID
	WHERE Bookings.Deleted = '0' AND Vessels.Deleted = 0
	ORDER BY startDate, enddate
</cfquery>

<cfquery name="getNorthJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Bookings.*, Vessels.Name, Jetties.*, FirstName, LastName, Users.FirstName + ' ' + Users.LastName AS AgentName
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Companies ON Vessels.CID = Companies.CID INNER JOIN
		Jetties ON Bookings.BRID = Jetties.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID
	WHERE Jetties.NorthJetty = '1' AND Bookings.Deleted = '0' AND Vessels.Deleted = 0
	ORDER BY startDate, enddate
</cfquery>

<cfquery name="getSouthJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Bookings.*, Vessels.Name, Jetties.*, FirstName, LastName, Users.FirstName + ' ' + Users.LastName AS AgentName
	FROM Bookings INNER JOIN
		Vessels ON Bookings.VNID = Vessels.VNID INNER JOIN
		Companies ON Vessels.CID = Companies.CID INNER JOIN
		Jetties ON Bookings.BRID = Jetties.BRID INNER JOIN
		Users ON Bookings.UID = Users.UID AND Jetties.SouthJetty = '1' AND Bookings.Deleted = '0' AND Vessels.Deleted = 0
	ORDER BY startDate, enddate
</cfquery>


		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			#language.archivedBookings#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.archivedBookings#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/user_menu.cfm">

				<cfset variables.referrer = "Archive">
				<cfoutput>
				<p>#language.followingbooking#</p>
					<cfset counter = 0>
					<h2>#language.Drydock#</h2>
					<cfif "getDockBookings.recordCount" GE 1>
            <table class="basic">
              <thead>
                <tr>
                  <th scope="col">#language.booking#</th>
                  <th scope="col">#language.status#</th>
                </tr>
              </thead>
              <tbody>
                <cfloop query="getDockBookings">
                  <tr>
                    <td>
                      <a href="#RootDir#comm/detail-res-book.cfm?lang=#lang#&amp;BRID=#BRID#&amp;referrer=#variables.referrer#">
                        ###BRID#:
                        #Name# &mdash;
                        #lsdateformat(CreateODBCDate(startDate), 'mmm d, yyyy')# - 
                        #lsdateformat(endDate, 'mmm d, yyyy')#
                      </a>
                    </td>
                    <td>
                      <cfif status EQ "PT">#language.pending#
                      <cfelseif status EQ "C">#language.confirmed#
                      <cfelseif status EQ "T">#language.tentative#</cfif>
                    </td>
                  </tr>
                <cfset counter = counter + 1>
                </cfloop>
              </tbody>
						</table>
					<cfelse>
						<p>#language.None#.</p>
					</cfif>

					<cfset counter = 0>
					<h2>#language.NorthLandingWharf#</h2>
					<cfif getNorthJettyBookings.recordCount GE 1>
						<table class="basic">
              <thead>
                <tr>
                  <th scope="col">#language.booking#</th>
                  <th scope="col">#language.status#</th>
                </tr>
              </thead>
              <tbody>
                <cfloop query="getNorthJettyBookings">
                  <tr>
                    <td>
                      <a href="#RootDir#comm/detail-res-book.cfm?lang=#lang#&amp;BRID=#BRID#&amp;referrer=#variables.referrer#">
                        ###BRID#:
                        #Name# &mdash;
                        #lsdateformat(startDate, 'mmm d, yyyy')# - 
                        #lsdateformat(endDate, 'mmm d, yyyy')#
                      </a>
                    </td>
                    <td>
                      <cfif NOT status eq 'c'>#language.pending#
                      <cfelse>#language.confirmed#</cfif>
                    </td>
                  </tr>
                <cfset counter = counter + 1>
                </cfloop>
              </tbody>
						</table>
					<cfelse>
						<p>#language.None#.</p>
					</cfif>

				<cfset counter = 0>
					<h2>#language.SouthJetty#</h2>
					<cfif getSouthJettyBookings.recordCount GE 1>
						<table class="basic">
              <thead>
                <tr>
                  <th scope="col">#language.booking#</th>
                  <th scope="col">#language.status#</th>
                </tr>
              </thead>
              <tbody>
                <cfloop query="getSouthJettyBookings">
                  <tr>
                    <td>
                      <a href="#RootDir#comm/detail-res-book.cfm?lang=#lang#&amp;BRID=#BRID#&amp;referrer=#variables.referrer#">
                        ###BRID#:
                        #Name# &mdash;
                        #lsdateformat(startDate, 'mmm d, yyyy')# - 
                        #lsdateformat(endDate, 'mmm d, yyyy')#
                      </a>
                    </td>
                    <td>
                      <cfif NOT status eq 'c'>#language.pending#
                      <cfelse>#language.confirmed#</cfif>
                    </td>
                  </tr>
                <cfset counter = counter + 1>
                </cfloop>
              </tbody>
						</table>
					<cfelse>
						<p>#language.None#.</p>
					</cfif>
				<p><a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#" class="textbutton">#language.returnTo#</a></p>

				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
