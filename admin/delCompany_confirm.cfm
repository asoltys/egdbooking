<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm Delete Company"">
	<meta name=""keywords"" lang=""eng"" content="""">
	<meta name=""description"" lang=""eng"" content="""">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm Delete Company</title>">

<cfif isDefined("form.companyID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<!---retrieve information on the company selected--->
<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT *
	FROM Companies
	WHERE Companies.companyID = #form.companyID#
</cfquery>

<!---get a list of companies besides the one to be deleted, 
so the users who belong to that current company can choose another company--->
<cfquery name="getCompanyList" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT CompanyID, Name
	FROM Companies
	WHERE companyID <> #form.companyID#
	AND Deleted = 0
	ORDER BY Name
</cfquery>

<!---get the user list from the company to be deleted--->
<cfquery name="getCompanyUsers" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Users.UserID, LastName + ', ' + FirstName AS UserName
	FROM Users INNER JOIN UserCompanies ON Users.UserID = UserCompanies.UserID 
			INNER JOIN Companies ON UserCompanies.CompanyID = Companies.CompanyID
	WHERE UserCompanies.companyID = #form.companyID# AND Users.Deleted = 0 
	AND UserCompanies.Deleted = 0 AND UserCompanies.Approved = 1 
	AND	Companies.Deleted = 0 AND Companies.Approved = 1
	AND (SELECT COUNT(*) AS MatchFui
				FROM UserCompanies
				WHERE UserID = Users.UserID) = 1
</cfquery>

<cfquery name="getDockBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Bookings.BookingID, Name, StartDate, EndDate, Status
	FROM Vessels INNER JOIN Bookings ON Vessels.VesselID = Bookings.VesselID 
			INNER JOIN Docks ON Bookings.BookingId = Docks.BookingId
	WHERE companyID = #form.companyID# AND Docks.Status = 'c' AND Bookings.Deleted = 0
			AND EndDate >= #CreateODBCDate(PacificNow)#
</cfquery>

<cfquery name="getJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Bookings.BookingID, Name, StartDate, EndDate, Status
	FROM Vessels INNER JOIN Bookings ON Vessels.VesselID = Bookings.VesselID 
			INNER JOIN Jetties ON Bookings.BookingId = Jetties.BookingId
	WHERE companyID = #form.companyID# AND Jetties.Status = 'c' AND Bookings.Deleted = 0
			AND EndDate >= #CreateODBCDate(PacificNow)#
</cfquery>

<cfquery name="getVessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Vessels.Name
	FROM	Companies INNER JOIN Vessels ON Companies.CompanyID = Vessels.CompanyID
	WHERE	Companies.CompanyID = #form.companyID# AND Vessels.Deleted = 0
</cfquery>

<!-- Start JavaScript Block -->
<script language="JavaScript" type="text/javascript">
	<!--
	function EditSubmit ( selectedform )
	{
	  document.forms[selectedform].submit() ;
	}
	//-->
</script>
<!-- End JavaScript Block -->

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<A href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			Confirm Delete Company
			</CFOUTPUT>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Confirm Delete Company
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>
				
				<cfif IsDefined("Session.Return_Structure")>
					<!--- Populate the Variables Structure with the Return Structure.
							Also display any errors returned --->
					<cfinclude template="#RootDir#includes/getStructure.cfm">
				</cfif>
				
				<cfif getDockBookings.recordCount GT 0 OR getJettyBookings.recordCount GT 0 OR getVessels.recordCount GT 0 OR getCompanyUsers.recordCount GT 0>
					<cfif getDockBookings.recordCount GT 0 OR getJettyBookings.recordCount GT 0>
					<cfoutput>
						<strong>#getCompany.Name#</strong> cannot be deleted as it has the following confirmed bookings:
						<br><br>
						<cfif getDockBookings.recordCount GT 0>
							<table style="padding-left:20px;font-size:10pt;" width="100%">
							<tr><th id="drydock" align="left"><strong>Drydock</strong></th></tr>
								<cfloop query="getDockBookings">
									<cfif getDockBookings.Status EQ "C">
										<tr>
											<td headers="drydock">&nbsp;&nbsp;#name#</td><td align="left">#DateFormat(StartDate, 'mmm d, yyyy')# - #DateFormat(EndDate, 'mmm d, yyyy')#</td>
										</tr>
									</cfif>
								</cfloop>
							</table>
						<br>
						</cfif>
						<cfif getJettyBookings.recordCount GT 0>
							<table style="padding-left:20px;font-size:10pt;" width="100%">
							<tr><th id="jetties" align="left"><strong>Jetties</strong></th></tr>
								<cfloop query="getJettyBookings">
									<cfif getJettyBookings.Status EQ "C">
										<tr>
											<td headers="jetties">&nbsp;&nbsp;#name#</td><td align="left">#DateFormat(StartDate, 'mmm d, yyyy')# - #DateFormat(EndDate, 'mmm d, yyyy')#</td>
										</tr>
									</cfif>
								</cfloop>
							</table>
						<br>
						</cfif>
						All confirmed bookings must be cancelled before #getCompany.Name# can be deleted.<br><br>
					</cfoutput>
					</cfif>
				
					<cfif getVessels.recordCount GT 0>
						<cfoutput>
						<strong>#getCompany.Name#</strong> cannot be deleted as it is currently responsible for the following vessel(s):
						<br><br>
						<table style="padding-left:20px;font-size:10pt;" width="100%">
							<cfloop query="getVessels">
								<tr>
									<td>&nbsp;&nbsp;#name#</td>
								</tr>
							</cfloop>
						</table>
						<br>All vessels must be deleted before #getCompany.Name# can be deleted.<br><br>
					</cfoutput>
					</cfif>
					
					<cfif getCompanyUsers.recordCount GT 0>
						<cfoutput>
						<strong>#getCompany.Name#</strong> cannot be deleted as it is currently the only company responsible for the following user(s):
						<br><br>
						<table style="padding-left:20px;font-size:10pt;" width="100%">
							<cfloop query="getCompanyUsers">
								<tr>
									<td>&nbsp;&nbsp;#userName#</td>
								</tr>
							</cfloop>
						</table>
						<br>All users that are associated with only #getCompany.name# must be deleted before #getCompany.Name# can be deleted.<br><br>
					</cfoutput>
					</cfif>
					
					<cfoutput>
					<div align="center">
						<input type="button" value="Back" onClick="self.location.href='delCompany.cfm?lang=#lang#'" class="textbutton">
						<input type="button" value="Cancel" onClick="self.location.href='menu.cfm?lang=#lang#'" class="textbutton">
					</div>
					</cfoutput>
					
				<cfelse>
				<cfform action="delCompany_action.cfm?lang=#lang#" method="post" name="delCompanyConfirmForm">
					Are you sure you want to delete <cfoutput><strong>#getCompany.Name#</strong></cfoutput>?
					
					<cfoutput>
					<p><div align="center">
					<!--a href="javascript:EditSubmit('delCompanyConfirmForm');" class="textbutton">Submit</a>
					<a href="menu.cfm?lang=#lang#" class="textbutton">Cancel</a-->
					<input type="submit" name="submitForm" class="textbutton" value="submit">
					<input type="button" value="Back" onClick="self.location.href='delCompany.cfm?lang=#lang#'" class="textbutton">
					<input type="button" value="Cancel" onClick="self.location.href='menu.cfm?lang=#lang#'" class="textbutton">
					</div></p>
					</cfoutput>
					
					<input type="hidden" name="companyID" value="<cfoutput>#form.CompanyID#</cfoutput>">
				
				
					<cfoutput>
					<table align="center" style="padding-top:10px;">
						<tr>
							<td colspan="2"><strong>Company Profile:</strong></td>
						</tr>
						<tr>
							<td id="Name">Name:</td>
							<td headers="Name">#getCompany.Name#</td>
						</tr>
						<tr>
							<td id="address1">Address 1:</td>
							<td headers="address1">#getCompany.address1#</td>
						</tr>
						<tr>
							<td id="address2">Address 2:</td>
							<td headers="address2">#getCompany.address2#</td>
						</tr>
						<tr>
							<td id="City">City:</td>
							<td headers="City">#getCompany.city#</td>
						</tr>
						<tr>
							<td id="Province">Province:</td>
							<td headers="Province">#getCompany.province#</td>
						</tr>
						<tr>
							<td id="Country">Country:</td>
							<td headers="Country">#getCompany.country#</td>
						</tr>
						<tr>
							<td id="Postal">Postal Code:</td>
							<td headers="Postal">#getCompany.zip#</td>
						</tr>
						<tr>
							<td id="Phone">Phone:</td>
							<td headers="Phone">#getCompany.phone#</td>
						</tr>
					</table>
					</cfoutput>
				
				</cfform>	
				</cfif>
				
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
