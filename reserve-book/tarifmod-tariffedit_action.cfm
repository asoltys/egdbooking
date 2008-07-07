<cfif lang EQ 'e'>
	<cfset language.lengthError = "The 'Misc' text has exceeded the maximum alotted number of 150 words.">
<cfelse>
	<cfset language.lengthError = "Vous avez d&eacute;pass&eacute; le nombre maximum permis de 150 mots dans la boîte de texte &laquo; Divers &raquo;">
</cfif>

<cfset Errors = ArrayNew(1)>
<cfset Success = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif isDefined("form.otherText") AND Len(form.otherText) GT 1000>
	<cfoutput>#ArrayAppend(Errors, "#language.lengthError#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<!--- Save the form data in a session structure so it can be sent back to the form page --->
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Errors>
 	<cflocation url="#RootDir#reserve-book/tarifmod-tariffedit.cfm?lang=#lang#&bookingID=#url.bookingId#" addtoken="no">
</cfif>

<cfquery name="submitTariffForm" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE TariffForms
	SET		<cfif isDefined("Form.BookFee") AND Form.BookFee EQ "on">
				BookFee = 1,
			<cfelse>
				BookFee = 0,
			</cfif>
			<cfif isDefined("Form.FullDrain") AND Form.FullDrain EQ "on">
				FullDrain = 1,
			<cfelse>
				FullDrain = 0,
			</cfif>
			<cfif isDefined("Form.VesselDockage") AND Form.VesselDockage EQ "on">
				VesselDockage = 1,
			<cfelse>
				VesselDockage = 0,
			</cfif>
			<cfif isDefined("Form.CargoDockage") AND Form.CargoDockage EQ "on">
				CargoDockage = 1,
			<cfelse>
				CargoDockage = 0,
			</cfif>
			<cfif isDefined("Form.WorkVesselBerthNorth") AND Form.WorkVesselBerthNorth EQ "on">
				WorkVesselBerthNorth = 1,
			<cfelse>
				WorkVesselBerthNorth = 0,
			</cfif>
			<cfif isDefined("Form.NonworkVesselBerthNorth") AND Form.NonworkVesselBerthNorth EQ "on">
				NonworkVesselBerthNorth = 1,
			<cfelse>
				NonworkVesselBerthNorth = 0,
			</cfif>
			<cfif isDefined("Form.VesselBerthSouth") AND Form.VesselBerthSouth EQ "on">
				VesselBerthSouth = 1,
			<cfelse>
				VesselBerthSouth = 0,
			</cfif>
			<cfif isDefined("Form.CargoStore") AND Form.CargoStore EQ "on">
				CargoStore = 1,
			<cfelse>
				CargoStore = 0,
			</cfif>
			<cfif isDefined("Form.TopWharfage") AND Form.TopWharfage EQ "on">
				TopWharfage = 1,
			<cfelse>
				TopWharfage = 0,
			</cfif>
			<cfif isDefined("Form.CraneLightHook") AND Form.CraneLightHook EQ "on">
				CraneLightHook = 1,
			<cfelse>
				CraneLightHook = 0,
			</cfif>
			<cfif isDefined("Form.CraneMedHook") AND Form.CraneMedHook EQ "on">
				CraneMedHook = 1,
			<cfelse>
				CraneMedHook = 0,
			</cfif>
			<cfif isDefined("Form.CraneBigHook") AND Form.CraneBigHook EQ "on">
				CraneBigHook = 1,
			<cfelse>
				CraneBigHook = 0,
			</cfif>
			<cfif isDefined("Form.CraneHyster") AND Form.CraneHyster EQ "on">
				CraneHyster = 1,
			<cfelse>
				CraneHyster = 0,
			</cfif>
			<cfif isDefined("Form.CraneGrove") AND Form.CraneGrove EQ "on">
				CraneGrove = 1,
			<cfelse>
				CraneGrove = 0,
			</cfif>
			<cfif isDefined("Form.Forklift") AND Form.Forklift EQ "on">
				Forklift = 1,
			<cfelse>
				Forklift = 0,
			</cfif>
			<cfif isDefined("Form.CompressPrimary") AND Form.CompressPrimary EQ "on">
				CompressPrimary = 1,
			<cfelse>
				CompressPrimary = 0,
			</cfif>
			<cfif isDefined("Form.CompressSecondary") AND Form.CompressSecondary EQ "on">
				CompressSecondary = 1,
			<cfelse>
				CompressSecondary = 0,
			</cfif>
			<cfif isDefined("Form.CompressPortable") AND Form.CompressPortable EQ "on">
				CompressPortable = 1,
			<cfelse>
				CompressPortable = 0,
			</cfif>
			<cfif isDefined("Form.Tug") AND Form.Tug EQ "on">
				Tug = 1,
			<cfelse>
				Tug = 0,
			</cfif>
			<cfif isDefined("Form.FreshH2O") AND Form.FreshH2O EQ "on">
				FreshH2O = 1,
			<cfelse>
				FreshH2O = 0,
			</cfif>
			<cfif isDefined("Form.Electric") AND Form.Electric EQ "on">
				Electric = 1,
			<cfelse>
				Electric = 0,
			</cfif>
			<cfif isDefined("Form.TieUp") AND Form.TieUp EQ "on">
				TieUp = 1,
			<cfelse>
				TieUp = 0,
			</cfif>
			<cfif isDefined("Form.Commissionaire") AND Form.Commissionaire EQ "on">
				Commissionaire = 1,
			<cfelse>
				Commissionaire = 0,
			</cfif>
			<cfif isDefined("Form.OvertimeLabour") AND Form.OvertimeLabour EQ "on">
				OvertimeLabour = 1,
			<cfelse>
				OvertimeLabour = 0,
			</cfif>
			<cfif isDefined("Form.LightsStandard") AND Form.LightsStandard EQ "on">
				LightsStandard = 1,
			<cfelse>
				LightsStandard = 0,
			</cfif>
			<cfif isDefined("Form.LightsCaisson") AND Form.LightsCaisson EQ "on">
				LightsCaisson = 1 ,
			<cfelse>
				LightsCaisson = 0,
			</cfif>
			<cfif isDefined("Form.Other") AND Form.Other EQ "on" AND trIM(Form.otherText) NEQ "">
				OtherText = '#Form.otherText#',
				Other = 1
			<cfelse>
				OtherText = '',
				Other = 0
			</cfif>
	WHERE	BookingID = '#url.BookingID#'
