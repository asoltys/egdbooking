<cfhtmlhead text="
	<meta name=""dc.title"" content=""TPSGC - CALE S&EGRAVE;CHE D'SEQUIMALT - #language.title#"">
	<meta name=""keywords"" content=""#language.masterKeywords# #language.title#"">
	<meta name=""description"" content=""#language.title#"">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""#language.subjects#"">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>TPSGC - CALE S&EGRAVE;CHE D'SEQUIMALT - #language.title#</title>">

<cfinclude template="#RootDir#includes/tete-header-fra.cfm">

		<!-- DEBUT DE LA PISTE DE NAVIGATION | BREAD CRUMB BEGINS -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-fra.html"><cfinclude template="#RootDir#includes/bread-pain-fra.cfm">&gt;
			<CFOUTPUT>#language.title#</CFOUTPUT>
		</p>
		<!-- FIN DE LA PISTE DE NAVIGATION | BREAD CRUMB ENDS -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-fra.cfm">
			<!-- DEBUT DU CONTENU | CONTENT BEGINS -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- DEBUT DU TITRE DU CONTENU | CONTENT TITLE BEGINS -->
					<CFOUTPUT>#language.title#</CFOUTPUT>
					<!-- FIN DU TITRE DU CONTENU | CONTENT TITLE ENDS -->
					</a></h1>

				<CFOUTPUT>
					<p>&nbsp;</p>
				</CFOUTPUT>
			</div>
		<!-- FIN DU CONTENU | CONTENT ENDS -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-fra.cfm">
