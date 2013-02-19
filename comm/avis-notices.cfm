

<cfif lang EQ "eng">
	<cfset language.keywords = language.masterKeywords & ", Notices">
	<cfset language.description = "Important Notices">
	<cfset language.subjects = language.masterSubjects & "">
<cfelse>
	<cfset language.keywords = language.masterKeywords & ", Avis">
	<cfset language.description = "Avis Important">
	<cfset language.subjects = language.masterSubjects & "">
</cfif>

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""#language.notices# - #language.bookingForms# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.keywords#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dcterms.subject"" content=""#language.subjects#"" />
	<title>#language.notices# - #language.bookingForms# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

  <!-- CONTENT BEGINS | DEBUT DU CONTENU -->
  <div class="center">
    <h1><a name="cont" id="cont">
    <!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
    #language.notices#
    <!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
    </a></h1>

      <cffile action="read" file="#FileDir#intro-#lang#.txt" variable="intromsg">
      <div class="option4">
        #intromsg#
      </div>
  </div>
<!-- CONTENT ENDS | FIN DU CONTENU -->

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm" />

