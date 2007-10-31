		  </td>
		 </tr>
		</table>
	</td>
</tr>
</table>
<!--BEGIN FOOTER-->
<table width="600" border="0" cellspacing="0" cellpadding="0">
<tr> 
	<td width="150"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="150" height="1" alt=""></td>
	<td width="450"> 
		<hr noshade size="1">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr valign="bottom"> 
			<td align="left" class="footertext" colspan="2">
				Mise &agrave; jour par <a href="http://www.tpsgc.gc.ca/pacific/egd/text/contact_us-f.html">TPSGC</a> <!--- This option is recommended. --->
			</td>
		</tr>
		<tr>
			<td align="left" class="footertext">
				<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,"\")>
				<cfset PageDir = listDeleteAt(cgi.CF_TEMPLATE_PATH, listLen(cgi.CF_TEMPLATE_PATH,"\"), "\")>
				<cfdirectory action="LIST" directory="#PageDir#" name="GetFile" filter="#PageFileName#">
				<cfif #GetFile.recordcount# is 1>Derni&egrave;re mise &agrave; jour&nbsp;:
				<cfoutput query="GetFile">
					#DateFormat(parseDateTime(GetFile.DateLastModified,"mm-dd-yyyy"), "yyyy-mm-dd")# 
					<!---#TimeFormat(parseDateTime(GetFile.DateLastModified, "h:mm tt"))#--->
				</cfoutput>
				</cfif>
			</td>
			<td align="right" class="footertext">
				<div> 
					<span lang="fr"><a href="http://www.tpsgc.gc.ca/text/generic/copyright-f.html">Avis Importants</a></span>
				</div>
			</td>
		</tr>
		</table>
	</td>
</tr>
<tr> 
    <td width="150"><img src="<cfoutput>#RootDir#</cfoutput>images/spacer.gif" width="1" height="10" alt=""></td>
</tr>
</table>
<!--END FOOTER-->
</body>
</html>