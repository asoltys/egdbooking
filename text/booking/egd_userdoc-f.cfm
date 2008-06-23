<cfif IsDefined("Session.Form_Structure")>
	<cfset StructDelete(Session, "Form_Structure")>
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>
			Syst√®me de r√©servation en ligne de la Cale s√®che d'Esquimalt : Guide de l'utilisateur
		</TITLE>
		<META http-equiv="Content-Type" content="text/html; charset=utf-8">
        <STYLE type="text/css">
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

H1 {
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
</STYLE>
	</HEAD>
	
	<BODY bgcolor="#FFFFFF" text="#000000">
	
			
	<div align="center" class="style1">
	  <table width="58%"  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="100%">
            <p><a name="Top"></a><h1>Cale s√®che d'Esquimalt (CSE)</h1>       
            <h1>Syst√®me de r√&copy;servation en ligne : Guide de l'utilisateur</h1>       
            <p class="style1">Table des mati√®res</p>       
            <p align="left"><span class="style2"><strong><a href="#Overview">1.        
            Aper√ßu</a></strong></span></p>
            <div style="padding-left:0px;"><strong><a href="#GettingStarted">2. 
              Introduction</a></strong><br>
            </div>
            <div style="padding-left:20px;"><em><a href="#SystemReqs">2.1        
              Configuration exig√&copy;e</a><br>       
              <a href="#CreateAccount">2.2 Cr√&copy;er un compte d'utilisateur</a></em><br>       
            </div>
            <div style="padding-left:40px;">2.2.1 Par o√π commencer<br>       
			  2.2.2 Compagnie(s) de l'utilisateur<br>       
			  2.2.3 Cr√&copy;er un compte de compagnie<br>       
			  2.2.4 Activer un compte d'utilisateur <br>       
            </div>
            <div style="padding-left:20px;"><em><a href="#LoggingIn">2.3 Entr√&copy;e        
              dans le syst√®me</a><br>       
              <a href="#GetPassword">2.4 R√&copy;cup√&copy;ration du mot de passe</a></em><br>       
                  <br>
            </div>
            <span class="style2">
            <div style="padding-left:0px;"><strong><a href="#UsingApp">3.  
              Utilisation du syst√®me de r√&copy;servation en ligne de la CSE</a></strong></div>       
            </span>
            <div style="padding-left:20px;"><em><a href="#HomePage">3.1 Page de 
              bienvenue</a></em><br></div>
			 <div style="padding-left:40px;">3.1.1 Entreprises<br>      
 				 3.1.2 R√&copy;servations       
            </div>
             <div style="padding-left:20px;"><em><a href="#EditProfile">3.2 
              Modifier le profil d'utilisateur</a></em><br>
            </div>
            <div style="padding-left:40px;">3.2.1 Modifier les renseignements        
              personnels<br>
              3.2.2  
              Changement de mot de passe            </div>
            <div style="padding-left:20px;"><em><a href="#Vessels">3.3 Navires</a></em><br>
            </div>
            <div style="padding-left:40px;">3.3.1 Ajouter des navires<br> 
			  3.3.2 Modifier le profil de navires<br> 
			  3.3.3 Supprimer des navires<br> 
            </div>
            <div style="padding-left:20px;"><em><a href="#Bookings">3.4 R√&copy;servations</a></em><br>       
            </div>
            <div style="padding-left:40px;">3.4.1 R√&copy;server une cale s√®che<br></div>       
			<div style="padding-left:60px;"><span class="style8">3.4.1.1 Demande        
              de dates pr√&copy;cises<br>       
				3.4.1.1 Demande de la prochaine p√&copy;riode disponible</span><br></div>       
			<div style="padding-left:40px;">
			  3.4.2 R√&copy;server une jet√&copy;e<br>       
			  3.4.3 Modifier une r√&copy;servation<br>       
			  3.4.4 Annuler une r√&copy;servation<br>       
			  3.4.5 Annulations et suppressions pour des raisons administratives<br>       
			  3.4.6 Pr√&copy;avis de 24 heures<br>       
            </div>
            <div style="padding-left:20px;"><em><a href="#Overviews">3.5 R√&copy;servations        
              - Vues d'ensemble</a></em><br>       
            </div>
            <div style="padding-left:40px;">3.5.1 Calendriers<br>       
 				 3.5.2 Sommaire des r√&copy;servations<br>       
            </div>
            <div style="padding-left:20px;"> <em><a href="#Forms">3.6        
              Formulaires pour les r√&copy;servation</a>s</em><br>      
            </div>
            <div style="padding-left:40px;">
  				3.6.1 Tarifs de droit de cale s√®che<br>     
  				3.6.2 Tableau 1<br>       
  				3.6.3 Clause d'indemnisation<br>       
  				3.6.4 Formulaire de modification d'une r√&copy;servation<br>      
            </div>
            <div style="padding-left:20px;"><em><a href="#LoggingOut">3.7 Sortie        
              du syst√®me</a></em><br>       
            </div>
            
            <p>           
            <hr width="75%">
            <p><strong><br>
              <br>
            <a name="Overview"></a><span class="style10">1. Aper√ßu</span></strong><br>       
            <div style="padding-left:20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Le        
              syst√®me de r√&copy;servation en ligne de la Cale s√®che d'Esquimalt        
              (CSE) est une fa√ßon pratique de r√&copy;server √&copy;lectroniquement des        
              installations de la CSE. Le syst√®me permet aux utilisateurs        
              d'observer l'√&copy;tat des r√&copy;servations qu'ils ont fait pour retenir  
              la cale s√®che ou une jet√&copy;e, et donne acc√®s √† toutes les activit√&copy;s        
              connexes.</div>
            <br>
            <a href="#Top">Retour √† la table des mati√®res</a>       
            <p></p>
            <p><strong><br>
                  <a name="GettingStarted"></a><span class="style10">2. 
            Introduction</span></strong><br> 
            <div style="padding-left:20px;"><em><a name="SystemReqs"></a><strong class="style11">2.1     
              Configuration exig√&copy;e</strong></em></div>    
            <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Avant     
              d'entrer dans le syst√®me&Acirc;∏ veillez √† ce que votre navigateur     
              respecte les param√®tres de configuration suivants :       
                <ul>
                  <li><a href="http://browser.netscape.com/ns8/" target="_blank">Netscape 4+</a> (<a href="http://browser.netscape.com/ns8/download/archive72x.jsp" target="_blank">liens 
                    vers de plus vieilles versions</a>), <a href="http://www.microsoft.com/windows/ie/downloads/critical/ie6sp1/default.mspx" target="_blank">Internet Explorer 4+</a>, 
                    ou <a href="http://www.mozilla.org/products/firefox/" target="_blank">Mozilla Firefox</a></li> 
                  <li>JavaScript activ√&copy;</li>    
                  <li>T√&copy;moins (cookies) activ√&copy;s</li>   
                  <li><a href="http://www.adobe.com/products/acrobat/readstep2_allversions.html" target="_blank">Adobe Acrobat Reader</a>  
                    install√&copy;</li>    
                </ul>
              Pour installer l'un ou l'autre des logiciels requis, cliquez sur     
              les liens ci-dessus. Si vous avez des difficult√&copy;s √† activer le JavaScript     
              ou les t√&copy;moins, suivez les instructions suivantes :      
                <ul>
                  <li>Netscape 4 : Allez √† √âdition &gt; Pr√&copy;f√&copy;rences &gt;   
                    Avanc√&copy; pour activer les deux fonctions. </li>    
                  <li>Netscape 7 ou 8 : Allez √† √âdition &gt; Pr√&copy;f√&copy;rences.   
                    Vous trouverez les fonctions JavaScript sous Avanc√&copy;, et   
                    Cookies sous Confidentialit√&copy; et s√&copy;curit√&copy;.</li>  
                  <li>Internet Explorer 6 : Allez √† Outils &gt; Options Internet.   
                    Vous trouverez JavaScript sous Advanced, et Cookies sous   
                    Confidentialit√&copy;.</li>
                  <li>Mozilla Firefox : Allez √† Outils &gt; Options. Vous trouverez   
                    JavaScript sous Fonctionnalit√&copy;s Web, et Cookies sous   
                    Confidentialit√&copy;.</li>
                </ul>
            </div>
            <a href="#Top">Retour √† la table des mati√®res</a>    
            <p></p>
            <p>            
            <div style="padding-left:20px;"> <em><a name="CreateAccount"></a><span class="style11"><strong>2.2     
              Cr√&copy;er un compte d'utilisateur</strong></span></em>    
            </div>
            <div style="padding-left:40px;"><strong>2.2.1 Par o√π commencer</strong><br>    
            </div>
            <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Allez     
              √† la page principale du site de la CSE : <a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-f.html">http://www.pwgsc.gc.ca/pacific/egd/text/index-f.html</a>     
              et cliquez sur &Acirc;&laquo;&nbsp;R√&copy;servations&nbsp;&Acirc;&raquo; dans le menu lat√&copy;ral.     
              Cliquez sur le lien &Acirc;&laquo; application des r√&copy;servations &Acirc;&raquo;, puis     
              cliquez sur &Acirc;&laquo; ajouter un nouveau compte d'utilisateur &Acirc;&raquo;. Entrez     
              vos coordonn√&copy;es, y compris votre pr√&copy;nom, votre nom de famille,     
              un mot de passe de 6 √† 10 caract√®res et votre adresse de     
              courriel, lesquels sont tous des renseignements obligatoires.     
              L'adresse de courriel que vous donnerez sera utilis√&copy;e pour l'entr√&copy;e     
              dans le syst√®me et les avis que la CSE vous enverra par courriel.     
              Le syst√®me ne fait pas la distinction entre les majuscules et les     
              minuscules pour les mots de passe, donc vous pouvez utiliser aussi     
              bien les unes que les autres. Pour un mot de passe plus s√&copy;curitaire,     
              nous vous sugg√&copy;rons d'utiliser des lettres et des chiffres.       
              <br>
              <br>
            </div>
            <div style="padding-left:40px;"><strong>2.2.2 Entreprises(s) de  
              l'utilisateur</strong><br>
            </div>
            <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;√Ä     
              la prochaine page, ajoutez √† votre profil la ou les entreprises que     
              vous repr√&copy;sentez. Choisissez votre entreprise dans le menu d√&copy;roulant     
              et cliquez sur &Acirc;&laquo;&nbsp;Ajouter&nbsp;&Acirc;&raquo;. Vous pouvez le refaire     
              autant de fois qu'il le faut. Si l'entreprise que vous repr√&copy;sentez     
              n'est pas √&copy;num√&copy;r√&copy;e, voir le paragraphe 2.2.3.<br>       
              <br>
            </div>
            <div style="padding-left:40px;"><strong>2.2.3 Cr√&copy;er un compte  
              d'entreprise</strong><br>
            </div>
            <div style="padding-left:60px;">
              <div align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cliquez sur     
                le lien &Acirc;&laquo; ici&nbsp;&Acirc;&raquo; sous le menu d√&copy;roulant (figure 1)     
                pour cr√&copy;er un profil d'entreprise. Tous les champs sont     
                obligatoires, sauf &Acirc;&laquo; Adresse 2&nbsp;&Acirc;&raquo; et &Acirc;&laquo;&nbsp;Fax&nbsp;&Acirc;&raquo;.     
                En cliquant sur le bouton &Acirc;&laquo;&nbsp;soumettre&nbsp;&Acirc;&raquo;, vous cr√&copy;erez     
                le compte d'entreprise et aviserez la CSE de la demande de cr√&copy;ation     
                d'un nouveau profil d'entreprise. Le profil d'entreprise devra     
                √™tre approuv√&copy; avant que l'on ne puisse l'activer.<br>       
              </div>
            </div>
				<br>
                <div align="center"><img src="../../images/createCompanyLink-f.gif" alt="Figure 1 : Ajouter une nouvelle entreprise"></div>
                <div align="center">Figure 1 : Ajouter une nouvelle entreprise <br>
                
              </div>
            <div style="padding-left:40px;"><br>
            <strong>2.2.4 Activer un compte d'utilisateur</strong>            </div>
            <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lorsque     
              votre ou vos entreprises ont √&copy;t√&copy; ajout√&copy;es, cliquez sur &Acirc;&laquo;     
              Soumettre une demande d'ajout d'un nouvel utilisateur &Acirc;&raquo;. Cela     
              aura pour effet de transmettre votre demande de compte et d'en     
              aviser l'administration de la CSE. Votre compte doit √™tre approuv√&copy;     
              avant que l'on ne puisse l'activer. Si vous ajoutez plusieurs  
              entreprises √† votre profil, il n'est pas n√&copy;cessaire qu'elles     
              soient toutes approuv√&copy;es pour que votre compte soit activ√&copy;. Vous     
              recevrez un avis par courriel lorsqu'une affiliation  
              utilisateur-entreprise est approuv√&copy;e ou rejet√&copy;e.       
              <p></p>
            </div>
            <p><a href="#Top">Retour √† la table des mati√®res</a> </p>    
            <p>
            <div style="padding-left:20px;"><em><a name="LoggingIn"></a><strong class="style11">2.3     
              Entr√&copy;e dans le syst√®me</strong><br>    
            </em></div>
            <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L'approbation     
              d'une seule affiliation utilisateur-entreprise est n√&copy;cessaire     
              pour que le compte soit activ√&copy;. Lorsque vous recevez un courriel     
              vous avisant que l'une de vos affiliations utilisateur-entreprise     
              est approuv√&copy;e, entrez dans le syst√®me avec l'adresse de courriel     
              et le mot de passe que vous avez indiqu√&copy;s lors de la cr√&copy;ation de     
              votre compte. Allez √†&nbsp; <a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-f.html">http://www.pwgsc.gc.ca/pacific/egd/text/index-f.html</a>     
              et cliquez sur &Acirc;&laquo; R√&copy;servations &Acirc;&raquo; dans le menu lat√&copy;ral. Cliquez     
              ensuite sur le lien &Acirc;&laquo; Application des r√&copy;servations&nbsp;&Acirc;&raquo;. Cela     
              vous m√®nera √† la page d'entr√&copy;e dans le syst√®me.</div>       
            <p></p>
            <a href="#Top">Retour √† la table des mati√®res</a> <br>    
            <p>            
            <div style="padding-left:20px;"><em><a name="GetPassword"></a><strong class="style11">2.4     
              R√&copy;cup√&copy;ration du mot de passe</strong><br>    
            </em></div>
            <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Si     
              vous avez oubli√&copy; votre mot de passe, cliquez sur le lien &Acirc;&laquo; Oubli  
              du mot de passe &Acirc;&raquo; de la page d'entr√&copy;e. Entrez l'adresse     
              de courriel que vous utilisez pour l'entr√&copy;e dans le syst√®me, et     
              votre mot de passe vous sera transmis par courriel.<br>       
            </div>
            <br>
            <a href="#Top">Retour √† la table des mati√®res</a>    
            <p></p>
            <p>     <br>       
            <strong><a name="UsingApp"></a><span class="style10">3. Utilisation  
            du     
            syst√®me de r√&copy;servation en ligne de la CSE</span></strong>    
            
            <div style="padding-left:20px;"><em><a name="HomePage"></a><span class="style11"><strong>3.1 
              Page de bienvenue</strong></span></em><br>
            </div>
            <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lorsque     
              vous entrez dans l'application, vous arrivez √† la &Acirc;&laquo; page de     
              bienvenue &Acirc;&raquo; du syst√®me de r√&copy;servation. Vous avez acc√®s √†     
              toutes les fonctions du syst√®me de r√&copy;servation √† partir de     
              cette page. Toutes les principales fonctions sont disponibles √†     
              partir de la barre de menus sous le titre de la page (figure 2).     
              Vous pouvez aussi naviguer dans le site au moyen de la piste de     
              navigation (figure 3). La piste de navigation vous indique le     
              chemin que vous avez suivi jusqu'√† maintenant dans le site, ce     
              qui peut √™tre tr√®s utile si vous voulez revenir en arri√®re.</div>       
            <br>
                <div align="center"><img src="../../images/userMenuBar-f.gif" alt="Figure 2 : barre de menus"></div>
                <div align="center">Figure 2: barre de menus <br>
                </div>
			<br>
                <div align="center"><img src="../../images/userBreadcrumbs-f.gif" alt="Figure 3 : piste de navigation"></div>
                <div align="center">Figure 3: piste de navigation <br>
            <br>
            </div>
			<div style="padding-left:40px;"><strong>3.1.1 Entreprises</strong></div>
			<div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;La     
              page de bienvenue affiche des renseignements sur une entreprise √†     
              la fois. Le nom de l'entreprise dont on voit les renseignements     
              est affich√&copy; dans le titre. Si vous √™tes autoris√&copy; √† repr√&copy;senter     
              plus d'une entreprise, l'affichage des renseignements de  
              l'entreprise pr√&copy;cis√&copy;e se fera sous la barre de menus, et les noms     
              des autres entreprises seront affich√&copy;s tout juste en dessous     
              (figure&nbsp;4). Vous pouvez passer d'une entreprise √† une autre     
              en cliquant sur leur nom. Le nom de toute entreprise pour laquelle     
              vous attendez l'approbation de repr√&copy;sentation appara√&reg;tra tout juste     
              en dessous de votre liste d'entreprises.<br>      
			  <br>
                <div align="center"><img src="../../images/userCompanies-f.gif" alt="Figure 4 : vos entreprises"></div>
                <div align="center">Figure 4: vos entreprises <br>
                </div>
			</div>
			<br>
			<div style="padding-left:40px;"><strong>3.1.2 R√&copy;servations</strong></div>    
			<div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Toutes     
              les r√&copy;servations pour l'entreprise que vous choisissez&nbsp; sont     
              affich√&copy;es sur la page de bienvenue. Pour une liste compl√®te de     
              toutes les r√&copy;servations, y compris les r√&copy;servations pass√&copy;es,     
              cliquez sur le bouton &Acirc;&laquo;&nbsp;Toutes les r√&copy;servations &Acirc;&raquo;.<br>       
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Les r√&copy;servations sont ainsi     
              divis√&copy;es : &Acirc;&laquo; Cale s√®che&nbsp;&Acirc;&raquo;, &Acirc;&laquo;&nbsp;Quai de d√&copy;barquement nord &Acirc;&raquo; et &Acirc;&laquo; Jet√&copy;e     
              sud &Acirc;&raquo;. Seuls les renseignements essentiels sont affich√&copy;s : nom     
              du navire, dates au bassin, √&copy;tat de la r√&copy;servation et agent     
              responsable de la r√&copy;servation. En cliquant sur le nom du navire,     
              vous pouvez voir d'autres renseignements sur la r√&copy;servation, et     
              vous avez l'option de la modifier ou de l'annuler. Pour les r√&copy;servations     
              de la cale s√®che, il y a aussi un lien menant qui permet de &Acirc;&laquo;  
              Consulter le formulaire de tarif&nbsp;&Acirc;&raquo; ou d'apporter une &Acirc;&laquo;  
              Modification au&nbsp; formulaire de tarif &Acirc;&raquo;. Veuillez consulter le paragraphe 3.6.1     
              pour de plus amples renseignements sur les formulaires de tarif.</div>      
		   
            <p><a href="#Top">Retour √† la table des mati√®res</a> </p>    
<p>
<div style="padding-left:20px;"><em><a name="EditProfile"></a><span class="style11"><strong>3.2 
  Modifier le profil d'utilisateur</strong></span></em><br></div>
  <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pour     
    modifier votre profil, cliquez sur &Acirc;&laquo;&nbsp;Modifier le profil&nbsp;&Acirc;&raquo; dans     
    la barre de menus. La page &Acirc;&laquo;&nbsp;Modifier le profil&nbsp;&Acirc;&raquo; est divis√&copy;e     
    en trois sections, et chacune d'entre elles a son bouton de soumission.<br>       
    <br>
  </div>
  <div style="padding-left:40px;"><strong>3.2.1 Modifier les renseignements 
    personnels</strong><br></div>
  <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;La premi√®re     
    section vous permet de modifier votre pr√&copy;nom et votre nom. L'adresse de     
    courriel ne peut pas √™tre modifi√&copy;e, √&copy;tant donn√&copy; qu'il s'agit de votre     
    code d'identification pour l'entr√&copy;e dans le syst√®me. Pour utiliser une     
    adresse de courriel diff√&copy;rente, vous devez cr√&copy;er un nouveau compte     
    d'utilisateur.<br>   
    <br>
  </div>
	<div align="center"><img src="../../images/userEditUserName-f.gif" alt="Figure 5 : modifier votre nom"></div>
	<div align="center">Figure 5 : modifier votre nom <br><br>
  </div>
  <div style="padding-left:40px;"><strong>3.2.2 Changement de mot de passe</strong><br>
  </div> 
  <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;La troisi√®me     
    section vous permet de changer votre mot de passe, qui doit compter de 6 √†     
    10 caract√®res.&nbsp; Le syst√®me ne fait pas la distinction entre les     
    majuscules et les minuscules pour les mots de passe, donc vous pouvez     
    utiliser aussi bien les unes que les autres. Pour des raisons de s√&copy;curit√&copy;,     
    nous vous sugg√&copy;rons d'utiliser des lettres et des chiffres dans votre mot     
    de passe, et de le changer fr√&copy;quemment.</div>       
  <br><div align="center"><img src="../../images/editUserPassword-f.gif" alt="Figure 7 : modifier votre mot de passe"></div>
	<div align="center">Figure 7: modifier votre mot de passe <br>
  </div>
            <p><a href="#Top">Retour √† la table des mati√®res</a> </p>    
  
  <p> <div style="padding-left:20px;"><em><a name="Vessels"></a><span class="style11"><strong>3.3 
              Navires</strong></span></em><br></div>
    <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Les     
      navires d'une entreprise sont √&copy;num√&copy;r√&copy;s dans la page de bienvenue sous la     
      rubrique &Acirc;&laquo;&nbsp;Navire(s)&nbsp;&Acirc;&raquo;. Si le navire que vous cherchez n'est     
      pas dans la liste, v√&copy;rifiez si vous avez bien les renseignements pour la     
      bonne entreprise. Pour voir les renseignement sur le navire, cliquez sur     
      son nom.<br>       
      <br>
    </div>
	<div style="padding-left:40px;"><strong>3.3.1 Ajouter des navires</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cliquez     
      &Acirc;&laquo;&nbsp;Ajout d'un navire&nbsp;&Acirc;&raquo; sous la liste des navires de  
      l'entreprise. Tous les champs sont obligatoires. Les longueurs et les     
      largeurs sont en m√®tres, et les temps d'installation et de retrait des  
      tins sont en jours. Le temps d'installation des tins est le nombre de jours n√&copy;cessaires     
      pour installer les tins de soutien avant que l'eau ne puisse √™tre enlev√&copy;e     
      de la cale, et le temps de retrait des tins est le nombre de jours n√&copy;cessaires     
      pour faire l'inverse. Il faut inclure ces temps dans le nombre de jours     
      demand√&copy;s pour la r√&copy;servation.<br>       
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Si un navire est anonyme, toutes les r√&copy;servations     
      pour ce navire seront affich√&copy;es sans nom dans les calendriers et les     
      sommaires des r√&copy;servations. Ainsi, seules les dates et l'√&copy;tat de la r√&copy;servation     
      sont affich√&copy;s pendant que celle-ci est en traitement attente de confirmation ou     
      provisoire. Lorsque la confirmation est donn√&copy;e, l'information     
      additionnelle suivante est affich√&copy;e&nbsp;: l'entreprise, le nom du navire     
      et sa longueur, les sections r√&copy;serv√&copy;es ainsi que les dates de la r√&copy;servation.     
      Tout autre renseignement sur le navire ou la r√&copy;servation ne peut √™tre vu     
      par les utilisateurs d'autres entreprises. Les administrateurs ont acc√®s     
      √† toute l'information sur les r√&copy;servations et les navires, peu importe  
      si ces derniers sont anonymes ou non.<br>      
    <br></div>
    <div style="padding-left:40px;"><strong>3.3.2 Modifier le profil de navires</strong></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cliquez     
      sur le nom du navire dans la rubrique &Acirc;&laquo;&nbsp;Navire(s) &Acirc;&raquo;, puis cliquez     
      sur le bouton &Acirc;&laquo;&nbsp;Modifier le navire &Acirc;&raquo;. Vous pouvez     
      modifier tous les renseignements sur le navire, √† l'exception de  
      l'entreprise, √† condition que le navire n'ait pas de r√&copy;servation confirm√&copy;e.     
      Dans le cas contraire, vous ne pourrez pas modifier les dimensions du     
      navire. Pour ce faire, vous devrez communiquer avec l'administration du     
      CSE. L'administration est avis√&copy;e lorsque les renseignements sur un navire     
      sont modifi√&copy;s.<br>       
      <br></div>
    <div style="padding-left:40px;"><strong>3.3.3 Supprimer des navires</strong></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cliquez     
      sur le nom du navire dans la rubrique &Acirc;&laquo;&nbsp;Navire(s), puis cliquez sur     
      le bouton &Acirc;&laquo; Supprimer le navire&nbsp;&Acirc;&raquo;. Les navires ne peuvent √™tre supprim√&copy;s     
      que s'il ne font l'objet d'aucune demande de r√&copy;servation. Dans le cas     
      contraire, vous recevrez un message affichant les r√&copy;servations pour le     
      navire qui doivent √™tre annul√&copy;es avant que le navire ne puisse √™tre     
      supprim√&copy;. Si vous arrivez √† supprimer le navire, vous recevrez un avis     
      de confirmation.</div>       
            <p><a href="#Top">Retour √† la table des mati√®res</a> </p>    
  <p> <div style="padding-left:20px;"><em><a name="Bookings"></a><span class="style11"><strong>3.4     
              R√&copy;servations</strong></span></em></div>
    <div style="padding-left:40px;"><strong>3.4.1 R√&copy;server la cale s√®che</strong></div>   
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cliquez    
      sur &Acirc;&laquo;&nbsp;Pr√&copy;senter une r√&copy;servation&nbsp;&Acirc;&raquo; sous vos r√&copy;servations&nbsp;  
      ou sur &Acirc;&laquo;&nbsp;Pr√&copy;senter une r√&copy;servation&nbsp;&Acirc;&raquo;    
      dans la barre de menus, puis choisissez l'option de r√&copy;servation de la    
      cale s√®che. Il y a deux fa√ßons de r√&copy;server la cale s√®che : indiquer des    
      dates pr√&copy;cises, ou demander le nombre de jours voulus dans la prochaine p√&copy;riode    
      libre (p. ex. demander la&nbsp; prochaine p√&copy;riode de 10 jours dans l'ann√&copy;e    
      qui vient.).<br>       
      <br>
    </div>
	<div style="padding-left:60px;"><span class="style12">3.4.1.1 Demande de    
      dates pr√&copy;cises</span><br></div>   
	  <div style="padding-left:80px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tous    
        les champs sont obligatoires pour la r√&copy;servation. Il faut choisir  
        l'entreprise et le navire au moyen des menus d√&copy;roulants, et il faut pr√&copy;ciser    
        les dates du d√&copy;but et de la fin de la p√&copy;riode r√&copy;serv√&copy;e. Vous pouvez    
        entrer manuellement les dates &Acirc;&laquo;&nbsp;mm/jj/aaaa&nbsp;&Acirc;&raquo; ou utiliser les    
        boutons calendriers. Lorsque vous cliquez sur l'un de ces boutons, un    
        petit calendrier appara√&reg;t, dans lequel vous pouvez cliquer sur la date    
        choisie. Cette date sera entr√&copy;e dans la bo√&reg;te de date correspondante.    
        Lorsque vous choisissez des dates de bassin, veuillez vous assurer de    
        tenir compte du temps n√&copy;cessaire pour installer et retirer les tins.  (<em>Nota    
        </em>: les dates de bassin sont inclusives, p.&nbsp;ex. une r√&copy;servation    
        de trois jours se fera du 1<sup>er</sup> mai au 3 mai.)<br>       
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Si la cale s√®che est disponible pour les    
        dates demand√&copy;es, vote demande sera soumise. Si rien n'est disponible    
        pour les dates pr√&copy;cis√&copy;es, vous avez le choix d'essayer de nouvelles    
        dates, ou de maintenir votre demande dans l'espoir d'une annulation.    
        Veuillez consulter le paragraphe 3.4.6 pour de plus amples    
        renseignements sur le processus de pr√&copy;avis de 24&nbsp;heures pour les    
        annulations.<br>    
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lorsque votre r√&copy;servation est soumise, un    
        avis est transmis par courriel √† l'administration de la CSE, et vous    
        recevez un formulaire de tarif des droits de cale s√®che. Il s'agit d'un formulaire    
        facultatif; pour de plus amples renseignements, voir le paragraphe 3.6.1.<br>       
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Il incombe √† l'administration de la CSE    
        d'approuver la r√&copy;servation; toutefois, lorsque vous avez re√ßu l'avis    
        de confirmation de la r√&copy;servation par courriel, vous devez envoyer les    
        formulaires appropri√&copy;es - le tableau 1 et la clause d'indemnisation -    
        ainsi que les frais de r√&copy;servation de 3 500 $ avant que la r√&copy;servation    
        ne puisse √™tre confirm√&copy;e. Pri√®re de consulter la section 3.6 pour de    
        plus amples renseignements sur les formulaires requis.<br>       
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Si votre r√&copy;servation est approuv√&copy;e et que    
        d'autres r√&copy;servations provisoires sont faites pour la m√™me p√&copy;riode,    
        la politique de pr√&copy;avis de 24 heures sera appliqu√&copy;e (section 3.4.6).    
        Vous serez avis√&copy; par courriel de la confirmation √&copy;ventuelle de votre r√&copy;servation.<br>       
        <br>
        </div>
    <div style="padding-left:60px;"><span class="style12">3.4.1.2 Demande de la    
      prochaine p√&copy;riode disponible</span></div>   
	<div style="padding-left:80px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tous les    
      champs sont obligatoires; il faut donc choisir l'entreprise et le navire    
      au moyen de menus d√&copy;roulants, une p√&copy;riode doit √™tre pr√&copy;cis√&copy;e de la fa√ßon    
      d√&copy;crite au paragraphe 3.4.1.1, et le nombre de jours requis pour la r√&copy;servation    
      doit √™tre pr√&copy;cis√&copy;. Le nombre de jours pour la r√&copy;servation doit √™tre    
      inf√&copy;rieur ou √&copy;gal √† la dur√&copy;e de la p√&copy;riode pr√&copy;cis√&copy;e.<br>       
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lorsque vous soumettez une demande, on    
      vous donnera la prochaine p√&copy;riode disponible pour la dur√&copy;e de la r√&copy;servation    
      pr√&copy;cis√&copy;e. Si c'est acceptable, vous pouvez faire la r√&copy;servation; sinon,    
      vous pouvez essayer une autre p√&copy;riode. (<em>Nota </em>: Lorsque vous    
      utilisez l'autre m√&copy;thode de r√&copy;servation qui prend les dates pr√&copy;cises,    
      si votre p√&copy;riode pr√&copy;cis√&copy;e n'est pas disponible, votre r√&copy;servation sera    
      approuv√&copy;e et vous serez mis sur une liste d'attente au cas o√π une    
      annulations surviendrait, et la politique de pr√&copy;avis de 24 heures sera    
      appliqu√&copy;e. Pri√®re de consulter le paragraphe 3.4.6 pour de plus amples    
      renseignements. (La m√&copy;thode qui consiste √† demander la prochaine p√&copy;riode    
      disponible n'offre pas cette option.)<br>       
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lorsque vous soumettez une demande de r√&copy;servation,    
      un avis est transmis par courriel √† l'administration de la CSE, et vous    
      voyez appara√&reg;tre le formulaire des tarifs de radoub. Il s'agit d'un    
      formulaire optionnel; pour de plus amples renseignements, voir le    
      paragraphe 3.6.1.<br>       
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Il incombe √†    
      l'administration de la CSE d'approuver la r√&copy;servation; toutefois, lorsque    
      vous avez re√ßu l'avis de confirmation de la r√&copy;servation par courriel,    
      vous devez envoyer les formulaires appropri√&copy;es - le tableau 1 et la    
      clause d'indemnisation - ainsi que les frais de r√&copy;servation de 3 500 $    
      avant que la r√&copy;servation ne puisse √™tre confirm√&copy;e. Pri√®re de consulter    
      la section 3.6 pour de plus amples renseignements sur les formulaires    
      requis.<br>    
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Si votre r√&copy;servation est approuv√&copy;e et que    
      d'autres r√&copy;servations provisoires sont faites pour la m√™me p√&copy;riode, la    
      politique de pr√&copy;avis de 24 heures sera appliqu√&copy;e (section 3.4.6). Vous    
      serez avis√&copy; par courriel de la confirmation √&copy;ventuelle de votre r√&copy;servation.<br>       
	</div>
	<div style="padding-left:40px;"><strong>3.4.2 R√&copy;server une jet√&copy;e</strong></div>   
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cliquez    
      sur &Acirc;&laquo; Pr√&copy;senter une r√&copy;servation &Acirc;&raquo; sous vos r√&copy;servations ou dans la barre des menus, et choisissez l'option de r√&copy;servation    
      d'une jet√&copy;e. Tous les champs sont obligatoires pour la r√&copy;servation d'une    
      jet√&copy;e. Vous pouvez choisir l'entreprise, le navire et la jet√&copy;e au moyen    
      des menus d√&copy;roulants. Les dates du d√&copy;but et de la fin de p√&copy;riode voulue    
      peuvent √™tre pr√&copy;cis√&copy;es de la fa√ßon d√&copy;crite au paragraphe 3.4.1.1.<br>       
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lorsque vous soumettez une demande de r√&copy;servation,    
      l'administration de la CSE en est avis√&copy;e. Pour que la r√&copy;servation soit    
      confirm√&copy;e, vous devez faire parvenir les formulaires du tableau 1 et de    
      la clause d'indemnisation. Pri√®re de consulter le paragraphe 3.6 pour de    
      plus amples renseignements sur les formulaires demand√&copy;s. Vous serez avis√&copy;    
      par courriel de la confirmation √&copy;ventuelle de votre r√&copy;servation. Il n'y    
      a pas de frais pour la r√&copy;servation d'une jet√&copy;e, mais si le navire    
      n'arrive pas aux dates indiqu√&copy;es, l'entreprise se verra facturer des    
      frais de r√&copy;servation.<br>       
	<br>
    </div>
    <div style="padding-left:40px;"><strong>3.4.3 Modifier des r√&copy;servations</strong><br></div>   
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Les r√&copy;servations    
      ne peuvent √™tre modifi√&copy;es en ligne. Si vous souhaitez modifier une r√&copy;servation,    
      vous devez communiquer avec l'administration de la CSE et transmettre par    
      courrier ou par fax une copie papier du formulaire de modification d'une r√&copy;servation.    
      Une version PDF de ce formulaire est disponible en ligne. Pour l'ouvrir,    
      allez √† la page de bienvenue et cliquez sur &Acirc;&laquo; Formulaires de r√&copy;servation&nbsp;&Acirc;&raquo;    
      en haut de la liste de vos r√&copy;servations.<br>       
      <br>
    </div>
    <div style="padding-left:40px;"><strong>3.4.4 Annuler des r√&copy;servations</strong><br></div>   
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Il est    
      possible d'annuler des r√&copy;servations. Pour ce faire, cliquez sur le nom du    
      navire dans la liste des r√&copy;servations sur la page de bienvenue ou la page    
      des r√&copy;servations archiv√&copy;es, puis cliquez sur le bouton &Acirc;&laquo;&nbsp;Demander    
      l'annulation&nbsp;&Acirc;&raquo;. Lorsque vous demandez une annulation,    
      l'administration de la CSE sera avis√&copy;e de la demande, et votre annulation    
      sera consid√&copy;r√&copy;e comme en traitement jusqu'√† ce que vous receviez un autre    
      avis. Si vous ne recevez pas d'avis d'annulation de votre r√&copy;servation,    
      cela veut dire que celle-ci est maintenue.<br>       
	<br>
    </div>
    <div style="padding-left:40px;"><strong>3.4.5 Annulations et suppressions 
      administratives</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L'administration    
      de la CSE a la capacit√&copy; d'annuler les r√&copy;servations actuelles, ainsi que    
      de supprimer les r√&copy;servations pass√&copy;es. Vous serez avis√&copy; par courriel si    
      l'une de vos r√&copy;servations est annul√&copy;e. Si l'administration supprime une r√&copy;servation    
      pass√&copy;e, vous ne serez pas avis√&copy;, mais vous remarquerez toutefois    
      qu'elle n'est plus affich√&copy;e dans la liste de vos r√&copy;servations archiv√&copy;es.<br>       
      <br>
    </div>
  	<div style="padding-left:40px;"><strong>3.4.6 Pr√&copy;avis de 24 heures</strong><br></div>   
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;La CSE    
      maintient une politique de pr√&copy;avis de 24&nbsp;heures en ce qui concerne les    
      listes d'attente. Si plusieurs r√&copy;servations provisoires indiquent la m√™me    
      p√&copy;riode de cale s√®che, la politique veut que le principe du premier    
      arriv√&copy;, premier servi s'applique. Par cons√&copy;quent, la premi√®re  
      entreprise    
      qui a demand√&copy; la p√&copy;riode la re√ßoit, √† condition qu'elle paye les frais    
      de r√&copy;servation et soumette les formulaires requis.<br>       
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cependant, si une autre entreprise plus    
      bas dans la liste paye les frais de r√&copy;servation et fournit les    
      formulaires en premier, toutes les entreprises ayant des demandes de r√&copy;servation    
      provisoires faites ant√&copy;rieurement auront 24 heures de pr√&copy;avis pour payer    
      les frais de r√&copy;servation, en commen√ßant par le d√&copy;but de la liste. 
      L'entreprise en haut de la liste sera avis√&copy;e la premi√®re. Si elle choisit de    
      ne pas prendre la p√&copy;riode, la prochaine entreprise sera avis√&copy;e, et ainsi    
      de suite. Si aucune de ces entreprises ne paye les frais de r√&copy;servation    
      dans le d√&copy;lai allou√&copy;, l'entreprise originale qui fait la demande de    
      confirmation re√ßoit la p√&copy;riode. La m√™me politique s'applique lorsque    
      des p√&copy;riodes deviennent disponibles en raison d'annulations.<br>       
    </div>
            <p><a href="#Top">Retour √† la table des mati√®res</a> </p>   
     
  <p> <div style="padding-left:20px;"><em><a name="Overviews"></a><span class="style11"><strong>3.5    
              R√&copy;servations - Vue d'ensemble</strong></span></em></div>   
    <div style="padding-left:40px;"><strong>3.5.1 Calendriers</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;La barre    
      de menus du haut donne acc√®s aux calendriers de la cale s√®che et des jet√&copy;es.    
      Des tableaux mensuels et trimestriels sont disponibles (figure 8). Les    
      calendriers affichent par d√&copy;faut le mois en cours, mais on peut voir    
      d'autres mois au moyen des menus d√&copy;roulants. Chaque jour affiche un    
      sommaire des r√&copy;servations confirm√&copy;es pour chaque section ou chaque jet√&copy;e,    
      ainsi que le nombre de r√&copy;servations en traitement ou provisoires pour cette    
      journ√&copy;e. En cliquant sur une date, vous voyez un sommaire plus d√&copy;taill√&copy;    
      des r√&copy;servations pour la journ√&copy;e en question.<br>       
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Si un navire est anonyme et si la r√&copy;servation    
      n'est pas confirm√&copy;e, le calendrier indiquera &Acirc;&laquo; Navire de haute mer&nbsp;&Acirc;&raquo;,    
      et ne donnera que l'√&copy;tat de la r√&copy;servation et les dates d'amarrage.    
      Lorsque la r√&copy;servation est confirm√&copy;e, quelques renseignements    
      additionnels limit√&copy;s sont affich√&copy;s. Pour les navires que tous peuvent    
      voir, un lien m√®nent √† des renseignements plus d√&copy;taill√&copy;s sur la r√&copy;servation    
      et le navire.<br>        
	<br>
    </div>
    <div style="padding-left:40px;"><strong>3.5.2 Sommaire des r√&copy;servations</strong><br></div>   
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;√Ä    
      partir de toutes les pages du calendrier, vous avez acc√®s √† un lien &Acirc;&laquo; R√&copy;sum√&copy; des r√&copy;servations &Acirc;&raquo; tout juste sous la barre de menus du haut    
      (figure 8). Le r√&copy;sum√&copy; des r√&copy;servations est un tableau regroupant    
      l'information donn√&copy;e dans les calendriers. Il affiche le nom et la    
      longueur du navire, l'√&copy;tat de la r√&copy;servation, la ou les sections ou la    
      jet√&copy;e r√&copy;serv√&copy;es, les dates d'amarrage et la date o√π la demande de r√&copy;servation    
      a √&copy;t√&copy; soumise. On peut faire afficher une version facile √† imprimer en    
      cliquant sur le bouton &Acirc;&laquo;&nbsp;Voir la version imprimable&nbsp;&Acirc;&raquo;.<br>       
    </div>
	<div align="center"><img src="../../images/userCalMenu-f.gif" alt="Figure 8 : Vue d'ensemble des r&eacute;servations"></div>
	<div align="center">Figure 8 : Vue d'ensemble des r√&copy;servations <br><br>   
 	 </div>
            <a href="#Top">Retour √† la table des mati√®res</a> <br>   
    <br>
    <div style="padding-left:20px;"><em><a name="Forms"></a><span class="style11">3.6    
      Formulaires pour les r√&copy;servations</span></em></div>   
    <div style="padding-left:40px;"><strong>3.6.1 Tarifs des droits de cale s√®che</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Le    
      formulaire des tarifs de droits de cale s√®che est un formulaire optionnel qui vous    
      permet de pr√&copy;ciser les services et les installations dont vous aurez    
      besoin, et qui permettra ainsi √† la CSE d'avoir les ressources dont vous 
      aurez besoin durant la p√&copy;riode que vous r√&copy;servez. Lorsque votre r√&copy;servation    
      est confirm√&copy;e, vous devriez confirmer √&copy;galement vos besoins exacts    
      directement avec la CSE. <br>       
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Le formulaire s'affichera apr√®s que   
      vous aurez demand√&copy; une r√&copy;servation. Vous pouvez le remplir √† ce   
      moment-l√†, ou d√&copy;cider de le faire plus tard. Si vous voulez modifier vos   
      entr√&copy;es ou remplir le formulaire plus tard, vous pourrez le faire √†   
      partir de la page de bienvenue. Les formulaires des tarifs peuvent √™tre   
      modifi√&copy;s pour les r√&copy;servations en traitement et provisoire. Cliquez sur le   
      lien &Acirc;&laquo; Modification du formulaire de tarif&nbsp;&Acirc;&raquo; dans la liste des r√&copy;servations   
      pour apporter des changements ou remplir le formulaire pour la premi√®re   
      fois. Si une r√&copy;servation est confirm√&copy;e, vous pouvez faire afficher le   
      formulaire des tarifs en cliquant sur&nbsp; &Acirc;&laquo;&nbsp;Consulter le formulaire 
      de tarif&nbsp;&Acirc;&raquo;. Pour faire apporter des changements au formulaire de 
      tarif d'une r√&copy;servation confirm√&copy;e, pri√®re de communiquer avec la CSE.<br>       
	<br>
    </div>
    <div style="padding-left:40px;"><strong>3.6.2 Tableau 1</strong><br></div> 
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Le   
      tableau 1 donne des renseignements sur le navire, et sert d'entente entre   
      l'agent qui fait la r√&copy;servation et la CSE. La CSE doit recevoir le   
      tableau 1 avant que la r√&copy;servation ne puisse √™tre confirm√&copy;e.<br>       
      <br>
    </div>
    <div style="padding-left:40px;"><strong>3.6.3 Clause d'indemnisation</strong><br></div>
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;La   
      clause d'indemnisation est une stipulation d'exon√&copy;ration de responsabilit√&copy;   
      juridique qui&nbsp; d√&copy;gage la Couronne de toute responsabilit√&copy; en ce qui   
      concerne les blessures et les dommages qui pourraient √™tre subis durant   
      tout le s√&copy;jour du navire √† la CSE. la CSE doit recevoir ce formulaire   
      avant qu'une r√&copy;servation ne puisse √™tre confirm√&copy;e.<br>       
      <br>
    </div>
    <div style="padding-left:40px;"><strong>3.6.4 Formulaire de modification   
      d'une r√&copy;servation</strong><br></div>  
    <div style="padding-left:60px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pour   
      faire une demande de changement des dates d'une r√&copy;servation, il faut   
      transmettre le formulaire de modification d'une r√&copy;servation √† la CSE.<br>       
    </div>
            <p align="left"><a href="#Top">Retour √† la table des mati√®res</a> </p>  
    <p align="left"><div style="padding-left:20px;"><em><a name="LoggingOut" id="LoggingOut"></a><span class="style11">3.7  
              Sortir du syst√®me</span></em><br></div> 
    <div style="padding-left:40px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pour  
      sortir du syst√®me, cliquez sur le bouton &Acirc;&laquo;&nbsp;Fermer la session&nbsp;&Acirc;&raquo;, dans la  
      barre de menus du haut. Il faut toujours sortir du syst√®me pour mettre  
      fin √† votre session, afin d'emp√™cher que d'autres personnes n'entrent  
      dans votre compte sur des ordinateurs partag√&copy;s.<br>  
    </div>
            <a href="#Top">Retour √† la table des mati√®res</a> </td>
        </tr>
      </table>
	<a href="file:///H|/EGDBooking/text/booking/egd_userdoc-e.html">egd_userdoc-e</a></BODY>
</HTML>

