<CFQUERY NAME="ListPCSFO" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT CatID, Title, ExpireDate
	FROM DocCategory
	WHERE Com_Code = 'PCSFO'
	AND Status = 'Display'
	ORDER BY Title
</CFQUERY>
<CFQUERY NAME="ListMIDMGR" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT CatID, Title, ExpireDate
	FROM DocCategory
	WHERE Com_Code = 'MIDMGR'
	AND Status = 'Display'
	ORDER BY Title
</CFQUERY>
<CFQUERY NAME="ListSUSTAIN" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT CatID, Title, ExpireDate
	FROM DocCategory
	WHERE Com_Code = 'SUSTAIN'
	AND Status = 'Display'
	ORDER BY Title
</CFQUERY>
<CFQUERY NAME="ListYLEADER" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT CatID, Title, ExpireDate
	FROM DocCategory
	WHERE Com_Code = 'YLEADER'
	AND Status = 'Display'
	ORDER BY Title
</CFQUERY>
<CFQUERY NAME="ListYUKON" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT CatID, Title, ExpireDate
	FROM DocCategory
	WHERE Com_Code = 'YUKON'
	AND Status = 'Display'
	ORDER BY Title
</CFQUERY>
<CFQUERY NAME="ListOFF_LANG" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT CatID, Title, ExpireDate
	FROM DocCategory
	WHERE Com_Code = 'OFF_LANG'
	AND Status = 'Display'
	ORDER BY Title
</CFQUERY>
<CFQUERY NAME="GetCommits" DATASOURCE="pcsfo">
	SELECT 	Com_Code, Name, Dir_Params
	FROM	Commit_XRef
<!--- 		WHERE NAME NOT LIKE 'events' AND
		NAME NOT LIKE '%test%' --->
	WHERE Com_Code <> 'test' AND 
		Com_Code <> 'events' AND 
		Com_Code <> 'reglearn'
	ORDER BY Name
</CFQUERY>
<CFQUERY NAME="ListRegLearn" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT CatID, Title, ExpireDate
	FROM DocCategory
	WHERE Com_Code = 'reglearn'
	AND Status = 'Display'
	ORDER BY Title
</CFQUERY>
<cfquery name="ListNewDocs" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Docs.Title, Docs.SystemName,
		Docs.WNewEndDate, Docs.FileType,
		Commit_XRef.Dir_Params, 
		Commit_XRef.Name
	FROM Docs, Commit_XRef 
	WHERE Docs.Com_Code = Commit_XRef.Com_Code
	AND Docs.WNewEndDate >= #CreateODBCDate(Now())#
	AND Status = 'Display'
	ORDER BY Name, WNewEndDate
</cfquery>
<CFQUERY NAME="ListNPSW" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT CatID, Title, ExpireDate
	FROM DocCategory
	WHERE Com_Code = 'NPSW'
	AND Status = 'Display'
	ORDER BY Title
</CFQUERY>
<CFQUERY NAME="ListUseful" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT CatID, Title, ExpireDate
	FROM DocCategory
	WHERE Com_Code = 'reglearn'
	AND Title = 'Useful Tools and Links'
	ORDER BY Title
</CFQUERY>
<CFQUERY NAME="SurveysPCSFO" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Title, SurveyID, Status, Com_Code
	FROM Surveys
	WHERE Com_Code = 'PCSFO'
</CFQUERY>
<CFQUERY NAME="SurveysMIDMGR" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Title, SurveyID, Status, Com_Code
	FROM Surveys
	WHERE Com_Code = 'MIDMGR'
</CFQUERY>
<CFQUERY NAME="SurveysYLEADER" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Title, SurveyID, Status, Com_Code
	FROM Surveys
	WHERE Com_Code = 'YLEADER'
</CFQUERY>
<CFQUERY NAME="SurveysYUKON" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Title, SurveyID, Status, Com_Code
	FROM Surveys
	WHERE Com_Code = 'YUKON'
</CFQUERY>
<CFQUERY NAME="SurveysOFF_LANG" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Title, SurveyID, Status, Com_Code
	FROM Surveys
	WHERE Com_Code = 'OFF_LANG'
</CFQUERY>
<CFQUERY NAME="SurveysNPSW" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT Title, SurveyID, Status, Com_Code
	FROM Surveys
	WHERE Com_Code = 'NPSW'
</CFQUERY>

<!--- Variable to hold all the DIV ID's for JavaScript later on --->
<cfset DivIDs = "">

<!-- ********* Floating Layers ********* -->
<div id="calendarofevents" class="menuFloat">
	<table width="390" cellpadding="0" cellspacing="0"  border="0">
		<tr>
			<td>
				<div class="menuFloatTitle">
					Calendar of Events
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="menuFloatText">
					<a href="../../ver1_bubbles/app/event_list.cfm">Events and meeting from around the region</a>
				</div>
			</td>
		</tr>
	</table>
</div>
<cfset DivFoo = "calendarofevents">
<cfif DivIDs EQ "">
	<cfset DivIDs = "'#DivFoo#','','hide'">
<cfelse>
	<cfset DivIDs = DivIDs & ",'#DivFoo#','','hide'">
</cfif>
<!--- BEGIN PACIFICCOUNCIL BLOCK OF CODE --->
<cfset RemainingRecords = ListPCSFO.RecordCount>
<cfset LoopNumber = "1">

<cfloop condition="RemainingRecords GREATER THAN 0">
	<cfif LoopNumber GT 1>
		<cfset DivFoo = "pacificcouncil" & LoopNumber>
		<cfoutput><div id="#DivFoo#" class="menuFloat"></cfoutput>
			<table width="390" cellpadding="0" cellspacing="0"  border="0">
				<tr>
					<td colspan="2">
						<div class="menuFloatTitle">Pacific Federal Council</div>
					</td>
				</tr>
	<cfelse>
		<cfset DivFoo = "pacificcouncil">
		<cfoutput><div id="#DivFoo#" class="menuFloat"></cfoutput>
			<table width="390" cellpadding="0" cellspacing="0"  border="0">
				<tr>
					<td colspan="2">
						<div class="menuFloatTitle">Pacific Federal Council</div>
					</td>
				</tr>
				<tr>
					<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
					<td width="231">
						<div class="menuFloatText">
							<a href="../../ver1_bubbles/app/orgperson-list.cfm?Commit=PCSFO">Committee Members</a>
						</div>
					</td>
				</tr>
	</cfif>
	<cfset StartRow = ListPCSFO.RecordCount - RemainingRecords>
	<cfif LoopNumber EQ "1">
		<cfset LeftToOutput = "8">
	<cfelse>
		<cfset LeftToOutput = "9">
	</cfif>
	<cfoutput query="ListPCSFO">
		<cfif ListPCSFO.CurrentRow GT StartRow AND LeftToOutput GT 0>
			<cfif Trim(ListPCSFO.ExpireDate) EQ "">
				<cfset Variables.ShowCat = "Yes">
			<cfelse>
				<cfif DATECOMPARE(ListPCSFO.ExpireDate, DATEFORMAT(NOW())) GTE 0>
					<cfset Variables.ShowCat = "Yes">
				<cfelse>
					<cfset Variables.ShowCat = "No">
				</cfif>
			</cfif>
			<cfif Variables.ShowCat EQ "Yes">
				<tr>
					<td width="13">
						<div class="menuFloatBullet"><img src="../images/bullet.gif" width="13" height="12"></div>
					</td>
					<td width="231">
						<div class="menuFloatText">
							<a href="../../ver1_bubbles/app/doc_list.cfm?Commit=PCSFO&CatID=#ListPCSFO.CatID#">#TRIM(ListPCSFO.Title)#</a>
						</div>
					</td>
				</tr>
			</cfif>
			<cfset LeftToOutput = LeftToOutput - "1">
			<cfset LastOutputted = ListPCSFO.CurrentRow>
		</cfif>
	</cfoutput>
	
	<cfif ListPCSFO.RecordCount - LastOutputted GT "0">
				<tr>
					<td align="right" colspan="2">
						<div class="menuFloatText">
							<a href="javascript: MM_showHideLayers('pacificcouncil<cfoutput>#Evaluate(LoopNumber + 1)#</cfoutput>','','show')"><img src="<cfoutput>#WebHost#</cfoutput>/images/yellowarrow.gif">more...</a>
						</div>
					</td>
				</tr>
	<cfelse>
	<CFIF SurveysPCSFO.RecordCount GT 0>
	<tr>
		<td valign="top" colspan="2">
			<br><strong>Take a Survey</strong>
		</td>
	</tr>
	</CFIF>
	<CFOUTPUT query="SurveysPCSFO">
		<CFIF #TRIM(SurveysPCSFO.Status)# EQ "Display">
				<tr>
					<td valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
					<td valign="top">
						<A HREF="../../ver1_bubbles/app/survey.cfm?Commit=PCSFO&SurveyID=#SurveysPCSFO.SurveyID#">#SurveysPCSFO.Title#</A>
					</td>
				</tr>
		</CFIF>
	</CFOUTPUT>
	</cfif>
			</table>
		</div>
	<cfif LoopNumber EQ "1">
		<cfset RemainingRecords = RemainingRecords - "8">
	<cfelse>
		<cfset RemainingRecords = RemainingRecords - "9">
	</cfif>
	<cfset LoopNumber = LoopNumber + "1">
	<cfif DivIDs EQ "">
		<cfset DivIDs = "'#DivFoo#','','hide'">
	<cfelse>
		<cfset DivIDs = DivIDs & ",'#DivFoo#','','hide'">
	</cfif>
