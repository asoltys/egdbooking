<cfhtmlhead text="
<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Contact Us"">
<meta name=""keywords"" lang=""eng"" content=""Esquimalt Graving Dock, contact"">
<meta name=""description"" lang=""eng"" content=""Contact the Esquimalt Graving Dock"">
<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content=""Ship; Wharf"">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2002-11-29"">
<title>PWGSC - ESQUIMALT GRAVING DOCK - Contact Us</title>">

<cfinclude template="#RootDir#includes/header-e.cfm">

<script language="JavaScript1.2" type="text/css">
<!--
function MM_findObj(n, d) { //v3.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document); return x;
}

function MM_validateForm() { //v3.0
  var i,p,q,nm,test,num,min,max,errors='',args=MM_validateForm.arguments;
  for (i=0; i<(args.length-2); i+=3) { test=args[i+2]; val=MM_findObj(args[i]);
    if (val) { nm=val.name; if ((val=val.value)!="") {
      if (test.indexOf('isEmail')!=-1) { p=val.indexOf('@');
        if (p<1 || p==(val.length-1)) errors+='- '+nm+' must contain an e-mail address.\n';
      } else if (test!='R') { num = parseFloat(val);
        if (val!=''+num) errors+='- '+nm+' must contain a number.\n';
        if (test.indexOf('inRange') != -1) { p=test.indexOf(':');
          min=test.substring(8,p); max=test.substring(p+1);
          if (num<min || max<num) errors+='- '+nm+' must contain a number between '+min+' and '+max+'.\n';
    } } } else if (test.charAt(0) == 'R') errors += '- '+nm+' is required.\n'; }
  } if (errors) alert('The following error(s) occurred:\n'+errors);
  document.MM_returnValue = (errors == '');
}
//-->
</script>

<div class="breadcrumbs"> 
	<a href="http://www.pwgsc.gc.ca/home-e.html">PWGSC</a> &gt; 
	Pacific Region &gt; 
	<a href="index-e.cfm">Esquimalt Graving Dock</a> &gt; 
	Contact Us
</div>

