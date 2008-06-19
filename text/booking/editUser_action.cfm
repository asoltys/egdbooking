<cfif lang EQ "eng">
	<cfset language.noFirstName = "Please enter a first name.">
	<cfset language.noLastName = "Please enter a last name.">
<cfelse>
	<cfset language.noFirstName = "Veuillez entrer votre pr&eacute;nom.">
	<cfset language.noLastName = "Veuillez entrer votre nom de famille.">
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

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="editUser.cfm?lang=#lang#" addtoken="no">
</cfif>


<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">

	<cfquery name="editUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE 	Users
		SET		FirstName = '#trim(form.firstname)#',
				LastName = '#trim(form.lastname)#'
		WHERE 	UserID = '#session.userID#'
	</cfquery>

</cflock>

<!--- create structure for sending to mothership/success page. --->
<cfif lang EQ "eng">
	<cfset Session.Success.Breadcrumb = "Edit Profile">
	<cfset Session.Success.Title = "Edit Profile">
	<cfset Session.Success.Message = "Your profile has been updated.">
	<cfset Session.Success.Back = "Back to Edit Profile">
<cfelse>
	<cfset Session.Success.Breadcrumb = "Modifier le profil">
	<cfset Session.Success.Title = "Modifier le profil">
	<cfset Session.Success.Message = "Votre profil a &eacute;t&eacute; mis &agrave; jour.">
	<cfset Session.Success.Back = "Retour &agrave; modifier le profil">
</cfif>
<cfset Session.Success.Link = "#RootDir#text/booking/editUser.cfm?lang=#lang#">
<cflocation addtoken="no" url="#RootDir#text/common/success.cfm?lang=#lang#">