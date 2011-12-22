<cfinclude template="#RootDir#includes/bookingInfoVariables.cfm">
<cfif lang EQ "eng">
	<cfset language.title = "Edit Booking">
	<cfset language.keywords = language.masterKeywords & ", Edit Booking">
	<cfset language.description = "Refers user to contact the administration for editing a booking.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.changeForm = "Tentative Vessel and Change Booking Form">
	<cfset language.explanation = "Bookings cannot be edited online.  If you wish to edit your booking request details, please inform the Esquimalt Graving Dock via phone, fax or email, and fax a hard copy of the Tentative Vessel and Booking Change Form.">
	<cfset language.phone = "Phone">
	<cfset language.fax = "Fax">
	<cfset language.emailAddress = "Email">
	<cfset language.or = "or">
	<cfset language.acrobatrequired = '<p>If you have a <acronym title="Portable Document Format">PDF</acronym> software reader, you will be able to view, print, or download these documents. </p>

	<p>If you do not have a <acronym title="Portable Document Format">PDF</acronym> software reader, you can download and install any one of these free <acronym title="Portable Document Format">PDF</acronym> software programs below:</p>

    <ul>

		<li><a href="http://www.adobe.com/products/reader.html">Adobe Reader</a></li>

		<li><a href="http://www.foxitsoftware.com/Secure_PDF_Reader/">Foxit Reader</a></li>

		<li><a href="http://www.foolabs.com/xpdf/">xPDF Reader</a></li>

		<li><a href="http://www.visagesoft.com/products/pdfreader/">xPERT PDF Reader</a></li>

	</ul>

	<p>If you prefer to convert <acronym title="Portable Document Format">PDF</acronym> documents to <acronym title="HyperText Markup Language">HTML</acronym>, Adobe offers <a href="http://www.adobe.com/designcenter/tutorials/acr7at_savepdfas/">conversion tools</a>.</p>

	<p>If the <acronym title="Portable Document Format">PDF</acronym> document is not accessible to you, or if you have difficulty downloading forms on this Web site, please <a href="http://www.tpsgc-pwgsc.gc.ca/pac/cse-egd/cn-cu-eng.html">contact <acronym title="Esquimalt Graving Dock">EGD</acronym></a> for assistance.</p>'>
	<cfset language.pdf = "Portable Document Format">
	<cfset language.kb = "<acronym title=""Kilo Bytes"">KB</acronym>">
