<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Edit Booking"">
	<meta name=""keywords"" lang=""eng"" content="""">
	<meta name=""description"" lang=""eng"" content="""">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Edit Booking</title>
	">
	

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<A href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</A> &gt;
			<CFELSE>
				<a href="#RootDir#reserve-book/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			<A href="bookingManage.cfm?lang=#lang#">Drydock Management</A> &gt;
			Change Company
			</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					<CFOUTPUT>Change Company</CFOUTPUT>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
				<cfquery name="getCompanyList" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
				SELECT Companies.CompanyID, Companies.Name
					FROM Companies JOIN Vessels ON Companies.CompanyID = Vessels.CompanyID
					WHERE Companies.Approved = 1 AND Companies.Deleted = 0 AND Vessels.Name = '#vesselNameURL#' AND Companies.Name <> '#CompanyURL#'
					ORDER BY Companies.Name
				</cfquery>
		
				<cfoutput>
		
				<cfif getCompanyList.recordCount LTE "0">
					<br />#CompanyURL# cannot be changed because #vesselNameURL# isn't available in another company.
				<cfelse>
		
					<cfform action="changeCompany2.cfm" method="POST">
					<table>
					  <tr>
						<td><br /><cfinput type="Text" style="border:0; font-weight:bold" value="#vesselNameURL#" name="vesselNameURL" required="Yes" readonly="yes"><cfinput type="Text" style="border:0; color:##FFFFFF" value="#BookingIDURL#" name="BookingIDURL" required="Yes" readonly="yes">
						</td>
					  </tr>
					  <tr>
						<td>Original Company: <cfinput type="Text" style="border:0;" value="#CompanyURL#" name="CompanyURL" required="Yes" readonly="yes"></td>
					  </tr>
					  <tr>
						<td>Original Agent: <cfinput type="Text" style="border:0;" value="#UserNameURL#" name="UserNameURL" required="Yes" readonly="yes"></td>
					  </tr>
					  <tr>
						<td><br />Change to Company:</td>
					  </tr>
					  <tr>
						<td><cfselect name="newCompanyID" size="1" required="yes">
						  <cfoutput query="getCompanyList">
							<option value="#CompanyID#">#Name#</option>
						  </cfoutput> </cfselect></td>
					  </tr>
					  <tr>
						<td><input id="submit" type="submit" value="Submit"></td>
					  </tr>
					</table>
					</cfform>
				</cfif>
				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
