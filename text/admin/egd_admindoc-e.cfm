<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>
			Esquimalt Graving Dock (EGD) Online Booking System: Administrator Documentation
		</TITLE>
		<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<STYLE type="text/css">
 body, th, td {
  font-size: 12pt;
 }
 
 th.link_from {
  background-color: #9999CC;
  color: #000000;
 }
	
 th.link_to {
  background-color: #CC99CC;
  color: #000000;
 }
 
 th {
  color: #FFFFFF;
  background-color: #339999;
 }
 
 .small {
  font-size: 10pt;
 }
 
 div.title {
  font-size: 18pt;
  color: #339999;
  font-weight: bold;
 }
 
 H1 {
  font-size: 14pt;
  color: #2C8585;
  font-weight: bold;
 }
 
 H2 {
  font-size: 12pt;
  color: #000099;
  font-weight: bold;
 }
 
 .red {
  color: #FF0000;
 }
 
 code {
  font-size: 10pt;
  font-family: "Courier New", Courier, mono;
  background-color: #CCFFFF;
 }
 
 .style1 {
	font-size: 14pt;
	font-weight: bold;
 }
 
 .style2 {font-size: 12pt}
.style8 {
	font-size: 12pt;
	font-style: italic;
}
.style10 {font-size: 14pt}

H1 {
	font-family: verdana, sans-serif;
	font-size: 160%;
	color: #669900;
	margin-bottom: 10px;
	border-bottom: 1px dashed;
	letter-spacing: 2px;
	font-weight: normal;
}

a, a:active {
	color: #CC7700;
	text-decoration: none;
}

a:visited {
	color: #996600;
}

a:hover {
	color: #FF3300;
	text-decoration: none;
}

