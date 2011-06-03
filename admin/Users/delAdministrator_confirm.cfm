<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Delete Administrator"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Delete Administrator</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfif isDefined("form.UID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfquery name="getAdmin" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT Users.UID, FirstName + ' ' + LastName AS UserName
		FROM Users
		WHERE UID = <cfqueryparam value="#form.UID#" cfsqltype="cf_sql_integer" />
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
			Confirm Remove Administrator
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Confirm Remove Administrator
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<cfif IsDefined("Session.Return_Structure")>
					<!--- Populate the Variables Structure with the Return Structure.
							Also display any errors returned --->
					<cfinclude template="#RootDir#includes/getStructure.cfm">
				</cfif>

				<cfform action="delAdministrator_action.cfm?lang=#lang#" method="post" id="delAdministratorConfirmForm">
					<div style="text-align:center;">
						Are you sure you want to remove <cfoutput><strong>#getAdmin.UserName#</strong></cfoutput> from administration?
						<br /><br />
						<!---a href="javascript:EditSubmit('delAdministratorConfirmForm');" class="textbutton">Remove</a>
						<a href="delAdministrator.cfm" class="textbutton">Back</a>
						<a href="../menu.cfm?lang=#lang#" class="textbutton">Cancel</a--->
						<input type="submit" value="Remove" class="textbutton" />
						<cfoutput><a href="delAdministrator.cfm?lang=#lang#" class="textbutton">Back</a></cfoutput>
						<cfoutput><a href="#RootDir#admin/menu.cfm?lang=#lang#" class="textbutton">Cancel</a></cfoutput>

					</div>

					<input type="hidden" name="UID" value="<cfoutput>#form.UID#</cfoutput>" />
				</cfform>

			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
