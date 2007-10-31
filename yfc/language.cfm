<!--- <cfset Variables.Refer = CGI.HTTP_REFERER>

<cfif findnocase("-e",CGI.HTTP_REFERER)>
	<cflock timeout="60" throwontimeout="no" type="exclusive" scope="session"> 
		<cfset session.lang = "f">
	</cflock>
	<cflocation url="#Replace("#Variable.refer#", "-e", "-f")#" addtoken="no"> <!--- This needs to be changed to -f when french files are provided --->
<cfelseif findnocase("-f",CGI.HTTP_REFERER)>
	<cflock timeout="60" throwontimeout="no" type="exclusive" scope="session"> 
		<cfset session.lang = "e">
	</cflock>
	<cflocation url="#Replace("#Variable.refer#", "-f", "-e")#" addtoken="no">
</cfif>

<cflock timeout="60" throwontimeout="no" type="exclusive" scope="session"> 
	<cfif session.lang EQ "e">
		<cfset session.lang = "f">
	<cfelseif session.lang EQ "f">
		<cfset session.lang = "e">
	</cfif>
	<cfoutput>#Variables.Refer#</cfoutput>
	<cflocation url="#Variables.Refer#" addtoken="no">
</cflock> --->


<!--- <cfif findnocase("lang=e",Variables.refer)>
	<cflocation url="#ReplaceNoCase("#Variables.refer#", "lang=e", "lang=f")#" addtoken="no">
<cfelseif findnocase("lang=f",Variables.refer)>
	<cflocation url="#ReplaceNoCase("#Variables.refer#", "lang=f", "lang=e")#" addtoken="no">
</cfif>   --->

<cfset Variables.refer="#CGI.HTTP_REFERER#">
<CFOUTPUT>#variables.refer#</CFOUTPUT>

<cfif findnocase("-e",CGI.HTTP_REFERER)>
	<cflocation url="#ReplaceNoCase("#Variables.refer#", "-e", "-f")#" addtoken="no">
<cfelseif findnocase("-f",CGI.HTTP_REFERER)>
	<cflocation url="#ReplaceNoCase("#Variables.refer#", "-f", "-e")#" addtoken="no">
</cfif>

<cfif findnocase("lang=e",Variables.refer)>
	<cflocation url="#ReplaceNoCase("#Variables.refer#", "lang=e", "lang=f")#" addtoken="no">
<cfelseif findnocase("lang=f",Variables.refer)>
	<cflocation url="#ReplaceNoCase("#Variables.refer#", "lang=f", "lang=e")#" addtoken="no">
</cfif>