<cfhtmlhead text="
<meta name=""dc.title"" lang=""fre"" content=""TPSGC - CALE S&Egrave;CHE D'ESQUIMALT - Recherche"">
<meta name=""keywords"" lang=""fre"" content=""cale s&egrave;che d'Esquimalt, rechercher"">
<meta name=""description"" lang=""fre"" content=""Page de recherche - Cale s&egrave;che d'Esquimalt"">
<meta name=""dc.subject"" scheme=""gccore"" lang=""fre"" content=""Navire; Quai"">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2002-11-29"">
<title>TPSGC - Cale s&egrave;che d'Esquimalt - Recherche</title>">

<cfinclude template="#RootDir#includes/header-f.cfm">

<div class="breadcrumbs"> 
	<a href="http://www.tpsgc.gc.ca/home-f.html">TPSGC</a> &gt; 
	R&eacute;gion du Pacifique &gt; 
	<a href="index-f.cfm">Cale s&egrave;che d'Esquimalt </a> &gt; 
	Recherche
</div>

<div class="main">
	<H1>Rechercher</H1>
	<!-- ********************************************************************************* --> 
	<!-- ******************** DO NOT EDIT FORM NAME, METHOD OR ACTION ******************** --> 
	<!-- ********************************************************************************* -->
	<!--- modify mfrm action="/cgi-bin/proxyvista.pl" --->
	<form name="mfrm" method="GET" action="http://www.pwgsc.gc.ca/cgi-bin/proxyvista.pl">
		<label for="section">Chercher documents dans&nbsp;:</label>
		<br>
		<!-- ********** DO NOT MODIFY THE SELECT NAME AND OPTION VALUES ********** -->
		<select name=url id="section">
			<!--- modify option value="http://www.tpsgc.gc.ca<cfoutput>#RootDir#</cfoutput>" --->
			<option value="<cfoutput>#RootDir#</cfoutput>" selected>cette section</option>
			<option value="http://www.tpsgc.gc.ca/home-f.html">TPSGC au complet</option>
		</select>
		<br><br>
		<label for="search">Chercher&nbsp;:</label>
		<br>
		<!-- ******************** DO NOT EDIT INPUT name="q" ******************** --> 
		<input name="q" size="35" maxlength="800" id="search" value="" class="textField">
		<br><br>
		<input type="submit" name="Submit" value="Chercher" class="textbutton">
		<input type="button" value="Effacer" name="Button" onClick="document.mfrm.q.value=''" class="textbutton">
		<!-- modify formloc value="http://www.tpsgc.gc.ca/site02/search-f.html" -->
		<!--- modify formloc value="http://www.tpsgc.gc.ca<cfoutput>#RootDir#</cfoutput>search-f.html" --->
		<!-- ********** this value is used for the results page ********** -->  
		<input type=hidden name="formloc" value="<cfoutput>#RootDir#</cfoutput>search-f.cfm">
		<input type=hidden name="tablewidth" value="450">
		<input type=hidden name="align" value="left">
		<input type=hidden name="bordersize" value="0">
		<br><br>
		<a href="shelp-f.cfm">Aide &agrave; la recherche</a>
	</form>
	<!-- ****************************************************************************** --> 
	<!-- ****************************** end search form ******************************* --> 
	<!-- ****************************************************************************** -->
	<!-- ********** Search Results Display ********** -->

</div>
<cfinclude template="#RootDir#includes/footer-f.cfm">