</cfquery>

<cfquery name="getBooking" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Vessels.Name AS vesselName, startDate, endDate
	FROM	Bookings
		INNER JOIN	Vessels ON Bookings.VesselID = Vessels.VesselID
	WHERE	BookingID = '#url.BookingID#'
</cfquery>

<CFPARAM name="url.referrer" default="Booking Home">
<CFIF url.referrer eq "Archive">
	<CFSET returnTo = "#RootDir#reserve-book/archives.cfm">
<CFELSE>
	<CFSET returnTo = "#RootDir#reserve-book/reserve-booking.cfm">
</CFIF>

<!--- create structure for sending to mothership/success page. --->
<cfif lang EQ "eng">
	<cfset Session.Success.Breadcrumb = "Tariff of Dock Charges">
	<cfset Session.Success.Title = "Tariff of Dock Charges">
	<cfset Session.Success.Message = "Tariff form for <b>#getBooking.vesselName#</b>, booked from #LSDateFormat(CreateODBCDate(getBooking.startDate), 'mmm d, yyyy')# to #LSDateFormat(CreateODBCDate(getBooking.endDate), 'mmm d, yyyy')#, has been updated.">
	<cfif url.referrer eq "archive"><cfset Session.Success.Back = "Back to Booking Archive"><cfelse><cfset Session.Success.Back = "Back to Booking Home"></cfif>
<cfelse>
	<cfset Session.Success.Breadcrumb = "Tarif des droits de cale s&egrave;che">
	<cfset Session.Success.Title = "Tarif des droits de cale s&egrave;che">
	<cfset Session.Success.Message = "Le formulaire de tarif pour <b>#getBooking.vesselName#</b>, qui fait l'objet d'une r&eacute;servation du #LSDateFormat(CreateODBCDate(getBooking.startDate), 'mmm d, yyyy')# au #LSDateFormat(CreateODBCDate(getBooking.endDate), 'mmm d, yyyy')#, a &eacute;t&eacute; mis &agrave; jour.">
	<cfif url.referrer eq "archive"><cfset Session.Success.Back = "Retour aux archives des r&eacute;servations "><cfelse><cfset Session.Success.Back = "Retour &agrave; Accueil&nbsp;- R&eacute;servation"></cfif>
</cfif>
<cfset Session.Success.Link = "#returnTo#?lang=#lang#&CompanyID=#FORM.CompanyID#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">

