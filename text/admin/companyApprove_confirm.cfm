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
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Approve Company"">
<meta name=""keywords"" lang=""eng"" content="""">
<meta name=""description"" lang=""eng"" content="""">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Approve Company</title>">
<cfinclude template="#RootDir#includes/header-#lang#.cfm">

<CFSET This_Page = "../admin/companyApprove_confirm.cfm">


<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT 	CompanyID, Name AS CompanyName
	FROM 	Companies
	WHERE 	CompanyID = '#Form.CompanyID#'
</cfquery>

<!-- Start JavaScript Block -->
<script language="JavaScript" type="text/javascript">
<!--
function EditSubmit ( selectedform )
{
  document.forms[selectedform].submit() ;
}
//-->
</script>

<div class="breadcrumbs">
	<a href="<cfoutput>http://www.pwgsc.gc.ca/text/home-#lang#.html</cfoutput>">PWGSC</a> &gt; 
	Pacific Region &gt; 
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-e.html">Esquimalt Graving Dock</a> &gt; 
  <CFOUTPUT>
		<a href="#RootDir#text/booking-#lang#.cfm">Booking</A> &gt;<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
			<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
		<CFELSE>
			 <a href="#RootDir#text/booking/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
		</CFIF>
	<A href="userApprove.cfm?lang=#lang#">Company Approvals</A> &gt;
	</CFOUTPUT>
	Approve Company
</div>

<div class="main">
<H1>Approve Company</H1>
<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>

<cfoutput>
<div align="center">
	<p>Are you sure you want to approve <strong>#getCompany.companyName#</strong>?</p>
	<form action="companyApprove_action.cfm?lang=#lang#" name="approveCompany" method="post">
		<input type="hidden" name="CompanyId" value="#Form.CompanyId#">
		<input type="hidden" name="abbrev" value="#Form.abbrev#">
		<!---a href="javascript:EditSubmit('rejectUser');" class="textbutton">Submit</a--->
		<input type="submit" class="textbutton" value="Approve">
		<input type="button" value="Cancel" onClick="javascript:location.href='companyApprove.cfm?lang=#lang#'" class="textbutton">
	</form>
</div>
</cfoutput>

</div>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">