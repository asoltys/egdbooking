<cfapplication name="PCSFO"
               sessionmanagement="Yes">

<!--- Set a global variable for the datasource and path paths.
	For Extranet production server:
		<CFSET WebHost = "http://pcsfo.gc.ca">
		<CFSET RootDir = "/pcsfo_root/">
		<CFSET ImageRootDir = "/">
 --->
<CFSET Foobar = SetLocale("English (Canadian)")>
<CFSET DSN = "pcsfo">
<CFSET WebHost = "http://monster/Lois/ver1_bubbles">
<CFSET RootDir = "/Lois/ver1_bubbles/">
<CFSET ImageRootDir = "/Lois/ver1_bubbles/images">
<!--- <CFSET Event_Reg_Sender = "Fe.DeCastro@pwgsc.gc.ca"> --->
<CFSET Event_Reg_Sender = "Carmen.Lawson@pwgsc.gc.ca">

<!--- The variables are used in PCSFO Document Collection Update and Refresh programs in utils.
Please note that the variable contents for monster and production servers are different.
	For Extranet production server:
		<CFSET CollectPath = "d:\web\pcsfo_v2\commits">
		<cfset URLPath ="http://pcsfo.gc.ca/commits">
		<cfset webserver = "Extranet Production">
--->
<CFSET CollectPath = "d:\web\pcsfo_v2\commits">
<cfset CollectName = "pcsfo">
<cfset URLPath ="http://monster/pcsfo_v2/commits">
<cfset webserver = "Monster">

<!--- These session variables are used in Home page for dynamic/random leaf graphics images.
For Extranet production server:
	<CFSET session.HomePath = "D:\web\PCSFO_V2\">
	<CFSET session.imagePath = "D:\web\PCSFO_V2\images\leaf\">
--->
<CFLOCK TIMEOUT="60" THROWONTIMEOUT="No" TYPE="EXCLUSIVE" SCOPE="SESSION">
	<CFSET session.HomePath = "D:\web\PCSFO_V2\">
	<CFSET session.imagePath = "D:\web\PCSFO_V2\images\leaf\">
</CFLOCK>