<div class="main">

	<H1>Contact Us</H1>
	<p>E-mail your comments to <a href="mailto:egd@pwgsc.gc.ca">egd@pwgsc.gc.ca</a> 
	or fill out the form below. You may also write or call us at the 
	<a href="contact_us-e.cfm#find_us">address</a> below:</p>
	
	<form method="POST" action="http://www.pwgsc.gc.ca/cgi-bin/generic_email.pl">
	
		<!-- une adresse est requise pour afficher la page de confirmation/an actual address will be required in order to display this formsent confirmation page -->
		<cfoutput><input type="hidden" name="redirect" value="#RootDir#thank_you-e.cfm"></cfoutput>
		<!--modifier les 3 type=hidden avec l'information de votre site et votre courriel/modify these 3 hidden fields to reflect content and email address for your site-->
		<input type="hidden" name="Title" value="PWGSC - Esquimalt Graving Dock - Contact Us">
		<input type="hidden" name="subject" value="Comments from the EGD Internet Site">
		<input type="hidden" name="recipient" value="egd@pwgsc.gc.ca">
		<table width="100%" border="0" cellpadding="0" cellspacing="2">
			<tr> 
				<td id="name" width="35%"><b><label for="id1">Name:&nbsp;*</label></b></td>
				<td headers="" width="65%"><input id="id1" maxlength="50" size="25" name="realname" class="textField"></td>
			</tr>
			<tr> 
				<td id="email"><b><label for="id2">E-mail address:&nbsp;*</label></b></td>
				<td headers="email"><input id="id2" size="25" name="email" class="textField"></td>
			</tr>
			<tr> 
				<td id="phone"><b><label for="id3">Phone Number:</label></b></td>
				<td headers="phone"><input id="id3" size="25" name="Person's Phone Number" class="textField"></td>
			</tr>
			<tr> 
				<td id="comments" valign="top"><b><label for="id4">Comments:&nbsp;*</label></b></td>
				<td headers="comments"><textarea id="id4" name="Comments" rows="8" cols="25"></textarea></td>
			</tr>
			<tr> 
				<td colspan="2"><b>Note:</b> * denotes a required field.</td>
			</tr>
			<tr> 
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr> 
				<td colspan=2>In cases where you wish to receive a written 
				response, please include your mailing address:</td>
			</tr>
			<tr> 
				<td id="street"><label for="id5">Street:</label></td>
				<td headers="street"><input id="id5" size="25" name="Mailing Address - Street" class="textField"></td>
			</tr>
			<tr> 
				<td id="city"><label for="id6">City/Town/Municipality:</label></td>
				<td headers="city"><input id="id6" size="25" name="Mailing Address - City" class="textField"></td>
			</tr>
			<tr> 
				<td id="prov"><label for="id7">Province/State:</label></td>
				<td headers="prov"><input id="id7" size="25" name="Mailing Address -  Province" class="textField"></td>
			</tr>
			<tr> 
				<td id="country"><label for="id8">Country:</label></td>
				<td headers="country"><input id="id8" size="25" name="Mailing Address -  Country" class="textField"></td>
			</tr>
			<tr> 
				<td id="postal"><label for="id9">Postal Code:</label></td>
				<td headers="postal"><input id="id9" size="25" name="Mailing Address -  Postal Code" class="textField"></td>
			</tr>
			<tr> 
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="Send comments" name="submit" onClick="MM_validateForm('Comments','','R');return document.MM_returnValue" class="textbutton">
				<input type="reset" value="Reset" name="reset" onClick="document.mfrm.q.value=''" class="textbutton"></td>
			</tr>
		</table>
	
	</form>


	<p><a href="#top"><img src="<cfoutput>#RootDir#</cfoutput>images/up_arrow.gif" alt="Back to top" border="0"></a></p>
	
	<p>For other enquiries dealing with PWGSC, visit our corporate <a href="http://www.pwgsc.gc.ca/generic/contact_us-e.html">Contact Us</a> page.</p>
	
	<a name="find_us"></a><h2>Where to find us....</h2>
	
	<p><b>Write to us:</b><br>
	Operations Manager<br>
	Esquimalt Graving Dock<br>
	825 Admirals Road<br>
	Esquimalt, BC<br>
	V9A 2P1<br>
	Canada</p>
	
	<p><b>Telephone us:</b><br>
	(250) 363-3879&nbsp;&nbsp;&nbsp;<b>or</b>&nbsp;&nbsp;&nbsp;(250) 363-8056</p>
	
	<p><b>Fax us:</b><br>
	(250) 363-8059</p>
	<br>
	
	<h2>Privacy Notice Statement</h2>
	<p>Provision of the information is on a voluntary basis. We will 
	use the information for the purpose of responding to your questions/comments, 
	and to improve our Internet presence.</p>
	<p>The information will be held in Public Works and Government 
	Services Canada's Personal Information Bank number PPU 115 (Internet 
	Services), and it will be retained according to the retention 
	and disposal schedule established for this bank.</p>
	<p>Your personal information is protected under the provisions 
	of the <a href="http://laws.justice.gc.ca/en/P-21/index.html">Privacy 
	Act</a>. Under the Act, you have the right to request access 
	to and correction of your personal information, if erroneous 
	or incomplete.</p>
	
	<p>For more information about your rights, see <a href="http://infosource.gc.ca/index_e.asp">Info 
	Source</a>. This is a Government of Canada publication available 
	in major libraries, at government information offices and from 
	constituency offices of federal Members of Parliament.</p>
	<p>The Internet is a public forum and electronic information can 
	be intercepted. This is not a secure website. Please do not disclose 
	unnecessary confidential information about yourself or your accounts 
	with PWGSC.</p>
	
</div>
<cfinclude template="#RootDir#includes/footer-e.cfm">