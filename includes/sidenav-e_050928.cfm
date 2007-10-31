<!---
EDIT 050928 1002
ANDREW LEUNG

ATTEMPT TO RELINK CONTACT US TO EXISTING STATIC PAGES

Currently, we would like to link users to the existing (and working)
EGD contact us page.

Fix: Changed href attribute to Contact Us link
--->
<table width="600" border="0" cellpadding="0" cellspacing="0">
<tr> 
	<td colspan="2" valign="top"> 			

		<table width="132" border="0" cellpadding="0" cellspacing="0" style="background: url(<cfoutput>#RootDir#</cfoutput>images/sidenav_images/bg.gif)">
		<tr>
			<td>
				<table width="132" border="0" cellspacing="0" cellpadding="0" style="background: url(<cfoutput>#RootDir#</cfoutput>images/transp3.gif)">
				<tr>
					<td height="21" width="132"></td>
				</tr>
				<tr valign="middle">
					<td width="132" height="35" valign="top"><a href="<cfoutput>#RootDir#</cfoutput>text/location-e.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('button1','','<cfoutput>#RootDir#</cfoutput>images/sidenav_images/button_location-e_on.gif',1)"><img name="button1" border="0" src="<cfoutput>#RootDir#</cfoutput>images/sidenav_images/button_location-e.gif" width="132" height="35" alt="Location" title="Location"></a></td>
				</tr>
				<tr valign="middle">
					<td width="132" height="35" valign="top"><a href="<cfoutput>#RootDir#</cfoutput>text/services_main-e.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('button2','','<cfoutput>#RootDir#</cfoutput>images/sidenav_images/button_services-e_on.gif',1)"><img name="button2" border="0" src="<cfoutput>#RootDir#</cfoutput>images/sidenav_images/button_services-e.gif" width="132" height="35" alt="Services" title="Services"></a></td>
				</tr>
				<tr valign="middle">
					<td width="132" height="35" valign="top"><a href="<cfoutput>#RootDir#</cfoutput>text/shiprepairfirms-e.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('button3','','<cfoutput>#RootDir#</cfoutput>images/sidenav_images/button_shiprepairfirms-e_on.gif',1)"><img name="button3" border="0" src="<cfoutput>#RootDir#</cfoutput>images/sidenav_images/button_shiprepairfirms-e.gif" width="132" height="35" alt="Ship Repair Firms" title="Ship Repair Firms"></a></td>
				</tr>
				<tr valign="middle">
					<td width="132" height="35" valign="top"><a href="<cfoutput>#RootDir#</cfoutput>text/environment-e.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('button4','','<cfoutput>#RootDir#</cfoutput>images/sidenav_images/button_environment-e_on.gif',1)"><img name="button4" border="0" src="<cfoutput>#RootDir#</cfoutput>images/sidenav_images/button_environment-e.gif" width="132" height="35" alt="Environment" title="Environment"></a></td>
				</tr>
 				<tr valign="middle">
					<td width="132" height="35" valign="top"><a href="<cfoutput>#RootDir#</cfoutput>text/dockdimensions-e.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('button5','','<cfoutput>#RootDir#</cfoutput>images/sidenav_images/button_dockdimensions-e_on.gif',1)"><img name="button5" border="0" src="<cfoutput>#RootDir#</cfoutput>images/sidenav_images/button_dockdimensions-e.gif" width="132" height="35" alt="Dock Dimensions" title="Dock Dimensions"></a></td>
				</tr>
				<tr valign="middle">
					<td width="132" height="35" valign="top"><a href="<cfoutput>#RootDir#</cfoutput>text/victoria-e.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('button6','','<cfoutput>#RootDir#</cfoutput>images/sidenav_images/button_victoria-e_on.gif',1)"><img name="button6" border="0" src="<cfoutput>#RootDir#</cfoutput>images/sidenav_images/button_victoria-e.gif" width="132" height="35" alt="Victoria" title="Victoria"></a></td>
				</tr>
				<tr valign="middle">
					<td width="132" height="35" valign="top"><a href="<cfoutput>#RootDir#</cfoutput>text/history-e.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('button7','','<cfoutput>#RootDir#</cfoutput>images/sidenav_images/button_history-e_on.gif',1)"><img name="button7" border="0" src="<cfoutput>#RootDir#</cfoutput>images/sidenav_images/button_history-e.gif" width="132" height="35" alt="History" title="History"></a></td>
				</tr>
				<tr valign="middle">
					<td width="132" height="35" valign="top"><a href="<cfoutput>#RootDir#</cfoutput>text/booking-e.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('button8','','<cfoutput>#RootDir#</cfoutput>images/sidenav_images/button_booking-e_on.gif',1)"><img name="button8" border="0" src="<cfoutput>#RootDir#</cfoutput>images/sidenav_images/button_booking-e.gif" width="132" height="35" alt="Booking" title="Booking"></a></td>
				</tr>
				<tr valign="middle">
					<td width="132" height="35" valign="top"><a href="<cfoutput>#RootDir#</cfoutput>text/contact_us-e.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('button9','','<cfoutput>#RootDir#</cfoutput>images/sidenav_images/button_contactus-e_on.gif',1)"><img name="button9" border="0" src="<cfoutput>#RootDir#</cfoutput>images/sidenav_images/button_contactus-e.gif" width="132" height="35" alt="Contact Us" title="Contact Us"></a></td>
				</tr>
				<tr>
					<td height="29" width="132"></td>
				</tr>
				</table>

			</td>
		</tr>
		</table>
			
			<!--fin de votre propre barre de navigation lat&eacute;rale/end sub-site side nav-->

      <!--DO NOT REMOVE THE ANCHOR BELOW-->
      <p><a name="skipnav"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="1" height="1" border="0" alt=""></a></p>
      <!--DO NOT REMOVE THE ANCHOR ABOVE-->
    </td>

	<TD width="18">&nbsp;</TD>

    <td valign="top"> 
      <table width="432" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td><!---<img src="<cfoutput>#RootDir#</cfoutput>images/pixel_blue.gif" width="450" height="1" border="0" alt="">--->