</cfloop>
<!--- END COMMITTEES BLOCK OF CODE --->
<!---
<div id="pacificcouncil" class="menuFloat">
	<table width="390" cellpadding="0" cellspacing="0"  border="0">
		<tr>
			<td colspan="2">
				<div class="menuFloatTitle">Pacific Council of Senior Federal Officials</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="../app/orgperson-list.cfm?Commit=PCSFO">Committee Members</a>
				</div>
			</td>
		</tr>
		<cfoutput query="ListPCSFO"> 
			<cfif Trim(ListPCSFO.ExpireDate) EQ "">
				<cfset Variables.ShowCat = "Yes">
			<cfelse>
				<cfif DATECOMPARE(ListPCSFO.ExpireDate, DATEFORMAT(NOW())) GTE 0>
					<cfset Variables.ShowCat = "Yes">
				<cfelse>
					<cfset Variables.ShowCat = "No">
				</cfif>
			</cfif>
			<cfif Variables.ShowCat EQ "Yes">
				<tr>
					<td width="13">
						<div class="menuFloatBullet"><img src="../images/bullet.gif" width="13" height="12"></div>
					</td>
					<td width="231">
						<div class="menuFloatText">
							<a href="../app/doc_list.cfm?Commit=PCSFO&CatID=#ListPCSFO.CatID#">#TRIM(ListPCSFO.Title)#</a>
						</div>
					</td>
				</tr>
			</cfif>
		</cfoutput>
	</table>
</div>
--->
<!--- BEGIN MANAGEMENT BLOCK OF CODE --->
<cfset RemainingRecords = ListMIDMGR.RecordCount>
<cfset LoopNumber = "1">

<cfloop condition="RemainingRecords GREATER THAN 0">
	<cfif LoopNumber GT 1>
		<cfset DivFoo = "management" & LoopNumber>
		<cfoutput><div id="#DivFoo#" class="menuFloat"></cfoutput>
			<table width="390" cellpadding="0" cellspacing="0"  border="0">
				<tr>
					<td colspan="2">
						<div class="menuFloatTitle">Pacific Management Community</div>
					</td>
				</tr>
	<cfelse>
		<cfset DivFoo = "management">
		<cfoutput><div id="#DivFoo#" class="menuFloat"></cfoutput>
			<table width="390" cellpadding="0" cellspacing="0"  border="0">
				<tr>
					<td colspan="2">
						<div class="menuFloatTitle">Pacific Management Community</div>
					</td>
				</tr>
				<tr>
					<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
					<td width="231">
						<div class="menuFloatText">
							<A HREF="../../ver1_bubbles/commits/mmc/docs/files/orgperson-list.cfm?Commit=MIDMGR">Council Members</A>
						</div>
					</td>
				</tr>
	</cfif>
	<cfset StartRow = ListMIDMGR.RecordCount - RemainingRecords>
	<cfif LoopNumber EQ "1">
		<cfset LeftToOutput = "8">
	<cfelse>
		<cfset LeftToOutput = "9">
	</cfif>
	<cfoutput query="ListMIDMGR">
		<cfif ListMIDMGR.CurrentRow GT StartRow AND LeftToOutput GT 0>
			<CFIF #TRIM(ListMIDMGR.ExpireDate)# EQ "">
				<CFSET Variables.ShowCat = "Yes">
			<CFELSE>
				<CFIF #DATECOMPARE(ListMIDMGR.ExpireDate, #DATEFORMAT(NOW())#)# GTE 0>
					<CFSET Variables.ShowCat = "Yes">
				<CFELSE>
					<CFSET Variables.ShowCat = "No">
				</CFIF>
			</CFIF>
			<CFIF Variables.ShowCat EQ "Yes">
				<tr>
					<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
					<td width="231">
						<div class="menuFloatText">
							<A HREF="../../ver1_bubbles/commits/mmc/docs/files/doc_list.cfm?Commit=MIDMGR&CatID=#ListMIDMGR.CatID#">#TRIM(ListMIDMGR.Title)#</A>
						</div>
					</td>
				</tr>
			</CFIF>
			<cfset LeftToOutput = LeftToOutput - "1">
			<cfset LastOutputted = ListMIDMGR.CurrentRow>
		</cfif>
	</cfoutput>
	
	<cfif ListMIDMGR.RecordCount - LastOutputted GT "0">
				<tr>
					<td align="right" colspan="2">
						<div class="menuFloatText">
							<a href="javascript: MM_showHideLayers('management<cfoutput>#Evaluate(LoopNumber + 1)#</cfoutput>','','show')"><img src="<cfoutput>#WebHost#</cfoutput>/images/yellowarrow.gif">more...</a>
						</div>
					</td>
				</tr>
	<cfelse>
	<CFIF SurveysMIDMGR.RecordCount GT 0>
	<tr>
		<td valign="top" colspan="2">
			<br><strong>Take a Survey</strong>
		</td>
	</tr>
	</CFIF>
	<CFOUTPUT query="SurveysMIDMGR">
		<CFIF #TRIM(SurveysMIDMGR.Status)# EQ "Display">
				<tr>
					<td valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
					<td valign="top">
						<A HREF="../../ver1_bubbles/app/survey.cfm?Commit=PCSFO&SurveyID=#SurveysMIDMGR.SurveyID#">#SurveysMIDMGR.Title#</A>
					</td>
				</tr>
		</CFIF>
	</CFOUTPUT>
	</cfif>
			</table>
		</div>
	<cfif LoopNumber EQ "1">
		<cfset RemainingRecords = RemainingRecords - "8">
	<cfelse>
		<cfset RemainingRecords = RemainingRecords - "9">
	</cfif>
	<cfset LoopNumber = LoopNumber + "1">
	<cfif DivIDs EQ "">
		<cfset DivIDs = "'#DivFoo#','','hide'">
	<cfelse>
		<cfset DivIDs = DivIDs & ",'#DivFoo#','','hide'">
	</cfif>
