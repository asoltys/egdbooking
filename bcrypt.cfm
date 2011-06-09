<cfsetting requestTimeOut="15000" />
<cfquery name="passConvert" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT *
	FROM Users
  WHERE password NOT LIKE '$2A$10%'
</cfquery>

<cfscript>
jbClass = ArrayNew(1);
jbClass[1] = "#FileDir#lib/jBCrypt-0.3";
javaloader = createObject('component','egdbooking.lib.javaloader.JavaLoader');
javaloader.init(jbClass);
bcrypt = javaloader.create("BCrypt");
</cfscript>

<cfoutput>
	<cfloop query="passConvert">
		<cfscript>
		hashed = bcrypt.hashpw(trim(passConvert.password), bcrypt.gensalt());
		</cfscript>
		#passConvert.firstname# #passConvert.lastname# #passConvert.password# <b>#hashed#</b><br />
    <cfquery datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
      UPDATE Users SET Password = '#hashed#' WHERE UID = #passConvert.UID#
    </cfquery>
    <cfflush>
	</cfloop>
</cfoutput>

