<!-- ====== /CSE-EGD/includes/BREAD-PAIN-FRA.HTML ====== -->
<cfoutput>
<li><a href="http://www.tpsgc-pwgsc.gc.ca/comm/services-fra.html">Services de TPSGC</a></li>
<li><a href="http://webdev02.tpsgc-pwgsc.gc.ca/services/bns-prprt-fra.html">Biens et immeubles</a></li>
<li><a href="http://webdev02.tpsgc-pwgsc.gc.ca/biens-property_30/index-fra.html">Biens immobiliers</a></li>
<li><a href="#EGD_URL#/index-fra.html"><abbr title="Cale s&egrave;che d'Esquimalt">CSE</abbr></a></li>
<li><cfif isDefined("request.title")>
	#request.title#
<cfelse>
	NULL
</cfif></li>
</cfoutput>
<!-- ====== /CSE-EGD/includes/BREAD-PAIN-FRA.HTML ====== -->