</cfloop>
<!--- END MANAGEMENT BLOCK OF CODE --->
<!---
<div id="management" class="menuFloat">
	<table width="390" cellpadding="0" cellspacing="0"  border="0">
		<tr>
			<td colspan="2">
				<div class="menuFloatTitle">Pacific Management Community</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<A HREF="../commits/mmc/docs/files/orgperson-list.cfm?Commit=MIDMGR">Council Members</A>
				</div>
			</td>
		</tr>
		<CFOUTPUT QUERY="ListMIDMGR">
			<CFIF #TRIM(ListMIDMGR.ExpireDate)# EQ "">
				<CFSET Variables.ShowCat = "Yes">
			<CFELSE>
				<CFIF #DATECOMPARE(ListMIDMGR.ExpireDate, #DATEFORMAT(NOW())#)# GTE 0>
					<CFSET Variables.ShowCat = "Yes">
				<CFELSE>
					<CFSET Variables.ShowCat = "No">
				</CFIF>
			</CFIF>
		
			<CFIF Variables.ShowCat EQ "Yes">
				<tr>
					<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
					<td width="231">
						<div class="menuFloatText">
							<A HREF="../commits/mmc/docs/files/doc_list.cfm?Commit=MIDMGR&CatID=#ListMIDMGR.CatID#">#TRIM(ListMIDMGR.Title)#</A>
						</div>
					</td>
				</tr>
			</CFIF>
		</CFOUTPUT>
	</table>
</div>
--->
<!--- BEGIN GOVERNEXX BLOCK OF CODE --->
<cfset RemainingRecords = ListYLEADER.RecordCount>
<cfset LoopNumber = "1">

<cfloop condition="RemainingRecords GREATER THAN 0">
	<cfif LoopNumber GT 1>
		<cfset DivFoo = "governexx" & LoopNumber>
		<cfoutput><div id="#DivFoo#" class="menuFloat"></cfoutput>
			<table width="390" cellpadding="0" cellspacing="0"  border="0">
				<tr>
					<td colspan="2">
						<div class="menuFloatTitle">Governexx</div>
					</td>
				</tr>
	<cfelse>
		<cfset DivFoo = "governexx">
		<cfoutput><div id="#DivFoo#" class="menuFloat"></cfoutput>
			<table width="390" cellpadding="0" cellspacing="0"  border="0">
				<tr>
					<td colspan="2">
						<div class="menuFloatTitle">Governexx</div>
					</td>
				</tr>
				<tr>
					<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
					<td width="231">
						<div class="menuFloatText">
							<A HREF="../../ver1_bubbles/app/orgperson-list.cfm?Commit=YLEADER">Committee Members</A>
						</div>
					</td>
				</tr>
	</cfif>
	<cfset StartRow = ListYLEADER.RecordCount - RemainingRecords>
	<cfif LoopNumber EQ "1">
		<cfset LeftToOutput = "8">
	<cfelse>
		<cfset LeftToOutput = "9">
	</cfif>
	<cfoutput query="ListYLEADER">
		<cfif ListYLEADER.CurrentRow GT StartRow AND LeftToOutput GT 0>
			<CFIF #TRIM(ListYLEADER.ExpireDate)# EQ "">
				<CFSET Variables.ShowCat = "Yes">
			<CFELSE>
				<CFIF #DATECOMPARE(ListYLEADER.ExpireDate, #DATEFORMAT(NOW())#)# GTE 0>
					<CFSET Variables.ShowCat = "Yes">
				<CFELSE>
					<CFSET Variables.ShowCat = "No">
				</CFIF>
			</CFIF>
		
			<CFIF Variables.ShowCat EQ "Yes">
				<tr>
					<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
					<td width="231">
						<div class="menuFloatText">
							<A HREF="../../ver1_bubbles/app/doc_list.cfm?Commit=YLEADER&CatID=#ListYLEADER.CatID#">#TRIM(ListYLEADER.Title)#</A>
						</div>
					</td>
				</tr>
			</CFIF>
			<cfset LeftToOutput = LeftToOutput - "1">
			<cfset LastOutputted = ListYLEADER.CurrentRow>
		</cfif>
	</cfoutput>
	
	<cfif ListYLEADER.RecordCount - LastOutputted GT "0">
				<tr>
					<td align="right" colspan="2">
						<div class="menuFloatText">
							<a href="javascript: MM_showHideLayers('governexx<cfoutput>#Evaluate(LoopNumber + 1)#</cfoutput>','','show')"><img src="<cfoutput>#WebHost#</cfoutput>/images/yellowarrow.gif">more...</a>
						</div>
					</td>
				</tr>
	<cfelse>
	<CFIF SurveysYLEADER.RecordCount GT 0>
	<tr>
		<td valign="top" colspan="2">
			<br><strong>Take a Survey</strong>
		</td>
	</tr>
	</CFIF>
	<CFOUTPUT query="SurveysYLEADER">
		<CFIF #TRIM(SurveysYLEADER.Status)# EQ "Display">
				<tr>
					<td valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
					<td valign="top">
						<A HREF="../../ver1_bubbles/app/survey.cfm?Commit=PCSFO&SurveyID=#SurveysYLEADER.SurveyID#">#SurveysYLEADER.Title#</A>
					</td>
				</tr>
		</CFIF>
	</CFOUTPUT>
	</cfif>
			</table>
		</div>
	<cfif LoopNumber EQ "1">
		<cfset RemainingRecords = RemainingRecords - "8">
	<cfelse>
		<cfset RemainingRecords = RemainingRecords - "9">
	</cfif>
	<cfset LoopNumber = LoopNumber + "1">
	<cfif DivIDs EQ "">
		<cfset DivIDs = "'#DivFoo#','','hide'">
	<cfelse>
		<cfset DivIDs = DivIDs & ",'#DivFoo#','','hide'">
	</cfif>
</cfloop>
<!--- END GOVERNEXX BLOCK OF CODE --->
<!---
<div id="governexx" class="menuFloat">
	<table width="390" cellpadding="0" cellspacing="0"  border="0">
		<tr>
			<td colspan="2">
				<div class="menuFloatTitle">Governexx</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<A HREF="../app/orgperson-list.cfm?Commit=YLEADER">Committee Members</A>
				</div>
			</td>
		</tr>
		<CFOUTPUT QUERY="ListYLEADER">
			<CFIF #TRIM(ListYLEADER.ExpireDate)# EQ "">
				<CFSET Variables.ShowCat = "Yes">
			<CFELSE>
				<CFIF #DATECOMPARE(ListYLEADER.ExpireDate, #DATEFORMAT(NOW())#)# GTE 0>
					<CFSET Variables.ShowCat = "Yes">
				<CFELSE>
					<CFSET Variables.ShowCat = "No">
				</CFIF>
			</CFIF>
		
			<CFIF Variables.ShowCat EQ "Yes">
				<tr>
					<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
					<td width="231">
						<div class="menuFloatText">
							<A HREF="../app/doc_list.cfm?Commit=YLEADER&CatID=#ListYLEADER.CatID#">#TRIM(ListYLEADER.Title)#</A>
						</div>
					</td>
				</tr>
			</CFIF>
		</CFOUTPUT>
	</table>
