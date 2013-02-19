<cfhtmlhead text="
	<meta name=""dcterms.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Booking"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dcterms.subject"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Booking</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

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
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Change Company
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				<cfquery name="getCompanyList" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				SELECT Companies.CID, Companies.Name
					FROM Companies JOIN Vessels ON Companies.CID = Vessels.CID
					WHERE Companies.Approved = 1 AND Companies.Deleted = 0 AND Vessels.Name = <cfqueryparam value="#vesselNameURL#" cfsqltype="cf_sql_varchar" /> AND Companies.Name <> <cfqueryparam value="#CompanyURL#" cfsqltype="cf_sql_varchar" />
					ORDER BY Companies.Name
				</cfquery>
		
				<cfoutput>
		
				<cfif getCompanyList.recordCount LTE "0">
					<br />#CompanyURL# cannot be changed because #vesselNameURL# isn't available in another company.
				<cfelse>
		
					<cfform action="changeCompany2.cfm" method="post">
					<table>
					  <tr>
						<td><br /><cfinput type="text" style="border:0; font-weight:bold" value="#vesselNameURL#" name="vesselNameURL" required="Yes" readonly="yes"><cfinput type="text" style="border:0; color:##FFFFFF" value="#BRIDURL#" name="BRIDURL" required="Yes" readonly="yes" />
						</td>
					  </tr>
					  <tr>
						<td>Original Company: <cfinput type="text" style="border:0;" value="#CompanyURL#" name="CompanyURL" required="Yes" readonly="yes" /></td>
					  </tr>
					  <tr>
						<td>Original Agent: <cfinput type="text" style="border:0;" value="#UserNameURL#" name="UserNameURL" required="Yes" readonly="yes" /></td>
					  </tr>
					  <tr>
						<td><br />Change to Company:</td>
					  </tr>
					  <tr>
						<td><cfselect name="newCID" size="1" required="yes">
						  <cfloop query="getCompanyList">
							<option value="#CID#">#Name#</option>
						  </cfloop> </cfselect></td>
					  </tr>
					  <tr>
						<td><input id="submit" type="submit" value="submit" />
					  </tr>
					</table>
					</cfform>
				</cfif>
				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
