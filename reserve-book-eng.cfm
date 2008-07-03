<cfhtmlhead text="
	<meta name=""dc.title"" lang=""eng"" content=""PWGSC - ESQUIMALT GRAVING DOCK - Booking Space at the Esquimalt Graving Dock"" />
	<meta name=""keywords"" lang=""eng"" content=""Booking Space at the Esquimalt Graving Dock"">
	<meta name=""description"" lang=""eng"" content=""Introduction page for the booking application."">
	<meta name=""dc.subject"" scheme=""gccore"" lang=""eng"" content="""" />
	<meta name=""dc.date.published"" content=""2005-07-25"" />
	<meta name=""dc.date.reviewed"" content=""2005-07-25"" />
	<meta name=""dc.date.modified"" content=""2005-07-25"" />
	<meta name=""dc.date.created"" content=""2005-07-25"" />
	<title>PWGSC - ESQUIMALT GRAVING DOCK - Booking Space at the Esquimalt Graving Dock</title>">

<cfoutput>
<SCRIPT type="text/javascript" language="javascript">
	function popUp(pageID) {
		window.open("#RootDir#" + pageID + ".cfm?lang=<cfoutput>#lang#</cfoutput>", "", "width=640, height=480, resizable=yes, menubar=yes, scrollbars=yes, toolbar=no");
	}
</SCRIPT>
</cfoutput>

<cfinclude template="#RootDir#includes/tete-header-eng.cfm">

		<!-- BREAD CRUMB BEGINS | DEBUT DE LA PISTE DE NAVIGATION -->
		<p class="breadcrumb">
			<cfinclude template="/clf20/ssi/bread-pain-eng.html"><cfinclude template="#RootDir#includes/bread-pain-eng.cfm">
		</p>
		<!-- BREAD CRUMB ENDS | FIN DE LA PISTE DE NAVIGATION -->
		<div class="colLayout">
		<cfinclude template="#RootDir#includes/left-menu-gauche-eng.cfm">
			<!-- CONTENT BEGINS | DEBUT DU CONTENU -->
			<div class="center">
				<h1><a name="cont" id="cont">
					<!-- CONTENT TITLE BEGINS | DEBUT DU TITRE DU CONTENU -->
					Booking Space at the <acronym title="Esquimalt Graving Dock">EGD</acronym>
					<!-- CONTENT TITLE ENDS | FIN DU TITRE DU CONTENU -->
					</a></h1>
				<cfoutput>
				<IMG src="#RootDir#images/EGD_aerial_small.jpg" usemap="##aerial" alt="Aerial view of the Esquimalt Graving Dock" width="435" height="342" title="Aerial view of the Esquimalt Graving Dock" border="0">
				<MAP name="aerial" id="aerial">
					<area href="javascript:void(0);" alt="Operations Centre Building" title="Operations Centre Building" shape="rect" coords="84,207,111,231">
					<area href="javascript:void(0);" alt="North Landing Wharf" title="North Landing Wharf" shape="rect" coords="2,301,175,340">
					<area href="javascript:void(0);" alt="Pumphouse" title="Pumphouse" shape="rect" coords="60,130,98,168">
					<area href="javascript:void(0);" alt="South Jetty" title="South Jetty" shape="rect" coords="270,300,433,340">
					<area href="javascript:void(0);" alt="Drydock Section 1" title="Drydock Section 1" shape="rect" coords="168,51,260,128">
					<area href="javascript:void(0);" alt="Drydock Section 2" title="Drydock Section 2" shape="rect" coords="170,130,262,198">
					<area href="javascript:void(0);" alt="Drydock Section 3" title="Drydock Section 3" shape="rect" coords="170,200,273,298">
					<area href="javascript:void(0);" alt="Aerial view of the Esquimalt Graving Dock" title="Aerial view of the Esquimalt Graving Dock" shape="rect" coords="0,0,435,342">
				</MAP>
				<p>To reserve space for a vessel at any of the facilities of the Esquimalt Graving
				  Dock, please proceed to the <a href="#RootDir#reserve-book/reserve-booking.cfm?lang=eng">Booking 
				  Application</a>.  If you experience any problems with the booking application, please
				  use the <a href="http://www.pwgsc.gc.ca/pacific/egd/contact_us-e.html">contact us</a> page.</p>
				<p>The Esquimalt Graving Dock booking fee is $3,500 Cdn. plus $175.00 Goods &amp; Services Tax (GST) for a total of $3675.00 payable in cash, certified cheque drawn on a Canadian bank or by an international money order. Effective April 1, 2008, interest will be applied on any account outstanding over 30 days.  Reservation requests are tentative until the booking fee is paid. Booking fees are non-refundable.</p>
				<p><a href="#RootDir#reserve-book/reserve-booking.cfm?lang=eng">Booking Application</a> - Book drydock and jetty space online.</p>
				<p><a href="#RootDir#utils/resume-summary_ch.cfm?lang=eng">Booking Summary</a> - View all bookings.</p>
				<p><i>The following links will direct you to an external site:</i><br />
				(<IMG src="#RootDir#images/www1.gif" width="31" height="9" border="0" alt="www site" title="www site">) <a href="http://laws.justice.gc.ca/en/p-38.2/sor-89-332/92221.html">EGD Regulations</a></p>
				<p>&nbsp;</p>
				</cfoutput>
			</div>
		<!-- CONTENT ENDS | FIN DU CONTENU -->
		</div>
<cfinclude template="#RootDir#includes/foot-pied-eng.cfm">

