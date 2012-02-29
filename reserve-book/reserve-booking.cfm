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

<cfinclude template="includes/reserve-booking-queries.cfm" />

<cfloop query="readonlycheck">
	<cfset Session.ReadOnly = #ReadOnly#>
</cfloop>

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

					<h3>#language.Drydock#</h3>
          #bookingsTable('drydock')#
					
          <!---
					<h3>#language.NorthLandingWharf#</h3>
          #bookingsTable(getNorthJettyBookings)#
					
					<h3>#language.SouthJetty#</h3>
          #bookingsTable(getSouthJettyBookings)#
--->
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

</cfoutput>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
