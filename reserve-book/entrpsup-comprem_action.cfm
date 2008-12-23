<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">


<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">

	<cfquery name="editUserCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	UserCompanies
		SET		Deleted = 1
		WHERE	UserCompanies.UID = #session.UID# AND UserCompanies.CID = #form.CID#
	</cfquery>

</cflock>

<!--- CLEAR FORM StrUCTURE --->
<cfset StructDelete(Session, "Form_Structure")>

<cflocation addtoken="no" url="#RootDir#reserve-book/profilmod-profileedit.cfm?lang=#lang#">
