<CFPARAM name="url.lang" default='e'>

<!doctype HTML public "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html lang="en">
<head>
<!--PUBLISERVICE TEMPLATE VERSION 2.0-->
<title>Yukon Federal Council</title>
<meta http-equiv="Content-type" content="text/html;charset=iso-8859-1">
<meta name="originator" content="Public Works and Government Services Canada">
<meta name="author" content="REQUIRED">
<meta name="email" content="REQUIRED">
<meta name="region" content="REQUIRED">
<meta name="branch" content="REQUIRED">
<meta name="sector" content="REQUIRED">
<meta name="directorate" content="REQUIRED">
<meta name="language" content="eng">
<meta name="description" content="REQUIRED">
<meta name="keywords" content="REQUIRED">
<meta name="date_of_publication" content="YYYYMMDD">
<meta name="date_for_review" content="YYYYMMDD">
<meta name="availability" content="">
<meta name="classification" content="">
<meta name="retention" content="">
<meta name="datelastmodified" content="<!--#config timefmt='%Y%m%d'--><!--#echo var='LAST_MODIFIED'-->">
<meta name="subject1" content="">
<meta name="subject2" content="">
<!--
Original js css selector
<script language="JavaScript" type="text/javascript" src="../scripts/chkbrows_subsite.js"></script>
-->
<cfif isdefined('url.css')>
		<cfset ssver = url.css>
	<cfelse>
		<cfset ssver = 2>
</cfif>
<link rel="stylesheet" href="../css/style<cfoutput>_#ssver#</cfoutput>.css" type="text/css" media="screen" />
<script language="JavaScript">
<!--
function MM_showHideLayers() { //v3.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v='hide')?'hidden':v; }
    obj.visibility=v; }
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}
//-->

<!--
function swapTdIn(elemId) {
	document.getElementById(elemId).style.background='#FF9933';
}

function swapTdOut(elemId) {
	document.getElementById(elemId).style.background='#FFFFFF';
}

//-->

</script>
</head>

<body bgcolor="#FFFFFF" topmargin="5" leftmargin="5" marginwidth="5" marginheight="5" onLoad="MM_preloadImages('../images/menu/circle_on.gif','../images/menu/circle_off.gif')">
<!-- ********************START NAV TABLE******************** -->
<table width="750" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
<!-- **********DO NOT REMOVE THIS TABLE ROW********** -->
				<tr><td valign="top" colspan="3"><a href="#skipnav"><img src="../images/spacer.gif" alt="Skip navigation links" width="14" height="14" border="0"></a></td></tr>
<!-- **********FIP AND CANADA WORDMARK TABLE ROW********** -->
				<tr><td width="9%" valign="top"><img src="../images/spacer.gif" width="93" height="1" alt=""></td><td valign="top" width="78%"> <img src="../images/canada-e.gif" width="364" height="33" alt="Government of Canada" border="0"></td><td valign="top" align="right" width="13%"> <img src="../images/wordmark.gif" width="83" height="21" alt="Canada wordmark" border="0"></td></tr>
				<tr><td valign="top" colspan="3"><img src="../images/spacer.gif" alt="" width="1" height="10" border="0"></td></tr>
			</table>
<!-- **********START GOC AND CORP NAV TABLE********** -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="2%"><img src="../images/spacer.gif" width="148" height="1" alt=""></td>
					<td width="98%">
<!-- **********START GOC NAV BLACK BUTTONS********** -->
						<table width="100%" border="0" cellspacing="1" cellpadding="0">
							<tr align="center">
								<CFOUTPUT>
								<td width="20%" class="GOCMenuCell"><span lang="fr"><a href="#WebHost#/language.cfm" class="GOCMenu">français</a></span></td>
								<td width="20%" class="GOCMenuCell"><a href="../../ver2_redsquares/pages/comments.cfm" class="GOCMenu">Contact Us</a></td>
								<td width="20%" class="GOCMenuCell"><a href="../../ver2_redsquares/pages/help.cfm" class="GOCMenu">Help</a></td>
								<td width="20%" class="GOCMenuCell"><a href="../../ver2_redsquares/pages/search.cfm" class="GOCMenu">Search</a></td>
								<td width="20%" class="GOCMenuCell"><a href="http://canada.gc.ca/main_e.html" class="GOCMenu">Canada Site</a></td>
								</CFOUTPUT>
							</tr>
						</table>
