<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Administrative Functions"">
<meta name=""keywords"" lang=""eng"" content="""">
<meta name=""description"" lang=""eng"" content="""">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Administrative Functions</title>">


<!---clear form structure--->
<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<!---these session variables are used in bookingManage and jettyBookingManage-->
<cflock scope="session" type="exclusive" timeout="30">
	<cfif IsDefined("Session.StartDate")>
		<cfset StructDelete(Session, "StartDate")>
	</cfif>
	<cfif IsDefined("Session.EndDate")>
		<cfset StructDelete(Session, "EndDate")>
	</cfif>
	<cfif IsDefined("Session.ShowApproved")>
		<cfset StructDelete(Session, "ShowApproved")>
	</cfif>
	<cfif IsDefined("Session.ShowConfirmed")>
		<cfset StructDelete(Session, "ShowConfirmed")>
	</cfif>
	<cfif IsDefined("Session.ShowPending")>
		<cfset StructDelete(Session, "ShowPending")>
	</cfif>
</cflock--->

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

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-eng.cfm"> &gt; 
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
				
				<!---cfform action="intromsgaction.cfm" method="POST"--->
					<!---<cffile action="read" file="D:\Web\EGDBooking\text\intromsg.txt" variable="intromsg">--->
				<cffile action="read" file="#FileDir#text\intromsg.txt" variable="intromsg">
				<cfif #Trim(intromsg)# EQ "">
				<cfelse>
					<DIV class="notice">
					<H2>Notice</H2>
					<cfoutput>#paragraphformat(intromsg)#</cfoutput>
					</DIV>
				</cfif>
				<!---/cfform--->
			
				<div style="font-size:10pt;padding-left:10px;">
					<cfif GetNewUsers.NumFound EQ 0>
						There are no new user company requests that need to be approved.
					<cfelseif GetNewUsers.NumFound EQ 1>
						You have a <a href="Users/userApprove.cfm?lang=#lang#">new user company request</a> that needs to be approved.
					<cfelseif GetNewUsers.NumFound GT 1>
						You have <a href="Users/userApprove.cfm?lang=#lang#">#GetNewUsers.NumFound# user company requests</a> that need to be approved.
					</cfif>
					<cfif GetNewCompanies.NumFound EQ 0>
						<br>There are no new companies that need to be approved.
					<cfelseif GetNewCompanies.NumFound EQ 1>
						<br>You have a <a href="companyApprove.cfm?lang=#lang#">new company</a> that needs to be approved.
					<cfelseif GetNewCompanies.NumFound GT 1>
						<br>You have <a href="companyApprove.cfm?lang=#lang#">#GetNewCompanies.NumFound# companies</a> that need to be approved.
					</cfif>
					<p>&nbsp;&nbsp;&nbsp;<a href="#RootDir#text/admin/intromsg.cfm" class="textbutton">Edit Intro Message</a>&nbsp;<a href="#RootDir#text/admin/egd_admindoc-e.html" class="textbutton" target="_blank">Help</a>&nbsp;<a href="#RootDir#text/ols-login/logout.cfm?lang=#lang#" class="textbutton">Logout</a></p>
					
					<p>Bookings<br>
					<!---<a href="#RootDir#text/admin/DockBookings/addbooking.cfm?lang=#lang#" class="textbutton">Add</a>--->
					<!---<a href="#RootDir#text/reserve-book/admin/editBooking-e.cfm?lang=#lang#">Edit</a> |--->
					&nbsp;&nbsp;&nbsp;<a href="#RootDir#text/admin/DockBookings/bookingmanage.cfm?lang=#lang#" class="textbutton">Drydock Booking Management</a>
					<a href="#RootDir#text/comm/dockCalendar.cfm?lang=#lang#" class="textbutton">Calendar</a>
					
					<!---<p>Jetty Bookings<br>--->
					<!---<a href="#RootDir#text/admin/JettyBookings/addJettybooking.cfm?lang=#lang#" class="textbutton">Add</a>--->
					<!---<a href="#RootDir#text/reserve-book/admin/editBooking-e.cfm?lang=#lang#">Edit</a> |--->
					<p>&nbsp;&nbsp;&nbsp;<a href="#RootDir#text/admin/JettyBookings/jettyBookingmanage.cfm?lang=#lang#" class="textbutton">Jetty Booking Management</a>
					<a href="#RootDir#text/comm/jettyCalendar.cfm?lang=#lang#" class="textbutton">Calendar</a></p>
					<p>&nbsp;&nbsp;&nbsp;<a href="#RootDir#text/admin/otherForms.cfm?lang=#lang#" class="textbutton">Booking Forms</a></p>
				
					<p>Users<br>
					&nbsp;&nbsp;&nbsp;<a href="#RootDir#text/admin/Users/addUser.cfm?lang=#lang#" class="textbutton">Add</a>
					<a href="#RootDir#text/admin/Users/editUser.cfm?lang=#lang#" class="textbutton">Edit</a>
					<a href="#RootDir#text/admin/Users/userApprove.cfm?lang=#lang#" class="textbutton">Approve</a>
					<a href="#RootDir#text/admin/Users/delUser.cfm?lang=#lang#" class="textbutton">Delete</a></p>
					
					<p>Administrators<br>
					&nbsp;&nbsp;&nbsp;<a href="#RootDir#text/admin/Users/addAdministrator.cfm?lang=#lang#" class="textbutton">Add</a>
					<a href="#RootDir#text/admin/Users/delAdministrator.cfm?lang=#lang#" class="textbutton">Remove</a>
					<a href="#RootDir#text/admin/editAdminDetails.cfm?lang=#lang#" class="textbutton">Edit Email List</a></p>
					
					<p>Companies<br>
					&nbsp;&nbsp;&nbsp;<a href="#RootDir#text/admin/addCompany.cfm?lang=#lang#" class="textbutton">Add</a>
					<a href="#RootDir#text/admin/EditCompany.cfm?lang=#lang#" class="textbutton">Edit</a>
					<a href="#RootDir#text/admin/CompanyApprove.cfm?lang=#lang#" class="textbutton">Approve</a>
					<a href="#RootDir#text/admin/DelCompany.cfm?lang=#lang#" class="textbutton">Delete</a>
					<!---a href="#RootDir#text/admin/OrphanedCompanies.cfm?lang=#lang#" class="textbutton">Orphaned Companies</a---></p>
					
					<p>Vessels<br>
					&nbsp;&nbsp;&nbsp;<a href="#RootDir#text/admin/addVessel.cfm?lang=#lang#" class="textbutton">Add</a>
					<a href="#RootDir#text/admin/editVessel.cfm?lang=#lang#" class="textbutton">Edit</a>
					<a href="#RootDir#text/admin/delVessel.cfm?lang=#lang#" class="textbutton">Delete</a></p>

				</cfoutput>
				</div>
			<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
		
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
