<cfif lang EQ "eng">
	<cfset language.vesselDetail = "Vessel Details">
	<cfset language.keywords = language.masterKeywords & ", Vessel details">
	<cfset language.description = "Retrieves information for a given vessel.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.detailsFor = "Details for">
	<cfset language.days = "days">
	<cfset language.editVessel = "Edit Vessel">
	<cfset language.deleteVessel = "Delete Vessel">
	<cfset language.company = "Company">
	<cfset language.tonnes = "tonnes">
	<cfset language.anon = "Anonymous">
	<cfset language.yes = "Yes">
	<cfset language.no = "No">
<cfelse>
	<cfset language.vesselDetail = "D&eacute;tails concernant le navire">
	<cfset language.keywords = language.masterKeywords & ", D&eacute;tails concernant le navire">
	<cfset language.description = "R&eacute;cup&eacute;ration de renseignements sur un navire pr&eacute;cis.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.detailsFor = "D&eacute;tails pour">
	<cfset language.days = "jours">
	<cfset language.editVessel = "Modifier le navire">
	<cfset language.deleteVessel = "Supprimer le navire">
	<cfset language.company = "Entreprise">
	<cfset language.tonnes = "tonnes">
	<cfset language.anon = "Anonyme">
	<cfset language.yes = "Oui">
	<cfset language.no = "Non">
</cfif>

<cfoutput>

<cfquery name="readonlycheck" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT ReadOnly
	FROM Users
	WHERE UID = <cfqueryparam value="#Session.UID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfloop query="readonlycheck">
	<cfset Session.ReadOnly = ReadOnly />
</cfloop>
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfif isDefined("form.VNID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfif NOT IsDefined('url.VNID') OR NOT IsNumeric(url.VNID)>
	<cflocation addtoken="no" url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">
</cfif>

<cflock timeout="60" throwontimeout="No" type="exclusive" scope="session">
	<cfset Session.Flow.VNID = URL.VNID>
</cflock>

<cfquery name="getVesselDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Vessels.*, Companies.Name AS CompanyName, Companies.CID
	FROM  Vessels INNER JOIN Companies ON Vessels.CID = Companies.CID
	WHERE VNID = <cfqueryparam value="#url.VNID#" cfsqltype="cf_sql_integer" />
	AND Vessels.deleted = 0
</cfquery>

<cfsavecontent variable="head">
	<meta name="dcterms.title" content="#language.detailsFor# #getVesselDetail.Name# - #getVesselDetail.Name# - #language.esqGravingDock# - #language.PWGSC#" />
	<meta name="keywords" content="#language.keywords#" />
	<meta name="description" content="#language.description#" />
	<meta name="dcterms.subject" scheme="gccore" content="#language.subjects#" />
  <title>#language.detailsFor# #getVesselDetail.Name# - #getVesselDetail.Name# - #language.esqGravingDock# - #language.PWGSC#</title>
</cfsavecontent>

<cfhtmlhead text="#head#" />

<cfif getVesselDetail.recordCount EQ 0>
	<cflocation addtoken="no" url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">
</cfif>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			</CFIF>
      <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.bookingHome#</a> &gt;
			#language.detailsFor# #getVesselDetail.Name#
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					#language.detailsFor# #getVesselDetail.Name#
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

					<CFINCLUDE template="#RootDir#includes/user_menu.cfm">

          <cfif structKeyExists(session, 'vessel_edit_success')>
            <div class="option4">
              <strong>The vessel has been edited successfully!</strong>
            </div>
            <cfset structDelete(session, 'vessel_edit_success')>
          </cfif>

					<table class="details">
						<tr>
							<th id="vessel">#language.vessel#:</th>
							<td headers="vessel">#getVesselDetail.name#</td>
						</tr>
						<tr>
							<th id="Company">#language.Company#:</th>
							<td headers="Company">#getVesselDetail.companyname#</td>
						</tr>
						<tr>
							<th id="Length">#language.Length#:</th>
							<td headers="Length">#getVesselDetail.length# m</td>
						</tr>
						<tr>
							<th id="Width">#language.Width#:</th>
							<td headers="Width">#getVesselDetail.width# m</td>
						</tr>
						<tr>
							<th id="BlockSetup">#language.BlockSetup#:</th>
							<td headers="BlockSetup">#getVesselDetail.blocksetuptime# #language.days#</td>
						</tr>
						<tr>
							<th id="BlockTeardown">#language.BlockTeardown#:</th>
							<td headers="BlockTeardown">#getVesselDetail.blockteardowntime# #language.days#</td>
						</tr>
						<tr>
							<th id="LloydsID">#language.LloydsID#:</th>
							<td headers="LloydsID">#getVesselDetail.lloydsid#</td>
						</tr>
						<tr>
							<th id="Tonnage">#language.Tonnage#:</th>
							<td headers="Tonnage">#getVesselDetail.tonnage# #language.tonnes#</td>
						</tr>
						<tr>
							<th id="anon">#language.anon#:</th>
							<td headers="anon"><cfif getVesselDetail.anonymous>#language.yes#<cfelse>#language.no#</cfif></td>
						</tr>
					</table>

					<div class="buttons">
						<cfif #Session.ReadOnly# NEQ "1">
						<a href="#RootDir#reserve-book/naviremod-vesseledit.cfm?lang=#lang#&amp;VNID=#url.VNID#" class="textbutton">#language.EditVessel#</a>
						<a href="#RootDir#reserve-book/naviresup-vesseldel.cfm?lang=#lang#&amp;VNID=#url.VNID#" class="textbutton">#language.DeleteVessel#</a>
						</cfif>
					</div>

			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

</cfoutput>
