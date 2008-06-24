<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Search"">
<meta name=""keywords"" lang=""eng"" content=""Esquimalt Graving Dock, search"">
<meta name=""description"" lang=""eng"" content=""Search Page of the Esquimalt Graving Dock"">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""Ship; Wharf"">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2002-11-29"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Search</title>">

<cfinclude template="#RootDir#includes/header-e.cfm">

<div class="breadcrumbs"> 
	<a href="http://www.pwgsc.gc.ca/home-e.html">PWGSC</a> &gt; 
	Pacific Region &gt; 
	<a href="index-e.cfm">Esquimalt Graving Dock</a> &gt; 
	Search
</div>

<div class="main">
	<H1>Search</H1>
	<!-- ********************************************************************************* --> 
	<!-- ******************** DO NOT EDIT FORM NAME, METHOD OR ACTION ******************** --> 
	<!-- ********************************************************************************* -->
	<!--- modify mfrm action="/cgi-bin/proxyvista.pl" --->
	<form name="mfrm" method="GET" action="http://www.pwgsc.gc.ca/cgi-bin/proxyvista.pl">
		<label for="section">Search for documents in:</label>
		<br>
		<!-- ********** DO NOT MODIFY THE SELECT NAME AND OPTION VALUES ********** -->
		<select name=url id="section">
			<!--- modify option value="http://www.pwgsc.gc.ca<cfoutput>#RootDir#</cfoutput>" --->
			<option value="<cfoutput>#RootDir#</cfoutput>" selected>this section</option>
			<option value="http://www.pwgsc.gc.ca/home-e.html">all of PWGSC</option>
		</select>
		<br><br>
		<label for="search">Search For:</label>
		<br>
		<!-- ******************** DO NOT EDIT INPUT name="q" ******************** --> 
		<input name="q" size="35" maxlength="800" id="search" value="" class="textField">
		<br><br>
		<input type="submit" name="Submit" value="Search" class="textbutton">
		<input type="button" value="Reset" name="Button" onClick="document.mfrm.q.value=''" class="textbutton">
		<!-- modify formloc value="http://www.pwgsc.gc.ca/site02/search-e.html" -->
		<!--- modify formloc value="http://www.pwgsc.gc.ca<cfoutput>#RootDir#</cfoutput>search-e.html" --->
		<!-- ********** this value is used for the results page ********** -->  
		<input type=hidden name="formloc" value="<cfoutput>#RootDir#</cfoutput>search-e.cfm">
		<input type=hidden name="tablewidth" value="450">
		<input type=hidden name="align" value="left">
		<input type=hidden name="bordersize" value="0">
		<br><br>
	<a href="shelp-e.cfm">Help on Search</a>
	</form>
	<!-- ****************************************************************************** --> 
	<!-- ****************************** end search form ******************************* --> 
	<!-- ****************************************************************************** -->
	<!-- ********** Search Results Display ********** -->
	<!--FOOTER-->

</div>
<cfinclude template="#RootDir#includes/footer-e.cfm">