a:hover {
	color: #FF2C00;
	text-decoration: none;
}
.style11 {
	font-size: 13pt;
	font-weight: bold;
}
.style14 {
	font-weight: bold;
	font-style: italic;
}
</STYLE>
	</HEAD>
	
	<BODY bgcolor="#FFFFFF" text="#000000">
	
			
	<div align="center" class="style1">
	  <p>&nbsp;</p>
	  <table width="58%"  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="100%"><div align="left">
            <p><a name="Top"></a><h1>Esquimalt Graving Dock (EGD) Online Booking System: Administrator Documentation</h1>
            </p>
          </div>
            <p class="style1">Table of Contents</p>
            <p align="left"><span class="style2"><strong><a href="#Overview">1. Overview</a></strong></span></p>
            <div style="padding-left:0px;"><strong><a href="#GettingStarted">2. Getting Started</a></strong><br>
            </div>
            <div style="padding-left:20px;"><em><a href="#SystemReqs">2.1 System Requirements</a><br>
                  <a href="#CreateAccount">2.2 Creating an Administrative Account</a></em><br>
            </div>
            <div style="padding-left:40px;">2.2.1 Where to Start<br>
  2.2.2 User Details<br>
  2.2.3 User Company/Companies<br>
  2.2.4 Creating a Company Account<br>
  2.2.5 Activating an Administrative Account <br>
            </div>
            <div style="padding-left:20px;"><em><a href="#LoggingIn">2.3 Logging In</a><br>
                  <a href="#GetPassword">2.4 Password Retrieval</a></em><a href="#GetPassword">
                  <p></p>
                  </a> <br>
                  <span class="style2"></span></div>
            <span class="style2">
            <div style="padding-left:0px;"><strong><a href="#UsingApp">3. Using the EGD Online Booking System </a></strong></div>
            </span>
            <div style="padding-left:20px;"><em><a href="#HomePage">3.1 Administrative Home Page</a><br>
                  <a href="#Approvals">3.2 User and Company Approvals</a></em><br>
            </div>
            <div style="padding-left:40px;">3.2.1 Approving a User-Company Relationship <br>
  3.2.2 Approving a Company <br>
            </div>
            <div style="padding-left:20px;"><em><a href="#Users">3.3 User Administration</a></em><br>
            </div>
            <div style="padding-left:40px;">3.3.1 Adding a User<br>
  3.3.2 Editing a User<br>
            </div>
            <div style="padding-left:60px;"><span class="style8">3.3.2.1 Editing Personal Information<br>
  3.3.2.2 Editing Passwords</span><br>
            </div>
            <div style="padding-left:40px;">3.3.3 Deleting Users <br>
            </div>
            <div style="padding-left:20px;"><em><a href="#Administrators">3.4 Administrators</a> </em><br>
            </div>
            <div style="padding-left:40px;">3.4.1 Adding Administrators<br>
  3.4.2 Removing Administrators<br>
  3.4.3 Editing the Administrator Email List<br>
            </div>
            <div style="padding-left:20px;"><em><a href="#Companies">3.5 Company Administration</a></em> <br>
            </div>
            <div style="padding-left:40px;">3.5.1 Adding Companies<br>
  3.5.2 Editing Companies<br>
  3.5.3 Deleting Companies<br>
            </div>
            <div style="padding-left:20px;"><em><a href="#Vessels">3.6 Vessel Administration</a> </em><br>
            </div>
            <div style="padding-left:40px;">3.6.1 Adding Vessels<br>
  3.6.2 Editing Vessels<br>
  3.6.3 Deleting Vessels<br>
            </div>
            <div style="padding-left:20px;"><em><a href="#DBMVessels">3.7 Drydock Booking Management: Vessel Bookings</a></em><br>
            </div>
            <div style="padding-left:40px;">3.7.1 Adding Drydock Bookings<br>
  3.7.2 Editing Drydock Bookings<br>
  3.7.3 Tariff of Dock Charges<br>
  3.7.4 Canceling Drydock Bookings<br>
  3.7.5 Deleting Past Drydock Bookings <br>
            </div>
            <div style="padding-left:20px;"><em><a href="#DBMMaintenance">3.8 Drydock Booking Management: Maintenance Blocks</a></em> <br>
            </div>
            <div style="padding-left:40px;">3.8.1 Adding Drydock Maintenance Blocks<br>
  3.8.2 Editing Drydock Maintenance Blocks<br>
  3.8.3 Canceling/Deleting Drydock Maintenance Blocks<br>
            </div>
            <div style="padding-left:20px;"><em><a href="#JBMVessels">3.9 Jetty Booking Management: Vessel Bookings</a> </em><br>
            </div>
            <div style="padding-left:40px;">3.9.1 Adding Jetty Bookings<br>
  3.9.2 Editing Jetty Bookings<br>
  3.9.3 Canceling Jetty Bookings<br>
  3.9.4 Deleting Past Jetty Bookings<br>
            </div>
            <div style="padding-left:20px;"><em><a href="#JBMMaintenance">3.10 Jetty Booking Management: Maintenance Blocks</a></em> <br>
            </div>
            <div style="padding-left:40px;">3.10.1 Adding Jetty Maintenance Blocks<br>
  3.10.2 Editing Jetty Maintenance Blocks<br>
  3.10.3 Canceling/Deleting Jetty Maintenance Blocks<br>
            </div>
            <div style="padding-left:20px;"><em><a href="#Overviews">3.11 Booking Overviews</a></em><br>
            </div>
            <div style="padding-left:40px;">3.11.1 Calendars<br>
  3.11.2 Bookings Summary<br>
  3.11.3 Project Calendar<br>
            </div>
            <div style="padding-left:20px;"> <em><a href="#Forms">3.12 Booking Forms</a> </em><br>
            </div>
            <div style="padding-left:40px;">3.12.1 PDF Forms<br>
  3.12.2 Tariff of Dock Charges<br>
            </div>
            <div style="padding-left:60px;"><span class="style8">3.12.2.1 Updating Dock Charges</span><br>
            </div>
            <div style="padding-left:20px;"><em><a href="#LoggingOut">3.13 Logging Out</a> </em><br>
            </div>
            
            <p><strong><br>
            </strong>            
            <hr width="75%">
            <p><strong><br>
              <br>
            <a name="Overview"></a><span class="style10">1. Overview</span></strong><br>
            <div style="padding-left:20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Esquimalt Graving Dock (EGD) Online Booking System provides a quick and convenient way to reserve space online for any of the EGD facilities, including the drydock and jetties. The system also allows users to monitor the status of drydock and jetty bookings along with providing access to all required forms. Automatic email notifications are used to alert users of any changes to their accounts or bookings.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;An administrator has control over all functionality of the system. Administrators have the ability to add, edit and delete any users, companies or vessels in the system. The booking system gives administrators the ability to make any bookings they wish, short of booking vessels that will not fit into the drydock or booking the same vessel to be in two places at once. The administrators are also expected to monitor company and user account requests, and approve or reject them.</div>
            <br>
            <a href="#Top">return to index</a>
            <p></p>
            <p><strong><br>
                  <a name="GettingStarted"></a><span class="style10">2. Getting Started </span></strong><br>
            <div style="padding-left:20px;"><em><a name="SystemReqs"></a><span class="style11">2.1 System Requirements</span></em></div>
            <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Before logging in, ensure that your browser meets the following system requirements:
                <ul>
                  <li><a href="http://browser.netscape.com/ns8/" target="_blank">Netscape 4+</a> (<a href="http://browser.netscape.com/ns8/download/archive72x.jsp" target="_blank">link to older versions</a>), <a href="http://www.microsoft.com/windows/ie/downloads/critical/ie6sp1/default.mspx" target="_blank">Internet Explorer 4+</a>, or <a href="http://www.mozilla.org/products/firefox/" target="_blank">Mozilla Firefox</a></li>
                  <li>JavaScript enabled</li>
                  <li>Cookies enabled</li>
                  <li><a href="http://www.adobe.com/products/acrobat/readstep2_allversions.html" target="_blank">Adobe Acrobat Reader</a> installed</li>
                </ul>
                To install any of the required software, follow the links above. If you have trouble enabling JavaScript or Cookies, follow these guidelines:
                <ul>
                  <li>Netscape 4: Go to Edit &gt; Preferences and click Advanced, both JavaScript and Cookies can be enabled there.</li>
                  <li>Netscape 7 or 8: Go to Edit &gt; Preferences. JavaScript can be enabled under Advanced and Cookies under Privacy &amp; Security.</li>
                  <li>Internet Explorer 6: Go to Tools &gt; Internet Options. JavaScript can be enabled under Advanced and Cookies under Privacy.</li>
                  <li>Mozilla Firefox: Go to Tools &gt; Options. JavaScript can be enabled under Web Features and Cookies under Privacy</li>
                </ul>
            </div>
            <a href="#Top">return to index</a>
            <p></p>
            <p>            
            <div style="padding-left:20px;"> <em><a name="CreateAccount"></a><span class="style11">2.2 Creating an Administrative Account</span></em><br>
            </div>
            <div style="padding-left:40px;"><strong>2.2.1 Where to Start</strong><br>
            </div>
            <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To create an account, go to the main EGD page: <a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-e.html">http://www.pwgsc.gc.ca/pacific/egd/text/index-e.html</a> and click on &quot;Booking&quot; in the side menu bar. Then click on the &quot;Booking Application&quot; link. This brings you to the booking login page; here, click on &quot;Add new user account.&quot;              Now user details can be entered, including: first name, last name, 6-10 character password and email address, all of which are required.  The email address provided will be used for logging in and receiving email notifications from EGD administrators.  Your password is not case-sensitive, so using uppercase letters is not any different from using lowercase.  It is recommended that you make your password more robust by using a combination of letters and numbers.              <br>
              <strong><br>
                </strong></div>
            <div style="padding-left:40px;"><span style="font-weight: bold">2.2.3 User Company/Companies</span><br>
            </div>
            <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Continuing to the next page allows you to add to your profile the company or companies that you represent. To do so, select the company that you represent from the drop down menu and click &quot;add.&quot; This can be repeated as many times as necessary. If the company that you represent is not listed, see 2.2.4. Being associated with a company is required for logging in to the system. As an administrator you will likely only need to be associated with the administrating company (EGD). If you are unsure of which company to add yourself to, contact the current EGD administration using the &quot;Contact Us&quot; link in the side menu bar (Figure 1).<br>
            </div>
			<br>
                <div align="center"><img src="../../images/sideMenuBar.gif"></div>
                <div align="center">Figure 1: Side menu bar <br><br>
                
              </div>
            <div style="padding-left:40px;"><strong>2.2.4 Creating a Company Account</strong><br>
            </div>
            <div style="padding-left:60px;">
              <div align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Underneath the drop down menu, it says, &quot;If the desired company is not listed, click here to create one&quot; as shown in Figure 2 below. Click on the link &quot;here&quot; to proceed. This link takes you to a page where you can enter all your company's details, every field is required except &quot;Address 2&quot; and &quot;Fax&quot; (&quot;Province / State&quot; and &quot;Postal Code / Zip Code&quot; should only be completed if applicable). Clicking &quot;Submit&quot; will create the company account and send email notification to EGD administration of the new company request. The company will have to be approved before becoming active.<br>
              </div>
            </div>
				<br>
                <div align="center"><img src="../../images/createCompanyLink.gif" width="523" height="106"></div>
                <div align="center">Figure 2: Adding a new company <br>
                
              </div>
            <div style="padding-left:40px;"><br>
              <strong>2.2.5 Activating an Administrative Account</strong><br>
            </div>
            <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Once all your companies have been added, click &quot;Submit New User Request.&quot; This will submit your account request, and send e-mail notification to the current EGD administration. Your account will have to be approved before it becomes active. Administrators can approve individual user-company associations, so if you have added multiple companies to your profile, they do not all need to be approved for your account to become active.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;You will receive email notification when one of your user-company associations is approved or rejected. However, you will not have administrative access until your account has been converted to an administration account by an existing administrator.
  <p></p>
            </div>
            <p><a href="#Top">return to index</a> </p>
            <p>
            <div style="padding-left:20px;"><em><a name="LoggingIn"></a><strong class="style11">2.3 Logging In</strong><br>
            </em></div>
            <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Once you have received email notification that one of your user-company associations has been approved, you may login as a general user at <a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-e.html">http://www.pwgsc.gc.ca/pacific/egd/text/login/login.cfm</a> using the email address and password that you specified upon creating your account.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;However, you will not have administrative access until your account has been converted to an administration account by an existing administrator. Once you have been approved as an administrator, you will be automatically taken to the administration home page upon logging in.</div>
            <p></p>
            <a href="#Top">return to index</a> <br>
            <p>            
            <div style="padding-left:20px;"><em><a name="GetPassword"></a><strong class="style11">2.4 Password Retrieval</strong><br>
            </em></div>
            <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If you have forgotten your password, click on the &quot;Forgot password&quot; link at http://www.pwgsc.gc.ca/pacific/egd/text/login/login.cfm . Enter the email address that you use to login, and your password will be emailed to you promptly.<br>
            </div>
            <br>
            <a href="#Top">return to index</a>
            <p></p>
            <p>     <br>       
            <strong><a name="UsingApp"></a><span class="style10">3. Using the EGD Online Booking System</span></strong>
            
            <div style="padding-left:20px;"><em><a name="HomePage"></a><span class="style11"><strong>3.1 Administrative Home Page</strong></span></em><br>
            </div>
            <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Upon logging in, you will be presented with the booking system &quot;Administrative Functions&quot; page. You can access all of the administrative functionality from this page. All major functions are also readily available in the menu bar (Figure 3) just below the title of each page. You also have the option of navigating throughout the site at any time using the breadcrumbs displayed between the EGD banner and the page title (Figure 4). Breadcrumbs track the path you have taken through the site, so they can be used to navigate backwards through the pages used to get to where you currently are.</div>
           <br>
                <div align="center"><img src="../../images/adminMenuBar.gif"></div>
                <div align="center">Figure 3: Menu bar <br>
                
              </div>
			  <br>
                <div align="center"><img src="../../images/breadcrumbs.gif"></div>
                <div align="center">Figure 4: Breadcrumbs <br>
                
              </div>
		    <p><a href="#Top">return to index</a> </p>
            <p><div style="padding-left:20px;"><em><a name="Approvals"></a><span class="style11"><strong>3.2 User and Company Approvals</strong></span></em><br>
            </div>
            <div style="padding-left:40px;"><strong>3.2.1 Approving a User-Company Relationship</strong><br></div>
