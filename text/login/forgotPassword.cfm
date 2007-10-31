<cfif lang EQ "e">
	<cfset language.forgot = "Forgot Password">
	<cfset language.description = "Allows user to retrieve lost password.">
	<cfset language.keywords = "#language.masterKeywords#" & " Retrieve Forget Lost Password">
	<cfset language.enterEmail = "Please enter the e-mail address you use to log in.">
	<cfset language.getPassword = "Your password will be emailed to you.">
	<cfset language.email = "Email Address">
	<cfset language.emailError ="Please enter a valid email address.">
	<cfset language.returnlogin = "Return to login">
<cfelse>
	<cfset language.forgot = "Oubli du mot de passe">
	<cfset language.description = "Permet &agrave; l'utilisateur de r&eacute;cup&eacute;rer un mot de passe perdu.">
	<cfset language.keywords = "#language.masterKeywords#" & " R&eacute;cup&eacute;ration d'un mot de passe perdu">
	<cfset language.enterEmail = "Veuillez entrer l'adresse de courriel que vous utilisez pour ouvrir une session.">
	<cfset language.getPassword = "Votre mot de passe vous a été transmis par courriel.">
	<cfset language.email = "Adresse de courriel">
	<cfset language.emailError ="Veuillez v&eacute;rifier la validit&eacute; de votre addresse de courriel.">
	<cfset language.returnlogin = "Retourner &agrave; l'ouverture d'une session">
</cfif>

<cfoutput>
<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""#language.PWGSC# - #language.EsqGravingDockCaps# - #language.forgot#"">
<meta name=""keywords"" lang=""eng"" content=""#language.keywords#"">
<meta name=""description"" lang=""eng"" content=""#language.description#"">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""#language.masterSubjects#"">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>#language.PWGSC# - #language.EsqGravingDockCaps# - #language.forgot#</title>">

<cfset Variables.onLoad = "javascript:document.forgotForm.email.focus();">

<cfinclude template="#RootDir#includes/header-#lang#.cfm">

<div class="breadcrumbs">
	<a href="http://www.pwgsc.gc.ca/text/home-#lang#.html">#language.PWGSC#</a> &gt; 
	#language.PacificRegion# &gt; 
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-#lang#.html">#language.EsqGravingDock#</a> &gt; 
	<a href="#RootDir#text/booking-#lang#.cfm">#language.Booking#</A> &gt; <a href="#RootDir#text/login/login.cfm?lang=#lang#">#language.login#</a> &gt; #language.forgot#
</div>

<div class="main">
<H1>#language.forgot#</H1>
<BR>

<cfif IsDefined("Session.Return_Structure")>
	<cfinclude template="#RootDir#includes/getStructure.cfm">
	<br>
</cfif>

<div align="center">#language.enterEmail#<br>#language.getPassword#</div><br>

<cfform action="forgotPassword_action.cfm?lang=#lang#" name="forgotForm">
	<table align="center">
		<tr>
			<td><label for="email">#language.Email#:</label>&nbsp;&nbsp;<cfinput class="textField" type="Text" name="email" id="email" size="30" validate="regular_expression" pattern=".+@.+..+"  message="#language.emailError#"></td>
		</tr>
		<tr>
			<td align="right"><input type="Submit" value="#language.Submit#" class="textbutton"></td>
		</tr>
	</table>
</cfform>

<div align="center"><a href="login.cfm?lang=#lang#">#language.returnlogin#</a></div>

</div>
</cfoutput>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">
