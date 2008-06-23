<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Booking Forms"">
	<meta name=""keywords"" lang=""eng"" content="""">
	<meta name=""description"" lang=""eng"" content="""">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""">
	<meta name=""dc.date.published"" content=""2005-07-25"">
	<meta name=""dc.date.reviewed"" content=""2005-07-25"">
	<meta name=""dc.date.modified"" content=""2005-07-25"">
	<meta name=""dc.date.created"" content=""2005-07-25"">
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Booking Forms</title>">

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-#lang#.html"><cfinclude template="#RootDir#includes/bread-pain-#lang#.cfm">&gt;
			<CFOUTPUT>
			<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
				<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
			<CFELSE>
				 <a href="#RootDir#text/reserve-book/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
			</CFIF>
			Dock Booking Forms
			</CFOUTPUT>
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
			
			<p>The following files may require <A href="http://www.adobe.com/products/acrobat/readstep2_allversions.html" target="_blank">Adobe Acrobat Reader</A> to be installed.</p>
			<cfoutput>
			<ul>
				<li><a href="../formes-forms/DockBookingApplication.pdf" target="_blank" title="Schedule 1">Schedule 1 (#LSDateFormat(CreateDate(2004, 7, 14), 'long')#) [PDF 55.8 KB]</a></li>
				<li><a href="../formes-forms/indemnificationClause.pdf" target="_blank" title="Indemnification Clause">Indemnification Clause (#LSDateFormat(CreateDate(2002, 6, 18), 'long')#) [PDF 5.58 KB]</a></li>
				<li><a href="../admin/viewFeesForm.cfm?<cfoutput>lang=#lang#</cfoutput>" title="Tariff of Dock Charges">Tariff of Dock Charges [HTML]</a>&nbsp;&nbsp;<a class="textbutton" href="updateFees.cfm?lang=#lang#">update fees</a></li>
				<li><a href="../formes-forms/Tentative_ChangeForm.pdf" target="_blank" title="Tentative Vessel and Change Booking Form">Tentative Vessel and Change Booking Form [PDF 5.51 KB]</a></li>
			</ul>
			</cfoutput>
			
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>

<cfinclude template="#RootDir#includes/foot-pied-#lang#.cfm">