</div>
--->
<!--- BEGIN YUKON BLOCK OF CODE --->
<cfset RemainingRecords = ListYLEADER.RecordCount>
<cfset LoopNumber = "1">

<cfloop condition="RemainingRecords GREATER THAN 0">
	<cfif LoopNumber GT 1>
		<cfset DivFoo = "yukon" & LoopNumber>
		<cfoutput><div id="#DivFoo#" class="menuFloat"></cfoutput>
			<table width="390" cellpadding="0" cellspacing="0"  border="0">
				<tr>
					<td colspan="2">
						<div class="menuFloatTitle">Yukon Federal Community</div>
					</td>
				</tr>
	<cfelse>
		<cfset DivFoo = "yukon">
		<cfoutput><div id="#DivFoo#" class="menuFloat"></cfoutput>
			<table width="390" cellpadding="0" cellspacing="0"  border="0">
				<tr>
					<td colspan="2">
						<div class="menuFloatTitle">Yukon Federal Community</div>
					</td>
				</tr>
				<tr>
					<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
					<td width="231">
						<div class="menuFloatText">
							<A HREF="../../ver1_bubbles/app/orgperson-list.cfm?Commit=YUKON">Committee Members</A>
						</div>
					</td>
				</tr>
	</cfif>
	<cfset StartRow = ListYUKON.RecordCount - RemainingRecords>
	<cfif LoopNumber EQ "1">
		<cfset LeftToOutput = "8">
	<cfelse>
		<cfset LeftToOutput = "9">
	</cfif>
	<cfoutput query="ListYUKON">
		<cfif ListYLEADER.CurrentRow GT StartRow AND LeftToOutput GT 0>
			<CFIF #TRIM(ListYUKON.ExpireDate)# EQ "">
				<CFSET Variables.ShowCat = "Yes">
			<CFELSE>
				<CFIF #DATECOMPARE(ListYUKON.ExpireDate, #DATEFORMAT(NOW())#)# GTE 0>
					<CFSET Variables.ShowCat = "Yes">
				<CFELSE>
					<CFSET Variables.ShowCat = "No">
				</CFIF>
			</CFIF>
		
			<CFIF Variables.ShowCat EQ "Yes">
				<tr>
					<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
					<td width="231">
						<div class="menuFloatText">
							<A HREF="../../ver1_bubbles/app/doc_list.cfm?Commit=YUKON&CatID=#ListYUKON.CatID#">#TRIM(ListYUKON.Title)#</A>
						</div>
					</td>
				</tr>
			</CFIF>
			<cfset LeftToOutput = LeftToOutput - "1">
			<cfset LastOutputted = ListYUKON.CurrentRow>
		</cfif>
	</cfoutput>
	
	<cfif ListYUKON.RecordCount - LastOutputted GT "0">
				<tr>
					<td align="right" colspan="2">
						<div class="menuFloatText">
							<a href="javascript: MM_showHideLayers('yukon<cfoutput>#Evaluate(LoopNumber + 1)#</cfoutput>','','show')"><img src="<cfoutput>#WebHost#</cfoutput>/images/yellowarrow.gif">more...</a>
						</div>
					</td>
				</tr>
	<cfelse>
	<CFIF SurveysYUKON.RecordCount GT 0>
	<tr>
		<td valign="top" colspan="2">
			<br><strong>Take a Survey</strong>
		</td>
	</tr>
	</CFIF>
	<CFOUTPUT query="SurveysYUKON">
		<CFIF #TRIM(SurveysYUKON.Status)# EQ "Display">
				<tr>
					<td valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
					<td valign="top">
						<A HREF="../../ver1_bubbles/app/survey.cfm?Commit=PCSFO&SurveyID=#SurveysYUKON.SurveyID#">#SurveysYUKON.Title#</A>
					</td>
				</tr>
		</CFIF>
	</CFOUTPUT>
	</cfif>
			</table>
		</div>
	<cfif LoopNumber EQ "1">
		<cfset RemainingRecords = RemainingRecords - "8">
	<cfelse>
		<cfset RemainingRecords = RemainingRecords - "9">
	</cfif>
	<cfset LoopNumber = LoopNumber + "1">
	<cfif DivIDs EQ "">
		<cfset DivIDs = "'#DivFoo#','','hide'">
	<cfelse>
		<cfset DivIDs = DivIDs & ",'#DivFoo#','','hide'">
	</cfif>
</cfloop>
<!--- END YUKON BLOCK OF CODE --->

<!--- BEGIN OFF_LANG BLOCK OF CODE --->
<cfset RemainingRecords = ListOFF_LANG.RecordCount>
<cfset LoopNumber = "1">

<cfloop condition="RemainingRecords GREATER THAN 0">
	<cfif LoopNumber GT 1>
		<cfset DivFoo = "OFF_LANG" & LoopNumber>
		<cfoutput><div id="#DivFoo#" class="menuFloat"></cfoutput>
			<table width="390" cellpadding="0" cellspacing="0"  border="0">
				<tr>
					<td colspan="2">
						<div class="menuFloatTitle">PFC Official Languages Committee </div>
					</td>
				</tr>
	<cfelse>
		<cfset DivFoo = "OFF_LANG">
		<cfoutput><div id="#DivFoo#" class="menuFloat"></cfoutput>
			<table width="390" cellpadding="0" cellspacing="0"  border="0">
				<tr>
					<td colspan="2">
						<div class="menuFloatTitle">PFC Official Languages Committee</div>
					</td>
				</tr>
				<tr>
					<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
					<td width="231">
						<div class="menuFloatText">
							<A HREF="../../ver1_bubbles/app/orgperson-list.cfm?Commit=OFF_LANG">Committee Members</A>
						</div>
					</td>
				</tr>
	</cfif>
	<cfset StartRow = ListOFF_LANG.RecordCount - RemainingRecords>
	<cfif LoopNumber EQ "1">
		<cfset LeftToOutput = "8">
	<cfelse>
		<cfset LeftToOutput = "9">
	</cfif>
	<cfoutput query="ListOFF_LANG">
		<cfif ListOFF_LANG.CurrentRow GT StartRow AND LeftToOutput GT 0>
			<CFIF #TRIM(ListOFF_LANG.ExpireDate)# EQ "">
				<CFSET Variables.ShowCat = "Yes">
			<CFELSE>
				<CFIF #DATECOMPARE(ListOFF_LANG.ExpireDate, #DATEFORMAT(NOW())#)# GTE 0>
					<CFSET Variables.ShowCat = "Yes">
				<CFELSE>
					<CFSET Variables.ShowCat = "No">
				</CFIF>
			</CFIF>
		
			<CFIF Variables.ShowCat EQ "Yes">
				<tr>
					<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
					<td width="231">
						<div class="menuFloatText">
							<A HREF="../../ver1_bubbles/app/doc_list.cfm?Commit=OFF_LANG&CatID=#ListOFF_LANG.CatID#">#TRIM(ListOFF_LANG.Title)#</A>
						</div>
					</td>
				</tr>
			</CFIF>
			<cfset LeftToOutput = LeftToOutput - "1">
			<cfset LastOutputted = ListOFF_LANG.CurrentRow>
		</cfif>
	</cfoutput>
	
	<cfif ListOFF_LANG.RecordCount - LastOutputted GT "0">
				<tr>
					<td align="right" colspan="2">
						<div class="menuFloatText">
							<a href="javascript: MM_showHideLayers('OFF_LANG<cfoutput>#Evaluate(LoopNumber + 1)#</cfoutput>','','show')"><img src="<cfoutput>#WebHost#</cfoutput>/images/yellowarrow.gif">more...</a>
						</div>
					</td>
				</tr>
	<cfelse>
	<CFIF SurveysOFF_LANG.RecordCount GT 0>
	<tr>
		<td valign="top" colspan="2">
			<br><strong>Take a Survey</strong>
		</td>
	</tr>
	</CFIF>
	<CFOUTPUT query="SurveysOFF_LANG">
		<CFIF #TRIM(SurveysOFF_LANG.Status)# EQ "Display">
				<tr>
					<td valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
					<td valign="top">
						<A HREF="../../ver1_bubbles/app/survey.cfm?Commit=PCSFO&SurveyID=#SurveysOFF_LANG.SurveyID#">#SurveysOFF_LANG.Title#</A>
					</td>
				</tr>
		</CFIF>
	</CFOUTPUT>
	</cfif>
			</table>
		</div>
	<cfif LoopNumber EQ "1">
		<cfset RemainingRecords = RemainingRecords - "8">
	<cfelse>
		<cfset RemainingRecords = RemainingRecords - "9">
	</cfif>
	<cfset LoopNumber = LoopNumber + "1">
	<cfif DivIDs EQ "">
		<cfset DivIDs = "'#DivFoo#','','hide'">
	<cfelse>
		<cfset DivIDs = DivIDs & ",'#DivFoo#','','hide'">
	</cfif>
