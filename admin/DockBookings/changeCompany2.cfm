<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Booking"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Booking</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfquery name="getUserName" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT UserCompanies.UID, Users.FirstName, Users.LastName
	FROM UserCompanies JOIN Users ON UserCompanies.UID = Users.UID
	WHERE UserCompanies.Approved = 1 AND UserCompanies.Deleted = 0 AND UserCompanies.CID = <cfqueryparam value="#newCID#" cfsqltype="cf_sql_integer" />
	</cfquery>
<cfquery name="getCompanyDetail" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
SELECT Name as CompanyDetail
	FROM Companies
	WHERE CID = <cfqueryparam value="#newCID#" cfsqltype="cf_sql_integer" />
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
			<a href="bookingManage.cfm?lang=#lang#">Drydock Management</a> &gt;
			Change Company
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1 id="wb-cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Change Company
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</h1>
					
				<cfoutput>
					
				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				<cfform action="changeCompany3.cfm" method="post">
				<table>
				  <tr>
					<td><br /><cfinput type="text" style="border:0; font-weight:bold" value="#vesselNameURL#" name="vesselNameURL" required="Yes" readonly="yes"><cfinput type="text" style="border:0; color:##FFFFFF" value="#BRIDURL#" name="BRIDURL" required="Yes" readonly="yes" /></td>
				  </tr>
				  <tr>
					<td>
				Original Company: <cfinput type="text" style="border:0;" value="#CompanyURL#" name="CompanyURL" required="Yes" readonly="yes" /></td>
				  </tr>
				  <tr>
					<td>Original Agent: <cfinput type="text" style="border:0;" value="#UserNameURL#" name="UserNameURL" required="Yes" readonly="yes" /></td>
				  </tr>
						<tr>
					<td><br />Change to Company: <cfloop query="getCompanyDetail">#CompanyDetail#</cfloop> <cfinput type="text" style="border:0; color:##FFFFFF" value="#newCID#" name="newCID" required="Yes" readonly="yes" /></td>
				  </tr>
				  <tr>
					<td>Change to Agent: <cfselect name="newUserName" size="1" required="yes">
					  <cfloop query="getUserName">
						<option value="#UID#">#LastName#, #FirstName#</option>
					  </cfloop> </cfselect></td>
				  </tr>
				  <tr>
					<td><input id="submit" type="submit" value="submit" />
				  </tr>
				</table>
				</cfform>
				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
