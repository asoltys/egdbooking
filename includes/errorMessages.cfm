<cfif lang eq "eng" OR (IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true)>
	<cfset language.invalidEmailError = "Please check that the email address is valid.">
	<cfset language.unapprovedEmailError = "Your login has not yet been approved.  Please wait until you receive an approval email.">
	<cfset language.incorrectPasswordError = "The password that was entered is incorrect.  Please try again.">
	<cfset language.duplicateVesselError = "A vessel with that name already exists.">
	<cfset language.startTodayError = "The start date can not be set for today.">
	<cfset language.endBeforeStartError = "The Start Date must be before the End Date.">
	<cfset language.pastStartError = "The Start Date can not be in the past.">
	<cfset language.bookingTooShortError = "The minimum booking time is 1 day.">
	<cfset language.needBookingDaysError = "Please enter the number of booking days.">
	<cfset language.futureStartError = "The Start Date must be in the future.">
	<cfset language.invalidStartError = "Please enter a valid Start Date.">
	<cfset language.invalidEndError = "Please enter a valid End Date.">
	<cfset language.noVesselError = "Please specify a vessel.">
	<cfset language.emailExistsError = "The e-mail address already exists in the system, please try another.">
	<cfset language.bookingTooShortErrorB = "The difference between the start date and end date must be at least the number of days provided.">
<cfelse>
	<cfset language.invalidEmailError = "Veuillez v&eacute;rifier la validit&eacute; de votre addresse de courriel.">
	<cfset language.unapprovedEmailError = "Votre acc&egrave;s au syst&egrave;me n'a pas encore &eacute;t&eacute; approuv&eacute;. Veuillez attendre de recevoir un courriel d'approbation.">
	<cfset language.incorrectPasswordError = "Le mot de passe entr&eacute; est incorrect. Veuillez r&eacute;essayer.">
	<cfset language.duplicateVesselError = "Un navire portant ce nom existe d&eacute;j&agrave;.">
	<cfset language.startTodayError = "La date de d&eacute;but ne peut pas &ecirc;tre aujourd'hui.">
	<cfset language.endBeforeStartError = "La date de d&eacute;but doit pr&eacute;c&eacute;der la date de fin.">
	<cfset language.pastStartError = "La date de d&eacute;but ne peut pas &ecirc;tre dans le pass&eacute;.">
	<cfset language.bookingTooShortError = "La dur&eacute;e minimale de la r&eacute;servation est de 1 journ&eacute;e.">
	<cfset language.needBookingDaysError = "Veuillez entrer le nombre de jours de r&eacute;servation.">
	<cfset language.futureStartError = "La date de d&eacute;but doit &ecirc;tre dans l'avenir.">
	<cfset language.invalidStartError = "Veuillez entrer une date de d&eacute;but valide.">
	<cfset language.invalidEndError = "Veuillez entrer une date de fin valide.">
	<cfset language.noVesselError = "Veuillez pr&eacute;ciser un navire.">
	<cfset language.emailExistsError = "L'adresse de courriel existe d&eacute;j&agrave; dans le syst&egrave;me; veuillez en utiliser une autre.">
	<cfset language.bookingTooShortErrorB = "La diff&eacute;rence entre la date de d&eacute;but et la date de fin doit au moins &eacute;quivaloir au nombre de jours indiqu&eacute;s.">
</cfif>

