<cfif isDefined("form.CID") OR isDefined("form.firstname")>
	<cfset StructDelete(Session, "Form_Structure")>
	<cfinclude template="#RootDir#includes/build_form_struct.cfm">
</cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">


<cfquery name="getAdministrators" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	Email, firstname + ' ' + lastname AS AdminName, Administrators.UID
	FROM 	Administrators INNER JOIN Users on Administrators.UID = Users.UID
	WHERE 	users.deleted = 0
	ORDER BY lastname, firstname
</cfquery>

<cfparam name="variables.emailList" default="#ArrayToList(ArrayNew(1))#">
<cfoutput query="getAdministrators">
	<cfif isDefined('form.Email#UID#')>
		<cfset variables.emailList = ListAppend(emailList, "#email#")>
	</cfif>
</cfoutput>

<cfquery name="updateConfig" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	UPDATE	Configuration
	SET		Email = <cfqueryparam value="#variables.emailList#" cfsqltype="cf_sql_varchar" />
</cfquery>


<cfset Session.Success.Breadcrumb = "Edit Email List">
<cfset Session.Success.Title = "Edit Email List">
<cfset Session.Success.Message = "The administrative email list has been updated.">
<cfset Session.Success.Back = "Back to Admin Functions Home">
<cfset Session.Success.Link = "#RootDir#admin/menu.cfm?lang=#lang#">
<cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">
