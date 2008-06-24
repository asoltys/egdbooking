<cfif isDefined('form.vesselID')>

	<cfquery name="editVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		UPDATE Vessels
		SET
			name = '#trim(form.name)#',
			length = '#trim(form.length)#',
			width = '#trim(form.width)#',
			blocksetuptime = '#trim(form.blocksetuptime)#',
			blockteardowntime = '#trim(form.blockteardowntime)#',
			LloydsID = '#trim(form.LloydsID)#',			
			Tonnage = '#trim(form.tonnage)#',
			Anonymous = '#(Form.Anonymous)#'
		WHERE vesselID = #form.vesselID#
		AND deleted = 0
	</cfquery>


	<cflock scope="session" throwontimeout="no" timeout="30" type="READONLY">
		<cfquery name="getUser" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
			SELECT	firstname + ' ' + lastname AS UserName, Email
			FROM	Users
			WHERE	UserID = #session.userID#
		</cfquery>
	</cflock>
	
	<cfquery name="getVessel" datasource="#DSN#" username="#dbuser#" password="#dbpassword#">
		SELECT	vessels.name AS VesselName, companies.name AS CompanyName
		FROM	Vessels INNER JOIN Companies ON Vessels.COmpanyID = Companies.CompanyID
		WHERE	vesselID = #form.vesselID#
	</cfquery>
	
	<cfoutput>
		<cfmail to="#Variables.AdminEmail#" from="#getUser.email#" subject="Vessel Edited" type="html">
	<p>#getUser.userName# of #getVessel.companyName# has edited the details for #getVessel.VesselName#.  Please check that the new vessel information is correct.</p>
		</cfmail>
	</cfoutput>

</cfif>

<!--- Clear Form Structure --->
<cfset StructDelete(Session, "Form_Structure")>
<cflocation addtoken="no" url="#RootDir#reserve-book/getVesselDetail.cfm?lang=#lang#&vesselID=#form.vesselID#&CompanyID=#url.companyID#">