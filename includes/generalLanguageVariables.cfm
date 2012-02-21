<cfinclude template="#RootDir#includes/errorMessages.cfm">
<cfif lang eq "eng" OR (IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true)>
	<cfset language.PWGSC = "PWGSC">
	<cfset language.egd = "EGD">
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
	<cfset language.sitemap = "Site Map">
	<cfset language.contact = "Contact">
  <cfset language.resources = "<acronym title=""Esquimalt Graving Dock"">#language.egd#</acronym> Resources" />
	<cfset language.masterKeywords = "Esquimalt Graving Dock, EGD, Booking Request">
	<cfset language.masterSubjects = "Wharfs; Water Transport; Ships; Ferries; Pleasure Craft; Vessels; Maintenance; Management">
  <cfset language.dateSelect = "Date Selection" />
  <cfset language.year = "Year" />
  <cfset language.month = "Month" />
  <cfset language.acknowledged = "I have read and acknowledged this notice" />
  <cfset language.acknowledgement_received = "Acknowledgement received.  You can view the notice at any time by visiting the <a href='#RootDir#reserve-book/avis-notices.cfm'>Notices</a> page" />
  <cfset language.notices = "Notices" />
  <cfset language.calendarInstructions = "Use the control and arrow keys to navigate the calendar" />
  <cfset language.detailsFor = "Details for:" />
<cfelse>
	<cfset language.PWGSC = "TPSGC">
	<cfset language.egd = "CSE">
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
	<cfset language.sitemap = "Plan du site">
  <cfset language.contact = "Contactez" />
  <cfset language.resources = "Ressources <acronym title=""Cale s&egrave;che d'Esquimalt"">CSE</acronym>" />
	<cfset language.masterKeywords = "Cale s&egrave;che d'Esquimalt, CSE, Demande de r&eacute;servation">
	<cfset language.masterSubjects = "Quai; Transport maritime; Navire; Traversier; Bateau de plaisance; Embarcation; Entretien; Gestion">
  <cfset language.dateSelect = "Choix de la date" />
  <cfset language.year = "Ann&eacute;e" />
  <cfset language.month = "Mois" />
  <cfset language.acknowledged = "J'ai lu et reconnu cet avis" />
  <cfset language.acknowledgement_received = "Remerciements reçus. Vous pouvez consulter l'avis en tout temps en visitant <a href='#RootDir#reserve-book/avis-notices.cfm'>la page des avis.</a>" />
  <cfset language.notices = "Avis" />
  <cfset language.calendarInstructions = "Utilisez les touches de contr&##244;le et de la fl&##232;che pour naviguer dans le calendrier" />
  <cfset language.detailsFor = "D&egrave;tails pour&nbsp:" />
</cfif>

<cfif lang EQ 'eng'>
  <cfset language.bookingHome = "Booking Home">
  <cfset language.drydockCalendar = "Drydock Calendar">
  <cfset language.jettyCalendar = "Jetties Calendar">
  <cfset language.requestBooking = "Request Booking">
  <cfset language.editProfileButton = "Edit Profile">
  <cfset language.help = "Help">
  <cfset language.bookingsSummary = "Bookings Summary">
  <cfset language.logoutButton = "Logout">
<cfelse>
  <cfset language.bookingHome = "Accueil - R&eacute;servation">
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
	<cfset language.pdf = "Portable Document Format">
	<cfset language.kb = "<acronym title=""Kilo Bytes"">KB</acronym>">
<cfelse>
	<cfset language.phone = "T&eacute;l&eacute;phone">
	<cfset language.fax = "Fac-simil&eacute;">
	<cfset language.emailAddress = "Adresse de courriel">
	<cfset language.or = "ou">
	<cfset language.pdf = "Format de Document Portable">
	<cfset language.kb = "<acronym title=""kilooctets"">Ko</acronym>">
</cfif>

