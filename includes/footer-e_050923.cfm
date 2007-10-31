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
				Maintained by <a href="<cfoutput>#RootDir#</cfoutput>text/contact_us-e.cfm">PWGSC</a> <!--- This option is recommended. --->
			</td>
		</tr>
		<tr valign="bottom">
			<td align="left" class="footertext">
				<cfset PageFileName = listlast(cgi.CF_TEMPLATE_PATH,"\")>
				<cfset PageDir = listDeleteAt(cgi.CF_TEMPLATE_PATH, listLen(cgi.CF_TEMPLATE_PATH,"\"), "\")>
				<cfdirectory action="LIST" directory="#PageDir#" name="GetFile" filter="#PageFileName#">
				<cfif #GetFile.recordcount# is 1>Last Updated:
				<cfoutput query="GetFile">
					#DateFormat(parseDateTime(GetFile.DateLastModified,"mm-dd-yyyy"), "yyyy-mm-dd")# 
					<!---#TimeFormat(parseDateTime(GetFile.DateLastModified, "h:mm tt"))#--->
				</cfoutput>
				</cfif>
			</td>
			<td align="right" class="footertext"> 
				<div> 
					<cfoutput>
					<span lang="en"><a href="http://www.pwgsc.gc.ca/text/generic/copyright-e.html">Important Notices</a></span>
					</cfoutput>
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