<!-- **********END GOC NAV BLACK BUTTONS********** -->
<!-- **********START CORP NAV GREEN BUTTONS********** -->
						<table width="100%" border="0" cellspacing="1" cellpadding="0"><tr><td width="50%" align="center" class="CorpMenuCell"><a href="../../ver2_redsquares/app/res_list.cfm" class="CorpMenu"  onMouseOver="MM_showHideLayers('calendarofevents','','hide','pacificcouncil','','hide','management','','hide','governexx','','hide','yukon','','hide','committees','','hide','horizontal','','hide','representativeness','','hide','locallyshared','','hide','virtuallearning','','hide','national','','hide','whatsnew','','hide','regional','','hide','government','','hide','references','','hide','home','','hide');MM_showHideLayers('locallyshared','','show')">Locally Shared Services</a></td>
						<td width="50%" align="center" class="CorpMenuCell"><a href="../../ver2_redsquares/app/olc_product_list.cfm" class="CorpMenu" onMouseOver="MM_showHideLayers('calendarofevents','','hide','pacificcouncil','','hide','management','','hide','governexx','','hide','yukon','','hide','committees','','hide','horizontal','','hide','representativeness','','hide','locallyshared','','hide','virtuallearning','','hide','national','','hide','whatsnew','','hide','regional','','hide','government','','hide','references','','hide','home','','hide');MM_showHideLayers('pfcproducts','','show')">YFC Products</a></td>
						</tr></table>
<!-- **********END CORP NAV GREEN BUTTONS********** -->
					</td>
				</tr>
			</table>
<!-- **********END GOC AND CORP NAV TABLE********** -->
<!-- **********START BANNER TABLE********** -->
<cfif isdefined('url.head')>
		<cfset hdver = url.head>
	<cfelse>
		<cfset hdver = 1>
</cfif>
			<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td width="2%" valign="top"><img src="../images/spacer.gif" width="121" height="1" alt=""></td><td width="2%" align="right" valign="top"><img src="../images/spacer.gif" width="28" height="39" alt=""></td><td width="98%" valign="top"><img src="../images/header_yfc<cfoutput>#hdver#-#lang#.</cfoutput>gif" width="600" height="39" alt="Banner"></td></tr></table>
		</td>
	</tr>
