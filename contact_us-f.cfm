<cfhtmlhead text="
<meta name=""dc.title"" lang=""fre"" content=""TPSGC - CALE S&Egrave;CHE D'ESQUIMALT - Contactez-nous"">
<meta name=""keywords"" lang=""fre"" content=""cale s&egrave;che d'Esquimalt, Contacter"">
<meta name=""description"" lang=""fre"" content=""Contacter l'administration de la cale s&egrave;che d'Esquimalt"">
<meta name=""dc.subject"" scheme=""gccore"" lang=""fre"" content=""Navire; Quai"">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2002-11-29"">
<title>TPSGC - Cale s&egrave;che d'Esquimalt - Contactez-nous</title>">

<cfinclude template="#RootDir#includes/header-f.cfm">

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
	<a href="http://www.pwgsc.gc.ca/home-f.html">TPSGC</a> &gt; 
	R&eacute;gion du Pacifique &gt;
	<a href="index-f.cfm">Cale s&egrave;che d'Esquimalt</a> &gt; 
	Contactez-nous
</div>

<div class="main">
	<H1>Contactez-nous</H1>
	
	<p>Envoyez vos commentaires par courriel&nbsp;: <a href="mailto:egd@tpsgc.gc.ca">egd@tpsgc.gc.ca</a> 
	ou au moyen du formulaire ci-dessous. Vous pouvez aussi nous &eacute;crire ou nous appeler &agrave; 
	<a href="contact_us-f.cfm#find_us">l'adresse</a> ci-dessous&nbsp;:</p>
	
	<form method="POST" action="http://www.pwgsc.gc.ca/cgi-bin/generic_email.pl">
		<!-- une adresse est requise pour afficher la page de confirmation/an actual address will be required in order to display this formsent confirmation page -->
		<cfoutput><input type="hidden" name="redirect" value="#RootDir#thank_you-f.cfm"></cfoutput>
		<!--modifier les 3 type=hidden avec l'information de votre site et votre courriel/modify these 3 hidden fields to reflect content and email address for your site-->
		<input type="hidden" name="Title" value="TPSGC - Cale s&egrave;che d'Esquimalt - Nous contacter">
		<input type="hidden" name="subject" value="Commentaires sur le site internet de la CSE">
		<input type="hidden" name="recipient" value="egd@tpsgc.gc.ca">
		
		<table width="100%" border="0" cellpadding="0" cellspacing="2">
			<tr> 
				<td id="name" width="35%"><b><label for="id1">Nom&nbsp;:*</label></b></td>
				<td headers="name" width="65%"><input id="id1" maxlength="50" size="25" name="realname" class="textField"></td>
			</tr>
			<tr> 
				<td id="email"><b><label for="id2">Adresse &eacute;lectronique&nbsp;:&nbsp;*</label></b></td>
				<td headers="email"><input id="id2" size="25" name="email" class="textField"></td>
			</tr>
			<tr> 
				<td id="phone"><b><label for="id3">N<sup>o</sup> t&eacute;l.&nbsp;: </label></b></td>
				<td headers="phone"><input id="id3" size="25" name="Person's Phone Number" class="textField"></td>
			</tr>
			<tr> 
				<td id="comments" valign="top"><b><label for="id4">Commentaires&nbsp;:&nbsp;*</label></b></td>
				<td headers="comments"><textarea id="id4" name="Comments" rows="8" cols="25"></textarea></td>
			</tr>
			<tr> 
			<td colspan="2"> 
				<b>N.B.&nbsp;:</b> * indique un champ obligatoire.</td>
			</tr>
			<tr> 
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr> 
				<td colspan="2">Si vous voulez une r&eacute;ponse par la poste, indiquez votre adresse postale ci-dessous&nbsp;:</td>
			</tr>
			<tr> 
				<td id="street"><label for="id5">Rue : </label></td>
				<td headers="street"><input id="id5" size="25" name="Mailing Address - Street" class="textField"></td>
			</tr>
			<tr> 
				<td id="city"><label for="id6">Ville/Localit&eacute;/Municipalit&eacute; : </label></td>
				<td headers="city"><input id="id6" size="25" name="Mailing Address - City" class="textField"></td>
			</tr>
			<tr> 
				<td id="prov"><label for="id7">Province/&Eacute;tat : </label></td>
				<td headers="prov"><input id="id7" size="25" name="Mailing Address -  Province" class="textField"></td>
			</tr>
			<tr> 
				<td id="country"><label for="id8">Pays : </label></td>
				<td headers="country"><input id="id8" size="25" name="Mailing Address -  Country" class="textField"></td>
			</tr>
			<tr> 
				<td id="postal"><label for="id9">Code postal : </label></td>
				<td headers="postal"><input id="id9" size="25" name="Mailing Address -  Postal Code" class="textField"></td>
			</tr>
			<tr> 
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr> 
				<td colspan="2" align="center"><input type="submit" value="Envoyer commentaires" name="submit" onClick="MM_validateForm('Comments','','R');return document.MM_returnValue" class="textbutton">
				<input type="reset" value="Effacer" name="reset" onClick="document.mfrm.q.value=''" class="textbutton"></td>
			</tr>
		</table>
	</form>
	
	<p><a href="contact_us-f.cfm#top"><img src="<cfoutput>#RootDir#</cfoutput>images/up_arrow.gif" alt="Retour haut de page" border="0"></a></p>
	<p>Pour tout autre renseignement concernant TPSGC, visitez la page &laquo;<a href="http://www.tpsgc.gc.ca/generic/contact_us-f.html"> nous contacter</a> &raquo; de notre site minist&eacute;riel.</p>
	
	<a name="find_us"></a><h2>Pour nous trouver....</h2>
	
	<p> <b>Notre adresse postale&nbsp;: </b> <br>
	Directeur des op&eacute;rations<br>
	Cale s&egrave;che d'Esquimalt <br>
	825 Admirals Road<br>
	Esquimalt (C.-B.)<br>
	V9A 2P1<br>
	Canada</p>
	
	<p><b>T&eacute;l&eacute;phone&nbsp;:</b><br>
	(250) 363-3879&nbsp;&nbsp;&nbsp;<b>ou</b>&nbsp;&nbsp;&nbsp;(250) 363-8056</p>
	
	<p><b>Notre fax :</b><br>
	(250) 363-8059</p>
	<br>
	
	<h2>&Eacute;nonc&eacute; de confidentialit&eacute;</h2>
	<p>La communication de renseignements est facultative. Nous utiliserons 
	cette information pour r&eacute;pondre &agrave; vos questions 
	ou commentaires, et pour am&eacute;liorer nos services Internet.</p>
	
	<p>Les renseignements seront vers&eacute;s au fichier de renseignements 
	personnels num&eacute;ro TPSGC PPU 115 (Services Internet) de 
	Travaux publics et Services gouvernementaux Canada, et ils seront 
	conserv&eacute;s selon le calendrier de conservation et d'&eacute;limination 
	&eacute;tabli pour ce fichier.</p>
	<p>Vos <a href="http://lois.justice.gc.ca/fr/P-21/index.html">renseignements 
	personnels</a> sont prot&eacute;g&eacute;s conform&eacute;ment 
	aux dispositions de la Loi sur la protection des renseignements 
	personnels. En vertu de cette loi, vous avez le droit de demander 
	l'acc&egrave;s &agrave; vos renseignements personnels ainsi 
	que leur correction s'ils sont erron&eacute;s ou incomplets.</p>
	
	<p>Pour plus de d&eacute;tails concernant vos droits, consultez 
	<a href="http://infosource.gc.ca/index_f.asp">Info Source</a>. 
	Cette publication du gouvernement du Canada est disponible dans 
	les principales biblioth&egrave;ques, les bureaux d'information 
	du gouvernement et les bureaux de circonscription des d&eacute;put&eacute;s 
	f&eacute;d&eacute;raux.</p>
	<p>L'Internet &eacute;tant un moyen de communication public, toute information &eacute;lectronique peut y être intercept&eacute;e. Ce site n'est pas s&eacute;curis&eacute;. Pri&egrave;re de ne pas donner de renseignements &agrave; caract&egrave;re confidentiel sur vous-même ou sur votre compte aupr&egrave;s de TPSGC, &agrave; moins que cela ne soit absolument n&eacute;cessaire.</p>

</div>
<cfinclude template="#RootDir#includes/footer-f.cfm">