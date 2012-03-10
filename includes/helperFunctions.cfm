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

<cffunction name="viewable">
  <cfargument name="query" />
  <cfargument name="VNID" />
  <cfreturn listContains(valueList(query.VNID), arguments.VNID) />
</cffunction>


<cffunction name="bookingsTable" output="true">
  <cfargument name="query">
  <cfargument name="counts">

  <cfif query.recordCount GE 1>
    <table class="basic">
      <thead>
        <tr>
          <th scope="col">#language.booking#</th>
          <th scope="col">#language.startdate#</th>
          <th scope="col">#language.enddate#</th>
          <th scope="col">#language.status#</th>
        </tr>
      </thead>
      <tbody>
        <cfloop query="query">
          <tr>
            <td>
              <a href="#RootDir#comm/detail-res-book.cfm?lang=#lang#&amp;BRID=#BRID#" title="#language.booking# ###BRID#">
                <span class="navaid">#language.booking# ###BRID#:</span>
                <cfif #EndHighlight# GTE PacificNow>*</cfif>
                #Name#
              </a>
            </td>
            <td>#myDateFormat(CreateODBCDate(startDate), request.datemask)#</td>
            <td>#myDateFormat(endDate, request.datemask)#</td>
            <td>
              <cfif status EQ "P" or status EQ "PT"><span class="pending">#language.pending#</span>
              <cfelseif status EQ "C"><span class="confirmed">#language.confirmed#</span>
              <cfelseif status EQ "T"><span class="tentative">#language.tentative#</span>
              <cfelseif status EQ "PC"><span class="pending">#language.confirming#</span>
              <cfelseif status EQ "PX"><span class="cancelled">#language.pending_cancelling#</span>
              </cfif>
            </td>
          </tr>
        </cfloop>
      </tbody>
    </table>
    <p class="total">
      Total:&nbsp;&nbsp;
      <span class="pending">#language.pending# - #counts.pending#</span>
      <span class="tentative">#language.tentative# - #counts.tentative#</span>
      <span class="confirmed">#language.confirmed# - #counts.confirmed#</span>
      <span class="cancelled">#language.pending_cancelling# - #counts.cancelled#</span>
    </p>
  <cfelse>
    #language.None#.
  </cfif>
</cffunction>
