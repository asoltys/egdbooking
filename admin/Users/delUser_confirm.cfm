<cfif isDefined("form.userID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfset Errors = ArrayNew(1)>
<cfset Success = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<!--- Validate the form data --->
<cfif NOT isDefined("Form.CompanyID") OR form.companyID EQ "">
	<cfoutput>#ArrayAppend(Errors, "You must select a company.")#</cfoutput>
	<cfset Proceed_OK = "No">
<cfelseif NOT isDefined("Form.UserID") OR form.userID EQ "">
	<cfoutput>#ArrayAppend(Errors, "You must select a user to delete.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>


<cfif Proceed_OK EQ "No">
	<!--- Save the form data in a session structure so it can be sent back to the form page --->
	<cfset Session.Return_Structure.CompanyID = Form.CompanyID>
	<cfset Session.Return_Structure.UserID = Form.UserID>
			
	<cfset Session.Return_Structure.Errors = Errors>
	
 	<cflocation url="delUser.cfm?lang=#lang#" addToken="no"> 
</cfif>

<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm Delete User"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm Delete User</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Users.email, FirstName + ' ' + LastName AS UserName
		FROM	Users
		WHERE	UserID = #form.UserID#
	</cfquery>
	
	<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Name AS CompanyName
		FROM	Companies
		WHERE	CompanyID = #form.CompanyID#
	</cfquery>
	
	<cfquery name="getCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	Companies.Name AS CompanyName
		FROM	Users INNER JOIN UserCompanies ON Users.UserID = UserCompanies.UserID
				INNER JOIN Companies ON UserCompanies.companyID = Companies.companyID
		WHERE	Users.UserID = #form.UserID# AND UserCompanies.Approved = 1 
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
					<table align="center">
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
						<!---<tr>
							<td colspan="2"><strong>User Vessels:</strong></td>
						</tr>
						<cfloop query="getUserVessels">
							<tr>
								<td colspan="2">#Name#</td>
							</tr>
						</cfloop>--->
					</table>
				</cfoutput>
				
				<cfform action="delUser_action.cfm?lang=#lang#" method="post" name="delUserConfirmForm">
					<div style="text-align:center;">
						<!---a href="javascript:EditSubmit('delUserConfirmForm');" class="textbutton">Delete</a>
						<a href="delUser.cfm" class="textbutton">Back</a>
						<a href="<cfoutput>#RootDir#</cfoutput>admin/menu.cfm?lang=#lang#" class="textbutton">Cancel</a--->
						<cfif getCompanies.recordCount GT 1><cfoutput><input type="button" value="remove user from #getCompany.companyName#" onclick="self.location.href='removeUserCompany_action.cfm?userID=#form.userID#&amp;CompanyID=#form.companyID#'" class="textbutton" />
						<input type="submit" value="Delete user account" class="textbutton" />
						<cfoutput><input type="button" value="Back" onclick="self.location.href='delUser.cfm?lang=#lang#'" class="textbutton" />
						<cfoutput><input type="button" value="Cancel" onclick="self.location.href='#RootDir#admin/menu.cfm?lang=#lang#'" class="textbutton" />
					</div>
					
					<input type="hidden" name="userID" value="<cfoutput>#form.UserID#</cfoutput>" />
				</cfform>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
