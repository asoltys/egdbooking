<cffile action="write" output="#datatowrite#" file="#FileDir#intro-eng.txt">
<cffile action="write" output="#datatowritefr#" file="#FileDir#intro-fra.txt">

<cfquery datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
  UPDATE users SET notice_acknowledged = 0
</cfquery>

<cflocation url="menu.cfm">