<cfelse>
	<cfset language.title = "Modification de r&eacute;servation">
	<cfset language.keywords = language.masterKeywords & ", Modification de r&eacute;servation">
	<cfset language.description = "Invite l'utilisateur &agrave; communiquer avec l'administration pour modifier une r&eacute;servation.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.changeForm = "Formulaire de r&eacute;servation provisoire pour les navires et les modifications">
	<cfset language.explanation = "Les r&eacute;servations ne peuvent &ecirc;tre modifi&eacute;es en ligne. Si vous voulez modifier les renseignements de votre demande de r&eacute;servation, veuillez en aviser la Cale s&egrave;che d'Esquimalt par t&eacute;l&eacute;phone, fax ou courriel, puis faites parvenir par fax une copie papier du formulaire de modification d'une r&eacute;servation.">
	<cfset language.phone = "T&eacute;l&eacute;phone">
	<cfset language.fax = "Fac-simil&eacute;">
	<cfset language.emailAddress = "Adresse de courriel">
	<cfset language.or = "ou">
	<cfset language.acrobatrequired = '<p>Si vous disposez d''un lecteur <acronym title="Format de document portable">PDF</acronym>, vous pourrez visionner, imprimer et t&eacute;l&eacute;charger les formulaires. </p>

	<p>Si vous ne disposez pas d''un lecteur <acronym title="Format de document portable">PDF</acronym>, vous pouvez t&eacute;l&eacute;charger et installer un des lecteurs ci-apr&egrave;s. </p>

	<ul>

		<li><a href="http://www.adobe.com/fr/products/acrobat.html?promoid=BPBLJ"><span xml:lang="en" lang="en">Adobe Reader</span></a></li>        

		<li><a href="http://www.foxitsoftware.com/Secure_PDF_Reader/"><span xml:lang="en" lang="en">Foxit Reader</span></a> <em>(disponible en anglais seulement)</em></li>        

		<li><a href="http://www.foolabs.com/xpdf/"><span xml:lang="en" lang="en">xPDF Reader</span></a> <em>(disponible en anglais seulement)</em></li>        

		<li><a href="http://www.visagesoft.com/products/pdfreader/"><span xml:lang="en" lang="en">xPERT PDF Reader</span></a> <em>(disponible en anglais seulement)</em></li>        

	</ul>

	<p>Si vous pr&eacute;f&eacute;rez convertir des documents <acronym title="Format de document portable">PDF</acronym> en format <acronym title="HyperText Markup Language">HTML</acronym>, diff&eacute;rents <a href="http://www.adobe.com/designcenter/tutorials/acr7at_savepdfas/">outils de conversion</a> (<em>disponible en anglais seulement</em>) Adobe existent.</p>

	<p>Si vous ne pouvez acc&eacute;der aux formulaires ou si vous avez de la difficult&eacute; &agrave; t&eacute;l&eacute;charger des formulaires du site, veuillez <a href="http://www.tpsgc-pwgsc.gc.ca/pac/cse-egd/cn-cu-fra.html">contactez <acronym title="Cale s&egrave;che d''Esquimalt">CSE</acronym></a> pour obtenir de l''aide.</p>'>
	<cfset language.pdf = "format de document portable">
	<cfset language.kb = "<acronym title=""kilooctets"">Ko</acronym>">
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.title# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.title# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFPARAM name="url.referrer" default="Booking Home">
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
			<CFELSE>
				<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
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
				<p>#language.acrobatRequired#</p>
				<ul>
          <cfdirectory action="list" directory="#FileDir#formes-forms/" filter="changement-change-eng.pdf" name="fileCheck"/>
					<li><a href="../formes-forms/changement-change-eng.pdf" title="#language.changeForm#" rel="external">#language.changeForm#</a> <span class="smallFont">(<acronym title="#language.pdf#">PDF</acronym>,&nbsp;#NumberFormat(fileCheck.size / 1024)##language.kb#)</span> <cfif lang NEQ "eng"><em>(disponible en anglais seulement)</em></cfif></li>
				</ul>
				<cfset emailSubject = "#getbooking.CompanyName# editing booking for #trim(getbooking.VesselName)# from #LSDateFormat(getbooking.StartDate, 'mmm d, yyyy')# to #LSDateFormat(getbooking.EndDate, 'mmm d, yyyy')#">
				<p>
					#language.phone#: 250-363-3879  #language.or#  250-363-8056<br />
					#language.fax#: 250-363-8059<br />
					<cfif ListLen(#variables.adminEmail#) EQ 1>#language.emailAddress#:  <a href="mailto:#Variables.AdminEmail#?subject=#emailSubject#">#Variables.AdminEmail#</a>
					<cfelse>
					<table cellpadding="0" cellspacing="0">
						<tr><td>#language.emailAddress#:&nbsp;</td><td><a href="mailto:#ListGetAt(variables.adminEmail, 1)#?subject=#emailSubject#">#ListGetAt(variables.adminEmail, 1)#</a></td></tr>
						<cfset variables.emailList = ListDeleteAt(#variables.adminEmail#, 1)>
						<cfloop list="#Variables.emailList#" index="email"><tr><td>&nbsp;</td><td><a href="mailto:#email#?subject=#emailSubject#">#email#</a></td></tr></cfloop>
					</table>
					</cfif>
        </p>
				<br />
				<div style="text-align:center;">
					<input type="button" onclick="self.location.href='#RootDir#comm/detail-res-book.cfm?lang=#lang#&amp;BRID=#url.BRID#&amp;referrer=#URLEncodedFormat(url.referrer)##variables.dateValue#';" class="textbutton" value="#language.Back#" />
				</div>

				</cfoutput>
			</div>

		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