</cfloop>
<!--- END OFF_LANG BLOCK OF CODE --->


<!---
<div id="yukon" class="menuFloat">
	<table width="390" cellpadding="0" cellspacing="0"  border="0">
		<tr>
			<td colspan="2">
				<div class="menuFloatTitle">Yukon Federal Community</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<A HREF="../app/orgperson-list.cfm?Commit=YUKON">Committee Members</A>
				</div>
			</td>
		</tr>
		<CFOUTPUT QUERY="ListYUKON">
			<CFIF #TRIM(ListPCSFO.ExpireDate)# EQ "">
				<CFSET Variables.ShowCat = "Yes">
			<CFELSE>
				<CFIF #DATECOMPARE(ListYUKON.ExpireDate, #DATEFORMAT(NOW())#)# GTE 0>
					<CFSET Variables.ShowCat = "Yes">
				<CFELSE>
					<CFSET Variables.ShowCat = "No">
				</CFIF>
			</CFIF>
		
			<CFIF Variables.ShowCat EQ "Yes">
				<tr>
					<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
					<td width="231">
						<div class="menuFloatText">
							<A HREF="../app/doc_list.cfm?Commit=YUKON&CatID=#ListYUKON.CatID#">#TRIM(ListYUKON.Title)#</A>
						</div>
					</td>
				</tr>
			</CFIF>
		</CFOUTPUT>
	</table>
</div>
--->
<!--- BEGIN COMMITTEES BLOCK OF CODE --->
<cfset RemainingRecords = GetCommits.RecordCount>
<cfset LoopNumber = "1">

<cfloop condition="RemainingRecords GREATER THAN 0">
	<cfif LoopNumber GT 1>
		<cfset DivFoo = "committees" & LoopNumber>
		<cfoutput><div id="#DivFoo#" class="menuFloat"></cfoutput>
			<table width="390" cellpadding="0" cellspacing="0"  border="0">
				<tr>
					<td colspan="2">
						<div class="menuFloatTitle">Committees</div>
					</td>
				</tr>
	<cfelse>
		<cfset DivFoo = "committees">
		<cfoutput><div id="#DivFoo#" class="menuFloat"></cfoutput>
			<table width="390" cellpadding="0" cellspacing="0"  border="0">
				<tr>
					<td colspan="2">
						<div class="menuFloatTitle">Committees</div>
					</td>
				</tr>
				<tr>
					<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
					<td width="231">
						<div class="menuFloatText">
							<A HREF="../../ver1_bubbles/commits/interdepartmental.cfm">Interdepartmental Committees - Pacific Region</A>
						</div>
					</td>
				</tr>
		<!--- added new committee link for Joint Alternate Site --->
				<tr>
					<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
					<td width="231">
						<div class="menuFloatText">
							<A HREF="http://spectrum.ic.gc.ca/urgent/pacific/jas">Joint Alternate Site</A>
						</div>
					</td>
				</tr>
	</cfif>
	<cfset StartRow = GetCommits.RecordCount - RemainingRecords>
	<cfif LoopNumber EQ "1">
		<cfset LeftToOutput = "7">
	<cfelse>
		<cfset LeftToOutput = "9">
	</cfif>
	<cfoutput query="GetCommits">
		<cfif GetCommits.CurrentRow GT StartRow AND LeftToOutput GT 0>
				<tr>
					<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
					<td width="231">
						<div class="menuFloatText">
							<A HREF="../../ver1_bubbles/app/commit.cfm?Commit=#GetCommits.Com_Code#">#TRIM(GetCommits.Name)#</A>
						</div>
					</td>
				</tr>
			<cfset LeftToOutput = LeftToOutput - "1">
			<cfset LastOutputted = GetCommits.CurrentRow>
		</cfif>
	</cfoutput>
	
	<cfif GetCommits.RecordCount - LastOutputted GT "0">
				<tr>
					<td align="right" colspan="2">
						<div class="menuFloatText">
							<a href="javascript: MM_showHideLayers('committees<cfoutput>#Evaluate(LoopNumber + 1)#</cfoutput>','','show')"><img src="<cfoutput>#WebHost#</cfoutput>/images/yellowarrow.gif">more...</a>
						</div>
					</td>
				</tr>
	</cfif>
			</table>
		</div>
	<cfif LoopNumber EQ "1">
		<cfset RemainingRecords = RemainingRecords - "7">
	<cfelse>
		<cfset RemainingRecords = RemainingRecords - "9">
	</cfif>
	<cfset LoopNumber = LoopNumber + "1">
	<cfif DivIDs EQ "">
		<cfset DivIDs = "'#DivFoo#','','hide'">
	<cfelse>
		<cfset DivIDs = DivIDs & ",'#DivFoo#','','hide'">
	</cfif>
</cfloop>
<!--- END COMMITTEES BLOCK OF CODE --->
<!---
<div id="committees" class="menuFloat">
	<table width="390" cellpadding="0" cellspacing="0"  border="0">
		<tr>
			<td colspan="2">
				<div class="menuFloatTitle">Committees</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<A HREF="../commits/interdepartmental.cfm">Interdepartmental Committees - Pacific Region</A>
				</div>
			</td>
		</tr>
<!--- added new committee link for Joint Alternate Site --->
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<A HREF="http://spectrum.ic.gc.ca/urgent/pacific/jas">Joint Alternate Site</A>
				</div>
			</td>
		</tr>
		<CFOUTPUT QUERY="GetCommits">
			<tr>
				<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
				<td width="231">
					<div class="menuFloatText">
						<A HREF="../../ver1_bubbles/app/commit.cfm?Commit=#GetCommits.Com_Code#">#TRIM(GetCommits.Name)#</A>
					</div>
				</td>
			</tr>
		</CFOUTPUT>
	</table>
