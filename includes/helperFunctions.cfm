<cfscript>
			function FormatParagraph(txt) {
				var temp = ReReplace(Trim(txt), '\r\n\r\n', '</p><p>', 'all');
				temp = '<p>' & ReReplace(temp, '\r\n', '<br />', 'all') & '</p>';
				temp=Replace(temp, '</p>', '</p>#Chr(10)##Chr(13)#', 'all');
				temp=Replace(temp, '<br />', '<br />#Chr(10)##Chr(13)#', 'all');
				return temp;
			}
</cfscript>

<cffunction name="error">
  <cfargument name="field" type="string" />
  <cfif structKeyExists(session['errors'], field)>
    <cfreturn "<div class=""error"">#session['errors'][field]#</div>" />
  </cfif>
</cffunction>

<cffunction name="myDateFormat">
  <cfargument name="date" />
  <cfargument name="mask" />

  <cfset var modifiedDate = lsDateFormat(date, mask) />

  <cfif getLocale() eq "French (Canadian)" and left(modifiedDate, 2) eq "1 ">
    <cfreturn "1<sup>er</sup> " & Right(modifiedDate, Len(modifiedDate) - 1) />
  </cfif>

  <cfreturn modifiedDate />
</cffunction>
