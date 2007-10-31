<cfhtmlhead text="
<meta name=""dc.title"" lang=""fre"" content=""TPSGC - CALE S&Egrave;CHE D'ESQUIMALT - Aide &agrave; la recherche"">
<meta name=""keywords"" lang=""fre"" content=""cale s&egrave;che d'Esquimalt, aide &agrave; la recherche"">
<meta name=""description"" lang=""fre"" content=""Bienvenue &agrave; la cale s&egrave;che d'Esquimalt"">
<meta name=""dc.subject"" scheme=""gccore"" lang=""fre"" content=""Navire; Quai"">
<meta name=""dc.date.published"" content=""2005-07-25"">
<meta name=""dc.date.reviewed"" content=""2005-07-25"">
<meta name=""dc.date.modified"" content=""2005-07-25"">
<meta name=""dc.date.created"" content=""2002-11-29"">
<title>TPSGC - Cale s&egrave;che d'Esquimalt - Aide &agrave; la recherche</title>
<style type=""text/css"">@import url(#RootDir#css/events.css);</style>
">

<cfinclude template="#RootDir#includes/header-f.cfm">

<div class="breadcrumbs"> 
	<a href="http://www.pwgsc.gc.ca/text/home-f.html">TPSGC</a> &gt; 
	R&eacute;gion du Pacifique &gt; 
	<a href="index-f.cfm">Cale s&egrave;che d'Esquimalt</a> &gt; 
	Aide &agrave; la recherche
</div>

<div class="main">
	<H1>Aide la recherche</H1>
	<p>
		<a name="helptop"></a><a href="#basic">Fonctions de recherche de base</a><br>
		<a href="#other">Fonctions de recherche avanc&eacute;es</a><br>
		<a href="#tips">Conseils rapides</a><br>
	</p>

	<a name="basic"></a><h2>Fonctions de recherche de base</h2>
	<p>Pour faire une recherche, tapez simplement un ou des mot(s)-cl&eacute;(s) dans le champ de saisie et cliquez sur le bouton &laquo; Recherche &raquo;, ou utilisez un des symboles suivants avec le ou les mot(s)-cl&eacute;(s). Utilisez des lettres minuscules pour obtenir de meilleurs r&eacute;sultats de recherche.</p>
	
	<table cellspacing="0" width="100%" class="calendar">
	<tbody> 
		<tr> 
			<th id="symbol" class="calendar" style="width: 10%; "><b>Symbole</b></th>
			<th id="desc" class="calendar" style="width: 90%; "><b>Description</b></th>
		</tr>
		<tr> 
			<td headers="symbol" valign="top" class="calendar">&nbsp;</td>
			<td headers="desc" class="calendar">Si vous laissez une espace entre les mots, le moteur cherchera des documents qui contiennent n'importe quel de ces mots ou tous ces mots.<br>			
			Exemple&nbsp;: <b>gouvernement f&eacute;d&eacute;ral</b>. Le moteur cherche des documents qui contiennent gouvernement, gouvernement f&eacute;d&eacute;ral ou f&eacute;d&eacute;ral.</td>
		</tr>
		<tr> 
			<td headers="symbol" valign="top" class="calendar">+</td>
			<td headers="desc" class="calendar">Afin de vous assurer qu'un mot est toujours inclus dans vos r&eacute;sultats de recherche, ajoutez le symbole (+) avant le mot.<br>
			Exemple&nbsp;: <b>gouvernement+f&eacute;d&eacute;ral</b>. Le moteur cherche des documents qui contiennent les deux mots (gouvernement f&eacute;d&eacute;ral) ou le mot (f&eacute;d&eacute;ral).</td>			
		</tr>
		<tr> 
			<td headers="symbol" valign="top" class="calendar">-</td>
			<td headers="desc" class="calendar">Afin de vous assurer qu'un mot est toujours exclu de vos r&eacute;sultats de recherche, ajoutez le symbole (-) avant le mot.<br>
			Exemple&nbsp;: <b>gouvernement-f&eacute;d&eacute;ral</b>. Le moteur cherche des documents qui contiennent le mot (gouvernement) mais <b>pas</b> le mot (f&eacute;d&eacute;ral).</td>
		</tr>
		<tr> 
			<td headers="symbol" valign="top" class="calendar">*</td>
			<td headers="desc" class="calendar">Vous pouvez pousser votre recherche en utilisant un caract&egrave;re de remplacement (*).<br>
			Exemple&nbsp;:<b> grand*</b>. Le moteur cherche des documents qui contiennent les mots (grand, grandeur, grandiose ou autre).</td>
		</tr>
		<tr> 
			<td headers="symbol" valign="top" class="calendar">&quot; &quot;</td>
			<td headers="desc" class="calendar">Les expressions devraient être plac&eacute;es entre &laquo;&nbsp;guillemets&nbsp;&raquo;.<br>
			Exemple&nbsp;: <b>&laquo;&nbsp;gouvernement f&eacute;d&eacute;ral&nbsp;&raquo;</b>. Le moteur cherche des documents qui contiennent les deux mots (gouvernement f&eacute;d&eacute;ral) un &agrave; c&ocirc;t&eacute; de l'autre. </td>		
		</tr>
	</tbody> 
	</table>

	<p align="right"><a href="#helptop">Haut de la page</a></p>

	<h2><a name="other"></a>Fonctions de recherche avanc&eacute;es</h2>
	<p>Pour effectuer une recherche avanc&eacute;e, utilisez un des mots-cl&eacute;s suivants&nbsp;:</p>

	<table cellspacing="0" width="100%" class="calendar">
	<tbody> 
		<tr> 
			<th id="keyword" class="calendar" style="width: 25%; ">Mot-cl&eacute;</th>
			<th id="desc" class="calendar" style="width: 75%; ">Description</th>
		</tr>
		<tr> 
			<td headers="keyword" valign="top" class="calendar"><b>anchor:</b>texte</td>
			<td headers="desc" class="calendar">Cherche des pages qui contiennent le mot sp&eacute;cifi&eacute; dans le texte d'un hyperlien. Utilisez <b>anchor:emploi</b> pour trouver des pages avec le mot (emploi) dans un lien.</td>
		</tr>
		<tr> 
			<td headers="keyword" valign="top" class="calendar"><b>link:</b>texte URL</td>
			<td headers="desc" class="calendar">Cherche des pages qui contiennent un lien pr&eacute;cis. Utilisez <b>link:ccn.ca</b> 
			pour trouver toutes les pages qui ont un lien avec ccn.ca (Conseil canadien des normes).</td>
		</tr>
		<tr> 
			<td headers="keyword" valign="top" class="calendar"><b>text:</b>texte</td>
			<td headers="desc" class="calendar">Cherche des pages qui contiennent le texte sp&eacute;cifi&eacute; dans toute partie de                                        page autre qu'une balise d'image, un lien ou un URL. Utilisez <b>text:s&eacute;minaire</b> 
			pour trouver toutes les pages qui contiennent le mot (s&eacute;minaire).</td>
		</tr>
		<tr> 
			<td headers="keyword" valign="top" class="calendar"><b>title:</b>texte</td>
			<td headers="desc" class="calendar">Cherche des pages dont le titre contient l'expression ou le mot sp&eacute;cifi&eacute; (qui s'affiche dans la barre de titre de la plupart des navigateurs). Utilisez 
			<b>title:institut</b> pour trouver des pages dont le titre contient (institut). </td>
		</tr>
		<tr> 
			<td headers="keyword" valign="top" class="calendar"><b>url:</b>texte</td>
			<td headers="desc" class="calendar">Cherche des pages dont l'URL contient une expression ou un mot sp&eacute;cifi&eacute;. Utilisez 
			<b>url:march&eacute;</b> pour trouver toutes les pages sur tous les serveurs qui affichent le mot (march&eacute;) dans le nom d'h&ocirc;te, le chemin ou le nom de fichier. </td>
		</tr>
	</tbody>
	</table>
	
	<p align="right"><a href="#helptop">Haut de la page</a></p>
	
	<h2><a name="tips"></a>Conseils rapides</h2>
	
	<table cellspacing="0" width="100%" class="calendar">
	<tbody> 
		<tr>
		<th id="keywords" class="calendar" style="width: 35%; ">Mot-cl&eacute;</th>
		<th id="desc" class="calendar" style="width: 65%; ">Description</th>
		</tr>
		<tr> 
			<td headers="keywords" valign="top" class="calendar">gouvernement f&eacute;d&eacute;ral</td>
			<td headers="desc" class="calendar">Cherche des documents qui contiennent le mot &laquo;&nbsp;gouvernement&nbsp;&raquo; ou le mot &laquo;&nbsp;f&eacute;d&eacute;ral&nbsp;&raquo; ainsi que des variantes en majuscules (&laquo;&nbsp;Gouvernement&nbsp;&raquo;, &laquo;&nbsp;F&Eacute;D&Eacute;RAL&nbsp;&raquo;). AltaVista classe les r&eacute;sultats de mani&egrave;re &agrave; afficher d'abord les documents dans lesquels ces deux mots figurent, sont proches l'un de l'autre et paraissent au d&eacute;but du document.</td>
		</tr>
		<tr> 
			<td headers="keywords" valign="top" class="calendar">gouvernement+f&eacute;d&eacute;ral</td>
			<td headers="desc" class="calendar">Cherche des documents qui contiennent les mots (gouvernement f&eacute;d&eacute;ral) ou le mot (f&eacute;d&eacute;ral), mais <b>pas</b> le mot (gouvernement) sans le mot (f&eacute;d&eacute;ral) puisque toutes les pages doivent contenir le mot (f&eacute;d&eacute;ral).</td>
		</tr>
		<tr> 
			<td headers="keywords" valign="top" class="calendar">+gouvernement+f&eacute;d&eacute;ral</td>
			<td headers="desc" class="calendar">Cherche uniquement des documents qui contiennent <b>ces deux mots</b>. Assurez-vous qu'il n'y a pas d'espace entre le signe + et le mot qui suit. </td>
		</tr>
		<tr> 
			<td headers="keywords" valign="top" class="calendar">+gouvernement f&eacute;d&eacute;ral</td>
			<td headers="desc" class="calendar">Cherche des documents qui doivent contenir le mot (gouvernement) ou toute autre variante en majuscules. Les documents qui contiennent &laquo;&nbsp;f&eacute;d&eacute;ral&nbsp;&raquo; seront affich&eacute;s en premier et seront suivis des documents qui ne contiennent pas &laquo;&nbsp;gouvernement&nbsp;&raquo;.</td>
		</tr>
		<tr> 
			<td headers="keywords" valign="top" class="calendar">&quot;&nbsp;gouvernement f&eacute;d&eacute;ral&nbsp;&quot;</td>		
			<td headers="desc" class="calendar">Cherche des documents qui contiennent ces deux mots situ&eacute;s l'un &agrave; c&ocirc;t&eacute; de l'autre. Si vous placez une s&eacute;rie de mots entre guillemets, vous transformez celle-ci en une expression, ce qui indique &agrave; AltaVista que vous cherchez des documents contenant ces mots dans cet ordre pr&eacute;cis.</td>
		</tr>
		<tr> 
			<td headers="keywords" valign="top" class="calendar">+&quot;&nbsp;gouvernement f&eacute;d&eacute;ral&nbsp;&quot;-minist&egrave;re</td>
			<td headers="desc" class="calendar">Cherche des documents qui contiennent les mots (gouvernement f&eacute;d&eacute;ral) mais <b>pas</b> le mot (minist&egrave;re).</td>
		</tr>
		<tr> 
			<td headers="keywords" valign="top" class="calendar">+gouvernement+f&eacute;* </td>
			<td headers="desc" class="calendar">Cherche des documents qui contiennent le mot (gouvernement) ainsi que tout autre mot commençant par (f&eacute;) comme (f&eacute;vrier, f&eacute;tiche). Utilisez un <B>ast&eacute;risque</B> lorsque vous ne connaissez pas l'&eacute;pellation d'un mot ou pour en trouver les variantes&nbsp;: essayez (grand*) pour trouver (grande, grandeur, grandiose). Utilisez l'ast&eacute;risque &agrave; la fin ou dans le corps d'un mot seulement.  </td>
		</tr>
	</tbody> 
	</table>
	
	<p align="right"><a href="#helptop">Haut de la page</a></p>
	
</div>
<cfinclude template="#RootDir#includes/footer-f.cfm">