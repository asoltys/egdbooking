<cfif lang eq "eng" OR (IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true)>
	<cfset language.PWGSC = "PWGSC">
	<cfset language.pacificRegion = "Pacific Region">
	<cfset language.esqGravingDock = "Esquimalt Graving Dock">
	<cfset language.esqGravingDockCaps = "ESQUIMALT GRAVING DOCK">
	<cfset language.submit = "submit">
	<cfset language.cancel = "Cancel">
	<cfset language.admin = "Admin">
	<cfset language.confirm = "Confirm">
	<cfset language.drydock = "Drydock">
	<cfset language.jetty = "Jetty">
	<cfset language.northLandingWharf = "North Landing Wharf">
	<cfset language.southJetty = "South Jetty">
	<cfset language.back = "Back">
	<cfset language.vessel = "Vessel">
	<cfset language.status = "Status">
	<cfset language.tentative = "tentative">
	<cfset language.pending = "pending">
	<cfset language.confirmed = "confirmed">
	<cfset language.bookings = "Bookings">
	<cfset language.booking = "Booking">
	<cfset language.calendar = "This calendar provides a day by day availability summary for the Esquimalt Graving Dock">
	<cfset language.calendars = "calendars">
	<cfset language.dateform = "(MM/DD/YYYY)">
	<cfset language.welcomePage = "Welcome Page">
	<cfset language.login = "Login">
	<cfset language.masterKeywords = "Esquimalt Graving Dock, EGD, Booking Request">
	<cfset language.masterSubjects = "Wharfs; Water Transport; Ships; Ferries; Pleasure Craft; Vessels; Maintenance; Management">
  <cfset language.dateSelect = "Date Selection" />
  <cfset language.year = "Year" />
  <cfset language.month = "Month" />
<cfelse>
	<cfset language.PWGSC = "TPSGC">
	<cfset language.pacificRegion = "R&eacute;gion du Pacifique">
	<cfset language.esqGravingDock = "Cale s&egrave;che d'Esquimalt">
	<cfset language.esqGravingDockCaps = "CALE S&Eacute;CHE D'ESQUIMALT">
	<cfset language.submit = "Soumettre">
	<cfset language.cancel = "Annuler">
	<cfset language.admin = "Admin">
	<cfset language.confirm = "Confirmer">
	<cfset language.drydock = "Cale s&egrave;che">
	<cfset language.jetty = "Jet&eacute;e">
	<cfset language.northLandingWharf = "Quai de d&eacute;barquement nord">
	<cfset language.southJetty = "Jet&eacute;e sud">
	<cfset language.back = "Retour">
	<cfset language.vessel = "Navire">
	<cfset language.status = "&Eacute;tat">
	<cfset language.tentative = "provisoire">
	<cfset language.pending = "en traitement">
	<cfset language.confirmed = "confirm&eacute;">
	<cfset language.bookings = "R&eacute;servations">
	<cfset language.booking = "R&eacute;servation">
	<cfset language.calendar = "Ce calendrier offre un r&eacute;sum&eacute; au jour le jour de disponibilit&eacute; pour le Cale s&egrave;che d'Esquimalt">
	<cfset language.calendars = "calendriers">
	<cfset language.dateform = "(MM/JJ/AAAA)">
	<cfset language.welcomePage = "Page de bienvenue">
	<cfset language.login = "Ouvrir la session">
	<cfset language.masterKeywords = "Cale s&egrave;che d'Esquimalt, CSE, Demande de r&eacute;servation">
	<cfset language.masterSubjects = "Quai; Transport maritime; Navire; Traversier; Bateau de plaisance; Embarcation; Entretien; Gestion">
  <cfset language.dateSelect = "Choix de la date" />
  <cfset language.year = "Ann&eacute;e" />
  <cfset language.month = "Mois" />
</cfif>

<cfif lang EQ 'eng'>
  <cfset language.bookingHomeButton = "Booking Home">
  <cfset language.drydockCalendar = "Drydock Calendar">
  <cfset language.jettyCalendar = "Jetties Calendar">
  <cfset language.requestBooking = "Request Booking">
  <cfset language.editProfileButton = "Edit Profile">
  <cfset language.help = "Help">
  <cfset language.bookingsSummary = "Bookings Summary">
  <cfset language.logoutButton = "Logout">