<cfif lang EQ 'eng'>
	<cfset language.currentCompany = "You are currently looking at details for: ">
	<cfset language.otherCompanies = "Other companies:">
	<cfset language.awaitingApproval = "Awaiting approval:">
	<cfset language.addVessel = "Add Vessel">
	<cfset language.bookingForms = "Booking Forms">
	<cfset language.agent = "Agent">
	<cfset language.administrator = "Administrator">
	<cfset language.welcome = "Welcome">
	<cfset language.none = "None">
	<cfset language.allBookings = "All Bookings">
	<cfset language.pending_cancelling = "pending cancellation">
  <cfset language.confirming = "pending confirmation">
  <cfset language.bookingForms = "Booking Forms">
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
	<cfset language.agent = "Agent">
	<cfset language.administrator = "Administrateur">
	<cfset language.welcome = "Bienvenue">
	<cfset language.none = "Aucun">
	<cfset language.allBookings = "Toutes les r servations">
	<cfset language.pending_cancelling = "en attendant l'annulation">	
	<cfset language.confirming = "confirmation ">
	<cfset language.bookingForms = "Formulaires de r&eacute;servation">
	<cfset language.agent = "Agent">
	<cfset language.administrator = "Administrateur">
	<cfset language.none = "Aucun">
	<cfset language.archivedBookings = "Archives des r&eacute;servations">
	<cfset language.returnTo = "Retour &agrave; Accueil&nbsp;- R&eacute;servation">
  <cfset language.mandatoryForms = "Formulaires obligatoires" />
</cfif>

<cfif lang EQ "eng">
	<cfset language.newBooking = "Submit Drydock Booking Information">
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

<cfif lang eq "eng" OR (IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true)>
  <cfset language.required = "Required field" />
  <cfset language.requiredFields = "<p>Required fields are marked with an asterisk (<abbr class=""required"" title=""#language.required#"">*</abbr>).</p>" />
	<cfset language.Agent = "Agent">
	<cfset language.startDate = "Start Date">
	<cfset language.endDate = "End Date">
	<cfset language.company = "Company">
	<cfset language.vessel = "Vessel">
	<cfset language.bookingRequest = "Booking Request">
	<cfset language.enterInfo = "Please enter the dates for your booking.">
	<cfset language.dateInclusive = "<strong>Note: Booking dates are inclusive</strong>; i.e. a three day booking is denoted as from May 1 to May 3.">
	<cfset language.chooseCompany = "choose a company">
	<cfset language.chooseVessel = "choose a vessel">
	<!--- Deprecated --->
	<!---cfset language.startError = "Please enter a start date.">
	<cfset language.endError = "Please enter an end date."--->
<cfelse>
  <cfset language.required = "Champ obligatoire" />
  <cfset language.requiredFields = "<p>Les champs obligatoires sont signal&eacute;s par un ast&eacute;risque (<abbr class=""required"" title=""#language.required#"">*</abbr>).</p>" />
	<cfset language.agent = "Agent">
	<cfset language.startDate = "Date de d&eacute;but">
	<cfset language.endDate = "Date de fin">
	<cfset language.company = "Entreprise">
	<cfset language.vessel = "Navire">
	<cfset language.bookingRequest = "Demande de r&eacute;servation">
	<cfset language.enterInfo = "Veuillez entrer les dates de votre r&eacute;servation.">
	<cfset language.dateInclusive = "Nota : les dates des r&eacute;servations sont inclusives; une r&eacute;servation de trois jours couvrira la p&eacute;riode du 1er mai au 3 mai, par exemple.">
	<cfset language.chooseCompany = "s&eacute;lectionner une entreprise">
	<cfset language.chooseVessel = "s&eacute;lectionner un navire">
	<!---cfset language.startError = "">
	<cfset language.endError = ""--->
</cfif>

<cfif lang EQ "eng">
	<cfset language.addVessel = "Add New Vessel">
	<cfset language.companyName = "Company Name">
	<cfset language.confirmInfo = "Please confirm the following information:">
	<cfset language.boatTooBig = "Note: The ship measurements exceed the maximum dimensions of the dock">
	<cfset language.yes = "Yes">
	<cfset language.no = "No">
	<cfset language.nameError = "Please enter the vessel name.">
<cfelse>
	<cfset language.addVessel = "Ajout d'un nouveau navire">
	<cfset language.companyName = "Raison sociale">
	<cfset language.confirmInfo = "Veuillez confirmer l'information suivante&nbsp;: ">
	<cfset language.boatTooBig = "Note&nbsp;: Les dimensions du navire d&eacute;passent celles de la cale s&egrave;che">
	<cfset language.yes = "Oui">
	<cfset language.no = "Non">
	<cfset language.nameError = "Veuillez entrer le nom du navire.">