</table>
<!-- **********END BANNER TABLE********** -->
<!-- ********************END NAV TABLE******************** -->
<!-- ********START SUB-SITE NAV UNDER BANNER******** -->
<table width="750" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="2%" rowspan="2"><img src="../images/spacer.gif" width="148" height="1" alt=""></td>
		<td width="98%">
			<table width="602" border="0" cellspacing="1" cellpadding="0" align="right">
				<tr align="center">
					<CFOUTPUT>
					<td width="20%" class="subMenuCell"><a href="../../ver2_redsquares/app/whatsnew.cfm" class="subMenu" onMouseOver="MM_showHideLayers('calendarofevents','','hide','pacificcouncil','','hide','management','','hide','governexx','','hide','yukon','','hide','committees','','hide','horizontal','','hide','representativeness','','hide','locallyshared','','hide','virtuallearning','','hide','national','','hide','whatsnew','','hide','regional','','hide','government','','hide','references','','hide','home','','hide');MM_showHideLayers('whatsnew','','show')">What's New</a></td>
					<td width="20%" class="subMenuCell"><a href="http://www.tbs-sct.gc.ca/frc-cfr/menu_e.asp" class="subMenu" onMouseOver="MM_showHideLayers('calendarofevents','','hide','pacificcouncil','','hide','management','','hide','governexx','','hide','yukon','','hide','committees','','hide','horizontal','','hide','representativeness','','hide','locallyshared','','hide','virtuallearning','','hide','national','','hide','whatsnew','','hide','regional','','hide','government','','hide','references','','hide','home','','hide');MM_showHideLayers('regional','','show')">Regional Councils</a></td>
					<td width="20%" class="subMenuCell"><a href="../../ver2_redsquares/pages/government.cfm" class="subMenu" onMouseOver="MM_showHideLayers('calendarofevents','','hide','pacificcouncil','','hide','management','','hide','governexx','','hide','yukon','','hide','committees','','hide','horizontal','','hide','representativeness','','hide','locallyshared','','hide','virtuallearning','','hide','national','','hide','whatsnew','','hide','regional','','hide','government','','hide','references','','hide','home','','hide');MM_showHideLayers('government','','show')">Government Links</a></td>
					<td width="20%" class="subMenuCell"><a href="../../ver2_redsquares/pages/references.cfm" class="subMenu" onMouseOver="MM_showHideLayers('calendarofevents','','hide','pacificcouncil','','hide','management','','hide','governexx','','hide','yukon','','hide','committees','','hide','horizontal','','hide','representativeness','','hide','locallyshared','','hide','virtuallearning','','hide','national','','hide','whatsnew','','hide','regional','','hide','government','','hide','references','','hide','home','','hide');MM_showHideLayers('references','','show')">References</a></td>
					<td width="20%" class="subMenuCell"><a href="../../ver2_redsquares/home/home.cfm?lang=#lang#" class="subMenu" onMouseOver="MM_showHideLayers('calendarofevents','','hide','pacificcouncil','','hide','management','','hide','governexx','','hide','yukon','','hide','committees','','hide','horizontal','','hide','representativeness','','hide','locallyshared','','hide','virtuallearning','','hide','national','','hide','whatsnew','','hide','regional','','hide','government','','hide','references','','hide','home','','hide');MM_showHideLayers('home','','show')">Home</a></td>
					</CFOUTPUT>
				</tr>
			</table>
		</td>
	</tr>
	<tr><td width="98%"><img src="../images/spacer.gif" width="600" height="5" alt=""></td></tr>
</table>
<!-- ******** END SUB-SITE NAV UNDER BANNER******** -->
<!-- ********START LARGE TABLE WITH SIDE NAV AND MAIN CONTENT******** -->
<table width="600" border="0" cellspacing="0" cellpadding="0">
<!-- ********TABLE ROW BELOW IS REQUIRED FOR SPACING - DO NOT REMOVE******** -->
	<tr>
		<td valign="top"><img src="../images/spacer.gif" width="150" height="1" alt=""></td>
		<td valign="top"><img src="../images/spacer.gif" width="450" height="1" alt=""></td>
	</tr>
	<tr>
<td width="1%" valign="top">
			<table width="150" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="98%" valign="top">
						<cfinclude template="../ssi/floating_layers.cfm">
