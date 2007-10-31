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
<cfinclude template="#RootDir#includes/header-#lang#.cfm">

<div class="breadcrumbs">
	<a href="<cfoutput>http://www.pwgsc.gc.ca/text/home-#lang#.html</cfoutput>">PWGSC</a> &gt; 
	Pacific Region &gt; 
	<a href="http://www.pwgsc.gc.ca/pacific/egd/text/index-e.html">Esquimalt Graving Dock</a> &gt; 
	<CFOUTPUT>
		<a href="#RootDir#text/booking-#lang#.cfm">Booking</A> &gt;<CFIF IsDefined('Session.AdminLoggedIn') AND Session.AdminLoggedIn eq true>
			<A href="#RootDir#text/admin/menu.cfm?lang=#lang#">Admin</A> &gt; 
		<CFELSE>
			 <a href="#RootDir#text/booking/booking.cfm?lang=#lang#">Welcome Page</a> &gt;
		</CFIF>
	</CFOUTPUT>
	Dock Booking Forms
</div>

<div class="main">
<H1>Dock Booking Forms</H1>
<CFINCLUDE template="#RootDir#includes/admin_menu.cfm">

<br>
<p>The following files may require <A href="http://www.adobe.com/products/acrobat/readstep2_allversions.html" target="_blank">Adobe Acrobat Reader</A> to be installed.</p>
<cfoutput>
&nbsp;&nbsp;<a href="../forms/DockBookingApplication.pdf" target="_blank" title="Schedule 1">Schedule 1 (#LSDateFormat(CreateDate(2004, 7, 14), 'long')#) [PDF 55.8 KB]</a><br>
&nbsp;&nbsp;<a href="../forms/indemnificationClause.pdf" target="_blank" title="Indemnification Clause">Indemnification Clause (#LSDateFormat(CreateDate(2002, 6, 18), 'long')#) [PDF 5.58 KB]</a><br>
&nbsp;&nbsp;<a href="../admin/viewFeesForm.cfm?<cfoutput>lang=#lang#</cfoutput>" title="Tariff of Dock Charges">Tariff of Dock Charges [HTML]</a>&nbsp;&nbsp;<a class="textbutton" href="updateFees.cfm?lang=#lang#">update fees</a><br>
&nbsp;&nbsp;<a href="../forms/Tentative_ChangeForm.pdf" target="_blank" title="Tentative Vessel and Change Booking Form">Tentative Vessel and Change Booking Form [PDF 5.51 KB]</a>
</cfoutput>
<br><br>



</div>
<cfinclude template="#RootDir#includes/footer-#lang#.cfm">