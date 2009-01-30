<cfinclude template="#RootDir#includes/vesselInfoVariables.cfm">
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

<cfquery name="readonlycheck" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT ReadOnly
	FROM Users
	WHERE UID = #Session.UID#
</cfquery>
<cfoutput query="readonlycheck">
	<cfset Session.ReadOnly = #ReadOnly#>
</cfoutput>
<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.vesselDetail# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.vesselDetail# - #language.esqGravingDock# - #language.PWGSC#</title>">
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
	WHERE VNID = #url.VNID#
	AND Vessels.deleted = 0
</cfquery>

<cfif getVesselDetail.recordCount EQ 0>
	<cflocation addtoken="no" url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">
</cfif>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			<CFELSE>
				<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			</CFIF>
			#language.vesselDetail#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<cfoutput query="getVesselDetail">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.detailsFor# #Name#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

					<CFINCLUDE template="#RootDir#includes/user_menu.cfm">

          <cfif structKeyExists(session, 'vessel_edit_success')>
            <div class="notice">
              <strong>The vessel has been edited successfully!</strong>
            </div>
            <cfset structDelete(session, 'vessel_edit_success')>
          </cfif>

					<table>
						<tr>
							<td id="vessel">#language.vessel#:</td>
							<td headers="vessel">#name#</td>
						</tr>
						<tr>
							<td id="Company">#language.Company#:</td>
							<td headers="Company">#companyname#</td>
						</tr>
						<tr>
							<td id="Length">#language.Length#:</td>
							<td headers="Length">#length# m</td>
						</tr>
						<tr>
							<td id="Width">#language.Width#:</td>
							<td headers="Width">#width# m</td>
						</tr>
						<tr>
							<td id="BlockSetup">#language.BlockSetup#:</td>
							<td headers="BlockSetup">#blocksetuptime# #language.days#</td>
						</tr>
						<tr>
							<td id="BlockTeardown">#language.BlockTeardown#:</td>
							<td headers="BlockTeardown">#blockteardowntime# #language.days#</td>
						</tr>
						<tr>
							<td id="LloydsID">#language.LloydsID#:</td>
							<td headers="LloydsID">#lloydsid#</td>
						</tr>
						<tr>
							<td id="Tonnage">#language.Tonnage#:</td>
							<td headers="Tonnage">#tonnage# #language.tonnes#</td>
						</tr>
						<tr>
							<td id="anon">#language.anon#:</td>
							<td headers="anon"><cfif anonymous>#language.yes#<cfelse>#language.no#</cfif></td>
						</tr>
					</table>

					<div class="buttons">
						<cfif #Session.ReadOnly# NEQ "1">
						<a href="#RootDir#reserve-book/naviremod-vesseledit.cfm?lang=#lang#&amp;VNID=#url.VNID#" class="textbutton">#language.EditVessel#</a>
						<a href="#RootDir#reserve-book/naviresup-vesseldel.cfm?lang=#lang#&amp;VNID=#url.VNID#" class="textbutton">#language.DeleteVessel#</a>
						</cfif>
					</div>
				</cfoutput>

			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
