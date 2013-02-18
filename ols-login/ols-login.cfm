<cfif lang EQ "eng">
	<cfset language.title = "Booking Application Login">
	<cfset language.description ="Login page for the booking application.">
<cfelse>
	<cfset language.title = "Entrer dans l'application de r&eacute;servation">
	<cfset language.description ="Page d'ouverture de session pour la demande de r&eacute;servation.">
</cfif>

<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""#language.title# - #language.esqGravingDock# - #language.PWGSC#"" />
	<meta name=""keywords"" content=""#language.masterKeywords# #language.Login#"" />
	<meta name=""description"" content=""#language.description#"" />
	<meta name=""dcterms.subject"" scheme=""gccore"" content=""#language.masterSubjects#"" />
	<title>#language.title# - #language.esqGravingDock# - #language.PWGSC#</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

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

<cfheader name="Pragma" value="no-cache">
<cfheader name="cache-control" value="no-cache, no-store, must-revalidate">
<cfcookie name="CFID" value="empty" expires="NOW">
<cfcookie name="CFTOKEN" value="empty" expires="NOW">

				<cfoutput>
					<form action="ols-login_action.cfm?lang=#lang#" method="post" id="login_form">
            <fieldset>
              <legend>#language.login#</legend>
              <p>#language.requiredFields#</p>
              
              <div>
                <label for="email">
                  <abbr title="#language.required#" class="required">*</abbr>&nbsp;#language.Email#:
                  #error('email')#
                </label>
                <input type="text" name="email" id="email" size="40" maxlength="100" value="#email#" />
              </div>

              <div>
                <label for="password">
                  <abbr title="#language.required#" class="required">*</abbr>&nbsp;#language.Password#:
                  #error('password')#
                </label>
                <input type="password" name="Password" id="password" size="25" maxlength="40" />
              </div>

              <div>
                <label for="remember">#language.Remember#</label>
                <input name="remember" type="checkbox" id="remember" value="remember" <CFIF IsDefined("Cookie.login")>checked="checked"</CFIF> />
              </div>

              <input type="submit" name="submitForm" value="#language.Login#" class="textbutton" />
            </fieldset>
					</form>
					<p><a href="utilisateurajout-useradd.cfm?lang=#lang#">#language.addUser#</a></p>
					<p><a href="passeoubli-passforgot.cfm?lang=#lang#">#language.Forgot#</a></p>
				</cfoutput>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">

