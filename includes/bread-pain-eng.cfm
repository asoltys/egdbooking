<!-- ====== /CSE-EGD/includes/BREAD-PAIN-ENG.HTML ====== -->

<cfoutput>
<li><a href="http://www.tpsgc-pwgsc.gc.ca/comm/services-eng.html">PWGSC Services</a></li>
<li><a href="http://webdev02.tpsgc-pwgsc.gc.ca/services/bns-prprt-eng.html">Property and Buildings</a></li>
<li><a href="http://webdev02.tpsgc-pwgsc.gc.ca/biens-property_30/index-eng.html">Real Property</a></li>
<li><a href="#EGD_URL#/index-eng.html"><abbr title="Esquimalt Graving Dock">EGD</abbr></a></li>
<li><cfif isDefined("request.title")>
	#request.title#
<cfelse>
	NULL
</cfif></li>	
</cfoutput>
<!-- ====== /CSE-EGD/includes/BREAD-PAIN-ENG.HTML ====== --> 