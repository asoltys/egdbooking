<cfquery name="vessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#" cachedwithin="#CreateTimeSpan(2,0,0,0)#">
  SELECT DISTINCT Vessels.VNID, Vessels.Name
  FROM Vessels 
  WHERE Vessels.CID = <cfqueryparam value="#session.CID#" cfsqltype="cf_sql_integer" /> 
  AND Vessels.Deleted = 0
  ORDER BY Vessels.Name
</cfquery>

<cfoutput>
  <cfif vessels.recordCount EQ 0>
    <p>#language.None#</p>
  <cfelse>
    <form action="#RootDir#reserve-book/detail-navire-vessel.cfm" method="get">
      <fieldset>
        <legend>#language.vesselSelection#</legend>
        <label for="VNID">#language.vessels#</label>
        <select id="VNID" name="VNID">
          <cfloop query="vessels">
            <option value="#vessels.VNID#">#vessels.name#</option>
          </cfloop>
        </select>
        <input type="hidden" name="lang" value="#lang#" />
        <input type="submit" value="#language.view#" />
      </fieldset>
    </form>
  </cfif>
</cfoutput>
