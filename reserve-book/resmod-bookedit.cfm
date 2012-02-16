<cfif lang EQ "eng">
	<cfset language.title = "Edit Booking">
	<cfset language.keywords = language.masterKeywords & ", Edit Booking">
	<cfset language.description = "Refers user to contact the administration for editing a booking.">
	<cfset language.subjects = language.masterSubjects & "">
  <cfset language.explanation = "Bookings cannot be edited online.  If you wish to edit your booking request details, please inform the Esquimalt Graving Dock via phone, fax or email, and fax a hard copy of the <em>Tentative Vessel and Booking Change Form</em>.  To receive a copy of the <em>Tentative Vessel and Booking Change Form</em>, contact the booking clerk:">
<cfelse>
	<cfset language.title = "Modification de r&eacute;servation">
	<cfset language.keywords = language.masterKeywords & ", Modification de r&eacute;servation">
	<cfset language.description = "Invite l'utilisateur &agrave; communiquer avec l'administration pour modifier une r&eacute;servation.">
	<cfset language.subjects = language.masterSubjects & "">
  <cfset language.explanation = "Les r&eacute;servations ne peuvent &ecirc;tre modifi&eacute;es en ligne. Si vous voulez modifier les renseignements de votre demande de r&eacute;servation, veuillez en aviser la Cale s&egrave;che d'Esquimalt par t&eacute;l&eacute;phone, fax ou courriel, puis faites parvenir par fax une copie papier du <em>formulaire de modification d'une r&eacute;servation</em>.  Pour recevoir une copie du <em>formulaire de modification d'une r&eacute;servation</em>, communiquer avec le greffier de r&eacute;servation&nbsp;:">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.title# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.title# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFPARAM name="url.referrer" default="#language.bookingHome#">
<CFIF url.referrer eq "Details For">
	<CFSET returnTo = "#RootDir#comm/detail.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#reserve-book/reserve-booking.cfm">
</CFIF>

<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&amp;date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>

<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Bookings.BRID,
			StartDate, EndDate,
			Docks.Status AS DStatus, Jetties.Status AS JStatus,
			Vessels.Name AS VesselName,
			Vessels.CID,
			Companies.Name AS CompanyName
	FROM	Bookings
			LEFT JOIN	Docks ON Bookings.BRID = Docks.BRID
			LEFT JOIN	Jetties ON Bookings.BRID = Jetties.BRID
			INNER JOIN	Vessels ON Bookings.VNID = Vessels.VNID
			INNER JOIN	Companies ON Vessels.CID = Companies.CID
	WHERE	Bookings.BRID = <cfqueryparam value="#url.BRID#" cfsqltype="cf_sql_integer" />
			AND Bookings.Deleted = '0'
			AND Vessels.Deleted = '0'
</cfquery>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			</CFIF>
			#language.title#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<cfoutput>#language.title#</cfoutput>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<cfinclude template="#RootDir#includes/user_menu.cfm">
				<!------------------------------------------------------------------------------------------------------------>
				<cfoutput>
				<p>#language.explanation#</p>
				<cfset emailSubject = "#getbooking.CompanyName# editing booking for #trim(getbooking.VesselName)# from #LSDateFormat(getbooking.StartDate, 'mmm d, yyyy')# to #LSDateFormat(getbooking.EndDate, 'mmm d, yyyy')#">
				<p>
        #language.phone#<cfif lang eq "fra">&nbsp;</cfif>: 250-363-3879  #language.or#  250-363-8056<br />
					#language.fax#<cfif lang eq "fra">&nbsp;</cfif>: 250-363-8059<br />
					#language.emailAddress#<cfif lang eq "fra">&nbsp;</cfif>: 
         <a href="mailto:#Variables.AdminEmail#?subject=#emailSubject#">
           #Variables.AdminEmail#
         </a>
        </p>
				</cfoutput>
			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