<cfelse>
  <cfset language.bookingHomeButton = "Accueil - R&eacute;servation">
  <cfset language.drydockCalendar = "Calendrier de la cale s&egrave;che">
  <cfset language.jettyCalendar = "Calendrier des jet&eacute;es">
  <cfset language.requestBooking = "Pr&eacute;senter une r&eacute;servation">
  <cfset language.editProfileButton = "Modifier le profil">
  <cfset language.help = "Aide">
  <cfset language.bookingsSummary = "R&eacute;sum&eacute; des R&eacute;servations">
  <cfset language.logoutButton = "Fermer la session">
</cfif>

<cfif lang EQ "eng">
	<cfset language.phone = "Phone">
	<cfset language.fax = "Fax">
	<cfset language.emailAddress = "Email">
	<cfset language.or = "or">
	<cfset language.acrobatrequired = '<p>If you have a <acronym title="Portable Document Format">PDF</acronym> software reader, you will be able to view, print, or download these documents. </p>

	<p>If you do not have a <acronym title="Portable Document Format">PDF</acronym> software reader, you can download and install any one of these free <acronym title="Portable Document Format">PDF</acronym> software programs below:</p>

    <ul>

		<li><a href="http://get.adobe.com/reader/">Adobe Reader</a></li>

		<li><a href="http://www.foxitsoftware.com/Secure_PDF_Reader/">Foxit Reader</a></li>

		<li><a href="http://www.foolabs.com/xpdf/">xPDF Reader</a></li>

		<li><a href="http://www.visagesoft.com/products/pdfreader/">xPERT PDF Reader</a></li>

	</ul>

	<p>If you prefer to convert <acronym title="Portable Document Format">PDF</acronym> documents to <acronym title="HyperText Markup Language">HTML</acronym>, Adobe offers <a href="http://www.adobe.com/designcenter/tutorials/acr7at_savepdfas/">conversion tools</a>.</p>

	<p>If the <acronym title="Portable Document Format">PDF</acronym> document is not accessible to you, or if you have difficulty downloading forms on this Web site, please <a href="http://www.tpsgc-pwgsc.gc.ca/pac/cse-egd/cn-cu-eng.html">contact <acronym title="Esquimalt Graving Dock">EGD</acronym></a> for assistance.</p>'>
	<cfset language.pdf = "Portable Document Format">
	<cfset language.kb = "<acronym title=""Kilo Bytes"">KB</acronym>">
<cfelse>
	<cfset language.phone = "T&eacute;l&eacute;phone">
	<cfset language.fax = "Fac-simil&eacute;">
	<cfset language.emailAddress = "Adresse de courriel">
	<cfset language.or = "ou">
	<cfset language.acrobatrequired = '<p>Si vous disposez d''un lecteur <acronym title="Format de document portable">PDF</acronym>, vous pourrez visionner, imprimer et t&eacute;l&eacute;charger les formulaires. </p>

	<p>Si vous ne disposez pas d''un lecteur <acronym title="Format de document portable">PDF</acronym>, vous pouvez t&eacute;l&eacute;charger et installer un des lecteurs ci-apr&egrave;s. </p>

	<ul>

		<li><a href="http://get.adobe.com/fr/reader/"><span xml:lang="en" lang="en">Adobe Reader</span></a></li>        

		<li><a href="http://www.foxitsoftware.com/Secure_PDF_Reader/"><span xml:lang="en" lang="en">Foxit Reader</span></a> <em>(disponible en anglais seulement)</em></li>        

		<li><a href="http://www.foolabs.com/xpdf/"><span xml:lang="en" lang="en">xPDF Reader</span></a> <em>(disponible en anglais seulement)</em></li>        

		<li><a href="http://www.visagesoft.com/products/pdfreader/"><span xml:lang="en" lang="en">xPERT PDF Reader</span></a> <em>(disponible en anglais seulement)</em></li>        

	</ul>

	<p>Si vous pr&eacute;f&eacute;rez convertir des documents <acronym title="Format de document portable">PDF</acronym> en format <acronym title="HyperText Markup Language">HTML</acronym>, diff&eacute;rents <a href="http://www.adobe.com/designcenter/tutorials/acr7at_savepdfas/">outils de conversion</a> (<em>disponible en anglais seulement</em>) Adobe existent.</p>

	<p>Si vous ne pouvez acc&eacute;der aux formulaires ou si vous avez de la difficult&eacute; &agrave; t&eacute;l&eacute;charger des formulaires du site, veuillez <a href="http://www.tpsgc-pwgsc.gc.ca/pac/cse-egd/cn-cu-fra.html">contactez <acronym title="Cale s&egrave;che d''Esquimalt">CSE</acronym></a> pour obtenir de l''aide.</p>'>
	<cfset language.pdf = "Format de Document Portable">
	<cfset language.kb = "<acronym title=""kilooctets"">Ko</acronym>">
</cfif>
