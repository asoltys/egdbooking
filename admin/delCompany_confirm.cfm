<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Confirm Delete Company"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Confirm Delete Company</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

<cfif isDefined("form.CID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<!---retrieve information on the company selected--->
<cfquery name="getCompany" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT *
	FROM Companies
	WHERE Companies.CID = <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" />
</cfquery>

<!---get a list of companies besides the one to be deleted,
so the users who belong to that current company can choose another company--->
<cfquery name="getCompanyList" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT CID, Name
	FROM Companies
	WHERE CID <> <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" />
	AND Deleted = 0
	ORDER BY Name
</cfquery>

<!---get the user list from the company to be deleted--->
<cfquery name="getCompanyUsers" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Users.UID, LastName + ', ' + FirstName AS UserName
	FROM Users INNER JOIN UserCompanies ON Users.UID = UserCompanies.UID
			INNER JOIN Companies ON UserCompanies.CID = Companies.CID
	WHERE UserCompanies.CID = <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" /> AND Users.Deleted = 0
	AND UserCompanies.Deleted = 0 AND UserCompanies.Approved = 1
	AND	Companies.Deleted = 0 AND Companies.Approved = 1
	AND (SELECT COUNT(*) AS MatchFui
				FROM UserCompanies
				WHERE UID = Users.UID) = 1
</cfquery>

<cfquery name="getDockBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Bookings.BRID, Name, StartDate, EndDate, Status
	FROM Vessels INNER JOIN Bookings ON Vessels.VNID = Bookings.VNID
			INNER JOIN Docks ON Bookings.BRID = Docks.BRID
	WHERE CID = <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" /> AND Docks.Status = 'c' AND Bookings.Deleted = 0
			AND EndDate >= <cfqueryparam value="#CreateODBCDate(PacificNow)#" cfsqltype="cf_sql_date" />
</cfquery>

<cfquery name="getJettyBookings" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Bookings.BRID, Name, StartDate, EndDate, Status
	FROM Vessels INNER JOIN Bookings ON Vessels.VNID = Bookings.VNID
			INNER JOIN Jetties ON Bookings.BRID = Jetties.BRID
	WHERE CID = <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" /> AND Jetties.Status = 'c' AND Bookings.Deleted = 0
			AND EndDate >= <cfqueryparam value="#CreateODBCDate(PacificNow)#" cfsqltype="cf_sql_date" />
</cfquery>

<cfquery name="getVessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	Vessels.Name
	FROM	Companies INNER JOIN Vessels ON Companies.CID = Vessels.CID
	WHERE	Companies.CID = <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" /> AND Vessels.Deleted = 0
</cfquery>

<!-- Start JavaScript Block -->
<script type="text/javascript">
/* <![CDATA[ */
function EditSubmit ( selectedform )
	{
	  document.forms[selectedform].submit();
	}
/* ]]> */
</script>
<!-- End JavaScript Block -->

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt;
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			Confirm Delete Company
			</cfoutput>
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

				<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

				<cfif IsDefined("Session.Return_Structure")>
					<!--- Populate the Variables Structure with the Return Structure.
							Also display any errors returned --->
					<cfinclude template="#RootDir#includes/getStructure.cfm">
				</cfif>

				<cfif getDockBookings.recordCount GT 0 OR getJettyBookings.recordCount GT 0 OR getVessels.recordCount GT 0 OR getCompanyUsers.recordCount GT 0>
					<cfif getDockBookings.recordCount GT 0 OR getJettyBookings.recordCount GT 0>
					<cfoutput>
						<strong>#getCompany.Name#</strong> cannot be deleted as it has the following confirmed bookings:
						<br /><br />
						<cfif getDockBookings.recordCount GT 0>
							<table style="padding-left:20px; width:100%;">
							<tr><th id="drydock" align="left"><strong>Drydock</strong></th></tr>
								<cfloop query="getDockBookings">
									<cfif getDockBookings.Status EQ "C">
										<tr>
											<td headers="drydock">&nbsp;&nbsp;#name#</td><td align="left">#DateFormat(StartDate, 'mmm d, yyyy')# - #DateFormat(EndDate, 'mmm d, yyyy')#</td>
										</tr>
									</cfif>
								</cfloop>
							</table>
						<br />
						</cfif>
						<cfif getJettyBookings.recordCount GT 0>
							<table style="padding-left:20px;width:100%;" >
							<tr><th id="jetties" align="left"><strong>Jetties</strong></th></tr>
								<cfloop query="getJettyBookings">
									<cfif getJettyBookings.Status EQ "C">
										<tr>
											<td headers="jetties">&nbsp;&nbsp;#name#</td><td align="left">#DateFormat(StartDate, 'mmm d, yyyy')# - #DateFormat(EndDate, 'mmm d, yyyy')#</td>
										</tr>
									</cfif>
								</cfloop>
							</table>
						<br />
						</cfif>
						All confirmed bookings must be cancelled before #getCompany.Name# can be deleted.<br /><br />
					</cfoutput>
					</cfif>

					<cfif getVessels.recordCount GT 0>
						<cfoutput>
						<strong>#getCompany.Name#</strong> cannot be deleted as it is currently responsible for the following vessel(s):
						<br /><br />
						<table style="padding-left:20px; width:100%;" >
							<cfloop query="getVessels">
								<tr>
									<td>&nbsp;&nbsp;#name#</td>
								</tr>
							</cfloop>
						</table>
						<br />All vessels must be deleted before #getCompany.Name# can be deleted.<br /><br />
					</cfoutput>
					</cfif>

					<cfif getCompanyUsers.recordCount GT 0>
						<cfoutput>
						<strong>#getCompany.Name#</strong> cannot be deleted as it is currently the only company responsible for the following user(s):
						<br /><br />
						<table style="padding-left:20px; width:100%;" >
							<cfloop query="getCompanyUsers">
								<tr>
									<td>&nbsp;&nbsp;#userName#</td>
								</tr>
							</cfloop>
						</table>
						<br />All users that are associated with only #getCompany.name# must be deleted before #getCompany.Name# can be deleted.<br /><br />
					</cfoutput>
					</cfif>

					<cfoutput>
					<div style="text-align:center;">
						<a href="delCompany.cfm?lang=#lang#" class="textbutton">Back</a>
						<a href="menu.cfm?lang=#lang#" class="textbutton">Cancel</a>
					</div>
					</cfoutput>

				<cfelse>
				<cfform action="delCompany_action.cfm?lang=#lang#" method="post" id="delCompanyConfirmForm">
					Are you sure you want to delete <cfoutput><strong>#getCompany.Name#</strong></cfoutput>?

					<cfoutput>
					<p><div style="text-align:center;">
					<!--a href="javascript:EditSubmit('delCompanyConfirmForm');" class="textbutton">Submit</a>
					<a href="menu.cfm?lang=#lang#" class="textbutton">Cancel</a-->
					<input type="submit" name="submitForm" class="textbutton" value="submit" />
					<a href="delCompany.cfm?lang=#lang#" class="textbutton">Back</a>
					<a href="menu.cfm?lang=#lang#" class="textbutton">Cancel</a>
					</div></p>
					</cfoutput>

					<input type="hidden" name="CID" value="<cfoutput>#form.CID#</cfoutput>" />


					<cfoutput>
					<table style="padding-top:10px;">
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
