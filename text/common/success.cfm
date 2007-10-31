<cfif NOT IsDefined("Session.Success")>
	<cflocation addtoken="no" url="#RootDir#text/booking/booking.cfm?lang=#lang#">
<cfelse>
	<cfset Variables.Success.Breadcrumb = Session.Success.Breadcrumb>
	<cfset Variables.Success.Title = Session.Success.Title>
	<cfset Variables.Success.Message = Session.Success.Message>
	<cfset Variables.Success.Back = Session.Success.Back>
	<cfset Variables.Success.Link = Session.Success.Link>
	<!---<cfset StructDelete(Session, "Success")>--->
</cfif>

<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""#language.PWGSC# - #language.EsqGravingDock# - #Variables.Success.Breadcrumb#"">
<meta name=""keywords"" lang=""eng"" content=""#Language.masterKeywords#"">
<meta name=""description"" lang=""eng"" content="""">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""#Language.masterSubjects#"">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #Variables.Success.Breadcrumb#</title>">

<cfinclude template="#RootDir#includes/header-#lang#.cfm">

<cfparam name="Variables.Success.Title" default="">
<cfparam name="Variables.Success.Message" default="">
<cfparam name="Variables.Success.Back" default="">
<cfparam name="Variables.Success.Link" default="">


<cfoutput>
<div class="breadcrumbs">
	<a href="http://www.pwgsc.gc.ca/text/home-#lang#.html">#language.PWGSC#</a> &gt;
	#language.PacificRegion# &gt;
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-#lang#.html">#language.EsqGravingDock#</a> &gt;
	<a href="#RootDir#text/booking-#lang#.cfm">#language.Booking#</A> &gt;
<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
	<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">#language.Admin#</A> &gt;
<CFELSE>
	<a href="#RootDir#text/booking/booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
</CFIF>
	#Variables.Success.Breadcrumb#
</div>
</cfoutput>

<div class="main">
<h1><cfoutput>#Variables.Success.Title#</cfoutput></h1>

<div class="content">

<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
	<cfinclude template="#RootDir#includes/admin_menu.cfm"><br>
<CFELSE>
	<cfinclude template="#RootDir#includes/user_menu.cfm"><br>
</CFIF>


<cfoutput>
<p align="center">#Variables.Success.Message#
<cfif IsDefined('Session.Success.paperFormLink')>
	<BR /><BR />
	*** Confirmation of Booking requires the submittal of the Schedule 1 and Indemnification Clause forms available through the "Mandatory Forms" button below. Payment of the necessary deposit is also required - please contact the Esquimalt Graving Dock for details.
</cfif>
</p>
<p align="center">

<cfif IsDefined('Session.Success.paperFormLink')>
	<a href="#Session.Success.paperFormLink#" class="textbutton">Mandatory Forms</a>&nbsp;
</cfif>

<a href="#Variables.Success.Link#" class="textbutton">#Variables.Success.Back#</a>
</p>
</cfoutput>

</div>
</div>

<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<cfinclude template="#RootDir#includes/footer-#lang#.cfm">