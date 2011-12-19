<cfsetting requesttimeout = "10000" />
<cfquery name="bookings" datasource="egdbooking" username="#dbuser#" password="#dbpassword#">
  SELECT * FROM Bookings
</cfquery>

<cfloop query="bookings">
  <cfquery name="fees" datasource="egdbooking" username="#dbuser#" password="#dbpassword#">
    SELECT * FROM TariffForms 
    WHERE BRID = #bookings.BRID#
  </cfquery>

  <cfloop query="fees">
    <cfloop list="#fees.columnlist#" index="col">
      <cfif evaluate("fees.#col#") eq 1>
        <cfoutput>Booking #bookings.brid# has #col# checked<br /></cfoutput>
      </cfif>
      <cfflush />
    </cfloop>
  </cfloop>
</cfloop> 

