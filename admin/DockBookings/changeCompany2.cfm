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
<cfoutput>
  <div class="breadcrumbs"> <a href="http://www.pwgsc.gc.ca/home-#lang#.html">PWGSC</a> &gt; 
    Pacific Region &gt; <a href="http://www.pwgsc.gc.ca/pacific/egd/index-e.html">Esquimalt Graving Dock</a> &gt; <a href="#RootDir#reserve-book-#lang#.cfm">Booking</A> &gt;
    <CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
      <A href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</A> &gt;
      <CFELSE>
      <a href="#RootDir#reserve-book/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
    </CFIF>
    <A href="bookingManage.cfm?lang=#lang#">Drydock Management</A> &gt;
    Change Company </div>
</CFOUTPUT>
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

<div class="main">
  <H1>Change Company</H1>
  <CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
  <cfform action="changeCompany3.cfm" method="POST">
    <table>
      <tr>
        <td><br /><cfinput type="Text" style="border:0; font-weight:bold" value="#vesselNameURL#" name="vesselNameURL" required="Yes" readonly="yes"><cfinput type="Text" style="border:0; color:##FFFFFF" value="#BookingIDURL#" name="BookingIDURL" required="Yes" readonly="yes"></td>
      </tr>
	  <tr>
        <td>
Original Company: <cfinput type="Text" style="border:0;" value="#CompanyURL#" name="CompanyURL" required="Yes" readonly="yes"></td>
      </tr>
      <tr>
        <td>Original Agent: <cfinput type="Text" style="border:0;" value="#UserNameURL#" name="UserNameURL" required="Yes" readonly="yes"></td>
      </tr>
	        <tr>
        <td><br />Change to Company: <cfoutput query="getCompanyDetail">#CompanyDetail#</cfoutput> <cfinput type="Text" style="border:0; color:##FFFFFF" value="#newCompanyID#" name="newCompanyID" required="Yes" readonly="yes"></td>
      </tr>
	  <tr>
        <td>Change to Agent: <cfselect name="newUserName" size="1" required="yes">
          <cfoutput query="getUserName">
            <option value="#UserID#">#LastName#, #FirstName#</option>
          </cfoutput> </cfselect></td>
      </tr>
      <tr>
      <tr>
        <td><input id="submit" type="submit" value="Submit"></td>
      </tr>
    </table>
  </cfform>
</div>
<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
