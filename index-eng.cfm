<cfoutput>
<cfsavecontent variable="head">
<title>Booking Space at the EGD - Esquimalt Graving Dock - PWGSC</title>
<meta name="description" content="Introduction page for the booking application" />
<meta name="dcterms.description" content="Introduction page for the booking application" />
<meta name="dcterms.title" content="Booking Space at the EGD - Esquimalt Graving Dock - PWGSC" />
<meta name="dcterms.subject" title="gccore" content="#language.masterSubjects#" />
<meta name="keywords" content="Booking Space at the Esquimalt Graving Dock" />
</cfsavecontent>
<cfhtmlhead text="#head#">
<cfset request.title = language.bookingSpace>

<cfinclude template="#RootDir#includes/tete-header-#lang#.cfm">
<h1 id="wb-cont">#language.bookingSpace#</h1>

<div class="span-4">
<img src="#RootDir#images/EGD_aerial_small.jpg" alt="" width="405" height="342" />

<p>To reserve space for a vessel at any of the facilities of the Esquimalt Graving
Dock, please proceed to the <a href="#RootDir#ols-login/ols-login.cfm?lang=eng">#language.bookingApplicationLogin#</a> page.  If you experience any problems with the booking application, please
  use the <a href="#EGD_URL#/cn-cu-#lang#.html">#language.contact# <abbr title="#language.esqGravingDock#">#language.egd#</abbr></a> page.</p>
<p>The Esquimalt Graving Dock booking fee is $4,800.00 Canadian plus $240.00 General Sales Tax (GST) for a total of $5,040.00 payable in cash, certified cheque drawn on a Canadian bank or by an international money order.  Effective April 1, 2008, interest will be applied on any account outstanding over 30 days.  Reservation requests are tentative until the booking fee is paid. Booking fees are non-refundable.</p>
<p><a href="#RootDir#ols-login/ols-login.cfm?lang=eng">#language.bookingApplicationLogin#</a> - Book drydock and jetty space online.</p>
<p><a href="#RootDir#utils/resume-summary_ch.cfm?lang=eng">#language.bookingsSummaryDateSelection#</a> - View all bookings.</p>
<p><a href="http://gazette.gc.ca/rp-pr/p2/2009/2009-12-23/html/sor-dors324-eng.html">Regulations amending the Esquimalt Graving Dock regulations.</a></p>
</div>

<cfinclude template="#RootDir#includes/right-menu-droite-eng.cfm">
<cfinclude template="#RootDir#includes/foot-pied-eng.cfm" />
</cfoutput>