</div>
--->
<div id="horizontal" class="menuFloat">
	<table width="390" cellpadding="0" cellspacing="0"  border="0">
		<tr>
			<td colspan="2">
				<div class="menuFloatTitle">Horizontal Initiatives</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.climatechange.gc.ca/">Climate Change Action Fund</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.city.vancouver.bc.ca/commsvcs/planning/dtes/dtehome.htm">Downtown Eastside Revitalization Program - Vancouver Agreement</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.fraserbasin.bc.ca/">Fraser Basin Council</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.pyr.ec.gc.ca/georgiabasin/">Georgia Basin</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://publiservice.pwgsc.gc.ca/publiservice/text/gol-e.html">Government On-line</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.gvrd.bc.ca/homelessness/">Homelessness</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.jctc.gc.ca">Joint Career Transition Committee</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.pac.dfo-mpo.gc.ca/oceans/fco/">Pacific Marine &amp; Coastal Ecosystems</a>
				</div>
			</td>
		</tr>
		<tr>
			<td align="right" colspan="2">
				<div class="menuFloatText">
					<a href="javascript: MM_showHideLayers('horizontal2','','show')"><img src="<cfoutput>#WebHost#</cfoutput>/images/yellowarrow.gif">more...</a>
				</div>
			</td>
		</tr>
	</table>
</div>
<cfset DivFoo = "horizontal">
<cfif DivIDs EQ "">
	<cfset DivIDs = "'#DivFoo#','','hide'">
<cfelse>
	<cfset DivIDs = DivIDs & ",'#DivFoo#','','hide'">
</cfif>
<div id="horizontal2" class="menuFloat">
	<table width="390" cellpadding="0" cellspacing="0"  border="0">
		<tr>
			<td colspan="2">
				<div class="menuFloatTitle">Horizontal Initiatives</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.rural.gc.ca/team/bc/bchome_e.phtml">Rural Partnerships</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.sdinfo.gc.ca/">Sustainable Development</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.inac.gc.ca/bc/index_e.html">Treaty Negotiations</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://pfc.gc.ca/app/commit.cfm?Commit=URBAN">Urban Aboriginal</a>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<div class="menuFloatText">&nbsp;</div>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<div class="menuFloatTitle">Regional Learning</div>
			</td>
		</tr>
<!---  <CFQUERY NAME="ListRegLearn" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT CatID, DocID, Title, Description, 
			ExpireDate, SystemName, MeetDate
	FROM Docs
	WHERE Com_Code = 'reglearn' 
		AND Status = 'Display'
	ORDER BY Title
</CFQUERY>

<CFQUERY NAME="GetCommit" DATASOURCE=#DSN#>
	SELECT NAME, Return_URL, Dir_Params
	FROM Commit_XRef
	WHERE Com_Code = 'reglearn'
</CFQUERY> --->

	<CFOUTPUT QUERY="ListRegLearn">
		<CFIF #TRIM(ListRegLearn.ExpireDate)# EQ "">
			<CFSET Variables.ShowCat = "Yes">
		<CFELSE>
			<CFIF #DATECOMPARE(ListRegLearn.ExpireDate, #DATEFORMAT(NOW())#)# GTE 0>
				<CFSET Variables.ShowCat = "Yes">
			<CFELSE>
				<CFSET Variables.ShowCat = "No">
			</CFIF>
		</CFIF>
	
		<CFIF Variables.ShowCat EQ "Yes">
			<tr>
				<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
				<td width="231">
					<div class="menuFloatText">
						<A HREF="../../ver1_bubbles/app/doc_list.cfm?Commit=reglearn&CatID=#ListRegLearn.CatID#" target="new">#TRIM(ListRegLearn.Title)#</A>
					</div>
<!--- 	  <td colspan="2" class="line"><font face="Arial" size="1"><A HREF="#TRIM(WebHost)#/commits/#TRIM(GetCommit.Dir_Params)#/docs/#TRIM(ListRegLearn.SystemName)#" target="new"><b>#ListRegLearn.Title#</b></A></font> 
      </td> --->
				</td>
			</tr>
		</CFIF>
	</CFOUTPUT>
		<tr>
			<td colspan="2">
				<div class="menuFloatText">&nbsp;</div>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<div class="menuFloatTitle"><cfoutput><A HREF="../../ver1_bubbles/app/doc_list.cfm?Commit=reglearn&CatID=#ListUseful.CatID#" target="new">Useful Tools and Links</a></cfoutput></div>
			</td>
		</tr>
	</table>
</div>
<cfset DivFoo = "horizontal2">
<cfif DivIDs EQ "">
	<cfset DivIDs = "'#DivFoo#','','hide'">
<cfelse>
	<cfset DivIDs = DivIDs & ",'#DivFoo#','','hide'">
</cfif>

<div id="communities" class="menuFloat">
	
  <table width="390" cellpadding="0" cellspacing="0"  border="0">
    <tr> 
      <td colspan="2"> <div class="menuFloatTitle">Service Delivery Communities</div></td>
    </tr>
    <tr>
      <td valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
      <td><a href="../../ver1_bubbles/pages/communities/about.cfm">About This Project</a></td>
    </tr>
    <tr> 
      <td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
      <td width="231"> <div class="menuFloatText"> <a href="../../ver1_bubbles/pages/communities/sd_communities.cfm">Pacific 
          Region Service Delivery Communities of Practice</a> </div></td>
    </tr>
    <tr> 
      <td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
      <td width="231"> <div class="menuFloatText"> <a href="../../ver1_bubbles/pages/communities/outreach.cfm">Outreach</a> 
        </div></td>
    </tr>
    <tr> 
      <td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
      <td width="231"> <div class="menuFloatText"> <a href="../../ver1_bubbles/pages/communities/cities.cfm">Cities</a> 
        </div></td>
    </tr>
    <tr> 
      <td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
      <td width="231"> <div class="menuFloatText"> <a href="../../ver1_bubbles/pages/communities/aboriginals.cfm">Aboriginals</a> 
        </div></td>
    </tr>
    <tr> 
      <td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
      <td width="231"> <div class="menuFloatText"> <a href="../../ver1_bubbles/pages/communities/voluntary.cfm">Voluntary 
          Sector</a> </div></td>
    </tr>
  </table>
</div>
<cfset DivFoo = "communities">
<cfif DivIDs EQ "">
	<cfset DivIDs = "'#DivFoo#','','hide'">
<cfelse>
	<cfset DivIDs = DivIDs & ",'#DivFoo#','','hide'">
</cfif>

<div id="representativeness" class="menuFloat">
	<table width="390" cellpadding="0" cellspacing="0"  border="0">
		<tr>
			<td colspan="2">
				<div class="menuFloatTitle">Diversity</div>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<p>The Federal Council is committed to a public service that welcomes 
				difference and diversity, is inclusive and responsive to change, and 
				sustainable through renewal and learning.</p>
				<p>Visit this page to get your Representative Workforce Manager's Toolkit!</p>
			</td>
		</tr>
	</table>
</div>
<cfset DivFoo = "representativeness">
<cfif DivIDs EQ "">
	<cfset DivIDs = "'#DivFoo#','','hide'">
<cfelse>
	<cfset DivIDs = DivIDs & ",'#DivFoo#','','hide'">
</cfif>

