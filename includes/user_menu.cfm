<div id="menu1">
	<cfif lang EQ "eng">
	<cffile action="read" file="#FileDir#intro-eng.txt" variable="intromsg">
	<cfif #Trim(intromsg)# EQ "">
	<cfelse>
		<cfinclude template="#RootDir#includes/helperFunctions.cfm" />
		<div class="notice">
		<h2>Notice</h2>
		<cfoutput>#FormatParagraph(intromsg)#</cfoutput>
		</div>
	</cfif>
	<cfelse>
	<cffile action="read" file="#FileDir#intro-fra.txt" variable="intromsg">
	<cfif #Trim(intromsg)# EQ "">
	<cfelse>
		<cfinclude template="#RootDir#includes/helperFunctions.cfm" />
		<div class="notice">
		<h2>Avis</h2>
		<cfoutput>#FormatParagraph(intromsg)#</cfoutput>
		</div>
	</cfif>
	</cfif>

	<CFSET variables.urltoken = "lang=#lang#">
	<CFIF IsDefined('variables.startDate')>
		<CFSET variables.urltoken = variables.urltoken & "&startDate=#DateFormat(variables.startDate, 'mm/dd/yyyy')#">
	<CFELSEIF IsDefined('url.startDate')>
		<CFSET variables.urltoken = variables.urltoken & "&startDate=#DateFormat(url.startDate, 'mm/dd/yyyy')#">
	</CFIF>
	<CFIF IsDefined('variables.endDate')>
		<CFSET variables.urltoken = variables.urltoken & "&endDate=#DateFormat(variables.endDate, 'mm/dd/yyyy')#">
	<CFELSEIF IsDefined('url.endDate')>
		<CFSET variables.urltoken = variables.urltoken & "&endDate=#DateFormat(url.endDate, 'mm/dd/yyyy')#">
	</CFIF>
	<CFIF IsDefined('variables.show')>
		<CFSET variables.urltoken = variables.urltoken & "&show=#variables.show#">
	<CFELSEIF IsDefined('url.show')>
		<CFSET variables.urltoken = variables.urltoken & "&show=#url.show#">
	</CFIF>
</div>

<br />