<div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;You will be alerted of pending user-company approvals at the top of the &quot;Administrative Functions&quot; page just below the page title as shown in Figure 5. There is a line that states how many user company requests need to be approved. You can approve a user-company relationship either by clicking on the link within that sentence, or by clicking on the &quot;Approve&quot; button under the &quot;Users&quot; heading.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The &quot;User Approval&quot; page lists the requests by company, with each user awaiting approval to represent that company underneath the company heading. The company heading is a link, which links to a pop-up displaying the company details. If a user listing does not have an &quot;Approve&quot; button next to it, then the company is still pending approval and must be approved first. Regardless of whether you approve or reject a user company request, the user will receive email notification of the status of their request.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Upon rejection of of a company, if the user is not attached to any other company relationships, the user account will be deleted. Doing so will allow the user to input a request at a later date.
<br>
<br>
</div>
<div style="padding-left:40px;"><strong>3.2.2 Approving Companies</strong><br></div>
<div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;You will be alerted of pending company approvals at the top of the &quot;Administrative Functions&quot; page just below the user-company approvals alert (Figure 5). There is a line that states how many company requests need to be approved. You can approve a company either by clicking on the link within that sentence, or by clicking on the &quot;Approve&quot; button under the &quot;Companies&quot; heading.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;In order to approve a company, you must first enter the company abbreviation into the text field labeled &quot;Abbrev.&quot; This abbreviation must be unique to the system as the abbreviation is used to display a vessel's company in the bookings summary. If you choose to reject the company, it will be deleted from the system and all users that were pending approval to represent the company will receive email notification of the company rejection.</div>
<br>
	<div align="center"><img src="../../images/userCompanyApprovals.gif"></div>
	<div align="center">Figure 5: Approval alerts <br>
	
  </div>