<!--- BEGIN SUSTAIN BLOCK OF CODE --->
<cfset RemainingRecords = ListSUSTAIN.RecordCount>
<cfset LoopNumber = "1">
<cfloop condition="RemainingRecords GREATER THAN 0">
	<cfset DivFoo = "sustain">
	<cfoutput><div id="#DivFoo#" class="menuFloat"></cfoutput>
		<table width="390" cellpadding="0" cellspacing="0"  border="0">
			<tr>
				<td colspan="2">
					<div class="menuFloatTitle">Sustainable Development</div>
				</td>
			</tr>
	<cfset StartRow = ListSUSTAIN.RecordCount - RemainingRecords>
	<cfif LoopNumber EQ "1">
		<cfset LeftToOutput = "8">
	<cfelse>
		<cfset LeftToOutput = "9">
	</cfif>
	<cfoutput query="ListSUSTAIN">
		<cfif ListSUSTAIN.CurrentRow GT StartRow AND LeftToOutput GT 0>
			<CFIF #TRIM(ListSUSTAIN.ExpireDate)# EQ "">
				<CFSET Variables.ShowCat = "Yes">
			<CFELSE>
				<CFIF #DATECOMPARE(ListSUSTAIN.ExpireDate, #DATEFORMAT(NOW())#)# GTE 0>
					<CFSET Variables.ShowCat = "Yes">
				<CFELSE>
					<CFSET Variables.ShowCat = "No">
				</CFIF>
			</CFIF>
		
			<CFIF Variables.ShowCat EQ "Yes">
				<tr>
					<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
					<td width="231">
						<div class="menuFloatText">
							<A HREF="../../ver1_bubbles/app/doc_list.cfm?Commit=SUSTAIN&CatID=#ListSUSTAIN.CatID#">#TRIM(ListSUSTAIN.Title)#</A>
						</div>
					</td>
				</tr>
			</CFIF>
			<cfset LeftToOutput = LeftToOutput - "1">
			<cfset LastOutputted = ListSUSTAIN.CurrentRow>
		</cfif>
	</cfoutput>
	
	<cfif ListSUSTAIN.RecordCount - LastOutputted GT "0">
				<tr>
					<td align="right" colspan="2">
						<div class="menuFloatText">
							<a href="javascript: MM_showHideLayers('SUSTAIN<cfoutput>#Evaluate(LoopNumber + 1)#</cfoutput>','','show')"><img src="<cfoutput>#WebHost#</cfoutput>/images/yellowarrow.gif">more...</a>
						</div>
					</td>
				</tr>
	</cfif>
			</table>
		</div>
	<cfif LoopNumber EQ "1">
		<cfset RemainingRecords = RemainingRecords - "8">
	<cfelse>
		<cfset RemainingRecords = RemainingRecords - "9">
	</cfif>
	<cfset LoopNumber = LoopNumber + "1">
	<cfif DivIDs EQ "">
		<cfset DivIDs = "'#DivFoo#','','hide'">
	<cfelse>
		<cfset DivIDs = DivIDs & ",'#DivFoo#','','hide'">
	</cfif>
</cfloop>
<!--- END SUSTAIN BLOCK OF CODE --->

<div id="locallyshared" class="menuFloat">
	<table width="390" cellpadding="0" cellspacing="0"  border="0">
		<tr>
			<td>
				<div class="menuFloatTitle">Locally Shared Services</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="menuFloatText">
					<a href="../../ver1_bubbles/app/res_list.cfm">Shared board rooms from around the region.</a>
				</div>
			</td>
		</tr>
	</table>
</div>
<cfset DivFoo = "locallyshared">
<cfif DivIDs EQ "">
	<cfset DivIDs = "'#DivFoo#','','hide'">
<cfelse>
	<cfset DivIDs = DivIDs & ",'#DivFoo#','','hide'">
</cfif>
<div id="virtuallearning" class="menuFloat">
	<table width="390" cellpadding="0" cellspacing="0"  border="0">
		<tr>
			<td>
				<div class="menuFloatTitle">Virtual Learning Centre</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="menuFloatText">
					<a href="../../ver1_bubbles/pages/virtual.cfm">Links and information on continuous learning, self development, training and career planning.</a>
				</div>
			</td>
		</tr>
	</table>
</div>
<cfset DivFoo = "virtuallearning">
<cfif DivIDs EQ "">
	<cfset DivIDs = "'#DivFoo#','','hide'">
<cfelse>
	<cfset DivIDs = DivIDs & ",'#DivFoo#','','hide'">
</cfif>
<div id="pfcproducts" class="menuFloat">
	<table width="390" cellpadding="0" cellspacing="0"  border="0">
		<tr>
			<td>
				<div class="menuFloatTitle">PFC Products</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="menuFloatText">
					<a href="../../ver1_bubbles/app/olc_product_list.cfm">Various products that the Pacific Federal Council has available.</a>
				</div>
			</td>
		</tr>
	</table>
</div>
<cfset DivFoo = "pfcproducts">
<cfif DivIDs EQ "">
	<cfset DivIDs = "'#DivFoo#','','hide'">
<cfelse>
	<cfset DivIDs = DivIDs & ",'#DivFoo#','','hide'">
</cfif>
<!--- BEGIN NATIONAL BLOCK OF CODE --->
<cfset RemainingRecords = ListNPSW.RecordCount>
<cfset LoopNumber = "1">

<cfloop condition="RemainingRecords GREATER THAN 0">
	<cfif LoopNumber GT 1>
		<cfset DivFoo = "national" & LoopNumber>
		<cfoutput><div id="#DivFoo#" class="menuFloat"></cfoutput>
			<table width="390" cellpadding="0" cellspacing="0"  border="0">
				<tr>
					<td colspan="2">
						<div class="menuFloatTitle">National Public Service Week 2003</div>
					</td>
				</tr>
	<cfelse>
		<cfset DivFoo = "national">
		<cfoutput><div id="#DivFoo#" class="menuFloat"></cfoutput>
			<table width="390" cellpadding="0" cellspacing="0"  border="0">
				<tr>
					<td colspan="2">
						<div class="menuFloatTitle" align="Center">National Public<BR>Service Week 2005</div>
					</td>
				</tr>
				<tr>
					<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
					<td width="231">
						<div class="menuFloatText">
							<A HREF="../../ver1_bubbles/app/orgperson-list.cfm?Commit=NPSW">Committee Members</A>
						</div>
					</td>
				</tr>
	</cfif>
	<cfset StartRow = ListNPSW.RecordCount - RemainingRecords>
	<cfif LoopNumber EQ "1">
		<cfset LeftToOutput = "8">
	<cfelse>
		<cfset LeftToOutput = "9">
	</cfif>
	<cfoutput query="ListNPSW">
		<cfif ListNPSW.CurrentRow GT StartRow AND LeftToOutput GT 0>
			<CFIF #TRIM(ListNPSW.ExpireDate)# EQ "">
				<CFSET Variables.ShowCat = "Yes">
			<CFELSE>
				<CFIF #DATECOMPARE(ListNPSW.ExpireDate, #DATEFORMAT(NOW())#)# GTE 0>
					<CFSET Variables.ShowCat = "Yes">
				<CFELSE>
					<CFSET Variables.ShowCat = "No">
				</CFIF>
			</CFIF>
		
			<CFIF Variables.ShowCat EQ "Yes">
				<tr>
					<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
					<td width="231">
						<div class="menuFloatText">
							<A HREF="../../ver1_bubbles/app/doc_list.cfm?Commit=NPSW&CatID=#ListNPSW.CatID#">#TRIM(ListNPSW.Title)#</A>
						</div>
					</td>
				</tr>
			</CFIF>
			<cfset LeftToOutput = LeftToOutput - "1">
			<cfset LastOutputted = ListNPSW.CurrentRow>
		</cfif>
	</cfoutput>
	
	<cfif ListNPSW.RecordCount - LastOutputted GT "0">
				<tr>
					<td align="right" colspan="2">
						<div class="menuFloatText">
							<a href="javascript: MM_showHideLayers('national<cfoutput>#Evaluate(LoopNumber + 1)#</cfoutput>','','show')"><img src="<cfoutput>#WebHost#</cfoutput>/images/yellowarrow.gif">more...</a>
						</div>
					</td>
				</tr>
	</cfif>
			</table>
		</div>
	<cfif LoopNumber EQ "1">
		<cfset RemainingRecords = RemainingRecords - "8">
	<cfelse>
		<cfset RemainingRecords = RemainingRecords - "9">
	</cfif>
	<cfset LoopNumber = LoopNumber + "1">
	<cfif DivIDs EQ "">
		<cfset DivIDs = "'#DivFoo#','','hide'">
	<cfelse>
		<cfset DivIDs = DivIDs & ",'#DivFoo#','','hide'">
	</cfif>
