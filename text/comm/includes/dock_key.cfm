<cfoutput>
<table class="keytable" cellspacing="0" align="center" cellpadding="2">
<tr align="center"><td style="border-bottom: 1px solid ##cccccc;" colspan="2">#language.Key#</td></tr>
<tr align="center"><td id="type_#pos#" style="border-right: 1px solid ##cccccc; border-bottom: 1px solid##cccccc;" width="50%">#language.bookingtype#</td><td id="section_#pos#" style="border-bottom: 1px solid##cccccc;">#language.sec#</td></tr>
<tr><td headers="type_#pos#" class="pending" style="border-right: 1px solid ##cccccc;" width="50%">#language.PendBook#</td><td headers="section_#pos#" class="sec1">#language.Sec1#</td></tr>
<tr><td headers="type_#pos#" class="tentative" style="border-right: 1px solid ##cccccc;">#language.TentBook#</td><td headers="section_#pos#" class="sec2">#language.Sec2#</td></tr>
<tr><td headers="type_#pos#" class="confirmed" style="border-right: 1px solid ##cccccc;">#language.ConfBook#</td><td headers="section_#pos#" class="sec3">#language.Sec3#</td></tr>
</table>
</cfoutput>
