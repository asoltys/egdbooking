<!-- ********END MAIN CONTENT TABLE******** -->
		</td>
	</tr>
</table>
<!-- ********START LARGE TABLE WITH SIDE NAV AND MAIN CONTENT******** -->
<!-- ********start footer******** -->
<br>
<table width="750" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="5%" valign="top"><cfoutput><img src="#ImageRootDir#images/spacer.gif" width="150" height="1" alt=""></cfoutput></td>
		<td width="95%" valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr valign="middle">
					<td colspan="2">
						<CFINCLUDE TEMPLATE="/pcsfo_root/ssi/maintain-e.cfm">
					</td>
				</tr>
				<tr> <!-- DATE CODE AUTO GENERATED FOR EACH PAGE - DO NOT MODIFY -->
					<td valign="top" width="50%" class="footerText">
					<!--- Last Updated: --->
					<!--- to insert date --->
					<!--- find full path and file name via cf variable --->
					<cfset page = CGI.CF_TEMPLATE_PATH>
					<!--- separate file name from dir info --->
					<cfset file = listLen(page,"\")>

					<CFSET PageFileName = listlast(cgi.CF_TEMPLATE_PATH,"\")>
					<CFSET PageDir = listDeleteAt(cgi.CF_TEMPLATE_PATH, listLen(cgi.CF_TEMPLATE_PATH,"\"), "\")>
					<CFDIRECTORY action="LIST" directory="#PageDir#" name="GetFile" filter="#PageFileName#">
					<CFIF #GetFile.recordcount# eq 1>Last Updated:
						<CFOUTPUT query="GetFile">
							#DateFormat(GetFile.DateLastModified,"mm/dd/yyyy")#
							#TimeFormat(GetFile.DateLastModified, "h:mm tt")#
						</CFOUTPUT>
					</CFIF>
					</td>
					<td align="right" valign="top" width="50%" class="footerText">
						<cfoutput><a href="#RootDir#pages/notices.cfm">Important Notices</a></cfoutput>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ****************end footer**************** -->
</body>
</html>