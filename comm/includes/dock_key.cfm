<cfset legend = arrayNew(1) />

<cfset arrayAppend(legend, language.pendbook) />
<cfset arrayAppend(legend, language.tentbook) />
<cfset arrayAppend(legend, language.sec1) />
<cfset arrayAppend(legend, language.sec2) />
<cfset arrayAppend(legend, language.sec3) />

<cfoutput>
	<table class="keytable">
		<tr><th colspan="2">#language.legend#</th></tr>
		<tr id="l1">
      <td class="pending">1</td>
      <td class="pending"><a name="pending">#legend[1]#</a></td>
    </tr>
		<tr id="l2">
      <td class="tentative">2</td>
      <td class="tentative"><a name="tentative">#legend[2]#</a></td>
    </tr>
		<tr id="l3">
      <td class="sec1">3</td>
      <td class="sec1"><a name="sec1">#legend[3]#</a></td>
    </tr>
		<tr id="l4">
      <td class="sec2">4</td>
      <td class="sec2"><a name="sec2">#legend[4]#</a></td>
    </tr>
		<tr id="l5">
      <td class="sec3">5</td>
      <td class="sec3"><a name="sec3">#legend[5]#</a></td>
    </tr>
	</table>
</cfoutput>
