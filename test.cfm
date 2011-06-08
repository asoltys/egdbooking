<cfscript>
pw = "testpass";

jbClass = ArrayNew(1);
jbClass[1] = "#FileDir#lib/jBCrypt-0.3";
javaloader = createObject('component','egdbooking.lib.javaloader.JavaLoader');
javaloader.init(jbClass);

bcrypt = javaloader.create("BCrypt");
startts = getTickCount();
hashed = bcrypt.hashpw(pw, bcrypt.gensalt());
writeoutput("created pw " & hashed & " in " & getTickCount()  - startts & " ms 
");

startts = getTickCount();
match = bcrypt.checkpw(pw, hashed);
writeoutput("checked pw match (#match#) in " & getTickCount()  - startts & " ms 
");


startts = getTickCount();
hashed = bcrypt.hashpw(pw, bcrypt.gensalt(12));
writeoutput("created pw " & hashed & " in " & getTickCount()  - startts & " ms 
");

startts = getTickCount();
match = bcrypt.checkpw(pw, hashed);
writeoutput("checked pw match (#match#) in " & getTickCount()  - startts & " ms 
");
</cfscript>
<cfdump var="#jbClass#"></cfdump>
