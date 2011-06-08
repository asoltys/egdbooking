<cfquery name="passConvert" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
	SELECT *
	FROM Users
</cfquery>

<cfscript>
jbClass = ArrayNew(1);
jbClass[1] = expandPath("jBCrypt-0.3");
javaloader = createObject('component','javaloader.javaloader');
javaloader.init(jbClass);
bcrypt = javaloader.create("BCrypt");
</cfscript>

<cfoutput>
	<cfloop query="passConvert">
		<cfscript>
		hashed = bcrypt.hashpw(trim(passConvert.password), bcrypt.gensalt());
		</cfscript>
		#passConvert.firstname# #passConvert.lastname# #passConvert.password# <b>#hashed#</b><br />
	</cfloop>
</cfoutput>

