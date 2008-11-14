<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Booking"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Booking</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfquery name="getUserName" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT UserCompanies.UserID, Users.FirstName, Users.LastName
	FROM UserCompanies JOIN Users ON UserCompanies.UserID = Users.UserID
	WHERE UserCompanies.Approved = 1 AND UserCompanies.Deleted = 0 AND UserCompanies.CompanyID = '#newCompanyID#'
</cfquery>
<cfquery name="getCompanyDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT Name as CompanyDetail
	FROM Companies
	WHERE CompanyID = '#newCompanyID#'
</cfquery>
<cfquery name="getUserIDDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT LastName + ', ' + FirstName as newFullName
	FROM users
	WHERE UserID = '#newUserName#'
</cfquery>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt;
			<CFELSE>
				<a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			<a href="jettyBookingManage.cfm?lang=#lang#">Jetty Management</a> &gt;
			Change Company
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Change Company
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>
				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				<cfform action="changeCompanyAction.cfm" method="post">
				<table>
				  <tr>
					<td><br /><cfinput type="Text" style="border:0; font-weight:bold" value="#vesselNameURL#" name="vesselNameURL" required="Yes" readonly="yes"><cfinput type="Text" style="border:0; color:##FFFFFF" value="#BookingIDURL#" name="BookingIDURL" required="Yes" readonly="yes" /></td>
				  </tr>
				  <tr>
					<td>
				Original Company: <cfinput type="Text" style="border:0;" value="#CompanyURL#" name="CompanyURL" required="Yes" readonly="yes" /></td>
				  </tr>
				  <tr>
					<td>Original Agent: <cfinput type="Text" style="border:0;" value="#UserNameURL#" name="UserNameURL" required="Yes" readonly="yes" /></td>
				  </tr>
						<tr>
					<td><br />Change to Company: <cfoutput query="getCompanyDetail">#CompanyDetail#</cfoutput> <cfinput type="Text" style="border:0; color:##FFFFFF" value="#newCompanyID#" name="newCompanyID" required="Yes" readonly="yes" /></td>
				  </tr>
				  <tr>
					<td>Change to Agent: <cfoutput query="getUserIDDetail">#newFullName#</cfoutput> <cfinput type="Text" style="border:0; color:##FFFFFF" value="#newUserName#" name="newUserName" required="Yes" readonly="yes" /></td>
				  </tr>
				
				  <tr>
					<td><br />
				<b>Please finalize changes before submitting</b> <br />
				<br />
				<input id="submit" type="submit" value="submit" />
				  </tr>
				</table>
				</cfform>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