</cfif>

<cfif lang eq "eng" OR (IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true)>
	<cfset language.vesselName = "Name">
  <cfset language.lloydsID = "<abbr title='International Maritime Organization'>IMO</abbr> Number">
	<cfset language.length = "Length (m)">
	<cfset language.width = "Width (m)">
	<cfset language.blockSetup = "Block Setup Time">
	<cfset language.blockTeardown = "Block Teardown Time">
	<cfset language.days = "(days)">
	<cfset language.tonnage = "Tonnage">
	<cfset language.anonymous = "Keep this vessel anonymous">
	<cfset language.max = "Max">
	<cfset language.nameError = "Please enter the vessel name.">
    <cfset language.lloydsError = "Please enter the International Maritime Organization (I.M.O.) number."> 
	<cfset language.lengthError = "Please enter the length in metres.">
	<cfset language.widthError = "Please enter the width in metres.">
	<cfset language.setupError = "Please enter the block setup time in days.">
	<cfset language.teardownError = "Please enter the block teardown time in days.">
	<cfset language.tonnageError = "Please enter the tonnage.">
<cfelse>
	<cfset language.vesselName = "Nom">
	<cfset language.lloydsID = "Code d'identification de la Lloyds">
	<cfset language.length = "Longueur (m)">
	<cfset language.width = "Largeur (m)">
	<cfset language.blockSetup = "Temps d'installation des tins">
	<cfset language.blockTeardown = "Temps de retrait des tins">
	<cfset language.days = "(jours)">
	<cfset language.tonnage = "Tonnage">
	<cfset language.anonymous = "Garder ce navire anonyme">
	<cfset language.max = "Maximum">
	<cfset language.nameError = "Veuillez entrer le nom du navire.">
	<cfset language.lloydsError = "Veuillez entrer le code d'identification de la Lloyds.">
	<cfset language.lengthError = "Veuillez entrer la longueur en m&egrave;tres.">
	<cfset language.widthError = "Veuillez entrer la largeur en m&egrave;tres.">
	<cfset language.setupError = "Veuillez entrer un nombre de jours pour pr&eacute;ciser le temps d'installation des tins.">
	<cfset language.teardownError = "Veuillez entrer un nombre de jours pour pr&eacute;ciser le temps de retrait des tins.">
	<cfset language.tonnageError = "Veuillez entrer le tonnage.">
</cfif>

<cfif lang EQ "eng">
	<cfset language.editVessel = "Edit Vessel">
	<cfset language.anonymousWarning = "Anonymous vessels are only anonymous to other companies' users.  The Esquimalt Graving Dock administrators have access to all vessel information regardless of anonymity.">
	<cfset language.notEditVesselDimensions = "You may not edit the vessel dimensions as this vessel currently has confirmed bookings.  To make dimension changes, please contact EGD Administration.">
<cfelse>
	<cfset language.editVessel = "Modifier le navire">
	<cfset language.anonymousWarning = "Les navires anonymes ne sont anonymes qu'aux utilisateurs d'autres entreprises. Les administrateurs de la cale s&egrave;che d'Esquimalt ont acc&egrave;s &agrave; la totalit&eacute; de l'information concernant les navires, peu importe l'anonymat.">
	<cfset language.notEditVesselDimensions = "Vous ne pouvez pas modifier les dimensions du navire, parce que ce dernier fait l'objet de r&eacute;servations confirm&eacute;es. Pour apporter des changements aux dimensions, pri&egrave;re de communiquer avec l'administration de la CSE.">
</cfif>

<cffunction name="decodeHtmlEntity" returntype="String" output="false">
    <cfargument name="Entity" type="String" hint="&##<number>; or &<name>;" />
    <cfset var XmlDoc = XmlParse('<xml>#Arguments.Entity#</xml>') />
    <cfreturn XmlDoc.XmlRoot.XmlText />
</cffunction>

<cfoutput>
<cfsavecontent variable="head">
<script type="text/javascript">
	/* <![CDATA[ */
  var t = { 
    "calendarInstructions": "#decodeHtmlEntity(language.calendarInstructions)#" 
  }
	/* ]]> */
</script>
</cfsavecontent>
<cfhtmlhead text="#head#" />
</cfoutput>

