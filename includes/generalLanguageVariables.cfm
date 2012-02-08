<cfif lang eq "eng" OR (IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true)>
	<cfset language.PWGSC = "PWGSC">
	<cfset language.pacificRegion = "Pacific Region">
	<cfset language.esqGravingDock = "Esquimalt Graving Dock">
	<cfset language.esqGravingDockCaps = "ESQUIMALT GRAVING DOCK">
	<cfset language.submit = "Submit">
	<cfset language.cancel = "Cancel">
	<cfset language.admin = "Admin">
	<cfset language.confirm = "Confirm">
	<cfset language.drydock = "Drydock">
	<cfset language.jetty = "Jetty">
	<cfset language.northLandingWharf = "North Landing Wharf">
	<cfset language.southJetty = "South Jetty">
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
	<cfset language.dateformexplanation = "Month, Day, Year">
	<cfset language.welcomePage = "Welcome Page">
	<cfset language.login = "Login">
	<cfset language.masterKeywords = "Esquimalt Graving Dock, EGD, Booking Request">
	<cfset language.masterSubjects = "Wharfs; Water Transport; Ships; Ferries; Pleasure Craft; Vessels; Maintenance; Management">
  <cfset language.dateSelect = "Date Selection" />
  <cfset language.year = "Year" />
  <cfset language.month = "Month" />
  <cfset language.acknowledged = "I have read and acknowledged this notice" />
  <cfset language.acknowledgement_received = "Acknowledgement received.  You can view the notice at any time by visiting the <a href='#RootDir#reserve-book/avis-notices.cfm'>Notices</a> page" />
  <cfset language.notices = "Notices" />
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
	<cfset language.dateformexplanation = "Mois, Jour, Ann&eacute;e">
	<cfset language.welcomePage = "Page de bienvenue">
	<cfset language.login = "Ouvrir la session">
	<cfset language.masterKeywords = "Cale s&egrave;che d'Esquimalt, CSE, Demande de r&eacute;servation">
	<cfset language.masterSubjects = "Quai; Transport maritime; Navire; Traversier; Bateau de plaisance; Embarcation; Entretien; Gestion">
  <cfset language.dateSelect = "Choix de la date" />
  <cfset language.year = "Ann&eacute;e" />
  <cfset language.month = "Mois" />
  <cfset language.acknowledged = "J'ai lu et reconnu cet avis" />
  <cfset language.acknowledgement_received = "Remerciements reçus. Vous pouvez consulter l'avis en tout temps en visitant <a href='#RootDir#reserve-book/avis-notices.cfm'>la page des avis.</a>" />
  <cfset language.notices = "Avis" />
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

<cfif lang EQ 'eng'>
	<cfset language.currentCompany = "You are currently looking at details for: ">
	<cfset language.otherCompanies = "Other companies:">
	<cfset language.awaitingApproval = "Awaiting approval:">
	<cfset language.addVessel = "Add Vessel">
	<cfset language.bookingForms = "Booking Forms">
	<cfset language.viewTariff = "View Tariffs">
	<cfset language.agent = "Agent">
	<cfset language.administrator = "Administrator">
	<cfset language.welcome = "Welcome">
	<cfset language.none = "None">
	<cfset language.allBookings = "All Bookings">
	<cfset language.pending_cancelling = "pending cancelling">
	<cfset language.cancelling = "cancelling">
  <cfset language.confirming = "confirming">
  <cfset language.bookingForms = "Booking Forms">
	<cfset language.viewTariff = "View Tariffs">
	<cfset language.agent = "Agent">
	<cfset language.administrator = "Administrator">
	<cfset language.none = "None">
	<cfset language.archivedBookings = "Booking Archive">
	<cfset language.returnTo = "Back to Booking Home">
  <cfset language.mandatoryForms = "Mandatory Forms" />
<cfelse>
	<cfset language.currentCompany = "Vous regardez les renseignements portant sur :">
	<cfset language.otherCompanies = "Autres entreprises">
	<cfset language.awaitingApproval = "En attente d'approbation&nbsp;:">
	<cfset language.addVessel = "Ajout d'un navire">
	<cfset language.bookingForms = "Formulaires de r&eacute;servation">
	<cfset language.viewTariff = "Consulter les tarifs">
	<cfset language.agent = "Agent">
	<cfset language.administrator = "Administrateur">
	<cfset language.welcome = "Bienvenue">
	<cfset language.none = "Aucun">
	<cfset language.allBookings = "Toutes les r servations">
	<cfset language.pending_cancelling = "en attendant l'annulation">	
	<cfset language.cancelling = "annulation">
	<cfset language.confirming = "confirmation ">
	<cfset language.bookingForms = "Formulaires de r&eacute;servation">
	<cfset language.viewTariff = "Consulter les tarifs">
	<cfset language.agent = "Agent">
	<cfset language.administrator = "Administrateur">
	<cfset language.none = "Aucun">
	<cfset language.archivedBookings = "Archives des r&eacute;servations">
	<cfset language.returnTo = "Retour &agrave; Accueil&nbsp;- R&eacute;servation">
  <cfset language.mandatoryForms = "Formulaires obligatoires" />
</cfif>

<cfif lang EQ "eng">
	<cfset language.newBooking = "Submit Drydock Booking Information">
	<cfset language.keywords = language.masterKeywords & ", Drydock Booking Information">
	<cfset language.description = "Allows user to submit a new booking request, drydock section.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.dblBookingError = "has already been booked from">
	<cfset language.to = "to">
	<cfset language.theVessel = "The vessel">
	<cfset language.tooLarge = "is too large for the dry dock">
	<cfset language.bookingConflicts = "The submitted booking request conflicts with other bookings.  The booking will be placed on a wait list if you choose to continue. Please confirm the following information.">
	<cfset language.bookingAvailable = "The requested time is available.  Please confirm the following information.">
	<cfset language.new = "New Booking">
	<cfset language.requestedStatus = "Requested Status">
	<cfset language.tplbookingError = "already has a booking for">
<cfelse>
	<cfset language.newBooking = "Pr&eacute;sentation des renseignements pour la r&eacute;servation de la cale s&egrave;che">
	<cfset language.keywords = language.masterKeywords & ", renseignements pour la r&eacute;servation de la cale s&egrave;che">
	<cfset language.description = "Permet &agrave; l'utilisateur de pr&eacute;senter une nouvelle demande de r&eacute;servation sur le site Web de la cale s&egrave;che d'Esquimalt - section de la cale s&egrave;che.">
	<cfset language.subjects = language.masterSubjects & "">
	<cfset language.dblBookingError = "fait d&eacute;j&agrave; l'objet d'une r&eacute;servation du">
	<cfset language.to = "au">
	<cfset language.theVessel = "Les dimensions du navire">
	<cfset language.tooLarge = "sont sup&eacute;rieures &agrave; celles de la cale s&egrave;che.">
	<cfset language.bookingConflicts = "La demande de r&eacute;servation pr&eacute;sent&eacute;e entre en conflit avec d'autres r&eacute;servations. La demande sera inscrite sur une liste d'attente si vous d&eacute;cidez de continuer. Veuillez confirmer les renseignements suivants.">
	<cfset language.bookingAvailable = "La p&eacute;riode demand&eacute;e est libre. Veuillez confirmer les renseignements suivants.">
	<cfset language.new = "Nouvelle r&eacute;servation">
	<cfset language.requestedStatus = "&Eacute;tat demand&eacute;">
	<cfset language.tplbookingError = "a d&eacute;j&agrave; une r&eacute;servation pour :">
</cfif>
