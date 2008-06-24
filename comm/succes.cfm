<cfif NOT IsDefined("Session.Success")>
	<cflocation addtoken="no" url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">
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

<cfparam name="Variables.Success.Title" default="">
<cfparam name="Variables.Success.Message" default="">
<cfparam name="Variables.Success.Back" default="">
<cfparam name="Variables.Success.Link" default="">

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<A href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</A> &gt;
			<CFELSE>
				<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">#language.welcomePage#</a> &gt;
			</CFIF>
				#Variables.Success.Breadcrumb#
			</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<CFOUTPUT>#Variables.Success.Title#</CFOUTPUT>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

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
		
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
