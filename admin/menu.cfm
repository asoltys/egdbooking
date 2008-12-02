<cfhtmlhead text="
<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Administrative Functions"">
<meta name=""keywords"" content="""" />
<meta name=""description"" content="""" />
<meta name=""dc.date.published"" content=""2005-07-25"" />
<meta name=""dc.date.published"" content=""2005-07-25"" />
<meta name=""dc.date.reviewed"" content=""2005-07-25"" />
<meta name=""dc.date.modified"" content=""2005-07-25"" />
<meta name=""dc.date.created"" content=""2005-07-25"" />
<title>PWGSC - ESQUIMALT GRAVING DOCK - Administrative Functions</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">


<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<cfquery name="GetNewUsers" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	COUNT(*) AS NumFound
	FROM	UserCompanies INNER JOIN Companies ON UserCompanies.CompanyID = Companies.CompanyID
			INNER JOIN Users ON UserCompanies.UserID = Users.UserID
	WHERE	UserCompanies.Approved = '0' AND UserCompanies.Deleted = '0'
			AND Users.Deleted = '0' AND Companies.Deleted = '0'
</cfquery>
<cfquery name="GetNewCompanies" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT	COUNT(*) AS NumFound
	FROM	Companies
	WHERE	Approved = '0'
	AND		Deleted = '0'
</cfquery>

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-eng.cfm"> &gt; 
			Administrative Functions
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Administrative Functions
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

				<cfoutput>
				
				<cffile action="read" file="#FileDir#intromsg.txt" variable="intromsg">
				<cfif #Trim(intromsg)# EQ "">
				<cfelse>
					<div class="notice">
					<h2>Notice</h2>
					<cfoutput>#paragraphformat(intromsg)#</cfoutput>
					</div>
				</cfif>
			
				<div style="padding-left:10px;">
					<cfif GetNewUsers.NumFound EQ 0>
						There are no new user company requests that need to be approved.
					<cfelseif GetNewUsers.NumFound EQ 1>
						You have a <a href="Users/userApprove.cfm?lang=#lang#">new user company request</a> that needs to be approved.
					<cfelseif GetNewUsers.NumFound GT 1>
						You have <a href="Users/userApprove.cfm?lang=#lang#">#GetNewUsers.NumFound# user company requests</a> that need to be approved.
					</cfif>
					<cfif GetNewCompanies.NumFound EQ 0>
						<br />There are no new companies that need to be approved.
					<cfelseif GetNewCompanies.NumFound EQ 1>
						<br />You have a <a href="companyApprove.cfm?lang=#lang#">new company</a> that needs to be approved.
					<cfelseif GetNewCompanies.NumFound GT 1>
						<br />You have <a href="companyApprove.cfm?lang=#lang#">#GetNewCompanies.NumFound# companies</a> that need to be approved.
					</cfif>
					<p>&nbsp;&nbsp;&nbsp;<a href="#RootDir#admin/intromsg.cfm" class="textbutton">Edit Intro Message</a>&nbsp;<a href="#RootDir#ols-login/fls-logout.cfm?lang=#lang#" class="textbutton">Logout</a></p>
					
					<p>Bookings<br />
					&nbsp;&nbsp;&nbsp;<a href="#RootDir#admin/DockBookings/bookingmanage.cfm?lang=#lang#" class="textbutton">Drydock Booking Management</a>
					<a href="#RootDir#comm/calend-cale-dock.cfm?lang=#lang#" class="textbutton">Calendar</a>
					
					<p>&nbsp;&nbsp;&nbsp;<a href="#RootDir#admin/JettyBookings/jettyBookingmanage.cfm?lang=#lang#" class="textbutton">Jetty Booking Management</a>
					<a href="#RootDir#comm/calend-jet.cfm?lang=#lang#" class="textbutton">Calendar</a></p>
					<p>&nbsp;&nbsp;&nbsp;<a href="#RootDir#admin/otherForms.cfm?lang=#lang#" class="textbutton">Booking Forms</a></p>
				
					<p>Users<br />
					&nbsp;&nbsp;&nbsp;<a href="#RootDir#admin/Users/addUser.cfm?lang=#lang#" class="textbutton">Add</a>
					<a href="#RootDir#admin/Users/editUser.cfm?lang=#lang#" class="textbutton">Edit</a>
					<a href="#RootDir#admin/Users/userApprove.cfm?lang=#lang#" class="textbutton">Approve</a>
					<a href="#RootDir#admin/Users/delUser.cfm?lang=#lang#" class="textbutton">Delete</a></p>
					
					<p>Administrators<br />
					&nbsp;&nbsp;&nbsp;<a href="#RootDir#admin/Users/addAdministrator.cfm?lang=#lang#" class="textbutton">Add</a>
					<a href="#RootDir#admin/Users/delAdministrator.cfm?lang=#lang#" class="textbutton">Remove</a>
					<a href="#RootDir#admin/editAdminDetails.cfm?lang=#lang#" class="textbutton">Edit Email List</a></p>
					
					<p>Companies<br />
					&nbsp;&nbsp;&nbsp;<a href="#RootDir#admin/addCompany.cfm?lang=#lang#" class="textbutton">Add</a>
					<a href="#RootDir#admin/EditCompany.cfm?lang=#lang#" class="textbutton">Edit</a>
					<a href="#RootDir#admin/CompanyApprove.cfm?lang=#lang#" class="textbutton">Approve</a>
					<a href="#RootDir#admin/DelCompany.cfm?lang=#lang#" class="textbutton">Delete</a>
					<!---a href="#RootDir#admin/OrphanedCompanies.cfm?lang=#lang#" class="textbutton">Orphaned Companies</a---></p>
					
					<p>Vessels<br />
					&nbsp;&nbsp;&nbsp;<a href="#RootDir#admin/addVessel.cfm?lang=#lang#" class="textbutton">Add</a>
					<a href="#RootDir#admin/editVessel.cfm?lang=#lang#" class="textbutton">Edit</a>
					<a href="#RootDir#admin/delVessel.cfm?lang=#lang#" class="textbutton">Delete</a></p>

				</cfoutput>
				</div>
			<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
		
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
