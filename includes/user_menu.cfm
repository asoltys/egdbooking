<cfoutput>

<cfsavecontent variable="head">
  <style>
    a##dismiss { color: ##369; cursor: pointer; text-decoration: underline; }
  </style>
</cfsavecontent>
<cfhtmlhead text="#head#">

<div id="menu1">
  <cfquery name="display_notice"  datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
    SELECT notice_acknowledged FROM users 
    WHERE UID = <cfqueryparam value="#session.uid#" cfsqltype="cf_sql_integer" />
  </cfquery>

  <cfif display_notice.notice_acknowledged EQ 0>
    <cffile action="read" file="#FileDir#intro-#lang#.txt" variable="intromsg" />
    <div class="option4">
      <h2>Notice</h2>
      #intromsg#
      <a id="dismiss">#language.acknowledged#</a>
    </div>
    <div id="acknowledged" class="option4" style="display: none">#language.acknowledgement_received#</div>
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

</cfoutput>
