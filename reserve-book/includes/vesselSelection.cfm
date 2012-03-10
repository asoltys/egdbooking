<cfquery name="vessels" datasource="#DSN#" username="#dbuser#" password="#dbpassword#" cachedwithin="#CreateTimeSpan(2,0,0,0)#">
  SELECT DISTINCT Vessels.VNID, Vessels.Name
  FROM Vessels 
  WHERE Vessels.CID = <cfqueryparam value="#session.CID#" cfsqltype="cf_sql_integer" /> 
  AND Vessels.Deleted = 0
  ORDER BY Vessels.Name
</cfquery>

<cfoutput>
  <h2>#language.Vessel#s</h2>

  <cfif vessels.recordCount EQ 0>
    <p>#language.None#</p>
  <cfelse>
    <form action="#RootDir#reserve-book/detail-navire-vessel.cfm?lang=#lang#" method="get">
      <fieldset>
        <legend>#language.vesselSelection#</legend>
        <select name="VNID">
          <cfloop query="vessels">
            <option value="#vessels.VNID#">#vessels.name#</option>
          </cfloop>
        </select>
        <input type="submit" value="#language.view#" />
      </fieldset>
    </form>
  </cfif>
</cfoutput>
