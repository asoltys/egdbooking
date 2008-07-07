<cfif isDefined("form.companyID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<CFIF trim(form.abbrev) eq ''>
	<cfoutput>#ArrayAppend(Variables.Errors, "You must enter a company abbreviation first.")#</cfoutput>
	<cfset Proceed_OK = "No">
</CFIF>

<cfquery name="getAbbrev" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Abbreviation
	FROM Companies
	WHERE Abbreviation = '#trim(form.abbrev)#'
	AND Deleted = 0
</cfquery>

<cfif getAbbrev.recordcount GE 1>
	<cfoutput>#ArrayAppend(Variables.Errors, "A company with that abbreviation already exists.")#</cfoutput>
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK EQ "No">
	<cfinclude template="#RootDir#includes/build_return_struct.cfm">
	<cfset Session.Return_Structure.Errors = Variables.Errors>
	<cflocation url="companyApprove.cfm?lang=#lang#" addtoken="no">
</cfif>


<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Approve Company"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Approve Company</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<CFSET This_Page = "../admin/companyApprove_confirm.cfm">


<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	CompanyID, Name AS CompanyName
	FROM 	Companies
	WHERE 	CompanyID = '#Form.CompanyID#'
</cfquery>

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
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt; 
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			<a href="userApprove.cfm?lang=#lang#">Company Approvals</a> &gt;
			Approve Company
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Approve Company
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				
				<cfoutput>
				<div style="text-align:center;">
					<p>Are you sure you want to approve <strong>#getCompany.companyName#</strong>?</p>
					<form action="companyApprove_action.cfm?lang=#lang#" name="approveCompany" method="post">
						<input type="hidden" name="CompanyId" value="#Form.CompanyId#" />
						<input type="hidden" name="abbrev" value="#Form.abbrev#" />
						<!---a href="javascript:EditSubmit('rejectUser');" class="textbutton">Submit</a--->
						<input type="submit" class="textbutton" value="Approve" />
						<input type="button" value="Cancel" onclick="javascript:location.href='companyApprove.cfm?lang=#lang#'" class="textbutton" />
					</form>
				</div>
				</cfoutput>
				
			</div>
			
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
