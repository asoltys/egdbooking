<cfif findNoCase('lang=fra', cgi.http_referer)>
  <cfset url_string = replaceNoCase(cgi.http_referer, 'lang=fra', 'lang=eng') />
<cfelse>
  <cfset url_string = replaceNoCase(cgi.http_referer, 'lang=eng', 'lang=fra') />
</cfif>

<cflocation url="#url_string#" addtoken="no" />