<p><a href="#Top">return to index</a> </p>
<p>
<div style="padding-left:20px;"><em><a name="Users"></a><span class="style11"><strong>3.3 User Administration</strong></span></em><br></div>
  <div style="padding-left:40px;"><strong>3.3.1 Adding a User</strong><br></div>
  <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To add a user, click the &quot;Add&quot; button under the &quot;Users&quot; heading. From there, refer to 2.2.2 through 2.2.4. The process is much like that of creating a new user account for yourself. The user will receive automatic email notification of their new account. Any user-company relationships and any new companies created during this process will be automatically approved.<br>
    <br>
  </div>
  <div style="padding-left:40px;"><strong>3.3.2 Editing a User</strong><br></div>
  <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To edit a profile, including your own, click &quot;Edit&quot; under the &quot;Users&quot; heading. The &quot;Edit User Profile&quot; page will automatically default to your profile. The page is divided into three sections with individual submit buttons for each.<br>
    <br></div>
  <div style="padding-left:60px;"><span class="style14">3.3.2.1 Editing Personal Information</span><br>
  </div>
  <div style="padding-left:80px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The first section (Figure 6) is used to edit first and last names. Email addresses cannot be edited as they act as login IDs. In order to use a different email address, you would have to create a new user account for yourself or the user.<br>
  </div>
  <br>
	<div align="center"><img src="../../images/editUserName.gif"></div>
	<div align="center">Figure 6: Editing user name <br><br>
  </div>
  	<div align="center">Figure 7: Editing user company associations <br><br>
  </div>
  <div style="padding-left:60px;"><span class="style14">3.3.2.2 Editing Passwords</span><br>
  </div>
  <div style="padding-left:80px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The third section (Figure 8) is for changing a user's password. A password for the EGD system must be 6-10 characters long. Passwords are not case-sensitive, so using uppercase letters is not any different from using lowercase.<br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;It is recommended that you make passwords more robust by using a combination of letters and numbers. Frequently changing your own password will also increase the security of your account.
  </div>
	<div align="center"><img src="../../images/editUserPassword.gif"></div>
	<div align="center">Figure 8: Editing user password <br><br>
  </div>
  <div style="padding-left:40px;"><strong>3.3.3 Deleting Users</strong><br></div>
  <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To delete a user, click on the &quot;Delete&quot; button under the &quot;Users&quot; heading. Select the company that the user represents from the &quot;Company&quot; drop down menu - if the user represents more than one company, you may select any of them. Then select the user from the subsequent &quot;User&quot; drop down menu and click the &quot;Delete&quot; button.<br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If the user represents more than one company, the confirmation page will present you with two options: to remove the user only from the company that you originally selected, or to delete the user's account from the system completely. If the user is only associated with one company, the only option will be to delete the user's account from the system.</div>
  <p><a href="#Top">return to index</a> </p>
     <p> <div style="padding-left:20px;"><em><a name="Administrators"></a><span class="style11"><strong>3.4 Administrators</strong></span></em><br></div>
    <div style="padding-left:40px;"><strong>3.4.1 Adding Administrators</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To add an administrator, click on the &quot;Add&quot; button under the &quot;Administrators&quot; heading. Select the desired user, and click &quot;Submit.&quot;<br>
      <br></div>
    <div style="padding-left:40px;"><strong>3.4.2 Removing Administrators</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To remove an administrator, click on the &quot;Remove&quot; button under the &quot;Administrators&quot; heading. Select the desired user, and click &quot;Remove.&quot; Note that this does not delete the user, it simply removes their administrative access, converting them back to a regular user.<br>
      <br></div>
    <div style="padding-left:40px;"><strong>3.4.3 Editing the Administrator Email List</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The administrator email list consists of all administrators that are to receive any automatic email notifications sent via user actions. To edit this list, click on &quot;Edit Email List&quot; under the &quot;Administrators&quot; heading. You can then add or remove any administrators from this list using the check boxes. Then click &quot;Submit&quot; to submit the new list.</p></div>
  <p><a href="#Top">return to index</a> </p>
  <p> <div style="padding-left:20px;"><em><a name="Companies"></a><span class="style11"><strong>3.5 Company Administration </strong></span></em><br></div>
    <div style="padding-left:40px;"><strong>3.5.1 Adding Companies</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To add a new company, click on the &quot;Add&quot; button under the &quot;Companies&quot; heading. All fields are required except &quot;Address 2&quot;, &quot;Province / State&quot;, &quot;Postal Code / Zip Code&quot;, and &quot;Fax.&quot; Both the company name and abbreviation must be unique to the system. The abbreviation is used to display a vessel's company in the bookings summary. Upon submitting the company details, the company profile will be automatically approved and added to the system.<br>
      <br></div>
    <div style="padding-left:40px;"><strong>3.5.2 Editing Companies</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To edit a company, click on the &quot;Edit&quot; button under the &quot;Companies&quot; heading. Select the company name from the drop down menu and click &quot;View.&quot; From here you can edit any of the company details. Keep in mind that all fields are required except &quot;Address 2&quot;, &quot;Province / State&quot;, &quot;Postal Code / Zip Code&quot;, and &quot;Fax,&quot; and the name and abbreviation must be unique to the system.<br>
      <br></div>
    <div style="padding-left:40px;"><strong>3.5.3 Deleting Companies</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To delete a company, click on the &quot;Delete&quot; button under the &quot;Companies&quot; heading. Select the company name from the drop down menu and click &quot;Delete.&quot;<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A company can only be deleted if it meets the following requirements: it must not have any confirmed bookings associated with it, it must not have any vessels associated with it, and it must not have any users associated with it that do not belong to any other companies. If the company does not meet these requirements, you will receive a notification page stating what action needs to be taken in order to delete the company. If a company is eligible for deletion, you will receive a confirmation page and be able to delete the company from the system.</div>
    </p>
  <p><a href="#Top">return to index</a> </p>
  <p> <div style="padding-left:20px;"><em><a name="Vessels"></a><strong class="style11">3.6 Vessel Administration </strong></em><br></div>
    <div style="padding-left:40px;"><strong>3.6.1 Adding Vessels</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To add a vessel, click on &quot;Add&quot; under the &quot;Vessels&quot; heading. Select a company using the drop down menu. All fields are required for creating a vessel record. Length and width are required in meters and block setup and teardown times are required in days.<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If you choose to make the vessel anonymous, any bookings made for this vessel will be shown as anonymous bookings in the calendars and booking summaries. This means that only the dates of the booking and the status are displayed while the booking is either pending or tentative.<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Once a booking is confirmed, the following additional information about the vessel and booking is released: the company, vessel name and length, sections booked and booking time. Any other information about the vessel or booking is withheld from other companies' users. However, as an administrator you will still have access to all the booking and vessel information whether the vessel is anonymous or not.<br>
    <br></div>
    <div style="padding-left:40px;"><strong>3.6.2 Editing Vessels</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Click on &quot;Edit&quot; under the &quot;Vessels&quot; heading. Select the vessel's company and the vessel name from the drop down menus and click &quot;Edit.&quot; From here you will be able to edit any of the vessel's details except the company that it belongs to.<br>
      <br></div>
    <div style="padding-left:40px;"><strong>3.6.3 Deleting Vessels</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Click on &quot;Delete&quot; under the &quot;Vessels&quot; heading. Vessels can only be deleted if they do not have any booking requests associated with them. If they do, you will receive a message displaying the bookings for that vessel which will need to be canceled before the vessel can be deleted. If you can delete the vessel, you will receive a confirmation page for deletion.</div></p>
  <p><a href="#Top">return to index</a> </p>
  <p> <div style="padding-left:20px;"><em><a name="DBMVessels"></a><span class="style11"><strong>3.7 Drydock Booking Management: Vessel Bookings</strong></span></em><br></div>
    <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Drydock booking management can be accessed either from the main &quot;Administrative Functions&quot; page or through the &quot;Drydock Bookings&quot; button in the top menu bar.<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The &quot;Drydock Booking Management&quot; page allows you to view any range of bookings by selecting a date range at the top of the page. The page automatically defaults to display all the bookings for next 30 days, including all current bookings. You can enter the dates either manually in the required &quot;mm/dd/yyyy&quot; format, or by using clicking the &quot;Calendar&quot; buttons to the right.<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;By clicking on one of the calendar buttons, a small calendar will pop up and you can simply click on the desired date. This date will be automatically entered into the associated date box. You can also choose to look at only confirmed, tentative or pending bookings, or any combination of the three types by selecting the check boxes. Clicking the &quot;Submit&quot; button will update the page to reflect your selections.<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The page lists both vessel bookings and maintenance blocks. To view further details for a specific booking, click on the vessel name, or click &quot;Expand All&quot; at the top of the table to view details for all bookings. To collapse the details, click on the vessel name again or on &quot;Collapse All.&quot;<br>
    <br></div>
    <div style="padding-left:40px;"><strong>3.7.1 Adding Drydock Bookings</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Click on &quot;Add New Drydock Booking&quot; at the top or bottom of the table. All fields are required for booking requests. Therefore, the company, vessel and agent must be selected using the drop down menus, and the start and end dates for the booking must be specified. The agent selected will be associated with the booking and will receive any email notification associated with the booking.<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;You can enter the dates in the manner explained above. When selecting docking dates, be sure to consider the amount of time needed for block setup and teardown. (Note: Docking dates are inclusive, i.e. a three day booking is denoted as May 1 to May 3.)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;You must also specify a status for the booking. Should you choose to set the booking as confirmed, you may also need to specify the drydock section(s) for the booking on the following page.<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Upon submitting this booking, if the drydock is available for booking, the booking system will assign a section to the booking and the booking will be added. If there isn't an open slot for the specified date range, you will be given a list of all conflicting confirmed bookings. You can choose to force the booking in by submitting it anyway, or return to the previous page and select a new date range.<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If you have set the booking status as confirmed, and you wish to force the booking in, you must select the section(s) for the booking. If the booking status is pending or tentative, the booking will be added to the wait list for that slot. Once you have submitted a booking, email notification is sent to selected agent informing them that a booking has been made on their behalf.<br>
    <br></div>
    <div style="padding-left:40px;"><strong>3.7.2 Editing Drydock Bookings</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To edit a drydock booking, click the &quot;Edit Booking&quot; link in the booking's details. This will allow you to change the agent associated with the booking as well as the start and end dates, and status of the booking. You can also edit the status directly from the booking's details by clicking on the &quot;Make Pending,&quot; &quot;Make Tentative&quot; and &quot;Make Confirmed&quot; buttons.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If you confirm a booking, and there is space for the vessel during that time slot, the section(s) will be automatically assigned and the booking will be confirmed. If there are confirmed bookings that conflict with this booking, you will be asked if you want to force the booking in by confirming it anyway. To do so, you will need to manually specify the section(s) using the check boxes.<br>
	<br></div>
    <div style="padding-left:40px;"><strong>3.7.3 Tariff of Dock Charges</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Tariff of Dock Charges is generally left for the user to fill out, but administrators have access to view and edit the tariff form. Just click on &quot;View/Edit Tariff Form&quot; under the booking's details.<br>
      <br></div>
    <div style="padding-left:40px;"><strong>3.7.4 Canceling Drydock Bookings</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Both current and future bookings can be canceled. By clicking on &quot;Cancel Booking&quot; in the booking's details, the booking will be canceled and removed from the system, and the agent responsible for the booking will receive email notification of the cancellation. If the agent is no longer with the company, you will be prompted to notify the company directly.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;You will then be presented with a waiting list of all tentative and pending bookings that will now fit into that time slot. It is the administrator's responsibility to contact agents or companies to give 24 hour notice of the cancellation.<br>
	<br></div>
    <div style="padding-left:40px;"><strong>3.7.5 Deleting Past Drydock Bookings</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Past bookings can be deleted by clicking the &quot;Delete Booking&quot; button in the booking's details. This will remove the booking from the system; neither administrators nor agents will be able to view this booking.</div></p>
  <p><a href="#Top">return to index</a> </p>
     <p> <div style="padding-left:20px;"><em><a name="DBMMaintenance"></a><span class="style11"><strong>3.8 Drydock Booking Management: Maintenance Blocks</strong></span></em><br></div>
    <div style="padding-left:40px;"><strong>3.8.1 Adding Drydock Maintenance Blocks</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To add a maintenance block, click on the &quot;Add New Maintenance Block&quot; button at the top of the Maintenance table. All fields are required for a maintenance block, so enter the date range for maintenance and the section(s) that will be affected.<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If the block conflicts with any confirmed bookings, upon clicking &quot;Submit&quot; you will receive a warning message listing the bookings involved. You may choose to submit the maintenance block anyway, or go back to change the date range. Otherwise, the maintenance block will be booked.<br>
    <br></div>
    <div style="padding-left:40px;"><strong>3.8.2 Editing Drydock Maintenance Blocks</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Click on the &quot;Edit&quot; link next to the maintenance block. This allows you to edit the date range and section(s). If the block conflicts with any confirmed bookings, upon clicking &quot;Submit&quot; you will receive a warning message listing the bookings involved. You may choose to submit the maintenance block anyway, or go back to change the date range. Otherwise, the maintenance block will be booked.<br>
      <strong><br>
      </strong></div>
    <div style="padding-left:40px;"><span style="font-weight: bold">3.8.3 Canceling/Deleting Drydock Maintenance Blocks</span><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Click on the &quot;Cancel&quot; or &quot;Delete&quot; link next to the maintenance block. When canceling, you may be presented with a wait list of tentative and pending bookings that can now fit into the available time slot. It is the administrator's responsibility to contact the agents or companies to give them 24 hours notice of the available slot.</div></p>
  <p><a href="#Top">return to index</a> </p>
  <p> <div style="padding-left:20px;"><em><a name="JBMVessels"></a><span class="style11"><strong>3.9 Jetty Booking Management</strong></span></em><span class="style11"><strong><em>: Vessel Bookings</em></strong></span><br></div>
    <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Jetty booking management can be accessed either from the main &quot;Administrative Functions&quot; page or through the &quot;Jetty Bookings&quot; button in the top menu bar.<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The &quot;Jetty Booking Management&quot; page allows you to view any range of bookings by selecting a date range at the top of the page. You can change the dates either manually in the required &quot;mm/dd/yyyy&quot; format, or by using clicking the &quot;Calendar&quot; buttons to the right. By clicking on one of the calendar buttons, a small calendar will pop up and you can simply click on the desired date. This date will be automatically entered into the associated date box. You can also choose to look at only confirmed or pending bookings, or both by selecting the check boxes. Clicking the &quot;Submit&quot; button will update the page to reflect your selections.<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The page lists both vessel bookings for the North Landing Wharf and the South Jetty as well as maintenance blocks. To view further details for a specific booking, click on the vessel name, or click &quot;Expand All&quot; at the top of the table to view details for all bookings. To collapse the details, click on the vessel name again or on &quot;Collapse All.&quot;<br>
    <br></div>
    <div style="padding-left:40px;"><strong>3.9.1 Adding Jetty Bookings</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Click on &quot;Add New North Landing Wharf / South Jetty Booking&quot; at the top or bottom of the tables. All fields are required for jetty bookings. The company, vessel and agent can be selected using the drop down menus. The agent selected will be associated with the booking and will receive any email notification associated with the booking.<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The start and end dates for the booking can be specified in the same manner as described above. (Note: Booking dates are inclusive, i.e. a three day booking is denoted as May 1 to May 3.) The status and desired jetty must also be selected. Upon submitting the booking request, email notification will be sent to the specified agent informing them that the booking has been made on their behalf.<br>
    <br></div>
    <div style="padding-left:40px;"><strong>3.9.2 Editing Jetty Bookings</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To edit a jetty booking, click on the &quot;Edit Booking&quot; link in the booking's details. This will allow you to edit the agent, the start and end dates, the selected jetty and the status of the booking. You can also edit the status directly from the booking's details by clicking on the &quot;Make Pending&quot; and &quot;Make Confirmed&quot; buttons.<br>
      <br></div>
    <div style="padding-left:40px;"><strong>3.9.3 Canceling Jetty Bookings</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Only future and current bookings can be canceled. To cancel a jetty booking, click on the &quot;Cancel Booking&quot; button in the booking's details. This will present you with a confirmation page, and upon confirming the cancellation, email notification will be sent to the agent associated with the booking.<br>
      <br></div>
    <div style="padding-left:40px;"><strong>3.9.4 Deleting Past Jetty Bookings</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Past bookings can be deleted by clicking the &quot;Delete Booking&quot; button in the booking's details. This will remove the booking from the system; neither administrators nor agents will be able to view this booking.<br></div>
    <br>
    <a href="#Top">return to index</a> </p>
  <p> <div style="padding-left:20px;"><em><a name="JBMMaintenance"></a><span class="style11"><strong>3.10 Jetty Booking Management: Maintenance Blocks</strong></span></em><br></div>
    <div style="padding-left:40px;"><strong>3.10.1 Adding Jetty Maintenance Blocks</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To add a maintenance block, click on the &quot;Add New Maintenance Block&quot; button at the top of the Maintenance table. All fields are required for a maintenance block, so enter the date range for maintenance and the section(s) that will be affected.<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If the block conflicts with any confirmed bookings, upon clicking &quot;Submit&quot; you will receive a warning message listing the bookings involved. You may choose to submit the maintenance block anyway, or go back to change the date range. Otherwise, the maintenance block will be booked.<br>
    <br></div>
    <div style="padding-left:40px;"><strong>3.10.2 Editing Jetty Maintenance Blocks</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Click on the &quot;Edit&quot; link next to the maintenance block. This allows you to edit the date range and jetty, or jetties. If the block conflicts with any bookings, upon clicking &quot;Submit&quot; you will receive a warning message listing the bookings involved. You may choose to submit the maintenance block anyway, or go back to change the date range. Otherwise, the maintenance block will be booked.<br>
      <br></div>
    <div style="padding-left:40px;"><strong>3.10.3 Canceling/Deleting Jetty Maintenance Blocks</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Click on the &quot;Cancel&quot; or &quot;Delete&quot; link next to the maintenance block. The maintenance block will be removed from the system.<br></div>
    <br>
    <a href="#Top">return to index</a> </p>
  <p> <div style="padding-left:20px;"><em><a name="Overviews"></a><span class="style11"><strong>3.11 Booking Overviews</strong></span></em><br></div>
    <div style="padding-left:40px;"><strong>3.11.1 Calendars</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The drydock and jetty calendars are accessible through the main &quot;Administrative Functions&quot; page as well as the top menu bar. Both one month and three month views are available (Figure 9). They default to the current month, but any month can be viewed using the drop down menus.<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Each day displays a summary of the confirmed bookings for each section or jetty, as well as how many pending and tentative bookings there are for that day. If you click on the day, you can view a more detailed summary of the bookings for that day, showing the name of the vessel, the booking agent, the status, the section(s) or jetty and the docking dates for each booking. There is also a link to view even further details about the booking and vessel. From this detail page, you have the ability to view or edit the tariff form, edit the booking and cancel or delete the booking.<br>
    <br></div>
    <div style="padding-left:40px;"><strong>3.11.2 Bookings Summary</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Accessible from any of the calendar pages, there is a link to &quot;bookings summary&quot; just under the top menu bar (Figure 9). The bookings summary is a table version of the information provided in the calendars, displayed in the same format as the old bookings summary spreadsheet. It displays the company, the vessel name and length, the booking status, the section(s) or jetty, the docking dates and the date the booking was requested. There is also a printer friendly version of the bookings summary available by clicking the &quot;View Printable Version&quot; button on the bookings summary page.<br>
      <br></div>
    <div style="padding-left:40px;"><strong>3.11.3 Project Calendar</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Accessible from any of the calendar pages, there is a link to &quot;project calendar&quot; just under the top menu bar (Figure 9). The project calendar is an MSProject style view of drydock bookings. When you click on the &quot;project calendar&quot; link, you are presented with a pop-up window. Here you can select a date range for which you would like to view the bookings.<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The project calendar provides the vessel name, docking dates and booking status. You can view the details for all bookings for a particular date, including jetty bookings, by clicking the date link in the left-hand column (Figure 10). There are explicit printing instructions at the top of the project calendar should you wish to print it.<br>
    </div>
    <br>
	<div align="center"><img src="../../images/calMenu.gif"></div>
	<div align="center">Figure 9: Booking overview menu <br><br>
 	 </div>
		<div align="center"><img src="../../images/dateSideBar.gif"></div>
		<div align="center">Figure 10: Project calendar date column <br><br>
	  </div>
    <a href="#Top">return to index</a> <br>
    <br>
    <div style="padding-left:20px;"><em><a name="Forms"></a><span class="style11"><strong>3.12 Booking Forms</strong></span></em><br>
    </div>
    <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;All of the EGD booking forms are available from the main &quot;Administrative Functions&quot; page by clicking on the &quot;Booking Forms&quot; button under the heading &quot;Bookings.&quot;<br>
      <br></div>
    <div style="padding-left:40px;"><strong>3.12.1 PDF Forms</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Schedule 1, the Indemnification Clause and the Tentative Vessel and Change Booking Form are all available in PDF format via the Booking Forms page. Adobe Acrobat Reader is required for viewing them. Click on the words &quot;Adobe Acrobat Reader&quot; to download the software.<br>
      <br></div>
    <div style="padding-left:40px;"><strong>3.12.2 Tariff of Dock Charges</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Tariff of Dock Charges is available in HTML format so that it can be filled out online, and to allow administrators to update the fees.<br>
      <br></div>
    <div style="padding-left:60px;"><span class="style14">3.12.2.1 Updating Dock Charges</span><br>
    </div>
    <div style="padding-left:80px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To update the fees displayed on the tariff form, click the &quot;Update&quot; button next to the form link. From here, you can enter updated prices for those services and facilities with fixed rates or check the &quot;prices vary&quot; box to indicate such. Note that if the prices vary box is checked, any fixed price specified will be disregarded.</p></div>
  <p align="left"> <a href="#Top">return to index</a> </p>
    <p align="left"><div style="padding-left:20px;"><em><a name="LoggingOut" id="LoggingOut"></a><span class="style11"><strong>3.13 Logging Out</strong></span></em><br></div>
    <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To log out click the &quot;Logout&quot; button in the top menu bar. Always log out to ensure that your session has been ended to prevent other people from entering your account on shared computers.<br></div>
    <br>
    <a href="#Top">return to index</a> </p>
</td>
        </tr>
      </table>
	</BODY>
</HTML>
