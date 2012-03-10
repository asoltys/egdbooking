<!-- ====== /CSE-EGD/includes/BREAD-PAIN-ENG.HTML ====== -->
<cfoutput>
&gt; 
<a href="http://www.tpsgc-pwgsc.gc.ca/apropos-about/rgnstnnll-rgnztnal-eng.html">Organization</a> &gt; 
<a href="http://www.tpsgc-pwgsc.gc.ca/pac/index-eng.html">Pacific</a> &gt; 
<a href="#EGD_URL#/index-eng.html"><acronym title="Esquimalt Graving Dock">EGD</acronym></a> &gt; 
  <cfif cgi.script_name eq "#RootDir#reserve-book-eng.cfm">
    #language.bookingSpace#
  <cfelse>
    <a href="#RootDir#reserve-book-eng.cfm">#language.bookingSpace#</a>
  </cfif>
</cfoutput>
<!-- ====== /CSE-EGD/includes/BREAD-PAIN-ENG.HTML ====== --> 
