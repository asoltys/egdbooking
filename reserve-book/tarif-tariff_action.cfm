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
 	<cflocation url="#RootDir#reserve-book/tarif-tariff.cfm?lang=#lang#&BRID=#url.BRID#" addtoken="no">
</cfif>

<!--- queries to populate details in e-mail sent to dock administrators --->

<cfquery name="getDetails" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Vessels.Name AS vesselName, CID
	FROM	Vessels
		INNER JOIN	Bookings ON Bookings.VNID = Vessels.VNID
	WHERE	BRID = (<cfqueryparam value="#form.BRID#" cfsqltype="cf_sql_integer" />)
</cfquery>
	
<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	firstname + ' ' + lastname AS UserName, Email, Companies.Name AS CompanyName
	FROM	Users INNER JOIN UserCompanies ON Users.UID = UserCompanies.UID 
			INNER JOIN Companies ON UserCompanies.CID = Companies.CID
	WHERE	Users.UID = <cfqueryparam value="#session.UID#" cfsqltype="cf_sql_integer" /> AND Companies.CID = <cfqueryparam value="#getDetails.CID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfquery name="BookingDates" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT     EndDate, StartDate
FROM       Bookings
WHERE     (BRID = <cfqueryparam value="#form.BRID#" cfsqltype="cf_sql_integer" />)
</cfquery>
	<cfoutput>
		<cfif ServerType EQ "Development">
<cfset Variables.AdminEmail = DevEmail />
</cfif>
		<cfmail to="#Variables.AdminEmail#" from="#getUser.email#" subject="Drydock Booking Request - Services and Facilities Requested" type="html">
			<p>#getUser.userName# of <em>#getUser.companyName#</em> has filled out the on-line Tariff of Dock Charges form for their drydock booking of vessel <strong>#getDetails.VesselName#</strong> from #DateFormat(BookingDates.StartDate, 'mmm d, yyyy')# to #DateFormat(BookingDates.EndDate, 'mmm d, yyyy')#.</p>
		</cfmail>
	</cfoutput>

<cflocation addtoken="no" url="#RootDir#reserve-book/formulaires-forms.cfm?lang=#lang#&BRID=#url.BRID#">

