<!--- <cfset Variables.Refer = CGI.HTTP_REFERER>

<cfif findnocase("-eng",CGI.HTTP_REFERER)>
	<cflock timeout="60" throwontimeout="no" type="exclusive" scope="session"> 
		<cfset session.lang = "fra">
	</cflock>
	<cflocation url="#Replace("#Variable.refer#", "-eng", "-fra")#" addtoken="no"> <!--- This needs to be changed to -fra when french files are provided --->
<cfelseif findnocase("-fra",CGI.HTTP_REFERER)>
	<cflock timeout="60" throwontimeout="no" type="exclusive" scope="session"> 
		<cfset session.lang = "eng">
	</cflock>
	<cflocation url="#Replace("#Variable.refer#", "-fra", "-eng")#" addtoken="no">
</cfif>

<cflock timeout="60" throwontimeout="no" type="exclusive" scope="session"> 
	<cfif session.lang eq "eng">
		<cfset session.lang = "fra">
	<cfelseif session.lang EQ "fra">
		<cfset session.lang = "eng">
	</cfif>
	<cfoutput>#Variables.Refer#</cfoutput>
	<cflocation url="#Variables.Refer#" addtoken="no">
</cflock> --->


<!--- <cfif findnocase("lang=eng",Variables.refer)>
	<cflocation url="#ReplaceNoCase("#Variables.refer#", "lang=eng", "lang=fra")#" addtoken="no">
<cfelseif findnocase("lang=fra",Variables.refer)>
	<cflocation url="#ReplaceNoCase("#Variables.refer#", "lang=fra", "lang=eng")#" addtoken="no">
</cfif>   --->

<cfset Variables.refer="#CGI.HTTP_REFERER#">

<cfif findnocase("-eng",CGI.HTTP_REFERER)>
	<cflocation url="#ReplaceNoCase("#Variables.refer#", "-eng", "-fra")#" addtoken="no">
<cfelseif findnocase("-fra",CGI.HTTP_REFERER)>
	<cflocation url="#ReplaceNoCase("#Variables.refer#", "-fra", "-eng")#" addtoken="no">
</cfif>

<cfif findnocase("lang=eng",Variables.refer)>
	<cflocation url="#ReplaceNoCase("#Variables.refer#", "lang=eng", "lang=fra")#" addtoken="no">
<cfelseif findnocase("lang=fra",Variables.refer)>
	<cflocation url="#ReplaceNoCase("#Variables.refer#", "lang=fra", "lang=eng")#" addtoken="no">
</cfif>  
