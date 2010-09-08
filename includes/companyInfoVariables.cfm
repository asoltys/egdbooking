<cfif lang eq "eng" OR (IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true)>
	<cfset language.companyName = "Company Name">
	<cfset language.address = "Address">
	<cfset language.optional = "(optional)">
	<cfset language.city = "City">
	<cfset language.zip = "Postal Code / Zip Code">
	<cfset language.province = "Province / State">
	<cfset language.country = "Country">
	<cfset language.phone = "Phone">
	<cfset language.abbreviation = "Abbreviation">
	<cfset language.fax = "Fax">

	<cfset language.nameError = "Please enter the company name.">
	<cfset language.addressError = "Please enter the address.">
	<cfset language.cityError = "Please enter the city.">
	<cfset language.provinceError = "Please enter the province or state.">
	<cfset language.countryError = "Please enter the country.">
	<cfset language.zipError = "Please enter the postal code or zip code.">
	<cfset language.phoneError = "Please check that the phone number is valid.">
	<cfset language.abbrevError = "Please enter the company abbreviation.">
	<cfset language.blankWarning = "You have left the following field(s) blank:">
	<cfset language.continueWarning = "Are you sure you wish to continue?">

<cfelse>
	<cfset language.companyName = "Raison sociale">
	<cfset language.address = "Adresse">
	<cfset language.optional = "(facultative)">
	<cfset language.city = "Ville">
	<cfset language.zip = "Code postal">
	<cfset language.province = "Province">
	<cfset language.country = "Pays">
	<cfset language.phone = "T&eacute;l&eacute;phone">
	<cfset language.abbreviation = "Abr&eacute;viation">
	<cfset language.fax = "fax">
	<cfset language.nameError = "Veuillez entrer la raison sociale.">
	<cfset language.addressError = "Veuillez entrer l'adresse.">
	<cfset language.cityError = "Veuillez entrer le nom de la ville.">
	<cfset language.provinceError = "Veuillez entrer la province ou l'&eacute;tat.">
	<cfset language.countryError = "Veuillez entrer le pays">
	<cfset language.zipError = "Veuillez entrer le code postal.">
	<cfset language.phoneError = "Veuillez v&eacute;rifier la validit&eacute; de votre num&eacute;ro de t&eacute;l&eacute;phone.">
	<cfset language.abbrevError = "">
	<cfset language.blankWarning = "Vous avez laiss&eacute; le ou les champs suivants vides :">
	<cfset language.continueWarning = "&Ecirc;tes-vous certain que vous voulez continuer?">
</cfif>

