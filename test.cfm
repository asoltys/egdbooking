<cfscript>
pw = "testpass";

jbClass = ArrayNew(1);
jbClass[1] = expandPath("jBCrypt-0.3");
javaloader = createObject('component','javaloader.javaloader');
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