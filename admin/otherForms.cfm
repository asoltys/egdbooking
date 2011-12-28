<cfhtmlhead text="
	<meta name=""dc.title"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Booking Forms"">
	<meta name=""keywords"" content="""" />
	<meta name=""description"" content="""" />
	<meta name=""dc.subject"" scheme=""gccore"" content="""" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Booking Forms</title>">
<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="#CLF_Path#/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<cfoutput>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<a href="#RootDir#admin/menu.cfm?lang=#lang#">Admin</a> &gt; 
			<CFELSE>
				 <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			Dock Booking Forms
			</cfoutput>
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-#lang#.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Dock Booking Forms
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>

			<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">
			
			<p>The following files may require <a href="http://www.adobe.com/products/acrobat/readstep2_allversions.html" rel="external">Adobe Acrobat Reader</a> to be installed.</p>
			<cfoutput>
			<ul>
				<li><a href="../formes-forms/tableau-schedule-1-eng.pdf" title="Schedule 1" rel="external">Schedule 1 (#LSDateFormat(CreateDate(2004, 7, 14), 'long')#) [PDF 55.8 KB]</a></li>
				<li><a href="../formes-forms/indem-eng.pdf" title="Indemnification Clause" rel="external">Indemnification Clause (#LSDateFormat(CreateDate(2002, 6, 18), 'long')#) [PDF 5.58 KB]</a></li>
				<li><a href="../admin/viewFeesForm.cfm?<cfoutput>lang=#lang#</cfoutput>" title="Tariff of Dock Charges">Tariff of Dock Charges [html]</a>&nbsp;&nbsp;<a class="textbutton" href="updateFees.cfm?lang=#lang#">update fees</a></li>
				<li><a href="../formes-forms/changement-change-eng.pdf" title="Tentative Vessel and Change Booking Form" rel="external">Tentative Vessel and Change Booking Form [PDF 5.51 KB]</a></li>
			</ul>
			</cfoutput>
			
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">
