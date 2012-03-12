<cfif IsDefined('form.anonymous')>
	<cfset Form.Anonymous = 1 />
<cfelse>
	<cfset Form.Anonymous = 0  />
</cfif>

<cfset return_url = "#RootDir#reserve-book/naviremod-vesseledit.cfm?lang=#lang#&VNID=#VNID#" />
<cfinclude template="#RootDir#reserve-book/includes/vesselValidation.cfm" />

<cfif isDefined('form.VNID')>

	<cfquery name="editVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE Vessels
		SET
			name = <cfqueryparam value="#trim(form.name)#" cfsqltype="cf_sql_varchar" />,
			length = <cfqueryparam value="#trim(form.length)#" cfsqltype="cf_sql_float" />,
			width = <cfqueryparam value="#trim(form.width)#" cfsqltype="cf_sql_float" />,
			blocksetuptime = <cfqueryparam value="#trim(form.blocksetuptime)#" cfsqltype="cf_sql_float" />,
			blockteardowntime = <cfqueryparam value="#trim(form.blockteardowntime)#" cfsqltype="cf_sql_float" />,
			LloydsID = <cfqueryparam value="#trim(form.LloydsID)#" cfsqltype="cf_sql_varchar" />,
			Tonnage = <cfqueryparam value="#trim(form.tonnage)#" cfsqltype="cf_sql_float" />,
			Anonymous = <cfqueryparam value="#(Form.Anonymous)#" cfsqltype="cf_sql_bit" />
		WHERE VNID = <cfqueryparam value="#form.VNID#" cfsqltype="cf_sql_integer" />
		AND deleted = 0
	</cfquery>


	<cflock scope="session" throwontimeout="no" timeout="30" type="READONLY">
		<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT	firstname + ' ' + lastname AS UserName, Email
			FROM	Users
			WHERE	UID = <cfqueryparam value="#session.UID#" cfsqltype="cf_sql_integer" />
		</cfquery>
	</cflock>

	<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	vessels.name AS VesselName, companies.name AS CompanyName
		FROM	Vessels INNER JOIN Companies ON Vessels.CID = Companies.CID
		WHERE	VNID = <cfqueryparam value="#form.VNID#" cfsqltype="cf_sql_integer" />
	</cfquery>

	<cfoutput>
	<cfif ServerType EQ "Development">
<cfset Variables.AdminEmail = DevEmail />
</cfif>
		<cfmail to="#Variables.AdminEmail#" from="#getUser.email#" subject="Vessel Edited" type="html">
	<p>#getUser.userName# of #getVessel.companyName# has edited the details for #getVessel.VesselName#.  Please check that the new vessel information is correct.</p>
		</cfmail>
	</cfoutput>

  <cfset session.vessel_edit_success = true />

</cfif>

<!--- Clear Form Structure --->
<cfset StructDelete(Session, "Form_Structure")>
<cflocation addtoken="no" url="#RootDir#reserve-book/detail-navire-vessel.cfm?lang=#lang#&VNID=#form.VNID#&CID=#url.CID#">
