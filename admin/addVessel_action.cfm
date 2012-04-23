<cfset Variables.Errors = ArrayNew(1)>
<cfset Proceed_OK = "Yes">

<CFIF trim(form.name) eq ''>
	<cfoutput>#ArrayAppend(Variables.Errors, "Please enter a name for your vessel.")#</cfoutput>
	<cfset Proceed_OK = "No">
</CFIF>

<cfif trim(form.name) EQ "">
  <cfset ArrayAppend(Variables.Errors,language.nameError) />
	<cfset Proceed_OK = "No">
</cfif>

<cfif not isNumeric(trim(form.width))>
  <cfset ArrayAppend(Variables.Errors,language.widthError) />
	<cfset Proceed_OK = "No">
</cfif>

<cfif not isNumeric(trim(form.length))>
  <cfset ArrayAppend(Variables.Errors,language.lengthError) />
	<cfset Proceed_OK = "No">
</cfif>

<cfif not isNumeric(trim(form.blockSetupTime))>
  <cfset ArrayAppend(Variables.Errors,language.setupError) />
	<cfset Proceed_OK = "No">
</cfif>

<cfif not isNumeric(trim(form.BlockTearDownTime))>
  <cfset ArrayAppend(Variables.Errors,language.teardownError) />
	<cfset Proceed_OK = "No">
</cfif>

<cfif not isNumeric(trim(form.tonnage))>
  <cfset ArrayAppend(Variables.Errors,language.tonnageError) />
	<cfset Proceed_OK = "No">
</cfif>

<cfif Proceed_OK>

  <cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
    SELECT Name
    FROM Vessels
    WHERE Name = <cfqueryparam value="#trim(form.Name)#" cfsqltype="cf_sql_varchar" />
    AND Deleted = 0
    AND CID = <cfqueryparam value="#form.CID#" cfsqltype="cf_sql_integer" />
  </cfquery>

  <cfif getVessel.recordcount EQ 0> 

    <cfquery name="insertNewVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
      INSERT INTO Vessels
      (
        Name,
        CID,
        length,
        width,
        blocksetuptime,
        blockteardowntime,
        lloydsid,
        tonnage,
        Anonymous,
        Deleted
      )
      
      VALUES
      (
        <cfqueryparam value="#trim(form.Name)#" cfsqltype="cf_sql_varchar" />,
        <cfqueryparam value="#trim(form.CID)#" cfsqltype="cf_sql_integer" />,
        <cfqueryparam value="#trim(form.length)#" cfsqltype="cf_sql_float" />,
        <cfqueryparam value="#trim(form.width)#" cfsqltype="cf_sql_float" />,
        <cfqueryparam value="#trim(form.blocksetuptime)#" cfsqltype="cf_sql_float" />,
        <cfqueryparam value="#trim(form.blockteardowntime)#" cfsqltype="cf_sql_float" />,
        <cfqueryparam value="#trim(form.lloydsID)#" cfsqltype="cf_sql_varchar" />,
        <cfqueryparam value="#trim(form.tonnage)#" cfsqltype="cf_sql_float" />,
        <cfqueryparam value="#Form.Anonymous#" cfsqltype="cf_sql_bit" />,
        0
      )
    </cfquery>

  </cfif>


  <cfset Session.Success.Breadcrumb = "Add New Vessel">
  <cfset Session.Success.Title = "Add New Vessel">
  <cfset Session.Success.Message = "<strong>#form.Name#</strong> has been created.">
  <cfset Session.Success.Back = "Back to Admin Functions Home">
  <cfset Session.Success.Link = "#RootDir#admin/menu.cfm?lang=#lang#">
  <cflocation addtoken="no" url="#RootDir#comm/succes.cfm?lang=#lang#">
<cfelse>
  <cfinclude template="#RootDir#includes/build_return_struct.cfm">
  <cfset Session.Return_Structure.Errors = Variables.Errors>
  <cflocation url="addVessel.cfm" addtoken="no">
</cfif>
