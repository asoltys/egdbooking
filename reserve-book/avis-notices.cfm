<cfif lang EQ "eng">
	<cfset language.notices = "Notices">
	<cfset language.keywords = language.masterKeywords & ", Notices">
	<cfset language.description = "Important Notices">
	<cfset language.subjects = language.masterSubjects & "">
<cfelse>
	<cfset language.notices = "Avis">
	<cfset language.keywords = language.masterKeywords & ", Avis">
	<cfset language.description = "Avis Important">
	<cfset language.subjects = language.masterSubjects & "">
</cfif>




<cfhtmlhead text="
	<meta name=""dc.title"" content=""#language.notices# - #language.bookingForms# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dc.subject"" scheme=""gccore"" content=""#language.subjects#"" />
	<title>#language.notices# - #language.bookingForms# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">#language.Admin#</a> &gt;
			</CFIF>
			<a href="#RootDir#reserve-book/formulaires-forms.cfm.cfm?lang=#lang#">#language.bookingForms#</a> &gt;
			#language.notices#
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
        <!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
        <cfoutput>#language.notices#</cfoutput>
        <!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
        </a></h1>

        <cfoutput>
          <cffile action="read" file="#FileDir#intro-#lang#.txt" variable="intromsg">
          <cfinclude template="#RootDir#includes/helperFunctions.cfm" />
          <div class="option4">
            #intromsg#
          </div>
				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

