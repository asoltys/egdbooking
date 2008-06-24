<cfif lang eq "eng" OR (IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true)>
	<cfset language.vesselName = "Name">
	<cfset language.lloydsID = "International Maritime Organization (I.M.O.) Number">
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
