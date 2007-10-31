<cfinclude template="#RootDir#includes/bookingInfoVariables.cfm">
<cfif lang EQ "e">
	<cfset language.title = "Edit Booking">
	<cfset language.keywords = language.masterKeywords & ", Edit Booking">
	<cfset language.description = "Refers user to contact the administration for editing a booking.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.changeForm = "Tentative Vessel and Change Booking Form">
	<cfset language.explanation = "Bookings cannot be edited online.  If you wish to edit your booking request details, please inform the Esquimalt Graving Dock via phone, fax or email, and mail or fax a hard copy of the Tentative Vessel and Booking Change Form.">
	<cfset language.phone = "Phone">
	<cfset language.fax = "Fax">
	<cfset language.emailAddress = "Email">
	<cfset language.or = "or">
	<cfset language.acrobatrequired = 'The following file requires <A href="http://www.adobe.com/products/acrobat/readstep2_allversions.html" target="_blank">Adobe Acrobat Reader</A> to be installed.  The links will open in a new window.'>
	<cfset language.mail = "Mailing Address">
	<cfset language.mailing = "Operations Manager<br>Esquimalt Graving Dock<br>825 Admirals Road<br>Esquimalt, BC<br>V9A 2P1<br>Canada">
<cfelse>
	<cfset language.title = "Modification de r&eacute;servation">
	<cfset language.keywords = language.masterKeywords & ", Modification de r&eacute;servation">
	<cfset language.description = "Invite l'utilisateur à communiquer avec l'administration pour modifier une réservation.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.changeForm = "Formulaire de r&eacute;servation provisoire pour les navires et les modifications">
	<cfset language.explanation = "Les réservations ne peuvent être modifiées en ligne. Si vous voulez modifier les renseignements de votre demande de réservation, veuillez en aviser la Cale sèche d'Esquimalt par téléphone, fax ou courriel, puis faites parvenir par courrier traditionnel ou par fax une copie papier du formulaire de modification d'une réservation.">
	<cfset language.phone = "T&eacute;l&eacute;phone">
	<cfset language.fax = "Fac-simil&eacute;">
	<cfset language.emailAddress = "Adresse de courriel">
	<cfset language.or = "ou">
	<cfset language.acrobatrequired = 'Il faut le logiciel <A href="http://www.adobe.com/products/acrobat/readstep2_allversions.html" target="_blank">Adobe Acrobat Reader</A> pour le fichier suivant. Le lien ouvrira une nouvelle fenêtre.'>
	<cfset language.mail = "Adresse postale">
	<cfset language.mailing = "Directeur des op&eacute;rations<br>Cale s&egrave;che d'Esquimalt<br>825 Admirals Road<br>Esquimalt (C.-B.)<br>V9A 2P1<br>Canada">
</cfif>

<cfoutput>
<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.title#"">
<meta name=""keywords"" lang=""eng"" content=""#language.keywords#"">
<meta name=""description"" lang=""eng"" content=""#language.description#"">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""#language.subjects#"">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.title#</title>
">

<CFPARAM name="url.referrer" default="Booking Home">
<CFIF url.referrer eq "Details For">
	<CFSET returnTo = "#RootDir#text/common/getDetail.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#text/booking/booking.cfm">
</CFIF>

<cfif isDefined("url.date")>
	<cfset variables.dateValue = "&date=#url.date#">
<cfelse>
	<cfset variables.dateValue = "">
</cfif>

<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Bookings.BookingID,
			StartDate, EndDate,
			Docks.Status AS DStatus, Jetties.Status AS JStatus,
			Vessels.Name AS VesselName,
			Vessels.CompanyID,
			Companies.Name AS CompanyName
	FROM	Bookings
			LEFT JOIN	Docks ON Bookings.BookingID = Docks.BookingID
			LEFT JOIN	Jetties ON Bookings.BookingID = Jetties.BookingID
			INNER JOIN	Vessels ON Bookings.VesselID = Vessels.vesselID
			INNER JOIN	Companies ON Vessels.CompanyID = Companies.CompanyID
	WHERE	Bookings.BookingID = #url.bookingid#
			AND Bookings.Deleted = '0'
			AND Vessels.Deleted = '0'
</cfquery>

<cfinclude template="#RootDir#includes/header-#lang#.cfm">

<div class="breadcrumbs">
	<a href="http://www.pwgsc.gc.ca/text/home-#lang#.html">#language.PWGSC#</a> &gt;
	#language.PacificRegion# &gt;
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-#lang#.html">#language.EsqGravingDock#</a> &gt;
	<a href="#RootDir#text/booking-#lang#.cfm">#language.Booking#</A> &gt;
		<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
		<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">#language.Admin#</A> &gt;
	<CFELSE>
		<a href="#RootDir#text/booking/booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
	</CFIF>
	#language.title#
</div>

<div class="main">

<h1>#language.title#</h1>
</cfoutput>
<cfinclude template="#RootDir#includes/user_menu.cfm"><br>

<!------------------------------------------------------------------------------------------------------------>
<cfoutput>
<div align="left">#language.explanation#</div>
<br>
<div align="left">#language.acrobatRequired#</div>
<br>
<a href="../forms/Tentative_ChangeForm.pdf" target="pdf" title="#language.changeForm#">#language.changeForm# [PDF 5.51 KB]</a>
<br>
<cfset emailSubject = "#getbooking.CompanyName# editing booking for #trim(getbooking.VesselName)# from #LSDateFormat(getbooking.StartDate, 'mmm d, yyyy')# to #LSDateFormat(getbooking.EndDate, 'mmm d, yyyy')#">
<div align="left">
	<br>#language.phone#: (250) 363-3879  #language.or#  (250) 363-8056
	<br>#language.fax#: (250) 363-8059
	<cfif ListLen(#variables.adminEmail#) EQ 1><br>#language.emailAddress#:  <a href="mailto:#Variables.AdminEmail#?subject=#emailSubject#">#Variables.AdminEmail#</a>
	<cfelse>
	<table>
		<tr><td align="left">#language.emailAddress#:</td><td><a href="mailto:#ListGetAt(variables.adminEmail, 1)#?subject=#emailSubject#">#ListGetAt(variables.adminEmail, 1)#</a></td></tr>
		<cfset variables.emailList = ListDeleteAt(#variables.adminEmail#, 1)>
		<cfloop list="#Variables.emailList#" index="email"><tr><td>&nbsp;</td><td><a href="mailto:#email#?subject=#emailSubject#">#email#</a></td></tr></cfloop>
	</table>
	</cfif>
	<br>#language.mail#:
	<br><div style="padding-left:25px">#language.mailing#</div>
</div>
<br>
<div align="center">
	<input type="button" onClick="self.location.href='#RootDir#text/common/getBookingDetail.cfm?lang=#lang#&amp;bookingID=#url.bookingID#&amp;referrer=#URLEncodedFormat(url.referrer)##variables.dateValue#';" class="textbutton" value="#language.Back#">
</div>

</cfoutput>
</div>

<cfinclude template="#RootDir#includes/footer-#lang#.cfm">