<!-- **********START SIDE NAVIGATION TABLE********** -->
			<CFOUTPUT>
			<img src="../images/yfc_side_logo-#lang#.gif" width="140" height="85">
			<table width="140" border="0" cellspacing="0" cellpadding="0" class="sideMenu">
              <tr valign="middle" onMouseOut="swapTdOut('cal')" onMouseOver="swapTdIn('cal');MM_showHideLayers(#DivIDs#);MM_showHideLayers('calendarofevents','','show')">
                <td class="sideMenuCell"> <a class="sideMenu" href="../../ver2_redsquares/app/event_list.cfm">Calendar
                  of Events</a> </td>
                <td width="15" class="sideMenuCellRight" id="cal">&nbsp;</td>
              </tr>
              <tr valign="middle" onMouseOut="swapTdOut('yc')" onMouseOver="swapTdIn('yc');MM_showHideLayers(#DivIDs#);MM_showHideLayers('pacificcouncil','','show')">
                <td class="sideMenuCell"> <a class="sideMenu" href="../../ver2_redsquares/app/commit.cfm?commit=PCSFO">Yukon
                  Council</a> </td>
                <td class="sideMenuCellRight" id="yc">&nbsp;</td>
              </tr>
              <tr valign="middle" onMouseOut="swapTdOut('pc')" onMouseOver="swapTdIn('pc');MM_showHideLayers(#DivIDs#);MM_showHideLayers('pacificcouncil','','show')">
                <td class="sideMenuCell"> <a class="sideMenu" href="../../ver2_redsquares/app/commit.cfm?commit=PCSFO">Pacific
                  Council</a> </td>
                <td class="sideMenuCellRight" id="pc">&nbsp;</td>
              </tr>
              <tr valign="middle" onMouseOut="swapTdOut('mc')" onMouseOver="swapTdIn('mc');MM_showHideLayers(<cfoutput>#DivIDs#</cfoutput>);MM_showHideLayers('management','','show')">
                <td class="sideMenuCell"> <a class="sideMenu" href="../../ver2_redsquares/app/commit.cfm?commit=MIDMGR">Management
                  Community</a> </td>
                <td class="sideMenuCellRight" id="mc">&nbsp;</td>
              </tr>
              <!--- hiding to make pretty
              <tr valign="middle">
                <td class="sideMenuCell"> <a class="sideMenu" href="../../ver2_redsquares/app/commit.cfm?commit=YLeader" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Circle4','','../images/menu/circle_on.gif',1);MM_showHideLayers(<cfoutput>#DivIDs#</cfoutput>);MM_showHideLayers('governexx','','show')">Governexx</a>
                </td>
                <td class="sideMenuCellRight">&nbsp;</td>
              </tr>
              <tr valign="middle">
                <td class="sideMenuCell"> <a class="sideMenu" href="../../ver2_redsquares/app/commit.cfm?commit=YUKON" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Circle5','','../images/menu/circle_on.gif',1);MM_showHideLayers(<cfoutput>#DivIDs#</cfoutput>);MM_showHideLayers('yukon','','show')">Yukon
                  Federal Community</a> </td>
                <td class="sideMenuCellRight">&nbsp;</td>
              </tr>
              <tr valign="middle" align="center">
                <td class="sideMenuCell"> <a class="sideMenu" href="../../ver2_redsquares/pages/committees.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Circle6','','../images/menu/circle_on.gif',1);MM_showHideLayers(<cfoutput>#DivIDs#</cfoutput>);MM_showHideLayers('committees','','show')">Committees</a>
                </td>
                <td width="20" background="../images/menu/menucirclebg.gif"><a class="sideMenu" href="../../ver2_redsquares/pages/committees.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Circle6','','../images/menu/circle_on.gif',1);MM_showHideLayers(<cfoutput>#DivIDs#</cfoutput>);MM_showHideLayers('committees','','show')"><img name="Circle6" border="0" src="../images/menu/circle_off.gif" width="20" height="30"></a></td>
              </tr>
              <tr valign="middle" align="center">
                <td class="sideMenuCell"> <a class="sideMenu" href="../../ver2_redsquares/app/commit.cfm?commit=OFF_LANG" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('circle9','','../images/menu/circle_on.gif',1);MM_showHideLayers(<cfoutput>#DivIDs#</cfoutput>);MM_showHideLayers('OFF_LANG','','show')">Official
                  Languages</a> </td>
                <td width="20" background="../images/menu/menucirclebg.gif"><a class="sideMenu" href="../../ver2_redsquares/app/commit.cfm?commit=OFF_LANG" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('circle9','','../images/menu/circle_on.gif',1);MM_showHideLayers(<cfoutput>#DivIDs#</cfoutput>);MM_showHideLayers('OFF_LANG','','show')"><img name="circle9" border="0" src="../images/menu/circle_off.gif" width="20" height="30"></a></td>
              </tr>
              <tr valign="middle" align="center">
                <!--- carey --->
                <td class="sideMenuCell"> <a class="sideMenu" href="../../ver2_redsquares/app/commit.cfm?commit=Sustain" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('circle10','','../images/menu/circle_on.gif',1);MM_showHideLayers(<cfoutput>#DivIDs#</cfoutput>);MM_showHideLayers('sustain','','show')">Sustainable
                  Development</a> </td>
                <td width="20" background="../images/menu/menucirclebg.gif"><a class="sideMenu" href="../../ver2_redsquares/app/commit.cfm?commit=Sustain" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('circle10','','../images/menu/circle_on.gif',1);MM_showHideLayers(<cfoutput>#DivIDs#</cfoutput>);MM_showHideLayers('sustain','','show')"><img name="circle10" border="0" src="../images/menu/circle_off.gif" width="20" height="30"></a></td>
              </tr>
			  <tr valign="middle" align="center">
                <td class="sideMenuCell"> <a class="sideMenu" href="../pages/horizontality.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Circle7','','../images/menu/circle_on.gif',1);MM_showHideLayers(<cfoutput>#DivIDs#</cfoutput>);MM_showHideLayers('horizontal','','show')">Horizontality</a>
                </td>
                <td width="20" background="../images/menu/menucirclebg.gif"><a class="sideMenu" href="../pages/horizontality.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Circle7','','../images/menu/circle_on.gif',1);MM_showHideLayers(<cfoutput>#DivIDs#</cfoutput>);MM_showHideLayers('horizontal','','show')"><img name="Circle7" border="0" src="../images/menu/circle_off.gif" width="20" height="30"></a></td>
              </tr>
              <tr valign="middle" align="center">
                <td class="sideMenuCell"> <a class="sideMenu" href="../app/commit.cfm?commit=sdc" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Circle12','','../images/menu/circle_on.gif',1);MM_showHideLayers(<cfoutput>#DivIDs#</cfoutput>);MM_showHideLayers('communities','','show')">Service
                  Delivery Community</a> </td>
                <td background="../images/menu/menucirclebg.gif"><a class="sideMenu" href="../pages/communities/sd_communities.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Circle12','','../images/menu/circle_on.gif',1);MM_showHideLayers(<cfoutput>#DivIDs#</cfoutput>);MM_showHideLayers('communities','','show')"><img name="Circle12" border="0" src="../images/menu/circle_off.gif" width="20" height="30"></a></td>
              </tr>
              <tr valign="middle" align="center">
                <td class="sideMenuCell"> <a class="sideMenu" href="../pages/represent/contents.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Circle8','','../images/menu/circle_on.gif',1);MM_showHideLayers(<cfoutput>#DivIDs#</cfoutput>);MM_showHideLayers('representativeness','','show')">Diversity</a>
                </td>
                <td width="20" background="../images/menu/menucirclebg.gif"><a class="sideMenu" href="../pages/represent/contents.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Circle8','','../images/menu/circle_on.gif',1);MM_showHideLayers(<cfoutput>#DivIDs#</cfoutput>);MM_showHideLayers('representativeness','','show')"><img name="Circle8" border="0" src="../images/menu/circle_off.gif" width="20" height="30"></a></td>
              </tr>
              <tr valign="middle" align="center">
                <td class="sideMenuCell"> <a class="sideMenu" href="../app/commit.cfm?Commit=NPSW" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Circle11','','../images/menu/circle_on.gif',1);MM_showHideLayers(<cfoutput>#DivIDs#</cfoutput>);MM_showHideLayers('national','','show')">National
                  Public Service Week</a> </td>
                <td width="20" background="../images/menu/menucirclebg.gif"><a class="sideMenu" href="../app/commit.cfm?Commit=NPSW" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Circle11','','../images/menu/circle_on.gif',1);MM_showHideLayers(<cfoutput>#DivIDs#</cfoutput>);MM_showHideLayers('national','','show')"><img name="Circle11" border="0" src="../images/menu/circle_off.gif" width="20" height="30"></a></td>
              </tr>
			  --->
            </table>
            </CFOUTPUT>
<!-- **********END SIDE NAVIGATION TABLE********** -->
					</td>
					<td valign="top" align="right" width="2%"><img src="../images/spacer.gif" width="10" height="1" alt=""></td>
				</tr>
			</table>
<!-- ********do not remove link below******** -->
			<a name="skipnav"><img src="../images/spacer.gif" width="1" height="1" border="0" alt=""></a>
		</td>
		<td width="99%" valign="top">
<!-- ********START MAIN CONTENT TABLE******** -->

<div class="main">
<table width="600" cellspacing="0" cellpadding="0" border="0">
	<TR><TD colspan="3"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="1" height="20"></TD></TR>
	<tr>
		<td>
			<TABLE>
				<TR>
					<TD width="390" valign="top">
						<div class="bigGreenText">Yukon Federal Council</div>
						<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nullam eget massa. Pellentesque laoreet rutrum mi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Maecenas ut magna quis magna semper consectetuer. Sed risus enim, aliquet et, congue id, venenatis nec, eros. Suspendisse sed ipsum. Mauris iaculis sapien non massa. Sed viverra, lorem a dapibus dictum, diam arcu laoreet lacus, eget luctus nulla risus dapibus arcu. Ut mi urna, tincidunt condimentum, volutpat laoreet, condimentum vel, leo. Suspendisse vulputate bibendum nisi. Aliquam erat volutpat.</p>
					</TD>
					<TD width="20" background="<cfoutput>#WebHost#</cfoutput>/images/vertlinebg.gif"><img src="<cfoutput>#WebHost#</cfoutput>/images/spacer.gif" width="1" height="500"></TD>
					<TD width="180" valign="top">
						<div class="whatsNewTitle">What's New</div>
						<div class="whatsNewText"><strong>#GetHighlight.title#</strong>
							<BR>#Gethighlight.highlight#  Lorem ipsum dolor sit amet, consectetuer adipiscing elit. In eu odio. Proin tincidunt, libero eget dictum pretium, mauris quam pharetra massa, id vulputate ligula nibh at lectus. Etiam bibendum dolor ac nibh. Donec in nulla sit amet arcu aliquet porttitor. Praesent vulputate. Quisque vestibulum. Curabitur diam. Praesent id orci in.</div>
						<div class="whatsNewMore"><A href="#"><IMG src="<CFOUTPUT>#WebHost#</CFOUTPUT>/images/yellowarrow.gif">more...</A></div>
					</TD>
				</TR>
			</TABLE>
		</td>
	</tr>
	<TR><TD colspan="3"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="1" height="20"></TD></TR>
	<tr>
		<td bgcolor="#999999">
			<table cellpadding="3" cellspacing="0" border="0" width="600" style="padding: 1px; ">
				<tr>
					<td class="infoText">
						This site is best viewed with 16-bit or higher colour depth.
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>
<!-- ********END MAIN CONTENT TABLE******** -->
		</td>
	</tr>
</table>
<!-- ********START LARGE TABLE WITH SIDE NAV AND MAIN CONTENT******** -->
<!-- ********start footer******** -->
<table width="750" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="5%" valign="top"><img src="../images/spacer.gif" width="150" height="1" alt=""></td>
		<td width="95%" valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr valign="middle">
					<td colspan="2">
<!--start maintained by content-->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="right">
			<p class="footerText">
				<a href="../../ver2_redsquares/maint/login/login.cfm">Committee Maintenance</a>
			</p>
		</td>
	</tr>
	<tr align="right" valign="bottom">
		<td align="left" class="footerText">
			<img src="../images/black.gif" width="600" height="1">
			<div>
				Maintained by the <nobr><a href="../../ver2_redsquares/pages/comments.cfm">Yukon Federal Council</a></nobr>
			</div> 
			<!-- This option is recommended. -->
		</td>
	</tr>
</table>
<!--end maintained by content-->
					</td>
				</tr>
				<tr> <!-- DATE CODE AUTO GENERATED FOR EACH PAGE - DO NOT MODIFY -->
					<td valign="top" width="50%" class="footerText">
					<!--- Last Updated: --->
					<!--- to insert date --->
					<!--- find full path and file name via cf variable --->
					<cfset page = CGI.CF_TEMPLATE_PATH>
					<!--- separate file name from dir info --->
					<cfset file = listLen(page,"\")>

					<CFSET PageFileName = listlast(cgi.CF_TEMPLATE_PATH,"\")>
					<CFSET PageDir = listDeleteAt(cgi.CF_TEMPLATE_PATH, listLen(cgi.CF_TEMPLATE_PATH,"\"), "\")>
					<CFDIRECTORY action="LIST" directory="#PageDir#" name="GetFile" filter="#PageFileName#">
					<CFIF #GetFile.recordcount# is 1>Last Updated:
						<CFOUTPUT query="GetFile">
							#DateFormat(GetFile.DateLastModified,"mm/dd/yyyy")#
							#TimeFormat(GetFile.DateLastModified, "h:mm tt")#
						</CFOUTPUT>
					</CFIF>
					</td>
					<td align="right" valign="top" width="50%" class="footerText"><a href="../../ver2_redsquares/pages/notices.cfm">Important Notices</a></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ****************end footer**************** -->
<!---
<!-- *** START PROTOTYPE SELECTION PANEL *** -->
<div id="ppt_sel" style="color:#999999;width:300px;padding:10px;border:1px dashed black;background:white;position:absolute;left:300px;top:430px;z-index:5;">
<form action="home.cfm?lang=e" method="get">
		<p><strong>Please choose the banner and style:</strong></p>
		<p>Banner:
		<select name="head">
			<cfloop index="loopCount" from="1" to="10">
				<cfoutput><option value="#loopCount#"<cfif hdver eq loopCount><cfoutput> selected="true"</cfoutput></cfif>>#loopCount#</option></cfoutput>
			</cfloop>
			<!---
			<option value="1" <cfif hdver eq 1><cfoutput>selected="true"</cfoutput></cfif>>1</option>
			<option value="2" <cfif hdver eq 2><cfoutput>selected="true"</cfoutput></cfif>>2</option>
			<option value="3" <cfif hdver eq 3><cfoutput>selected="true"</cfoutput></cfif>>3</option>
			<option value="4" <cfif hdver eq 4><cfoutput>selected="true"</cfoutput></cfif>>4</option>
			<option value="5" <cfif hdver eq 5><cfoutput>selected="true"</cfoutput></cfif>>5</option>
			<option value="6" <cfif hdver eq 6><cfoutput>selected="true"</cfoutput></cfif>>6</option>
			<option value="7" <cfif hdver eq 7><cfoutput>selected="true"</cfoutput></cfif>>7</option>
			<option value="8" <cfif hdver eq 8><cfoutput>selected="true"</cfoutput></cfif>>8</option>
			<option value="9" <cfif hdver eq 9><cfoutput>selected="true"</cfoutput></cfif>>9</option>
			--->
		</select>
		Style:
		<select name="css">
			<cfloop index="loopCount" from="1" to="2">
				<cfoutput><option value="#loopCount#"<cfif ssver eq loopCount><cfoutput> selected="true"</cfoutput></cfif>>#loopCount#</option></cfoutput>
			</cfloop>
		</select></p>
		<input type="submit" value="Apply Changes" />
		<span onClick="move_div();">Head=<strong><cfoutput>#hdver#</cfoutput></strong></span>
	</form>
</div>
<script type="text/javascript">
	var coords = new Array();
	coords[0] = new Array('300px','430px');
	coords[1] = new Array('301px','429px');
	coords[2] = new Array('302px','428px');
	coords[3] = new Array('303px','429px');
	coords[4] = new Array('304px','430px');
	coords[5] = new Array('303px','431px');
	coords[6] = new Array('302px','432px');
	coords[7] = new Array('301px','431px');
	var pxni = 1;
	//move_div();
	function move_div() {
		theDiv = document.getElementById('ppt_sel');
		theDiv.style.left = coords[pxni][0];
		theDiv.style.top = coords[pxni][1];
		if (pxni == coords.length - 1) {
			pxni = 0;
		} else {
			pxni++;
		}
		setTimeout("move_div()",30);
	}
</script>
--->
</body>
</html>