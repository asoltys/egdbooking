<cfif lang EQ "e">
	<cfset language.title = "Booking Application Login">
	<cfset language.login = "Login">
	<cfset language.description ="Login page for the booking application.">
	<cfset language.browser = "Please ensure that your browser meets the following requirements before proceeding:">
	<cfset language.criteria = '<li><A href="http://browser.netscape.com/ns8/" target="browser">Netscape 4.7+</A> (<A href="http://browser.netscape.com/ns8/download/archive72x.jsp" target="browser">link to older versions</A>), <A href="http://www.microsoft.com/windows/ie/downloads/critical/ie6sp1/default.mspx" target="browser">Internet Explorer 5+</A>, or <A href="http://www.mozilla.org/products/firefox/" target="browser">Mozilla Firefox</A></li>'
		<!---& '<li>128-bit encryption</li>'--->
		& '<li>JavaScript enabled</li>'
		& '<li>Cookies enabled</li>'
		& '<li><A href="http://www.adobe.com/products/acrobat/readstep2_allversions.html" target="browser">Adobe Acrobat Reader</A> installed</li>'>
	<cfset language.displayproblem = "The application may not function properly without these components.">
	<cfset language.jserror = "You do not have JavaScript enabled.  Parts of this application will not function properly.">
	<cfset language.forgot = "Forgot password">
	<cfset language.addUser = "Add new user account">
	<cfset language.email = "Email">
	<cfset language.password = "Password">
	<cfset language.Remember = "Remember Me">
<cfelse>
	<cfset language.title = "Entrer dans l'application de réservation">
	<cfset language.login = "Ouvrir la session">
	<cfset language.description ="Page d'ouverture de session pour la demande de r&eacute;servation.">
	<cfset language.browser = "Veuillez v&eacute;rifier que votre navigateur Web r&eacute;pond aux exigences suivantes avant de continuer&nbsp;:">
	<cfset language.criteria = '<li><A href"http://browser.netscape.com/ns8/" target="browser">Netscape 4.7+</A> (<A href="http://browser.netscape.com/ns8/download/archive72x.jsp" target="browser">liens vers des versions antérieures</A>), <A href="http://www.microsoft.com/windows/ie/downloads/critical/ie6sp1/default.mspx" target="browser">Internet Explorer 5+</A>, ou <A href="http://www.mozilla.org/products/firefox/" target="browser">Mozilla Firefox</A></li>'
		<!---& '<li>Permet le chiffrement de 128 bits du JavaScript</li>'--->
		& '<li>JavaScript activé</li>'
		& '<li>Témoins activés</li>'
		& '<li>Poss&egrave;de <A href="http://www.adobe.com/products/acrobat/readstep2_allversions.html" target="browser">Adobe Acrobat Reader</A> installé</li>'>
	<cfset language.displayproblem = "L'application ne fonctionnera peut-être pas correctement sans ces composantes.">
	<cfset language.jserror = "La fonction JavaScript n'est pas activ&eacute;e. Des parties de l'application ne fonctionnent pas correctement.">
	<cfset language.forgot = "Oubli du mot de passe">
	<cfset language.addUser = "Ajout d'un nouveau compte d'utilisateur">
	<cfset language.email = "Courriel">
	<cfset language.password = "Mot de passe">
	<cfset language.Remember = "Rappelez-vous moi">
</cfif>

<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<cfoutput>
<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.title#"">
<meta name=""keywords"" lang=""eng"" content=""#language.masterKeywords# #language.Login#"">
<meta name=""description"" lang=""eng"" content=""#language.description#"">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""#language.masterSubjects#"">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.title#</title>">

<cfif IsDefined("Session.Return_Structure") AND isDefined("url.pass") AND url.pass EQ "true">
	<cfset Variables.onLoad = "javascript:document.login_form.Password.focus();">
<cfelse>
	<cfset Variables.onLoad = "javascript:document.login_form.email.focus();">
</cfif>

<CFIF IsDefined("Cookie.login")>
	<CFSET email = "#Cookie.login#">
<CFELSE>
	<CFSET email = "">
</CFIF>

<cfinclude template="#RootDir#includes/header-#lang#.cfm">

<cfheader name="Pragma" value="no-cache"> 
<cfheader name="cache-control" value="no-cache, no-store, must-revalidate">
<cfcookie name="CFID" value="empty" expires="NOW">
<cfcookie name="CFTOKEN" value="empty" expires="NOW">



<div class="breadcrumbs">
	<a href="http://www.pwgsc.gc.ca/text/home-#lang#.html">#language.PWGSC#</a> &gt; 
	#language.PacificRegion# &gt; 
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-#lang#.html">#language.EsqGravingDock#</a> &gt; 
	<a href="#RootDir#text/booking-#lang#.cfm">#language.Booking#</A> &gt; #language.title#
</div>

<div class="main">

<H1>#language.title#</H1>

<!--- If the last login failed, show error message --->
<cfif IsDefined("Session.Return_Structure")>
	<cfinclude template="#RootDir#includes/getStructure.cfm">
	<br>
</cfif>

<p>#language.browser#</p>
<UL>#language.criteria#</UL>
<p>#language.displayproblem#</p>

<noscript>
<b style="color: ##FF0000; ">#language.jserror#</b>
</noscript>
<h2>#language.login#</h2>

<!-- Display the login form and pass contents to login_action.cfm -->
<form name="login_form" action="login_action.cfm?lang=<cfoutput>#lang#</cfoutput>" method="post">
<table border="0" cellspacing="2" cellpadding="2" align="center">

	<tr>
		<td align="right"><label for="email">#language.Email#:</label></td>
		<td><input type="text" name="email" id="email" size="40" maxlength="100" class="textField" value="<CFOUTPUT>#email#</CFOUTPUT>"></td>
	</tr>
	<tr>
		<td align="right"><label for="password">#language.Password#:</label></td>
		<td><input type="password" name="Password" id="password" size="25" maxlength="40" class="textField"></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td align="right"><INPUT type="Submit" name="submitForm" value="#language.Login#" class="textbutton">
	</tr>
</table>
<div align="center">#language.Remember#
  <input name="remember" type="checkbox" id="remember" value="remember" <CFIF IsDefined("Cookie.login")>checked</CFIF>/>
</div>
</form>
<div align="center"><a href="adduser.cfm?lang=<cfoutput>#lang#</cfoutput>">#language.addUser#</a></div>
<div align="center"><a href="forgotPassword.cfm?lang=<cfoutput>#lang#</cfoutput>">#language.Forgot#</a></div>


</div>
</cfoutput>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">

