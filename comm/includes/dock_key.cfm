<cfscript>
legend = [
  language.sec1, 
  language.sec2, 
  language.sec3, 
  language.tentbook, 
  language.pendbook
];
</cfscript>

<cfoutput>
	<table class="keytable">
		<tr><th colspan="2">#language.Key#</th></tr>
		<tr id="sec1">
      <td class="sec1">1</td>
      <td class="sec1"><a name="sec1">#legend[1]#</a></td>
    </tr>
		<tr id="sec2">
      <td class="sec2">2</td>
      <td class="sec2"><a name="sec2">#legend[2]#</a></td>
    </tr>
		<tr id="sec3">
      <td class="sec3">3</td>
      <td class="sec3"><a name="sec3">#legend[3]#</a></td>
    </tr>
		<tr id="tentative">
      <td class="tentative">4</td>
      <td class="tentative"><a name="tentative">#legend[4]#</a></td>
    </tr>
		<tr id="pending">
      <td class="pending">5</td>
      <td class="pending"><a name="pending">#legend[5]#</a></td>
    </tr>
	</table>
</cfoutput>
