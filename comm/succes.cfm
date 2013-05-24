<cfif NOT IsDefined("Session.Success")>
	<cflocation addtoken="no" url="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">
<cfelse>
	<cfset Variables.Success.Breadcrumb = Session.Success.Breadcrumb>
	<cfset Variables.Success.Title = Session.Success.Title>
	<cfset Variables.Success.Message = Session.Success.Message>
</cfif>
<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""#language.PWGSC# - #language.EsqGravingDock# - #Variables.Success.Breadcrumb#"" />
	<meta name=""keywords"" content=""#Language.masterKeywords#"" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.subject"" content=""#Language.masterSubjects#"" />
	<title>#Variables.Success.Breadcrumb# - #language.esqGravingDock# - #language.PWGSC#</title>">
	<cfset request.title = variables.success.title />
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfparam name="Variables.Success.Title" default="">
<cfparam name="Variables.Success.Message" default="">

				<h1 id="wb-cont"><cfoutput>#Variables.Success.Title#</cfoutput></h1>

				<div class="content">

					<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
						<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
					<CFELSE>
						<CFINCLUDE template="#RootDir#includes/user_menu.cfm">
					</CFIF>

					<cfoutput>
						<p>#Variables.Success.Message#</p>

            <p><a href="#RootDir#reserve-book/reserve-booking.cfm" class="textbutton">#language.returnTo#</a></p>
					</cfoutput>
				</div>

			<cfif IsDefined("Session.Form_Structure")>
				<cfset StructDelete(Session, "Form_Structure")>
			</cfif>

		<!-- CONTENT ENDS | FIN DU CONTENU -->

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
