<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">


<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">

	<cfquery name="editUserCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE	UserCompanies
		SET		Deleted = 1
		WHERE	UserCompanies.UserID = #session.UserID# AND UserCompanies.CompanyID = #form.companyID#
	</cfquery>

</cflock>

<!--- CLEAR FORM STRUCTURE --->
<cfset StructDelete(Session, "Form_Structure")>

<cflocation addtoken="no" url="#RootDir#text/reserve-book/editUser.cfm?lang=#lang#">