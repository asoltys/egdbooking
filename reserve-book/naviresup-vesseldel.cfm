<cfif lang EQ "eng">
	<cfset language.deleteVessel = "Delete Vessel">
	<cfset language.keywords = language.masterKeywords & ", Delete Vessel">
	<cfset language.description = "Allows user to delete a vessel.">
	<cfset language.subjects = language.masterSubjects>
	<cfset language.areYouSure = "Are you sure you want to delete">
	<cfset language.delete = "Delete">
	<cfset language.cannotDelete = "cannot be deleted as it is booked for the following dates.  Please cancel all bookings before deleting the vessel.">

<cfelse>
	<cfset language.deleteVessel = "Suppression de navire">
	<cfset language.keywords = language.masterKeywords & ", Suppression de navire">
	<cfset language.description = "Permet &agrave; l'utilisateur de supprimer un navire.">
	<cfset language.subjects = language.masterSubjects>
	<cfset language.areYouSure = "&Ecirc;tes-vous certain de vouloir supprimer ">
	<cfset language.delete = "Supprimer">
	<cfset language.cannotDelete = "ne peut pas &ecirc;tre supprim&eacute; puisqu'il fait l'objet d'une r&eacute;servation pour les dates suivantes. Veuillez annuler toutes les r&eacute;servations avant de supprimer le navire.">

</cfif>

<cfoutput>

<cfsavecontent variable="head">
	<meta name="dcterms.title" content="#language.DeleteVessel# - #language.esqGravingDock# - #language.PWGSC#" />
	<meta name="keywords" content="#language.DeleteVessel#" />
	<meta name="description" content="#language.description#" />
	<meta name="dcterms.subject" scheme="gccore" content="#language.subjects#" />
	<title>#language.DeleteVessel# - #language.esqGravingDock# - #language.PWGSC#</title>
</cfsavecontent>
<cfhtmlhead text="#head#" />

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<script type="text/javascript">
/* <![CDATA[ */
	function SubmitForm(selectedForm) {
		document.forms[selectedForm].submit();
	}
/* ]]> */
</script>

<cfif NOT IsDefined('url.VNID') OR NOT IsNumeric(url.VNID)>
	<cflocation addtoken="no" url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">
</cfif>

<cfquery name="getVesselDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Vessels.VNID, Vessels.Name, Vessels.CID
	FROM  Vessels
	WHERE VNID = <cfqueryparam value="#url.VNID#" cfsqltype="cf_sql_integer" />
	AND Vessels.deleted = 0
</cfquery>

<cfquery name="getVesselDockBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	*
	FROM	Bookings INNER JOIN Vessels ON Vessels.VNID = Bookings.VNID
			INNER JOIN Docks ON Bookings.BRID = Docks.BRID
	WHERE	EndDate >= <cfqueryparam value="#CreateODBCDate(PacificNow)#" cfsqltype="cf_sql_date" /> AND Vessels.VNID = <cfqueryparam value="#url.VNID#" cfsqltype="cf_sql_integer" /> AND Bookings.Deleted = 0
</cfquery>

<cfquery name="getVesselJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	*
	FROM	Bookings INNER JOIN Vessels ON Vessels.VNID = Bookings.VNID
			INNER JOIN Jetties ON Bookings.BRID = Jetties.BRID
	WHERE	EndDate >= <cfqueryparam value="#CreateODBCDate(PacificNow)#" cfsqltype="cf_sql_date" /> AND Vessels.VNID = <cfqueryparam value="#url.VNID#" cfsqltype="cf_sql_integer" /> AND Bookings.Deleted = 0
</cfquery>

<cfif getVesselDetail.recordCount EQ 0>
	<cflocation addtoken="no" url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">
</cfif>

<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
<p class="breadcrumb">
  <cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
  <CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
  <a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
  </CFIF>
  #language.DeleteVessel#
</p>
<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
<div class="colLayout">
<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
  <!-- CONTENT BEGINS | DEBUT DU CONTENU -->
  <div class="center">
    <h1><a name="cont" id="cont">
      <!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
      #language.DeleteVessel#
      <!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
      </a></h1>

    <CFINCLUDE template="#RootDir#includes/user_menu.cfm">

    <cfif getVesselDockBookings.recordCount EQ 0 AND getVesselJettyBookings.recordCount EQ 0>
        <cfloop query="getVesselDetail">
          <p>#language.areYouSure# <strong>#name#</strong>?</p>
          <form id="DelVessel" action="#RootDir#reserve-book/naviresup-vesseldel_action.cfm?lang=#lang#&amp;CID=#CID#" method="post">
            <fieldset>
						<legend>#language.deleteVessel#</legend>
            <div style="text-align:center;">
              <input type="hidden" name="VNID" value="#VNID#" />
              <input type="submit" value="#language.Delete#" class="textbutton" />
            </div>
            </fieldset>
          </form>
        </cfloop>
    <cfelse>
        <p><strong>#getVesselDetail.name#</strong> #language.cannotDelete#</p>

        <cfif getVesselDockBookings.recordCount GT 0>

        <h2>#language.Drydock#</h2>
        <table class="bookings" summary="#language.DrydockTableSummary#">
          <thead>
            <tr>
              <th id="drydock_start_date">#language.Startdate#</th>
              <th id="drydock_end_date">#language.EndDate#</th>
              <th id="drydock_status">#language.Status#</th>
            </tr>
          </thead>

            <tbody>
              <cfloop query="getVesselDockBookings">
                <tr>
                  <td headers="drydock_start_date">#myDateFormat(startDate, request.datemask)#</td>
                  <td headers="drydock_end_date">#myDateFormat(endDate, request.datemask)#</td>
                  <td headers="drydock_status">
                    <cfif status EQ "PT"><em>#language.pending#</em>
                    <cfelseif status EQ "T"><em>#language.tentative#</em>
                    <cfelseif status EQ "C"><em>#language.confirmed#</em></cfif>
                  </td>
                </tr>
              </cfloop>
            </tbody>
          </table>
        </cfif>

        <cfif getVesselJettyBookings.recordCount GT 0>
        <h2>#language.Jetty#</h2>
        <table class="bookings" summary="#language.SJTableSummary#">
          <tr>
            <th id="jetty_start_date">#language.StartDate#</th>
            <th id="jetty_end_date">#language.EndDate#</th>
            <th id="jetty">#language.Jetty#</th>
            <th id="jetty_status">#language.Status#</th>
          </tr>

          <cfloop query="getVesselJettyBookings">
            <tr>
              <td headers="jetty_start_date">#myDateFormat(startDate, request.datemask)#</td>
              <td headers="jetty_end_date">#myDateFormat(endDate, request.datemask)#</td>
              <td headers="jetty">
                <cfif getVesselJettyBookings.NorthJetty EQ 1>
                  #language.NorthLandingWharf#
                <cfelseif getVesselJettyBookings.SouthJetty EQ 1>
                  #language.SouthJetty#
                </cfif>
              </td>
              <td headers="jetty_status">
                <cfif status EQ "PT"><em>#language.pending#</em>
                <cfelseif status EQ "C"><em>#language.confirmed#</em></cfif>
              </td>
            </tr>
          </cfloop>
          </table>
        </cfif>
        <p><a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#&amp;CID=#getVesselDetail.CID#" class="textbutton">#language.returnTo#</a></p>
    </cfif>
  </div>
</cfoutput>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

