<div class="clear"></div>
<!-- EndEditableContent -->
<dl id="gcwu-date-mod" role="contentinfo">
<dt>Date modified:</dt><dd><span><time><cfoutput query="GetFile">#myDateFormat(parseDateTime(GetFile.DateLastModified,"mm-dd-yyyy"), "yyyy-mm-dd")#</cfoutput></time></span></dd>
</dl>
<!-- MainContentEnd -->
</div></div>

<div id="wb-sec"><div id="wb-sec-in">
<cfinclude template="/site30/includes/app_nav_gauche-nav_left_app-eng.html" />
</div></div>
</div></div>

<div id="wb-foot"><div id="wb-foot-in"><footer><h2>Footer</h2>
<!-- FooterStart -->
<cfinclude template="/site/wet3.0/html5/includes/app_pied_site-site_footer_app-eng.html" />
<cfinclude template="/boew-wet/wet3.0/html5/includes/app_pied_gc-gc_footer_app-eng.html" />
<!-- FooterEnd -->
</footer>
</div></div></div>

<!-- ScriptsStart -->
<cfinclude template="/boew-wet/wet3.0/html5/includes/script_pied-script_footer.html" />
<!-- ScriptsEnd -->
</body>
</html>
