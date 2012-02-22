<cfif lang EQ "eng">
	<cfset language.noFirstName = "Please enter a first name.">
	<cfset language.noLastName = "Please enter a last name.">
	<cfset language.noEmail = "Please enter an Email">
<cfelse>
	<cfset language.noFirstName = "Veuillez entrer votre pr&eacute;nom.">
	<cfset language.noLastName = "Veuillez entrer votre nom de famille.">
	<cfset language.noEmail = "Veuillez entrer votre email.">
</cfif>

<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<cfif Form.FirstName EQ "">
	<cfoutput>#ArrayAppend(Errors, "#language.noFirstName#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Form.LastName EQ "">
	<cfoutput>#ArrayAppend(Errors, "#language.noLastName#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Form.Email EQ "">
	<cfoutput>#ArrayAppend(Errors, "#language.noEmail#")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="#RootDir#reserve-book/profilmod-profileedit.cfm?lang=#lang#" addtoken="no">
</cfif>


<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">

	<cfquery name="editUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE 	Users
		SET		FirstName = <cfqueryparam value="#trim(form.firstname)#" cfsqltype="cf_sql_varchar" />,
				  LastName = <cfqueryparam value="#trim(form.lastname)#" cfsqltype="cf_sql_varchar" />,
			  	Email = <cfqueryparam value="#trim(form.email)#" cfsqltype="cf_sql_varchar" />
		WHERE 	UID = <cfqueryparam value="#session.UID#" cfsqltype="cf_sql_integer" />
	</cfquery>

</cflock>

<!--- create structure for sending to mothership/success page. --->
	<cfset Session.Eng.Success.Breadcrumb = "Edit Profile">
	<cfset Session.Eng.Success.Title = "Edit Profile">
	<cfset Session.Eng.Success.Message = "Your profile has been updated.">
	<cfset Session.Eng.Success.Back = "Back to Edit Profile">
  <cfset Session.Eng.Success.Link = "#RootDir#reserve-book/profilmod-profileedit.cfm?lang=#lang#">
	<cfset Session.Fra.Success.Breadcrumb = "Modifier le profil">
	<cfset Session.Fra.Success.Title = "Modifier le profil">
	<cfset Session.Fra.Success.Message = "Votre profil a &eacute;t&eacute; mis &agrave; jour.">
	<cfset Session.Fra.Success.Back = "Retour &agrave; modifier le profil">
  <cfset Session.Fra.Success.Link = "#RootDir#reserve-book/profilmod-profileedit.cfm?lang=#lang#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">
