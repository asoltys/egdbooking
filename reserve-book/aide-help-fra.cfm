<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>
			Système de réservation en ligne de la Cale sèche d'Esquimalt : Guide de l'utilisateur
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
            <p><a name="Top"></a><h1>Cale sèche d'Esquimalt (CSE)</h1>       
            <h1>Système de r&eacute;servation en ligne : Guide de l'utilisateur</h1>       
            <P class="style1">Table des matières</p>       
            <P align="left"><span class="style2"><strong><a href="#Overview">1.        
            Aperçu</a></strong></span></p>
            <div style="padding-left:0px;"><strong><a href="#GettingStarted">2. 
              Introduction</a></strong><br />
            </div>
            <div style="padding-left:20px;"><em><a href="#SystemReqs">2.1   
            			 Configuration exig&copy;e</a><br />       
              <a href="#CreateAccount">2.2 Cr&eacute;er un compte d'utilisateur</a></em><br />       
            </div>
            <div style="padding-left:40px;">2.2.1 Par où commencer<br />       
			  2.2.2 Compagnie(s) de l'utilisateur<br />       
			  2.2.3 Cr&eacute;er un compte de compagnie<br />       
			  2.2.4 Activer un compte d'utilisateur <br />       
            </div>
            <div style="padding-left:20px;"><em><a href="#LoggingIn">2.3 Entr&eacute;e        
              dans le système</a><br />       
              <a href="#GetPassword">2.4 R&eacute;cup&eacute;ration du mot de passe</a></em><br />       
                  <br />
            </div>
            <span class="style2">
            <div style="padding-left:0px;"><strong><a href="#UsingApp">3.  
              Utilisation du système de r&eacute;servation en ligne de la CSE</a></strong></div>       
            </span>
            <div style="padding-left:20px;"><em><a href="#HomePage">3.1 Page de 
              bienvenue</a></em><br /></div>
			 <div style="padding-left:40px;">3.1.1 Entreprises<br />      
 				 3.1.2 R&eacute;servations       
            </div>
             <div style="padding-left:20px;"><em><a href="#EditProfile">3.2 
              Modifier le profil d'utilisateur</a></em><br />
            </div>
            <div style="padding-left:40px;">3.2.1 Modifier les renseignements        
              personnels<br />
              3.2.2  
              Changement de mot de passe            </div>
            <div style="padding-left:20px;"><em><a href="#Vessels">3.3 Navires</a></em><br />
            </div>
            <div style="padding-left:40px;">3.3.1 Ajouter des navires<br /> 
			  3.3.2 Modifier le profil de navires<br /> 
			  3.3.3 Supprimer des navires<br /> 
            </div>
            <div style="padding-left:20px;"><em><a href="#Bookings">3.4 R&eacute;servations</a></em><br />       
            </div>
            <div style="padding-left:40px;">3.4.1 R&eacute;server une cale sèche<br /></div>       
			<div style="padding-left:60px;"><span class="style8">3.4.1.1 Demande        
              de dates pr&eacute;cises<br />       
				3.4.1.1 Demande de la prochaine p&eacute;riode disponible</span><br /></div>       
			<div style="padding-left:40px;">
			  3.4.2 R&eacute;server une jet&eacute;e<br />       
			  3.4.3 Modifier une r&eacute;servation<br />       
			  3.4.4 Annuler une r&eacute;servation<br />       
			  3.4.5 Annulations et suppressions pour des raisons administratives<br />       
			  3.4.6 Pr&eacute;avis de 24 heures<br />       
            </div>
            <div style="padding-left:20px;"><em><a href="#Overviews">3.5 R&eacute;servations        
              - Vues d'ensemble</a></em><br />       
            </div>
            <div style="padding-left:40px;">3.5.1 Calendriers<br />       
 				 3.5.2 Sommaire des r&eacute;servations<br />       
            </div>
            <div style="padding-left:20px;"> <em><a href="#Forms">3.6        
              Formulaires pour les r&eacute;servation</a>s</em><br />      
            </div>
            <div style="padding-left:40px;">
  				3.6.1 Tarifs de droit de cale sèche<br />     
  				3.6.2 Tableau 1<br />       
  				3.6.3 Clause d'indemnisation<br />       
  				3.6.4 Formulaire de modification d'une r&eacute;servation<br />      
            </div>
            <div style="padding-left:20px;"><em><a href="#LoggingOut">3.7 Sortie        
              du système</a></em><br />       
            </div>
            
            <p>           
            <hr width="75%">
            <p><strong><br />
              <br />
            <a name="Overview"></a><span class="style10">1. Aperçu</span></strong><br />       
            <div style="padding-left:20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Le        
              système de r&eacute;servation en ligne de la Cale sèche d'Esquimalt        
              (CSE) est une façon pratique de r&eacute;server &eacute;lectroniquement des        
              installations de la CSE. Le système permet aux utilisateurs        
              d'observer l'&eacute;tat des r&eacute;servations qu'ils ont fait pour retenir  
              la cale sèche ou une jet&eacute;e, et donne accès à toutes les activit&eacute;s        
              connexes.</div>
            <br />
            <a href="#Top">Retour à la table des matières</a>       
            <p></p>
            <p><strong><br />
                  <a name="GettingStarted"></a><span class="style10">2. 
            Introduction</span></strong><br /> 
            <div style="padding-left:20px;"><em><a name="SystemReqs"></a><strong class="style11">2.1     
              Configuration exig&eacute;e</strong></em></div>    
            <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Avant     
              d'entrer dans le système&Acirc; veillez à ce que votre navigateur     
              respecte les paramètres de configuration suivants :       
                <ul>
                  <li><a href="http://browser.netscape.com/ns8/" rel="external">Netscape 4+</a> (<a href="http://browser.netscape.com/ns8/download/archive72x.jsp" rel="external">liens 
                    vers de plus vieilles versions</a>), <a href="http://www.microsoft.com/windows/ie/downloads/critical/ie6sp1/default.mspx" rel="external">Internet Explorer 4+</a>, 
                    ou <a href="http://www.mozilla.org/products/firefox/" rel="external">Mozilla Firefox</a></li> 
                  <li>JavaScript activ&eacute;</li>    
                  <li>T&eacute;moins (cookies) activ&eacute;s</li>   
                  <li><a href="http://www.adobe.com/products/acrobat/readstep2_allversions.html" rel="external">Adobe Acrobat Reader</a>  
                    install&eacute;</li>    
                </ul>
              Pour installer l'un ou l'autre des logiciels requis, cliquez sur     
              les liens ci-dessus. Si vous avez des difficult&eacute;s à activer le JavaScript     
              ou les t&eacute;moins, suivez les instructions suivantes :      
                <ul>
                  <li>Netscape 4 : Allez à Édition &gt; Pr&eacute;f&eacute;rences &gt;   
                    Avanc&eacute; pour activer les deux fonctions. </li>    
                  <li>Netscape 7 ou 8 : Allez à Édition &gt; Pr&eacute;f&eacute;rences.   
                    Vous trouverez les fonctions JavaScript sous Avanc&eacute;, et   
                    Cookies sous Confidentialit&eacute; et s&eacute;curit&eacute;.</li>  
                  <li>Internet Explorer 6 : Allez à Outils &gt; Options Internet.   
                    Vous trouverez JavaScript sous Advanced, et Cookies sous   
                    Confidentialit&eacute;.</li>
                  <li>Mozilla Firefox : Allez à Outils &gt; Options. Vous trouverez   
                    JavaScript sous Fonctionnalit&eacute;s Web, et Cookies sous   
                    Confidentialit&eacute;.</li>
                </ul>
            </div>
            <a href="#Top">Retour à la table des matières</a>    
            <p></p>
            <p>            
            <div style="padding-left:20px;"> <em><a name="CreateAccount"></a><span class="style11"><strong>2.2     
              Cr&eacute;er un compte d'utilisateur</strong></span></em>    
            </div>
            <div style="padding-left:40px;"><strong>2.2.1 Par où commencer</strong><br />    
            </div>
            <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Allez     
              à la page principale du site de la CSE : <a href="http://www.pwgsc.gc.ca/pacific/egd/index-f.html">http://www.pwgsc.gc.ca/pacific/egd/index-f.html</a>     
              et cliquez sur &laquo;&nbsp;R&eacute;servations&nbsp;&raquo; dans le menu lat&eacute;ral.     
              Cliquez sur le lien &laquo; application des r&eacute;servations &raquo;, puis     
              cliquez sur &laquo; ajouter un nouveau compte d'utilisateur &raquo;. Entrez     
              vos coordonn&eacute;es, y compris votre pr&eacute;nom, votre nom de famille,     
              un mot de passe de 6 à 10 caractères et votre adresse de     
              courriel, lesquels sont tous des renseignements obligatoires.     
              L'adresse de courriel que vous donnerez sera utilis&eacute;e pour l'entr&eacute;e     
              dans le système et les avis que la CSE vous enverra par courriel.     
              Le système ne fait pas la distinction entre les majuscules et les     
              minuscules pour les mots de passe, donc vous pouvez utiliser aussi     
              bien les unes que les autres. Pour un mot de passe plus s&eacute;curitaire,     
              nous vous sugg&eacute;rons d'utiliser des lettres et des chiffres.       
              <br />
              <br />
            </div>
            <div style="padding-left:40px;"><strong>2.2.2 Entreprises(s) de  
              l'utilisateur</strong><br />
            </div>
            <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;À     
              la prochaine page, ajoutez à votre profil la ou les entreprises que     
              vous repr&eacute;sentez. Choisissez votre entreprise dans le menu d&eacute;roulant     
              et cliquez sur &laquo;&nbsp;Ajouter&nbsp;&raquo;. Vous pouvez le refaire     
              autant de fois qu'il le faut. Si l'entreprise que vous repr&eacute;sentez     
              n'est pas &eacute;num&eacute;r&eacute;e, voir le paragraphe 2.2.3.<br />       
              <br />
            </div>
            <div style="padding-left:40px;"><strong>2.2.3 Cr&eacute;er un compte  
              d'entreprise</strong><br />
            </div>
            <div style="padding-left:60px;">
              <div style="text-align:left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cliquez sur     
                le lien &laquo; ici&nbsp;&raquo; sous le menu d&eacute;roulant (figure 1)     
                pour cr&eacute;er un profil d'entreprise. Tous les champs sont     
                obligatoires, sauf &laquo; Adresse 2&nbsp;&raquo; et &laquo;&nbsp;Fax&nbsp;&raquo;.     
                En cliquant sur le bouton &laquo;&nbsp;soumettre&nbsp;&raquo;, vous cr&eacute;erez     
                le compte d'entreprise et aviserez la CSE de la demande de cr&eacute;ation     
                d'un nouveau profil d'entreprise. Le profil d'entreprise devra     
                être approuv&eacute; avant que l'on ne puisse l'activer.<br />       
              </div>
            </div>
				<br />
                <div style="text-align:center;"><img src="../images/aide-help/entrpajout-compadd-fra.gif" alt="Figure 1 : Ajouter une nouvelle entreprise" /></div>
                <div style="text-align:center;">Figure 1 : Ajouter une nouvelle entreprise <br />
                
              </div>
            <div style="padding-left:40px;"><br />
            <strong>2.2.4 Activer un compte d'utilisateur</strong>            </div>
            <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lorsque     
              votre ou vos entreprises ont &eacute;t&eacute; ajout&eacute;es, cliquez sur &laquo;     
              Soumettre une demande d'ajout d'un nouvel utilisateur &raquo;. Cela     
              aura pour effet de transmettre votre demande de compte et d'en     
              aviser l'administration de la CSE. Votre compte doit être approuv&eacute;     
              avant que l'on ne puisse l'activer. Si vous ajoutez plusieurs  
              entreprises à votre profil, il n'est pas n&eacute;cessaire qu'elles     
              soient toutes approuv&eacute;es pour que votre compte soit activ&eacute;. Vous     
              recevrez un avis par courriel lorsqu'une affiliation  
              utilisateur-entreprise est approuv&eacute;e ou rejet&eacute;e.       
              <p></p>
            </div>
            <p><a href="#Top">Retour à la table des matières</a> </p>    
            <p>
            <div style="padding-left:20px;"><em><a name="LoggingIn"></a><strong class="style11">2.3     
              Entr&eacute;e dans le système</strong><br />    
            </em></div>
            <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L'approbation     
              d'une seule affiliation utilisateur-entreprise est n&eacute;cessaire     
              pour que le compte soit activ&eacute;. Lorsque vous recevez un courriel     
              vous avisant que l'une de vos affiliations utilisateur-entreprise     
              est approuv&eacute;e, entrez dans le système avec l'adresse de courriel     
              et le mot de passe que vous avez indiqu&eacute;s lors de la cr&eacute;ation de     
              votre compte. Allez à&nbsp; <a href="http://www.pwgsc.gc.ca/pacific/egd/index-f.html">http://www.pwgsc.gc.ca/pacific/egd/index-f.html</a>     
              et cliquez sur &laquo; R&eacute;servations &raquo; dans le menu lat&eacute;ral. Cliquez     
              ensuite sur le lien &laquo; Application des r&eacute;servations&nbsp;&raquo;. Cela     
              vous mènera à la page d'entr&eacute;e dans le système.</div>       
            <p></p>
            <a href="#Top">Retour à la table des matières</a> <br />    
            <p>            
            <div style="padding-left:20px;"><em><a name="GetPassword"></a><strong class="style11">2.4     
              R&eacute;cup&eacute;ration du mot de passe</strong><br />    
            </em></div>
            <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Si     
              vous avez oubli&eacute; votre mot de passe, cliquez sur le lien &laquo; Oubli  
              du mot de passe &raquo; de la page d'entr&eacute;e. Entrez l'adresse     
              de courriel que vous utilisez pour l'entr&eacute;e dans le système, et     
              votre mot de passe vous sera transmis par courriel.<br />       
            </div>
            <br />
            <a href="#Top">Retour à la table des matières</a>    
            <p></p>
            <p>     <br />       
            <strong><a name="UsingApp"></a><span class="style10">3. Utilisation  
            du     
            système de r&eacute;servation en ligne de la CSE</span></strong>    
            
            <div style="padding-left:20px;"><em><a name="HomePage"></a><span class="style11"><strong>3.1 
              Page de bienvenue</strong></span></em><br />
            </div>
            <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lorsque     
              vous entrez dans l'application, vous arrivez à la &laquo; page de     
              bienvenue &raquo; du système de r&eacute;servation. Vous avez accès à     
              toutes les fonctions du système de r&eacute;servation à partir de     
              cette page. Toutes les principales fonctions sont disponibles à     
              partir de la barre de menus sous le titre de la page (figure 2).     
              Vous pouvez aussi naviguer dans le site au moyen de la piste de     
              navigation (figure 3). La piste de navigation vous indique le     
              chemin que vous avez suivi jusqu'à maintenant dans le site, ce     
              qui peut être très utile si vous voulez revenir en arrière.</div>       
            <br />
                <div style="text-align:center;"><img src="../images/aide-help/utilisateur-user-menu-fra.gif" alt="Figure 2 : barre de menus" /></div>
                <div style="text-align:center;">Figure 2: barre de menus <br />
                </div>
			<br />
                <div style="text-align:center;"><img src="../images/aide-help/userBreadcrumbs-f.gif" alt="Figure 3 : piste de navigation" /></div>
                <div style="text-align:center;">Figure 3: piste de navigation <br />
            <br />
            </div>
			<div style="padding-left:40px;"><strong>3.1.1 Entreprises</strong></div>
			<div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;La     
              page de bienvenue affiche des renseignements sur une entreprise à     
              la fois. Le nom de l'entreprise dont on voit les renseignements     
              est affich&eacute; dans le titre. Si vous êtes autoris&eacute; à repr&eacute;senter     
              plus d'une entreprise, l'affichage des renseignements de  
              l'entreprise pr&eacute;cis&eacute;e se fera sous la barre de menus, et les noms     
              des autres entreprises seront affich&eacute;s tout juste en dessous     
              (figure&nbsp;4). Vous pouvez passer d'une entreprise à une autre     
              en cliquant sur leur nom. Le nom de toute entreprise pour laquelle     
              vous attendez l'approbation de repr&eacute;sentation appara&reg;tra tout juste     
              en dessous de votre liste d'entreprises.<br />      
			  <br />
                <div style="text-align:center;"><img src="../images/aide-help/userCompanies-f.gif" alt="Figure 4 : vos entreprises" /></div>
                <div style="text-align:center;">Figure 4: vos entreprises <br />
                </div>
			</div>
			<br />
			<div style="padding-left:40px;"><strong>3.1.2 R&eacute;servations</strong></div>    
			<div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Toutes     
              les r&eacute;servations pour l'entreprise que vous choisissez&nbsp; sont     
              affich&eacute;es sur la page de bienvenue. Pour une liste complète de     
              toutes les r&eacute;servations, y compris les r&eacute;servations pass&eacute;es,     
              cliquez sur le bouton &laquo;&nbsp;Toutes les r&eacute;servations &raquo;.<br />       
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Les r&eacute;servations sont ainsi     
              divis&eacute;es : &laquo; Cale sèche&nbsp;&raquo;, &laquo;&nbsp;Quai de d&eacute;barquement nord &raquo; et &laquo; Jet&eacute;e     
              sud &raquo;. Seuls les renseignements essentiels sont affich&eacute;s : nom     
              du navire, dates au bassin, &eacute;tat de la r&eacute;servation et agent     
              responsable de la r&eacute;servation. En cliquant sur le nom du navire,     
              vous pouvez voir d'autres renseignements sur la r&eacute;servation, et     
              vous avez l'option de la modifier ou de l'annuler. Pour les r&eacute;servations     
              de la cale sèche, il y a aussi un lien menant qui permet de &laquo;  
              Consulter le formulaire de tarif&nbsp;&raquo; ou d'apporter une &laquo;  
              Modification au&nbsp; formulaire de tarif &raquo;. Veuillez consulter le paragraphe 3.6.1     
              pour de plus amples renseignements sur les formulaires de tarif.</div>      
		   
            <p><a href="#Top">Retour à la table des matières</a> </p>    
