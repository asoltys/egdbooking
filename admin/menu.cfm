<cfhtmlhead text="
<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Administrative Functions"" />
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
	FROM	UserCompanies INNER JOIN Companies ON UserCompanies.CID = Companies.CID
			INNER JOIN Users ON UserCompanies.UID = Users.UID
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
				
				<cffile action="read" file="#FileDir#intro-eng.txt" variable="intromsg">
				<cfif #Trim(intromsg)# EQ "">
				<cfelse>
					<cfinclude template="#RootDir#includes/helperFunctions.cfm" />
					<div class="option4">
					<h2>Notice</h2>
					<cfoutput>#FormatParagraph(intromsg)#</cfoutput>
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
            
          <div class="menu">
            <h2>Bookings</h2>
            <ul>
              <li><a href="#RootDir#admin/DockBookings/bookingManage.cfm?lang=#lang#">Drydock Booking Management</a></li>
              <li><a href="#RootDir#comm/calend-cale-dock.cfm?lang=#lang#">Dock Calendar</a></li>
              <li><a href="#RootDir#admin/JettyBookings/jettyBookingManage.cfm?lang=#lang#">Jetty Booking Management</a></li>
              <li><a href="#RootDir#comm/calend-jet.cfm?lang=#lang#">Jetty Calendar</a></li>
              <li><a href="#RootDir#admin/otherForms.cfm?lang=#lang#">Booking Forms</a></li>
            </ul>
          
            <h2>Users</h2>
            <ul>
              <li><a href="#RootDir#admin/Users/addUser.cfm?lang=#lang#">Add</a></li>
              <li><a href="#RootDir#admin/Users/editUser.cfm?lang=#lang#">Edit</a></li>
              <li><a href="#RootDir#admin/Users/userApprove.cfm?lang=#lang#">Approve</a></li>
              <li><a href="#RootDir#admin/Users/delUser.cfm?lang=#lang#">Delete</a></li>
            </ul>
            
            <h2>Administrators</h2>
            <ul>
              <li><a href="#RootDir#admin/Users/addAdministrator.cfm?lang=#lang#">Add</a></li>
              <li><a href="#RootDir#admin/Users/delAdministrator.cfm?lang=#lang#">Remove</a></li>
              <li><a href="#RootDir#admin/editAdminDetails.cfm?lang=#lang#">Edit Email List</a></li>
            </ul>
            
            <h2>Companies</h2>
            <ul>
              <li><a href="#RootDir#admin/addCompany.cfm?lang=#lang#">Add</a></li>
              <li><a href="#RootDir#admin/EditCompany.cfm?lang=#lang#">Edit</a></li>
              <li><a href="#RootDir#admin/CompanyApprove.cfm?lang=#lang#">Approve</a></li>
              <li><a href="#RootDir#admin/DelCompany.cfm?lang=#lang#">Delete</a></li>
            </ul>
            
            <h2>Vessels</h2>
            <ul>
              <li><a href="#RootDir#admin/addVessel.cfm?lang=#lang#">Add</a></li>
              <li><a href="#RootDir#admin/editVessel.cfm?lang=#lang#">Edit</a></li>
              <li><a href="#RootDir#admin/delVessel.cfm?lang=#lang#">Delete</a></li>
            </ul>
          </div>

				</cfoutput>
				</div>
			<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
		
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
