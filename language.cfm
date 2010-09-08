<cfif findNoCase('lang=fra', cgi.http_referer)>
  <cfset url_string = replaceNoCase(cgi.http_referer, 'lang=fra', 'lang=eng') />
<cfelseif findNoCase('lang=eng', cgi.http_referer)>
  <cfset url_string = replaceNoCase(cgi.http_referer, 'lang=eng', 'lang=fra') />
</cfif>

<cfif findNoCase('-fra', cgi.http_referer)>
  <cfset url_string = replaceNoCase(cgi.http_referer, '-fra', '-eng') />
<cfelseif findNoCase('-eng', cgi.http_referer)>
  <cfset url_string = replaceNoCase(cgi.http_referer, '-eng', '-fra') />
</cfif>

<cflocation url="#url_string#" addtoken="no" />
