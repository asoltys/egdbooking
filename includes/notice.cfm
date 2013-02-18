<cfoutput>

<cfquery name="display_notice"  datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
  SELECT notice_acknowledged FROM users 
  WHERE UID = <cfqueryparam value="#session.uid#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfif display_notice.notice_acknowledged EQ 0>
  <cffile action="read" file="#FileDir#intro-#lang#.txt" variable="intromsg" />
  <div class="module-note" style="margin-left: 10px; margin-right: 10px;">
    #intromsg#
    <a id="dismiss">#language.acknowledged#</a>
  </div>
  <div id="acknowledged" class="module-note" style="display: none; margin-left: 10px; margin-right: 10px;">#language.acknowledgement_received#</div>
</cfif>

</cfoutput>
