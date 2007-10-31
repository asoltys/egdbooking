<!--begin clf fip-e.html--> 
<table width="600" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td colspan="3"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="10" height="10" border="0" align="top" alt=""></td>
  </tr>
  <tr> 
    <td colspan="2"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="92" height="1" border="0" align="top" alt=""></td>
    <td><img src="<cfoutput>#RootDir#</cfoutput>images/pwgsc-e.gif" width="364" height="33" alt="Public Works and Government Services Canada" title="Public Works and Government Services Canada" border="0"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="61" height="1" border="0" align="top" alt=""><img src="<cfoutput>#RootDir#</cfoutput>images/wordmark.gif" width="83" height="21" alt="Canada wordmark" title="Canada workmark" border="0" align="top"></td>
  </tr>
  <tr> 
    <td colspan="3"><a href="#skipnav"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="14" height="3" border="0" alt="Skip navigation links"></a></td>
  </tr>
  <tr> 
    <td colspan="3"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="14" height="14" border="0" alt=""></td>
  </tr>
</table>
<!--end clf fip-e.html-->

<!--d&eacute;but des boutons noirs de navigation/start sub-site black navigation buttons-->
<table width="600" border="0" cellspacing="0" cellpadding="0">
  <tr align="left" valign="top"> 
		
    <td width="150"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="150" height="14" alt=""></td>
		
    <td width="89"><a href="<cfoutput>#RootDir#</cfoutput>text/language.cfm"><span lang="fr"><img src="<cfoutput>#RootDir#</cfoutput>images/nav1st_level_lang-e.gif" width="89" height="14" vspace="0" hspace="0" border="0" alt="Fran&ccedil;ais"></span></a></td>
		
    <td width="90" align="left" valign="top"><a href="http://www.pwgsc.gc.ca/pacific/egd/text/contact_us-e.html"><img src="<cfoutput>#RootDir#</cfoutput>images/nav1st_level_contact-e.gif" width="90" height="14" vspace="0" hspace="0" border="0" alt="Contact Us"></a></td>
		
    <td width="90" align="left" valign="top"><a href="<cfoutput>#RootDir#</cfoutput>text/help-e.cfm"><img src="<cfoutput>#RootDir#</cfoutput>images/nav1st_level_help-e.gif" width="90" height="14" vspace="0" hspace="0" border="0" alt="Help"></a></td>
		
    <td width="90" align="left" valign="top"><a href="http://www.pwgsc.gc.ca/pacific/egd/text/search-e.html"><img src="<cfoutput>#RootDir#</cfoutput>images/nav1st_level_search-e.gif" width="90" height="14" vspace="0" hspace="0" border="0" alt="Search"></a></td>
		
    <td width="91" align="left" valign="top"><a href="http://www.canada.gc.ca/main_e.html"><img src="<cfoutput>#RootDir#</cfoutput>images/nav1st_level_canada-e.gif" width="91" height="14" vspace="0" hspace="0" border="0" alt="Canada Site"></a></td>
        </tr>
	<tr align="left" valign="top"> 
		
    <td colspan="6"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="600" height="2" alt=""></td>
        </tr>
</table>
<!--fin des boutons noirs de navigation/end sub-site black navigation buttons-->

<!--start blue corporate nav buttons-->
<CFHTTP url="http://www.pwgsc.gc.ca/clf02/ssi/corp-nav-e.html" resolveurl="yes" method="get" timeout="10"></CFHTTP>
<CFOUTPUT>#cfhttp.filecontent#</CFOUTPUT>
<!--end blue corp nav buttons-->

<!--d&eacute;but de la banni&egrave;re/start banner graphic-->
<table cellspacing=0 cellpadding=0 width=600 border=0>
  <tbody> 
  <tr> 
    <td width=122 height=39><img height=1 src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width=122 alt=""></td>
    <td width=28 height=39 align="right"><!-- <img height=39 src="<cfoutput>#RootDir#</cfoutput>images/header_left_leaf2-b.gif" alt="" width=28> --></td>
    <td width=450 height=39><img height=39 alt="Esquimalt Graving Dock header Image" src="<cfoutput>#RootDir#</cfoutput>images/banner_en.jpg" width=450 border=0></td>
  </tr>
  </tbody> 
</table>
<!--fin de la banni&egrave;re/end banner graphic-->

<!--d&eacute;but du menu du site subalterne/begin sub-site menu--> 

<table width="600" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td colspan="6"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="600" height="1" alt=""></td>
  </tr>
  <tr>
    <td><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="330" height="14" alt=""></td>
    <td><a href="<cfoutput>#RootDir#</cfoutput>text/new-e.cfm"><img name="Image7" border="0" src="<cfoutput>#RootDir#</cfoutput>images/whats-e.gif" width="89" height="14" alt="What's New"></a></td>
    <td><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="1" height="14" alt=""></td>
    <td><a href="<cfoutput>#RootDir#</cfoutput>text/site-e.cfm"><img name="Image8" border="0" src="<cfoutput>#RootDir#</cfoutput>images/map-e.gif" width="89" height="14" alt="Branch Site Map"></a></td>
    <td><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="1" height="14" alt=""></td>
    <td><a href="<cfoutput>#RootDir#</cfoutput>text/index-e.cfm"><img name="Image9" border="0" src="<cfoutput>#RootDir#</cfoutput>images/home_sample-e.gif" width="89" height="14" alt="Branch Home"></a></td>
  </tr>
</table>
<!--fin du menu du site subalterne/end sub-site menu-->

<!-- ************************************************** -->