</cfloop>
<!--- END NATIONAL BLOCK OF CODE --->
<!---
<div id="national" class="menuFloat">
	<table width="390" cellpadding="0" cellspacing="0"  border="0">
		<tr>
			<td colspan="2">
				<div class="menuFloatTitle">National Public Service Week 2003</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<A HREF="../app/orgperson-list.cfm?Commit=NPSW">Committee Members</A>
				</div>
			</td>
		</tr>
		<CFOUTPUT QUERY="ListNPSW">
			<CFIF #TRIM(ListNPSW.ExpireDate)# EQ "">
				<CFSET Variables.ShowCat = "Yes">
			<CFELSE>
				<CFIF #DATECOMPARE(ListNPSW.ExpireDate, #DATEFORMAT(NOW())#)# GTE 0>
					<CFSET Variables.ShowCat = "Yes">
				<CFELSE>
					<CFSET Variables.ShowCat = "No">
				</CFIF>
			</CFIF>
		
			<CFIF Variables.ShowCat EQ "Yes">
				<tr>
					<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
					<td width="231">
						<div class="menuFloatText">
							<A HREF="../app/doc_list.cfm?Commit=NPSW&CatID=#ListNPSW.CatID#">#TRIM(ListNPSW.Title)#</A>
						</div>
					</td>
				</tr>
			</CFIF>
		</CFOUTPUT>
	</table>
</div>
--->
<div id="whatsnew" class="menuFloat">
	<table width="390" cellpadding="0" cellspacing="0"  border="0">
		<tr>
			<td colspan="2">
				<div class="menuFloatTitle">What's New</div>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<div class="menuFloatText"><strong><a href="../../ver1_bubbles/app/whatsnew.cfm">News & Messages</a></strong></div>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<div class="menuFloatText"><strong>New Documents</strong></div>
			</td>
		</tr>
		<cfoutput query="ListNewDocs" group="Name">
		<!--- Note that this limits the what's new display to only one item per committee --->
			<tr>
				<td colspan="2">
					<div class="menuFloatText">#Trim(ListNewDocs.Name)#</div>
				</td>
			</tr>
			<tr>
				<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
				<td width="231">
					<div class="menuFloatText">
						<cfif ListNewDocs.FileType EQ "Link">
							<a href="#Trim(ListNewDocs.SystemName)#" target="_new">#Trim(ListNewDocs.Title)#</a>
						<cfelse>
							<a href="#Trim(WebHost)#/commits/#Trim(ListNewDocs.Dir_Params)#/docs/#Trim(ListNewDocs.SystemName)#">#Trim(ListNewDocs.Title)#</a>
						</cfif>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="menuFloatText">&nbsp;</div>
				</td>
			</tr>
		</cfoutput>
	</table>
</div>
<cfset DivFoo = "whatsnew">
<cfif DivIDs EQ "">
	<cfset DivIDs = "'#DivFoo#','','hide'">
<cfelse>
	<cfset DivIDs = DivIDs & ",'#DivFoo#','','hide'">
</cfif>
<div id="regional" class="menuFloat">
	<table width="390" cellpadding="0" cellspacing="0"  border="0">
		<tr>
			<td colspan="2">
				<div class="menuFloatTitle">Other Regional Councils</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://afc.gc.ca">Alberta Federal Council</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://mfc-cfm.gc.ca">Manitoba Federal Council</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://publiservice.gc.ca/committees/nbfc-cfnb/menu_e.html">New Brunswick Federal Council</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://publiservice.gc.ca/committees/nlfc/html/nfrc.htm">Newfoundland and Labrador Federal Council</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.nsfederalcouncil.gc.ca/">Nova Scotia Federal Council</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.tbs-sct.gc.ca/frc-cfr/bkgrd-contexte/nunavut/nunavut_e.asp">Nunavut Federal Council</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://ofc.gc.ca/english/ofc-e.cfm">Ontario Federal Council</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.peifc-cfipe.gc.ca ">Prince Edward Island Federal Regional Council</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://publiservice.gc.ca/services/gfrq/cfq/">Quebec Federal Council</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://publiservice.gc.ca/committees/scsfo-cffs/menu_e.html">Saskatchewan Council of Senior Federal Officials</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.tbs-sct.gc.ca/frc-cfr/menu_e.asp">Treasury Board of Canada Secretaritat </a>
				</div>
			</td>
		</tr>
	</table>
</div>
<cfset DivFoo = "regional">
<cfif DivIDs EQ "">
	<cfset DivIDs = "'#DivFoo#','','hide'">
<cfelse>
	<cfset DivIDs = DivIDs & ",'#DivFoo#','','hide'">
</cfif>
<div id="government" class="menuFloat">
	<table width="390" cellpadding="0" cellspacing="0"  border="0">
		<tr>
			<td colspan="2">
				<div class="menuFloatTitle">Other Government Sites</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="../../ver1_bubbles/pages/govcan.cfm">Government of Canada Resources</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="../../ver1_bubbles/pages/govbc.cfm">Government of BC Resources</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.civicnet.gov.bc.ca/">BC Municipal Resources</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.gov.yk.ca">Yukon Government Resources</a>
				</div>
			</td>
		</tr>
	</table>
</div>
<cfset DivFoo = "government">
<cfif DivIDs EQ "">
	<cfset DivIDs = "'#DivFoo#','','hide'">
<cfelse>
	<cfset DivIDs = DivIDs & ",'#DivFoo#','','hide'">
</cfif>
<div id="references" class="menuFloat">
	<table width="390" cellpadding="0" cellspacing="0"  border="0">
		<tr>
			<td colspan="2">
				<div class="menuFloatTitle">References</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.aircanada.ca">Air Canada</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://gtmo.gc.ca/card_main.shtml">American Express Government Travel Card</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.bcferries.bc.ca">BC Ferries</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.harbour-air.com/">Harbour Air Seaplanes</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.helijet.com/">Helijet</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.hcrd.gts.gc.ca/ehcd_e.htm">Hotel and Car Rental Directory</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://gtmo.gc.ca">Government Travel Service</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.translink.bc.ca">Translink</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.tbs-sct.gc.ca/travel/travel_e.html">Treasury Board Travel Directive</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.yvr.ca/">Vancouver International Airport</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.bced.gov.bc.ca/vidcon/welcome.htm#BCSites">Video Conferencing in BC</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="../../ver1_bubbles/pages/virtual.cfm">Virtual Learning Center</a>
				</div>
			</td>
		</tr>
		<tr>
			<td width="13" valign="top"><img src="../images/bullet.gif" width="13" height="12"></td>
			<td width="231">
				<div class="menuFloatText">
					<a href="http://www.westjet.com">WestJet</a>
				</div>
			</td>
		</tr>
	</table>
</div>
<cfset DivFoo = "references">
<cfif DivIDs EQ "">
	<cfset DivIDs = "'#DivFoo#','','hide'">
<cfelse>
	<cfset DivIDs = DivIDs & ",'#DivFoo#','','hide'">
</cfif>

<script language="JavaScript">
function HideAllLayers() {
	MM_showHideLayers(<cfoutput>#DivIDs#</cfoutput>);
}
</script>