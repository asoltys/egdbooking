<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Jetty Booking Management"">
<meta name=""keywords"" lang=""eng"" content="""">
<meta name=""description"" lang=""eng"" content="""">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2005-07-25"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Add Administrator</title>
">

<cfinclude template="#RootDir#includes/header-#lang#.cfm">

<cfquery name="getUserList" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT UserID, LastName + ', ' + FirstName AS UserName
	FROM Users
	WHERE Deleted = 0 
	AND NOT EXISTS (SELECT	UserID
					FROM	Administrators
					WHERE	Users.UserID = Administrators.UserID)
	AND EXISTS (SELECT	*
				FROM	UserCompanies
				WHERE	UserCompanies.UserID = Users.UserID AND Approved = 1)
	ORDER BY LastName, Firstname
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

<div class="breadcrumbs">
	<a href="<cfoutput>http://www.pwgsc.gc.ca/text/home-#lang#.html</cfoutput>">PWGSC</a> &gt; 
	Pacific Region &gt; 
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-e.html">Esquimalt Graving Dock</a> &gt; 
  <CFOUTPUT>
		<a href="#RootDir#text/booking-#lang#.cfm">Booking</A> &gt;<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
			<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
		<CFELSE>
			 <a href="#RootDir#text/booking/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
		</CFIF>
	</CFOUTPUT>
	Add Administrator
</div>

<div class="main">
<H1>Add Administrator</H1>
<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>

<cfif IsDefined("Session.Return_Structure")>
	<!--- Populate the Variables Structure with the Return Structure.
			Also display any errors returned --->
	<cfinclude template="#RootDir#includes/getStructure.cfm">
</cfif>

<!---<div align="left">
	<cfform action="addAdministrator_action.cfm?lang=#lang#" name="chooseUserForm" method="post">
		<cfselect name="UserID" query="getUserList" value="UserID" display="UserName" />
		<a href="javascript:EditSubmit('chooseUserForm');">Add</a>
	</cfform>
</div>--->

<cfform action="addAdministrator_action.cfm?lang=#lang#" name="addAdministratorForm" method="post">
	Select User: <cfselect name="UserID" query="getUserList" value="UserID" display="UserName" />
	&nbsp;&nbsp;&nbsp;
	<!--a href="javascript:EditSubmit('addAdministratorForm');" class="textbutton">Submit</a-->
	<input type="submit" name="submitForm" value="Submit" class="textbutton">
	<CFOUTPUT><input type="button" name="cancel" value="Cancel" class="textbutton" onClick="self.location.href='../menu.cfm?lang=#lang#'"></CFOUTPUT>
</cfform>

</div>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">