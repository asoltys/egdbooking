<cfif isDefined("form.UID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfset Errors = ArrayNew(1)>
<cfset Success = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<!--- Validate the form data --->
<cfif NOT isDefined("Form.CID") OR form.CID EQ "">
	<cfoutput>#ArrayAppend(Errors, "You must select a company.")#</cfoutput>
	<cfset Proceed_OK = "No">
<cfelseif NOT isDefined("Form.UID") OR form.UID EQ "">
	<cfoutput>#ArrayAppend(Errors, "You must select a user to delete.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>


<cfif Proceed_OK EQ "No">
	<!--- Save the form data in a session structure so it can be sent back to the form page --->
	<cfset Session.Return_Structure = Duplicate(Form) />
	<cfset Session.Return_Structure.Errors = Errors>

 	<cflocation url="delUser.cfm?lang=#lang#" addToken="no">
</cfif>

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm Delete User"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm Delete User</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Users.email, FirstName + ' ' + LastName AS UserName
		FROM	Users
		WHERE	UID = <cfqueryparam value="#form.UID#" cfsqltype="cf_sql_integer" />
	</cfquery>

	<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Name AS CompanyName
		FROM	Companies
		WHERE	CID = <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" />
	</cfquery>

	<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Companies.Name AS CompanyName
		FROM	Users INNER JOIN UserCompanies ON Users.UID = UserCompanies.UID
				INNER JOIN Companies ON UserCompanies.CID = Companies.CID
		WHERE	Users.UID = <cfqueryparam value="#form.UID#" cfsqltype="cf_sql_integer" /> AND UserCompanies.Approved = 1
				AND UserCompanies.Deleted = 0 AND Companies.Approved = 1 AND Companies.Deleted = 0
	</cfquery>
</cflock>

<!-- Start JavaScript Block -->
<script type="text/javascript">
/* <![CDATA[ */
function EditSubmit ( selectedform )
	{
	  document.forms[selectedform].submit();
	}
/* ]]> */
</script>
		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt;
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			Confirm Delete User</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Confirm Delete User
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<cfif IsDefined("Session.Return_Structure")>
					<!--- Populate the Variables Structure with the Return Structure.
							Also display any errors returned --->
					<cfinclude template="#RootDir#includes/getStructure.cfm">
				</cfif>

				Are you sure you want to delete <cfoutput><strong>#getUser.UserName#</strong></cfoutput>?
				<!---All vessels associated with this user will also be deleted, along with all bookings associated with those vessels.--->

				<br /><br />
				<cfoutput query="getUser">
					<table>
						<tr>
							<td colspan="2"><strong>User Profile:</strong></td>
						</tr>
						<tr>
							<td id="Name">Name:</td>
							<td headers="Name">#UserName#</td>
						</tr>
						<!---<tr>
							<td>Login Name:</td>
							<td>#loginID#</td>
						</tr>--->
						<tr>
							<td id="Email">Email:</td>
							<td headers="Email">#email#</td>
						</tr>
						<tr>
							<td><cfif getCompanies.recordCount EQ 1>Company:<cfelseif getCompanies.recordCount GT 1>Companies:<cfelse>&nbsp;</cfif></td>
							<cfloop query="getCompanies" endrow="1"><td>#CompanyName#</td></cfloop>
						</tr>
						<cfloop query="getCompanies" startRow="2">
							<tr>
								<td>&nbsp;</td>
								<td>#CompanyName#</td>
							</tr>
						</cfloop>
						<tr>
							<td>&nbsp;</td>
						</tr>
					</table>
				</cfoutput>

				<cfform action="delUser_action.cfm?lang=#lang#" method="post" id="delUserConfirmForm">
					<div style="text-align:center;">
						<cfif getCompanies.recordCount GTE 1>
              <cfoutput>
              <a href="removeUserCompany_action.cfm?UID=#form.UID#&amp;CID=#form.CID#" class="textbutton">remove user from #getCompany.companyName#</a>
              </cfoutput>
						  <input type="submit" value="Delete user account" class="textbutton" />
            </cfif>
              <cfoutput>
              <a href="delUser.cfm?lang=#lang#" class="textbutton">Back</a>
              </cfoutput>
              <cfoutput><a href="#RootDir#admin/menu.cfm?lang=#lang#" class="textbutton">Cancel</a></cfoutput>
					</div>

					<input type="hidden" name="UID" value="<cfoutput>#form.UID#</cfoutput>" />
				</cfform>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
