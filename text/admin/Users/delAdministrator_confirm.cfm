<cfinclude template="#RootDir#includes/header-#lang#.cfm">

<cfif isDefined("form.userID")><cfinclude template="#RootDir#includes/build_form_struct.cfm"></cfif>
<cfinclude template="#RootDir#includes/restore_params.cfm">

<cflock scope="session" throwontimeout="no" type="readonly" timeout="60">
	<cfquery name="getAdmin" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT Users.UserID, FirstName + ' ' + LastName AS UserName
		FROM Users
		WHERE UserID = #form.UserID#
	</cfquery>
</cflock>

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
	Confirm Delete Administrator
</div>

<div class="main">
<H1>Confirm Delete Administrator</H1>
<CFINCLUDE template="#RootDir#includes/admin_menu.cfm"><br>

<cfif IsDefined("Session.Return_Structure")>
	<!--- Populate the Variables Structure with the Return Structure.
			Also display any errors returned --->
	<cfinclude template="#RootDir#includes/getStructure.cfm">
</cfif>

<cfform action="delAdministrator_action.cfm?lang=#lang#" method="post" name="delAdministratorConfirmForm">
	<div align="center">
		Are you sure you want to remove <cfoutput><strong>#getAdmin.UserName#</strong></cfoutput> from administration?
		<BR><BR>
		<!---a href="javascript:EditSubmit('delAdministratorConfirmForm');" class="textbutton">Remove</a>
		<a href="delAdministrator.cfm" class="textbutton">Back</a>
		<a href="../menu.cfm?lang=#lang#" class="textbutton">Cancel</a--->
		<input type="submit" value="Remove" class="textbutton">
		<cfoutput><input type="button" value="Back" onClick="self.location.href='delAdministrator.cfm?lang=#lang#'" class="textbutton"></cfoutput>
		<cfoutput><input type="button" value="Cancel" onClick="self.location.href='#RootDir#text/admin/menu.cfm?lang=#lang#'" class="textbutton"></cfoutput>

	</div>
	
	<input type="hidden" name="userID" value="<cfoutput>#form.UserID#</cfoutput>">
</cfform>

</div>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">