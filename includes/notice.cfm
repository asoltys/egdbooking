<cfoutput>

<cfquery name="display_notice"  datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
  SELECT notice_acknowledged FROM users 
  WHERE UID = <cfqueryparam value="#session.uid#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfif display_notice.notice_acknowledged EQ 0>
  <cffile action="read" file="#FileDir#intro-#lang#.txt" variable="intromsg" />
  <div class="module-note">
    #intromsg#
    <a id="dismiss">#language.acknowledged#</a>
  </div>
  <div id="acknowledged" class="option4" style="display: none">#language.acknowledgement_received#</div>
</cfif>

</cfoutput>
