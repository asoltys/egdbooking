<cfoutput>
<table class="keytable" cellspacing="0" align="center" cellpadding="2">
<tr align="center"><td style="border-bottom: 1px solid ##cccccc;" colspan="2">#language.Key#</td></tr>
<tr align="center"><td id="type_#pos#" style="border-right: 1px solid ##cccccc; border-bottom: 1px solid##cccccc;" width="50%">#language.bookingtype#</td><td id="section_#pos#" style="border-bottom: 1px solid##cccccc; ">#language.sec#</td></tr>
<tr><td class="pending" headers="type_#pos#" style="border-right: 1px solid ##cccccc;" width="50%">#language.PendBook#</td><td headers="section_#pos#" class="sec1">#language.NorthLandingWharf#</td></tr>
<tr><td class="tentative" headers="type_#pos#" style="border-right: 1px solid ##cccccc;">#language.TentBook#</td><td headers="section_#pos#" class="sec2">#language.SouthJetty#</td></tr>
<tr><td class="confirmed" headers="type_#pos#" style="border-right: 1px solid ##cccccc;">#language.ConfBook#</td><td>&nbsp;</td></tr>
<!---tr><td style="border-right: 1px solid #cccccc;">&nbsp;</td><td class="njetty">North Jetty</td></tr>
<tr><td style="border-right: 1px solid #cccccc;">&nbsp;</td><td class="sjetty">South Jetty</td></tr--->
</table>
</cfoutput>