<p>
<div style="padding-left:20px;"><em><a name="EditProfile"></a><span class="style11"><strong>3.2 
  Modifier le profil d'utilisateur</strong></span></em><br /></div>
  <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pour     
    modifier votre profil, cliquez sur &laquo;&nbsp;Modifier le profil&nbsp;&raquo; dans     
    la barre de menus. La page &laquo;&nbsp;Modifier le profil&nbsp;&raquo; est divis&eacute;e     
    en trois sections, et chacune d'entre elles a son bouton de soumission.<br />       
    <br />
  </div>
  <div style="padding-left:40px;"><strong>3.2.1 Modifier les renseignements 
    personnels</strong><br /></div>
  <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;La première     
    section vous permet de modifier votre pr&eacute;nom et votre nom. L'adresse de     
    courriel ne peut pas être modifi&eacute;e, &eacute;tant donn&eacute; qu'il s'agit de votre     
    code d'identification pour l'entr&eacute;e dans le système. Pour utiliser une     
    adresse de courriel diff&eacute;rente, vous devez cr&eacute;er un nouveau compte     
    d'utilisateur.<br />   
    <br />
  </div>
	<div style="text-align:center;"><img src="../images/aide-help/utilisateur-user-profilmod-profileedit-fra.gif" alt="Figure 5 : modifier votre nom" /></div>
	<div style="text-align:center;">Figure 5 : modifier votre nom <br /><br />
  </div>
  <div style="padding-left:40px;"><strong>3.2.2 Changement de mot de passe</strong><br />
  </div> 
  <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;La troisième     
    section vous permet de changer votre mot de passe, qui doit compter de 6 à     
    10 caractères.&nbsp; Le système ne fait pas la distinction entre les     
    majuscules et les minuscules pour les mots de passe, donc vous pouvez     
    utiliser aussi bien les unes que les autres. Pour des raisons de s&eacute;curit&eacute;,     
    nous vous sugg&eacute;rons d'utiliser des lettres et des chiffres dans votre mot     
    de passe, et de le changer fr&eacute;quemment.</div>       
  <br /><div style="text-align:center;"><img src="../images/aide-help/passechangement-passchange-fra.gif" alt="Figure 7 : modifier votre mot de passe" /></div>
	<div style="text-align:center;">Figure 7: modifier votre mot de passe <br />
  </div>
            <p><a href="#Top">Retour à la table des matières</a> </p>    
  
  <p> <div style="padding-left:20px;"><em><a name="Vessels"></a><span class="style11"><strong>3.3 
              Navires</strong></span></em><br /></div>
    <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Les     
      navires d'une entreprise sont &eacute;num&eacute;r&eacute;s dans la page de bienvenue sous la     
      rubrique &laquo;&nbsp;Navire(s)&nbsp;&raquo;. Si le navire que vous cherchez n'est     
      pas dans la liste, v&eacute;rifiez si vous avez bien les renseignements pour la     
      bonne entreprise. Pour voir les renseignement sur le navire, cliquez sur     
      son nom.<br />       
      <br />
    </div>
	<div style="padding-left:40px;"><strong>3.3.1 Ajouter des navires</strong><br /></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cliquez     
      &laquo;&nbsp;Ajout d'un navire&nbsp;&raquo; sous la liste des navires de  
      l'entreprise. Tous les champs sont obligatoires. Les longueurs et les     
      largeurs sont en mètres, et les temps d'installation et de retrait des  
      tins sont en jours. Le temps d'installation des tins est le nombre de jours n&eacute;cessaires     
      pour installer les tins de soutien avant que l'eau ne puisse être enlev&eacute;e     
      de la cale, et le temps de retrait des tins est le nombre de jours n&eacute;cessaires     
      pour faire l'inverse. Il faut inclure ces temps dans le nombre de jours     
      demand&eacute;s pour la r&eacute;servation.<br />       
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Si un navire est anonyme, toutes les r&eacute;servations     
      pour ce navire seront affich&eacute;es sans nom dans les calendriers et les     
      sommaires des r&eacute;servations. Ainsi, seules les dates et l'&eacute;tat de la r&eacute;servation     
      sont affich&eacute;s pendant que celle-ci est en traitement attente de confirmation ou     
      provisoire. Lorsque la confirmation est donn&eacute;e, l'information     
      additionnelle suivante est affich&eacute;e&nbsp;: l'entreprise, le nom du navire     
      et sa longueur, les sections r&eacute;serv&eacute;es ainsi que les dates de la r&eacute;servation.     
      Tout autre renseignement sur le navire ou la r&eacute;servation ne peut être vu     
      par les utilisateurs d'autres entreprises. Les administrateurs ont accès     
      à toute l'information sur les r&eacute;servations et les navires, peu importe  
      si ces derniers sont anonymes ou non.<br />      
    <br /></div>
    <div style="padding-left:40px;"><strong>3.3.2 Modifier le profil de navires</strong></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cliquez     
      sur le nom du navire dans la rubrique &laquo;&nbsp;Navire(s) &raquo;, puis cliquez     
      sur le bouton &laquo;&nbsp;Modifier le navire &raquo;. Vous pouvez     
      modifier tous les renseignements sur le navire, à l'exception de  
      l'entreprise, à condition que le navire n'ait pas de r&eacute;servation confirm&eacute;e.     
      Dans le cas contraire, vous ne pourrez pas modifier les dimensions du     
      navire. Pour ce faire, vous devrez communiquer avec l'administration du     
      CSE. L'administration est avis&eacute;e lorsque les renseignements sur un navire     
      sont modifi&eacute;s.<br />       
      <br /></div>
    <div style="padding-left:40px;"><strong>3.3.3 Supprimer des navires</strong></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cliquez     
      sur le nom du navire dans la rubrique &laquo;&nbsp;Navire(s), puis cliquez sur     
      le bouton &laquo; Supprimer le navire&nbsp;&raquo;. Les navires ne peuvent être supprim&eacute;s     
      que s'il ne font l'objet d'aucune demande de r&eacute;servation. Dans le cas     
      contraire, vous recevrez un message affichant les r&eacute;servations pour le     
      navire qui doivent être annul&eacute;es avant que le navire ne puisse être     
      supprim&eacute;. Si vous arrivez à supprimer le navire, vous recevrez un avis     
      de confirmation.</div>       
            <p><a href="#Top">Retour à la table des matières</a> </p>    
  <p> <div style="padding-left:20px;"><em><a name="Bookings"></a><span class="style11"><strong>3.4     
              R&eacute;servations</strong></span></em></div>
    <div style="padding-left:40px;"><strong>3.4.1 R&eacute;server la cale sèche</strong></div>   
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cliquez    
      sur &laquo;&nbsp;Pr&eacute;senter une r&eacute;servation&nbsp;&raquo; sous vos r&eacute;servations&nbsp;  
      ou sur &laquo;&nbsp;Pr&eacute;senter une r&eacute;servation&nbsp;&raquo;    
      dans la barre de menus, puis choisissez l'option de r&eacute;servation de la    
      cale sèche. Il y a deux façons de r&eacute;server la cale sèche : indiquer des    
      dates pr&eacute;cises, ou demander le nombre de jours voulus dans la prochaine p&eacute;riode    
      libre (p. ex. demander la&nbsp; prochaine p&eacute;riode de 10 jours dans l'ann&eacute;e    
      qui vient.).<br />       
      <br />
    </div>
	<div style="padding-left:60px;"><span class="style12">3.4.1.1 Demande de    
      dates pr&eacute;cises</span><br /></div>   
	  <div style="padding-left:80px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tous    
        les champs sont obligatoires pour la r&eacute;servation. Il faut choisir  
        l'entreprise et le navire au moyen des menus d&eacute;roulants, et il faut pr&eacute;ciser    
        les dates du d&eacute;but et de la fin de la p&eacute;riode r&eacute;serv&eacute;e. Vous pouvez    
        entrer manuellement les dates &laquo;&nbsp;mm/jj/aaaa&nbsp;&raquo; ou utiliser les    
        boutons calendriers. Lorsque vous cliquez sur l'un de ces boutons, un    
        petit calendrier appara&reg;t, dans lequel vous pouvez cliquer sur la date    
        choisie. Cette date sera entr&eacute;e dans la bo&reg;te de date correspondante.    
        Lorsque vous choisissez des dates de bassin, veuillez vous assurer de    
        tenir compte du temps n&eacute;cessaire pour installer et retirer les tins.  (<em>Nota    
        </em>: les dates de bassin sont inclusives, p.&nbsp;ex. une r&eacute;servation    
        de trois jours se fera du 1<SUP>er</SUP> mai au 3 mai.)<br />       
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Si la cale sèche est disponible pour les    
        dates demand&eacute;es, vote demande sera soumise. Si rien n'est disponible    
        pour les dates pr&eacute;cis&eacute;es, vous avez le choix d'essayer de nouvelles    
        dates, ou de maintenir votre demande dans l'espoir d'une annulation.    
        Veuillez consulter le paragraphe 3.4.6 pour de plus amples    
        renseignements sur le processus de pr&eacute;avis de 24&nbsp;heures pour les    
        annulations.<br />    
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lorsque votre r&eacute;servation est soumise, un    
        avis est transmis par courriel à l'administration de la CSE, et vous    
        recevez un formulaire de tarif des droits de cale sèche. Il s'agit d'un formulaire    
        facultatif; pour de plus amples renseignements, voir le paragraphe 3.6.1.<br />       
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Il incombe à l'administration de la CSE    
        d'approuver la r&eacute;servation; toutefois, lorsque vous avez reçu l'avis    
        de confirmation de la r&eacute;servation par courriel, vous devez envoyer les    
        formulaires appropri&eacute;es - le tableau 1 et la clause d'indemnisation -    
        ainsi que les frais de r&eacute;servation de 3 500 $ avant que la r&eacute;servation    
        ne puisse être confirm&eacute;e. Prière de consulter la section 3.6 pour de    
        plus amples renseignements sur les formulaires requis.<br />       
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Si votre r&eacute;servation est approuv&eacute;e et que    
        d'autres r&eacute;servations provisoires sont faites pour la même p&eacute;riode,    
        la politique de pr&eacute;avis de 24 heures sera appliqu&eacute;e (section 3.4.6).    
        Vous serez avis&eacute; par courriel de la confirmation &eacute;ventuelle de votre r&eacute;servation.<br />       
        <br />
        </div>
    <div style="padding-left:60px;"><span class="style12">3.4.1.2 Demande de la    
      prochaine p&eacute;riode disponible</span></div>   
	<div style="padding-left:80px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tous les    
      champs sont obligatoires; il faut donc choisir l'entreprise et le navire    
      au moyen de menus d&eacute;roulants, une p&eacute;riode doit être pr&eacute;cis&eacute;e de la façon    
      d&eacute;crite au paragraphe 3.4.1.1, et le nombre de jours requis pour la r&eacute;servation    
      doit être pr&eacute;cis&eacute;. Le nombre de jours pour la r&eacute;servation doit être    
      inf&eacute;rieur ou &eacute;gal à la dur&eacute;e de la p&eacute;riode pr&eacute;cis&eacute;e.<br />       
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lorsque vous soumettez une demande, on    
      vous donnera la prochaine p&eacute;riode disponible pour la dur&eacute;e de la r&eacute;servation    
      pr&eacute;cis&eacute;e. Si c'est acceptable, vous pouvez faire la r&eacute;servation; sinon,    
      vous pouvez essayer une autre p&eacute;riode. (<em>Nota </em>: Lorsque vous    
      utilisez l'autre m&eacute;thode de r&eacute;servation qui prend les dates pr&eacute;cises,    
      si votre p&eacute;riode pr&eacute;cis&eacute;e n'est pas disponible, votre r&eacute;servation sera    
      approuv&eacute;e et vous serez mis sur une liste d'attente au cas où une    
      annulations surviendrait, et la politique de pr&eacute;avis de 24 heures sera    
      appliqu&eacute;e. Prière de consulter le paragraphe 3.4.6 pour de plus amples    
      renseignements. (La m&eacute;thode qui consiste à demander la prochaine p&eacute;riode    
      disponible n'offre pas cette option.)<br />       
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lorsque vous soumettez une demande de r&eacute;servation,    
      un avis est transmis par courriel à l'administration de la CSE, et vous    
      voyez appara&reg;tre le formulaire des tarifs de radoub. Il s'agit d'un    
      formulaire optionnel; pour de plus amples renseignements, voir le    
      paragraphe 3.6.1.<br />       
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Il incombe à    
      l'administration de la CSE d'approuver la r&eacute;servation; toutefois, lorsque    
      vous avez reçu l'avis de confirmation de la r&eacute;servation par courriel,    
      vous devez envoyer les formulaires appropri&eacute;es - le tableau 1 et la    
      clause d'indemnisation - ainsi que les frais de r&eacute;servation de 3 500 $    
      avant que la r&eacute;servation ne puisse être confirm&eacute;e. Prière de consulter    
      la section 3.6 pour de plus amples renseignements sur les formulaires    
      requis.<br />    
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Si votre r&eacute;servation est approuv&eacute;e et que    
      d'autres r&eacute;servations provisoires sont faites pour la même p&eacute;riode, la    
      politique de pr&eacute;avis de 24 heures sera appliqu&eacute;e (section 3.4.6). Vous    
      serez avis&eacute; par courriel de la confirmation &eacute;ventuelle de votre r&eacute;servation.<br />       
	</div>
	<div style="padding-left:40px;"><strong>3.4.2 R&eacute;server une jet&eacute;e</strong></div>   
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cliquez    
      sur &laquo; Pr&eacute;senter une r&eacute;servation &raquo; sous vos r&eacute;servations ou dans la barre des menus, et choisissez l'option de r&eacute;servation    
      d'une jet&eacute;e. Tous les champs sont obligatoires pour la r&eacute;servation d'une    
      jet&eacute;e. Vous pouvez choisir l'entreprise, le navire et la jet&eacute;e au moyen    
      des menus d&eacute;roulants. Les dates du d&eacute;but et de la fin de p&eacute;riode voulue    
      peuvent être pr&eacute;cis&eacute;es de la façon d&eacute;crite au paragraphe 3.4.1.1.<br />       
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lorsque vous soumettez une demande de r&eacute;servation,    
      l'administration de la CSE en est avis&eacute;e. Pour que la r&eacute;servation soit    
      confirm&eacute;e, vous devez faire parvenir les formulaires du tableau 1 et de    
      la clause d'indemnisation. Prière de consulter le paragraphe 3.6 pour de    
      plus amples renseignements sur les formulaires demand&eacute;s. Vous serez avis&eacute;    
      par courriel de la confirmation &eacute;ventuelle de votre r&eacute;servation. Il n'y    
      a pas de frais pour la r&eacute;servation d'une jet&eacute;e, mais si le navire    
      n'arrive pas aux dates indiqu&eacute;es, l'entreprise se verra facturer des    
      frais de r&eacute;servation.<br />       
	<br />
    </div>
    <div style="padding-left:40px;"><strong>3.4.3 Modifier des r&eacute;servations</strong><br /></div>   
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Les r&eacute;servations    
      ne peuvent être modifi&eacute;es en ligne. Si vous souhaitez modifier une r&eacute;servation,    
      vous devez communiquer avec l'administration de la CSE et transmettre par    
      courrier ou par fax une copie papier du formulaire de modification d'une r&eacute;servation.    
      Une version PDF de ce formulaire est disponible en ligne. Pour l'ouvrir,    
      allez à la page de bienvenue et cliquez sur &laquo; Formulaires de r&eacute;servation&nbsp;&raquo;    
      en haut de la liste de vos r&eacute;servations.<br />       
      <br />
    </div>
    <div style="padding-left:40px;"><strong>3.4.4 Annuler des r&eacute;servations</strong><br /></div>   
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Il est    
      possible d'annuler des r&eacute;servations. Pour ce faire, cliquez sur le nom du    
      navire dans la liste des r&eacute;servations sur la page de bienvenue ou la page    
      des r&eacute;servations archiv&eacute;es, puis cliquez sur le bouton &laquo;&nbsp;Demander    
      l'annulation&nbsp;&raquo;. Lorsque vous demandez une annulation,    
      l'administration de la CSE sera avis&eacute;e de la demande, et votre annulation    
      sera consid&eacute;r&eacute;e comme en traitement jusqu'à ce que vous receviez un autre    
      avis. Si vous ne recevez pas d'avis d'annulation de votre r&eacute;servation,    
      cela veut dire que celle-ci est maintenue.<br />       
	<br />
    </div>
    <div style="padding-left:40px;"><strong>3.4.5 Annulations et suppressions 
      administratives</strong><br /></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L'administration    
      de la CSE a la capacit&eacute; d'annuler les r&eacute;servations actuelles, ainsi que    
      de supprimer les r&eacute;servations pass&eacute;es. Vous serez avis&eacute; par courriel si    
      l'une de vos r&eacute;servations est annul&eacute;e. Si l'administration supprime une r&eacute;servation    
      pass&eacute;e, vous ne serez pas avis&eacute;, mais vous remarquerez toutefois    
      qu'elle n'est plus affich&eacute;e dans la liste de vos r&eacute;servations archiv&eacute;es.<br />       
      <br />
    </div>
  	<div style="padding-left:40px;"><strong>3.4.6 Pr&eacute;avis de 24 heures</strong><br /></div>   
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;La CSE    
      maintient une politique de pr&eacute;avis de 24&nbsp;heures en ce qui concerne les    
      listes d'attente. Si plusieurs r&eacute;servations provisoires indiquent la même    
      p&eacute;riode de cale sèche, la politique veut que le principe du premier    
      arriv&eacute;, premier servi s'applique. Par cons&eacute;quent, la première  
      entreprise    
      qui a demand&eacute; la p&eacute;riode la reçoit, à condition qu'elle paye les frais    
      de r&eacute;servation et soumette les formulaires requis.<br />       
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cependant, si une autre entreprise plus    
      bas dans la liste paye les frais de r&eacute;servation et fournit les    
      formulaires en premier, toutes les entreprises ayant des demandes de r&eacute;servation    
      provisoires faites ant&eacute;rieurement auront 24 heures de pr&eacute;avis pour payer    
      les frais de r&eacute;servation, en commençant par le d&eacute;but de la liste. 
      L'entreprise en haut de la liste sera avis&eacute;e la première. Si elle choisit de    
      ne pas prendre la p&eacute;riode, la prochaine entreprise sera avis&eacute;e, et ainsi    
      de suite. Si aucune de ces entreprises ne paye les frais de r&eacute;servation    
      dans le d&eacute;lai allou&eacute;, l'entreprise originale qui fait la demande de    
      confirmation reçoit la p&eacute;riode. La même politique s'applique lorsque    
      des p&eacute;riodes deviennent disponibles en raison d'annulations.<br />       
    </div>
            <p><a href="#Top">Retour à la table des matières</a> </p>   
     
  <p> <div style="padding-left:20px;"><em><a name="Overviews"></a><span class="style11"><strong>3.5    
              R&eacute;servations - Vue d'ensemble</strong></span></em></div>   
    <div style="padding-left:40px;"><strong>3.5.1 Calendriers</strong><br /></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;La barre    
      de menus du haut donne accès aux calendriers de la cale sèche et des jet&eacute;es.    
      Des tableaux mensuels et trimestriels sont disponibles (figure 8). Les    
      calendriers affichent par d&eacute;faut le mois en cours, mais on peut voir    
      d'autres mois au moyen des menus d&eacute;roulants. Chaque jour affiche un    
      sommaire des r&eacute;servations confirm&eacute;es pour chaque section ou chaque jet&eacute;e,    
      ainsi que le nombre de r&eacute;servations en traitement ou provisoires pour cette    
      journ&eacute;e. En cliquant sur une date, vous voyez un sommaire plus d&eacute;taill&eacute;    
      des r&eacute;servations pour la journ&eacute;e en question.<br />       
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Si un navire est anonyme et si la r&eacute;servation    
      n'est pas confirm&eacute;e, le calendrier indiquera &laquo; Navire de haute mer&nbsp;&raquo;,    
      et ne donnera que l'&eacute;tat de la r&eacute;servation et les dates d'amarrage.    
      Lorsque la r&eacute;servation est confirm&eacute;e, quelques renseignements    
      additionnels limit&eacute;s sont affich&eacute;s. Pour les navires que tous peuvent    
      voir, un lien mènent à des renseignements plus d&eacute;taill&eacute;s sur la r&eacute;servation    
      et le navire.<br />        
	<br />
    </div>
    <div style="padding-left:40px;"><strong>3.5.2 Sommaire des r&eacute;servations</strong><br /></div>   
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;À    
      partir de toutes les pages du calendrier, vous avez accès à un lien &laquo; R&eacute;sum&eacute; des r&eacute;servations &raquo; tout juste sous la barre de menus du haut    
      (figure 8). Le r&eacute;sum&eacute; des r&eacute;servations est un tableau regroupant    
      l'information donn&eacute;e dans les calendriers. Il affiche le nom et la    
      longueur du navire, l'&eacute;tat de la r&eacute;servation, la ou les sections ou la    
      jet&eacute;e r&eacute;serv&eacute;es, les dates d'amarrage et la date où la demande de r&eacute;servation    
      a &eacute;t&eacute; soumise. On peut faire afficher une version facile à imprimer en    
      cliquant sur le bouton &laquo;&nbsp;Voir la version imprimable&nbsp;&raquo;.<br />       
    </div>
	<div style="text-align:center;"><img src="../images/aide-help/utilisateur-user-resume-summary-fra.gif" alt="Figure 8 : Vue d'ensemble des r&eacute;servations" /></div>
	<div style="text-align:center;">Figure 8 : Vue d'ensemble des r&eacute;servations <br /><br />   
 	 </div>
            <a href="#Top">Retour à la table des matières</a> <br />   
    <br />
    <div style="padding-left:20px;"><em><a name="Forms"></a><span class="style11">3.6    
      Formulaires pour les r&eacute;servations</span></em></div>   
    <div style="padding-left:40px;"><strong>3.6.1 Tarifs des droits de cale sèche</strong><br /></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Le    
      formulaire des tarifs de droits de cale sèche est un formulaire optionnel qui vous    
      permet de pr&eacute;ciser les services et les installations dont vous aurez    
      besoin, et qui permettra ainsi à la CSE d'avoir les ressources dont vous 
      aurez besoin durant la p&eacute;riode que vous r&eacute;servez. Lorsque votre r&eacute;servation    
      est confirm&eacute;e, vous devriez confirmer &eacute;galement vos besoins exacts    
      directement avec la CSE. <br />       
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Le formulaire s'affichera après que   
      vous aurez demand&eacute; une r&eacute;servation. Vous pouvez le remplir à ce   
      moment-là, ou d&eacute;cider de le faire plus tard. Si vous voulez modifier vos   
      entr&eacute;es ou remplir le formulaire plus tard, vous pourrez le faire à   
      partir de la page de bienvenue. Les formulaires des tarifs peuvent être   
      modifi&eacute;s pour les r&eacute;servations en traitement et provisoire. Cliquez sur le   
      lien &laquo; Modification du formulaire de tarif&nbsp;&raquo; dans la liste des r&eacute;servations   
      pour apporter des changements ou remplir le formulaire pour la première   
      fois. Si une r&eacute;servation est confirm&eacute;e, vous pouvez faire afficher le   
      formulaire des tarifs en cliquant sur&nbsp; &laquo;&nbsp;Consulter le formulaire 
      de tarif&nbsp;&raquo;. Pour faire apporter des changements au formulaire de 
      tarif d'une r&eacute;servation confirm&eacute;e, prière de communiquer avec la CSE.<br />       
	<br />
    </div>
    <div style="padding-left:40px;"><strong>3.6.2 Tableau 1</strong><br /></div> 
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Le   
      tableau 1 donne des renseignements sur le navire, et sert d'entente entre   
      l'agent qui fait la r&eacute;servation et la CSE. La CSE doit recevoir le   
      tableau 1 avant que la r&eacute;servation ne puisse être confirm&eacute;e.<br />       
      <br />
    </div>
    <div style="padding-left:40px;"><strong>3.6.3 Clause d'indemnisation</strong><br /></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;La   
      clause d'indemnisation est une stipulation d'exon&eacute;ration de responsabilit&eacute;   
      juridique qui&nbsp; d&eacute;gage la Couronne de toute responsabilit&eacute; en ce qui   
      concerne les blessures et les dommages qui pourraient être subis durant   
      tout le s&eacute;jour du navire à la CSE. la CSE doit recevoir ce formulaire   
      avant qu'une r&eacute;servation ne puisse être confirm&eacute;e.<br />       
      <br />
    </div>
    <div style="padding-left:40px;"><strong>3.6.4 Formulaire de modification   
      d'une r&eacute;servation</strong><br /></div>  
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pour   
      faire une demande de changement des dates d'une r&eacute;servation, il faut   
      transmettre le formulaire de modification d'une r&eacute;servation à la CSE.<br />       
    </div>
            <P align="left"><a href="#Top">Retour à la table des matières</a> </p>  
    <P align="left"><div style="padding-left:20px;"><em><a name="LoggingOut" id="LoggingOut"></a><span class="style11">3.7  
              Sortir du système</span></em><br /></div> 
    <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pour  
      sortir du système, cliquez sur le bouton &laquo;&nbsp;Fermer la session&nbsp;&raquo;, dans la  
      barre de menus du haut. Il faut toujours sortir du système pour mettre  
      fin à votre session, afin d'empêcher que d'autres personnes n'entrent  
      dans votre compte sur des ordinateurs partag&eacute;s.<br />  
    </div>
            <a href="#Top">Retour à la table des matières</a> </td>
        </tr>
      </table>
	<a href="egd_userdoc-eng.cfm">egd_userdoc-eng</a></body>
</html>


