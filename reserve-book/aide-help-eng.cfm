<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>
			Esquimalt Graving Dock (EGD) Online Booking System: User Documentation
		</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
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
 
 .red {
  color: #FF0000;
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
 .style11 {
	font-size: 13pt;
	font-weight: bold;
	}
 .style12 {
	font-weight: bold;
	font-style: italic;
	}

h1 {
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
</style>
	</head>
	
	<body bgcolor="#FFFFFF" text="#000000">
	
			
	<div style="text-align:center;" class="style1">
	  <table style="width:58%;"  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td style="width:100%;">
            <p><a name="Top"></a><h1>Esquimalt Graving Dock (EGD) Online Booking System: User Documentation</h1>
            </p>
            <P class="style1">Table of Contents</p>
            <P align="left"><span class="style2"><strong><a href="#Overview">1. Overview</a></strong></span></p>
            <div style="padding-left:0px;"><strong><a href="#GettingStarted">2. Getting Started</a></strong><br />
            </div>
            <div style="padding-left:20px;"><em><a href="#SystemReqs">2.1 System Requirements</a><br />
                  <a href="#CreateAccount">2.2 Creating a User Account</a></em><br />
            </div>
            <div style="padding-left:40px;">2.2.1 Where to Start<br />
			  2.2.2 User Company/Companies<br />
			  2.2.3 Creating a Company Account<br />
			  2.2.4 Activating a User Account <br />
            </div>
            <div style="padding-left:20px;"><em><a href="#LoggingIn">2.3 Logging In</a><br />
                  <a href="#GetPassword">2.4 Password Retrieval</a></em><a href="#GetPassword">
                  </a><br />
                  <br />
            </div>
            <span class="style2">
            <div style="padding-left:0px;"><strong><a href="#UsingApp">3. Using the EGD Online Booking System </a></strong></div>
            </span>
            <div style="padding-left:20px;"><em><a href="#HomePage">3.1 Welcome Page</a></em><br /></div>
			 <div style="padding-left:40px;">3.1.1 Companies<br />
 				 3.1.2 Bookings
            </div>
             <div style="padding-left:20px;"><em><a href="#EditProfile">3.2 Editing User Profile</a></em><br />
            </div>
            <div style="padding-left:40px;">3.2.1 Editing Personal Information<br />
            3.2.2 Editing Your Password            </div>
            <div style="padding-left:20px;"><em><a href="#Vessels">3.3 Vessels</a> </em><br />
            </div>
            <div style="padding-left:40px;">3.3.1 Adding Vessels<br />
			  3.3.2 Editing Vessels<br />
			  3.3.3 Deleting Vessels<br />
            </div>
            <div style="padding-left:20px;"><em><a href="#Bookings">3.4 Bookings</a></em><br />
            </div>
            <div style="padding-left:40px;">3.4.1 Requesting Drydock Bookings<br /></div>
			<div style="padding-left:60px;"><span class="style8">3.4.1.1 Requesting with Specific Dates<br />
				3.4.1.1 Requesting Next Available Slot</span><br /></div>
			<div style="padding-left:40px;">
			  3.4.2 Requesting Jetty Bookings<br />
			  3.4.3 Editing Bookings<br />
			  3.4.4 Canceling Bookings<br />
			  3.4.5 Administrative Cancellations and Deletions<br />
			  3.4.6 24 Hour Notice<br />
            </div>
            <div style="padding-left:20px;"><em><a href="#Overviews">3.5 Booking Overviews</a></em><br />
            </div>
            <div style="padding-left:40px;">3.5.1 Calendars<br />
 				 3.5.2 Bookings Summary<br />
            </div>
            <div style="padding-left:20px;"> <em><a href="#Forms">3.6 Booking Forms</a> </em><br />
            </div>
            <div style="padding-left:40px;">
  				3.6.1 Tariff of Dock Charges<br />
  				3.6.2 Schedule 1<br />
  				3.6.3 Indemnification Clause<br />
  				3.6.4 Tentative Vessel and Change Booking Form<br />
            </div>
            <div style="padding-left:20px;"><em><a href="#LoggingOut">3.7 Logging Out</a> </em><br />
            </div>
            
            <p>           
            <hr width="75%">
            <p><strong><br />
              <br />
            <a name="Overview"></a><span class="style10">1. Overview</span></strong><br />
            <div style="padding-left:20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Esquimalt Graving Dock (EGD) Online Booking System is a  convenient way to reserve space  for  the EGD facilities online.  The system  allows users to monitor the status of their drydock and jetty bookings, and provides access to all related activities.</div>
            <br />
            <a href="#Top">return to index</a>
            <p></p>
            <p><strong><br />
                  <a name="GettingStarted"></a><span class="style10">2. Getting Started </span></strong><br />
            <div style="padding-left:20px;"><em><a name="SystemReqs"></a><strong class="style11">2.1 System Requirements</strong></em></div>
            <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Before logging in, ensure that your browser meets the following system requirements:
                <ul>
                  <li><a href="http://browser.netscape.com/ns8/" target="_blank">Netscape 4+</a> (<a href="http://browser.netscape.com/ns8/download/archive72x.jsp" target="_blank">link to older versions</a>), <a href="http://www.microsoft.com/windows/ie/downloads/critical/ie6sp1/default.mspx" target="_blank">Internet Explorer 4+</a>, or <a href="http://www.mozilla.org/products/firefox/" target="_blank">Mozilla Firefox</a></li>
                  <li>JavaScript enabled</li>
                  <li>Cookies enabled</li>
                  <li><a href="http://www.adobe.com/products/acrobat/readstep2_allversions.html" target="_blank">Adobe Acrobat Reader</a> installed</li>
                </ul>
                To install any of the required software, follow the links above. If you have trouble enabling JavaScript or Cookies, follow these guidelines:
                <ul>
                  <li>Netscape 4: Go to Edit &gt; Preferences &gt; Advanced to enable both. </li>
                  <li>Netscape 7 or 8: Go to Edit &gt; Preferences. JavaScript can be enabled under Advanced and Cookies under Privacy &amp; Security.</li>
                  <li>Internet Explorer 6: Go to Tools &gt; Internet Options. JavaScript can be enabled under Advanced and Cookies under Privacy.</li>
                  <li>Mozilla Firefox: Go to Tools &gt; Options. JavaScript can be enabled under Web Features and Cookies under Privacy</li>
                </ul>
            </div>
            <a href="#Top">return to index</a>
            <p></p>
            <p>            
            <div style="padding-left:20px;"> <em><a name="CreateAccount"></a><span class="style11"><strong>2.2 Creating a User Account</strong></span></em>
            </div>
            <div style="padding-left:40px;"><strong>2.2.1 Where to Start</strong><br />
            </div>
            <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Go to the main EGD page: <a href="http://www.pwgsc.gc.ca/pacific/egd/index-e.html">http://www.pwgsc.gc.ca/pacific/egd/index-e.html</a> and click &quot;Booking&quot; in the side menu bar. Click  the &quot;Booking Application&quot; link, then click &quot;Add new user account.&quot;  Enter your  details, including: first name, last name, 6-10 character password and email address, all of which are required.  The email address provided will be used for logging in and receiving email notification from EGD.  Your password is not case-sensitive, so using uppercase letters is no different from using lowercase.  For a more robust password,  use both letters and numbers.
              <br />
              <br />
            </div>
            <div style="padding-left:40px;"><strong>2.2.2 User Company/Companies</strong><br />
            </div>
            <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;On the next page,  add to your profile the company or companies that you represent.  Select your company from the drop down menu and click "Add."  This can be repeated as many times as necessary.  If the company that you represent is not listed, see 2.2.3.<br />
              <br />
            </div>
            <div style="padding-left:40px;"><strong>2.2.3 Creating a Company Account</strong><br />
            </div>
            <div style="padding-left:60px;">
              <div style="text-align:left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Click  the &quot;here&quot; link underneath the drop down menu (Figure 1) to create a company.  Every field is required except "Address 2" and "Fax."  Clicking "submit" will create the company account and notify  EGD  of the new company request.  The company will have to be approved before becoming active.<br />
              </div>
            </div>
				<br />
                <div style="text-align:center;"><img src="../images/aide-help/entrpajout-compadd-eng.gif" alt="Figure 1: Adding a new company"></div>
                <div style="text-align:center;">Figure 1: Adding a new company <br />
                
              </div>
            <div style="padding-left:40px;"><br />
            <strong>2.2.4 Activating a User Account</strong>            </div>
            <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Once  your companies have been added, click "Submit New User Request."  This  submits your account request, and notifies EGD administration.  Your account must be approved before becoming active.  If you  added multiple companies to your profile, they do not all need approval to activate your account.  You will receive email notification when a user-company association is approved or rejected.
              <p></p>
            </div>
            <p><a href="#Top">return to index</a> </p>
            <p>
            <div style="padding-left:20px;"><em><a name="LoggingIn"></a><strong class="style11">2.3 Logging In</strong><br />
            </em></div>
            <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Only one user-company association approval is required for account activation.  Once you receive email notification that one of your user-company associations is approved, login  using the email address and password that you specified  creating your account. Go to <a href="http://www.pwgsc.gc.ca/pacific/egd/index-e.html">http://www.pwgsc.gc.ca/pacific/egd/index-e.html</a> and click on &quot;Booking&quot; in the side menu bar. Then click  the &quot;Booking Application&quot; link. This brings you to the  login page.</div>
            <p></p>
            <a href="#Top">return to index</a> <br />
            <p>            
            <div style="padding-left:20px;"><em><a name="GetPassword"></a><strong class="style11">2.4 Password Retrieval</strong><br />
            </em></div>
            <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If you  forget your password, click  the "Forgot password" link at the login page.  Enter the email address that you use to login, and your password will be emailed to you.<br />
            </div>
            <br />
            <a href="#Top">return to index</a>
            <p></p>
            <p>     <br />       
            <strong><a name="UsingApp"></a><span class="style10">3. Using the EGD Online Booking System</span></strong>
            
            <div style="padding-left:20px;"><em><a name="HomePage"></a><span class="style11"><strong>3.1 Welcome Page</strong></span></em><br />
            </div>
            <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Logging in presents you with the booking system "Welcome Page."  You can access all of the booking system functionality from this page.  All major functions are  available in the menu bar beneath the page title (Figure 2).  You can also navigate  the site  using the breadcrumbs (Figure 3).  Breadcrumbs track the path you have taken through the site, so they can be used to navigate backwards through the pages used to get to where you currently are.</div>
            <br />
                <div style="text-align:center"><img src="../images/aide-help/utilisateur-user-menu-eng.gif" alt="Figure 2: Menu bar"></div>
                <div style="text-align:center;">Figure 2: Menu bar <br />
                </div>
			<br />
                <div style="text-align:center;"><img src="../images/aide-help/utilisateur-user-pain-bread-eng.gif" alt="Figure 3: Breadcrumbs"></div>
                <div style="text-align:center;">Figure 3: Breadcrumbs <br />
            <br />
            </div>
			<div style="padding-left:40px;"><strong>3.1.1 Companies</strong></div>
			<div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Welcome Page  displays information for one company at a time.  The name of the company whose information you are currently viewing is displayed in the title.  If you have approval to represent more than one company,  the current company will be displayed beneath the menu bar and  additional companies will be listed just below this (Figure 4).  You can toggle between company details by clicking  the company names.  Any companies that you are waiting to get approval to represent will be listed just below your company list.<br />
			  <br />
                <div style="text-align:center;"><img src="../images/aide-help/entreprises-companies-eng.gif" alt="Figure 4: Your companies"></div>
                <div style="text-align:center;">Figure 4: Your companies <br />
                </div>
			</div>
			<br />
			<div style="padding-left:40px;"><strong>3.1.2 Bookings</strong></div>
			<div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;All  current and future bookings for the company you are currently viewing are displayed on the Welcome Page.  For a complete listing, including past bookings,  click  the "All Bookings" button.<br />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Bookings are divided into "Drydock," "North Landing Wharf" and "South Jetty" bookings. Only essential  details are displayed: vessel name, docking dates, booking status and  booking agent.  Clicking  the vessel name links you to further booking details, and options for editing and canceling bookings.  For drydock bookings there is also a link to "View Tariff Form" or "Edit Tariff Form."  Please see 3.6.1 for further information on tariff forms.</div>
		   
		    <p><a href="#Top">return to index</a> </p>
<p>
<div style="padding-left:20px;"><em><a name="EditProfile"></a><span class="style11"><strong>3.2 Editing User Profile</strong></span></em><br /></div>
  <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To edit your profile, click "Edit Profile" in the menu bar.  The "Edit Profile" page is divided into three sections with individual submit buttons for each section.<br />
    <br />
  </div>
  <div style="padding-left:40px;"><strong>3.2.1 Editing Personal Information</strong><br /></div>
  <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The first section is  for editing your first and last names.  Your email address cannot be edited as it is your login ID.  In order to use a different email address, you  must create a new user account.<br />
    <br />
  </div>
	<div style="text-align:center;"><img src="../images/aide-help/utilisateur-user-profilmod-profileedit-eng.gif" alt="Figure 5: Editing your name"></div>
	<div style="text-align:center;">Figure 5: Editing your name <br /><br />
  </div>
  <div style="padding-left:40px;"><strong>3.2.2 Editing Your Password</strong><br />
  </div>
  <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The third section is for changing your password, which must be 6-10 characters long.  Your password is not case-sensitive, so using uppercase letters is no different than using lowercase.  For a more robust password,  use both letters and numbers.  Increase the security of your account by frequently changing your password.</div>
  <br /><div style="text-align:center;"><img src="../images/aide-help/passechangement-passchange-eng.gif" alt="Figure 7: Editing your password"></div>
	<div style="text-align:center;">Figure 7: Editing your password <br />
  </div>
  <p><a href="#Top">return to index</a> </p>
  
  <p> <div style="padding-left:20px;"><em><a name="Vessels"></a><span class="style11"><strong>3.3 Vessels</strong></span></em><br /></div>
    <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A company's vessels are listed on the Welcome Page under "Vessel(s)." If the vessel you are looking for is not listed, check to make sure that you are  viewing the details for the correct company. To view vessel details,  click  the vessel name.<br />
      <br />
    </div>
	<div style="padding-left:40px;"><strong>3.3.1 Adding Vessels</strong><br /></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Click "Add Vessel" under the company vessel list.  All fields are required.  Length and width are  in metres, and block setup and teardown times are  in days.  Block setup time is the number of days required to set up the support blocks before the water can be drained from the dock, and block teardown time is the number of days needed to reverse the process. These   must be included in the number of days requested for a booking.<br />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If a vessel is anonymous, any bookings  for this vessel will be anonymous  in the calendars and booking summaries.  Therefore, only the dates of the booking and the status are displayed while the booking is  pending or tentative.  Upon confirmation, the following additional information is released: the company, vessel name and length, sections booked and booking time.  Any other information about the vessel or booking is withheld from other companies' users.  EGD administrators  have access to all  booking and vessel information regardless of anonymity.<br />
    <br /></div>
    <div style="padding-left:40px;"><strong>3.3.2 Editing Vessels</strong></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Click  the vessel name under "Vessel(s)," then click the "Edit Vessel" button.  You  can edit any  vessel details except the company,  provided the vessel does not have any confirmed bookings.  If it does, you will not be able to edit the vessel dimensions.  To do so, you must contact EGD administration.  Administration will be notified when vessel details are edited.<br />
      <br /></div>
    <div style="padding-left:40px;"><strong>3.3.3 Deleting Vessels</strong></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Click  the vessel name under "Vessel(s)," then click the "Delete Vessel" button.  Vessels can only be deleted if there aren't any booking requests for them.  If there are, you will receive a message displaying  the bookings for that vessel which  need to be canceled before the vessel can be deleted.  If you can delete the vessel, you will receive a confirmation page for deletion.</div>
    </p>
  <p><a href="#Top">return to index</a> </p>
  <p> <div style="padding-left:20px;"><em><a name="Bookings"></a><span class="style11"><strong>3.4 Bookings</strong></span></em></div>
    <div style="padding-left:40px;"><strong>3.4.1 Requesting Drydock Bookings</strong></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Click "Request New Booking" under "Your current bookings..." or "Request Booking" in the menu bar, and then select the drydock booking option.  There are two ways to request a drydock booking, using specific dates or requesting the next available slot within a given date range for a specified number of days (i.e. Request the next available 10 day booking within the next year.).<br />
      <br />
    </div>
	<div style="padding-left:60px;"><span class="style12">3.4.1.1 Requesting with Specific Dates</span><br /></div>
	  <div style="padding-left:80px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;All fields are required for booking requests.  The company and vessel must be selected using the drop down menus, and the start and end dates for the booking must be specified.  You can  manually enter the dates in the "mm/dd/yyyy" format or use the calendar buttons.  By clicking  one of the calendar buttons, a small calendar will pop up and you can  click  the desired date.  This date will be  entered into the associated date box.  When selecting docking dates, be sure to consider the amount of time needed for block setup and teardown.  (<em>Note</em>: Docking dates are inclusive, i.e. a three day booking is denoted as May 1 to May 3.)<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Upon submitting a  request, if the drydock is  available for booking, your request will be submitted. If there is not an open slot for the specified dates, you have the option of trying a different date range, or continuing with the request in case a cancellation is made, and the slot  becomes available.  Please see 3.4.6 for details on the 24 hour notification process for cancellations.<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Once you  submit a booking, email notification is sent to EGD administration and you are presented with the Tariff of Dock Charges.  This is an optional form; for more information see 3.6.1.<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;It is the responsibility of EGD administration to approve the booking; however, once you have received email notification of approval, you must send in the appropriate forms - Schedule 1 and the Indemnification Clause - and the $3,500.00 booking fee before the booking can be confirmed.  Please refer to section 3.6 for more information on the required forms.<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If your booking is approved and there are other tentative bookings competing for the same time slot, the 24 hour notice policy will be followed (Section 3.4.6). You will be notified via email if your booking is confirmed.<br />
        <br />
        </div>
    <div style="padding-left:60px;"><span class="style12">3.4.1.2 Requesting Next Available Slot</span></div>
	<div style="padding-left:80px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;All fields are required, so the company and vessel must be selected using the drop down menus, a date range must be specified in the same manner as described in 3.4.1.1, and the number of days required for the booking must be specified.  The number of days for the booking must be less than or equal to the length of the given date range.<br />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Upon submitting a request, you will be given the next available date range for the booking length specified.  If this is acceptable, you can request the booking; if not, you can try a different date range. (<em>Note</em>: If you use the alternate requesting method, which takes specific dates, even if that date range is unavailable, if your booking is approved you will be added to a wait list in case a cancellation is made, and the 24 hour notification policy will be followed.  Please refer to 3.4.6 for more information. The method of requesting the next available slot does not provide this option.)<br />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Once you  submit a booking, email notification is sent to EGD administration and you are  presented with the Tariff of Dock Charges.  This is an optional form; for more information see 3.6.1.<br />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;It is the responsibility of EGD administration to approve the booking; however, once you have received email notification of approval, you must send in the appropriate forms - Schedule 1 and the Indemnification Clause - and the $3,500.00 booking fee before the booking can be confirmed.  Please see section 3.6 for more information on the required forms.<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If your booking is approved and there are other tentative bookings competing for the same time slot, the 24 hour notice policy will be followed (Section 3.4.6). You will be notified via email if your booking is confirmed..<br />
	<br />
	</div>
	<div style="padding-left:40px;"><strong>3.4.2 Requesting Jetty Bookings</strong></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Click "Request New Booking" under "Your current bookings..." or "Request Booking" in the menu bar, and  select the jetty booking option.  All fields are required for jetty bookings.  The company, vessel and  jetty can be selected using the drop down menus.  The start and end dates  can be specified in the same manner as described in 3.4.1.1.<br />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Upon submitting a request, EGD administration will be notified.  To have the booking confirmed, you must send in the required Schedule 1 and Indemnification forms.  Please refer to 3.6 for more information on required forms. You will be notified via email if your booking is confirmed.  There is no fee for jetty bookings, but  if the vessel does not arrive for the booked time, the company will be charged a booking fee.<br />
	<br />
    </div>
    <div style="padding-left:40px;"><strong>3.4.3 Editing Bookings</strong><br /></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Bookings cannot be edited online.  If you wish to amend a booking, you must contact EGD administration and mail  or fax a hard copy of the Tentative Vessel and Change Booking Form. A PDF version of this form is available online. Go to the Welcome Page and click &quot;Booking Forms&quot; at the top of your booking listings.<br />
      <br />
    </div>
    <div style="padding-left:40px;"><strong>3.4.4 Canceling Bookings</strong><br /></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Future and current bookings can be canceled.  To cancel bookings, click the vessel name in the booking listing on either the Welcome Page or Bookings Archive page, then click the "Request Cancellation" button.  By requesting a cancellation, EGD administration will be notified of the request and your cancellation will be considered pending until you receive further notificaiton.  If you do not receive notification of your booking being canceled, the booking will go ahead as scheduled.<br />
	<br />
    </div>
    <div style="padding-left:40px;"><strong>3.4.5 Administrative Cancellations and Deletions</strong><br /></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;EGD administration has the ability to cancel current or future bookings, as well as delete past bookings.  You will be notified via email if one of your bookings has been canceled.  If administration deletes a past booking, you will not be notified, but you will notice that it is no longer listed in your archived bookings.<br />
      <br />
    </div>
  	<div style="padding-left:40px;"><strong>3.4.6 24 Hour Notice</strong><br /></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;EGD has a 24 hour notice policy regarding wait lists.  If there are multiple tentative bookings competing for a particular time slot in the drydock,  the policy runs on a first come, first served basis.  Therefore, the first company to have requested this time is entitled to the position provided they pay the booking fee and submit the required forms.<br />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;However, if another company further down on the wait list offers the booking fee and forms first, all companies with tentative bookings requested before this one are given 24 hours notice to pay the booking fee, starting from the top of the list. The company highest on the list will be notified first, if they choose to decline the time slot, the next company will be notified, and so on.  If none of these companies offers the booking fee within their allotted time, the original company making the confirmation request receives the time slot.  The same policy is applied when time slots are made available due to cancellations.<br />
    </div></p>
  <p><a href="#Top">return to index</a> </p>
     
  <p> <div style="padding-left:20px;"><em><a name="Overviews"></a><span class="style11"><strong>3.5 Booking Overviews</strong></span></em></div>
    <div style="padding-left:40px;"><strong>3.5.1 Calendars</strong><br /></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The drydock and jetty calendars are accessible through the top menu bar.  One month and three month views are available (Figure 8).  They default to the current month, but any month can be viewed using the drop down menus.  Each day displays a summary of the confirmed bookings for each section or jetty, as well as how many pending and tentative bookings there are for that day.  By clicking on a date, you can view a more detailed summary of the bookings for that day.<br />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If a vessel is anonymous and the booking unconfirmed, it will be listed as "Deepsea Vessel" with only the status and docking dates available.  Once confirmed, a limited amount of additional information becomes available. For publicly viewable vessels, there is  a link to even  further details about the booking and vessel.<br /> 
	<br />
    </div>
    <div style="padding-left:40px;"><strong>3.5.2 Bookings Summary</strong><br /></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Accessible from any of the calendar pages, there is a "bookings summary" link  just under the top menu bar (Figure 8).  The bookings summary is a table version of the information provided in the calendars.  It displays the vessel name and length,  booking status,  section(s) or jetty,  docking dates and the date the booking was requested.  There is  a printer friendly version available by clicking the "View Printable Version" button.<br />
    </div></p>
	<div style="text-align:center;"><img src="../images/aide-help/utilisateur-user-resume-summary-eng.gif" alt="Figure 8: Booking overview menu"></div>
	<div style="text-align:center;">Figure 8: Booking overview menu <br /><br />
 	 </div>
    <a href="#Top">return to index</a> <br />
    <br />
    <div style="padding-left:20px;"><em><a name="Forms"></a><span class="style11">3.6 Booking Forms</span></em></div>
    <div style="padding-left:40px;"><strong>3.6.1 Tariff of Dock Charges</strong><br /></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The tariff form is an optional form that allows you to specify the services and facilities that will be required, allowing EGD to have sufficient resources available during your booking. Once your booking is confirmed, you should confirm your exact needs directly with EGD. <br />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;You are presented with the form  after requesting a booking.  You can fill it out then, or opt to do so later.  If you wish to edit or fill the form out later, you can do so from the Welcome Page.  Tariff forms can be edited for pending and tentative bookings.  Click the "Edit Tariff Form" link on the booking listing to make changes or to fill the form out for the first time.  If a booking is confirmed, view the tariff form by clicking "View Tariff Form."  Contact EGD  to make changes to the tariff form for a confirmed booking.<br />
	<br />
    </div>
    <div style="padding-left:40px;"><strong>3.6.2 Schedule 1</strong><br /></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Schedule 1 provides information about the vessel and acts as an agreement between the booking agent and EGD.  Schedule 1 must be received by EGD before a booking can be confirmed.<br />
      <br />
    </div>
    <div style="padding-left:40px;"><strong>3.6.3 Indemnification Clause</strong><br /></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Indemnification Clause is a legal disclaimer that  indemnifies the Crown against liability for injuries or damages for the entire time the vessel is at EGD. It must be received by EGD before a booking can be confirmed.<br />
      <br />
    </div>
    <div style="padding-left:40px;"><strong>3.6.4 Tentative Vessel and Change Booking Form</strong><br /></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Tentative Vessel and Change Booking Form must be sent in to EGD to request a change in docking dates for a booking.<br />
    </div>
  <P align="left"> <a href="#Top">return to index</a> </p>
    <P align="left"><div style="padding-left:20px;"><em><a name="LoggingOut" id="LoggingOut"></a><span class="style11">3.7 Logging Out</span></em><br /></div>
    <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To log out click the "Logout" button in the top menu bar.  Always log out to end your session to prevent other people from entering your account on shared computers.<br />
    </div>
    </p>
    <a href="#Top">return to index</a> </td>
        </tr>
      </table>
	<a href="aide-help-fra.html">aide-help-fra</a>
	</body>
</html>
